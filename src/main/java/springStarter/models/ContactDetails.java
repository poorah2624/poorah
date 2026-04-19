package springStarter.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="contactDetails")
@Getter
@Setter
public class ContactDetails {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long detailsId;
	
	@Column(name="emailId", nullable=false)
	private String emailId;
	
	@Column(name="mobileNo", nullable=false)
	private String mobileNo;
	
	@Column(name="phone", nullable=false)
	private String phone;
	
	@Column(name="facebook", nullable=false)
	private String facebook;
	
	@Column(name="twitter", nullable=false)
	private String twitter;
	
	@Column(name="google", nullable=false)
	private String google;
	
	@Column(name="pinterest", nullable=false)
	private String pinterest;
	
	@Column(name="address", nullable=false, length=500)
	private String address;
	
	@Column(name="map", nullable=false)
	private String map;
	
	

}
