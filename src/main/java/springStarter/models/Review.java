package springStarter.models;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="review")
@Getter
@Setter
public class Review {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long reviewId;
	
	@Column(length = 1000)
    private String message;

    private int rating;

    private String status; // pending / approved

    private LocalDateTime createdAt;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable=true)
    private User user;
    
    @ManyToOne
    @JoinColumn(name = "item_id")
    private Item item;
    
    private String guestName;
    private String guestEmail;
    
    @PrePersist
    public void onCreate(){
        createdAt = LocalDateTime.now();
    }

}
