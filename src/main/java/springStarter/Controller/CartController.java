package springStarter.Controller;

import java.io.File;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import springStarter.models.Cart;
import springStarter.models.Category;
import springStarter.models.ContactDetails;
import springStarter.models.Item;
import springStarter.models.User;
import springStarter.services.CartService;
import springStarter.services.CategoryService;
import springStarter.services.ContactDetailsService;
import springStarter.services.ItemService;

@Controller
public class CartController {
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private ItemService itemService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private ContactDetailsService cDetailsService;
	
	@GetMapping("/cart")
	public String addToCart(HttpSession session, Model model){
		
		 List<Category> categories = categoryService.getAllCategories();

		    model.addAttribute("categories", categories);
		    
		    ContactDetails cDetails = cDetailsService.getContactDetails();
			model.addAttribute("cDetails", cDetails);

		User user = (User) session.getAttribute("LoggedInUser");

	    if(user == null){
	        return "redirect:/userlogin";
	    }
	    
	    List<Cart> cartItems = cartService.getCartByUser(user);
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
	    
	    return "cart";
	}
	
	@GetMapping("/addToCart")
	public String addToCart(@RequestParam Long itemId, 
			@RequestParam(required = false) String size,
            @RequestParam(required = false) String age,
            HttpSession session){

	    User user = (User) session.getAttribute("LoggedInUser");

	    if(user == null){
	        session.setAttribute("redirectUrl", "/addToCart?itemId=" + itemId);
	        return "redirect:/userlogin";
	    }

	    Item item = itemService.getItemById(itemId);
	    
	    if(item.getCategory().getCategoryName().equalsIgnoreCase("Kids") && age == null){
	        return "redirect:/single/" + itemId;
	    }

	    if(!item.getCategory().getCategoryName().equalsIgnoreCase("Kids") && size == null){
	        return "redirect:/single/" + itemId;
	    }

	    cartService.addToCart(user, item, size, age);
	    
	    

	    return "redirect:/single/" + itemId;
	}
	
	@PostMapping("/UpdateQuantity")
	public String updateQuantity(@RequestParam Long itemId,
	                             @RequestParam int quantity,
	                             HttpSession session){

	    User user = (User) session.getAttribute("LoggedInUser");

	    if(user == null){
	        return "redirect:/userLogin";
	    }

	    cartService.updateQuantity(user, itemId, quantity);

	    return "redirect:/cart";
	}
	
	@GetMapping("/DeleteCart/{cartId}")
	public String deleteCart(@PathVariable("cartId") Long cartId) {
	    cartService.deleteCart(cartId);
	    return "redirect:/cart";
	}
	
	@GetMapping("/emptyCart")
	public String emptyCart(HttpSession session){
	    User user = (User) session.getAttribute("LoggedInUser");
	    cartService.clearCart(user);
	    return "redirect:/cart";
	}
	
	@GetMapping("/buyNow")
	public String buyNow(@RequestParam Long itemId,
	                     HttpSession session){

	    User user = (User) session.getAttribute("LoggedInUser");

	    if(user == null){
	        return "redirect:/userlogin";
	    }

	    session.setAttribute("buyNowItemId", itemId);

	    return "redirect:/checkout";
	}
	
	
	@PostMapping("/addCustomToCart")
	public String addCustomToCart(
	        @RequestParam("image") MultipartFile file,
	        @RequestParam String size,
	        @RequestParam String color,
	        @RequestParam String tshirtType,
	        @RequestParam String gender,
	        @RequestParam(required = false) String customNote,
	        HttpSession session) {

	    User user = (User) session.getAttribute("LoggedInUser");
	    if (user == null) {
	        return "redirect:/userlogin";
	    }

	    try {
	        if (file.isEmpty()) {
	            System.out.println("⚠️ File empty hai");
	            return "redirect:/customDesign";
	        }

	        String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads/";

	        File dir = new File(uploadDir);
	        if (!dir.exists()) {
	            dir.mkdirs();
	        }
	        
	        String originalName = file.getOriginalFilename();
	        String fileName = System.currentTimeMillis() + "_" + originalName.replaceAll("\\s+", "_");

	        File destination = new File(dir, fileName);
	        file.transferTo(destination);

	        System.out.println("✅ File saved at: " + destination.getAbsolutePath());

	        cartService.addCustomToCart(user, fileName, size, color, tshirtType, gender, customNote);

	    } catch (Exception e) {
	        e.printStackTrace();
	        return "redirect:/customDesign";
	    }

	    return "redirect:/cart";
	}
}
