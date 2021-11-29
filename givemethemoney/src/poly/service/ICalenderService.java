package poly.service;


import poly.dto.EventDTO;
import poly.dto.MemberDTO;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.List;

public interface ICalenderService {

	String testSample(String... args) throws IOException, GeneralSecurityException;
	void getCalendarList() throws IOException, GeneralSecurityException;
	List<EventDTO> eventShow() throws IOException, GeneralSecurityException;
	void insertEvent(EventDTO pDTO) throws IOException, GeneralSecurityException;
	void deleteEvent(String event_id) throws IOException, GeneralSecurityException;
	void updateEvent(EventDTO pDTO) throws IOException, GeneralSecurityException;
	void interfaceGetCredentials(MemberDTO mDTO) throws IOException, GeneralSecurityException;

	MemberDTO memberinfo(MemberDTO mDTO);
}
