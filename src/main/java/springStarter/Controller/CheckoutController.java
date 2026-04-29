package springStarter.Controller;

import java.math.BigDecimal;
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
		
		List<Cart> cartItems = cartService.getCartByUser(user);
		
		if(buyNowItemId != null){
	        //  SINGLE PRODUCT checkout
	        Cart temp = cartService.getTempCartItem(buyNowItemId, user);
	        cartItems = Arrays.asList(temp);
	    } else {
	        // normal cart
	        cartItems = cartService.getCartByUser(user);
	    }
		
	    model.addAttribute("cartItems", cartItems);
	    
	    BigDecimal grandTotal = BigDecimal.ZERO;

	    for(Cart cart : cartItems){
	        grandTotal = grandTotal.add(cart.getTotalPrice());
	    }

	    BigDecimal deliveryCharge = new BigDecimal("50");

	    if(grandTotal.compareTo(new BigDecimal("500")) > 0){
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
	                         HttpSession session,
	                         Model model){

	    User user = (User) session.getAttribute("LoggedInUser");

	    if(user == null){
	        return "redirect:/userlogin";
	    }
	   
	    session.removeAttribute("buyNowItemId");
	    session.removeAttribute("isBuyNow");

	 // selected address save
	    model.addAttribute("selectedAddressId", addressId);

	    // cart items
	    List<Cart> cartItems = cartService.getCartByUser(user);
	    model.addAttribute("cartItems", cartItems);

	    // total
	    BigDecimal grandTotal = BigDecimal.ZERO;

	    for(Cart cart : cartItems){
	        grandTotal = grandTotal.add(cart.getTotalPrice());
	    }
	    
	    if(addressId == null){
	        throw new RuntimeException("Address not selected!");
	    }

	    session.setAttribute("grandTotal", grandTotal);
	    session.setAttribute("selectedAddressId", addressId);

	    return "payment?addressId=" + addressId;
	}

}
