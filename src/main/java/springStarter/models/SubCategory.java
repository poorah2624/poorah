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

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="subCategory")
@Getter
@Setter
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

}
