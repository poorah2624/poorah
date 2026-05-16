package springStarter.Controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import springStarter.models.Category;
import springStarter.models.Item;
import springStarter.models.ItemVariant;
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
	
	@Autowired
	private Cloudinary cloudinary;
	
	@PostMapping("/Add_Item")
	public String add_Item(
	        @RequestParam Long categoryId,
	        @RequestParam Long subCategoryId,
	        @RequestParam("itemName") String itemName,
	        @RequestParam("itemImage") MultipartFile[] files,
	        @RequestParam("itemPrice") BigDecimal itemPrice,
	        @RequestParam(value="stock", required=false) String stock,
	        @RequestParam("discount") BigDecimal discount,
	        @RequestParam("featuredProduct") String featuredProduct,
	        @RequestParam("itemDesc") String itemDesc,
	        @RequestParam("keyFeatures") String keyFeatures,
	        @RequestParam("status") String status,
	        @RequestParam(value="weight", required=false) String weight,
	        @RequestParam(value="fabric", required=false) String fabric,
	        @RequestParam(value="gender", required=false) String gender,
	        @RequestParam(value="color[]", required=false) List<String> colors,
	        @RequestParam Map<String, String> allParams,
	        @RequestParam(value="variantImage[]", required=false) MultipartFile[] variantImages,
	        Model model
	) throws IOException {

	    // ================= MAIN IMAGES =================
	    StringBuilder imageUrls = new StringBuilder();

	    for (MultipartFile file : files) {
	        if (!file.isEmpty()) {
	            Map uploadResult = cloudinary.uploader().upload(
	                    file.getBytes(),
	                    ObjectUtils.asMap("folder", "poorah/products")
	            );
	            imageUrls.append(uploadResult.get("secure_url")).append(",");
	        }
	    }

	    String finalImages = imageUrls.toString().replaceAll(",$", "");

	    Item item = new Item();

	    String skuId = "SKU-" + System.currentTimeMillis();
	    item.setSkuId(skuId.substring(0, Math.min(skuId.length(), 50)));

	    item.setItemName(itemName);
	    item.setItemImage(finalImages);
	    item.setItemPrice(itemPrice);

	    item.setDiscount(discount);
	    item.setFeaturedProduct(featuredProduct);
	    item.setItemDesc(itemDesc);
	    item.setKeyFeatures(keyFeatures);
	    item.setStatus(status);
	    item.setWeight(weight);
	    item.setFabric(fabric);
	    item.setGender(gender);
	    item.setStock(stock);

	    item.setCategory(categoryService.getCategoryById(categoryId));
	    item.setSubCategory(subCategoryService.getSubCategoryById(subCategoryId));

	    item.setInCart(false);

	    // ================= VARIANTS =================
	    List<ItemVariant> variants = new ArrayList<>();
	    String[] sizes = {"S","M","L","XL"};

	    if (colors != null) {

	        for (int i = 0; i < colors.size(); i++) {

	            String color = colors.get(i);

	            if (color == null || color.trim().isEmpty())
	                continue;

	            // color image
	            String imageUrl = "";

	            if (variantImages != null &&
	                variantImages.length > i &&
	                !variantImages[i].isEmpty()) {

	                Map uploadResult = cloudinary.uploader().upload(
	                        variantImages[i].getBytes(),
	                        ObjectUtils.asMap("folder", "poorah/variants")
	                );

	                imageUrl = (String) uploadResult.get("secure_url");
	            }

	            // sizes loop
	            for (int j = 0; j < sizes.length; j++) {

	                String size = sizes[j];

	                int index = i * sizes.length + j;

	                int stockVal = 0;

	                try {
	                    String[] stockArr = allParams.get("stock[" + size + "][]").split(",");

	                    if (stockArr.length > i && !stockArr[i].isEmpty()) {
	                        stockVal = Integer.parseInt(stockArr[i].trim());
	                    }
	                } catch (Exception e) {
	                    stockVal = 0;
	                }

	                if (stockVal > 0) {

	                    ItemVariant v = new ItemVariant();
	                    v.setVariantColor(color);
	                    v.setVariantSize(size);
	                    v.setVariantStock(stockVal);
	                    v.setVariantImage(imageUrl);

	                    v.setVariantSku("VAR-" + System.currentTimeMillis() + "-" + i + "-" + j);

	                    v.setItem(item);

	                    variants.add(v);
	                }
	            }
	        }
	    }

	    item.setVariants(variants);

	    itemService.saveItem(item);

	    return "redirect:/view_Item";
	}
	
	private int getStock(Map<String, String> params, String size, int index) {
	    try {
	        String key = "stock[" + size + "][]";
	        String value = params.get(key);

	        if (value == null) return 0;

	        // value comes like comma separated or single depending browser
	        String[] arr = value.split(",");

	        if (arr.length > index) {
	            return Integer.parseInt(arr[index].trim());
	        }

	    } catch (Exception e) {
	        return 0;
	    }

	    return 0;
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
	                         @RequestParam("file") MultipartFile[] files,
	                         @RequestParam(value = "variantId[]", required = false)
	                         List<Long> variantIds,

	                         @RequestParam(value = "color[]", required = false)
	                         List<String> colors,

	                         @RequestParam(value = "variantSize[]", required = false)
	                         List<String> variantSizes,

	                         @RequestParam(value = "variantStock[]", required = false)
	                         List<Integer> variantStocks,

	                         @RequestParam(value = "variantImage[]", required = false)
	                         MultipartFile[] variantImages) throws IOException {

	    Item existingItem = itemService.getItemById(item.getItemId());

	    // MAIN PRODUCT IMAGE
	    try {

	        StringBuilder imageUrls = new StringBuilder();

	        for (MultipartFile file : files) {

	            if (!file.isEmpty()) {

	                Map uploadResult = cloudinary.uploader().upload(
	                        file.getBytes(),
	                        ObjectUtils.asMap("folder", "poorah/products")
	                );

	                String imageUrl =
	                        (String) uploadResult.get("secure_url");

	                imageUrls.append(imageUrl).append(",");
	            }
	        }

	        // new main image uploaded
	        if (imageUrls.length() > 0) {

	            String finalImages =
	                    imageUrls.toString().replaceAll(",$", "");

	            item.setItemImage(finalImages);

	        } else {

	            // old image preserve
	            item.setItemImage(existingItem.getItemImage());
	        }

	    } catch (Exception e) {

	        e.printStackTrace();
	    }

	    // VARIANTS
	    List<ItemVariant> variants = new ArrayList<>();

	    String[] sizes = {"S","M","L","XL"};

	    if (colors != null) {

	        for (int i = 0; i < colors.size(); i++) {

	            String color = colors.get(i);

	            if (color == null || color.trim().isEmpty())
	                continue;

	            for (int j = 0; j < sizes.length; j++) {

	                String size = sizes[j];

	                ItemVariant variant = new ItemVariant();

	                if (variantIds != null && variantIds.size() > i) {
	                    variant.setVariantId(variantIds.get(i));
	                }

	                variant.setVariantColor(color);
	                variant.setVariantSize(size);

	                if (variantStocks != null && variantStocks.size() > i) {
	                    variant.setVariantStock(variantStocks.get(i));
	                }

	                // image
	                String imageUrl = "";

	                if (variantImages != null &&
	                    variantImages.length > i &&
	                    !variantImages[i].isEmpty()) {

	                    Map uploadResult = cloudinary.uploader().upload(
	                            variantImages[i].getBytes(),
	                            ObjectUtils.asMap("folder", "poorah/variants")
	                    );

	                    imageUrl = (String) uploadResult.get("secure_url");
	                } else {

	                    for (ItemVariant old : existingItem.getVariants()) {
	                        if (old.getVariantColor().equals(color)) {
	                            imageUrl = old.getVariantImage();
	                            break;
	                        }
	                    }
	                }

	                variant.setVariantImage(imageUrl);
	                variant.setItem(item);

	                variants.add(variant);
	            }
	        }
	    }

	    item.setVariants(variants);

	    itemService.updateItem(item);

	    return "redirect:/view_Item";
	}
	
	@GetMapping("/Delete_Item/{itemId}")
	public String deleteItem(@PathVariable("itemId") Long itemId) {
	    itemService.deleteItem(itemId);
	    return "redirect:/view_Item";
	}
	
	

}
