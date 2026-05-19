package springStarter.services;


import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Service
public class CaptchaService {

    private static final String SECRET_KEY = "6LfFcfIsAAAAAHjcxME2HWhPdq-EMVRFKNe18yPq";

    public boolean verifyCaptcha(String captchaResponse) {

        String url =
                "https://www.google.com/recaptcha/api/siteverify";

        RestTemplate restTemplate = new RestTemplate();

        MultiValueMap<String, String> map =
                new LinkedMultiValueMap<>();

        map.add("secret", SECRET_KEY);
        map.add("response", captchaResponse);

        Map response = restTemplate.postForObject(
                url,
                map,
                Map.class
        );

        return (Boolean) response.get("success");
    }
}