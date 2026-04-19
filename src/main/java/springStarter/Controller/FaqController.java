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
import springStarter.models.FAQ;
import springStarter.services.FaqService;

@Controller
public class FaqController {
	
	@GetMapping("/ADD_FAQ")
	public String add_FAQ() {
	    
	    return "admin/ADD_FAQ";
	}
	
	@Autowired
	private FaqService faqService;
	
	@GetMapping("/View_FAQ")
	public String view_FAQ(Model model) {
		
		List<FAQ> faq = faqService.getAllFaq(); 
		model.addAttribute("faq", faq); 
	    
	    return "admin/View_FAQ";
	}
	
	@PostMapping("/AddFaq")
	public String saveFAQ(@RequestParam String question, @RequestParam String answer, Model model) throws IOException {
		
		FAQ faq = new FAQ();
		faq.setQuestion(question);
		faq.setAnswer(answer);
		
		faqService.saveFAQ(faq);
		
		model.addAttribute("msg","FAQ added successfully");
	    return "redirect:/View_FAQ";
	
	}
	
	@GetMapping("/edit_FAQ/{faqId}")
	public String edit_FAQ(@PathVariable("faqId") Long faqId, Model model) {

	    FAQ faq = faqService.getFaqById(faqId);

	    model.addAttribute("faq", faq);

	    return "admin/edit_FAQ";
	}
	
	@PostMapping("/edit_FAQ")
	public String updateFAQ(@ModelAttribute FAQ faq) {
	    faqService.updateFAQ(faq); 
	    return "redirect:/View_FAQ";
	}
	
	@GetMapping("/DeleteFAQ/{faqId}")
	public String deleteFaq(@PathVariable("faqId") Long faqId) {

		faqService.deleteFaq(faqId);

	    return "redirect:/View_FAQ";
	}

}
