package com.ski.piq.config;


import com.ski.piq.auth.handler.CustomAccessDeniedHandler;
import com.ski.piq.auth.handler.CustomAuthenticationEntryPoint;
import com.ski.piq.auth.jwt.filter.JwtAuthenticationFilter;
import com.ski.piq.auth.jwt.util.JwtUtil;
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

    };

    private static final String[] STUDENT_ROUTES = {

    };

    private static final String[] INSTRUCTOR_ROUTES = {

    };

    private static final String[] OWNER_ROUTES = {

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