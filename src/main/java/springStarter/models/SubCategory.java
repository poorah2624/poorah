package springStarter.models;

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
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@Entity
@Table(name="subCategory")
public class SubCategory {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long subCategoryId;
	
	@Column(name="subCategoryName", nullable=false)
	private String subCategoryName;
	
	@Column(name="subCategoryStatus", nullable=false)
	private String subCategoryStatus;
	
	@ManyToOne
    @JoinColumn(name="categoryId")
	 @JsonIgnoreProperties("subCategories")
    private Category category;
	
	@OneToMany(mappedBy = "subCategory", cascade = CascadeType.ALL)
	private List<Item> items;

	public Long getSubCategoryId() {
		return subCategoryId;
	}

	public void setSubCategoryId(Long subCategoryId) {
		this.subCategoryId = subCategoryId;
	}

	public String getSubCategoryName() {
		return subCategoryName;
	}

	public void setSubCategoryName(String subCategoryName) {
		this.subCategoryName = subCategoryName;
	}

	public String getSubCategoryStatus() {
		return subCategoryStatus;
	}

	public void setSubCategoryStatus(String subCategoryStatus) {
		this.subCategoryStatus = subCategoryStatus;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public List<Item> getItems() {
		return items;
	}

	public void setItems(List<Item> items) {
		this.items = items;
	}
	
	
	

}
