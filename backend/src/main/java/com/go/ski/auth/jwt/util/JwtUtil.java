package com.go.ski.auth.jwt.util;


import com.go.ski.redis.dto.LoginTokenDto;
import com.go.ski.redis.repository.LoginTokenRepository;
import com.go.ski.user.core.model.User;
import com.go.ski.user.core.repository.UserRepository;
import com.go.ski.user.support.vo.Role;
import io.jsonwebtoken.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class JwtUtil {

    private final LoginTokenRepository loginTokenRepository;
    private final UserRepository userRepository;
    @Value("${jwt.access.expiration}")
    private long accessExpiration;
    @Value("${jwt.access.secret_key}")
    private String accessSecretKey;
    @Value("${jwt.refresh.expiration}")
    private long refreshExpiration;
    @Value("${jwt.refresh.secret_key}")
    private String refreshSecretKey;

    public String createToken(int userId, Role role, String type) {
        long expiration = type.equals("access") ? accessExpiration : refreshExpiration;
        String secretKey = type.equals("access") ? accessSecretKey : refreshSecretKey;

        Claims claims = Jwts.claims();
        claims.setSubject(String.valueOf(userId));
        claims.put("role", role);
        claims.put("type", type);

        return Jwts.builder()
                .setClaims(claims) // 만들어 놓은 claim을 넣는 것
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + expiration))
                .signWith(SignatureAlgorithm.HS256, secretKey)
                .compact();
    }

    public String resolveToken(HttpServletRequest request) {
        return request.getHeader(HttpHeaders.AUTHORIZATION);
    }

    public void saveToken(String refreshToken, String accessToken) {
        LoginTokenDto loginTokenDto = new LoginTokenDto(refreshToken, accessToken, refreshExpiration);
        loginTokenRepository.save(loginTokenDto);
    }

    public void deleteToken(String id) {
        loginTokenRepository.deleteById(id);
    }

    public UsernamePasswordAuthenticationToken getAuthentication(HttpServletRequest request, HttpServletResponse response, String token) {
        token = token.split(" ")[1];

        try {
            String type = request.getHeader("accessToken") == null ? "access" : "refresh";

            Claims claims = validateToken(token, type);
            // claims 검증
            String subject = claims.getSubject();
            String role = claims.get("role", String.class);
            // 만료 시간 검증
            Date expiration = claims.getExpiration();
            if (expiration.before(new Date())) {
                log.info("토큰이 만료되었습니다: {}", expiration);
                throw new Exception();
            }

            // 레디스에서 검증
            if (type.equals("refresh")) {
                LoginTokenDto loginTokenDto = loginTokenRepository.findById(token).orElseThrow();
                String accessToken = request.getHeader("accessToken");
                accessToken = accessToken.split(" ")[1];

                if (!loginTokenDto.getAccessToken().equals(accessToken)) {
                    log.info("Redis 검증 실패");
                    throw new Exception();
                }

                // 리프레시가 유효하면 토큰 재발급해야함
                deleteToken(loginTokenDto.getId());
                String newAccessToken = createToken(Integer.parseInt(subject), Role.valueOf(role), "access");
                String newRefreshToken = createToken(Integer.parseInt(subject), Role.valueOf(role), "refresh");
                saveToken(newRefreshToken, newAccessToken);
                response.setHeader("accessToken", newAccessToken);
                response.setHeader("refreshToken", newRefreshToken);
            }

            // DB에서 유저 객체를 가져와서 DELETE 확인
            User user = userRepository.findById(Integer.valueOf(subject)).orElseThrow();
            if (user.getExpiredDate() != null) {
                log.info("탈퇴한 유저: {}", user.getExpiredDate());
                throw new Exception();
            }

            request.setAttribute("user", user); // 이후 API에서 사용할 유저
            return new UsernamePasswordAuthenticationToken(subject, "", List.of(new SimpleGrantedAuthority(role)));
        } catch (Exception e) {
            log.info(e.getMessage());
            return null;
        }
    }

    private Claims validateToken(String token, String type) throws JwtException {
        // 타입에 맞는 키를 가져옴
        String secretKey = type.equals("access") ? accessSecretKey : refreshSecretKey;

        // 토큰을 파싱하고 클레임을 검증합니다.
        Jws<Claims> claimsJws = Jwts.parserBuilder()
                .setSigningKey(secretKey)
                .build()
                .parseClaimsJws(token);

        return claimsJws.getBody();
    }

}