package springStarter.models;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;



@Entity
@Table(name="order_item")
@Getter
@Setter
public class Order_item {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

	@Column(name="quantity", nullable=false)
    private Integer quantity;
	
	private String size;
    private String age;

	@Column(name="price", nullable=false)
    private BigDecimal price;
	
	@Column(name="discount", nullable=false)
    private BigDecimal discount;
	
	@Column(name="finalPrice", nullable=false)
    private BigDecimal finalPrice;

    // product mapping
    @ManyToOne
    @JoinColumn(name="item_Id")
    private Item item;

    @ManyToOne
    @JoinColumn(name="order_id")
    private Orders order;
    
    @Column(name="status")
    private String status; 
    // Pending, Cancelled, Delivered, Return Requested, Exchange Requested

    @Column(name="isCancelled")
    private Boolean isCancelled;

    @Column(name="refundStatus")
    private String refundStatus; // Pending, Done
    
    private Boolean returnRequested =false;
    
    private Boolean exchangeRequested;
    
    private String newSize;

    private String returnStatus;   // Requested, Approved, Rejected
    
    private String exchangeStatus; // Requested, Approved, Shipped, Delivered

    private String returnPickupDate;
    
    private String exchangeDeliveryDate;
    
    private LocalDateTime cancelledAt;
    
    private Boolean isCustom = false;

    private String customImage;
    
    private String tshirtType; 
    
    private String color;  
    
    private String gender;
    
    private String customNote; 
    
    
    

}
