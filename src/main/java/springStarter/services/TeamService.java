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

import springStarter.models.Team;
import springStarter.repository.TeamRepo;

@Service
@Transactional
public class TeamService {
	
	@Autowired
	private final TeamRepo teamRepo;

    public TeamService(TeamRepo teamRepo) {
        this.teamRepo = teamRepo;
    }
    

    public List<Team> getAllTeams() {
        return teamRepo.findAll();
    }

    public Team getById(Long teamId) {
        return teamRepo.findById(teamId).orElse(null);
    }

    @Autowired
	private Cloudinary cloudinary;

    public void save(Team team, MultipartFile file) throws IOException {

       /* String uploadDir = System.getProperty("user.dir") + "/uploads";*/
        /*String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";*/
    	if (file != null && !file.isEmpty()) {
    	    try {
    	        Map uploadResult = cloudinary.uploader().upload(
    	                file.getBytes(),
    	                ObjectUtils.asMap("folder", "poorah/team")
    	        );

    	        String imageUrl = (String) uploadResult.get("secure_url");

    	        team.settImage(imageUrl); 

    	    } catch (Exception e) {
    	        e.printStackTrace();
    	    }
    	}
        

        teamRepo.save(team);
    }
    
    public void updateTeam(Team team) {
		
	    // save
	    teamRepo.save(team);
		
	}


	public void delete(Long teamId) {
		teamRepo.deleteById(teamId);
		
	}

   

}
