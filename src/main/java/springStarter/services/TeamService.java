package springStarter.services;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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

	

    public void save(Team team, MultipartFile file) throws IOException {

       /* String uploadDir = System.getProperty("user.dir") + "/uploads";*/
        /*String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";*/
        String uploadDir = "uploads/";
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();
        
        

        if (!file.isEmpty()) {
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            file.transferTo(new File(uploadDir + "/" + fileName));
            team.settImage(fileName);
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
