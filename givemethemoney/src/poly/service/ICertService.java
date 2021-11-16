package poly.service;

import poly.dto.CertDTO;

public interface ICertService {
	String generateSecret();
	String generateCertification(String ip);
	void clear();
	boolean validate(CertDTO certDTO);
}
