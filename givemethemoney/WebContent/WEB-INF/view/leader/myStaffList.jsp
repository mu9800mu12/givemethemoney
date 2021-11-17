<%@page import="poly.util.CmmUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="poly.dto.MemberDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <jsp:include page="/WEB-INF/view/templates/tableHeader.jsp"></jsp:include>
<%	
	session.setAttribute("member_team", 1);
	List<MemberDTO> mList = (List<MemberDTO>)request.getAttribute("mList");
	if(mList == null){
		mList = new ArrayList<MemberDTO>();
	}
%>
<script type="text/javascript">

function doDelete(member_no){
	location.href="/leader/deleteStaff.do?member_no="+member_no
}
</script>
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
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Data Table</h4>
                                <div class="table-responsive">
							<table
								class="table table-striped table-bordered zero-configuration">
								<thead>
									<tr>
										<th>직원번호</th>
										<th>이름</th>
										<th>아이디</th>
										<th>이메일</th>
										<th>전화번호</th>
										<th>퇴출</th>
									</tr>
								</thead>
								<tbody>
									<%
									for (int i = 0; i < mList.size(); i++) {
										MemberDTO mDTO = mList.get(i);
										if (mDTO == null) {
											mDTO = new MemberDTO();
										}
									%>
									<tr>
										<td><%=mDTO.getMember_no() %></td>
										<td><%=mDTO.getMember_name() %></td>
										<td><%=mDTO.getMember_id() %></td>
										<td><%=mDTO.getMember_email() %></td>
										<td><%=mDTO.getMember_phone() %></td>
										<td>
										<a href="javascript:doDelete('<%=mDTO.getMember_no()%>');">퇴출</a>
										</td>
									</tr>
									<% } %>
								
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                               <th>직원번호</th>
                                                <th>이름</th>
                                                <th>아이디</th>
                                                <th>이메일</th>
                                                <th>전화번호</th>
                                                <th>팀퇴출</th>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- #/ container -->
        </div>
        <!--**********************************
            Content body end
        ***********************************-->
              
<jsp:include page="/WEB-INF/view/templates/tableFooter.jsp"></jsp:include>