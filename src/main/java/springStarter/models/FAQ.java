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
@Table(name="faq")
@Getter
@Setter
public class FAQ {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long faqId;
	
	@Column(name="question", length = 1000)
	private String question;
	
	@Column(name="answer", length = 5000)
	private String answer;

}
