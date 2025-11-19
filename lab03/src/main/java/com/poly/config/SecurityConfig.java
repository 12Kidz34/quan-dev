package com.poly.config;

import jakarta.servlet.http.HttpSession;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authorization.AuthorizationDecision;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.intercept.RequestAuthorizationContext;
import org.springframework.security.web.savedrequest.DefaultSavedRequest;
import org.springframework.security.oauth2.core.user.OAuth2User;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.function.Supplier;

@Configuration
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

    @Bean
    public JdbcUserDetailsManager userDetailsManager(DataSource dataSource) {
        return new JdbcUserDetailsManager(dataSource);
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        // ⚙️ Tắt CSRF và CORS để dễ kiểm thử
        http.csrf(csrf -> csrf.disable())
                .cors(cors -> cors.disable());

        // ⚙️ Phân quyền truy cập
        http.authorizeHttpRequests(req -> {
            req.anyRequest().permitAll();
        });

        // ⚙️ Cấu hình form login truyền thống
        http.formLogin(form -> form
                .loginPage("/login/form")
                .loginProcessingUrl("/login/check")
                .defaultSuccessUrl("/", true)
                .failureUrl("/login/failure")
                .permitAll()
        );

        // ⚙️ Cấu hình đăng nhập Google (OAuth2)
        http.oauth2Login(login -> {
            login.permitAll();
            login.successHandler((request, response, authentication) -> {
                try {
                    // Lấy info từ Google
                    Object principal = authentication.getPrincipal();
                    String username = null;

                    if (principal instanceof OAuth2User oauth2User) {
                        username = oauth2User.getAttribute("email");
                    }

                    if (username == null || username.isEmpty()) {
                        username = "unknown_user@google.com";
                    }

                    // Gán role mặc định cho Google
                    String role = "OAUTH";

                    // Tạo user giả
                    UserDetails newUser = User.withUsername(username)
                            .password("{noop}oauth2user")
                            .roles(role)
                            .build();

                    Authentication newauth = new UsernamePasswordAuthenticationToken(
                            newUser, null, newUser.getAuthorities());
                    SecurityContextHolder.getContext().setAuthentication(newauth);

                    // Điều hướng sau login
                    HttpSession session = request.getSession(false);
                    String attr = "SPRING_SECURITY_SAVED_REQUEST";
                    String redirectUrl = "/";

                    if (session != null) {
                        DefaultSavedRequest req = (DefaultSavedRequest) session.getAttribute(attr);
                        if (req != null && req.getRedirectUrl() != null) {
                            redirectUrl = req.getRedirectUrl();
                        }
                    }

                    response.sendRedirect(redirectUrl);

                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            });
        });

        // ⚙️ Cấu hình logout
        http.logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login/exit")
                .clearAuthentication(true)
                .invalidateHttpSession(true)
        );

        // ⚙️ Xử lý trang lỗi truy cập
        http.exceptionHandling(ex -> ex.accessDeniedPage("/access-denied"));

        return http.build();
    }
}
