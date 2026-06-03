package springStarter.Controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import springStarter.models.Address;
import springStarter.models.Cart;
import springStarter.models.Category;
import springStarter.models.ContactDetails;
import springStarter.models.User;
import springStarter.services.AddressService;
import springStarter.services.CartService;
import springStarter.services.CategoryService;
import springStarter.services.ContactDetailsService;

@Controller
public class CheckoutController {
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private AddressService addressService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private ContactDetailsService cDetailsService;
	
	@GetMapping("/checkout")
	public String checkout(Model model, HttpSession session) {
		
		User user = (User) session.getAttribute("LoggedInUser");

	    if(user == null){
	        return "redirect:/userlogin";
	    }
		
		List<Address> addresses = addressService.getByUser(user);
		model.addAttribute("addresses", addresses);
		
		Long buyNowItemId = (Long) session.getAttribute("buyNowItemId");
		List<Cart> cartItems = new ArrayList<>();
		
		if(buyNowItemId != null){
	      
			String size = (String) session.getAttribute("buyNowSize");
	        Cart temp = cartService.getTempCartItem(buyNowItemId, user, size);
	        if(temp == null){
	          
	            session.removeAttribute("buyNowItemId");
	            session.removeAttribute("buyNowSize");
	            return "redirect:/cart";
	        }
	        cartItems.add(temp);
	    } else {
	       
	        cartItems = cartService.getCartByUser(user);
	    }
		
	    model.addAttribute("cartItems", cartItems);
	 
	    BigDecimal grandTotal = BigDecimal.ZERO;

	    for(Cart cart : cartItems){
	    	if(cart.getTotalPrice() != null){
	            grandTotal = grandTotal.add(cart.getTotalPrice());
	    	}
	    }

	    BigDecimal deliveryCharge = new BigDecimal("50");

	    if(grandTotal.compareTo(new BigDecimal("500")) >= 0 || grandTotal.compareTo(BigDecimal.ZERO) == 0){
	        deliveryCharge = BigDecimal.ZERO;
	    }

	    BigDecimal finalAmount = grandTotal.add(deliveryCharge);

	    model.addAttribute("grandTotal", grandTotal);
	    model.addAttribute("deliveryCharge", deliveryCharge);
	    model.addAttribute("finalAmount", finalAmount);
		
		List<Category> categories = categoryService.getAllCategories();
	    model.addAttribute("categories", categories);
	    
	    ContactDetails cDetails = cDetailsService.getContactDetails();
		model.addAttribute("cDetails", cDetails);
	    
	    return "checkout";
	}
	
	@PostMapping("/payment")
	public String placeOrder(@RequestParam Long addressId,
	                         @RequestParam(value = "noReturnDiscount", defaultValue = "NO") String noReturnDiscount,
	                         HttpSession session,
	                         Model model){

	    User user = (User) session.getAttribute("LoggedInUser");

	    if(user == null){
	        return "redirect:/userlogin";
	    }
	   
	    if(addressId == null){
	        throw new RuntimeException("Address not selected!");
	    }

	    Long buyNowItemId = (Long) session.getAttribute("buyNowItemId");
	    List<Cart> cartItems = new ArrayList<>();

	    if (buyNowItemId != null) {
	        String size = (String) session.getAttribute("buyNowSize");
	        Cart temp = cartService.getTempCartItem(buyNowItemId, user, size);
	        if (temp != null) {
	            cartItems.add(temp);
	        }
	    } else {
	        cartItems = cartService.getCartByUser(user);
	    }

	    String[] discountFlags = noReturnDiscount.split(",");

	    BigDecimal grandTotal = BigDecimal.ZERO;

	    for (int i = 0; i < cartItems.size(); i++) {
	        Cart cart = cartItems.get(i);
	        if (cart.getTotalPrice() != null) {
	            BigDecimal itemRowTotal = cart.getTotalPrice();

	            if (i < discountFlags.length && "YES".equalsIgnoreCase(discountFlags[i].trim())) {
	               
	                BigDecimal itemDiscount = itemRowTotal.multiply(new BigDecimal("0.08"));
	                itemRowTotal = itemRowTotal.subtract(itemDiscount);
	            }

	            grandTotal = grandTotal.add(itemRowTotal);
	        }
	    }

	
	    BigDecimal deliveryCharge = (grandTotal.compareTo(BigDecimal.valueOf(500)) > 0 || grandTotal.compareTo(BigDecimal.ZERO) == 0) 
	                                ? BigDecimal.ZERO : BigDecimal.valueOf(50);
	    
	    BigDecimal finalAmount = grandTotal.add(deliveryCharge).setScale(0, RoundingMode.HALF_UP);
	    grandTotal = grandTotal.setScale(0, RoundingMode.HALF_UP);

	
	    session.setAttribute("grandTotal", grandTotal);
	    session.setAttribute("deliveryCharge", deliveryCharge);
	    session.setAttribute("finalAmount", finalAmount);
	    session.setAttribute("selectedAddressId", addressId);
	    session.setAttribute("noReturnDiscount", noReturnDiscount); 

	    return "redirect:/payment";
	}

}
