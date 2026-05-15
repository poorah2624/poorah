package springStarter.models;

import javax.persistence.*;

import lombok.*;

@Entity
@Table(name = "item_variant")
@Getter
@Setter
public class ItemVariant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long variantId;

    private String color;

    private String size;

    private Integer stock;

    private String image;

    private String sku;

    @ManyToOne
    @JoinColumn(name = "item_id")
    private Item item;

    
}