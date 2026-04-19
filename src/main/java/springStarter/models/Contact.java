package springStarter.models;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="contact")
@Getter
@Setter
public class Contact {
	
	 public static final String STATUS_NEW = "NEW";
	 
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long contactId;
	
	@Column(name="userName", nullable=false)
	private String userName;
	
	@Column(name="userEmail", nullable=false)
	private String userEmail;
	
	@Column(name="userMobile", nullable=true)
	private String userMobile;
	
	@Column(name="message", nullable=false, length=5000)
	private String message;
	
	@Column(name="status", nullable=false)
	private String status;
	
	@CreationTimestamp
	@Column(name = "created_at", updatable = false)
	private LocalDateTime createdAt;
	

}
