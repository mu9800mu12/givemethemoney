<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="poly.dto.EventDTO" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Quixlab - Bootstrap Admin Dashboard Template by Themefisher.com</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
    <!-- Custom Stylesheet -->
    <link href="${pageContext.request.contextPath}/plugins/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">


    <script src="${pageContext.request.contextPath}/plugins/common/common.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/custom.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/settings.js"></script>
    <script src="${pageContext.request.contextPath}/js/gleek.js"></script>
    <script src="${pageContext.request.contextPath}/js/styleSwitcher.js"></script>


    <script src="${pageContext.request.contextPath}/plugins/jqueryui/js/jquery-ui.min.js"></script>
    <link href="${pageContext.request.contextPath}/fullcalendar/lib/main.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/fullcalendar/lib/main.js"></script>
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>


    <script language="JavaScript" charset="UTF-8">
        var access = "관리자";
        access = "노예";
        var events_arr = new Array();

        window.onload = function(){
            document.getElementById("sbtn").onclick = function(){
                //insert로 넣은 날자랑 구글 캘린더에 실제 들어간 날자와 시간 확인

                if(!document.newForm.title.value){
                    alert("제목을 입력하세요!");
                    document.newForm.title.focus();
                    return false;
                }  else if(!document.newForm.start.value){
                    alert("추가할 파트의 시작시간을 입력하세요!");
                    document.newForm.start.focus();
                    return false;
                } else if(!document.newForm.end.value){
                    alert("추가할 파트의 종료시간을 입력하세요!");
                    document.newForm.end.focus();
                    return false;
                } else if(!document.newForm.until.value){
                    alert("반복 종료 날자를 입력하세요.");
                    document.newForm.until.focus();
                    return false;
                } else if(!document.newForm.need_staff.value){
                    alert("추가할 파트의 모집 인원을 입력하세요!");
                    document.newForm.need_staff.focus();
                    return false;
                }

                var dateStart = new Date(document.newForm.start.value);
                var dateEnd = new Date(document.newForm.end.value);
                console.log("dateStart: " + dateStart);
                console.log("dateEnd: " + dateEnd);
                console.log("dateStart < dateEnd: " );
                console.log(dateStart.getTime() > dateEnd.getTime());
                if(dateStart.getTime() >= dateEnd.getTime()){
                    alert("종료시간은 시작시간 이후여야 합니다.");
                    document.newForm.start.focus();
                    document.newForm.end.focus();
                    return false;
                }


                alert("체크박스 체크 수: "+ $("input[name='week']:checked").length);
                if($("input[name='week']:checked").length == 0){
                    $(".default-check").prop("checked", true);
                }

                alert("수정 후 체크 수: "+ $("input[name='week']:checked").length);
                alert("전송하기");
                var x = document.getElementsByName("newForm");
                x[0].submit();
                return false;
            };
        };


        document.addEventListener('DOMContentLoaded', function(){
            var calendarE1 = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarE1,{
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
                },
                locale : "ko",
                weekNumbers: true,
                navLinks: true, // can click day/week names to navigate views
                editable: true,
                contentHeight: 'auto',
                minTime: '00:00:00',
                maxTime: '24:00:00',
                selectable: true,
                nowIndicator: true,
                dayMaxEvents: true, // allow "more" link when too many events
                // showNonCurrentDates: false,

                // select: function(arg) {
                //     var title = prompt('Event Title:');
                //     if (title) {
                //         calendar.addEvent({
                //             title: title,
                //             start: arg.start,
                //             end: arg.end,
                //             allDay: arg.allDay
                //         })
                //     }
                //     calendar.unselect()
                // },
                // eventClick: function(arg) {
                //
                //     if (confirm('AAAAre you sure you want to delete this event?')) {
                //         arg.event.remove()
                //     }
                // },

                dateClick: function(info) {
                    alert('clicked ' + info.dateStr);
                    console.log(' on resource ');
                },
                select: function(info) {
                    alert('selected ' + info.startStr + ' to ' + info.endStr);
                    console.log( ' on resource ' )
                },

                eventClick: function(info) {
                    var eventObj = info.event;
                    if(access=="관리자"){
                        if (eventObj.id) {
                            alert('Clicked Event Id = ' + eventObj.id);
                            console.log('Clicked Event Id = ' + eventObj.id);
                            $.post("/deleteEvent.do", {event_id:eventObj.id});

                            alert(eventObj.title + "삭제중입니다.");
                            setTimeout(function(){
                                location.href = "/getCalendarEvents.do";
                            },1000);
                        }
                    }
                    else{
                        alert("당신은 " + access +"입니다.\n당신은 관리자가 아닙니다.");
                        alert(eventObj.title);
                        //12~18(8/7)
                        var evOtitle = eventObj.title;
                        var leftKnife = evOtitle.indexOf('(');
                        var middleKnife = evOtitle.indexOf('/');
                        var rightKnife = evOtitle.indexOf(')');
                        var need_staff = evOtitle.slice(leftKnife+1, middleKnife);
                        //8
                        var now_staff = evOtitle.slice(middleKnife+1, rightKnife);
                        //7
                        alert("필요인원은 " + need_staff + "\n현재 인원은 " + now_staff);
                        if(Number(now_staff) < Number(need_staff)){
                            if(confirm("예약하시겠습니까?") == true){
                                var new_title = evOtitle.slice(0, leftKnife);
                                now_staff = (Number(now_staff)+1)+"";
                                //1 counting now_staff  7 = 8
                                //(8/8)
                                // alert("ㅇㅋ 기다려봐");
                                // alert(eventObj.id);
                                // alert(new_title);
                                console.log("new_title: "+ new_title);
                                console.log("eventObj.id: "+ eventObj.id);
                                console.log("now_staff: "+ now_staff);
                                console.log("need_staff: "+ need_staff);

                                $.post("/updateTitle.do", {event_id:eventObj.id,title:new_title,now_staff:now_staff,need_staff:need_staff});
                                info.event.remove();

                                alert(new_title+ "로 예약중입니다.");
                                setTimeout(function(){
                                    location.href = "/getCalendarEvents.do";
                                },800);

                            }else{
                                alert("취소하셨습니다");
                            }
                        }
                        else{
                            alert("인원이 다 찼는데...");
                        }


                    }

                },
                eventMouseEnter: function(calEvent) {
                    var tooltip = '<div class="tooltipevent" style="width:auto;height:120px;vertical-align:middle;background:'+calEvent.el.style.backgroundColor+';position:absolute;z-index:10001;">' + calEvent.event._def.title + '</div>';
                    $("body").append(tooltip);
                    $(this.el).mouseover(function(e) {
                        $(this.el).css('z-index', 10000);
                        $('.tooltipevent').fadeIn('500');
                        $('.tooltipevent').fadeTo('10', 1.9);
                    }).mousemove(function(e) {
                        $('.tooltipevent').css('top', e.pageY + 10);
                        $('.tooltipevent').css('left', e.pageX + 20);
                    });},

                eventMouseLeave: function(calEvent, jsEvent) {
                    $(this.el).css('z-index', 8);
                    $('.tooltipevent').remove();},

                events: [
                    <%
             List<EventDTO> rlist = (ArrayList<EventDTO>)request.getAttribute("showSchedule");
             %>

                    <%
                    Iterator<EventDTO> it = rlist.iterator();
                    while(it.hasNext())
                    {
                        EventDTO rDTO = it.next();

                    %>
                    {   id: '<%=rDTO.getId()%>',
                        title: '<%= rDTO.getTitle() %>',
                        start: '<%= rDTO.getStart() %>',
                        end: '<%= rDTO.getEnd() %>'
                    },
                    <%
                    }
                    %>

                    {
                        title: 'default',
                        start: '2019-01-01',
                        end: '2019-01-01'
                    }
                ],
                loading: function(bool){
                    document.getElementById('loading').style.display =
                        bool ? 'block' : 'none';
                }

            });
            calendar.render();
        });


    </script>

    <style>

        html, body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
            font-size: 14px;
        }
    </style>
