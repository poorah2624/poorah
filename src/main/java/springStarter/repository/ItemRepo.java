package springStarter.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import springStarter.models.Item;

@Repository
public interface ItemRepo extends JpaRepository<Item, Long>  {
	
	List<Item> findBySubCategorySubCategoryIdAndStatus(Long subCategoryId, String status);
	
	List<Item> findByCategoryCategoryIdAndStatus(Long categoryId, String status);
	
	List<Item> findTop3ByCategoryCategoryIdAndStatusOrderByItemIdDesc(Long categoryId, String status);
	
	boolean existsBySkuId(String skuId);
	
	List<Item> findByStatus(String status);
	
	List<Item> findByGender(String gender);
	

}
