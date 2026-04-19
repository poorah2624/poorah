package springStarter.Controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import springStarter.models.Item;
import springStarter.models.Review;
import springStarter.models.SubCategory;
import springStarter.models.User;
import springStarter.repository.ItemRepo;
import springStarter.models.Address;
import springStarter.models.Category;
import springStarter.models.ContactDetails;
import springStarter.services.AddressService;
import springStarter.services.CartService;
import springStarter.services.CategoryService;
import springStarter.services.ContactDetailsService;
import springStarter.services.SubCategoryService;
import springStarter.services.ItemService;
import springStarter.services.ReviewService;

@Controller
public class ProductController {

	@Autowired
	private ItemService itemService;

	@Autowired
	private SubCategoryService subCategoryService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private AddressService addressService;

	@ModelAttribute("categories")
	public List<Category> getCategories() {
		return categoryService.getAllCategories();
	}
	
	@Autowired
	private ContactDetailsService cDetailsService;

	@GetMapping("/products/{subCategoryId}")
	public String products(@PathVariable Long subCategoryId, Model model, HttpSession session) {
		
		User user = (User) session.getAttribute("LoggedInUser");

	    if(user != null){
	        Address address = addressService.getDefaultAddress(user);
	        model.addAttribute("defaultAddress", address);
	        
	    }

		List<Item> items = itemService.getItemsBySubCategoryAndActiveStatus(subCategoryId);

		model.addAttribute("items", items);

		SubCategory subCategory = subCategoryService.getSubCategoryById(subCategoryId);

		model.addAttribute("subCategory", subCategory);
		model.addAttribute("category", subCategory.getCategory());
		
		List<Category> categories = categoryService.getAllCategories();

	    model.addAttribute("categories", categories);

		ContactDetails cDetails = cDetailsService.getContactDetails();
		model.addAttribute("cDetails", cDetails);

		return "products";
	}

	@GetMapping("/products2")
	public String products2(Model model, HttpSession session) {
		
		User user = (User) session.getAttribute("LoggedInUser");

	    if(user != null){
	        Address address = addressService.getDefaultAddress(user);
	        model.addAttribute("defaultAddress", address);
	        
	    }

		List<Item> items = itemService.getAllItems();
		model.addAttribute("items", items);
		model.addAttribute("items", itemService.getActiveItems());
		
		ContactDetails cDetails = cDetailsService.getContactDetails();
		model.addAttribute("cDetails", cDetails);
		
		List<Category> categories = categoryService.getAllCategories();

	    model.addAttribute("categories", categories);
		
		return "products2";
	}

	@GetMapping("/products3/category/{categoryId}")
	public String productsByCategory(@PathVariable Long categoryId, Model model, HttpSession session) {
		
		User user = (User) session.getAttribute("LoggedInUser");
		
		if(user != null){
	        Address address = addressService.getDefaultAddress(user);
	        model.addAttribute("defaultAddress", address);
	        
	    }

		List<Item> items = itemService.getItemsByCategoryAndActiveStatus(categoryId);
		model.addAttribute("items", items);
		
		ContactDetails cDetails = cDetailsService.getContactDetails();
		model.addAttribute("cDetails", cDetails);
		
		List<Category> categories = categoryService.getAllCategories();

	    model.addAttribute("categories", categories);

		return "products3";
	}

	@GetMapping("/single/{itemId}")
	public String single(@PathVariable Long itemId, Model model, HttpSession session) {

		Item item = itemService.getItemById(itemId);

		User user = (User) session.getAttribute("LoggedInUser");

		if (user != null) {
			boolean exists = cartService.existsByUserAndItem(user, itemId);
			item.setInCart(exists);
			Address address = addressService.getDefaultAddress(user);
	        model.addAttribute("defaultAddress", address);
		}

		List<Review> reviews = reviewService.getApprovedReviewsByItem(itemId);

		model.addAttribute("item", item);

		Double avgRating = reviewService.getAvgRating(itemId);
		Long totalReviews = reviewService.getReviewCount(itemId);

		model.addAttribute("avgRating", avgRating);
		model.addAttribute("totalReviews", totalReviews);

		model.addAttribute("reviews", reviews);
		
		ContactDetails cDetails = cDetailsService.getContactDetails();
		model.addAttribute("cDetails", cDetails);
		
		List<Category> categories = categoryService.getAllCategories();

	    model.addAttribute("categories", categories);

		return "single";
	}
	
	@Autowired
	private ItemRepo itemRepo;
	
	@GetMapping("/products/gender/{gender}")
	public String getByGender(@PathVariable String gender, Model model){
	    List<Item> items = itemRepo.findByGender(gender);
	    model.addAttribute("items", items);
	    
	    ContactDetails cDetails = cDetailsService.getContactDetails();
		model.addAttribute("cDetails", cDetails);
		
		List<Category> categories = categoryService.getAllCategories();

	    model.addAttribute("categories", categories);
	    
	    return "products";
	}

}
