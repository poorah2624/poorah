package springStarter.services;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import net.bytebuddy.utility.RandomString;
import springStarter.models.User;
import springStarter.repository.UserRepository;

@Service
@Transactional
public class UserService {

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	public void registerUser(String userName, String userEmail, String userPassword, String userMobile) {

		System.out.println("EMAIL FROM FORM = " + userEmail);
		System.out.println("EXISTS = " + userRepo.existsByUserEmail(userEmail));

		if (userRepo.existsByUserEmail(userEmail)) {

			throw new RuntimeException("Email already exists.");
		}

		// create user
		User user = new User();
		user.setUserName(userName);
		user.setUserEmail(userEmail);

		// encrypt user password
		user.setUserPassword(passwordEncoder.encode(userPassword));

		user.setUserMobile(userMobile);

		// save in db
		userRepo.save(user);

		// return "SUCCESS";

	}

	// login
	public User login(String userEmail, String userPassword) {
		User userOpted = userRepo.findByUserEmail(userEmail);
		if (userOpted == null) {
			return null;
		}
		
		if("GOOGLE".equals(userOpted.getAuthProvider())){
		    return userOpted;
		}

		System.out.println("Input password: " + userPassword);
		System.out.println(userOpted.getUserPassword());

		if (!passwordEncoder.matches(userPassword, userOpted.getUserPassword())) {
			return null;
		}

		return userOpted;
	}

	public User updateUser(User updatedUser) {

		User existingUser = userRepo.findById(updatedUser.getId())
				.orElseThrow(() -> new RuntimeException("User not found"));

		existingUser.setUserName(updatedUser.getUserName());
		existingUser.setUserEmail(updatedUser.getUserEmail());
		existingUser.setUserMobile(updatedUser.getUserMobile());

		return userRepo.save(existingUser);
	}

	public boolean changePassword(Long id, String userPassword, String newPassword) {

		Optional<User> optionalUser = userRepo.findById(id);

		if (!optionalUser.isPresent())
			return false;

		User user = optionalUser.get();

// check old password
		if (!passwordEncoder.matches(userPassword, user.getUserPassword())) {
			return false;
		}

// set new password
		user.setUserPassword(passwordEncoder.encode(newPassword));

		userRepo.save(user);

		return true;
	}
	
	@Autowired
    private EmailService emailService; 

	// Step 1: Generate reset token and send email
    public boolean sendPasswordResetLink(String userEmail) {
        User user = userRepo.findByUserEmail(userEmail);
        if(user == null) return false;

        // Generate unique token
        String token = UUID.randomUUID().toString();
        user.setResetToken(token);
        user.setTokenExpiry(LocalDateTime.now().plusMinutes(30)); // 30 min expiry
        userRepo.save(user);

        // Send email with reset link
        String resetLink = "https://poorah.com/resetPassword?token=" + token;
        String subject = "Password Reset Request";
        String body = "Click the link to reset your password: " + resetLink;

        emailService.sendEmail(user.getUserEmail(), subject, body);

        return true;
    }

    // Step 2: Validate token
    public User validatePasswordResetToken(String token) {
        User user = userRepo.findByResetToken(token);
        if(user == null) return null;
        if(user.getTokenExpiry().isBefore(LocalDateTime.now())) return null;
        return user;
    }

    // Step 3: Reset password
    public boolean resetPassword(String token, String userPassword) {
        User user = validatePasswordResetToken(token);
        if(user == null) return false;

        user.setUserPassword(passwordEncoder.encode(userPassword));
        user.setResetToken(null);
        user.setTokenExpiry(null);
        userRepo.save(user);

        return true;
    }
    
    public long getUserCount() {
        return userRepo.count();
    }
    
    
   
    
    public User registerGoogleUser(String userEmail, String userName){

        User user = userRepo.findByUserEmail(userEmail);

        if(user == null){
            user = new User();
            user.setUserEmail(userEmail);
            user.setUserName(userName);

            user.setAuthProvider("GOOGLE");   // ⭐ important
            user.setUserPassword(null);       // ⭐ no password

            userRepo.save(user);
        }

        return user;
    }


}
