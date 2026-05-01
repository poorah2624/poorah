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
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Transient;



@Entity
@Table(name="item")
public class Item {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long itemId;
	
	@Column(name="itemName", nullable=false)
	private String itemName;
	
	@Column(name="itemImage", nullable=false)
	private String itemImage;
	
	@Column(name="itemPrice", nullable=false)
	private BigDecimal itemPrice;
	
	@Column(name="stock", nullable=false)
	private String stock;
	
	@Column(name="discount", nullable=false)
	private BigDecimal discount;
	
	@Column(name="featuredProduct", nullable=false)
	private String featuredProduct;
	
	@Column(name="itemDesc", nullable=false, length=5000)
	private String itemDesc;
	
	@Column(name="keyFeatures", nullable=false, length=5000)
	private String KeyFeatures;
	
	@Column(name="status", nullable=false)
	private String status;
	
	@Column(name="size", nullable=true)
	private String size;
	
	@Column(name="age", nullable=true)
	private String age;
	
	@Column(name="weight", nullable=true)
	private String weight;
	
	@Column(name="fabric", nullable=false)
	private String fabric;
	
	@Column(name="skuId", nullable=false, unique=true)
	private String skuId;
	
	@Column(name="gender", nullable=false)
	private String gender; 
	
	private LocalDateTime createdAt;

    @PrePersist
    public void onCreate(){
        createdAt = LocalDateTime.now();
    }
    
	@ManyToOne
    @JoinColumn(name="categoryId")
	private Category category;
	
	@ManyToOne
    @JoinColumn(name="subCategoryId")
	private SubCategory subCategory;
	
	@Transient
	private boolean inCart;
	
	
	

	
	@Transient
	public BigDecimal getDiscountedPrice() {
	    try {
	        BigDecimal price = this.itemPrice;
	        BigDecimal discountPercent = this.discount;

	        BigDecimal discountAmount = price.multiply(discountPercent)
	                .divide(new BigDecimal("100"));

	        return price.subtract(discountAmount);
	    } catch (Exception e) {
	        return this.itemPrice;
	    }
	}





	public Long getItemId() {
		return itemId;
	}





	public void setItemId(Long itemId) {
		this.itemId = itemId;
	}





	public String getItemName() {
		return itemName;
	}





	public void setItemName(String itemName) {
		this.itemName = itemName;
	}





	public String getItemImage() {
		return itemImage;
	}





	public void setItemImage(String itemImage) {
		this.itemImage = itemImage;
	}





	public BigDecimal getItemPrice() {
		return itemPrice;
	}





	public void setItemPrice(BigDecimal itemPrice) {
		this.itemPrice = itemPrice;
	}





	public String getStock() {
		return stock;
	}





	public void setStock(String stock) {
		this.stock = stock;
	}





	public BigDecimal getDiscount() {
		return discount;
	}





	public void setDiscount(BigDecimal discount) {
		this.discount = discount;
	}





	public String getFeaturedProduct() {
		return featuredProduct;
	}





	public void setFeaturedProduct(String featuredProduct) {
		this.featuredProduct = featuredProduct;
	}





	public String getItemDesc() {
		return itemDesc;
	}





	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}





	public String getKeyFeatures() {
		return KeyFeatures;
	}





	public void setKeyFeatures(String keyFeatures) {
		KeyFeatures = keyFeatures;
	}





	public String getStatus() {
		return status;
	}





	public void setStatus(String status) {
		this.status = status;
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





	public String getWeight() {
		return weight;
	}





	public void setWeight(String weight) {
		this.weight = weight;
	}





	public String getFabric() {
		return fabric;
	}





	public void setFabric(String fabric) {
		this.fabric = fabric;
	}





	public String getSkuId() {
		return skuId;
	}





	public void setSkuId(String skuId) {
		this.skuId = skuId;
	}





	public String getGender() {
		return gender;
	}





	public void setGender(String gender) {
		this.gender = gender;
	}





	public LocalDateTime getCreatedAt() {
		return createdAt;
	}





	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}





	public Category getCategory() {
		return category;
	}





	public void setCategory(Category category) {
		this.category = category;
	}





	public SubCategory getSubCategory() {
		return subCategory;
	}





	public void setSubCategory(SubCategory subCategory) {
		this.subCategory = subCategory;
	}





	public boolean isInCart() {
		return inCart;
	}





	public void setInCart(boolean inCart) {
		this.inCart = inCart;
	}
	
	
	
	
	

}
