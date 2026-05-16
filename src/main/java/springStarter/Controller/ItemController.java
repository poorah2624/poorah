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
	        
	        @RequestParam(value="stockS[]", required=false) String[] stockS,
	        @RequestParam(value="stockM[]", required=false) String[] stockM,
	        @RequestParam(value="stockL[]", required=false) String[] stockL,
	        @RequestParam(value="stockXL[]", required=false) String[] stockXL,

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

	            String sStock = (stockS != null && stockS.length > i && !stockS[i].trim().isEmpty()) ? stockS[i].trim() : "0";
	            String mStock = (stockM != null && stockM.length > i && !stockM[i].trim().isEmpty()) ? stockM[i].trim() : "0";
	            String lStock = (stockL != null && stockL.length > i && !stockL[i].trim().isEmpty()) ? stockL[i].trim() : "0";
	            String xlStock = (stockXL != null && stockXL.length > i && !stockXL[i].trim().isEmpty()) ? stockXL[i].trim() : "0";

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
	        
	        @RequestParam(value = "stockS[]", required = false) String[] stockS,
	        @RequestParam(value = "stockM[]", required = false) String[] stockM,
	        @RequestParam(value = "stockL[]", required = false) String[] stockL,
	        @RequestParam(value = "stockXL[]", required = false) String[] stockXL,
	        
	        @RequestParam(value = "variantImage[]", required = false) MultipartFile[] variantImages
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
	        // Note: Agar files empty hain, toh existingItem ka image already retained hai.
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    // Basic Form Formatted parameters direct transfer to existing persistent entity
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

	            String sStock = (stockS != null && stockS.length > i && !stockS[i].trim().isEmpty()) ? stockS[i].trim() : "0";
	            String mStock = (stockM != null && stockM.length > i && !stockM[i].trim().isEmpty()) ? stockM[i].trim() : "0";
	            String lStock = (stockL != null && stockL.length > i && !stockL[i].trim().isEmpty()) ? stockL[i].trim() : "0";
	            String xlStock = (stockXL != null && stockXL.length > i && !stockXL[i].trim().isEmpty()) ? stockXL[i].trim() : "0";

	            String combinedStockString = "S:" + sStock + ",M:" + mStock + ",L:" + lStock + ",XL:" + xlStock;
	            variant.setVariantStock(combinedStockString);

	            // IMAGE LOGIC
	         // IMAGE LOGIC
	            String imageUrl = "";
	            if (variantImages != null && variantImages.length > i && !variantImages[i].isEmpty()) {
	                // Agar user ne nayi file select ki hai
	                Map uploadResult = cloudinary.uploader().upload(
	                        variantImages[i].getBytes(),
	                        ObjectUtils.asMap("folder", "poorah/variants")
	                );
	                imageUrl = (String) uploadResult.get("secure_url");
	            } else {
	                // FIX: Bina kisi extra List.of() ke direct existingItem ke variants par loop chalayein
	                if (variantIds != null && variantIds.size() > i && variantIds.get(i) != null) {
	                    Long currentId = variantIds.get(i);
	                    for (ItemVariant oldV : existingItem.getVariants()) {
	                        if (oldV.getVariantId().equals(currentId)) {
	                            imageUrl = oldV.getVariantImage(); // Purani image mil gayi
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

	    // Service layer ko managed object pass karenge update ke liye
	    itemService.updateItem(existingItem);

	    return "redirect:/view_Item";
	}
	
	@GetMapping("/Delete_Item/{itemId}")
	public String deleteItem(@PathVariable("itemId") Long itemId) {
	    itemService.deleteItem(itemId);
	    return "redirect:/view_Item";
	}
}