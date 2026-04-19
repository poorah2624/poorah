package springStarter.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.Orders;
import springStarter.models.User;

@Repository
public interface OrderRepo extends JpaRepository<Orders, Long> {

	List<Orders> findByUser(User user);
	
	Optional<Orders> findByIdAndUserId(Long id, Long userId);
	
	List<Orders> findByStatus(String status);
	
	List<Orders> findByUserOrderByOrderDateDesc(User user);
	
	List<Orders> findAllByOrderByOrderDateDesc();
	
	List<Orders> findByStatusOrderByOrderDateDesc(String status);
	
	

}
