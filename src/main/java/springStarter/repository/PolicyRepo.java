package springStarter.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import springStarter.models.Policy;

public interface PolicyRepo extends JpaRepository<Policy, Long>{

}
