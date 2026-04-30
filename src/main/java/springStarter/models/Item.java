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

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="item")
@Getter
@Setter
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
	
	

}
