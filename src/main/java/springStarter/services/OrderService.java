package springStarter.services;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.razorpay.RazorpayClient;
import com.razorpay.Refund;

import springStarter.models.Address;
import springStarter.models.Cart;
import springStarter.models.ExchangeRequest;
import springStarter.models.Order_item;
import springStarter.models.Orders;
import springStarter.models.Payment;
import springStarter.models.ReturnRequest;
import springStarter.models.User;
import springStarter.repository.AddressRepo;
import springStarter.repository.CartRepo;
import springStarter.repository.ExchangeRequestRepo;
import springStarter.repository.OrderItemRepo;
import springStarter.repository.OrderRepo;
import springStarter.repository.PaymentRepo;
import springStarter.repository.ReturnRequestRepo;

@Service
@Transactional
public class OrderService {

	@Autowired
	private CartRepo cartRepo;

	@Autowired
	private AddressRepo addressRepo;

	@Autowired
	private OrderRepo orderRepo;

	@Autowired
	private PaymentRepo paymentRepo;

	@Autowired
	private CartService cartService;

	@Autowired
	private EmailService emailService;

	public void placeOrder(User user, Long addressId, String paymentMethod, HttpSession session,
	        String razorpayPaymentId, String razorpayOrderId) {

	    Long buyNowItemId = (Long) session.getAttribute("buyNowItemId");

	    List<Cart> cartItems = new ArrayList<>();

	    if (buyNowItemId != null) {
	        Cart temp = cartService.getTempCartItem(buyNowItemId, user);

	        if (temp == null) {
	            throw new RuntimeException("Buy Now item not found");
	        }

	        cartItems.add(temp);
	    } else {
	        cartItems = cartRepo.findByUser(user);
	    }

	    if (cartItems.isEmpty()) {
	        throw new RuntimeException("Cart is empty");
	    }

	    Address address = addressRepo.findById(addressId)
	            .orElseThrow(() -> new RuntimeException("Invalid address"));

	    // ✅ CREATE ORDER
	    Orders order = new Orders();
	    order.setUser(user);
	    order.setOrderNumber("ORD" + System.currentTimeMillis());
	    order.setStatus("Pending");
	    order.setPaymentMethod(paymentMethod);
	    order.setPaymentStatus("Pending");
	    order.setOrderDate(LocalDateTime.now());
	    order.setEstimatedDeliveryDate(LocalDate.now().plusDays(5).toString());
	    order.setAddress(address);

	    BigDecimal total = BigDecimal.ZERO;
	    List<Order_item> orderItems = new ArrayList<>();
	    int totalQty = 0;

	    // ✅ ITEMS LOOP
	    for (Cart cart : cartItems) {

	        Order_item item = new Order_item();

	        item.setOrder(order);
	        //item.setItem(cart.getItem());
	        item.setQuantity(cart.getQuantity());
	        item.setSize(cart.getSize());
	        item.setAge(cart.getAge());
	        item.setStatus("Pending");
	        item.setIsCancelled(false);
	        item.setRefundStatus("None");
	        
	        if (cart.getIsCustom() != null && cart.getIsCustom()) {

	            item.setIsCustom(true);
	            item.setItem(null);

	            item.setCustomImage(cart.getCustomImage());
	            item.setColor(cart.getColor());
	            item.setTshirtType(cart.getTshirtType());
	            item.setGender(cart.getGender());
	            item.setCustomNote(cart.getCustomNote());

	        } else {

	            item.setIsCustom(false);
	            item.setItem(cart.getItem());
	        }
	        
	        BigDecimal price;
	        BigDecimal discountAmount;
	        BigDecimal finalPrice;

	        if (cart.getIsCustom() != null && cart.getIsCustom()) {
	            price = cart.getTotalPrice();
	        } else {
	            price = cart.getItem().getItemPrice();
	        }
	        
	        BigDecimal discountPercent;
	        BigDecimal quantity = BigDecimal.valueOf(cart.getQuantity());  
          
	        if (cart.getIsCustom() != null && cart.getIsCustom()) {
	            discountPercent = new BigDecimal("10"); 
	        } else {
	            discountPercent = cart.getItem().getDiscount();
	        }

	        discountAmount = price.multiply(discountPercent)
	                .divide(BigDecimal.valueOf(100));

	        BigDecimal discountedPrice = price.subtract(discountAmount);
	        finalPrice = discountedPrice.multiply(quantity);

	        item.setPrice(price);
	        item.setDiscount(discountAmount);
	        item.setFinalPrice(finalPrice);

	        total = total.add(finalPrice);
	        totalQty += cart.getQuantity();

	        orderItems.add(item);
	    }

	    // ✅ DELIVERY CHARGE LOGIC
	    BigDecimal deliveryCharge;
	    if (total.compareTo(BigDecimal.valueOf(500)) > 0) {
	        deliveryCharge = BigDecimal.ZERO;
	    } else {
	        deliveryCharge = BigDecimal.valueOf(50);
	    }

	    BigDecimal finalAmount = total.add(deliveryCharge);

	    // ✅ SET ORDER VALUES
	    order.setItems(orderItems);
	    order.setDiscountedPrice(total);
	    order.setQuantity(totalQty);
	    order.setTotalAmount(finalAmount);
	    order.setDeliveryCharge(deliveryCharge);

	    // =========================
	    // ✅ PAYMENT CREATE
	    // =========================
	    Payment payment = new Payment();

	    payment.setOrder(order);
	    order.setPayment(payment); 

	    payment.setPaymentMethod(paymentMethod);
	    payment.setPaymentDate(LocalDateTime.now());
	    payment.setAmount(finalAmount); 

	    if ("COD".equals(paymentMethod)) {

	        payment.setPaymentStatus("Pending");

	        order.setPaymentMethod("COD");
	        order.setPaymentStatus("Pending");

	    } else {

	        if (razorpayPaymentId != null && !razorpayPaymentId.isEmpty()) {

	            payment.setRazorpayPaymentId(razorpayPaymentId);
	            payment.setRazorpayOrderId(razorpayOrderId);
	            payment.setPaymentStatus("Paid");

	            order.setPaymentMethod("ONLINE");
	            order.setPaymentStatus("Paid");

	        } else {
	            System.out.println("⚠️ Razorpay Payment ID missing");
	        }
	    }
	    orderRepo.save(order);

	    StringBuilder items = new StringBuilder();

	    for (Order_item i : order.getItems()) {
	        String price = i.getFinalPrice()
	                .setScale(0, RoundingMode.HALF_UP)
	                .toPlainString();
	        if (i.getIsCustom() != null && i.getIsCustom()) {

	            items.append("• Custom T-Shirt")
	                    .append(" (Qty: ").append(i.getQuantity()).append(")")
	                    .append(" - ₹").append(price)
	                    .append("\n");

	        }
	        else
	        {
	        items.append("• ")
	                .append(i.getItem().getItemName())
	                .append(" (Qty: ")
	                .append(i.getQuantity())
	                .append(")")
	                .append(" - ₹")
	                .append(price)
	                .append("\n");
	        }
	    }

	    emailService.sendOrderMail(order, items.toString());

	    if (buyNowItemId == null) {
	        cartRepo.deleteAll(cartItems);
	    } else {
	        session.removeAttribute("buyNowItemId");
	    }
	}

