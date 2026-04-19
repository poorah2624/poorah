package springStarter.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;


import springStarter.models.Category;

public interface CategoryRepo extends JpaRepository<Category, Long>{

	Optional<Category> findByCategoryId(Long categoryId);

	

}
