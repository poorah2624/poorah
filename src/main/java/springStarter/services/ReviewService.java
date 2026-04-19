package springStarter.services;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import springStarter.models.Item;
import springStarter.models.Review;
import springStarter.repository.ReviewRepo;
import springStarter.repository.UserRepository;

@Transactional
@Service
public class ReviewService {
	
	@Autowired
	private ReviewRepo reviewRepo;
	
	@Autowired
	private UserRepository userRepo;

	public List<Review> getAllReviews() {
		return reviewRepo.findAll();
	}
	
	public void deleteReview(Long reviewId) {
        reviewRepo.deleteByReviewId(reviewId);
    }

    public void activateReview(Long reviewId) {
        Review r = reviewRepo.findByReviewId(reviewId).orElseThrow(null);
        r.setStatus("approved");
        reviewRepo.save(r);
    }
    
    /*public List<Review> getReviewsByItem(Item item){
        return reviewRepo.findByItem(item);
    }*/

    public void saveReview(Review review){
        reviewRepo.save(review);
    }
    
    public Double getAvgRating(Long itemId){
        return reviewRepo.getAverageRating(itemId);
    }

    public Long getReviewCount(Long itemId){
        return reviewRepo.getTotalReviews(itemId);
    }
    
    public List<Review> getApprovedReviewsByItem(Long itemId){
        return reviewRepo.findByItemItemIdAndStatus(itemId, "approved");
    }

}
