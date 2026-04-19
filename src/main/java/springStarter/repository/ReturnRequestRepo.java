package springStarter.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.Order_item;
import springStarter.models.ReturnRequest;

@Repository
public interface ReturnRequestRepo extends JpaRepository<ReturnRequest, Long>{
	
	List<ReturnRequest> findByOrderItem(Order_item orderItem);
	
	List<ReturnRequest> findAllByOrderByReturnIdDesc();
	
	
}
