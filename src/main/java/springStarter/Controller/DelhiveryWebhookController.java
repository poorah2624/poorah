package springStarter.Controller;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import springStarter.models.Orders;
import springStarter.repository.OrderRepo;

@Controller
public class DelhiveryWebhookController {

    @Autowired
    private OrderRepo orderRepo;

    @PostMapping("/delhivery/webhook")
    @ResponseBody
    public String webhook(
            @RequestBody String payload) {

        try {

            System.out.println(
                    "WEBHOOK: " + payload
            );

            JSONObject json =
                    new JSONObject(payload);

            String awb =
                    json.optString("awb");

            String status =
                    json.optString("status");

            Orders order =
                    orderRepo.findByAwbCode(awb);

            if(order != null) {

                order.setShipmentStatus(status);

                if(status.equalsIgnoreCase(
                        "In Transit")) {

                    order.setStatus(
                            "Shipped"
                    );
                }

                else if(status.equalsIgnoreCase(
                        "Out For Delivery")) {

                    order.setStatus(
                            "Out for delivery"
                    );
                }

                else if(status.equalsIgnoreCase(
                        "Delivered")) {

                    order.setStatus(
                            "Delivered"
                    );
                }

                orderRepo.save(order);
            }

        }

        catch(Exception e) {

            e.printStackTrace();
        }

        return "OK";
    }
}