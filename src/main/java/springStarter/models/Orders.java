package springStarter.models;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.Getter;
import lombok.Setter;


@Entity
@Table(name="orders")
@Getter
@Setter
public class Orders {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@Column(name="orderNumber", nullable=false)
    private String orderNumber;   // ORD12345
    
	@Column(name="quantity", nullable=false)
    private int quantity;
    
	@Column(name="discountedPrice", nullable=false)
    private BigDecimal discountedPrice;

	@Column(name="totalAmount", nullable=false)
    private BigDecimal totalAmount;

	@Column(name="status", nullable=false)
    private String status;  // Pending, Shipped, Delivered
	
	@Column(name="refundAmount")
	private BigDecimal refundAmount;

	@Column(name="refundStatus")
	private String refundStatus;

	@Column(name="paymentStatus", nullable=false)
    private String paymentStatus = "Pending"; // Paid / COD

	@Column(name="paymentMethod", nullable=false)
    private String paymentMethod; // COD, UPI, Card
	
	@Transient
	private boolean canCancel;

	@Transient
	private boolean canReturn;

	@Transient
	private boolean canExchange;

    private LocalDateTime orderDate;

    @PrePersist
    public void onCreate(){
        orderDate = LocalDateTime.now();
    }
    
    private LocalDateTime packedDate;
    private LocalDateTime shippedDate;
    private LocalDateTime deliveredDate;

    private String estimatedDeliveryDate;

    // Order belongs to user
    @ManyToOne
    @JoinColumn(name="user_id")
    private User user;

    // Order delivered to selected address
    @ManyToOne
    @JoinColumn(name="address_Id")
    private Address address;

    //  order → multiple products
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private List<Order_item> items;
    
    @OneToOne(mappedBy = "order", cascade = CascadeType.ALL)
    private Payment payment;
    
    @Column(name = "delivery_charge")
    private BigDecimal deliveryCharge;
	
    
	private String category;
	
	public String getCategory() { return category; }
	public void setCategory(String category) { this.category = category; }

}
