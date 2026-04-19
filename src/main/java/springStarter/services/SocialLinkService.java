package springStarter.services;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import springStarter.models.SocialLinks;
import springStarter.repository.SocialLinkRepo;

@Service
@Transactional
public class SocialLinkService {
	
	@Autowired
	private SocialLinkRepo socialLinkRepo;
	
	public void saveSocialLink(SocialLinks social) {
		socialLinkRepo.save(social);
		
	}
	
	public List<SocialLinks> getAllSocialLinks() {
		 return socialLinkRepo.findAll();
	}
	
	public SocialLinks getSocialLinksById(Long i) {
		
		 return socialLinkRepo.findByInstaId(i) 
	             .orElseThrow(() -> new RuntimeException("Social link not found"));
	}
	
	public void updateSocialLinks(SocialLinks updated) {

		SocialLinks existing = socialLinkRepo.findById(updated.getInstaId())
	            .orElseThrow(() -> new RuntimeException("Not found"));

	    existing.setPlatform(updated.getPlatform());
	    existing.setUrl(updated.getUrl());
	    existing.setSocialStatus(updated.getSocialStatus());

	    socialLinkRepo.save(existing);
	}
	
	public void deleteSocialLinks(Long instaId) {
		socialLinkRepo.deleteById(instaId);
	}

}
