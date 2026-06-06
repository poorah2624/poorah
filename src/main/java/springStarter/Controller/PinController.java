package springStarter.Controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
import org.springframework.web.client.RestTemplate;

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
	
	@Autowired
    private RestTemplate restTemplate;
	
	@GetMapping("/checkDelivery")
    @ResponseBody
    public String checkDelivery(@RequestParam String pincode) {
       
        if (pincode == null || !pincode.matches("^[1-9][0-9]{5}$")) {
            return "❌ Invalid Pincode. Please enter a valid 6-digit number.";
        }

        try {
        
            String apiUrl = "https://api.postalpincode.in/pincode/" + pincode;
        
            PincodeApiResponse[] responseArray = restTemplate.getForObject(apiUrl, PincodeApiResponse[].class);

            if (responseArray == null || responseArray.length == 0 || !"Success".equalsIgnoreCase(responseArray[0].getStatus())) {
                return "❌ Delivery not available. This pincode does not exist in India Post records.";
            }

            PostOfficeDetails details = responseArray[0].getPostOffice().get(0);
            String city = details.getDistrict();
            String state = details.getState();

            char zone = pincode.charAt(0);
            int days = 5; 

            if (zone == '8') { 
                // Local Zone: Jharkhand & Bihar 
                days = 3; 
            } else if (zone == '1' || zone == '2') { 
                // North/Central: Delhi NCR, UP, Haryana
                days = 5; 
            } else if (zone == '3' || zone == '4') { 
                // West/Central: Mumbai, Maharashtra, Gujarat, MP
                days = 6; 
            } else if (zone == '5' || zone == '6') { 
                // South: Bengaluru, Hyderabad, Chennai
                days = 7; 
            } else if (zone == '7') { 
                // East / North-East States (Kolkata, Assam)
                days = pincode.startsWith("79") ? 9 : 6;
            }

            // 5. Live Date Formatter setup (e.g., "Monday, 08 Jun")
            LocalDate deliveryDate = LocalDate.now().plusDays(days);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, dd MMM");
            String formattedDate = deliveryDate.format(formatter);

            return "✅ Serviceable to " + city + " (" + state + "). Delivery expected by " + formattedDate + " (" + days + " Days).";

        } catch (Exception e) {
            e.printStackTrace();
           
            return "🚚 Delivery available at your location. Standard delivery takes 5-7 days.";
        }
    }


// 🌟 GOVERNMENT API DYNAMIC RESPONSE PARSING CLASSES 🌟
class PincodeApiResponse {
    private String Message;
    private String Status;
    private List<PostOfficeDetails> PostOffice;

    public String getMessage() { return Message; }
    public void setMessage(String Message) { this.Message = Message; }
    public String getStatus() { return Status; }
    public void setStatus(String Status) { this.Status = Status; }
    public List<PostOfficeDetails> getPostOffice() { return PostOffice; }
    public void setPostOffice(List<PostOfficeDetails> PostOffice) { this.PostOffice = PostOffice; }
}

class PostOfficeDetails {
    private String Name;
    private String District;
    private String State;

    public String getName() { return Name; }
    public void setName(String Name) { this.Name = Name; }
    public String getDistrict() { return District; }
    public void setDistrict(String District) { this.District = District; }
    public String getState() { return State; }
    public void setState(String State) { this.State = State; }
}

}
