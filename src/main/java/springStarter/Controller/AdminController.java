package springStarter.Controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import springStarter.models.Admin;
import springStarter.services.AdminService;
import springStarter.services.UserService;

@Controller
public class AdminController {

	@GetMapping("/adminLogin")
	public String adminLogin() {
		return "admin/adminLogin";
	}

	@GetMapping("/registerAdmin")
	public String registerAdmin() {
		return "admin/registerAdmin";
	}

	@Autowired
	private AdminService adminService;

	private static final String PASSWORD_REGEX = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@#$%!^&*]).{8,}$";

	// handle form submit
	@PostMapping("/registerAdmin")
	public String registerAdmin(@RequestParam String name, @RequestParam String email, @RequestParam String password,
			@RequestParam String confirmPassword, @RequestParam String address, @RequestParam String mobile,
			@RequestParam("image") MultipartFile file, Model model) throws IOException {

		if (adminService.emailExists(email)) {
			model.addAttribute("Error", "Email already exists.");
			return "admin/registerAdmin";
		}

		if (!password.matches(PASSWORD_REGEX)) {
			model.addAttribute("Error",
					"Password must be at least 8 characters and include uppercase, lowercase, number and special character. Sign up again.");
			return "admin/registerAdmin";
		}
		// password match check
		if (!password.equals(confirmPassword)) {
			model.addAttribute("Error", "Password and confirm password don't match. Sign up again.");
			return "admin/registerAdmin";
		}

		String fileName = "default.png";

		if (!file.isEmpty()) {

			/*String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";*/
			String uploadDir = "uploads/";

			File directory = new File(uploadDir);
			if (!directory.exists())
				directory.mkdirs();

			fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();

			File saveFile = new File(uploadDir + "/" + fileName);
			file.transferTo(saveFile);
		}

		Admin admin = new Admin();
		admin.setName(name);
		admin.setEmail(email);
		admin.setPassword(password); // service me encode hoga
		admin.setAddress(address);
		admin.setMobile(mobile);
		admin.setImage(fileName);

		adminService.registerAdmin(admin);

		model.addAttribute("msg", "Registered successfully...");
		return "admin/adminLogin";
	}

	@PostMapping("/login")
	public String login(@RequestParam String email, @RequestParam String password,
			@RequestParam(required = false) String remember, HttpServletResponse response, Model model,
			HttpSession session) {
		Admin admin = adminService.login(email, password);
		if (admin == null) {
			model.addAttribute("Error", "Invalid email or password.");
			return "admin/adminLogin";
		}

		session.setAttribute("LoggedInAdmin", admin);

		if (remember != null) {
			Cookie cookie = new Cookie("adminEmail", email);
			cookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
			cookie.setPath("/");
			response.addCookie(cookie);
		}

		return "redirect:/dashboard";

	}

	@Autowired
	private UserService userService;

	@GetMapping("/dashboard")
	public String dashboard(HttpSession session, HttpServletRequest request, Model model) {

		long totalUsers = userService.getUserCount();
		model.addAttribute("userCount", totalUsers);

		if (session.getAttribute("LoggedInAdmin") == null) {

			Cookie[] cookies = request.getCookies();

			if (cookies != null) {
				for (Cookie c : cookies) {
					if (c.getName().equals("adminEmail")) {
						Admin admin = adminService.findByEmail(c.getValue());
						session.setAttribute("LoggedInAdmin", admin);
					}
				}
			}
			return "admin/adminLogin";
		}

		return "admin/dashboard";
	}

	@GetMapping("/forgot")
	public String forgot() {
		return "admin/forgot";
	}

	@GetMapping("/edit_profile")
	public String editAdmin(HttpSession session, Model model) {
		Admin loggedAdmin = (Admin) session.getAttribute("LoggedInAdmin");

		if (loggedAdmin == null) {
			return "adminLogin"; // session expired safety
		}

		model.addAttribute("admin", loggedAdmin);

		return "admin/edit_profile";
	}
	
	@PostMapping("/editAdmin")
	public String updateProfile(@ModelAttribute Admin admin,
	                            @RequestParam(value="file", required=false) MultipartFile file,
	                            HttpSession session) throws IOException {

	    Admin sessionAdmin = (Admin) session.getAttribute("LoggedInAdmin");

	    if (sessionAdmin == null) {
	        return "redirect:/adminLogin";
	    }

	    admin.setAdminId(sessionAdmin.getAdminId());

	   
	    if (file != null && !file.isEmpty()) {

	        /*String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads";*/
	        String uploadDir = "/app/uploads/";

	        File dir = new File(uploadDir);
	        if (!dir.exists()) dir.mkdirs();

	        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	        file.transferTo(new File(uploadDir + "/" + fileName));

	        admin.setImage(fileName);

	    } else {
	        admin.setImage(sessionAdmin.getImage()); // keep old image
	    }

	    Admin updatedAdmin = adminService.updateAdmin(admin);

	    session.setAttribute("LoggedInAdmin", updatedAdmin);

	    return "admin/edit_profile";
	}

	@GetMapping("/Logout")
	public String logout(HttpSession session, HttpServletResponse response) {

		session.invalidate();

		Cookie cookie = new Cookie("email", null);
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);

		return "redirect:/adminLogin";
	}

	@PostMapping("/forgot")
	public String forgotPassword(@RequestParam String email, Model model) {
		boolean sent = adminService.sendPasswordResetLink(email);

		if (sent) {
			model.addAttribute("msg", "Reset link sent to your email!");
		} else {
			model.addAttribute("error", "Email not registered!");
		}
		return "admin/forgot";
	}

	// Reset password page
	@GetMapping("/admin/resetAdminPassword")
	public String showResetPasswordForm(@RequestParam String token, Model model) {
		Admin admin = adminService.validatePasswordResetToken(token);
		if (admin == null) {
			model.addAttribute("Error", "Invalid or expired token!");
			return "Error";
		}
		model.addAttribute("token", token);
		return "admin/resetAdminPassword";
	}

	// Reset password submit
	@PostMapping("/resetAdminPassword")
	public String resetPassword(@RequestParam String token, @RequestParam String password,
			@RequestParam String confirmPassword, Model model) {
		if (!password.equals(confirmPassword)) {
			model.addAttribute("Error", "Passwords do not match!");
			model.addAttribute("token", token);
			return "admin/resetPassword";
		}

		boolean success = adminService.resetPassword(token, password);
		if (success) {
			model.addAttribute("msg", "Password reset successfully! You can now login.");
			return "admin/adminLogin";
		} else {
			model.addAttribute("Error", "Invalid or expired token! Try Again.");
			return "admin/forgot";
		}
	}
	
	@GetMapping("/change_Password")
	public String change_password() {
		return "admin/change_Password";
	}
	
	@PostMapping("/change_Password")
	public String changePassword(
	        @RequestParam String password,
	        @RequestParam String newPassword,
	        HttpSession session, Model model) {
		System.out.println("Change");

	    Admin loggedAdmin = (Admin) session.getAttribute("LoggedInAdmin");

	    boolean changed = adminService.changePassword(
	    		loggedAdmin.getAdminId(),
	            password,
	            newPassword);

	    if(changed) {
	    	model.addAttribute("msg","Password changed");
	        return "admin/dashboard";
	    } else {
	    	model.addAttribute("Error","Try again.");
	        return "admin/change_Password";
	    }
	}
	
	

}
