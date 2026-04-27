package springStarter.services;

import java.math.RoundingMode;
import java.text.DecimalFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import springStarter.models.Orders;

@Service
public class EmailService {

	
	@Autowired
    private JavaMailSender mailSender;

    public void sendEmail(String to, String subject, String body) {
        SimpleMailMessage msg = new SimpleMailMessage();
        msg.setTo(to);
        msg.setSubject(subject);
        msg.setText(body);
        mailSender.send(msg);
    }
    
    public void sendOrderMail(Orders order, String items){

        SimpleMailMessage message = new SimpleMailMessage();

        message.setTo("rahul@poorah.com"); // admin mail
        message.setSubject("New Order Received - " + order.getOrderNumber());
        String amount = order.getTotalAmount()
                .setScale(0, RoundingMode.HALF_UP)
                .toPlainString();


        message.setText(
        	    "🛒 New Order Placed\n\n" +
        	    "Order ID: " + order.getOrderNumber() + "\n" +
        	    "Customer: " + order.getUser().getUserName() + "\n" +
        	    "Amount: ₹" + amount + "\n" +
        	    "Payment: " + order.getPaymentMethod() + "\n" +
        	    "Status: " + order.getStatus() + "\n\n" +
        	    
        	    "📦 Order Items:\n" +
        	    "-------------------------\n" +
        	    items +
        	    "-------------------------\n\n" +
        	    
        	    "Thank you,\nPooRah Store"
        	);

        try {
            mailSender.send(message);
            System.out.println("MAIL SENT SUCCESS");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void sendToAdmin(String subject, String body, String userEmail) {
       
    	 try {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("rahul@poorah.com");
        message.setTo("poojakri2496@gmail.com"); 
        message.setReplyTo(userEmail);
        message.setSubject(subject);
        message.setText(body);

        mailSender.send(message);
    	 }
    	 catch (Exception e) {
    	        e.printStackTrace(); 
    	    }
    }
    
    public void sendAutoReply(String toEmail, String subject, String inbox)
    {
    	SimpleMailMessage message = new SimpleMailMessage();
    	message.setTo(toEmail);
    	message.setSubject(subject);
    	message.setText(inbox);
    	
    	mailSender.send(message);
    }
    
    public void sendReply(String toEmail, String subject, String inbox, String userName) {

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject(subject);
        
        String body = "Hello " + userName + ",\n\n"
                + inbox + "\n\n"
                + "Regards,\nTeam Poorah";
        
        message.setText(body);

        mailSender.send(message);
    }
}
