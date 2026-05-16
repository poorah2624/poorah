package springStarter.models;

import javax.persistence.*;


@Entity
@Table(name = "itemVariant")
public class ItemVariant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long variantId;

    private String variantColor;

    private String variantSize;

    private Integer variantStock;

    private String variantImage;

    private String variantSku;

    @ManyToOne
    @JoinColumn(name = "item_id")
    private Item item;

	public Long getVariantId() {
		return variantId;
	}

	public void setVariantId(Long variantId) {
		this.variantId = variantId;
	}

	public String getVariantColor() {
		return variantColor;
	}

	public void setVariantColor(String variantColor) {
		this.variantColor = variantColor;
	}

	public String getVariantSize() {
		return variantSize;
	}

	public void setVariantSize(String variantSize) {
		this.variantSize = variantSize;
	}

	public Integer getVariantStock() {
		return variantStock;
	}

	public void setVariantStock(Integer variantStock) {
		this.variantStock = variantStock;
	}

	public String getVariantImage() {
		return variantImage;
	}

	public void setVariantImage(String variantImage) {
		this.variantImage = variantImage;
	}

	public String getVariantSku() {
		return variantSku;
	}

	public void setVariantSku(String variantSku) {
		this.variantSku = variantSku;
	}

	public Item getItem() {
		return item;
	}

	public void setItem(Item item) {
		this.item = item;
	}

	
    
    

    
}