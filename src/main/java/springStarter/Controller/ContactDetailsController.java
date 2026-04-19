package springStarter.Controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import springStarter.models.Category;
import springStarter.models.ContactDetails;
import springStarter.models.Team;
import springStarter.services.CategoryService;
import springStarter.services.ContactDetailsService;
import springStarter.services.TeamService;

@Controller
public class ContactDetailsController {
	
	@Autowired
	private ContactDetailsService cDetailsService;
	
	@Autowired
	private CategoryService categoryService;
	
	
	
	@GetMapping("/contactdetails")
	public String contactDetails(Model model) {
		
		ContactDetails cDetails = cDetailsService.getContactDetails();
		
		if(cDetails==null)
		{
			cDetails = new ContactDetails();
		}
		
		model.addAttribute("cDetails", cDetails);
	    
	    return "admin/contactdetails";
	}
	
	@PostMapping("/editDetails")
	public String updateDetails(
			@RequestParam(required=false) Long detailsId, @RequestParam String emailId, @RequestParam String mobileNo, @RequestParam String phone,
	        @RequestParam String facebook, @RequestParam String twitter, @RequestParam String google, @RequestParam String pinterest, @RequestParam String address,
	        @RequestParam String map
	) throws IOException {
		
		ContactDetails cDetails;

	    if (detailsId != null && detailsId > 0) {
	    	cDetails = cDetailsService.getById(detailsId);
	    } else {
	    	cDetails = new ContactDetails();
	    }

	 
	    cDetails.setEmailId(emailId);
	    cDetails.setMobileNo(mobileNo);
	    cDetails.setPhone(phone);
	    cDetails.setFacebook(facebook);
	    cDetails.setTwitter(twitter);
	    cDetails.setGoogle(google);
	    cDetails.setPinterest(pinterest);
	    cDetails.setAddress(address);
	    cDetails.setMap(map);

	    // send file to service
	    cDetailsService.saveOrUpdate(cDetails);

	    return "redirect:/contactdetails";
	}
	
	
	
	@GetMapping("/mail")
	public String mail(Model model) {
		List<Category> categories = categoryService.getAllCategories();

	    model.addAttribute("categories", categories);
	    
	    ContactDetails contactDetails = cDetailsService.getContactDetails();
	    
	    model.addAttribute("contactDetails", contactDetails);
	    
	    ContactDetails cDetails = cDetailsService.getContactDetails();
		model.addAttribute("cDetails", cDetails);
		
        
	    
	    return "mail";
	}
	
	

}
