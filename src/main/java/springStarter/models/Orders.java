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



@Entity
@Table(name="orders")
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
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public BigDecimal getDiscountedPrice() {
		return discountedPrice;
	}
	public void setDiscountedPrice(BigDecimal discountedPrice) {
		this.discountedPrice = discountedPrice;
	}
	public BigDecimal getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public BigDecimal getRefundAmount() {
		return refundAmount;
	}
	public void setRefundAmount(BigDecimal refundAmount) {
		this.refundAmount = refundAmount;
	}
	public String getRefundStatus() {
		return refundStatus;
	}
	public void setRefundStatus(String refundStatus) {
		this.refundStatus = refundStatus;
	}
	public String getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	public String getPaymentMethod() {
		return paymentMethod;
	}
	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}
	public boolean isCanCancel() {
		return canCancel;
	}
	public void setCanCancel(boolean canCancel) {
		this.canCancel = canCancel;
	}
	public boolean isCanReturn() {
		return canReturn;
	}
	public void setCanReturn(boolean canReturn) {
		this.canReturn = canReturn;
	}
	public boolean isCanExchange() {
		return canExchange;
	}
	public void setCanExchange(boolean canExchange) {
		this.canExchange = canExchange;
	}
	public LocalDateTime getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(LocalDateTime orderDate) {
		this.orderDate = orderDate;
	}
	public LocalDateTime getPackedDate() {
		return packedDate;
	}
	public void setPackedDate(LocalDateTime packedDate) {
		this.packedDate = packedDate;
	}
	public LocalDateTime getShippedDate() {
		return shippedDate;
	}
	public void setShippedDate(LocalDateTime shippedDate) {
		this.shippedDate = shippedDate;
	}
	public LocalDateTime getDeliveredDate() {
		return deliveredDate;
	}
	public void setDeliveredDate(LocalDateTime deliveredDate) {
		this.deliveredDate = deliveredDate;
	}
	public String getEstimatedDeliveryDate() {
		return estimatedDeliveryDate;
	}
	public void setEstimatedDeliveryDate(String estimatedDeliveryDate) {
		this.estimatedDeliveryDate = estimatedDeliveryDate;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Address getAddress() {
		return address;
	}
	public void setAddress(Address address) {
		this.address = address;
	}
	public List<Order_item> getItems() {
		return items;
	}
	public void setItems(List<Order_item> items) {
		this.items = items;
	}
	public Payment getPayment() {
		return payment;
	}
	public void setPayment(Payment payment) {
		this.payment = payment;
	}
	public BigDecimal getDeliveryCharge() {
		return deliveryCharge;
	}
	public void setDeliveryCharge(BigDecimal deliveryCharge) {
		this.deliveryCharge = deliveryCharge;
	}
	
	
	

}
