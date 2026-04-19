package springStarter.Controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import springStarter.models.Category;
import springStarter.models.Pin;
import springStarter.services.PinService;

@Controller
public class PinController {
	
	@Autowired
	private PinService pinService;
	
	@GetMapping("/AddPin")
	public String addPin() {
	    
	    return "admin/AddPin";
	}
	
	@PostMapping("/AddPin")
	public String savePin(@RequestParam String pincode, Model model) throws IOException {
		
		Pin pin = new Pin();
		pin.setPincode(pincode);
		
		pinService.savePin(pin);
		
	    return "redirect:/viewPin";
	
	}
	
	@GetMapping("/viewPin")
	public String viewPin(Model model) {
		
		List<Pin> pin = pinService.getAllPin(); 

	    model.addAttribute("pin", pin); 
	    
	    return "admin/viewPin";
	}
	
	@GetMapping("/editPin/{pinId}")
	public String editPin(@PathVariable("pinId") Long pinId, Model model) {

	    Pin pin = pinService.getPinById(pinId);

	    model.addAttribute("pin", pin);

	    return "admin/editPin";
	}
	
	@PostMapping("/editPin")
	public String updatePin(@ModelAttribute Pin pin) {
	    pinService.updatePin(pin); 
	    return "redirect:/viewPin";
	}
	
	@GetMapping("/DeletePin/{pinId}")
	public String deletePin(@PathVariable("pinId") Long pinId) {

	    pinService.deletePin(pinId);

	    return "redirect:/viewPin";
	}
	
	
	@GetMapping("/checkDelivery")
	@ResponseBody
	public String checkDelivery(@RequestParam String pincode){

	   
	    int days = 5;

	    if(pincode.startsWith("8")){ 
	        days = 5;
	    } else if(pincode.startsWith("1")){ 
	        days = 7;
	    }

	    LocalDate deliveryDate = LocalDate.now().plusDays(days);

	    return "Delivery by " + deliveryDate;
	}

}