	public void updateOrderStatus(Long orderId, String status) {

		Orders order = orderRepo.findById(orderId).orElseThrow(() -> new RuntimeException("Order not found"));

		order.setStatus(status);

		// optional logic
		for (Order_item item : order.getItems()) {
	        item.setStatus(status);

	        // optional item level timestamps
	        if ("Packed".equalsIgnoreCase(status)) {
	            order.setPackedDate(LocalDateTime.now());
	        }

	        if ("Shipped".equalsIgnoreCase(status)) {
	            order.setShippedDate(LocalDateTime.now());
	        }

	        if ("Delivered".equalsIgnoreCase(status)) {
	            order.setDeliveredDate(LocalDateTime.now());
	        }

	        if ("Cancelled".equalsIgnoreCase(status)) {
	            item.setIsCancelled(true);
	        }
	    }

	    if ("Delivered".equalsIgnoreCase(status)) {
	        order.setPaymentStatus("Paid");
	    }

	    if ("Cancelled".equalsIgnoreCase(status)) {
	        order.setPaymentStatus("Cancelled");
	    }

	    orderRepo.save(order);

	}

	public Orders getOrderById(Long id) {
		return orderRepo.findById(id).orElseThrow(() -> new RuntimeException("Order not found"));
	}

	public Order_item getOrderItemById(Long orderItemId) {
		return orderItemRepo.findById(orderItemId).orElseThrow(() -> new RuntimeException("Order Item not found"));
	}

