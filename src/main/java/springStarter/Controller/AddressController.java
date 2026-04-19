package springStarter.Controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import springStarter.models.Address;
import springStarter.models.Category;
import springStarter.models.User;
import springStarter.services.AddressService;
import springStarter.services.CategoryService;

@Controller
public class AddressController {
	
	@Autowired
	private AddressService addressService;
	
	@Autowired
	private CategoryService categoryService;
	
	@GetMapping("/address")
	public String addressPage(Model model, HttpSession session){
		
		List<Category> categories = categoryService.getAllCategories();

	    model.addAttribute("categories", categories);

	    User user = (User) session.getAttribute("LoggedInUser");
	    if(user == null){
	        return "redirect:/userlogin";
	    }

	    List<Address> list = addressService.getByUser(user);
	    System.out.println("SIZE = " + list.size());

	    model.addAttribute("addresses", list);

	    return "address";
	}
	
	@GetMapping("/addAddress")
	public String addAddress(Model model, HttpSession session)
	{
		List<Category> categories = categoryService.getAllCategories();

	    model.addAttribute("categories", categories);

	    User user = (User) session.getAttribute("LoggedInUser");
	    if(user == null){
	        return "redirect:/userlogin";
	    }
	    
		return "addAddress";
	}
	
	
	@PostMapping("/saveAddress")
	public String saveAddress(@ModelAttribute Address address, 
	                          HttpSession session,
	                          @RequestParam(value="isDefaultAddress", required=false) String isDefault){

	    User user = (User) session.getAttribute("LoggedInUser");

	    address.setUser(user);

	    // checkbox handle
	    address.setDefaultAddress(isDefault != null);

	    addressService.save(address);

	    return "redirect:/address";
	}
	
	@GetMapping("/editAddress/{id}")
	public String editAddress(@PathVariable Long id, Model model){

	    Address address = addressService.getById(id);

	    model.addAttribute("address", address);

	    return "editAddress"; // JSP page
	}
	
	@PostMapping("/updateAddress")
	public String updateAddress(@ModelAttribute Address address,
	                            HttpSession session,
	                            @RequestParam(value="isDefaultAddress", required=false) String isDefault){

	    User user = (User) session.getAttribute("LoggedInUser");

	    address.setUser(user);

	    // checkbox fix
	    address.setDefaultAddress(isDefault != null);

	    addressService.update(address);

	    return "redirect:/address";
	}
	
	@GetMapping("/deleteAddress/{addressId}")
	public String deleteAddress(@PathVariable("addressId") Long addressId) {
	    addressService.deleteAddress(addressId);
	    return "redirect:/address";
	}

}
