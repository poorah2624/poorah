package springStarter.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.Address;
import springStarter.models.User;

@Repository
public interface AddressRepo extends JpaRepository<Address, Long>{
	
	List<Address> findByUserId(Long userId);
	
	Address findByUserAndIsDefaultAddressTrue(User user);

}
