package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class OauthController {
    private Logger log = Logger.getLogger(getClass().getName());

    @RequestMapping(value="/google/oauth/redirect")
    public String Redirect(){
        log.info("시작");
        log.info("끝");
        return "/google/oauth/redirect";
    }

    @RequestMapping(value="/google/oauth/login")
    public String Login(){
        log.info("시작");
        log.info("끝");
        return "/google/oauth/login";
    }
    @RequestMapping(value="/google/oauth/authcode")
    public String Authcode(){
        log.info("시작");
        log.info("끝");
        return "/google/oauth/authcode";
    }
}
