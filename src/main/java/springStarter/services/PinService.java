package springStarter.services;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import springStarter.models.Category;
import springStarter.models.Pin;
import springStarter.repository.PinRepo;

@Service
@Transactional
public class PinService {
	
	@Autowired
	private PinRepo pinRepo;

	public void savePin(Pin pin) {
		pinRepo.save(pin);
		
	}

	public List<Pin> getAllPin() {
		// TODO Auto-generated method stub
		return pinRepo.findAll();
	}

	public Pin getPinById(Long pinId) {
		return pinRepo.findByPinId(pinId) 
	             .orElseThrow(() -> new RuntimeException("Pin not found"));
	}
	
	public void updatePin(Pin updated) {

	    Pin existing = pinRepo.findById(updated.getPinId())
	            .orElseThrow(() -> new RuntimeException("Not found"));

	    existing.setPincode(updated.getPincode());
	   

	    pinRepo.save(existing);
	}
	
	public void deletePin(Long pinId) {
	    pinRepo.deleteById(pinId);
	}

}
