package springStarter.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import springStarter.models.AboutUs;
import springStarter.models.Category;
import springStarter.models.ContactDetails;
import springStarter.models.Team;
import springStarter.services.AboutUsService;
import springStarter.services.CategoryService;
import springStarter.services.ContactDetailsService;
import springStarter.services.TeamService;

@Controller
public class AboutUsController {
	
	@Autowired
	private AboutUsService aboutUsService;
	
	@Autowired
    private CategoryService categoryService;
	
	@Autowired
	private TeamService teamService;
	
	
	@GetMapping("/Addaboutus")
	public String aboutUsPage(Model model) {

	    AboutUs about = aboutUsService.getAboutUs();
	    
	    if (about == null) {
	        about = new AboutUs();  
	    }
	    model.addAttribute("aboutUs", about);
	    
	    

	    return "admin/Addaboutus";
	}
	
	@PostMapping("/UpdateAboutUs")
	public String updateAboutUs(
			@RequestParam(required=false) Long aId,
	        @RequestParam String aName,
	        @RequestParam("aImage") MultipartFile file
	) throws IOException {
		
		AboutUs aboutUs;

	    if (aId != null && aId > 0) {
	        aboutUs = aboutUsService.getById(aId);
	    } else {
	        aboutUs = new AboutUs();
	    }

	 
	    aboutUs.setaName(aName);
	    //aboutUs.setaDesc(aDesc);

	    // send file to service
	    aboutUsService.saveOrUpdate(aboutUs, file);

	    return "redirect:/Addaboutus";
	}
	
	@Autowired
	private ContactDetailsService cDetailsService;
	
	@GetMapping("/about")
	public String about(Model model) {
		
		List<Category> categories = categoryService.getAllCategories();

	    model.addAttribute("categories", categories);
	    
	    AboutUs about = aboutUsService.getAboutUs();
	    
	    model.addAttribute("about", about);
	    
	    List<Team> team = teamService.getAllTeams();
	    
	    model.addAttribute("team", team);
	    
	    ContactDetails cDetails = cDetailsService.getContactDetails();
		model.addAttribute("cDetails", cDetails);
	    
	    return "about";
	}

}
