package springStarter.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import springStarter.models.User;
import springStarter.services.CartService;

@ControllerAdvice
public class GlobalControllerAdvice {
	
	@Autowired
    private CartService cartService;

    @ModelAttribute
    public void addCartCount(Model model, HttpSession session){
        User user = (User) session.getAttribute("LoggedInUser");

        if(user != null){
            int cartCount = cartService.getCartCount(user);
            model.addAttribute("cartCount", cartCount);
        }
    }

}
