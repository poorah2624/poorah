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
@Table(name="terms")
@Getter
@Setter
public class Terms {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long termId;
	
	@Column(name="termName", nullable=false)
	private String termName;
	
	@Column(name="termDesc", nullable=false, length=5000)
	private String termDesc;


}
