package springStarter.models;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="admintable")
@Getter
@Setter
public class Admin {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long adminId;
	
	@Column(name="name", nullable=false)
	private String name;
	
	@Column(name="email", nullable=false, unique=true)
	private String email;
	
	@Column(name="password", nullable=false)
	private String password;
	
	@Column(name="address", nullable=false)
	private String address;
	
	@Column(name="mobile", nullable=false)
	private String mobile;
	
	@Column(name="image")
	private String image;
	
	private String role;
	
	private String categoryAccess;
	
	
	
	// New fields for reset password
    private String resetToken;
    private LocalDateTime tokenExpiry;
	

}
