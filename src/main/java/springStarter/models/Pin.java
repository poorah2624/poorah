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
@Table(name="pin")
@Getter
@Setter
public class Pin {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long pinId;
	
	@Column(name="pincode", nullable=false)
	private String pincode;

}
