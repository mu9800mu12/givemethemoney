package poly.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import poly.dto.EventDTO;
import poly.service.ICalenderService;
import poly.service.INoticeService;
import poly.util.CmmUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class CalendarController {
    private Logger log = Logger.getLogger(this.getClass().getName());

    @Resource(name = "NoticeService")
    private INoticeService noticeService;

    @Resource(name ="CalendarService")
    private ICalenderService iCalenderService;


    @RequestMapping(value="getCalendarEvents")
    public String getCalendarEvents(HttpServletRequest req, HttpServletResponse resp, ModelMap model)throws IOException, GeneralSecurityException {
        log.info("event show start");

        List<EventDTO> list = iCalenderService.eventShow();
        if(list == null){
            list = new ArrayList<EventDTO>();
        }
        model.addAttribute("showSchedule", list);
        log.info("event show end");
        return "/home";
    }

    @RequestMapping(value="NewEventAtTheGC", method= RequestMethod.POST)
    public String newEventAtTheGC(HttpServletRequest request, HttpServletResponse response,
                                  ModelMap model) throws Exception {
        log.info("NewEventAtTheGC Start");
        String title = CmmUtil.nvl(request.getParameter("title"));
        String Ydate = CmmUtil.nvl(request.getParameter("date"));
        String until = CmmUtil.nvl(request.getParameter("until"));
        String start = CmmUtil.nvl(request.getParameter("start"));
        String end = CmmUtil.nvl(request.getParameter("end"));
        String[] week = request.getParameterValues("week");
        String need_staff = CmmUtil.nvl(request.getParameter("need_staff"), "0");
        String now_staff = CmmUtil.nvl(request.getParameter("now_staff"),"0");
        /*

        커밋 test
         */

        String days ="";
        for (String day:week) {
            days+= day + " ";
        }
        days = days.trim();
        days = days.replaceAll(" ", ",");
        until = until.replaceAll("-", "");
        start = start+":00+09:00";
        end = end+":00+09:00";
        title = title + "(" + need_staff+ "/" + "0)";


        log.info("title: " + title);
        log.info("start: "   +start);
        log.info("end: "   +end);
        log.info("until: "+  until);
        log.info("days:" + days);
        EventDTO pDTO = new EventDTO();
        pDTO.setTitle(title);
        pDTO.setStart(start);
        pDTO.setEnd(end);
        pDTO.setUntil(until);
        pDTO.setDays(days);
        iCalenderService.insertEvent(pDTO);

        log.info("NewEventAtTheGC End");
        return "redirect:getCalendarEvents.do";
    }

    @RequestMapping(value="deleteEvent", method = RequestMethod.POST)
    public void remove(HttpServletRequest request) throws GeneralSecurityException, IOException {
        log.info("deleteEvent start");
        String event_id = CmmUtil.nvl(request.getParameter("event_id"));
        log.info("event_id:\n" + event_id);

        iCalenderService.deleteEvent(event_id);

        log.info("deleteEvent end");
//        return "redirect:getCalendarEvents.do";
    }


    @RequestMapping(value="updateTitle", method = RequestMethod.POST)
    public void updateTitle(HttpServletRequest request) throws GeneralSecurityException, IOException {
        log.info("updateTitle start");
        String event_id = CmmUtil.nvl(request.getParameter("event_id"));
        String title = CmmUtil.nvl(request.getParameter("title"));
        String need_staff = CmmUtil.nvl(request.getParameter("need_staff"));
        String now_staff = CmmUtil.nvl(request.getParameter("now_staff"));
        title = title+"("+need_staff+"/"+now_staff+")";
        log.info("event_id:\n" + event_id);
        log.info("title:\n" + title);
        EventDTO pDTO = new EventDTO();

        pDTO.setId(event_id);
        pDTO.setTitle(title);

        iCalenderService.updateEvent(pDTO);

        log.info("updateTitle end");
//        return "redirect:getCalendarEvents.do";
    }






}
