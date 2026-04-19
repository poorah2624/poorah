package springStarter.models;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="social_links")
@Getter
@Setter
public class SocialLinks {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long instaId;

    private String platform;   
    private String url;
    
    private String SocialStatus;

}
