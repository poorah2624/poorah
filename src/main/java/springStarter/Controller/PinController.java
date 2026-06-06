package springStarter.Controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import com.fasterxml.jackson.annotation.JsonProperty;

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
            RestTemplate restTemplate = new RestTemplate();

           
            HttpHeaders headers = new HttpHeaders();
            headers.set("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36");
            HttpEntity<String> entity = new HttpEntity<>(headers);

           
            ResponseEntity<String> responseEntity = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, String.class);
            String rawJsonResponse = responseEntity.getBody();

            if (rawJsonResponse == null || rawJsonResponse.contains("\"Status\":\"Error\"") || rawJsonResponse.contains("\"PostOffice\":null")) {
                return "❌ Delivery not available. This pincode does not exist in India Post records.";
            }

            // 5. Zone Mapping Algorithm Framework
            char zone = pincode.charAt(0);
            int days = 5; 
            String regionInfo = "Standard Delivery Zone";

            if (zone == '8') { 
                days = 3; 
                regionInfo = "Local Home Zone (Jharkhand/Bihar)";
            } else if (zone == '1' || zone == '2') { 
                days = 5; 
                regionInfo = "North/Central Region";
            } else if (zone == '3' || zone == '4') { 
                days = 6; 
                regionInfo = "West & Central Grid";
            } else if (zone == '5' || zone == '6') { 
                days = 7; 
                regionInfo = "South Territory";
            } else if (zone == '7') { 
                days = pincode.startsWith("79") ? 9 : 6;
                regionInfo = "East Line Hub";
            }

           
            LocalDate deliveryDate = LocalDate.now().plusDays(days);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, dd MMM");
            String formattedDate = deliveryDate.format(formatter);

            return "✅ Serviceable Code. Delivery expected by " + formattedDate + " (" + days + " Days) via " + regionInfo;

        } catch (Exception e) {
          
            System.out.println("--- REAL SERVER ERROR PINCODE DIAGNOSIS ---");
            e.printStackTrace(); 
            
           
            int fallbackDays = pincode.startsWith("8") ? 3 : 6;
            LocalDate fallbackDate = LocalDate.now().plusDays(fallbackDays);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, dd MMM");
            return "🚚 Serviceable. Expected Delivery by " + fallbackDate.format(formatter) + " (" + fallbackDays + " Days).";
        }
    }


	public static class PincodeApiResponse {
	    @JsonProperty("Message") 
	    private String message;
	    
	    @JsonProperty("Status")
	    private String status;
	    
	    @JsonProperty("PostOffice")
	    private List<PostOfficeDetails> postOffice;

	    // Getters and Setters
	    public String getMessage() { return message; }
	    public void setMessage(String message) { this.message = message; }
	    public String getStatus() { return status; }
	    public void setStatus(String status) { this.status = status; }
	    public List<PostOfficeDetails> getPostOffice() { return postOffice; }
	    public void setPostOffice(List<PostOfficeDetails> postOffice) { this.postOffice = postOffice; }
	}

	public static class PostOfficeDetails {
	    @JsonProperty("Name")
	    private String name;
	    
	    @JsonProperty("District")
	    private String district;
	    
	    @JsonProperty("State")
	    private String state;

	    // Getters and Setters
	    public String getName() { return name; }
	    public void setName(String name) { this.name = name; }
	    public String getDistrict() { return district; }
	    public void setDistrict(String district) { this.district = district; }
	    public String getState() { return state; }
	    public void setState(String state) { this.state = state; }
	}

}
