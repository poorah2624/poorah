package springStarter.services;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import springStarter.models.Category;
import springStarter.models.Item;
import springStarter.models.ItemVariant;
import springStarter.repository.CategoryRepo;
import springStarter.repository.ItemRepo;

@Transactional
@Service
public class ItemService {
	
	@Autowired
	private ItemRepo itemRepo;
	
	@Autowired
	private CategoryRepo categoryRepo;

	public void saveItem(Item item) {
		
		
		itemRepo.save(item);
		
	}

	public List<Item> getAllItems() {
		return itemRepo.findAll();
	}

	public Item getItemById(Long itemId) {
		 return itemRepo.findById(itemId)
		            .orElseThrow(() -> new RuntimeException("Item not found"));
	}

	public void updateItem(Item item) {
	    Item existingItem = itemRepo.findById(item.getItemId())
	            .orElseThrow(() -> new RuntimeException("Item not found"));
	    
	    if(item.getSkuId() != null &&
	       itemRepo.existsBySkuId(item.getSkuId()) &&
	       !existingItem.getSkuId().equals(item.getSkuId())){
	        throw new RuntimeException("SKU already exists");
	    }

	    // Basic Fields Update
	    existingItem.setSkuId(item.getSkuId());
	    existingItem.setItemName(item.getItemName());
	    existingItem.setItemPrice(item.getItemPrice());
	    existingItem.setDiscount(item.getDiscount());
	    existingItem.setFeaturedProduct(item.getFeaturedProduct());
	    existingItem.setItemDesc(item.getItemDesc());
	    existingItem.setKeyFeatures(item.getKeyFeatures());
	    existingItem.setStatus(item.getStatus());
	    
	    existingItem.setWeight(item.getWeight());
	    existingItem.setFabric(item.getFabric());
	    existingItem.setGender(item.getGender());
	    
	    existingItem.setCategory(item.getCategory());
	    existingItem.setSubCategory(item.getSubCategory());

	    if(item.getItemImage() != null && !item.getItemImage().isEmpty()) {
	        existingItem.setItemImage(item.getItemImage());
	    }
	    
	    // ================= VARIANTS RE-MAPPING (SAFE WAY) =================
	    // Direct clear karne ke bajay existing list ko clean karke re-populate karenge
	    if (existingItem.getVariants() != null) {
	        existingItem.getVariants().clear();
	    }

	    if(item.getVariants() != null){
	        for(ItemVariant variant : item.getVariants()){
	            variant.setItem(existingItem); // Bidirectional relation map karein
	            existingItem.getVariants().add(variant);
	        }
	    }
	    
	    // Final Database Sync
	    itemRepo.save(existingItem);
	}
	
	public void deleteItem(Long id) {

	    Item item = itemRepo.findById(id)
	            .orElseThrow(() -> new RuntimeException("Item not found"));
	    
	    

	    item.setStatus("inactive");   // soft delete
	    itemRepo.save(item);
	}

	public List<Item> getItemsBySubCategoryAndActiveStatus(Long subCategoryId) {
		return itemRepo.findBySubCategorySubCategoryIdAndStatus(subCategoryId, "active");
	}
	
	public List<Item> getItemsByCategoryAndActiveStatus(Long categoryId){
	    return itemRepo.findByCategoryCategoryIdAndStatus(categoryId, "active");
	}
	
	public List<Item> getItemsByCategoryGenderAndActiveStatus(
	        Long categoryId,
	        String gender){

	    return itemRepo.findByCategoryCategoryIdAndGenderAndStatus(
	            categoryId,
	            gender,
	            "active"
	    );
	}
	
	public List<Item> getTop2Items(Long categoryId){
	    List<Item> items = itemRepo.findByCategoryCategoryIdAndStatus(categoryId, "active");

	    if(items.size() > 2){
	        return items.subList(0, 2);
	    }
	    return items;
	}
	
	public boolean isSkuExists(String skuId){
	    return itemRepo.existsBySkuId(skuId);
	}
	
	public List<Item> getActiveItems(){
	    return itemRepo.findByStatus("active");
	}
	

}
