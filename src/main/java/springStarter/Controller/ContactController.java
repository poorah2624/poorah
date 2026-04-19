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
	public String contact(@RequestParam String userName, 
			@RequestParam String userEmail, 
			@RequestParam String userMobile,
			@RequestParam String message,
			Model model,
			RedirectAttributes redirectAttributes)
	{
		Contact contact = new Contact();
		
		contact.setUserName(userName);
		contact.setUserEmail(userEmail);
		contact.setUserMobile(userMobile);
		contact.setMessage(message);
		
		contact.setStatus(Contact.STATUS_NEW); 
		
		contact.setCreatedAt(LocalDateTime.now());
		
		contactService.saveContact(contact);
		
		redirectAttributes.addFlashAttribute("msg", "Submitted successfully");
		
		String adminBody = "New Contact Query Received\n\n"
	            + "Name: " + userName + "\n"
	            + "Email: " + userEmail + "\n"
	            + "Mobile: " + userMobile + "\n"
	            + "Message: " + message;

	    emailService.sendToAdmin(
	            "New Contact Query - Poorah",
	            adminBody
	    );
	    
	    emailService.sendAutoReply(
	            userEmail,
	            "We received your query",
	            "Hello " + userName + ",\n\nThank you for reaching out to us. \n\nWe have received your query and our team will get back to you shortly.\n\nTeam Poorah"
	    );
		
        ContactDetails contactDetails = cDetailsService.getContactDetails();
	    
	    model.addAttribute("contactDetails", contactDetails);
	    
		
		return "redirect:/mail?success";
		
	}
	

}
