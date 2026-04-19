package springStarter.models;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="reply")
@Getter
@Setter
public class Reply {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long queryId;
	
	@Column(name="userName", nullable=false)
	private String userName;
	
	@Column(name="userEmail", nullable=false)
	private String userEmail;
	
	@Column(name="subject", nullable=false)
	private String subject;
	
	@Column(name="inbox", nullable=false, length=5000)
	private String inbox;
	
	
	private LocalDateTime repliedAt;
	
	@ManyToOne
	@JoinColumn(name = "contact_id")
	private Contact contact;

}
