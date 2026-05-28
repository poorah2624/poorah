package springStarter.services;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import springStarter.models.Order_item;
import springStarter.models.Orders;

@Service
public class ShiprocketService {
	
	private String cachedToken;
	private long tokenTime;
	
	public String getToken() {
		if (cachedToken != null &&
		        (System.currentTimeMillis() - tokenTime) < 50 * 60 * 1000) {
		        return cachedToken;
		    }
		
		String url = "https://apiv2.shiprocket.in/v1/external/auth/login";

	    RestTemplate restTemplate = new RestTemplate();

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);

	    Map<String, String> body = new HashMap<>();
	    body.put("email", "rahul@poorah.com");
	    body.put("password", "YV20LdgZ&wh5b&MAS$5Krss4q6bk%TXD");

	    HttpEntity<Map<String, String>> request =
	            new HttpEntity<>(body, headers);

	    ResponseEntity<String> response =
	            restTemplate.postForEntity(url, request, String.class);

	    JSONObject json = new JSONObject(response.getBody());
	    tokenTime = System.currentTimeMillis();

	    return json.getString("token");   
    }
	
	public void createOrder(Orders order) {

        try {

            String token = getToken();
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            headers.setBearerAuth(token);
            headers.setContentType(MediaType.APPLICATION_JSON);
            JSONArray items = new JSONArray();
            for (Order_item item : order.getItems()) {
            	
                JSONObject itemJson = new JSONObject();
                if (item.getIsCustom() != null && item.getIsCustom()) {

                    itemJson.put("name", "Custom TShirt");

                } else {

                    itemJson.put("name",
                            item.getItem().getItemName());
                }

                itemJson.put("sku", "SKU_" + item.getId());

                itemJson.put("units",
                        item.getQuantity());

                itemJson.put("selling_price",
                        item.getFinalPrice());

                items.put(itemJson);
            }

            JSONObject body = new JSONObject();

            body.put("order_id",
                    order.getOrderNumber());

            body.put("order_date",
                    order.getOrderDate().toString());

            body.put("pickup_location",
                    "Home");

            body.put("billing_customer_name",
                    order.getUser().getUserName());

            body.put("billing_last_name", "");
            
            body.put("billing_address",
                    order.getAddress().getHouseNo() + ", " +
                    order.getAddress().getArea() + ", " +
                    order.getAddress().getLandmark());

            body.put("billing_city",
                    order.getAddress().getCity());

            body.put("billing_pincode",
                    order.getAddress().getPincode());

            body.put("billing_state",
                    order.getAddress().getState());

            body.put("billing_country",
                    "India");

            body.put("billing_email",
                    order.getUser().getUserEmail());

            body.put("billing_phone",
                    order.getAddress().getMobile());

            body.put("shipping_is_billing", true);

            body.put("order_items", items);

            if ("Paid".equalsIgnoreCase(order.getPaymentStatus())) {
                
                body.put("payment_method", "Prepaid");
                body.put("sub_total", order.getTotalAmount()); 

            } else if ("Partially Paid".equalsIgnoreCase(order.getPaymentStatus())) {
                
                body.put("payment_method", "COD");
               
                BigDecimal collectableAmount = order.getTotalAmount().multiply(new BigDecimal("0.6"))
                        .setScale(0, RoundingMode.HALF_UP);
                        
                body.put("sub_total", collectableAmount); 

            } else {
               
                body.put("payment_method", "COD");
                body.put("sub_total", order.getTotalAmount());
            }

            body.put("length", 10);
            body.put("breadth", 10);
            body.put("height", 2);
            body.put("weight", 0.5);

            HttpEntity<String> request =
                    new HttpEntity<>(body.toString(), headers);

            ResponseEntity<String> response =
                    restTemplate.postForEntity(
                            "https://apiv2.shiprocket.in/v1/external/orders/create/adhoc",
                            request,
                            String.class);

            System.out.println("SHIPROCKET RESPONSE:");
            System.out.println(response.getBody());

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
	
	public void cancelOrderInShiprocket(String orderNumber) {
	    try {
	       
	        String url = "https://apiv2.shiprocket.in/v1/external/orders/cancel";
	        RestTemplate restTemplate = new RestTemplate();
	        
	        HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(MediaType.APPLICATION_JSON);
	   
	        String token = getToken(); 
	        if (token == null) {
	            System.out.println("❌ Cancellation stopped: Token generate nahi ho paya.");
	            return;
	        }
	        headers.set("Authorization", "Bearer " + token);

	        JSONObject payload = new JSONObject();
	        JSONArray idsArray = new JSONArray();
	        idsArray.put(orderNumber);
	        payload.put("ids", idsArray);

	        HttpEntity<String> entity = new HttpEntity<>(payload.toString(), headers);

	        String response = restTemplate.postForObject(url, entity, String.class);
	        System.out.println("🤖 Shiprocket Cancel API Response: " + response);

	    } catch (Exception e) {
	        System.out.println("❌ Shiprocket ke andar order cancel nahi ho paya: " + e.getMessage());
	      
	    }
	}

}
