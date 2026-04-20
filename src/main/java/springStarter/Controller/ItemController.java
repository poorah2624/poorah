package springStarter.Controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import springStarter.models.Category;
import springStarter.models.Item;
import springStarter.models.SubCategory;
import springStarter.services.CategoryService;
import springStarter.services.ItemService;
import springStarter.services.SubCategoryService;

@Controller
public class ItemController {
	
	@Autowired
	ItemService itemService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private SubCategoryService subCategoryService;
	
	@GetMapping("/Add_Item")
	public String addItem(Model model)
	{
		model.addAttribute("item", new Item());
		model.addAttribute("subcategories", subCategoryService.getAllSubCategories());
	    model.addAttribute("categories", categoryService.getAllCategories());
	    
	    
		return "admin/Add_Item";
	}
	
	/*@GetMapping("/getSubCategories")
	@ResponseBody
	public List<SubCategory> getSubCategories(@RequestParam Long categoryId) {
	    return subCategoryService.getSubCategoriesByCategoryId(categoryId);
	}*/
	
	@PostMapping("/Add_Item")
	public String add_Item(@RequestParam Long categoryId, @RequestParam Long subCategoryId,
			               @RequestParam("itemName") String itemName,  @RequestParam("itemImage") MultipartFile[] files,
			               @RequestParam("itemPrice") BigDecimal itemPrice, @RequestParam("stock") String stock,
			               @RequestParam("discount") BigDecimal discount, @RequestParam("featuredProduct") String featuredProduct,
			               @RequestParam("itemDesc") String itemDesc, 
			               @RequestParam("itemDesc") String keyFeatures,
			               @RequestParam("status") String status,
			               @RequestParam(value="size", required=false) String[] size,
			               @RequestParam(value="age", required=false) String[] age,
			               @RequestParam(value="weight", required=false) String weight,
			               @RequestParam("fabric") String fabric,
			               @RequestParam("gender") String gender,
	                        Model model) throws IOException {
		
		 // upload folder
		 /*String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";*/
        String uploadDir = "uploads/";

	    File dir = new File(uploadDir);
	    if(!dir.exists()) dir.mkdirs();
	    
	    StringBuilder imageNames = new StringBuilder();
	    
	    for(MultipartFile file : files){
	    
		if(!file.isEmpty()) {
			 String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();

	            file.transferTo(new File(uploadDir + "/" + fileName));

	            imageNames.append(fileName).append(",");
	    }
	    }

	   

	    // unique file name
	    //String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();

	   // file.transferTo(new File(uploadDir + "/" + fileName));
	    
	    String finalImages = imageNames.toString().replaceAll(",$", "");
		
		Item item = new Item();
		
		
		
		String skuId = "SKU-" + System.currentTimeMillis();
		item.setSkuId(skuId.substring(0, Math.min(skuId.length(), 50)));

		item.setItemName(itemName);
		item.setItemImage(finalImages);
		item.setItemPrice(itemPrice);
		item.setStock(stock);
		item.setDiscount(discount);
		item.setFeaturedProduct(featuredProduct);
		item.setItemDesc(itemDesc);
		item.setKeyFeatures(keyFeatures);
		item.setStatus(status);
		
		if(size != null){
            String sizes = String.join(",", size);
            item.setSize(sizes);
        }

        if(age != null){
            String ages = String.join(",", age);
            item.setAge(ages);
        }

		item.setWeight(weight);
		item.setFabric(fabric);
		item.setGender(gender);
		
		Category category = categoryService.getCategoryById(categoryId);
	    item.setCategory(category);
	    
	    SubCategory subCategory = subCategoryService.getSubCategoryById(subCategoryId);
	    item.setSubCategory(subCategory);
	    
	    item.setInCart(true);
	    item.setInCart(false);

	    itemService.saveItem(item);
		
		return "redirect:/view_Item";
	
	}
	
	@GetMapping("/view_Item")
	public String view_Item(Model model) {
		
		List<Item> item = itemService.getAllItems(); 

	    model.addAttribute("items", item); 
	    
	    return "admin/view_Item";
	}
	
	@GetMapping("/edit_Item/{itemId}")
	public String edit_Item(@PathVariable Long itemId, Model model) {

		Item item = itemService.getItemById(itemId);

	    model.addAttribute("item", item);
	    model.addAttribute("categories", categoryService.getAllCategories());
	    model.addAttribute("subcategories", subCategoryService.getAllSubCategories());

	    return "admin/edit_Item";
	}
	
	@PostMapping("/edit_Item")
	public String updateItem(@ModelAttribute Item item,
	                         @RequestParam("file") MultipartFile[] files) {

		 /*String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";*/
        String uploadDir = "uploads/";

	    StringBuilder imageNames = new StringBuilder();

	    try {

	        for (MultipartFile file : files) {

	            if (!file.isEmpty()) {

	                String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();

	                file.transferTo(new File(uploadDir + fileName));

	                imageNames.append(fileName).append(",");
	            }
	        }

	        if (imageNames.length() > 0) {
	            String finalImages = imageNames.toString().replaceAll(",$", "");
	            item.setItemImage(finalImages);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    itemService.updateItem(item);

	    return "redirect:/view_Item";
	}
	
	@GetMapping("/Delete_Item/{itemId}")
	public String deleteItem(@PathVariable("itemId") Long itemId) {
	    itemService.deleteItem(itemId);
	    return "redirect:/view_Item";
	}
	
	

}
