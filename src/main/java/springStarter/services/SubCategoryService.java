package springStarter.services;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import springStarter.models.Category;
import springStarter.models.SubCategory;
import springStarter.repository.CategoryRepo;
import springStarter.repository.SubCategoryRepo;

@Service
@Transactional
public class SubCategoryService {
	
	@Autowired
	private SubCategoryRepo subCategoryRepo;
	
	@Autowired
	private CategoryRepo categoryRepo;

	public void saveSubCategory(SubCategory subCategory) {
		subCategoryRepo.save(subCategory);
		
	}

	public List<SubCategory> getAllSubCategories() {
		 return subCategoryRepo.findAll();
	}

	
	public List<SubCategory> getSubCategoriesByCategoryId(Long categoryId) { 
		
		 return subCategoryRepo.findByCategoryCategoryId(categoryId);
	}
	
	public SubCategory getSubCategoryById(Long subCategoryid) {
	    return subCategoryRepo.findById(subCategoryid)
	            .orElseThrow(() -> new RuntimeException("SubCategory not found"));
	}
	
	public void deleteSubCategory(Long subCategoryId) {
	    subCategoryRepo.deleteById(subCategoryId);
	}

	public void updateSubCategory(SubCategory subCategory) {
		 // existing record fetch
	    SubCategory existing = subCategoryRepo.findById(subCategory.getSubCategoryId())
	            .orElseThrow(() -> new RuntimeException("SubCategory not found"));

	    // update fields
	    existing.setSubCategoryName(subCategory.getSubCategoryName());
	    existing.setSubCategoryStatus(subCategory.getSubCategoryStatus());
	    
	    Long categoryId = subCategory.getCategory().getCategoryId();
	    Category category = categoryRepo.findById(categoryId)
	            .orElseThrow(() -> new RuntimeException("Category not found"));

	    // update category (IMPORTANT)
	    existing.setCategory(category);

	    // save 
	    subCategoryRepo.save(existing);
		
	}

}
