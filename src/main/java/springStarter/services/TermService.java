package springStarter.services;

import java.io.IOException;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import springStarter.models.Terms;
import springStarter.repository.TermRepo;

@Service
@Transactional
public class TermService {
	
	@Autowired
	private TermRepo termRepo;

	public Terms getTerm() {
		List<Terms> list = termRepo.findAll();
    	
    	if(list.isEmpty()) {
            Terms terms = new Terms();
            terms.setTermName("Terms Condition");
            terms.setTermDesc("Terms condition description");
            
            return termRepo.save(terms);  // auto insert
        }
    	return list.get(0);
	}

	public Terms getById(Long termId) {
		return termRepo.findById(termId) 
	             .orElseThrow(() -> new RuntimeException("Terms us not found"));
	}
	
	public void saveOrUpdate(Terms terms) throws IOException{
    	Terms existing = null;

        if (terms.getTermId() != null) {
            existing = termRepo.findById(terms.getTermId()).orElse(null);
        }

        if (existing == null) {
            existing = new Terms();
        }

        existing.setTermName(terms.getTermName());
        existing.setTermDesc(terms.getTermDesc());

        

        termRepo.save(existing);
    }

}
