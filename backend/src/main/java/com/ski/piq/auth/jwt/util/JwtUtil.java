//package com.ski.piq.auth.jwt.util;
//
//
//import io.jsonwebtoken.Claims;
//import io.jsonwebtoken.Jwts;
//import io.jsonwebtoken.SignatureAlgorithm;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.http.HttpHeaders;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.authority.SimpleGrantedAuthority;
//import org.springframework.stereotype.Component;
//
//import java.util.Date;
//import java.util.List;
//import java.util.UUID;
//
//@Slf4j
//@Component
//@RequiredArgsConstructor
//public class JwtUtil {
//
//    @Value("${jwt.access.expiration}")
//    private long accessExpiration;
//    @Value("${jwt.refresh.expiration}")
//    private long refreshExpiration;
//
//    public String createToken(String type) {
//        String secretKey = UUID.randomUUID().toString() + UUID.randomUUID().toString();
//        secretKey = secretKey.replace("-", "");
//        long expiration = type.equals("access") ? accessExpiration : refreshExpiration;
//
//        Claims claims = Jwts.claims();
//        claims.put("jti", UUID.randomUUID());
//
//        return Jwts.builder()
//                .setClaims(claims) // 만들어 놓은 claim을 넣는 것
//                .setIssuedAt(new Date(System.currentTimeMillis()))
//                .setExpiration(new Date(System.currentTimeMillis() + expiration))
//                .signWith(SignatureAlgorithm.HS256, secretKey)
//                .compact();
//    }
//
//    public String resolveToken(HttpServletRequest request) {
//        return request.getHeader(HttpHeaders.AUTHORIZATION);
//    }
//
//
//    public UsernamePasswordAuthenticationToken getAuthentication(HttpServletRequest request, HttpServletResponse response, String token) {
//        token = token.split(" ")[1];
//
//        if (loginTokenRepository.findById(token).isPresent()) {
//            LoginTokenDto loginTokenDto = loginTokenRepository.findById(token).get();
//
//            String accessToken = loginTokenDto.getAccessToken();
//            if (accessToken != null) {
//                // refreshToken으로 로그인하면 둘 다 재발급
//                loginTokenRepository.deleteById(token);
//
//                accessToken = createToken("access");
//                String refreshToken = createToken("refresh");
//                saveTokens(accessToken, refreshToken, loginTokenDto.getUserId());
//
//                response.setHeader("accessToken", accessToken);
//                response.setHeader("refreshToken", refreshToken);
//                request.setAttribute("refreshToken", refreshToken);
//            }
//
//            request.setAttribute("userId", loginTokenDto.getUserId());
//            log.info("{} 유저 인증 성공", request.getAttribute("userId"));
//
//            return new UsernamePasswordAuthenticationToken(loginTokenDto.getUserId(), "", List.of(new SimpleGrantedAuthority("USER")));
//        }
//
//        log.info("유저 인증 실패");
//        return null;
//    }
//
//}