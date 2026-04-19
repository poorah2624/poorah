package springStarter.models;

import java.time.LocalDateTime;
import java.util.List;

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
@Table(name="addresses")
@Getter
@Setter
public class Address {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long addressId;
    
    @Column(name="fullName", nullable=false)
    private String fullName;
    
    @Column(name="mobile", nullable=false)
    private String mobile;

    @Column(name="houseNo", nullable=false)
    private String houseNo;
    
    @Column(name="area", nullable=false)
    private String area;
    
    @Column(name="landmark", nullable=false)
    private String landmark;
    
    @Column(name="city", nullable=false)
    private String city;
    
    @Column(name="state", nullable=false)
    private String state;
    
    @Column(name="pincode", nullable=false)
    private String pincode;

    @Column(name="addressType", nullable=false)
    private String addressType; // Home, Office

    @Column(name="isDefaultAddress", nullable=false)
    private boolean isDefaultAddress;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}