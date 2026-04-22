package springStarter.config;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CloudinaryConfig {

    @Bean
    public Cloudinary cloudinary() {
        return new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "dqufjiuzx",
            "api_key", "116481343763136",
            "api_secret", "00u9_HCgzpgSJy-wsrBJ3PtF_Mo"
        ));
    }
}