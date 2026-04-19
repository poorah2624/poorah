package springStarter.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import springStarter.models.Gallery;

public interface GalleryRepo extends JpaRepository<Gallery, Long>{

	Gallery findTopByOrderByGalleryIdDesc();

	Optional<Gallery> findByGalleryId(Long galleryId);
	
	

}