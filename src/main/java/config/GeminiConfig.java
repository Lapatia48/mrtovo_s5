package config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class GeminiConfig {
    
    private static final String GEMINI_API_KEY = "AIzaSyDIqnCWubDTdX6RKaSyTje20iXC_Oa-QCM";
    
    private static final String GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent";
    private static final String GEMINI_MODEL = "gemini-flash-latest";

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

    public String getModel() {
        return GEMINI_MODEL;
    }

    public String getApiKey() {
        return GEMINI_API_KEY;
    }

    public String getApiUrl() {
        return GEMINI_API_URL + "?key=" + GEMINI_API_KEY;
    }
}