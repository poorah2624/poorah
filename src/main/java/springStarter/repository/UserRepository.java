package springStarter.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import springStarter.models.User;

public interface UserRepository extends JpaRepository<User, Long>{
	
	// email already exist check
    boolean existsByUserEmail(String userEmail);

    // login
    User findByUserEmail(String userEmail);

	User findByResetToken(String token);

}
