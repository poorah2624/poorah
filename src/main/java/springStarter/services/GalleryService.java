package springStarter.services;

import java.io.File;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import springStarter.models.Gallery;
import springStarter.repository.GalleryRepo;

@Service
@Transactional
public class GalleryService {
	
	@Autowired
	private GalleryRepo galleryRepo;
	
	public void saveGallery(Gallery gallery) {
        galleryRepo.save(gallery);
    }
	
	 //  get all banners
    public List<Gallery> getAllGallery() {
        return galleryRepo.findAll();
    }

    public Gallery getGalleryById(Long galleryId) {
        return galleryRepo.findByGalleryId(galleryId)
                .orElseThrow(() -> new RuntimeException("Gallery not found"));
    }
    
//  delete banner
    public void deleteGallery(Long galleryId) {

        Gallery gallery = galleryRepo.findByGalleryId(galleryId)
                .orElseThrow(() -> new RuntimeException("Gallery not found"));

        // delete image file
        /*String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";*/
        String uploadDir = "uploads/";
        File file = new File(uploadDir + gallery.getGalleryName());

        if (file.exists()) {
            file.delete();
        }

        galleryRepo.deleteById(galleryId);
    }

}
