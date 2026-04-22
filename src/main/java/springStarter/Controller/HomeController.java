package springStarter.Controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import springStarter.models.Banner;
import springStarter.models.Category;
import springStarter.models.ContactDetails;
import springStarter.models.Gallery;
import springStarter.models.Item;
import springStarter.models.SocialLinks;
import springStarter.models.User;
import springStarter.repository.UserRepository;
import springStarter.services.BannerService;
import springStarter.services.CategoryService;
import springStarter.services.ContactDetailsService;
import springStarter.services.GalleryService;
import springStarter.services.ItemService;
import springStarter.services.SocialLinkService;
import springStarter.services.SubCategoryService;
import springStarter.services.UserService;

@Controller
public class HomeController {

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private BannerService bannerService;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private SubCategoryService subCategoryService;

	@Autowired
	private ItemService itemService;
	
	@Autowired
	private GalleryService galleryService;
	
	@Autowired
	private ContactDetailsService cDetailsService;
	
	@Autowired
	private SocialLinkService socialLinkService;

	@GetMapping("/")
	public String home(Model model, HttpServletResponse response) {
		List<Banner> banner = bannerService.getAllBanners();
		model.addAttribute("banner", banner);

		List<Category> categories = categoryService.getAllCategories();
		model.addAttribute("categories", categories);

		Map<Long, List<Item>> categoryItems = new HashMap<>();

		for (Category cat : categories) {
			List<Item> items = itemService.getLatestItems(cat.getCategoryId());
			categoryItems.put(cat.getCategoryId(), items);
		}

		model.addAttribute("categoryItems", categoryItems);
		
		List<Gallery> gallery = galleryService.getAllGallery();
		model.addAttribute("gallery", gallery);
		
		ContactDetails cDetails = cDetailsService.getContactDetails();
		model.addAttribute("cDetails", cDetails);
		
		List<SocialLinks> social = socialLinkService.getAllSocialLinks();
		model.addAttribute("social", social);
		
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	    response.setHeader("Pragma", "no-cache");
	    response.setDateHeader("Expires", 0);


		return "home";
	}

	@GetMapping("/home")
	public String homeForClick(Model model, HttpSession session) {
		List<Banner> banner = bannerService.getAllBanners();
		model.addAttribute("banner", banner);

		List<Category> categories = categoryService.getAllCategories();

		model.addAttribute("categories", categories);

		Map<Long, List<Item>> categoryItems = new HashMap<>();

		for (Category cat : categories) {
			List<Item> items = itemService.getLatestItems(cat.getCategoryId());
			categoryItems.put(cat.getCategoryId(), items);
		}

		model.addAttribute("categoryItems", categoryItems);

		User user = (User) session.getAttribute("LoggedInUser");

		if (user == null) {
			return "redirect:/userlogin";
		}
		
		List<Gallery> gallery = galleryService.getAllGallery();
		model.addAttribute("gallery", gallery);
		
		ContactDetails cDetails = cDetailsService.getContactDetails();
		model.addAttribute("cDetails", cDetails);
		
		List<SocialLinks> social = socialLinkService.getAllSocialLinks();
		model.addAttribute("social", social);

		return "home";
	}

	@ModelAttribute("categories")
	public List<Category> getCategories() {
		return categoryService.getAllCategories();
	}

	@Autowired
	private UserService userService;

	private static final String PASSWORD_REGEX = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@#$%!^&*]).{8,}$";

	@PostMapping("/register")
	public String registerUser(@RequestParam String userName, @RequestParam String userEmail,
			@RequestParam String userPassword, @RequestParam String confirmPassword, @RequestParam String userMobile,
			Model model) {

		if (!userPassword.matches(PASSWORD_REGEX)) {
			model.addAttribute("Error",
					"Password must be at least 8 characters and include uppercase, lowercase, number and special character. Sign up again.");
			return "userlogin";
		}
		// password match check
		if (!userPassword.equals(confirmPassword)) {
			model.addAttribute("Error", "Password and confirm password don't match. Sign up again.");
			return "userlogin";
		}

		try {
			// call service
			userService.registerUser(userName, userEmail, userPassword, userMobile);

			model.addAttribute("msg", "Registration successfull, Please login..");
		} catch (RuntimeException e) {
			model.addAttribute("Error", e.getMessage());
			return "userlogin";
		}

		return "userlogin";

	}

	@PostMapping("/dologin")
	public String login(@RequestParam String userEmail, @RequestParam String userPassword, Model model,
			HttpSession session) {
		List<Banner> banner = bannerService.getAllBanners();
		model.addAttribute("banner", banner);
		
		List<Category> categories = categoryService.getAllCategories();
		model.addAttribute("categories", categories);
		
		List<SocialLinks> social = socialLinkService.getAllSocialLinks();
		model.addAttribute("social", social);
		
		ContactDetails cDetails = cDetailsService.getContactDetails();
		model.addAttribute("cDetails", cDetails);

		Map<Long, List<Item>> categoryItems = new HashMap<>();

		for (Category cat : categories) {
			List<Item> items = itemService.getLatestItems(cat.getCategoryId());
			categoryItems.put(cat.getCategoryId(), items);
		}

		model.addAttribute("categoryItems", categoryItems);

		User user = userService.login(userEmail, userPassword);
		if (user == null) {
			model.addAttribute("Error", "Invalid email or password.");
			return "userlogin";
		}
		session.setAttribute("LoggedInUser", user);

		// redirect logic
		String redirectUrl = (String) session.getAttribute("redirectUrl");

		if (redirectUrl != null) {
			session.removeAttribute("redirectUrl"); // clean session
			return "redirect:" + redirectUrl;
		}
		return "home";
	}

