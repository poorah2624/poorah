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
@Table(name="banner")
@Getter
@Setter
public class Banner {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long bannerId;
	
	@Column(name="bannerName", nullable=false)
	private String bannerName;
	
	@Column(name="bannerStatus", nullable=false)
	private String bannerStatus;

}
