package com.poly.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService(PasswordEncoder pe) {
        String password = pe.encode("123");

        UserDetails user = User.withUsername("user@gmail.com").password(password).roles("USER").build();
        UserDetails admin = User.withUsername("admin@gmail.com").password(password).roles("ADMIN").build();
        UserDetails both = User.withUsername("both@gmail.com").password(password).roles("USER", "ADMIN").build();

        return new InMemoryUserDetailsManager(user, admin, both);
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        // Tắt CSRF và CORS
        http.csrf(csrf -> csrf.disable())
                .cors(cors -> cors.disable());

        http.authorizeHttpRequests(auth -> auth
                //  Home & URL0 → ai cũng vào được
                .requestMatchers("/", "/poly/home", "/poly/url0").permitAll()


                .requestMatchers("/poly/url1", "/poly/url2").hasAnyRole("USER")


                .requestMatchers("/poly/url3").hasRole("ADMIN")


                .requestMatchers("/poly/url4").hasAnyRole("USER", "ADMIN")


                .anyRequest().authenticated()
        );


        // ✅ FORM ĐĂNG NHẬP TÙY BIẾN
        http.formLogin(config -> {
            config.loginPage("/login/form");                     // Trang hiển thị form
            config.loginProcessingUrl("/login/check");            // URL xử lý login (form action)
            config.defaultSuccessUrl("/", true);
            config.failureUrl("/login/failure");                  // Khi đăng nhập thất bại
            config.permitAll();
            config.usernameParameter("username");                 // Tên input username
            config.passwordParameter("password");                 // Tên input password
        });

        // ✅ GHI NHỚ TÀI KHOẢN
        http.rememberMe(config -> {
            config.tokenValiditySeconds(3 * 24 * 60 * 60);        // 3 ngày
            config.rememberMeCookieName("remember-me");           // Tên cookie
            config.rememberMeParameter("remember-me");            // Tên checkbox trong form
        });

        // ✅ ĐĂNG XUẤT
        http.logout(config -> {
            config.logoutUrl("/logout");                          // URL xử lý logout
            config.logoutSuccessUrl("/login/exit");               // Khi logout thành công
            config.clearAuthentication(true);                     // Xóa thông tin xác thực
            config.invalidateHttpSession(true);                   // Hủy session
            config.deleteCookies("remember-me");                  // Xóa cookie
        });

        return http.build();
    }
}
