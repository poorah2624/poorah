package springStarter.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;


import springStarter.models.SubCategory;

public interface SubCategoryRepo extends JpaRepository<SubCategory, Long>{
	
	List<SubCategory> findByCategoryCategoryId(Long categoryId);

}
