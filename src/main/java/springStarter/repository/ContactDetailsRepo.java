package springStarter.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.ContactDetails;

@Repository
public interface ContactDetailsRepo extends JpaRepository<ContactDetails, Long> {

}
