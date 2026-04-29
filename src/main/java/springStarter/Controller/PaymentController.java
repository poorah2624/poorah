package springStarter.Controller;


import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;

import springStarter.models.Cart;
import springStarter.models.Category;
import springStarter.models.ContactDetails;
import springStarter.models.User;
import springStarter.services.CartService;
import springStarter.services.CategoryService;
import springStarter.services.ContactDetailsService;
import springStarter.services.OrderService;

@Controller
public class PaymentController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private ContactDetailsService cDetailsService;
	
	@GetMapping("/payment")
	public String paymentPage(@RequestParam(required = false) Long addressId,
	                          HttpSession session,
	                          Model model){

	    User user = (User) session.getAttribute("LoggedInUser");

	    if(user == null){
	        return "redirect:/userlogin";
	    }

	    // ❗ address validation (IMPORTANT)
	    Long sessionAddressId = (Long) session.getAttribute("selectedAddressId");

	    if(addressId == null && sessionAddressId == null){
	        return "redirect:/checkout";
	    }

	    if(addressId == null){
	        addressId = sessionAddressId;
	    }

	    model.addAttribute("selectedAddressId", addressId);

	    // categories
	    List<Category> categories = categoryService.getAllCategories();
	    model.addAttribute("categories", categories);

	    // contact details
	    ContactDetails cDetails = cDetailsService.getContactDetails();
	    model.addAttribute("cDetails", cDetails);

	    // cart items
	    List<Cart> cartItems = new ArrayList<>();

	    Long buyNowItemId = (Long) session.getAttribute("buyNowItemId");

	    if(buyNowItemId != null){

	        Cart temp = cartService.getTempCartItem(buyNowItemId, user);

	        if(temp != null){
	            cartItems.add(temp);
	        } else {
	            throw new RuntimeException("Buy Now item not found");
	        }

	    } else {

	        cartItems = cartService.getCartByUser(user);

	        if(cartItems.isEmpty()){
	            throw new RuntimeException("Cart is empty");
	        }
	    }

	    model.addAttribute("cartItems", cartItems);

	    // total calculation
	    BigDecimal grandTotal = BigDecimal.ZERO;

	    for(Cart cart : cartItems){
	        if(cart.getTotalPrice() != null){
	            grandTotal = grandTotal.add(cart.getTotalPrice());
	        }
	    }

	    BigDecimal deliveryCharge = new BigDecimal("50");

	    if(grandTotal.compareTo(new BigDecimal("500")) > 0){
	        deliveryCharge = BigDecimal.ZERO;
	    }

	    BigDecimal finalAmount = grandTotal.add(deliveryCharge);

	    model.addAttribute("grandTotal", grandTotal);
	    model.addAttribute("deliveryCharge", deliveryCharge);
	    model.addAttribute("finalAmount", finalAmount);

	    return "payment";
	}
	
	@PostMapping("/orderPlaced")
	public String placeOrder(@RequestParam Long addressId,
	                         @RequestParam String paymentMethod,
	                         @RequestParam(required = false) String razorpayPaymentId,
	                         @RequestParam(required = false) String razorpayOrderId,
	                         HttpSession session,
	                         Model model,
	                         RedirectAttributes redirectAttributes){
       try {
	    User user = (User) session.getAttribute("LoggedInUser");
	    if(user == null){
	        return "redirect:/userlogin";
	    }
	    
	 // selected address save
	    model.addAttribute("selectedAddressId", addressId);


	    orderService.placeOrder(user, addressId, paymentMethod, session, razorpayPaymentId, razorpayOrderId);
	    
	    session.removeAttribute("buyNowItemId");


	    return "redirect:/orderSuccess";
       }
	    
	    catch (Exception e) {

	        
			redirectAttributes.addFlashAttribute("errorMsg", e.getMessage());

	        return "redirect:/orderFailed";
	    }
	}
	
	@PostMapping("/create-order")
	@ResponseBody
	public String createOrder(@RequestParam BigDecimal amount) {

	    try {
	        RazorpayClient client = new RazorpayClient("rzp_test_SXlvfKVfbzo45f", "dSXBfnLljl8vNuWK6KUnrBlO");

	        JSONObject options = new JSONObject();

	        int finalAmount = amount.multiply(new BigDecimal(100)).intValue();

	        options.put("amount", finalAmount);
	        options.put("currency", "INR");
	        options.put("receipt", "order_" + System.currentTimeMillis());

	        Order order = client.orders.create(options);

	        return order.toString();

	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error";
	    }
	}
	
	

}
