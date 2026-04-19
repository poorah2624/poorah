package springStarter.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.FAQ;

@Repository
public interface FaqRepo extends JpaRepository<FAQ, Long> {

	Optional<FAQ> findByFaqId(Long faqId);

}
