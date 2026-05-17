package springStarter.services;

import java.util.ArrayList;
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
		return itemRepo.findAllByOrderByCreatedAtDesc();
	}

	public Item getItemById(Long itemId) {
		 return itemRepo.findById(itemId)
		            .orElseThrow(() -> new RuntimeException("Item not found"));
	}

	public void updateItem(Item existingItem, Item incomingItem) {
	    
	    if(incomingItem.getSkuId() != null &&
	       itemRepo.existsBySkuId(incomingItem.getSkuId()) &&
	       !existingItem.getSkuId().equals(incomingItem.getSkuId())){
	        throw new RuntimeException("SKU already exists");
	    }

	    
	    if(incomingItem.getItemImage() != null && !incomingItem.getItemImage().isEmpty()) {
	        existingItem.setItemImage(incomingItem.getItemImage());
	    }
	    
	    
	    if (existingItem.getVariants() != null) {
	        existingItem.getVariants().clear();
	    } else {
	        existingItem.setVariants(new ArrayList<>());
	    }

	   
	    if (incomingItem.getVariants() != null) {
	        for (ItemVariant v : incomingItem.getVariants()) {
	            
	           
	            ItemVariant newVariant = new ItemVariant();
	            newVariant.setVariantColor(v.getVariantColor());
	            newVariant.setVariantStock(v.getVariantStock());
	            newVariant.setVariantImage(v.getVariantImage());
	            newVariant.setVariantSku(v.getVariantSku());
	            
	            newVariant.setItem(existingItem); 
	            
	            existingItem.getVariants().add(newVariant);
	        }
	    }
	    
	    
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
