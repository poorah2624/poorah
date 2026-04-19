package springStarter.services;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import springStarter.models.Admin;
import springStarter.models.User;
import springStarter.repository.AdminRepo;

@Service
@Transactional
public class AdminService {
	
	@Autowired
	private AdminRepo adminRepo;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
    
    public void registerAdmin(Admin admin) {

    	admin.setPassword(passwordEncoder.encode(admin.getPassword()));
    	adminRepo.save(admin);
    }

	public boolean emailExists(String email) {
		// TODO Auto-generated method stub
		return adminRepo.existsByEmail(email);
	}
	
	public Admin findByEmail(String email){
	    return adminRepo.findByEmail(email);
	}


	// login
	public Admin login(String email, String password) {
		Admin admin = adminRepo.findByEmail(email);
		if (admin == null) {
			return null;
		}

		System.out.println("Input password: " + password);
		System.out.println(admin.getPassword());

		if (!passwordEncoder.matches(password, admin.getPassword())) {
			return null;
		}

		return admin;
	}
	
	@Autowired
    private EmailService emailService; 
	
	// Step 1: Generate reset token and send email
    public boolean sendPasswordResetLink(String email) {
        Admin admin = adminRepo.findByEmail(email);
        if(admin == null) return false;

        // Generate unique token
        String token = UUID.randomUUID().toString();
        admin.setResetToken(token);
        admin.setTokenExpiry(LocalDateTime.now().plusMinutes(30)); // 30 min expiry
        adminRepo.save(admin);

        // Send email with reset link
        String resetLink = "http://localhost:8080/admin/resetAdminPassword?token=" + token;
        String subject = "Password Reset Request for admin";
        String body = "Click the link to reset your password: " + resetLink;

        emailService.sendEmail(admin.getEmail(), subject, body);

        return true;
    }

    // Step 2: Validate token
    public Admin validatePasswordResetToken(String token) {
    	Admin admin = adminRepo.findByResetToken(token);
        if(admin == null) return null;
        if(admin.getTokenExpiry().isBefore(LocalDateTime.now())) return null;
        return admin;
    }

    // Step 3: Reset password
    public boolean resetPassword(String token, String password) {
        Admin admin = validatePasswordResetToken(token);
        if(admin == null) return false;

        admin.setPassword(passwordEncoder.encode(password));
        admin.setResetToken(null);
        admin.setTokenExpiry(null);
        adminRepo.save(admin);

        return true;
    }
    
    public Admin updateAdmin(Admin updatedAdmin) {

		Admin existingAdmin = adminRepo.findById(updatedAdmin.getAdminId())
				.orElseThrow(() -> new RuntimeException("Admin not found"));

		existingAdmin.setName(updatedAdmin.getName());
		existingAdmin.setEmail(updatedAdmin.getEmail());
		existingAdmin.setMobile(updatedAdmin.getMobile());
		existingAdmin.setImage(updatedAdmin.getImage());
		existingAdmin.setAddress(updatedAdmin.getAddress());

		return adminRepo.save(existingAdmin);
	}
    
    public boolean changePassword(Long adminId, String password, String newPassword) {

		Optional<Admin> optionalAdmin = adminRepo.findById(adminId);

		if (!optionalAdmin.isPresent())
			return false;

		Admin admin = optionalAdmin.get();

// check old password
		if (!passwordEncoder.matches(password, admin.getPassword())) {
			return false;
		}

// set new password
		admin.setPassword(passwordEncoder.encode(newPassword));

		adminRepo.save(admin);

		return true;
	}
}
