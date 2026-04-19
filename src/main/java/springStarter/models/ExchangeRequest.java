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
@Table(name="exchangeRequest")
@Getter
@Setter
public class ExchangeRequest {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long exchangeId; 

    @ManyToOne
    private Order_item orderItem;

    private String newSize;

    private String reason;

    private String status; 

}