	public boolean cancelOrderItem(Long orderItemId, Long userId) {

		Optional<Order_item> optionalItem = orderItemRepo.findById(orderItemId);

		if (!optionalItem.isPresent())
			return false;

		Order_item item = optionalItem.get();

		// user validation
		if (!item.getOrder().getUser().getId().equals(userId))
			return false;

		// status check
		if (!item.getStatus().equals("Pending") && !item.getStatus().equals("Processing") && !item.getStatus().equals("Packed")) {
			return false;
		}

		Orders order = item.getOrder();
		
		if (!"COD".equals(order.getPaymentMethod())) {
	        item.setRefundStatus("Pending");
	        item.setCancelledAt(LocalDateTime.now()); 
	    } else {
	        item.setRefundStatus("Not Required");
	    }

		item.setStatus("Cancelled");
		item.setIsCancelled(true);

		orderItemRepo.save(item);

		updateOrderStatusAfterItemChange(item.getOrder());

		return true;
	}

	private void updateOrderStatusAfterItemChange(Orders order) {

		List<Order_item> items = order.getItems();

		boolean allCancelled = true;
		boolean allDelivered = true;
		boolean allCompleted = true; 

		for (Order_item item : items) {
			String status = item.getStatus();

			if (!"Cancelled".equals(item.getStatus())) {
				allCancelled = false;
			}

			if (!"Delivered".equals(item.getStatus())) {
				allDelivered = false;
			}
			if (!(status.equalsIgnoreCase("Delivered") ||
		              status.equalsIgnoreCase("Returned") ||
		              status.equalsIgnoreCase("Cancelled"))) {

		            allCompleted = false;
		        }
		}

		if (allCancelled) {
			order.setStatus("Cancelled");
		} else if (allDelivered) {
			order.setStatus("Delivered");
		} else if (allCompleted) {
	        order.setStatus("Completed");
	    } else {
	        order.setStatus("Active");
	    }

		orderRepo.save(order);
	}

	@Autowired
	private ReturnRequestRepo returnRequestRepo;

	public boolean returnOrderItem(Long orderItemId, Long userId, String reason) {

		Optional<Order_item> optionalItem = orderItemRepo.findById(orderItemId);

		if (!optionalItem.isPresent())
			return false;

		Order_item item = optionalItem.get();

		if (!item.getOrder().getUser().getId().equals(userId))
			return false;

		if (!"Delivered".equals(item.getOrder().getStatus()))
			return false;

		List<ReturnRequest> existing = returnRequestRepo.findByOrderItem(item);

	    ReturnRequest req;

	    if (!existing.isEmpty()) {
	        req = existing.get(0);
	        if ("Cancelled by User".equals(req.getStatus()) || "Rejected".equals(req.getStatus())) 
	        {
	            req.setStatus("Requested");
	            req.setReason(reason);
	        } else {
	            return false;
	        }

	    } else {
	        req = new ReturnRequest();
	        req.setOrderItem(item);
	        req.setReason(reason);
	        req.setStatus("Requested");
	    }
	    
	    item.setReturnRequested(true);
	    item.setReturnStatus("Requested");
	    item.setReturnPickupDate(LocalDate.now().plusDays(2).toString());

	    returnRequestRepo.save(req);
	    orderItemRepo.save(item);

	    return true;
	}

	@Autowired
	private OrderItemRepo orderItemRepo;

	@Autowired
	private ExchangeRequestRepo exchangeRequestRepo;

	public boolean exchangeOrderItem(Long orderItemId, Long userId, String newSize) {

		Optional<Order_item> optionalItem = orderItemRepo.findById(orderItemId);

		if (!optionalItem.isPresent())
			return false;

		Order_item item = optionalItem.get();

		if (!item.getOrder().getUser().getId().equals(userId))
			return false;

		if (!"Delivered".equals(item.getOrder().getStatus()))
			return false;

		ExchangeRequest req = new ExchangeRequest();
		req.setOrderItem(item);
		req.setNewSize(newSize);
		req.setStatus("Requested");

		item.setExchangeRequested(true);
		item.setNewSize(newSize);
		item.setExchangeStatus("Requested");

		// Delivery (5 days)
		item.setExchangeDeliveryDate(LocalDate.now().plusDays(5).toString());

		exchangeRequestRepo.save(req);

		return true;
	}

	// return approve
	public boolean approveReturn(Long orderItemId) {

		Optional<Order_item> optionalItem = orderItemRepo.findById(orderItemId);

		if (!optionalItem.isPresent())
			return false;

		Order_item item = optionalItem.get();

		if (!"Requested".equals(item.getReturnStatus()))
			return false;

		item.setReturnStatus("Approved");

		item.setReturnPickupDate(LocalDate.now().plusDays(2).toString());

		orderItemRepo.save(item);

		List<ReturnRequest> requests = returnRequestRepo.findByOrderItem(item);

		if (!requests.isEmpty()) {
			ReturnRequest req = requests.get(0);
			req.setStatus("Approved"); // or Picked / Rejected
			returnRequestRepo.save(req);
		}

		return true;
	}

