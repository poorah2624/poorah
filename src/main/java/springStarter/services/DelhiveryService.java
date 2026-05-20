package springStarter.services;

import java.net.URLEncoder;

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

            RestTemplate restTemplate =
                    new RestTemplate();

            HttpHeaders headers =
                    new HttpHeaders();

            // IMPORTANT
            headers.setContentType(
                    MediaType.APPLICATION_FORM_URLENCODED
            );

            headers.set(
                    "Authorization",
                    "Token f2d0914077bc56b985c0cdb42f830616a5b3ff72"
            );

            // =========================
            // ORDER ITEMS
            // =========================

            JSONArray orderItems =
                    new JSONArray();

            for (Order_item item : order.getItems()) {

                JSONObject obj =
                        new JSONObject();

                if (item.getIsCustom() != null
                        && item.getIsCustom()) {

                    obj.put(
                            "name",
                            "Custom T-Shirt"
                    );

                } else {

                    obj.put(
                            "name",
                            item.getItem().getItemName()
                    );
                }

                obj.put(
                        "sku",
                        "SKU-" + item.getId()
                );

                obj.put(
                        "units",
                        item.getQuantity()
                );

                obj.put(
                        "selling_price",
                        item.getFinalPrice()
                );

                orderItems.put(obj);
            }

            // =========================
            // SHIPMENT
            // =========================

            JSONObject shipment =
                    new JSONObject();

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

            shipment.put(
                    "payment_mode",
                    "Paid".equalsIgnoreCase(
                            order.getPaymentStatus())
                            ? "Prepaid"
                            : "COD"
            );

            shipment.put(
                    "sub_total",
                    order.getTotalAmount()
            );

            shipment.put(
                    "order_items",
                    orderItems
            );

            shipment.put(
                    "shipping_is_billing",
                    true
            );

            shipment.put("length", 10);
            shipment.put("breadth", 10);
            shipment.put("height", 2);
            shipment.put("weight", 0.5);

            // =========================
            // MAIN BODY
            // =========================

            JSONArray shipments =
                    new JSONArray();

            shipments.put(shipment);

            JSONObject body =
                    new JSONObject();

            body.put(
                    "shipments",
                    shipments
            );

            // IMPORTANT
            String requestBody =
                    "format=json&data="
                            + URLEncoder.encode(
                            body.toString(),
                            "UTF-8"
                    );

            HttpEntity<String> request =
                    new HttpEntity<>(
                            requestBody,
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

            // IMPORTANT
            if (packages.length() == 0) {

                System.out.println(
                        "NO PACKAGE CREATED"
                );

                return;
            }

            JSONObject pkg =
                    packages.getJSONObject(0);

            String awb =
                    pkg.getString("waybill");

            // =========================
            // SAVE DB
            // =========================

            order.setAwbCode(awb);

            order.setCourierName(
                    "Delhivery"
            );

            order.setShipmentStatus(
                    "Packed"
            );

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