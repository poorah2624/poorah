package springStarter.Controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import springStarter.models.Banner;
import springStarter.services.BannerService;

@Controller
public class BannerController {
	
	@Autowired
	private BannerService bannerService;
	
	@Autowired
	private Cloudinary cloudinary;
	
	@GetMapping("/Add_Banner")
	public String Add_Banner() {
		return "admin/Add_Banner";
	}
	
	@PostMapping("/Add_Banner")
	public String addBanner(@RequestParam("bannerName") MultipartFile file,
	                        @RequestParam("bannerStatus") String status,
	                        Model model) throws IOException {

	    if(file.isEmpty()) {
	        model.addAttribute("Error","Please select image");
	        return "admin/Add_Banner";
	    }

	    // upload folder
	    /*String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";*/
	    String imageUrl = null;

	    try {
	        Map uploadResult = cloudinary.uploader().upload(
	                file.getBytes(),
	                ObjectUtils.asMap("folder", "poorah/banner") 
	        );

	        imageUrl = (String) uploadResult.get("secure_url");

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    // save in DB
	    Banner banner = new Banner();
	    banner.setBannerName(imageUrl);
	    banner.setBannerStatus(status);

	    bannerService.saveBanner(banner);

	    model.addAttribute("msg","Banner added successfully");
	    return "redirect:/view_Banner";
	}
	
	@GetMapping("/view_Banner")
	public String viewBanner(Model model) {

	    List<Banner> banner = bannerService.getAllBanners(); 
	    model.addAttribute("banner", banner);
	    System.out.println(banner);

	    return "admin/view_Banner";
	}
	
	@GetMapping("/edit_Banner/{bannerId}")
	public String editBanner(@PathVariable("bannerId") Long bannerId, Model model) {

	    Banner banner = bannerService.getBannerById(bannerId);

	    model.addAttribute("banner", banner);

	    return "admin/edit_Banner";
	}
	
	@PostMapping("/edit_Banner")
	public String updateBanner(
	        @RequestParam("bannerId") Long bannerId,
	        @RequestParam("bannerStatus") String bannerStatus,
	        @RequestParam(value = "image", required = false) MultipartFile file, Model model
	) throws IOException {

	    Banner existingBanner = bannerService.getBannerById(bannerId);

	    //  Image Update Logic
	    if (file != null && !file.isEmpty()) {

	    	 /*String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";*/
	    	try {
	    	    Map uploadResult = cloudinary.uploader().upload(
	    	            file.getBytes(),
	    	            ObjectUtils.asMap("folder", "poorah/banner") 
	    	    );

	    	    String imageUrl = (String) uploadResult.get("secure_url");

	    	    existingBanner.setBannerName(imageUrl);  

	    	} catch (Exception e) {
	    	    e.printStackTrace();
	    	}
	    }

	    // Status Update
	    existingBanner.setBannerStatus(bannerStatus);

	    bannerService.saveBanner(existingBanner);
	    model.addAttribute("msg","Banner edited successfully");
	    return "redirect:/view_Banner";
	}
	
	@GetMapping("/delete_Banner/{bannerId}")
	public String deleteBanner(@PathVariable("bannerId") Long bannerId) {

	    bannerService.deleteBanner(bannerId);

	    return "redirect:/view_Banner";
	}

}