	@GetMapping("/userlogin")
	public String userlogin() {

		return "userlogin";
	}

	@GetMapping("/userProfile")
	public String userProfile(HttpSession session) {

		User user = (User) session.getAttribute("LoggedInUser");

		if (user == null) {
			return "redirect:/userlogin";
		}

		return "userProfile";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/home";
	}

	@GetMapping("/editUser")
	public String editProfile(HttpSession session, Model model) {

		User loggedUser = (User) session.getAttribute("LoggedInUser");

		if (loggedUser == null) {
			return "userlogin"; // session expired safety
		}

		model.addAttribute("user", loggedUser);

		return "editUser";
	}

	@PostMapping("/updateProfile")
	public String updateProfile(@ModelAttribute User user, HttpSession session) {

		User sessionUser = (User) session.getAttribute("LoggedInUser");

		if (sessionUser == null) {
			return "redirect:/login";
		}

		user.setId(sessionUser.getId());

		User updatedUser = userService.updateUser(user);
		session.setAttribute("LoggedInUser", updatedUser);

		return "userProfile";
	}

	@GetMapping("/changeUserPass")
	public String changePassword() {
		return "changeUserPass";
	}

	@PostMapping("/changeUserPassword")
	public String changePassword(@RequestParam String userPassword, @RequestParam String newPassword,
			HttpSession session, Model model) {
		System.out.println("Change");

		User loggedUser = (User) session.getAttribute("LoggedInUser");

		boolean changed = userService.changePassword(loggedUser.getId(), userPassword, newPassword);

		if (changed) {
			model.addAttribute("msg", "Password changed");
			return "userProfile";
		} else {
			model.addAttribute("Error", "Try again.");
			return "changeUserPass";
		}
	}

	@PostMapping("/forgotPassword")
	public String forgotPassword(@RequestParam String userEmail, Model model) {
		boolean sent = userService.sendPasswordResetLink(userEmail);

		if (sent) {
			model.addAttribute("msg", "Reset link sent to your email!");
		} else {
			model.addAttribute("Error", "Email not registered!");
		}
		return "userlogin";
	}

	// Reset password page
	@GetMapping("/resetPassword")
	public String showResetPasswordForm(@RequestParam String token, Model model) {
		User user = userService.validatePasswordResetToken(token);
		if (user == null) {
			model.addAttribute("Error", "Invalid or expired token!");
			return "Error";
		}
		model.addAttribute("token", token);
		return "resetPassword";
	}

	// Reset password submit
	@PostMapping("/resetPassword")
	public String resetPassword(@RequestParam String token, @RequestParam String userPassword,
			@RequestParam String confirmPassword, Model model) {
		if (!userPassword.equals(confirmPassword)) {
			model.addAttribute("Error", "Passwords do not match!");
			model.addAttribute("token", token);
			return "resetPassword";
		}

		boolean success = userService.resetPassword(token, userPassword);
		if (success) {
			model.addAttribute("msg", "Password reset successfully! You can now login.");
			return "userlogin";
		} else {
			model.addAttribute("Error", "Invalid or expired token! Try Again.");
			return "Error";
		}
	}

	@GetMapping("/AllUsers")
	public String allUsers(Model model) {
		List<User> users = userRepo.findAll();

		model.addAttribute("users", users);
		return "admin/AllUsers";
	}

	@GetMapping("/allUsersTable")
	public String allUsersTable(Model model) {
		List<User> users = userRepo.findAll();

		model.addAttribute("users", users);
		return "admin/allUsersTable";
	}

	@GetMapping("/calendar")
	public String calendar() {
		return "admin/calendar";
	}
	
	@GetMapping("/customDesign")
	public String customDesign() {
		return "customDesign";
	}
	
	@Autowired
	private Cloudinary cloudinary;
	
	@PostMapping("/custom-order")
	public String customOrder(
	        @RequestParam("designImage") MultipartFile file,
	        @RequestParam String size,
	        @RequestParam String type,
	        @RequestParam String color,
	        HttpSession session,
	        RedirectAttributes redirectAttributes) {

	    try {
	    	String imageUrl = null;

	    	Map uploadResult = cloudinary.uploader().upload(
	    	        file.getBytes(),
	    	        ObjectUtils.asMap("folder", "poorah/custom-orders", "resource_type", "auto")
	    	);

	    	imageUrl = (String) uploadResult.get("secure_url");

	        // TODO: save in DB (CustomOrder entity)

	        redirectAttributes.addFlashAttribute("msg", "Design uploaded successfully!");

	    } catch (Exception e) {
	        e.printStackTrace();
	        redirectAttributes.addFlashAttribute("msg", "Upload failed!");
	    }

	    return "redirect:/home";
	}
	
	

}
