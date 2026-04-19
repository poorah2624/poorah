package springStarter.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import springStarter.models.Admin;



public interface AdminRepo extends JpaRepository<Admin, Long>{
	
	
		
		// email already exist check
	    boolean existsByEmail(String email);

	    // login
	    Admin findByEmail(String email);

	    Admin findByResetToken(String token);

	

}
