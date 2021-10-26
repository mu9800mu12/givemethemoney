package poly.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PracticeController {
	@RequestMapping(value="sid", method=RequestMethod.GET)
	public String sid() {
		return "/sid";
	}
}
