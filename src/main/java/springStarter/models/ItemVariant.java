package springStarter.models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class ItemVariant {

    @Id
    @GeneratedValue
    private Long variantId;

    @ManyToOne
    private Item item;

    private String color;

    private String size;

    private Integer stock;

    private String image;

    private String sku;
}