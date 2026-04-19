package springStarter.Controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import springStarter.models.AboutUs;
import springStarter.models.Policy;
import springStarter.services.PolicyService;

@Controller
public class PolicyController {
	
	@Autowired
	private PolicyService policyService;
	
	@GetMapping("/PrivacyPolicy")
	public String privacyPolicy(Model model) {
		
     Policy policy = policyService.getPolicy();
	    
	    if (policy == null) {
	    	policy = new Policy();  
	    }
	    model.addAttribute("policy", policy);
	    
	    return "admin/PrivacyPolicy";
	}
	
	@PostMapping("/UpdatePolicy")
	public String updatePolicy(
			@RequestParam(required=false) Long policyId,
	        @RequestParam String policyName,
	        @RequestParam String policyDesc
	) throws IOException {
		
		Policy policy;

	    if (policyId != null && policyId > 0) {
	        policy = policyService.getById(policyId);
	    } else {
	        policy = new Policy();
	    }

	 
	    policy.setPolicyName(policyName);
	    policy.setPolicyDesc(policyDesc);

	    // send file to service
	    policyService.saveOrUpdate(policy);

	    return "redirect:/PrivacyPolicy";
	}

}
