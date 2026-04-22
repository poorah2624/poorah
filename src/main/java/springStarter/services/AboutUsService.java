package springStarter.services;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import springStarter.models.AboutUs;
import springStarter.repository.AboutUsRepo;

@Transactional
@Service
public class AboutUsService {
	
	

	    @Autowired
	    private AboutUsRepo aboutRepo;

	    public AboutUs getAboutUs() {
	        //return aboutRepo.findAll().stream().findFirst().orElse(new AboutUs());
	    	List<AboutUs> list = aboutRepo.findAll();
	    	
	    	if(list.isEmpty()) {
	            AboutUs about = new AboutUs();
	            about.setaName("About Company");
	            about.setaImage("https://res.cloudinary.com/demo/image/upload/45.png");
	            about.setaDesc("Write about your company here...");
	            return aboutRepo.save(about);  // auto insert
	        }
	    	return list.get(0);
	    }
	    
	    public AboutUs getById(Long aId) {
			return aboutRepo.findById(aId) 
		             .orElseThrow(() -> new RuntimeException("about us not found"));
		}
	    
	    @Autowired
		private Cloudinary cloudinary;

	    public void saveOrUpdate(AboutUs aboutUs,MultipartFile file) throws IOException{
	    	AboutUs existing = null;

	        if (aboutUs.getaId() != null) {
	            existing = aboutRepo.findById(aboutUs.getaId()).orElse(null);
	        }

	        if (existing == null) {
	            existing = new AboutUs();
	        }

	        existing.setaName(aboutUs.getaName());
	        //existing.setaDesc(aboutUs.getaDesc());

	        if (!file.isEmpty()) {

	        	 /*String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";*/
	        	try {
	        	    Map uploadResult = cloudinary.uploader().upload(
	        	            file.getBytes(),
	        	            ObjectUtils.asMap("folder", "poorah/about")
	        	    );

	        	    String imageUrl = (String) uploadResult.get("secure_url");

	        	    existing.setaImage(imageUrl);   

	        	} catch (Exception e) {
	        	    e.printStackTrace();
	        	}
	        }

	        aboutRepo.save(existing);
	    }

		
	

}