	// return refund
	public boolean markReturnPicked(Long orderItemId) {

		Order_item item = orderItemRepo.findById(orderItemId).get();

		if (!"Approved".equals(item.getReturnStatus()))
			return false;

		// double refund protection
		if ("Processed".equals(item.getRefundStatus()))
			return false;

		Orders order = item.getOrder();
		Payment payment = order.getPayment();

		if (payment == null) {
		    System.out.println("⚠️ Payment not found");
		    return false;
		}

		System.out.println("Payment: " + payment);
		System.out.println("Razorpay ID: " + (payment != null ? payment.getRazorpayPaymentId() : "NULL"));

		if (!processRefund(item, order, payment)) {
	        return false;
	    }

		item.setReturnStatus("Picked");
		item.setStatus("Returned");

		List<ReturnRequest> requests = returnRequestRepo.findByOrderItem(item);

		if (!requests.isEmpty()) {
			ReturnRequest req = requests.get(0);
			req.setStatus("Picked");
			returnRequestRepo.save(req);
		}
		updateOrderStatusAfterItemChange(order);
		orderItemRepo.save(item);

		return true;
	}

	public boolean rejectReturn(Long orderItemId) {

		Optional<Order_item> optionalItem = orderItemRepo.findById(orderItemId);

		if (!optionalItem.isPresent())
			return false;

		Order_item item = optionalItem.get();

		if (!"Requested".equals(item.getReturnStatus()))
			return false;

		item.setReturnStatus("Rejected");
		item.setRefundStatus("Not Applicable");

		orderItemRepo.save(item);

		List<ReturnRequest> requests = returnRequestRepo.findByOrderItem(item);

		if (!requests.isEmpty()) {
			ReturnRequest req = requests.get(0);
			req.setStatus("Rejected");
			returnRequestRepo.save(req);
		}

		return true;
	}
	
	public boolean revertCancel(Long orderItemId, Long userId) {

	    Order_item item = orderItemRepo.findById(orderItemId).orElse(null);

	    if(item == null) return false;

	    if(!item.getOrder().getUser().getId().equals(userId)) return false;

	    // only before refund
	    if(!"Cancelled".equals(item.getStatus()) 
	       || "Processed".equals(item.getRefundStatus())) {
	        return false;
	    }

	    // revert
	    item.setStatus("Pending");
	    item.setIsCancelled(false);
	    item.setRefundStatus("None");

	    orderItemRepo.save(item);

	    updateOrderStatusAfterItemChange(item.getOrder());

	    return true;
	}
	
	public boolean revertReturn(Long orderItemId, Long userId) {

	    Order_item item = orderItemRepo.findById(orderItemId).orElse(null);

	    if(item == null) return false;

	    if(!item.getOrder().getUser().getId().equals(userId)) return false;

	    if(!"Requested".equals(item.getReturnStatus()) 
	       && !"Approved".equals(item.getReturnStatus())) {
	        return false;
	    }

	    item.setReturnRequested(false);
	    item.setReturnStatus("Cancelled by User");
	    item.setReturnPickupDate(null);

	    orderItemRepo.save(item);
	    
	    List<ReturnRequest> requests = returnRequestRepo.findByOrderItem(item);

	    if (!requests.isEmpty()) {
	        ReturnRequest req = requests.get(0);

	        req.setStatus("Cancelled by User");

	        returnRequestRepo.save(req);
	    }

	    return true;
	}
	
	public boolean revertExchange(Long orderItemId, Long userId) {

	    Order_item item = orderItemRepo.findById(orderItemId).orElse(null);

	    if(item == null) return false;

	    if(!item.getOrder().getUser().getId().equals(userId)) return false;

	    if(!"Requested".equals(item.getExchangeStatus()) 
	       && !"Approved".equals(item.getExchangeStatus())) {
	        return false;
	    }

	    item.setExchangeRequested(false);
	    item.setExchangeStatus(null);
	    item.setNewSize(null);
	    item.setExchangeDeliveryDate(null);

	    orderItemRepo.save(item);

	    return true;
	}
	
