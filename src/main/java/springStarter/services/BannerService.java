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
    
    /* @Autowired
	private Cloudinary cloudinary; */
    
    @Autowired
	private R2StorageService r2StorageService;
    
//  delete banner
    public void deleteBanner(Long bannerId) {

        Banner banner = bannerRepo.findByBannerId(bannerId)
                .orElseThrow(() -> new RuntimeException("Banner not found"));

        try {

            if (banner.getBannerName() != null && !banner.getBannerName().isEmpty()) {
                r2StorageService.deleteImage(banner.getBannerName());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        bannerRepo.delete(banner);
    }


}
