package springStarter.Controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import springStarter.models.Team;
import springStarter.services.TeamService;

@Controller
public class TeamController {
	
	@Autowired
	private TeamService teamService;
	
	@GetMapping("/Add_team")
	public String add_team() {
	    
	    return "admin/Add_team";
	}
	
	@PostMapping("/save")
    public String saveTeam(
            @ModelAttribute Team team,
            @RequestParam("file") MultipartFile file
    ) throws IOException {

        teamService.save(team, file);
        return "redirect:/View_team";
    }
	
	  @GetMapping("/View_team")
	    public String viewPage(Model model) {
	        model.addAttribute("teams", teamService.getAllTeams());
	        return "admin/View_team";
	    }
	  
	  @GetMapping("/editTeam/{teamId}")
	    public String editPage(@PathVariable Long teamId, Model model) {
	        model.addAttribute("team", teamService.getById(teamId));
	        return "admin/editTeam";
	    }
	  
	  @Autowired
		private Cloudinary cloudinary;
	  
	  @PostMapping("/editTeam")
		public String updateTeam(
		        @RequestParam("teamId") Long teamId,
		        @RequestParam("tName") String tName,
		        @RequestParam("tEmail") String tEmail,
		        @RequestParam("tDesignation") String tDesignation,
		        @RequestParam(value = "file", required = false) MultipartFile file,
		        @RequestParam("tMobile") String tMobile,
		        Model model
		) throws IOException {

		    Team existingTeam = teamService.getById(teamId);

		    //  Image Update Logic
		    if (file != null && !file.isEmpty()) {

		    	 /*String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";*/
		    	try {
		    	    Map uploadResult = cloudinary.uploader().upload(
		    	            file.getBytes(),
		    	            ObjectUtils.asMap("folder", "poorah/team")
		    	    );

		    	    String imageUrl = (String) uploadResult.get("secure_url");

		    	    existingTeam.settImage(imageUrl);   

		    	} catch (Exception e) {
		    	    e.printStackTrace();
		    	}
		    }

		    // Status Update
		    existingTeam.settName(tName);
		    existingTeam.settEmail(tEmail);
		    existingTeam.settDesignation(tDesignation);
		    existingTeam.settMobile(tMobile);

		    teamService.updateTeam(existingTeam);
		    model.addAttribute("msg","Team edited successfully");
		    return "redirect:/View_team";
		}
	  
	  @GetMapping("/DeleteTeam/{teamId}")
	    public String delete(@PathVariable Long teamId) {
	        teamService.delete(teamId);
	        return "redirect:/View_team";
	    }
	

}
