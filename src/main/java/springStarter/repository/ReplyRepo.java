package springStarter.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.Reply;

@Repository
public interface ReplyRepo extends JpaRepository<Reply, Long> {

	

}
