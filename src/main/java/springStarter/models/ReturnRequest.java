package springStarter.models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;



@Entity
@Table(name="returnRequest")
public class ReturnRequest {
	


	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long returnId;

    @ManyToOne
    private Order_item orderItem;

    private String reason;

    private String status; 
    
    private String returnPickupDate;

	public Long getReturnId() {
		return returnId;
	}

	public void setReturnId(Long returnId) {
		this.returnId = returnId;
	}

	public Order_item getOrderItem() {
		return orderItem;
	}

	public void setOrderItem(Order_item orderItem) {
		this.orderItem = orderItem;
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

	public String getReturnPickupDate() {
		return returnPickupDate;
	}

	public void setReturnPickupDate(String returnPickupDate) {
		this.returnPickupDate = returnPickupDate;
	}
    
    
    

}
