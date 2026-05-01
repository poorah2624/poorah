package springStarter.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;



@Entity
@Table(name="terms")
public class Terms {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long termId;
	
	@Column(name="termName", nullable=false)
	private String termName;
	
	@Column(name="termDesc", nullable=false, length=5000)
	private String termDesc;

	public Long getTermId() {
		return termId;
	}

	public void setTermId(Long termId) {
		this.termId = termId;
	}

	public String getTermName() {
		return termName;
	}

	public void setTermName(String termName) {
		this.termName = termName;
	}

	public String getTermDesc() {
		return termDesc;
	}

	public void setTermDesc(String termDesc) {
		this.termDesc = termDesc;
	}
	
	
	


}
