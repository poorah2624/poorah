package springStarter.Controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import springStarter.models.Item;
import springStarter.models.Review;
import springStarter.models.User;
import springStarter.services.ItemService;
import springStarter.services.ReviewService;

@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ItemService itemService;
	
	@GetMapping("/Testimonial")
	public String testimonial(Model model) {
		
		List<Review> review = reviewService.getAllReviews(); 

	    model.addAttribute("reviews", review); 
	   
	    return "admin/Testimonial";
	}
	
	@GetMapping("/deleteReview")
    public String delete(@RequestParam Long reviewId) {
        reviewService.deleteReview(reviewId);
        return "redirect:/admin/Testimonial";
    }

    @GetMapping("/activateTestimonial")
    public String activate(@RequestParam Long reviewId) {
        reviewService.activateReview(reviewId);
        return "admin/Testimonial";
    }
    
    @PostMapping("/addReview")
    public String addReview(@RequestParam Long itemId,
                            @RequestParam String message,
                            @RequestParam int rating,
                            @RequestParam(required = false) String guestName,
                            @RequestParam(required = false) String guestEmail,
                            HttpSession session){

        User user = (User) session.getAttribute("LoggedInUser");

        Item item = itemService.getItemById(itemId);

        Review review = new Review();
        review.setMessage(message);
        review.setRating(rating);
        review.setStatus("pending");
        
        review.setItem(item);
        
        if(user != null){
            // Logged-in user
            review.setUser(user);
        } else {
            // Guest user
            review.setGuestName(guestName);
            review.setGuestEmail(guestEmail);
        }

        reviewService.saveReview(review);

        return "redirect:/single/" + itemId;
    }
    
    

}
