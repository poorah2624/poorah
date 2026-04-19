package springStarter.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.Order_item;

@Repository
public interface OrderItemRepo extends JpaRepository<Order_item, Long> {
	
	List<Order_item> findByReturnStatus(String status);
	
	List<Order_item> findByRefundStatusAndStatus(String refundStatus, String status);
	
	List<Order_item> findByRefundStatusAndReturnStatus(String refundStatus, String returnStatus);

}
