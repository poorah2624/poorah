package springStarter.services;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import springStarter.models.AboutUs;
import springStarter.models.ContactDetails;
import springStarter.repository.ContactDetailsRepo;

@Service
@Transactional
public class ContactDetailsService {
	
	@Autowired
	private ContactDetailsRepo cDetailsRepo;

	public ContactDetails getContactDetails() {
		 //return aboutRepo.findAll().stream().findFirst().orElse(new AboutUs());
    	List<ContactDetails> list = cDetailsRepo.findAll();
    	
    	if(list.isEmpty()) {
    		ContactDetails cDetails = new ContactDetails();
    		cDetails.setEmailId("email@gmail.com");
    		cDetails.setMobileNo("123456789");
    		cDetails.setPhone("88888");
    		cDetails.setFacebook("Facebook link");
    		cDetails.setTwitter("Twitter link");
    		cDetails.setGoogle("google");
    		cDetails.setPinterest("Pinterest");
    		cDetails.setAddress("Address");
    		cDetails.setMap("Map service");
    		
            return cDetailsRepo.save(cDetails);  // auto insert
        }
    	return list.get(0);
	}

	public ContactDetails getById(Long detailsId) {
		return cDetailsRepo.findById(detailsId) 
	             .orElseThrow(() -> new RuntimeException("Details not found"));
	}

	public void saveOrUpdate(ContactDetails cDetails) {
		ContactDetails existing = null;

        if (cDetails.getDetailsId() != null) {
            existing = cDetailsRepo.findById(cDetails.getDetailsId()).orElse(null);
        }

        if (existing == null) {
            existing = new ContactDetails();
        }
        
        existing.setEmailId(cDetails.getEmailId());
        existing.setMobileNo(cDetails.getMobileNo());
        existing.setPhone(cDetails.getPhone());
        existing.setFacebook(cDetails.getFacebook());
        existing.setTwitter(cDetails.getTwitter());
        existing.setGoogle(cDetails.getGoogle());
        existing.setPinterest(cDetails.getPinterest());
        existing.setAddress(cDetails.getAddress());
        existing.setMap(cDetails.getMap());
        
        
        cDetailsRepo.save(existing);
		
	}

}
