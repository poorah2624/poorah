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


@Entity
@Table(name="order_item")
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

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getDiscount() {
		return discount;
	}

	public void setDiscount(BigDecimal discount) {
		this.discount = discount;
	}

	public BigDecimal getFinalPrice() {
		return finalPrice;
	}

	public void setFinalPrice(BigDecimal finalPrice) {
		this.finalPrice = finalPrice;
	}

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	public Orders getOrder() {
		return order;
	}

	public void setOrder(Orders order) {
		this.order = order;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Boolean getIsCancelled() {
		return isCancelled;
	}

	public void setIsCancelled(Boolean isCancelled) {
		this.isCancelled = isCancelled;
	}

	public String getRefundStatus() {
		return refundStatus;
	}

	public void setRefundStatus(String refundStatus) {
		this.refundStatus = refundStatus;
	}

	public Boolean getReturnRequested() {
		return returnRequested;
	}

	public void setReturnRequested(Boolean returnRequested) {
		this.returnRequested = returnRequested;
	}

	public Boolean getExchangeRequested() {
		return exchangeRequested;
	}

	public void setExchangeRequested(Boolean exchangeRequested) {
		this.exchangeRequested = exchangeRequested;
	}

	public String getNewSize() {
		return newSize;
	}

	public void setNewSize(String newSize) {
		this.newSize = newSize;
	}

	public String getReturnStatus() {
		return returnStatus;
	}

	public void setReturnStatus(String returnStatus) {
		this.returnStatus = returnStatus;
	}

	public String getExchangeStatus() {
		return exchangeStatus;
	}

	public void setExchangeStatus(String exchangeStatus) {
		this.exchangeStatus = exchangeStatus;
	}

	public String getReturnPickupDate() {
		return returnPickupDate;
	}

	public void setReturnPickupDate(String returnPickupDate) {
		this.returnPickupDate = returnPickupDate;
	}

	public String getExchangeDeliveryDate() {
		return exchangeDeliveryDate;
	}

	public void setExchangeDeliveryDate(String exchangeDeliveryDate) {
		this.exchangeDeliveryDate = exchangeDeliveryDate;
	}

	public LocalDateTime getCancelledAt() {
		return cancelledAt;
	}

	public void setCancelledAt(LocalDateTime cancelledAt) {
		this.cancelledAt = cancelledAt;
	}

	public Boolean getIsCustom() {
		return isCustom;
	}

	public void setIsCustom(Boolean isCustom) {
		this.isCustom = isCustom;
	}

	public String getCustomImage() {
		return customImage;
	}

	public void setCustomImage(String customImage) {
		this.customImage = customImage;
	}

	public String getTshirtType() {
		return tshirtType;
	}

	public void setTshirtType(String tshirtType) {
		this.tshirtType = tshirtType;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getCustomNote() {
		return customNote;
	}

	public void setCustomNote(String customNote) {
		this.customNote = customNote;
	} 
    
    
    
    
    
    

}
