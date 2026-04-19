package springStarter.models;

import java.math.BigDecimal;

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
@Table(name="cart")
@Getter
@Setter
public class Cart {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long cartId;
	
	@Column(name="quantity")
	private int quantity;

	@Column(name="totalPrice")
    private BigDecimal totalPrice;
	
	@Column(name="size")
	private String size;

	@Column(name="age")
	private String age;
	
	@ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "item_id")
    private Item item;
    
    private Boolean isCustom = false;
    
    private String customImage;
    
    private String tshirtType;
    
    private String color;
    
    private String gender;
    
    private String customNote;

}
