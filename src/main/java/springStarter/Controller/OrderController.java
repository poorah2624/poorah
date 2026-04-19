package springStarter.Controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import springStarter.models.Admin;
import springStarter.models.Category;
import springStarter.models.ExchangeRequest;
import springStarter.models.Order_item;
import springStarter.models.Orders;
import springStarter.models.ReturnRequest;
import springStarter.models.User;
import springStarter.repository.ExchangeRequestRepo;
import springStarter.repository.OrderItemRepo;
import springStarter.repository.OrderRepo;
import springStarter.repository.ReturnRequestRepo;
import springStarter.services.CategoryService;
import springStarter.services.OrderService;

@Controller
public class OrderController {
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private OrderRepo orderRepo;
	
	@Autowired
	private OrderService orderService;
	
	
	
	@GetMapping("/invoice")
	public String invoice() {
		return "admin/invoice";
	}
	
	
	@GetMapping("/myOrders")
	public String myOrders(HttpSession session, Model model){

	    User user = (User) session.getAttribute("LoggedInUser");
	    if(user == null){
	        return "redirect:/userlogin";
	    }

	    List<Orders> orders = orderRepo.findByUserOrderByOrderDateDesc(user);

	    model.addAttribute("orders", orders);
	    
	    List<Category> categories = categoryService.getAllCategories();

	    model.addAttribute("categories", categories);

	    return "myOrders";
	}
	
	@GetMapping("/orderSuccess")
	public String orderSuccess(Model model, HttpSession session) {
		
		User user = (User) session.getAttribute("LoggedInUser");
	    if(user == null){
	        return "redirect:/userlogin";
	    }
		
		List<Category> categories = categoryService.getAllCategories();

	    model.addAttribute("categories", categories);
		
		return "orderSuccess";
	}
	
	@GetMapping("/orderFailed")
	public String orderFailed(Model model, HttpSession session){
		
		User user = (User) session.getAttribute("LoggedInUser");
	    if(user == null){
	        return "redirect:/userlogin";
	    }
	    
		List<Category> categories = categoryService.getAllCategories();

	    model.addAttribute("categories", categories);
	    return "orderFailed";
	}
	
	@GetMapping("/manage_order")
	public String manage_order(HttpSession session, Model model) {
		
		Admin admin = (Admin) session.getAttribute("LoggedInAdmin");
	    if(admin == null){
	        return "admin/adminLogin";
	    }
	    List<Orders> orders = orderRepo.findAllByOrderByOrderDateDesc();
	    model.addAttribute("orders", orders);
	    		
		return "admin/manage_order";
	}
	
	@GetMapping("/order_History")
	public String order_History(HttpSession session, Model model) {
		
		Admin admin = (Admin) session.getAttribute("LoggedInAdmin");
	    if(admin == null){
	        return "admin/adminLogin";
	    }
	    List<Orders> orders = orderRepo.findByStatusOrderByOrderDateDesc("Delivered");
	    model.addAttribute("orders", orders);
	    		
		return "admin/order_History";
	}
	
	@Autowired
	private ReturnRequestRepo returnRequestRepo;
	
	@Autowired
	private OrderItemRepo orderItemRepo;
	
	@GetMapping("/returns")
	public String returns(HttpSession session, Model model) {
		
		Admin admin = (Admin) session.getAttribute("LoggedInAdmin");
	    if(admin == null){
	        return "admin/adminLogin";
	    }	    
	    
	    List<ReturnRequest> returns = returnRequestRepo.findAllByOrderByReturnIdDesc();
	    model.addAttribute("returns", returns);
	    		
		return "admin/returns";
	}
	
	@Autowired
	private ExchangeRequestRepo exchangeReqRepo;
	
	@GetMapping("/exchange")
	public String exchange(HttpSession session, Model model) {
		
		Admin admin = (Admin) session.getAttribute("LoggedInAdmin");
	    if(admin == null){
	        return "admin/adminLogin";
	    }	    
	    
	    List<ExchangeRequest> exchange = exchangeReqRepo.findAllByOrderByExchangeIdDesc();
	    model.addAttribute("exchange", exchange);
	    		
		return "admin/exchange";
	}
	
	@GetMapping("/order/details")
	public String orderDetails(@RequestParam Long orderItemId, Model model, HttpSession session) {

	    User user = (User) session.getAttribute("LoggedInUser");
	    if(user == null) return "redirect:/userlogin";
	    
	    List<Category> categories = categoryService.getAllCategories();

	    model.addAttribute("categories", categories);

	    Order_item item = orderService.getOrderItemById(orderItemId);
	    
	    if(!item.getOrder().getUser().getId().equals(user.getId())) {
	        return "redirect:/myOrders";
	    }

	    model.addAttribute("item", item);
	    
	    

	    return "orderDetails";
	}
	
	@GetMapping("/updateOrder")
	public String updateOrder(@RequestParam Long id,
           Model model) {
		
		Orders order = orderService.getOrderById(id);

	    model.addAttribute("order", order);
		
		return "admin/updateOrder";
	}
	
	@PostMapping("/updateOrder")
	public String updateOrder(@RequestParam Long orderId,
	                          @RequestParam String status){
		

	    orderService.updateOrderStatus(orderId, status);

	    return "redirect:/manage_order";
	}
	
