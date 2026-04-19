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
@Table(name="team")
@Getter
@Setter
public class Team {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long teamId;
	
	@Column(name="tName", nullable=false)
	private String tName;
	
	@Column(name="tEmail", nullable=false)
	private String tEmail;
	
	@Column(name="tDesignation", nullable=false)
	private String tDesignation;

	@Column(name="tImage", nullable=true)
	private String tImage;

	@Column(name="tMobile", nullable=false)
	private String tMobile;

	public String gettName() {
		return tName;
	}

	public void settName(String tName) {
		this.tName = tName;
	}

	public String gettEmail() {
		return tEmail;
	}

	public void settEmail(String tEmail) {
		this.tEmail = tEmail;
	}

	public String gettDesignation() {
		return tDesignation;
	}

	public void settDesignation(String tDesignation) {
		this.tDesignation = tDesignation;
	}

	public String gettImage() {
		return tImage;
	}

	public void settImage(String tImage) {
		this.tImage = tImage;
	}

	public String gettMobile() {
		return tMobile;
	}

	public void settMobile(String tMobile) {
		this.tMobile = tMobile;
	}
	
	



}
