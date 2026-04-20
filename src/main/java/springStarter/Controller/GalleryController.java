package springStarter.Controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import springStarter.models.Gallery;
import springStarter.services.GalleryService;

@Controller
public class GalleryController {
	
	@Autowired
	private GalleryService galleryService;
	
	@GetMapping("/Add_Gallery")
	public String Add_Gallery() {
		return "admin/Add_Gallery";
	}
	
	@PostMapping("/Add_Gallery")
	public String addBanner(@RequestParam("galleryName") MultipartFile file,
	                        @RequestParam("galleryStatus") String status,
	                        Model model) throws IOException {

	    if(file.isEmpty()) {
	        model.addAttribute("Error","Please select image");
	        return "admin/Add_Gallery";
	    }

	    // upload folder
	    /*String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";*/
	    String uploadDir = "/app/uploads/";

	    File dir = new File(uploadDir);
	    if(!dir.exists()) dir.mkdirs();

	    // unique file name
	    String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();

	    file.transferTo(new File(uploadDir + "/" + fileName));

	    // save in DB
	    Gallery gallery = new Gallery();
	    gallery.setGalleryName(fileName);
	    gallery.setGalleryStatus(status);

	    galleryService.saveGallery(gallery);

	    model.addAttribute("msg","Gallery added successfully");
	    return "redirect:/view_Gallery";
	}
	
	@GetMapping("/view_Gallery")
	public String viewBanner(Model model) {

	    List<Gallery> gallery = galleryService.getAllGallery(); 
	    model.addAttribute("gallery", gallery);

	    return "admin/view_Gallery";
	}
	
	@GetMapping("/edit_Gallery/{galleryId}")
	public String editGallery(@PathVariable("galleryId") Long galleryId, Model model) {

	    Gallery gallery = galleryService.getGalleryById(galleryId);

	    model.addAttribute("gallery", gallery);

	    return "admin/edit_Gallery";
	}
	
	@PostMapping("/edit_Gallery")
	public String updateGallery(
	        @RequestParam("galleryId") Long galleryId,
	        @RequestParam("galleryStatus") String galleryStatus,
	        @RequestParam(value = "image", required = false) MultipartFile file, Model model
	) throws IOException {

	    Gallery existingGallery = galleryService.getGalleryById(galleryId);

	    //  Image Update Logic
	    if (file != null && !file.isEmpty()) {

	    	 /*String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";*/
	        String uploadDir = "uploads/";
	        File dir = new File(uploadDir);
	        if (!dir.exists()) dir.mkdirs();

	        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	        file.transferTo(new File(uploadDir + "/" + fileName));

	        existingGallery.setGalleryName(fileName);
	    }

	    // Status Update
	    existingGallery.setGalleryStatus(galleryStatus);

	    galleryService.saveGallery(existingGallery);
	    model.addAttribute("msg","Gallery edited successfully");
	    return "redirect:/view_Gallery";
	}
	
	@GetMapping("/delete_Gallery/{galleryId}")
	public String deleteGallery(@PathVariable("galleryId") Long galleryId) {

	    galleryService.deleteGallery(galleryId);

	    return "redirect:/view_Gallery";
	}

}
