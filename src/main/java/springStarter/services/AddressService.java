package springStarter.services;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import springStarter.models.Address;
import springStarter.models.User;
import springStarter.repository.AddressRepo;

@Service
@Transactional
public class AddressService {
	
	@Autowired
	private AddressRepo addressRepo;
	
	public List<Address> getAllAddresses() {
		 return addressRepo.findAll();
	}
	
	public List<Address> getByUser(User user){
	    return addressRepo.findByUserId(user.getId());
	}
	
	public Address getDefaultAddress(User user){
	    return addressRepo.findByUserAndIsDefaultAddressTrue(user);
	}
	
	public void save(Address address){

	    if(address.isDefaultAddress()){
	        List<Address> list = addressRepo.findByUserId(address.getUser().getId());

	        for(Address a : list){
	            a.setDefaultAddress(false);
	        }

	        addressRepo.saveAll(list);
	    }

	    addressRepo.save(address);
	}
	
	public Address getById(Long id){
	    return addressRepo.findById(id).orElse(null);
	}
	
	public void update(Address address){

	    if(address.isDefaultAddress()){
	        List<Address> list = addressRepo.findByUserId(address.getUser().getId());

	        for(Address a : list){
	            a.setDefaultAddress(false);
	        }

	        addressRepo.saveAll(list);
	    }

	    addressRepo.save(address);
	}
	
	public void deleteAddress(Long addressId) {
	    addressRepo.deleteById(addressId);
	}

}
