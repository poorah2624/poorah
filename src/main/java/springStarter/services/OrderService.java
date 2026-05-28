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
	
	@Autowired
	private ShiprocketService shiprocketService;
	
	@Autowired
	private DelhiveryService delhiveryService;

	@Autowired
	private OrderItemRepo orderItemRepo;

	@Autowired
	private ReturnRequestRepo returnRequestRepo;

	@Autowired
	private ExchangeRequestRepo exchangeRequestRepo;

	public void placeOrder(User user, Long addressId, String paymentMethod, HttpSession session,
	        String razorpayPaymentId, String razorpayOrderId, String noReturnDiscount) {

	    Long buyNowItemId = (Long) session.getAttribute("buyNowItemId");
	    List<Cart> cartItems = new ArrayList<>();

	    if (buyNowItemId != null) {
	        Cart temp = cartService.getTempCartItem(buyNowItemId, user, null);
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

	 
	    String[] discountFlags = (noReturnDiscount != null) ? noReturnDiscount.split(",") : new String[0];

	    BigDecimal total = BigDecimal.ZERO;
	    List<Order_item> orderItems = new ArrayList<>();
	    int totalQty = 0;
	    String category = null;

	    // ✅ ITEMS LOOP
	    for (int i = 0; i < cartItems.size(); i++) {
	        Cart cart = cartItems.get(i);
	    	
	    	if (category == null) {
	    	    if (cart.getItem() != null && cart.getItem().getCategory() != null) {
	    	        category = cart.getItem().getCategory().getCategoryName();
	    	    } else {
	    	        category = "CUSTOM";
	    	    }
	    	}

	        Order_item item = new Order_item();
	        item.setOrder(order);
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
	        
	        BigDecimal basePrice = (cart.getIsCustom() != null && cart.getIsCustom()) ? cart.getTotalPrice() : cart.getItem().getItemPrice();
	        BigDecimal quantity = BigDecimal.valueOf(cart.getQuantity());  
	        BigDecimal discountPercent = (cart.getIsCustom() != null && cart.getIsCustom()) ? new BigDecimal("10") : cart.getItem().getDiscount();

	      
	        BigDecimal discountAmount = basePrice.multiply(discountPercent).divide(BigDecimal.valueOf(100));
	        BigDecimal finalPriceBeforeNoReturn = basePrice.subtract(discountAmount);

	        boolean isItemNoReturn = false;
	        if (i < discountFlags.length && "YES".equalsIgnoreCase(discountFlags[i].trim())) {
	            isItemNoReturn = true;
	            BigDecimal noReturnDiscountAmt = finalPriceBeforeNoReturn.multiply(new BigDecimal("8")).divide(BigDecimal.valueOf(100));
	            discountAmount = discountAmount.add(noReturnDiscountAmt);
	            finalPriceBeforeNoReturn = finalPriceBeforeNoReturn.subtract(noReturnDiscountAmt);
	        }
	        item.setNoReturnOrder(isItemNoReturn);

	        BigDecimal finalPrice = finalPriceBeforeNoReturn.multiply(quantity).setScale(0, RoundingMode.HALF_UP);

	        item.setPrice(basePrice.setScale(0, RoundingMode.HALF_UP));
	        item.setDiscount(discountAmount.setScale(0, RoundingMode.HALF_UP));
	        item.setFinalPrice(finalPrice);

	        total = total.add(finalPrice);
	        totalQty += cart.getQuantity();

	        orderItems.add(item);
	    }

	    // ✅ DELIVERY CHARGE LOGIC
	    BigDecimal deliveryCharge = total.compareTo(BigDecimal.valueOf(500)) > 0 ? BigDecimal.ZERO : BigDecimal.valueOf(50);
	    BigDecimal finalAmount = total.add(deliveryCharge).setScale(0, RoundingMode.HALF_UP); 

	    // ✅ SET ORDER VALUES
	    order.setItems(orderItems);
	    order.setDiscountedPrice(total.setScale(0, RoundingMode.HALF_UP));
	    order.setQuantity(totalQty);
	    order.setTotalAmount(finalAmount);
	    order.setDeliveryCharge(deliveryCharge.setScale(0, RoundingMode.HALF_UP));
	    order.setCategory(category);

	    Payment payment = new Payment();
	    payment.setOrder(order);
	    order.setPayment(payment); 
	    payment.setPaymentMethod(paymentMethod);
	    payment.setPaymentDate(LocalDateTime.now());
	    
	    if ("PARTIAL_COD".equals(paymentMethod)) {
	    	BigDecimal advanceAmount = finalAmount.multiply(new BigDecimal("0.4")).setScale(0, RoundingMode.HALF_UP);
	        payment.setAmount(advanceAmount);
	        if (razorpayPaymentId != null && !razorpayPaymentId.isEmpty()) {
	        	payment.setRazorpayPaymentId(razorpayPaymentId);
	            payment.setRazorpayOrderId(razorpayOrderId);
	            payment.setPaymentStatus("Partially Paid");
		        order.setPaymentMethod("PARTIAL_COD");
		        order.setPaymentStatus("Partially Paid");
	        }
	        else {
	            System.out.println("⚠️ Razorpay Payment ID missing for partial COD.");
	        }
	        
	    } else {
	    	payment.setAmount(finalAmount);
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
	    
	    try {
          
            if ("ONLINE".equals(paymentMethod) && (razorpayPaymentId == null || razorpayPaymentId.isEmpty())) {
                System.out.println("⚠️ Order " + order.getOrderNumber() + " is ONLINE but Razorpay ID missing. Postponing Shiprocket sync.");
            } else {
                shiprocketService.createOrder(order);
                delhiveryService.createShipment(order);
                System.out.println("🚀 Order " + order.getOrderNumber() + " automatically synced to Shiprocket!");
            }
        } catch (Exception e) {
            
            System.out.println("❌ Automatic Shiprocket Sync Failed: " + e.getMessage());
        }

	    StringBuilder items = new StringBuilder();
	    for (Order_item i : order.getItems()) {
	        String priceStr = i.getFinalPrice().setScale(0, RoundingMode.HALF_UP).toPlainString();
	        if (i.getIsCustom() != null && i.getIsCustom()) {
	            items.append("• Custom T-Shirt (Qty: ").append(i.getQuantity()).append(") - ₹").append(priceStr).append("\n");
	        } else {
	            items.append("• ").append(i.getItem().getItemName()).append(" (Qty: ").append(i.getQuantity()).append(") - ₹").append(priceStr).append("\n");
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

		if ("Cancel".equalsIgnoreCase(status)) {
			status = "Cancelled";
		}
		order.setStatus(status);
		
		/* if ("Packed".equalsIgnoreCase(status)) {
			shiprocketService.createOrder(order);
			delhiveryService.createShipment(order);
		} */

		for (Order_item item : order.getItems()) {
			item.setStatus(status);
			if ("Packed".equalsIgnoreCase(status)) order.setPackedDate(LocalDateTime.now());
			if ("Shipped".equalsIgnoreCase(status)) order.setShippedDate(LocalDateTime.now());
			if ("Delivered".equalsIgnoreCase(status)) order.setDeliveredDate(LocalDateTime.now());

			if ("Cancelled".equalsIgnoreCase(status)) {
				item.setIsCancelled(true);
				item.setStatus("Cancelled");
				item.setRefundStatus("Pending");
				item.setCancelledAt(LocalDateTime.now());
			}
		}

		if ("Delivered".equalsIgnoreCase(status)) {
			order.setPaymentStatus("PARTIAL_COD".equals(order.getPaymentMethod()) ? "COD Partial" : "Paid");
		}

		if ("Cancelled".equalsIgnoreCase(status)) {
			order.setPaymentStatus("Cancelled");
			orderRepo.save(order); 
			try {
	            shiprocketService.cancelOrderInShiprocket(order);
	            System.out.println("🛑 Successfully triggered full cancellation in Shiprocket for: " + order.getOrderNumber());
	        } catch (Exception e) {
	            System.out.println("⚠️ Shiprocket API automation error: " + e.getMessage());
	        }
			for (Order_item item : order.getItems()) {
				processRefund(item, order, order.getPayment());
			}
		} else {
			orderRepo.save(order);
		}
	}

	private boolean processRefund(Order_item item, Orders order, Payment payment) {
	    if ("COD".equals(order.getPaymentMethod())) {
	        item.setRefundStatus("Not Required");
	        return true;
	    }
	    
	    if (payment == null || payment.getRazorpayPaymentId() == null || payment.getRazorpayPaymentId().isEmpty()) {
	        item.setRefundStatus("Not Required (Unpaid)");
	        return true;
	    }

	    try {
	        RazorpayClient client = new RazorpayClient("rzp_live_SjF1cX3eDU1byW", "xkrdODrz7yDiFbYeczBOTHgl");
	        JSONObject refundRequest = new JSONObject();
	        BigDecimal refundAmount = BigDecimal.ZERO;

	        boolean allItemsDone = order.getItems().stream()
	                .allMatch(i -> i.getIsCancelled() || "Returned".equals(i.getStatus()) || i.getId().equals(item.getId()));

	     
	        if ("ONLINE".equalsIgnoreCase(order.getPaymentMethod()) || "UPI".equalsIgnoreCase(order.getPaymentMethod())) {
	            if (allItemsDone) {
	                refundAmount = order.getTotalAmount(); 
	            } else {
	                refundAmount = item.getFinalPrice(); 
	            }
	        } 
	        else if ("PARTIAL_COD".equalsIgnoreCase(order.getPaymentMethod())) {
	            if (allItemsDone) {
	                refundAmount = order.getTotalAmount().multiply(new BigDecimal("0.4")); 
	            } else {
	                refundAmount = item.getFinalPrice().multiply(new BigDecimal("0.4")); 
	            }
	        }

	        BigDecimal refundAmountRounded = refundAmount.setScale(0, RoundingMode.HALF_UP);
	        BigDecimal paidAmountRounded = payment.getAmount().setScale(0, RoundingMode.HALF_UP);

	        if (refundAmountRounded.compareTo(paidAmountRounded) > 0) {
	            refundAmountRounded = paidAmountRounded; 
	        }

	        if (refundAmountRounded.compareTo(BigDecimal.ZERO) <= 0) {
	            item.setRefundStatus("Not Required");
	            return true;
	        }

	        refundRequest.put("amount", refundAmountRounded.multiply(new BigDecimal(100)).intValue());
	        client.payments.refund(payment.getRazorpayPaymentId(), refundRequest);

	        item.setRefundStatus("Processed");
	        return true;

	    } catch (Exception e) {
	        System.out.println("❌ Razorpay Refund Exception: " + e.getMessage());
	        item.setRefundStatus("Failed");
	        return false;
	    }
	}

	public Orders getOrderById(Long id) {
		return orderRepo.findById(id).orElseThrow(() -> new RuntimeException("Order not found"));
	}

	public Order_item getOrderItemById(Long orderItemId) {
		return orderItemRepo.findById(orderItemId).orElseThrow(() -> new RuntimeException("Order Item not found"));
	}

	public boolean cancelOrderItem(Long orderItemId, Long userId) {
		Optional<Order_item> optionalItem = orderItemRepo.findById(orderItemId);
		if (!optionalItem.isPresent()) return false;

		Order_item item = optionalItem.get();
		if (!item.getOrder().getUser().getId().equals(userId)) return false;

		if (!item.getStatus().equals("Pending") && !item.getStatus().equals("Processing") && !item.getStatus().equals("Packed")) {
			return false;
		}

		Orders order = item.getOrder();
		item.setRefundStatus(!"COD".equals(order.getPaymentMethod()) ? "Pending" : "Not Required");
		if (!"COD".equals(order.getPaymentMethod())) item.setCancelledAt(LocalDateTime.now());

		item.setStatus("Cancelled");
		item.setIsCancelled(true);
		orderItemRepo.save(item);

		processRefund(item, order, order.getPayment());
		updateOrderStatusAfterItemChange(order);
		try {
	         boolean isWholeOrderCancelled = order.getItems().stream()
	                .allMatch(i -> "Cancelled".equalsIgnoreCase(i.getStatus()));

	        if (isWholeOrderCancelled) {
	            shiprocketService.cancelOrderInShiprocket(order);
	            System.out.println("🛑 All items cancelled by user. Order " + order.getOrderNumber() + " cancelled in Shiprocket.");
	        } else {
	            System.out.println("ℹ️ Partial cancellation done. Shiprocket order kept active for remaining items.");
	        }
	    } catch (Exception e) {
	        System.out.println("⚠️ Shiprocket item cancellation sync failed: " + e.getMessage());
	    }
		return true;
	}

	private void updateOrderStatusAfterItemChange(Orders order) {
		List<Order_item> items = order.getItems();
		boolean allCancelled = true;
		boolean allDelivered = true;
		boolean allCompleted = true; 

		for (Order_item item : items) {
			String status = item.getStatus();
			if (!"Cancelled".equals(status)) allCancelled = false;
			if (!"Delivered".equals(status)) allDelivered = false;
			if (!(status.equalsIgnoreCase("Delivered") || status.equalsIgnoreCase("Returned") || status.equalsIgnoreCase("Cancelled"))) {
				allCompleted = false;
			}
		}

		if (allCancelled) order.setStatus("Cancelled");
		else if (allDelivered) order.setStatus("Delivered");
		else if (allCompleted) order.setStatus("Completed");
		else order.setStatus("Active");

		orderRepo.save(order);
	}

	public boolean returnOrderItem(Long orderItemId, Long userId, String reason) {
		Optional<Order_item> optionalItem = orderItemRepo.findById(orderItemId);
		if (!optionalItem.isPresent()) return false;

		Order_item item = optionalItem.get();
		if (Boolean.TRUE.equals(item.getNoReturnOrder())) return false;
		if (!item.getOrder().getUser().getId().equals(userId)) return false;
		if (!"Delivered".equals(item.getOrder().getStatus())) return false;
        
        // 🟢 SERVICE LAYER POLICY CHECK
        if (item.getOrder().getDeliveredDate() != null && 
            item.getOrder().getDeliveredDate().plusDays(5).isBefore(LocalDateTime.now())) {
            return false;
        }

		List<ReturnRequest> existing = returnRequestRepo.findByOrderItem(item);
	    ReturnRequest req;

	    if (!existing.isEmpty()) {
	        req = existing.get(0);
	        if ("Cancelled by User".equals(req.getStatus()) || "Rejected".equals(req.getStatus())) {
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

	public boolean exchangeOrderItem(Long orderItemId, Long userId, String newSize) {
		Optional<Order_item> optionalItem = orderItemRepo.findById(orderItemId);
		if (!optionalItem.isPresent()) return false;

		Order_item item = optionalItem.get();
		if (!item.getOrder().getUser().getId().equals(userId)) return false;
		if (!"Delivered".equals(item.getOrder().getStatus())) return false;
        
        // 🟢 SERVICE LAYER POLICY CHECK
        if (item.getOrder().getDeliveredDate() != null && 
            item.getOrder().getDeliveredDate().plusDays(5).isBefore(LocalDateTime.now())) {
            return false;
        }

		ExchangeRequest req = new ExchangeRequest();
		req.setOrderItem(item);
		req.setNewSize(newSize);
		req.setStatus("Requested");

		item.setExchangeRequested(true);
		item.setNewSize(newSize);
		item.setExchangeStatus("Requested");
		item.setExchangeDeliveryDate(LocalDate.now().plusDays(5).toString());

		exchangeRequestRepo.save(req);
		return true;
	}

	public boolean approveReturn(Long orderItemId) {
		Optional<Order_item> optionalItem = orderItemRepo.findById(orderItemId);
		if (!optionalItem.isPresent()) return false;

		Order_item item = optionalItem.get();
		if (!"Requested".equals(item.getReturnStatus())) return false;

		item.setReturnStatus("Approved");
		item.setReturnPickupDate(LocalDate.now().plusDays(2).toString());
		orderItemRepo.save(item);

		List<ReturnRequest> requests = returnRequestRepo.findByOrderItem(item);
		if (!requests.isEmpty()) {
			ReturnRequest req = requests.get(0);
			req.setStatus("Approved");
			returnRequestRepo.save(req);
		}
		return true;
	}

	public boolean markReturnPicked(Long orderItemId) {
		Order_item item = orderItemRepo.findById(orderItemId).get();
		if (!"Approved".equals(item.getReturnStatus())) return false;
		if ("Processed".equals(item.getRefundStatus())) return false;

		Orders order = item.getOrder();
		Payment payment = order.getPayment();
		if (payment == null) return false;

		if (!processRefund(item, order, payment)) return false;

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
		if (!optionalItem.isPresent()) return false;

		Order_item item = optionalItem.get();
		if (!"Requested".equals(item.getReturnStatus())) return false;

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

	    if(!"Cancelled".equals(item.getStatus()) || "Processed".equals(item.getRefundStatus())) {
	        return false;
	    }

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

	    if(!"Requested".equals(item.getReturnStatus()) && !"Approved".equals(item.getReturnStatus())) {
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

	    if(!"Requested".equals(item.getExchangeStatus()) && !"Approved".equals(item.getExchangeStatus())) {
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
	        processRefund(item, item.getOrder(), item.getOrder().getPayment());
	    }
	}
}