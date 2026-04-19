package springStarter.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.Contact;

@Repository
public interface ContactRepo extends JpaRepository<Contact, Long> {

	Contact findByContactId(Long contactId);

}
