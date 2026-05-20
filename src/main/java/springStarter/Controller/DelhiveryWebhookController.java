package springStarter.Controller;

import java.util.Map;

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
            @RequestBody Map<String,Object> payload) {

        String awb =
            payload.get("awb").toString();

        String status =
            payload.get("status").toString();

        Orders order =
            orderRepo.findByAwbCode(awb);

        if(order != null) {

            order.setShipmentStatus(status);

            if(status.equalsIgnoreCase("In Transit")) {

                order.setStatus("Shipped");
            }

            else if(status.equalsIgnoreCase("Out For Delivery")) {

                order.setStatus("Out for delivery");
            }

            else if(status.equalsIgnoreCase("Delivered")) {

                order.setStatus("Delivered");
            }

            orderRepo.save(order);
        }

        return "OK";
    }
}
