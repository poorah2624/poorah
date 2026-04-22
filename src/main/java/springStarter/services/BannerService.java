package springStarter.services;

import java.io.File;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import springStarter.models.Banner;
import springStarter.repository.BannerRepo;

@Service
@Transactional
public class BannerService {
	
	@Autowired
	private BannerRepo bannerRepo;
	
	public void saveBanner(Banner banner) {
        bannerRepo.save(banner);
    }

	//  get single banner (latest)
    public Banner getBanner() {
        return bannerRepo.findTopByOrderByBannerIdDesc();
    }

    //  get all banners
    public List<Banner> getAllBanners() {
        return bannerRepo.findAll();
    }

    

    public Banner getBannerById(Long bannerId) {
        return bannerRepo.findByBannerId(bannerId)
                .orElseThrow(() -> new RuntimeException("Banner not found"));
    }
    
    @Autowired
	private Cloudinary cloudinary;
    
//  delete banner
    public void deleteBanner(Long bannerId) {

        Banner banner = bannerRepo.findByBannerId(bannerId)
                .orElseThrow(() -> new RuntimeException("Banner not found"));

        // delete image file
        /*String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";*/
        try {
            String imageUrl = banner.getBannerName();

            if (imageUrl != null && imageUrl.contains("/upload/")) {

                String publicId = imageUrl
                        .substring(imageUrl.indexOf("/upload/") + 8)
                        .replaceAll("v[0-9]+/", "")   // remove version
                        .replaceAll("\\.[^.]+$", ""); // remove extension

                cloudinary.uploader().destroy(publicId, ObjectUtils.emptyMap());

                System.out.println("Deleted from Cloudinary: " + publicId);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        bannerRepo.deleteById(bannerId);
    }


}