	public boolean approveExchange(Long orderItemId) {

	    Order_item item = orderItemRepo.findById(orderItemId).orElse(null);

	    if (item == null) return false;

	    if (!"Requested".equals(item.getExchangeStatus())) return false;

	    item.setExchangeStatus("Approved");

	    orderItemRepo.save(item);

	    List<ExchangeRequest> requests = exchangeRequestRepo.findByOrderItem(item);

	    if (!requests.isEmpty()) {
	        ExchangeRequest req = requests.get(0);
	        req.setStatus("Approved");
	        exchangeRequestRepo.save(req);
	    }

	    return true;
	}
	
	public boolean rejectExchange(Long orderItemId) {

	    Order_item item = orderItemRepo.findById(orderItemId).orElse(null);

	    if (item == null) return false;

	    if (!"Requested".equals(item.getExchangeStatus())) return false;

	    item.setExchangeStatus("Rejected");

	    orderItemRepo.save(item);

	    List<ExchangeRequest> requests = exchangeRequestRepo.findByOrderItem(item);

	    if (!requests.isEmpty()) {
	        ExchangeRequest req = requests.get(0);
	        req.setStatus("Rejected");
	        exchangeRequestRepo.save(req);
	    }

	    return true;
	}
	
	public boolean shipExchange(Long orderItemId) {

	    Order_item item = orderItemRepo.findById(orderItemId).orElse(null);

	    if (item == null) return false;

	    if (!"Approved".equals(item.getExchangeStatus())) return false;

	    item.setExchangeStatus("Shipped");

	    orderItemRepo.save(item);

	    List<ExchangeRequest> requests = exchangeRequestRepo.findByOrderItem(item);

	    if (!requests.isEmpty()) {
	        ExchangeRequest req = requests.get(0);
	        req.setStatus("Shipped");
	        exchangeRequestRepo.save(req);
	    }

	    return true;
	}
	
	public boolean deliverExchange(Long orderItemId) {

	    Order_item item = orderItemRepo.findById(orderItemId).orElse(null);

	    if (item == null) return false;

	    if (!"Shipped".equals(item.getExchangeStatus())) return false;

	    item.setExchangeStatus("Delivered");

	    orderItemRepo.save(item);

	    List<ExchangeRequest> requests = exchangeRequestRepo.findByOrderItem(item);

	    if (!requests.isEmpty()) {
	        ExchangeRequest req = requests.get(0);
	        req.setStatus("Delivered");
	        exchangeRequestRepo.save(req);
	    }

	    return true;
	}
	
	@Scheduled(fixedDelay = 900000)
	public void processPendingRefunds() {

	    List<Order_item> items = orderItemRepo.findByRefundStatusAndStatus("Pending","Cancelled");

	    for (Order_item item : items) {

	        Orders order = item.getOrder();
	        Payment payment = order.getPayment();

	        processRefund(item, order, payment);
	    }
	}
	
	private boolean processRefund(Order_item item, Orders order, Payment payment) {

	    if ("COD".equals(order.getPaymentMethod())) {
	        item.setRefundStatus("Not Required");
	        return true;
	    }

	    try {
	        RazorpayClient client = new RazorpayClient("rzp_test_SXlvfKVfbzo45f", "dSXBfnLljl8vNuWK6KUnrBlO");

	        JSONObject refundRequest = new JSONObject();
	        BigDecimal refundAmount;

	        // ✅ check all items cancelled / returned
	        boolean allItemsDone = order.getItems().stream()
	                .allMatch(i -> 
	                    i.getIsCancelled() || 
	                    "Returned".equals(i.getStatus()) ||
	                    i.getId().equals(item.getId())
	                );

	        if (allItemsDone) {
	            refundAmount = order.getTotalAmount(); // include delivery
	        } else {
	            refundAmount = item.getFinalPrice(); // only item
	        }

	        BigDecimal paidAmount = payment.getAmount();

	        // ✅ rounding fix (important)
	        BigDecimal refundAmountRounded = refundAmount.setScale(0, RoundingMode.HALF_UP);
	        BigDecimal paidAmountRounded = paidAmount.setScale(0, RoundingMode.HALF_UP);

	        // NEVER exceed
	        if (refundAmountRounded.compareTo(paidAmountRounded) > 0) {
	            refundAmountRounded = paidAmountRounded;
	        }

	        refundRequest.put("amount",
	                refundAmountRounded.multiply(new BigDecimal(100)).intValue());

	        System.out.println("Refunding: " + refundAmountRounded);
	        System.out.println("Payment ID: " + payment.getRazorpayPaymentId());

	        client.payments.refund(payment.getRazorpayPaymentId(), refundRequest);

	        item.setRefundStatus("Processed");
	        return true;

	    } catch (Exception e) {
	        e.printStackTrace();
	        item.setRefundStatus("Failed");
	        return false;
	    }
	}

}
