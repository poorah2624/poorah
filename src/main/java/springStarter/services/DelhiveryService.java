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

                // PRODUCT NAME
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

                // SKU
                obj.put(
                        "sku",
                        "SKU-" + item.getId()
                );

                // QUANTITY
                obj.put(
                        "units",
                        item.getQuantity()
                );

                // PRICE
                obj.put(
                        "selling_price",
                        item.getFinalPrice()
                );

                orderItems.put(obj);
            }

            // =========================
            // SHIPMENT DATA
            // =========================

            JSONObject shipment =
                    new JSONObject();

            shipment.put(
                    "name",
                    order.getUser().getUserName()
            );

            shipment.put(
                    "add",
                    order.getAddress().getHouseNo()
                            + ", "
                            + order.getAddress().getArea()
                            + ", "
                            + order.getAddress().getLandmark()
            );

            shipment.put(
                    "city",
                    order.getAddress().getCity()
            );

            shipment.put(
                    "state",
                    order.getAddress().getState()
            );

            shipment.put(
                    "country",
                    "India"
            );

            shipment.put(
                    "pin",
                    order.getAddress().getPincode()
            );

            shipment.put(
                    "phone",
                    order.getAddress().getMobile()
            );

            shipment.put(
                    "email",
                    order.getUser().getUserEmail()
            );

            shipment.put(
                    "order",
                    order.getOrderNumber()
            );

            shipment.put(
                    "payment_mode",
                    "Paid".equalsIgnoreCase(
                            order.getPaymentStatus()
                    )
                            ? "Prepaid"
                            : "COD"
            );

            shipment.put(
                    "total_amount",
                    order.getTotalAmount()
            );

            shipment.put(
                    "quantity",
                    order.getQuantity()
            );

            shipment.put(
                    "products_desc",
                    "Fashion Products"
            );

            shipment.put(
                    "weight",
                    0.5
            );

            shipment.put(
                    "shipment_length",
                    10
            );

            shipment.put(
                    "shipment_width",
                    10
            );

            shipment.put(
                    "shipment_height",
                    2
            );

            // EXACT SAME AS PANEL PICKUP NAME
            shipment.put(
                    "seller_add",
                    "POORAH"
            );

         // =========================
         // SHIPMENTS ARRAY
         // =========================

         JSONArray shipments =
                 new JSONArray();

         shipments.put(shipment);

         // =========================
         // FINAL BODY
         // =========================

         JSONObject finalBody =
                 new JSONObject();

         finalBody.put(
                 "shipments",
                 shipments
         );

         // =========================
         // REQUEST BODY
         // =========================

         String requestBody =
                 "format=json&data="
                         + URLEncoder.encode(
                         finalBody.toString(),
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

            if (packages.length() == 0) {

                System.out.println(
                        "NO PACKAGE CREATED"
                );

                return;
            }

            JSONObject pkg =
                    packages.getJSONObject(0);

            String status =
                    pkg.getString("status");

            // =========================
            // SUCCESS
            // =========================

            if (status.equalsIgnoreCase("Success")) {

                String awb =
                        pkg.getString("waybill");

                order.setAwbCode(awb);

                order.setCourierName(
                        "Delhivery"
                );

                order.setShipmentStatus(
                        "Packed"
                );

                orderRepo.save(order);

                System.out.println(
                        "AWB SAVED: "
                                + awb
                );

            }

            // =========================
            // FAILED
            // =========================

            else {

                System.out.println(
                        "DELHIVERY FAILED: "
                                + pkg.toString()
                );
            }

        }

        catch (Exception e) {

            e.printStackTrace();
        }
    }
}