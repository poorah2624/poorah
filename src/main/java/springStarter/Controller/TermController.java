package springStarter.Controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import springStarter.models.Terms;
import springStarter.services.TermService;

@Controller
public class TermController {
	
	@Autowired
	private TermService termService;
	
	@GetMapping("/Term_Condition")
	public String privacyPolicy(Model model) {
		
     Terms terms = termService.getTerm();
	    
	    if (terms == null) {
	    	terms = new Terms();  
	    }
	    model.addAttribute("terms", terms);
	    
	    return "admin/Term_Condition";
	}
	
	@PostMapping("/UpdateTermsCondition")
	public String updateTerm(
			@RequestParam(required=false) Long termId,
	        @RequestParam String termName,
	        @RequestParam String termDesc
	) throws IOException {
		
		Terms terms;

	    if (termId != null && termId > 0) {
	        terms = termService.getById(termId);
	    } else {
	        terms = new Terms();
	    }

	 
	    terms.setTermName(termName);
	    terms.setTermDesc(termDesc);

	    // send file to service
	    termService.saveOrUpdate(terms);

	    return "redirect:/Term_Condition";
	}

}
