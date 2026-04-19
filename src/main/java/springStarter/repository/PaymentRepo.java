package springStarter.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.Orders;
import springStarter.models.Payment;

@Repository
public interface PaymentRepo extends JpaRepository<Payment, Long>{
	
	List<Payment> findByOrder(Orders order);
	
	List<Payment> findAllByOrder(Orders order);

}
