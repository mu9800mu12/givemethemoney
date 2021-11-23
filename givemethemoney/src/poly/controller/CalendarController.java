package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.service.ICalendarService;

@Controller
public class CalendarController {
	@Resource(name="CalendarService")
	private ICalendarService calendarService;
	@RequestMapping(value = "calendar/main")
	public String main(HttpServletRequest req, HttpServletResponse resp) {
		return "calendar/main";
	}
	@RequestMapping(value = "calendar/count")
	public String count(HttpServletRequest req, HttpServletResponse resp) {
		return "calendar/count";
	}
}
