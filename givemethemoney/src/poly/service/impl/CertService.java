package poly.service.impl;

import java.text.DecimalFormat;
import java.text.Format;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import poly.dto.CertDTO;
import poly.persistance.mapper.ICertMapper;
import poly.service.ICertService;
@Service("CertService")
public class CertService implements ICertService {
	private Random r = new Random();
	@Resource(name = "CertMapper")
	private ICertMapper certMapper;

	@Override
	public String generateSecret() {
		int n = r.nextInt(1000000);
		Format f = new DecimalFormat("000000");
		String secret = f.format(n);
		return secret;
	}

	@Override
	public String generateCertification(String ip) {
		String secret = this.generateSecret();
		CertDTO certDTO = new CertDTO();
		certDTO.setSecret(secret);
		certDTO.setWho(ip);
		certMapper.regist(certDTO);
		return secret;
	}

	@Override
	@Scheduled(cron = "* * * * * *")
	public void clear() {
		certMapper.clearAll();
	}
	@Override
	public boolean validate(CertDTO certDTO) {
		CertDTO result = certMapper.validate(certDTO);
		if(result != null) {	
			certMapper.remove(result);
		}
		return result != null;
	}

}
