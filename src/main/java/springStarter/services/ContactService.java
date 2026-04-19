package springStarter.services;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import springStarter.models.Contact;
import springStarter.repository.ContactRepo;

@Service
@Transactional
public class ContactService {
	
	@Autowired
	private ContactRepo contactRepo;
	
	public void saveContact(Contact contact) {
		contactRepo.save(contact);
		
	}
	
	public List<Contact> getAllContacts() {
		return contactRepo.findAll();
	}

	public Contact getByContactId(Long contactId) {
		return contactRepo.findByContactId(contactId);
	}

}
