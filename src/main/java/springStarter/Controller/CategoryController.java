package springStarter.Controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import springStarter.models.Category;
import springStarter.services.CategoryService;

@Controller
public class CategoryController {
	
	@GetMapping("/Add_Category")
	public String Add_Category() {
	    
	    return "admin/Add_Category";
	}
	
	@Autowired
	private CategoryService categoryService;
	
	@PostMapping("/Add_Category")
	public String saveCategory(@RequestParam String categoryName, @RequestParam String categoryStatus, Model model) throws IOException {
		
		Category category = new Category();
		category.setCategoryName(categoryName);
		category.setCategoryStatus(categoryStatus);
		
		categoryService.saveCategory(category);
		
		model.addAttribute("msg","Category added successfully");
	    return "redirect:/view_Category";
	
	}
	
	@GetMapping("/view_Category")
	public String view_Category(Model model) {
		
		List<Category> category = categoryService.getAllCategories(); 

	    model.addAttribute("category", category); 
	    
	    return "admin/view_Category";
	}
	
	@GetMapping("/Edit_Category/{categoryId}")
	public String editCategory(@PathVariable("categoryId") Long categoryId, Model model) {

	    Category category = categoryService.getCategoryById(categoryId);

	    model.addAttribute("category", category);

	    return "admin/Edit_Category";
	}
	
	@PostMapping("/Edit_Category")
	public String updateCategory(@ModelAttribute Category category) {
	    categoryService.updateCategory(category); 
	    return "redirect:/view_Category";
	}
	
	@GetMapping("/Delete_Category/{categoryId}")
	public String deleteCategory(@PathVariable("categoryId") Long categoryId) {

	    categoryService.deleteCategory(categoryId);

	    return "redirect:/view_Category";
	}
}
