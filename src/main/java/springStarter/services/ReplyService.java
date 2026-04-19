package springStarter.services;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import springStarter.models.Reply;
import springStarter.repository.ReplyRepo;

@Service
@Transactional
public class ReplyService {
	
	@Autowired
	private ReplyRepo replyRepo;
	
	public void save(Reply reply) {
		replyRepo.save(reply);
		
	}

}
