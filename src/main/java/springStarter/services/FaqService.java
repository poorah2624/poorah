package springStarter.services;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import springStarter.models.Category;
import springStarter.models.FAQ;
import springStarter.repository.FaqRepo;

@Service
@Transactional
public class FaqService {
	
	@Autowired
	private FaqRepo faqRepo;

	public void saveFAQ(FAQ faq) {
		faqRepo.save(faq);
		
	}

	public List<FAQ> getAllFaq() {
		return faqRepo.findAll();
	}

	public FAQ getFaqById(Long faqId) {
		return faqRepo.findByFaqId(faqId) 
	             .orElseThrow(() -> new RuntimeException("Faq not found"));
	}

	public void updateFAQ(FAQ faq) {
		 FAQ existing = faqRepo.findById(faq.getFaqId())
		            .orElseThrow(() -> new RuntimeException("Not found"));

		    existing.setQuestion(faq.getQuestion());
		    existing.setAnswer(faq.getAnswer());

		    faqRepo.save(existing);
		
	}

	public void deleteFaq(Long faqId) {
		faqRepo.deleteById(faqId);
		
	}

}
