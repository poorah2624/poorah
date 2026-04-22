package springStarter.Controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

@Controller
public class ImageController {
	
	@Autowired
	private Cloudinary cloudinary;
	
	
	@PostMapping("/uploadImage")
	public String uploadImage(@RequestParam("file") MultipartFile file) {
	    try {

	        Map uploadResult = cloudinary.uploader().upload(
	            file.getBytes(),
	            ObjectUtils.emptyMap()
	        );

	        String imageUrl = (String) uploadResult.get("secure_url");

	        System.out.println("Image URL: " + imageUrl);

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return "redirect:/home";
	}

}
