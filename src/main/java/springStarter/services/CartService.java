package springStarter.services;

import java.math.BigDecimal;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import springStarter.models.Cart;
import springStarter.models.Item;
import springStarter.models.User;
import springStarter.repository.CartRepo;
import springStarter.repository.ItemRepo;

@Service
@Transactional
public class CartService {

	@Autowired
	private CartRepo cartRepo;

	@Autowired
	private ItemRepo itemRepo;

	public void addToCart(User user, Item item, String size, String age) {

		Cart cart = cartRepo.findByUserAndItemAndSizeAndAge(user, item, size, age);

		BigDecimal price = new BigDecimal(String.valueOf(item.getItemPrice()));
		BigDecimal discount = item.getDiscount();

		BigDecimal hundred = new BigDecimal("100");

		BigDecimal finalPrice = price.subtract(price.multiply(discount).divide(hundred));

		if (cart != null) {
			int newQty = cart.getQuantity() + 1;
			cart.setQuantity(newQty);

			BigDecimal total = finalPrice.multiply(BigDecimal.valueOf(newQty));
			cart.setTotalPrice(total);

		} else {
			cart = new Cart();
			cart.setUser(user);
			cart.setItem(item);
			cart.setQuantity(1);
			cart.setSize(size);
			cart.setAge(age);
			cart.setTotalPrice(finalPrice);
		}

		cartRepo.save(cart);
	}

	public List<Cart> getCartByUser(User user) {
		return cartRepo.findByUser(user);
	}

	public boolean existsByUserAndItem(User user, Long itemId) {
		Item item = itemRepo.findById(itemId).orElse(null);
		List<Cart> carts = cartRepo.findByUserAndItem(user, item);
		return !carts.isEmpty();
	}

	public void updateQuantity(User user, Long itemId, int quantity) {

		Item item = itemRepo.findById(itemId).orElse(null);

		List<Cart> carts = cartRepo.findByUserAndItem(user, item);

		BigDecimal price = item.getItemPrice();
		BigDecimal discount = item.getDiscount();
		BigDecimal hundred = new BigDecimal("100");

		BigDecimal finalPrice = price.subtract(price.multiply(discount).divide(hundred));

		for (Cart cart : carts) {

			cart.setQuantity(quantity);

			BigDecimal total = finalPrice.multiply(BigDecimal.valueOf(quantity));
			cart.setTotalPrice(total);

			cartRepo.save(cart);
		}
	}

	public void deleteCart(Long cartId) {
		cartRepo.deleteById(cartId);
	}

	public int getCartCount(User user) {
		return cartRepo.countByUser(user);
	}

	public void clearCart(User user) {
		cartRepo.deleteByUser(user);
	}

	public Cart getTempCartItem(Long itemId, User user) {

		Item item = itemRepo.findById(itemId).get();

		if (item == null) {
			return null;
		}

		Cart cart = new Cart();
		cart.setItem(item);
		cart.setQuantity(1);
		cart.setUser(user);

		BigDecimal price = item.getItemPrice();
		cart.setTotalPrice(price);

		return cart;
	}

	public void addCustomToCart(User user, String image, String size, String color, String type, String gender,
			String customNote) {

		Cart cart = new Cart();
		cart.setUser(user);

		cart.setIsCustom(true);
		cart.setCustomImage(image);
		cart.setSize(size);
		cart.setColor(color);
		cart.setTshirtType(type);

		cart.setGender(gender);
		cart.setCustomNote(customNote);

		cart.setQuantity(1);

		BigDecimal basePrice = new BigDecimal("499"); 
		BigDecimal printCharge = new BigDecimal("100"); 
		
		if ("XL".equals(size) || "XXL".equals(size)) {
		    basePrice = basePrice.add(new BigDecimal("50"));
		}

		if ("Oversize".equalsIgnoreCase(type)) {
			basePrice = basePrice.add(new BigDecimal("100"));
		}

		BigDecimal finalPrice = basePrice.add(printCharge);

		cart.setTotalPrice(finalPrice);

		cartRepo.save(cart);
	}

}
