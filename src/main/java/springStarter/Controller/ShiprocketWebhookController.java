package springStarter.Controller;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping; 
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import springStarter.models.Orders;
import springStarter.models.Order_item;
import springStarter.repository.OrderRepo;
import java.time.LocalDateTime;

@RestController
public class ShiprocketWebhookController {

	@Autowired
	private OrderRepo orderRepo;

	@RequestMapping(value = "/api/webhook/shiprocket", method = {RequestMethod.POST, RequestMethod.GET})
	public ResponseEntity<String> handleShiprocketUpdate(
			@RequestBody(required = false) String requestBody,
			@RequestHeader(value = "x-api-key", required = false) String webhookSecret) {
        
		try {
			System.out.println("📩 Webhook Received! Token: " + webhookSecret);
	        System.out.println("📦 Payload: " + requestBody);

	      
	        if (requestBody == null || requestBody.trim().isEmpty()) {
	            System.out.println("ℹ️ Shiprocket Test Ping Received & Passed Successfully!");
	            return new ResponseEntity<>("PING_SUCCESS", HttpStatus.OK);
	        }

	       
	        if (webhookSecret == null || !webhookSecret.equalsIgnoreCase("PooRahSecret2026")) {
	            System.out.println("❌ Unauthorized webhook attempt blocked! Invalid Token.");
	            return new ResponseEntity<>("Unauthorized", HttpStatus.UNAUTHORIZED);
	        }

			JSONObject json = new JSONObject(requestBody);
		
		
			String orderNumber = json.optString("channel_order_id");
			if (orderNumber == null || orderNumber.trim().isEmpty()) {
				orderNumber = json.optString("order_id");
			}
			
			String shiprocketStatus = json.optString("current_status").toLowerCase();

			Orders order = orderRepo.findByOrderNumber(orderNumber);
			if (order == null) {
				return new ResponseEntity<>("Order not found in database", HttpStatus.NOT_FOUND);
			}

			String targetStatus = order.getStatus();

			switch (shiprocketStatus) {
			case "shipped":
			case "dispatched":
				targetStatus = "Shipped";
				order.setShippedDate(LocalDateTime.now());
				break;
			case "out for delivery":
				targetStatus = "Out for delivery";
				break;
			
			case "delivered":
				targetStatus = "Delivered";
				order.setDeliveredDate(LocalDateTime.now());

				if ("PARTIAL_COD".equals(order.getPaymentMethod())) {
					order.setPaymentStatus("COD Partial");
				} else {
					order.setPaymentStatus("Paid");
				}
				break;
			case "cancelled":
				targetStatus = "Cancelled";
				order.setPaymentStatus("Cancelled");
				break;
			}

			if (!targetStatus.equals(order.getStatus())) {
				order.setStatus(targetStatus);

				for (Order_item item : order.getItems()) {
					item.setStatus(targetStatus);
					if ("Cancelled".equals(targetStatus)) {
						item.setIsCancelled(true);
						item.setRefundStatus("Pending");
					}
				}

				orderRepo.save(order);
				System.out.println("✅ Live Order " + orderNumber + " successfully auto-updated to " + targetStatus);
			}

			return new ResponseEntity<>("SUCCESS", HttpStatus.OK);

		} catch (Exception e) {
			System.out.println("❌ Webhook Internal Error: " + e.getMessage());
			return new ResponseEntity<>("Error processing webhook", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}