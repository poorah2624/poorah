package springStarter.Controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import springStarter.models.Category;
import springStarter.models.SocialLinks;
import springStarter.services.SocialLinkService;

@Controller
public class SocialLinkController {
	
	@Autowired
	private SocialLinkService socialLinkService;
	
	@GetMapping("/add_insta")
	public String add_insta()
	{
		return "admin/add_insta";
	}
	
	@PostMapping("/add_insta")
	public String saveInsta(@RequestParam String platform, @RequestParam String url, @RequestParam String socialStatus, Model model) throws IOException {
		
		SocialLinks social = new SocialLinks();
		
		social.setPlatform(platform);
		social.setUrl(url);
		social.setSocialStatus(socialStatus);
		
		socialLinkService.saveSocialLink(social);
		
		model.addAttribute("msg","Social link added successfully");
	    return "redirect:/view_insta";
	
	}
	
	@GetMapping("/edit_insta/{instaId}")
	public String edit_insta(@PathVariable("instaId") Long instaId, Model model)
	{
		SocialLinks social = socialLinkService.getSocialLinksById(instaId);
		
		model.addAttribute("social", social);
		
		return "admin/edit_insta";
	}
	
	@GetMapping("/view_insta")
	public String view_insta(Model model)
	{
		List<SocialLinks> social = socialLinkService.getAllSocialLinks();

	    model.addAttribute("social", social); 
	    
		return "admin/view_insta";
	}
	
	@PostMapping("/edit_insta")
	public String updateSocial(@ModelAttribute SocialLinks social) {
		socialLinkService.updateSocialLinks(social); 
	    return "redirect:/view_insta";
	}
	
	@GetMapping("/Delete_Insta/{instaId}")
	public String deleteSocialLinks(@PathVariable("instaId") Long instaId) {

		socialLinkService.deleteSocialLinks(instaId);

	    return "redirect:/view_Category";
	}

}
