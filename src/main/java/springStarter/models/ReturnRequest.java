package springStarter.models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="returnRequest")
@Getter
@Setter
public class ReturnRequest {
	


	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long returnId;

    @ManyToOne
    private Order_item orderItem;

    private String reason;

    private String status; 
    
    private String returnPickupDate;

}
