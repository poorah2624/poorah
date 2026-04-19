package springStarter.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.Team;

@Repository
public interface TeamRepo extends JpaRepository<Team, Long> {

}
