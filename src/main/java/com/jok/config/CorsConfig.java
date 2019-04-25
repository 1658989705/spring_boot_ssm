package com.jok.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 解决跨域的配置方法
 * @author jok
 *
 */
@Configuration
public class CorsConfig {
    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
//                registry.addMapping("/api/**")
//                        .allowedHeaders("Authorization", "Token")//允许的头信息
//                        .allowedOrigins("http://localhost:8086").allowedOrigins("http://localhost:8086/index");
            	 registry.addMapping("/**")
            	 .allowedOrigins("*")
            	 .allowCredentials(true)
            	 .allowedMethods("GET", "POST", "DELETE", "PUT")
            	 .maxAge(3600); 
            }
        };
    }
}