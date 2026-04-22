package springStarter.services;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import springStarter.models.AboutUs;
import springStarter.models.Policy;
import springStarter.repository.PolicyRepo;

@Service
@Transactional
public class PolicyService {
	
	@Autowired
	private PolicyRepo policyRepo;

	public Policy getPolicy() {
		List<Policy> list = policyRepo.findAll();
    	
    	if(list.isEmpty()) {
            Policy policy = new Policy();
            policy.setPolicyName("About Company");
            policy.setPolicyDesc("https://res.cloudinary.com/demo/image/upload/45.png");
            
            return policyRepo.save(policy);  // auto insert
        }
    	return list.get(0);
	}

	public Policy getById(Long policyId) {
		return policyRepo.findById(policyId) 
	             .orElseThrow(() -> new RuntimeException("Policy us not found"));
	}
	
	public void saveOrUpdate(Policy policy) throws IOException{
    	Policy existing = null;

        if (policy.getPolicyId() != null) {
            existing = policyRepo.findById(policy.getPolicyId()).orElse(null);
        }

        if (existing == null) {
            existing = new Policy();
        }

        existing.setPolicyName(policy.getPolicyName());
        existing.setPolicyDesc(policy.getPolicyDesc());

        

        policyRepo.save(existing);
    }

}