</head>

<body>

<!--*******************
    Preloader start
********************-->
<div id="preloader">
    <div class="loader">
        <svg class="circular" viewBox="25 25 50 50">
            <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
        </svg>
    </div>
</div>
<!--*******************
    Preloader end
********************-->


<!--**********************************
    Main wrapper start
***********************************-->
<div id="main-wrapper">

    <!--**********************************
        Nav header start
    ***********************************-->
    <div class="nav-header">
        <div class="brand-logo">
            <a href="index.html">
                <b class="logo-abbr"><img src="images/logo.png" alt=""> </b>
                <span class="logo-compact"><img src="./images/logo-compact.png" alt=""></span>
                <span class="brand-title">
                        <img src="images/logo-text.png" alt="">
                    </span>
            </a>
        </div>
    </div>
    <!--**********************************
        Nav header end
    ***********************************-->

    <!--**********************************
        Header start
    ***********************************-->
    <div class="header">
        <div class="header-content clearfix">

            <div class="nav-control">
                <div class="hamburger">
                    <span class="toggle-icon"><i class="icon-menu"></i></span>
                </div>
            </div>
            <div class="header-left">
                <div class="input-group icons">
                    <div class="input-group-prepend">
                        <span class="input-group-text bg-transparent border-0 pr-2 pr-sm-3" id="basic-addon1"><i class="mdi mdi-magnify"></i></span>
                    </div>
                    <input type="search" class="form-control" placeholder="Search Dashboard" aria-label="Search Dashboard">
                    <div class="drop-down   d-md-none">
                        <form action="#">
                            <input type="text" class="form-control" placeholder="Search">
                        </form>
                    </div>
                </div>
            </div>
            <div class="header-right">
                <ul class="clearfix">
                    <li class="icons dropdown"><a href="javascript:void(0)" data-toggle="dropdown">
                        <i class="mdi mdi-email-outline"></i>
                        <span class="badge gradient-1 badge-pill badge-primary">3</span>
                    </a>
                        <div class="drop-down animated fadeIn dropdown-menu">
                            <div class="dropdown-content-heading d-flex justify-content-between">
                                <span class="">3 New Messages</span>

                            </div>
                            <div class="dropdown-content-body">
                                <ul>
                                    <li class="notification-unread">
                                        <a href="javascript:void()">
                                            <img class="float-left mr-3 avatar-img" src="images/avatar/1.jpg" alt="">
                                            <div class="notification-content">
                                                <div class="notification-heading">Saiful Islam</div>
                                                <div class="notification-timestamp">08 Hours ago</div>
                                                <div class="notification-text">Hi Teddy, Just wanted to let you ...</div>
                                            </div>
                                        </a>
                                    </li>
                                    <li class="notification-unread">
                                        <a href="javascript:void()">
                                            <img class="float-left mr-3 avatar-img" src="images/avatar/2.jpg" alt="">
                                            <div class="notification-content">
                                                <div class="notification-heading">Adam Smith</div>
                                                <div class="notification-timestamp">08 Hours ago</div>
                                                <div class="notification-text">Can you do me a favour?</div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void()">
                                            <img class="float-left mr-3 avatar-img" src="images/avatar/3.jpg" alt="">
                                            <div class="notification-content">
                                                <div class="notification-heading">Barak Obama</div>
                                                <div class="notification-timestamp">08 Hours ago</div>
                                                <div class="notification-text">Hi Teddy, Just wanted to let you ...</div>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void()">
                                            <img class="float-left mr-3 avatar-img" src="images/avatar/4.jpg" alt="">
                                            <div class="notification-content">
                                                <div class="notification-heading">Hilari Clinton</div>
                                                <div class="notification-timestamp">08 Hours ago</div>
                                                <div class="notification-text">Hello</div>
                                            </div>
                                        </a>
                                    </li>
                                </ul>

                            </div>
                        </div>
                    </li>
                    <li class="icons dropdown"><a href="javascript:void(0)" data-toggle="dropdown">
                        <i class="mdi mdi-bell-outline"></i>
                        <span class="badge badge-pill gradient-2 badge-primary">3</span>
                    </a>
                        <div class="drop-down animated fadeIn dropdown-menu dropdown-notfication">
                            <div class="dropdown-content-heading d-flex justify-content-between">
                                <span class="">2 New Notifications</span>

                            </div>
                            <div class="dropdown-content-body">
                                <ul>
                                    <li>
                                        <a href="javascript:void()">
                                            <span class="mr-3 avatar-icon bg-success-lighten-2"><i class="icon-present"></i></span>
                                            <div class="notification-content">
                                                <h6 class="notification-heading">Events near you</h6>
                                                <span class="notification-text">Within next 5 days</span>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void()">
                                            <span class="mr-3 avatar-icon bg-danger-lighten-2"><i class="icon-present"></i></span>
                                            <div class="notification-content">
                                                <h6 class="notification-heading">Event Started</h6>
                                                <span class="notification-text">One hour ago</span>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void()">
                                            <span class="mr-3 avatar-icon bg-success-lighten-2"><i class="icon-present"></i></span>
                                            <div class="notification-content">
                                                <h6 class="notification-heading">Event Ended Successfully</h6>
                                                <span class="notification-text">One hour ago</span>
                                            </div>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void()">
                                            <span class="mr-3 avatar-icon bg-danger-lighten-2"><i class="icon-present"></i></span>
                                            <div class="notification-content">
                                                <h6 class="notification-heading">Events to Join</h6>
                                                <span class="notification-text">After two days</span>
                                            </div>
                                        </a>
                                    </li>
                                </ul>

                            </div>
                        </div>
                    </li>
                    <li class="icons dropdown d-none d-md-flex">
                        <a href="javascript:void(0)" class="log-user"  data-toggle="dropdown">
                            <span>English</span>  <i class="fa fa-angle-down f-s-14" aria-hidden="true"></i>
                        </a>
                        <div class="drop-down dropdown-language animated fadeIn  dropdown-menu">
                            <div class="dropdown-content-body">
                                <ul>
                                    <li><a href="javascript:void()">English</a></li>
                                    <li><a href="javascript:void()">Dutch</a></li>
                                </ul>
                            </div>
                        </div>
                    </li>
                    <li class="icons dropdown">
                        <div class="user-img c-pointer position-relative"   data-toggle="dropdown">
                            <span class="activity active"></span>
                            <img src="images/user/1.png" height="40" width="40" alt="">
                        </div>
                        <div class="drop-down dropdown-profile   dropdown-menu">
                            <div class="dropdown-content-body">
                                <ul>
                                    <li>
                                        <a href="app-profile.html"><i class="icon-user"></i> <span>Profile</span></a>
                                    </li>
                                    <li>
                                        <a href="email-inbox.html"><i class="icon-envelope-open"></i> <span>Inbox</span> <div class="badge gradient-3 badge-pill badge-primary">3</div></a>
                                    </li>

                                    <hr class="my-2">
                                    <li>
                                        <a href="page-lock.html"><i class="icon-lock"></i> <span>Lock Screen</span></a>
                                    </li>
                                    <li><a href="page-login.html"><i class="icon-key"></i> <span>Logout</span></a></li>
                                </ul>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <!--**********************************
        Header end ti-comment-alt
    ***********************************-->

    <!--**********************************
        Sidebar start
    ***********************************-->
    <div class="nk-sidebar">
        <div class="nk-nav-scroll">
            <ul class="metismenu" id="menu">
                <li class="nav-label">Dashboard</li>
                <li>
                    <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                        <i class="icon-speedometer menu-icon"></i><span class="nav-text">Dashboard</span>
                    </a>
                    <ul aria-expanded="false">
                        <li><a href="./index.html">Home 1</a></li>
                        <!-- <li><a href="./index-2.html">Home 2</a></li> -->
                    </ul>
                </li>
                <li class="mega-menu mega-menu-sm">
                    <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                        <i class="icon-globe-alt menu-icon"></i><span class="nav-text">Layouts</span>
                    </a>
                    <ul aria-expanded="false">
                        <li><a href="./layout-blank.html">Blank</a></li>
                        <li><a href="./layout-one-column.html">One Column</a></li>
                        <li><a href="./layout-two-column.html">Two column</a></li>
                        <li><a href="./layout-compact-nav.html">Compact Nav</a></li>
                        <li><a href="./layout-vertical.html">Vertical</a></li>
                        <li><a href="./layout-horizontal.html">Horizontal</a></li>
                        <li><a href="./layout-boxed.html">Boxed</a></li>
                        <li><a href="./layout-wide.html">Wide</a></li>


                        <li><a href="./layout-fixed-header.html">Fixed Header</a></li>
                        <li><a href="layout-fixed-sidebar.html">Fixed Sidebar</a></li>
                    </ul>
                </li>
                <li class="nav-label">Apps</li>
                <li>
                    <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                        <i class="icon-envelope menu-icon"></i> <span class="nav-text">Email</span>
                    </a>
                    <ul aria-expanded="false">
                        <li><a href="./email-inbox.html">Inbox</a></li>
                        <li><a href="./email-read.html">Read</a></li>
                        <li><a href="./email-compose.html">Compose</a></li>
                    </ul>
                </li>
                <li>
                    <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                        <i class="icon-screen-tablet menu-icon"></i><span class="nav-text">Apps</span>
                    </a>
                    <ul aria-expanded="false">
                        <li><a href="./app-profile.html">Profile</a></li>
                        <li><a href="./app-calender.html">Calender</a></li>
                    </ul>
                </li>
                <li>
                    <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                        <i class="icon-graph menu-icon"></i> <span class="nav-text">Charts</span>
                    </a>
                    <ul aria-expanded="false">
                        <li><a href="./chart-flot.html">Flot</a></li>
                        <li><a href="./chart-morris.html">Morris</a></li>
                        <li><a href="./chart-chartjs.html">Chartjs</a></li>
                        <li><a href="./chart-chartist.html">Chartist</a></li>
                        <li><a href="./chart-sparkline.html">Sparkline</a></li>
                        <li><a href="./chart-peity.html">Peity</a></li>
                    </ul>
                </li>
                <li class="nav-label">UI Components</li>
                <li>
                    <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                        <i class="icon-grid menu-icon"></i><span class="nav-text">UI Components</span>
                    </a>
                    <ul aria-expanded="false">
                        <li><a href="./ui-accordion.html">Accordion</a></li>
                        <li><a href="./ui-alert.html">Alert</a></li>
                        <li><a href="./ui-badge.html">Badge</a></li>
                        <li><a href="./ui-button.html">Button</a></li>
                        <li><a href="./ui-button-group.html">Button Group</a></li>
                        <li><a href="./ui-cards.html">Cards</a></li>
                        <li><a href="./ui-carousel.html">Carousel</a></li>
                        <li><a href="./ui-dropdown.html">Dropdown</a></li>
                        <li><a href="./ui-list-group.html">List Group</a></li>
                        <li><a href="./ui-media-object.html">Media Object</a></li>
                        <li><a href="./ui-modal.html">Modal</a></li>
                        <li><a href="./ui-pagination.html">Pagination</a></li>
                        <li><a href="./ui-popover.html">Popover</a></li>
                        <li><a href="./ui-progressbar.html">Progressbar</a></li>
                        <li><a href="./ui-tab.html">Tab</a></li>
                        <li><a href="./ui-typography.html">Typography</a></li>
                        <!-- </ul>
                    </li>
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-layers menu-icon"></i><span class="nav-text">Components</span>
                        </a>
                        <ul aria-expanded="false"> -->
                        <li><a href="./uc-nestedable.html">Nestedable</a></li>
                        <li><a href="./uc-noui-slider.html">Noui Slider</a></li>
                        <li><a href="./uc-sweetalert.html">Sweet Alert</a></li>
                        <li><a href="./uc-toastr.html">Toastr</a></li>
                    </ul>
                </li>
                <li>
                    <a href="widgets.html" aria-expanded="false">
                        <i class="icon-badge menu-icon"></i><span class="nav-text">Widget</span>
                    </a>
                </li>
                <li class="nav-label">Forms</li>
                <li>
                    <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                        <i class="icon-note menu-icon"></i><span class="nav-text">Forms</span>
                    </a>
                    <ul aria-expanded="false">
                        <li><a href="./form-basic.html">Basic Form</a></li>
                        <li><a href="./form-validation.html">Form Validation</a></li>
                        <li><a href="./form-step.html">Step Form</a></li>
                        <li><a href="./form-editor.html">Editor</a></li>
                        <li><a href="./form-picker.html">Picker</a></li>
                    </ul>
                </li>
                <li class="nav-label">Table</li>
                <li>
                    <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                        <i class="icon-menu menu-icon"></i><span class="nav-text">Table</span>
                    </a>
                    <ul aria-expanded="false">
                        <li><a href="./table-basic.html" aria-expanded="false">Basic Table</a></li>
                        <li><a href="./table-datatable.html" aria-expanded="false">Data Table</a></li>
                    </ul>
                </li>
                <li class="nav-label">Pages</li>
                <li>
                    <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                        <i class="icon-notebook menu-icon"></i><span class="nav-text">Pages</span>
                    </a>
                    <ul aria-expanded="false">
                        <li><a href="./page-login.html">Login</a></li>
                        <li><a href="./page-register.html">Register</a></li>
                        <li><a href="./page-lock.html">Lock Screen</a></li>
                        <li><a class="has-arrow" href="javascript:void()" aria-expanded="false">Error</a>
                            <ul aria-expanded="false">
                                <li><a href="./page-error-404.html">Error 404</a></li>
                                <li><a href="./page-error-403.html">Error 403</a></li>
                                <li><a href="./page-error-400.html">Error 400</a></li>
                                <li><a href="./page-error-500.html">Error 500</a></li>
                                <li><a href="./page-error-503.html">Error 503</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <!--**********************************
        Sidebar end
    ***********************************-->

    <!--**********************************
        Content body start
    ***********************************-->
    <div class="content-body">

        <div class="row page-titles mx-0">
            <div class="col p-md-0">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="javascript:void(0)">Dashboard</a></li>
                    <li class="breadcrumb-item active"><a href="javascript:void(0)">Home</a></li>
                </ol>
            </div>
        </div>
        <!-- row -->

        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-title">
                                <h4>Calendar</h4>
                            </div>
                            <div class="row">
                                <div class="col-lg-4 mt-5">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h4 class="modal-title"><strong>Add a category</strong></h4>
                                        </div>
                                        <div class="modal-body">
                                            <form action="/NewEventAtTheGC.do" name="newForm" method="post">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <label class="control-label">시작시간</label>
                                                        <input class="form-control form-white" type="datetime-local" name="start">
                                                        <label class="control-label">종료시간</label>
                                                        <input class="form-control form-white" type="datetime-local" name="end">
                                                        <label class="control-label">반복종료시간</label>
                                                        <input class="form-control form-white" type="date" name="until"><br/>



                                                        <fieldset>
                                                            <label class="control-label">요일별 반복 설정</label>
                                                            <div>
                                                                <input type="checkbox" id="MO" class="default-check" name="week" value="MO">
                                                                <label for="MO">MO</label>
                                                                <input type="checkbox" id="TU" class="default-check" name="week" value="TU">
                                                                <label for="TU">TU</label>
                                                                <input type="checkbox" id="WE" class="default-check" name="week" value="WE">
                                                                <label for="WE">WE</label>
                                                                <input type="checkbox" id="TH" class="default-check" name="week" value="TH">
                                                                <label for="TH">TH</label>
                                                                <input type="checkbox" id="FR" class="default-check" name="week" value="FR">
                                                                <label for="FR">FR</label>
                                                            </div>
                                                            <div>
                                                                <input type="checkbox" id="SA" class="default-check" name="week" value="SA">
                                                                <label for="SA">SA</label>
                                                                <input type="checkbox" id="SU" class="default-check" name="week" value="SU">
                                                                <label for="SU">SU</label>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label class="control-label">파트 이름</label>
                                                        <input class="form-control form-white" placeholder="Enter name" type="text" name="title">
                                                        <label class="control-label">인원 모집</label>
                                                        <input class="form-control form-white" placeholder="필요인원" type="number" name="need_staff">
                                                        <input class="form-control form-white" placeholder="현재인원" type="number" name="now_staff">
                                                    </div>
                                                </div>
                                                <div class="modal-footer">
                                                    <input type="reset" class="btn btn-default waves-effect" data-dismiss="modal" value="Reset">
                                                    <input type="button" id="sbtn" class="btn btn-danger waves-effect waves-light save-category" data-dismiss="modal" value="Add">
                                                </div>
                                            </form>
                                        </div>

                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="card-box m-b-50">
                                        <div id='loading'>loading...</div>
                                        <div id='calendar-container'>
                                            <div id='calendar'></div>
                                        </div>
                                    </div>
                                </div>

                                <!-- end col -->
                                <!-- BEGIN MODAL -->

                                <!-- Modal Add Category -->
                                <div class="modal fade none-border" id="add-category">
                                    <div class="modal-dialog">

                                    </div>
                                </div>
                                <!-- END MODAL -->
                            </div>
                        </div>
                    </div>
                    <!-- /# card -->
                </div>
                <!-- /# column -->
            </div>
        </div>
        <!-- #/ container -->
    </div>
    <!--**********************************
        Content body end
    ***********************************-->


    <!--**********************************
        Footer start
    ***********************************-->
    <div class="footer">
        <div class="copyright">
            <p>Copyright &copy; Designed & Developed by <a href="https://themeforest.net/user/quixlab">Quixlab</a> 2018</p>
        </div>
    </div>
    <!--**********************************
        Footer end
    ***********************************-->
</div>
<!--**********************************
    Main wrapper end
***********************************-->

<!--**********************************
    Scripts
***********************************-->



</body>

</html>

