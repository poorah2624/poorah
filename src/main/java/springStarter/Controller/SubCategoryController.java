package springStarter.Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import springStarter.models.Category;
import springStarter.models.SubCategory;
import springStarter.services.CategoryService;
import springStarter.services.SubCategoryService;

@Controller
public class SubCategoryController {
	
	@Autowired
	private CategoryService categoryService;
		
	@GetMapping("/Add_SubCategory")
	public String addSubCategory(Model model) {

	    model.addAttribute("subcategory", new SubCategory());
	    model.addAttribute("categories", categoryService.getAllCategories());

	    return "admin/Add_SubCategory";
	}
		
		@Autowired
		private SubCategoryService subCategoryService;
		
		@PostMapping("/Add_SubCategory")
		public String saveSubCategory(
				@RequestParam Long categoryId,
		        @RequestParam String subCategoryName,
		        @RequestParam String subCategoryStatus,
		        Model model) {

		    SubCategory subCategory = new SubCategory();

		    subCategory.setSubCategoryName(subCategoryName);
		    subCategory.setSubCategoryStatus(subCategoryStatus);

		  
		    Category category = categoryService.getCategoryById(categoryId);
		    subCategory.setCategory(category);

		    subCategoryService.saveSubCategory(subCategory);

		    return "redirect:/view_SubCategory";
		}
		
		@GetMapping("/view_SubCategory")
		public String view_SubCategory(Model model) {
			
			List<SubCategory> subCategory = subCategoryService.getAllSubCategories(); 

		    model.addAttribute("subcategories", subCategory); 
		    
		    return "admin/view_SubCategory";
		}
		
		@GetMapping("/edit_SubCategory/{subCategoryId}")
		public String edit_SubCategory(@PathVariable Long subCategoryId, Model model) {

			SubCategory subCategory = subCategoryService.getSubCategoryById(subCategoryId);

		    model.addAttribute("subCategory", subCategory);
		    model.addAttribute("categories", categoryService.getAllCategories());

		    return "admin/edit_SubCategory";
		}
		
		@PostMapping("/edit_SubCategory")
		public String updateSubCategory(@ModelAttribute SubCategory subCategory,HttpServletRequest request) {
		    subCategoryService.updateSubCategory(subCategory);
		    System.out.println(request.getParameterMap());
		    
		    return "redirect:/view_SubCategory";
		}
		
		@GetMapping("/DeleteSubCategory/{subCategoryId}")
		public String deleteSubCategory(@PathVariable("subCategoryId") Long subCategoryId) {

		    subCategoryService.deleteSubCategory(subCategoryId);

		    return "redirect:/view_SubCategory";
		}
		
		@GetMapping("/getSubCategories")
		@ResponseBody
		public List<Map<String,Object>> getSubCategories(@RequestParam Long categoryId){

		    List<SubCategory> list = subCategoryService.getSubCategoriesByCategoryId(categoryId);

		    List<Map<String,Object>> result = new ArrayList<>();

		    for(SubCategory s : list){
		        Map<String,Object> map = new HashMap<>();
		        map.put("subCategoryId", s.getSubCategoryId());
		        map.put("subCategoryName", s.getSubCategoryName());
		        result.add(map);
		    }

		    return result;
		}
		 

}
