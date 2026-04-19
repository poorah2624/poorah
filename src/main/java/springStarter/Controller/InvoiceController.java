package springStarter.Controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import springStarter.models.Order_item;
import springStarter.repository.OrderItemRepo;
import springStarter.services.InvoiceService;

@Controller
public class InvoiceController {
	
	@Autowired
	private OrderItemRepo orderItemRepo;
	
	private InvoiceService invoiceService;
	
	@GetMapping("/order/invoice/{orderItemId}")
	public void downloadInvoice(@PathVariable Long orderItemId,
	                            HttpServletResponse response) throws Exception {

	    Order_item item = orderItemRepo.findById(orderItemId).orElse(null);

	    if(item == null) return;

	    response.setContentType("application/pdf");
	    response.setHeader("Content-Disposition", "attachment; filename=invoice.pdf");

	    invoiceService.generateInvoice(item, response);
	}

}
