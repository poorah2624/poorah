package springStarter.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import springStarter.models.Review;

@Repository
public interface ReviewRepo extends  JpaRepository<Review, Long>  {

	void deleteByReviewId(Long reviewId);

	Optional<Review> findByReviewId(Long reviewId);
	
	//List<Review> findByItem(Item item);
	
	@Query("SELECT AVG(r.rating) FROM Review r WHERE r.item.itemId = :itemId AND r.status='approved'")
	Double getAverageRating(Long itemId);

	@Query("SELECT COUNT(r) FROM Review r WHERE r.item.itemId = :itemId AND r.status='approved'")
	Long getTotalReviews(Long itemId);
	
	List<Review> findByItemItemIdAndStatus(Long itemId, String status);
	

}
