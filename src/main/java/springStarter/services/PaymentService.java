package springStarter.services;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import springStarter.models.Payment;
import springStarter.repository.PaymentRepo;

@Service
@Transactional
public class PaymentService {
	
	@Autowired
	private PaymentRepo paymentRepo;
	
	public Payment getPaymentByPaymentId(Long paymentId) {
		return paymentRepo.findById(paymentId).orElseThrow(() -> new RuntimeException("Payment not found"));
	}

}
