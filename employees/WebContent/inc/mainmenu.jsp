<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">

<style type="text/css">
      .centered {
        margin-left: auto;
        margin-right: auto;
      }
</style>

	
	<!-- <nav class="navbar navbar-expand-lg navbar-dark bg-primary"> -->
	<!-- <nav class="navbar navbar-expand-sm bg-primary navbar-dark"> -->
	<nav class="navbar navbar-expand-sm bg-info navbar-dark">
	
	  <ul class="navbar-nav centered">
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath() %>/index.jsp"><i class='fas fa-home'>홈으로</i></a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath() %>/about.jsp"><i class='fas fa-smile'>관리자 소개</i></a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath() %>/empData/empDataList.jsp"><i class='fas fa-envelope'>empData</i></a>
	    </li>	    
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath() %>/departments/departmentsList.jsp"><i class='fas fa-building'>departments</i></a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath() %>/employees/employeesList.jsp"><i class='fas fa-user'>employees</i></a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath() %>/deptEmp/deptEmpList.jsp"><i class='fas fa-columns'>deptEmp</i></a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath() %>/deptManager/deptManagerList.jsp"><i class='fas fa-file'>deptManager</i></a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath() %>/titles/titlesList.jsp"><i class='fas fa-bookmark'>titles</i></a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath() %>/salaries/salariesList.jsp"><i class='fas fa-cloud'>salaries</i></a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=request.getContextPath() %>/qna/qnaList.jsp"><i class='fas fa-question'>QnA 게시판</i></a>
	    </li>
	    
	    <%
				request.setCharacterEncoding("utf-8");
				
				String loginID = "";
				
				try{
					loginID = (String)session.getAttribute("loginID");
					
						if(loginID == null){
							//System.out.println("loginID = " + loginID);
		%>
							<li class="nav-item">
								<a class="nav-link" href="<%=request.getContextPath() %>/signUp/login.jsp"><i class='fas fa-address-book'>로그인</i></a>
							</li>
		<%	
						}else{
		%>
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown">
									<i class='fas fa-address-book'>
										<%=loginID %>
									</i>
								</a>
								<div class="dropdown-menu">
						        	<a class="dropdown-item" href="<%=request.getContextPath() %>/signUp/updateUser.jsp">회원정보 수정</a>
						       		<a class="dropdown-item" href="<%=request.getContextPath() %>/signUp/logout.jsp">로그아웃</a>
						    	</div>
								
							</li>
		<%
						}
				}catch(NullPointerException e){
					
				}
	    %>
	    
	    
	    
	  </ul>
	</nav>
	
	

