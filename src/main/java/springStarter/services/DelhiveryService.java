package springStarter.services;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import springStarter.models.Order_item;
import springStarter.models.Orders;
import springStarter.repository.OrderRepo;

@Service
public class DelhiveryService {

    @Autowired
    private OrderRepo orderRepo;

    public void createShipment(Orders order) {

        try {

            RestTemplate restTemplate = new RestTemplate();

            HttpHeaders headers = new HttpHeaders();

            headers.setContentType(MediaType.APPLICATION_JSON);

            headers.set(
                    "Authorization",
                    "Token f2d0914077bc56b985c0cdb42f830616a5b3ff72"
            );

            // =========================
            // ORDER ITEMS
            // =========================

            JSONArray orderItems = new JSONArray();

            for (Order_item item : order.getItems()) {

                JSONObject obj = new JSONObject();

                // product name
                if (item.getIsCustom() != null && item.getIsCustom()) {

                    obj.put("name", "Custom T-Shirt");

                } else {

                    obj.put(
                            "name",
                            item.getItem().getItemName()
                    );
                }

                // SKU
                obj.put(
                        "sku",
                        "SKU-" + item.getId()
                );

                // quantity
                obj.put(
                        "units",
                        item.getQuantity()
                );

                // price
                obj.put(
                        "selling_price",
                        item.getFinalPrice()
                );

                orderItems.put(obj);
            }

            // =========================
            // SHIPMENT DATA
            // =========================

            JSONObject shipment = new JSONObject();

            shipment.put(
                    "name",
                    order.getUser().getUserName()
            );

            shipment.put(
                    "billing_last_name",
                    ""
            );

            shipment.put(
                    "billing_address",
                    order.getAddress().getHouseNo()
                            + ", "
                            + order.getAddress().getArea()
                            + ", "
                            + order.getAddress().getLandmark()
            );

            shipment.put(
                    "billing_city",
                    order.getAddress().getCity()
            );

            shipment.put(
                    "billing_pincode",
                    order.getAddress().getPincode()
            );

            shipment.put(
                    "billing_state",
                    order.getAddress().getState()
            );

            shipment.put(
                    "billing_country",
                    "India"
            );

            shipment.put(
                    "billing_email",
                    order.getUser().getUserEmail()
            );

            shipment.put(
                    "phone",
                    order.getAddress().getMobile()
            );

            shipment.put(
                    "order",
                    order.getOrderNumber()
            );

            // PAYMENT MODE

            shipment.put(
                    "payment_mode",
                    "Paid".equalsIgnoreCase(
                            order.getPaymentStatus())
                            ? "Prepaid"
                            : "COD"
            );

            // TOTAL

            shipment.put(
                    "sub_total",
                    order.getTotalAmount()
            );

            // ITEMS

            shipment.put(
                    "order_items",
                    orderItems
            );

            // PACKAGE SIZE

            shipment.put("length", 10);

            shipment.put("breadth", 10);

            shipment.put("height", 2);

            shipment.put("weight", 0.5);

            // SHIPPING SAME AS BILLING

            shipment.put(
                    "shipping_is_billing",
                    true
            );

            // =========================
            // MAIN BODY
            // =========================

            JSONArray shipments = new JSONArray();

            shipments.put(shipment);

            JSONObject body = new JSONObject();

            body.put("shipments", shipments);

            HttpEntity<String> request =
                    new HttpEntity<>(
                            body.toString(),
                            headers
                    );

            // =========================
            // API CALL
            // =========================

            String response =
                    restTemplate.postForObject(
                            "https://track.delhivery.com/api/cmu/create.json",
                            request,
                            String.class
                    );

            System.out.println(
                    "DELHIVERY RESPONSE: "
                            + response
            );

            // =========================
            // RESPONSE PARSE
            // =========================

            JSONObject json =
                    new JSONObject(response);

            JSONArray packages =
                    json.getJSONArray("packages");

            JSONObject pkg =
                    packages.getJSONObject(0);

            String awb =
                    pkg.getString("waybill");

            // =========================
            // SAVE IN DATABASE
            // =========================

            order.setAwbCode(awb);

            order.setCourierName("Delhivery");

            order.setShipmentStatus("Packed");

            orderRepo.save(order);

            System.out.println(
                    "AWB SAVED: " + awb
            );

        }

        catch (Exception e) {

            e.printStackTrace();
        }
    }
}