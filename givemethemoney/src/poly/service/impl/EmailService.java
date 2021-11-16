package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.service.IEmailService;

@Service("EmailService")
public class EmailService implements IEmailService {

	@Override
	public int send_code(String member_email) {
		// TODO Auto-generated method stub
		return 0;
	}

}
