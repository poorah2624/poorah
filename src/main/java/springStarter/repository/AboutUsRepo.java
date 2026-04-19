package springStarter.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.AboutUs;

@Repository
public interface AboutUsRepo extends JpaRepository<AboutUs, Long> {
	}


