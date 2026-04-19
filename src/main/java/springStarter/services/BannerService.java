package springStarter.services;

import java.io.File;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    
//  delete banner
    public void deleteBanner(Long bannerId) {

        Banner banner = bannerRepo.findByBannerId(bannerId)
                .orElseThrow(() -> new RuntimeException("Banner not found"));

        // delete image file
        String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads/";
        File file = new File(uploadDir + banner.getBannerName());

        if (file.exists()) {
            file.delete();
        }

        bannerRepo.deleteById(bannerId);
    }


}
