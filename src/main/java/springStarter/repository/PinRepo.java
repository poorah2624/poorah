package springStarter.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


import springStarter.models.Pin;

@Repository
public interface PinRepo extends JpaRepository<Pin, Long> {

	Optional<Pin> findByPinId(Long pinId);

}
