package springStarter.services;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import springStarter.models.Category;
import springStarter.repository.CategoryRepo;

@Service
@Transactional
public class CategoryService {
	
	@Autowired
	private CategoryRepo categoryRepo;

	public void saveCategory(Category category) {
		categoryRepo.save(category);
		
	}

	public List<Category> getAllCategories() {
		 return categoryRepo.findAll();
	}

	public Category getCategoryById(Long i) {
		
		 return categoryRepo.findByCategoryId(i) 
	             .orElseThrow(() -> new RuntimeException("Category not found"));
	}
	
	public void updateCategory(Category updated) {

	    Category existing = categoryRepo.findById(updated.getCategoryId())
	            .orElseThrow(() -> new RuntimeException("Not found"));

	    existing.setCategoryName(updated.getCategoryName());
	    existing.setCategoryStatus(updated.getCategoryStatus());

	    categoryRepo.save(existing);
	}
	
	public void deleteCategory(Long categoryId) {
	    categoryRepo.deleteById(categoryId);
	}

	

}
