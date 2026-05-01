package springStarter.models;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;



@Entity
@Table(name="social_links")
public class SocialLinks {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long instaId;

    private String platform;   
    private String url;
    
    private String SocialStatus;

	public Long getInstaId() {
		return instaId;
	}

	public void setInstaId(Long instaId) {
		this.instaId = instaId;
	}

	public String getPlatform() {
		return platform;
	}

	public void setPlatform(String platform) {
		this.platform = platform;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getSocialStatus() {
		return SocialStatus;
	}

	public void setSocialStatus(String socialStatus) {
		SocialStatus = socialStatus;
	}
    
    
    

}
