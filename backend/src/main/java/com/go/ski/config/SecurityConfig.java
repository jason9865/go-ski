package com.go.ski.config;


import com.go.ski.auth.handler.CustomAccessDeniedHandler;
import com.go.ski.auth.handler.CustomAuthenticationEntryPoint;
import com.go.ski.auth.jwt.filter.JwtAuthenticationFilter;
import com.go.ski.auth.jwt.util.JwtUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;

import java.util.Arrays;
import java.util.Collections;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final JwtUtil jwtUtil;
    private final CustomAccessDeniedHandler accessDeniedHandler;
    private final CustomAuthenticationEntryPoint authenticationEntryPoint;

    private static final String[] ALL_USER_ROUTES = {
            "/api/v1/user/signout", "/api/v1/user/resign",
            "/api/v1/notification/token","/api/v1/notification","/api/v1/notification/read-all",
            "/api/v1/notification/delete/*","/api/v1/notification/dm","/api/v1/notification/setting",
            "/api/v1/team/*"
    };

    private static final String[] STUDENT_ROUTES = {
            "/api/v1/user/update/user", "/api/v1/user/profile/user",
            "/api/v1/lesson/reserve/novice/*", "/api/v1/lesson/reserve/advanced", "/api/v1/lesson/list/user",
            "/api/v1/lesson/feedback/*","/api/v1/lesson/review/tags","/api/v1/lesson/review/create",
            "/api/v1/lesson/review/*"
    };

    private static final String[] INSTRUCTOR_ROUTES = {
            "/api/v1/user/update/inst", "/api/v1/user/profile/inst",
            "/api/v1/lesson/list/instructor",
            "/api/v1/schedule/mine", "/api/v1/schedule/**",
            "/api/v1/lesson/review/list","/api/v1/lesson/review/list/*",
            "/api/v1/notification/invite","/api/v1/notification/accept-invite",
            "/api/v1/team/member/*","/api/v1/team/list/inst"
    };

    private static final String[] OWNER_ROUTES = {
            "/api/v1/user/update/user", "/api/v1/user/profile/user",
            "/api/v1/lesson/list/head/*",
            "/api/v1/schedule/**",
            "/api/v1/notification/invite",
            "/api/v1/team/create","/api/v1/team/update/*","/api/v1/team/member/*","/api/v1/team/list/owner",
            "/api/v1/team/update/member","/api/v1/team/delete/*"
    };

    // 특정 HTTP 요청에 대한 웹 기반 보안 구성
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)
                .cors(corsConfigurer -> corsConfigurer.configurationSource(corsConfigurationSource()))
                .addFilterBefore(new JwtAuthenticationFilter(jwtUtil), UsernamePasswordAuthenticationFilter.class)
                .httpBasic(AbstractHttpConfigurer::disable)
                .formLogin(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests((authorize) -> authorize
                        .requestMatchers(STUDENT_ROUTES).hasAuthority("STUDENT")
                        .requestMatchers(INSTRUCTOR_ROUTES).hasAuthority("INSTRUCTOR")
                        .requestMatchers(OWNER_ROUTES).hasAuthority("OWNER")
                        .requestMatchers(ALL_USER_ROUTES).authenticated()
                        .anyRequest().permitAll())
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .exceptionHandling((exceptionHandling) -> exceptionHandling
                        .authenticationEntryPoint(authenticationEntryPoint)
                        .accessDeniedHandler(accessDeniedHandler));
        return http.build();
    }

    // ⭐️ CORS 설정
    CorsConfigurationSource corsConfigurationSource() {
        return request -> {
            CorsConfiguration config = new CorsConfiguration();
            config.setAllowedHeaders(Collections.singletonList("*"));
            config.setAllowedMethods(Collections.singletonList("*"));
            config.setAllowedOriginPatterns(Arrays.asList("https://k10a604.p.ssafy.io", "http://localhost:3000", "https://online-pay.kakao.com"));
            config.setAllowCredentials(true);
            config.addExposedHeader("accessToken");
            config.addExposedHeader("refreshToken");
            return config;
        };
    }
}