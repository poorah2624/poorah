package springStarter.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="aboutUs")
public class AboutUs {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long aId;
	
	@Column(name="aName", nullable=false)
	private String aName;
	
	@Column(name="aImage", nullable=false)
	private String aImage;
	
	@Column(name="aDesc", length=5000)
	private String aDesc;

	public Long getaId() {
		return aId;
	}

	public void setaId(Long aId) {
		this.aId = aId;
	}

	public String getaName() {
		return aName;
	}

	public void setaName(String aName) {
		this.aName = aName;
	}

	public String getaImage() {
		return aImage;
	}

	public void setaImage(String aImage) {
		this.aImage = aImage;
	}

	public String getaDesc() {
		return aDesc;
	}

	public void setaDesc(String aDesc) {
		this.aDesc = aDesc;
	}

	
	
	

}