	@PostMapping("/order/cancel-item")
	public String cancelItem(@RequestParam Long orderItemId,
	                         HttpSession session,
	                         RedirectAttributes redirectAttrs) {

	    User user = (User) session.getAttribute("LoggedInUser");

	    boolean success = orderService.cancelOrderItem(orderItemId, user.getId());

	    redirectAttrs.addFlashAttribute("msg",
	        success ? "Item cancelled successfully" : "Cancel failed");

	    return "redirect:/myOrders";
	}

	@PostMapping("/order/return")
	public String returnOrder(@RequestParam Long orderItemId,
	                          @RequestParam String reason,
	                          HttpSession session,
	                          RedirectAttributes redirectAttrs) {

	    User user = (User) session.getAttribute("LoggedInUser");

	    boolean success = orderService.returnOrderItem(orderItemId, user.getId(), reason);

	    redirectAttrs.addFlashAttribute("msg", success ? "Return requested" : "Error");

	    return "redirect:/myOrders";
	}

	@PostMapping("/order/exchange")
	public String exchangeOrder(@RequestParam Long orderItemId,
	                            @RequestParam String newSize,
	                            HttpSession session,
	                            RedirectAttributes redirectAttrs) {

	    User user = (User) session.getAttribute("LoggedInUser");

	    boolean success = orderService.exchangeOrderItem(orderItemId, user.getId(), newSize);

	    redirectAttrs.addFlashAttribute("msg", success ? "Exchange requested" : "Error");

	    return "redirect:/myOrders";
	}
	
	
	@PostMapping("/admin/approve-return")
	public String approveReturn(@RequestParam Long orderItemId,
	                           RedirectAttributes redirectAttributes){

	    boolean success = orderService.approveReturn(orderItemId);

	    redirectAttributes.addFlashAttribute("msg",
	        success ? "Return Approved & Refund Done" : "Failed");

	    return "redirect:/returns";
	}
	
	@PostMapping("/admin/reject-return")
	public String rejectReturn(@RequestParam Long orderItemId,
	                          RedirectAttributes redirectAttributes){

	    boolean success = orderService.rejectReturn(orderItemId);

	    redirectAttributes.addFlashAttribute("msg",
	        success ? "Return Rejected" : "Failed");

	    return "redirect:/returns";
	}
	
	@PostMapping("/admin/mark-picked")
	public String markPicked(@RequestParam Long orderItemId,
	                        RedirectAttributes redirectAttributes){

	    boolean success = orderService.markReturnPicked(orderItemId);

	    redirectAttributes.addFlashAttribute("msg",
	        success ? "Product Picked & Refund Done" : "Failed");

	    return "redirect:/returns";
	}
	
	@PostMapping("/order/revert-cancel")
	public String revertCancel(@RequestParam Long orderItemId,
	                           HttpSession session,
	                           RedirectAttributes redirectAttrs) {

	    User user = (User) session.getAttribute("LoggedInUser");

	    boolean success = orderService.revertCancel(orderItemId, user.getId());

	    redirectAttrs.addFlashAttribute("msg",
	        success ? "Cancel reverted successfully" : "Revert failed");

	    return "redirect:/myOrders";
	}
	
	@PostMapping("/order/revert-return")
	public String revertReturn(@RequestParam Long orderItemId,
	                           HttpSession session,
	                           RedirectAttributes redirectAttrs) {

	    User user = (User) session.getAttribute("LoggedInUser");

	    boolean success = orderService.revertReturn(orderItemId, user.getId());

	    redirectAttrs.addFlashAttribute("msg",
	        success ? "Return request cancelled" : "Failed");

	    return "redirect:/myOrders";
	}
	
	@PostMapping("/order/revert-exchange")
	public String revertExchange(@RequestParam Long orderItemId,
	                             HttpSession session,
	                             RedirectAttributes redirectAttrs) {

	    User user = (User) session.getAttribute("LoggedInUser");

	    boolean success = orderService.revertExchange(orderItemId, user.getId());

	    redirectAttrs.addFlashAttribute("msg",
	        success ? "Exchange cancelled" : "Failed");

	    return "redirect:/myOrders";
	}
	
	@PostMapping("/admin/approve-exchange")
	public String approveExchange(@RequestParam Long orderItemId,
	                              RedirectAttributes redirectAttributes) {

	    boolean success = orderService.approveExchange(orderItemId);

	    redirectAttributes.addFlashAttribute("msg",
	            success ? "Exchange Approved" : "Failed");

	    return "redirect:/exchange";
	}
	
	@PostMapping("/admin/reject-exchange")
	public String rejectExchange(@RequestParam Long orderItemId,
	                             RedirectAttributes redirectAttributes) {

	    boolean success = orderService.rejectExchange(orderItemId);

	    redirectAttributes.addFlashAttribute("msg",
	            success ? "Exchange Rejected" : "Failed");

	    return "redirect:/exchange";
	}
	
	@PostMapping("/admin/ship-exchange")
	public String shipExchange(@RequestParam Long orderItemId,
	                           RedirectAttributes redirectAttributes) {

	    boolean success = orderService.shipExchange(orderItemId);

	    redirectAttributes.addFlashAttribute("msg",
	            success ? "Item Shipped" : "Failed");

	    return "redirect:/exchange";
	}
	
	@PostMapping("/admin/deliver-exchange")
	public String deliverExchange(@RequestParam Long orderItemId,
	                              RedirectAttributes redirectAttributes) {

	    boolean success = orderService.deliverExchange(orderItemId);

	    redirectAttributes.addFlashAttribute("msg",
	            success ? "Exchange Completed" : "Failed");

	    return "redirect:/exchange";
	}
	
	


}
