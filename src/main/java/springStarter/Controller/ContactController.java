package springStarter.Controller;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import springStarter.models.Contact;
import springStarter.models.ContactDetails;
import springStarter.models.Reply;
import springStarter.services.CaptchaService;
import springStarter.services.ContactDetailsService;
import springStarter.services.ContactService;
import springStarter.services.EmailService;

@Controller
public class ContactController {
	
	@Autowired
	private ContactService contactService;
	
	@Autowired
	private ContactDetailsService cDetailsService;
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private CaptchaService captchaService;
	
	@GetMapping("/contact_Query")
	public String contact_Query(Model model) {
		
		List<Contact> contact = contactService.getAllContacts();
		
		model.addAttribute("contact", contact);
	    
	    return "admin/contact_Query";
	}
	
	@GetMapping("/ViewContactQuery/{contactId}")
	public String viewContactQuery(@PathVariable("contactId") Long contactId, Model model) {
		
	    Contact contact = contactService.getByContactId(contactId);

	    model.addAttribute("contact", contact);

	    
	    return "admin/ViewContactQuery";
	}
	
	
	
	
	@PostMapping("/contact")
	public String contact(
	        @RequestParam String userName,
	        @RequestParam String userEmail,
	        @RequestParam String userMobile,
	        @RequestParam String message,
	        @RequestParam(required = false) String website,
	        Model model,
	        @RequestParam(name = "g-recaptcha-response")
	        String captchaResponse,
	        RedirectAttributes redirectAttributes)
	{
	    
	    // Honeypot check
	    if (website != null && !website.trim().isEmpty()) {
	        return "redirect:/mail";
	        
	    }
	    
	    if (!captchaService.verifyCaptcha(captchaResponse)) {
	        return "redirect:/mail?captchaerror";
	    }

	    // Name validation
	    if(userName.length() > 50){
	        return "redirect:/mail?error";
	    }

	    // Email validation
	    if(!userEmail.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
	        return "redirect:/mail?error";
	    }

	    // Mobile validation
	    if(!userMobile.matches("^[0-9]{10,15}$")) {
	        return "redirect:/mail?error";
	    }

	    // Message validation
	    String lowerMessage = message.toLowerCase();

	    if(lowerMessage.contains("http://")
	            || lowerMessage.contains("https://")
	            || lowerMessage.contains("btc")
	            || lowerMessage.contains("crypto")
	            || lowerMessage.contains(".xyz")
	            || lowerMessage.contains("telegram")
	            || message.length() > 500) {

	        return "redirect:/mail?spam";
	    }

	    Contact contact = new Contact();

	    contact.setUserName(userName.trim());
	    contact.setUserEmail(userEmail.trim());
	    contact.setUserMobile(userMobile.trim());
	    contact.setMessage(message.trim());

	    contact.setStatus(Contact.STATUS_NEW);
	    contact.setCreatedAt(LocalDateTime.now());

	    contactService.saveContact(contact);

	    redirectAttributes.addFlashAttribute(
	            "msg",
	            "Submitted successfully"
	    );

	    String adminBody = "New Contact Query Received\n\n"
	            + "Name: " + userName + "\n"
	            + "Email: " + userEmail + "\n"
	            + "Mobile: " + userMobile + "\n"
	            + "Message: " + message;

	    try {

	        emailService.sendToAdmin(
	                "New Contact Query - Poorah",
	                adminBody,
	                userEmail
	        );

	        emailService.sendAutoReply(
	                userEmail,
	                "We received your query",
	                "Hello " + userName
	                        + ",\n\nThank you for reaching out to us."
	                        + "\n\nTeam Poorah"
	        );

	    } catch(Exception e) {
	        e.printStackTrace();
	    }

	    return "redirect:/mail?success";
	}
	
	

}
