package springStarter.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.ExchangeRequest;
import springStarter.models.Order_item;
import springStarter.models.ReturnRequest;

@Repository
public interface ExchangeRequestRepo extends JpaRepository<ExchangeRequest, Long>{
	
	List<ExchangeRequest> findByOrderItem(Order_item orderItem);
	
	List<ExchangeRequest> findAllByOrderByExchangeIdDesc();

}
