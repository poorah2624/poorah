package springStarter.models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name="exchangeRequest")
public class ExchangeRequest {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long exchangeId; 

    @ManyToOne
    private Order_item orderItem;

    private String newSize;

    private String reason;

    private String status;

	public Long getExchangeId() {
		return exchangeId;
	}

	public void setExchangeId(Long exchangeId) {
		this.exchangeId = exchangeId;
	}

	public Order_item getOrderItem() {
		return orderItem;
	}

	public void setOrderItem(Order_item orderItem) {
		this.orderItem = orderItem;
	}

	public String getNewSize() {
		return newSize;
	}

	public void setNewSize(String newSize) {
		this.newSize = newSize;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	} 
    
    

}
