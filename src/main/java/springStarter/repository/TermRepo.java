package springStarter.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import springStarter.models.Terms;

public interface TermRepo extends JpaRepository<Terms, Long>{

}
