package springStarter.Controller;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import springStarter.models.Contact;
import springStarter.models.Reply;
import springStarter.services.ContactService;
import springStarter.services.EmailService;
import springStarter.services.ReplyService;

@Controller
public class ReplyController {
	
	@Autowired
	private ContactService contactService;
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private EmailService emailService;

	@GetMapping("/ReplyQuery/{contactId}")
	public String replyQuery(@PathVariable Long contactId, Model model) {
		
		Contact contact = contactService.getByContactId(contactId);

	    model.addAttribute("contact", contact);
	    
	    return "admin/ReplyQuery";
	}
	

	@PostMapping("/ReplyQuery")
	public String sendReply(@RequestParam Long contactId,
			                @RequestParam String userEmail,
			                @RequestParam String userName,
	                        @RequestParam String subject,
	                        @RequestParam String inbox) {

	    Contact contact = contactService.getByContactId(contactId);

	    Reply reply = new Reply();
	    reply.setContact(contact);
	    reply.setUserEmail(userEmail);
	    reply.setUserName(userName);
	    reply.setInbox(inbox);
	    reply.setSubject(subject);
	    reply.setRepliedAt(LocalDateTime.now());

	    replyService.save(reply);
	    
	    emailService.sendReply(
	            contact.getUserEmail(),   
	            subject,                  
	            inbox ,
	            contact.getUserName()
	    );

	    // update status
	    contact.setStatus("REPLIED");
	    contactService.saveContact(contact);

	    return "admin/contact_Query";
	}

}
