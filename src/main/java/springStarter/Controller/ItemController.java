package springStarter.Controller;

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

import springStarter.models.Item;
import springStarter.models.ItemVariant;
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
	
	@Autowired
	private Cloudinary cloudinary;
	
	@GetMapping("/Add_Item")
	public String addItem(Model model) {
		model.addAttribute("item", new Item());
		model.addAttribute("subcategories", subCategoryService.getAllSubCategories());
	    model.addAttribute("categories", categoryService.getAllCategories());
		return "admin/Add_Item";
	}
	
	@PostMapping("/Add_Item")
	public String add_Item(
	        @RequestParam Long categoryId,
	        @RequestParam Long subCategoryId,
	        @RequestParam("itemName") String itemName,
	        @RequestParam("itemImage") MultipartFile[] files,
	        @RequestParam("itemPrice") BigDecimal itemPrice,
	        @RequestParam("stock") String stock,
	        @RequestParam("discount") BigDecimal discount,
	        @RequestParam("featuredProduct") String featuredProduct,
	        @RequestParam("itemDesc") String itemDesc,
	        @RequestParam("keyFeatures") String keyFeatures,
	        @RequestParam("status") String status,

	        @RequestParam(value="weight", required=false) String weight,
	        @RequestParam(value="fabric", required=false) String fabric,
	        @RequestParam(value="gender", required=false) String gender,

	        @RequestParam(value="color[]", required=false) List<String> colors,
	        @RequestParam(value="variantImage[]", required=false) MultipartFile[] variantImages,
	        
	        javax.servlet.http.HttpServletRequest request,

	        Model model
	) throws IOException {

	    // ================= 1. MAIN IMAGES UPLOAD =================
	    StringBuilder imageUrls = new StringBuilder();
	    for (MultipartFile file : files) {
	        if (file != null && !file.isEmpty()) {
	            Map uploadResult = cloudinary.uploader().upload(
	                    file.getBytes(),
	                    ObjectUtils.asMap("folder", "poorah/products")
	            );
	            imageUrls.append(uploadResult.get("secure_url")).append(",");
	        }
	    }
	    String finalImages = imageUrls.toString().replaceAll(",$", "");

	    // ================= 2. CREATE ITEM OBJECT =================
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
	    item.setStock(stock != null && !stock.trim().isEmpty() ? stock : "0");

	    item.setCategory(categoryService.getCategoryById(categoryId));
	    item.setSubCategory(subCategoryService.getSubCategoryById(subCategoryId));
	    item.setInCart(false);

	    // ================= 3. VARIANTS PROCESSING (1 row per color) =================
	    List<ItemVariant> variants = new ArrayList<>();

	    if (colors != null && !colors.isEmpty()) {
	        long baseTimestamp = System.currentTimeMillis(); 

	        for (int i = 0; i < colors.size(); i++) {
	            String color = colors.get(i);
	            if (color == null || color.trim().isEmpty()) {
	                continue;
	            }

	            String imageUrl = "";
	            if (variantImages != null && variantImages.length > i && !variantImages[i].isEmpty()) {
	                Map uploadResult = cloudinary.uploader().upload(
	                        variantImages[i].getBytes(),
	                        ObjectUtils.asMap("folder", "poorah/variants")
	                );
	                imageUrl = (String) uploadResult.get("secure_url");
	            }

	            String sStock = request.getParameter("stockS_" + i);
	            String mStock = request.getParameter("stockM_" + i);
	            String lStock = request.getParameter("stockL_" + i);
	            String xlStock = request.getParameter("stockXL_" + i);
	            
	            sStock = (sStock != null && !sStock.trim().isEmpty()) ? sStock.trim() : "0";
	            mStock = (mStock != null && !mStock.trim().isEmpty()) ? mStock.trim() : "0";
	            lStock = (lStock != null && !lStock.trim().isEmpty()) ? lStock.trim() : "0";
	            xlStock = (xlStock != null && !xlStock.trim().isEmpty()) ? xlStock.trim() : "0";
	            
	            String combinedStockString = "S:" + sStock + ",M:" + mStock + ",L:" + lStock + ",XL:" + xlStock;

	            ItemVariant v = new ItemVariant();
	            v.setVariantColor(color);
	            v.setVariantStock(combinedStockString); 
	            v.setVariantImage(imageUrl);
	            v.setVariantSku("VAR-" + baseTimestamp + "-C" + i); 
	            v.setItem(item);

	            variants.add(v);
	        }
	    }

	    item.setVariants(variants);
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
	public String updateItem(
	        @ModelAttribute Item item,
	        @RequestParam("file") MultipartFile[] files,
	        
	        @RequestParam(value = "variantId[]", required = false) List<Long> variantIds,
	        @RequestParam(value = "color[]", required = false) List<String> colors,
	        @RequestParam(value = "variantImage[]", required = false) MultipartFile[] variantImages,
	        
	        // HIGHLIGHT: Indexed parameter inputs ko extract karne ke liye HttpServletRequest ko add kiya
	        javax.servlet.http.HttpServletRequest request
	) throws IOException {

	    Item existingItem = itemService.getItemById(item.getItemId());

	    // ================= 1. MAIN PRODUCT IMAGE UPDATE =================
	    try {
	        StringBuilder imageUrls = new StringBuilder();
	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	                Map uploadResult = cloudinary.uploader().upload(
	                        file.getBytes(),
	                        ObjectUtils.asMap("folder", "poorah/products")
	                );
	                String imageUrl = (String) uploadResult.get("secure_url");
	                imageUrls.append(imageUrl).append(",");
	            }
	        }

	        if (imageUrls.length() > 0) {
	            String finalImages = imageUrls.toString().replaceAll(",$", "");
	            existingItem.setItemImage(finalImages);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    // Basic Form Formatted Fields Sync
	    existingItem.setItemName(item.getItemName());
	    existingItem.setSkuId(item.getSkuId());
	    existingItem.setItemPrice(item.getItemPrice());
	    existingItem.setDiscount(item.getDiscount());
	    existingItem.setFeaturedProduct(item.getFeaturedProduct());
	    existingItem.setItemDesc(item.getItemDesc());
	    existingItem.setKeyFeatures(item.getKeyFeatures());
	    existingItem.setStatus(item.getStatus());
	    existingItem.setWeight(item.getWeight());
	    existingItem.setFabric(item.getFabric());
	    existingItem.setGender(item.getGender());
	    existingItem.setStock(item.getStock());
	    existingItem.setCategory(item.getCategory());
	    existingItem.setSubCategory(item.getSubCategory());

	    // ================= 2. VARIANTS UPDATE (1 Row Per Color) =================
	    List<ItemVariant> variants = new ArrayList<>();
	    long baseTimestamp = System.currentTimeMillis();

	    if (colors != null) {
	        for (int i = 0; i < colors.size(); i++) {
	            String color = colors.get(i);
	            if (color == null || color.trim().isEmpty())
	                continue;

	            ItemVariant variant = new ItemVariant();

	            if (variantIds != null && variantIds.size() > i) {
	                variant.setVariantId(variantIds.get(i));
	            }

	            variant.setVariantColor(color);

	            // HIGHLIGHT: Params arrays hata kar humne explicit template query logic map kar diya
	            String sStock = request.getParameter("stockS_" + i);
	            String mStock = request.getParameter("stockM_" + i);
	            String lStock = request.getParameter("stockL_" + i);
	            String xlStock = request.getParameter("stockXL_" + i);

	            // Safe fallback validation 
	            sStock = (sStock != null && !sStock.trim().isEmpty()) ? sStock.trim() : "0";
	            mStock = (mStock != null && !mStock.trim().isEmpty()) ? mStock.trim() : "0";
	            lStock = (lStock != null && !lStock.trim().isEmpty()) ? lStock.trim() : "0";
	            xlStock = (xlStock != null && !xlStock.trim().isEmpty()) ? xlStock.trim() : "0";

	            String combinedStockString = "S:" + sStock + ",M:" + mStock + ",L:" + lStock + ",XL:" + xlStock;
	            variant.setVariantStock(combinedStockString);

	            // IMAGE LOGIC
	            String imageUrl = "";
	            if (variantImages != null && variantImages.length > i && !variantImages[i].isEmpty()) {
	                Map uploadResult = cloudinary.uploader().upload(
	                        variantImages[i].getBytes(),
	                        ObjectUtils.asMap("folder", "poorah/variants")
	                );
	                imageUrl = (String) uploadResult.get("secure_url");
	            } else {
	                if (variantIds != null && variantIds.size() > i && variantIds.get(i) != null) {
	                    Long currentId = variantIds.get(i);
	                    for (ItemVariant oldV : existingItem.getVariants()) {
	                        if (oldV.getVariantId().equals(currentId)) {
	                            imageUrl = oldV.getVariantImage(); 
	                            break;
	                        }
	                    }
	                }
	            }

	            variant.setVariantImage(imageUrl);
	            
	            // SKU Logic
	            if (variantIds != null && variantIds.size() > i && variantIds.get(i) != null) {
	                for (ItemVariant oldV : existingItem.getVariants()) {
	                    if (oldV.getVariantId().equals(variantIds.get(i))) {
	                        variant.setVariantSku(oldV.getVariantSku());
	                        break;
	                    }
	                }
	            }
	            if (variant.getVariantSku() == null) {
	                variant.setVariantSku("VAR-" + baseTimestamp + "-C" + i);
	            }

	            variant.setItem(existingItem);
	            variants.add(variant);
	        }
	    }

	    existingItem.setVariants(variants);

	    // Sync update to repo via service layer
	    itemService.updateItem(existingItem);

	    return "redirect:/view_Item";
	}
	
	@GetMapping("/Delete_Item/{itemId}")
	public String deleteItem(@PathVariable("itemId") Long itemId) {
	    itemService.deleteItem(itemId);
	    return "redirect:/view_Item";
	}
}