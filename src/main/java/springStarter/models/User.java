package springStarter.models;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="users")
@Getter
@Setter
public class User {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(name="userName", nullable=false)
	private String userName;
	
	@Column(name="userEmail", nullable=false, unique=true)
	private String userEmail;
	
	@Column(name="userPassword", nullable=false)
	private String userPassword;
	
	@Column(name="userMobile", nullable=false)
	private String userMobile;
	
	// New fields for reset password
    private String resetToken;
    private LocalDateTime tokenExpiry;

	
	
	@Column(name="created_at", updatable=false)
	private LocalDateTime createdAt;
	
	//automatically set time before insert
    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }
    
 //  one user → many addresses
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Address> addresses;

    //  one user → many orders
    @OneToMany(mappedBy = "user")
    private List<Orders> orders;
    

}
