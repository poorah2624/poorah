package springStarter.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import springStarter.services.ShiprocketService;

@RestController
public class ShiprocketController {
	
	@Autowired
    ShiprocketService shiprocketService;

    @GetMapping("/shiprocket-test")
    public String test() {

        return shiprocketService.getToken();
    }

}
