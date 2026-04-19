package springStarter.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.Cart;
import springStarter.models.Item;
import springStarter.models.User;

@Repository
public interface CartRepo extends JpaRepository<Cart, Long> {
	
	List<Cart> findByUserAndItem(User user, Item item);
	
	Cart findByUserAndItemAndSizeAndAge(User user, Item item, String size, String age);

    List<Cart> findByUser(User user);
    
    int countByUser(User user);

    @Transactional
	void deleteByUser(User user);

}
