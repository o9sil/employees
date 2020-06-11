<%@page import="gd.emp.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<style>
  /* Make the image fully responsive */
  .carousel-inner img {
      width: 100%;      
  }
</style>



</head>
<body>
<div class="container-fluid">
	<!-- Navigation MainMenu -->
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>		
	</div>


	
<%

	// 2.0 database
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");
	
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	
	int departmentDB = 0;
	int deptEmpDB = 0;
	int deptManagerDB = 0;
	int employeesDB = 0;
	int salariesDB = 0;
	int titlesDB = 0;
	int qnaDB = 0;
	
	stmt = conn.prepareStatement("SELECT count(*) FROM employees_departments;");	
	rs = stmt.executeQuery();
	if(rs.next()){
		departmentDB = rs.getInt("count(*)");		
	}
	
	stmt = conn.prepareStatement("SELECT count(*) FROM employees_dept_emp;");	
	rs = stmt.executeQuery();
	if(rs.next()){
		deptEmpDB = rs.getInt("count(*)");		
	}
	stmt = conn.prepareStatement("SELECT count(*) FROM employees_dept_manager;");	
	rs = stmt.executeQuery();
	if(rs.next()){
		deptManagerDB = rs.getInt("count(*)");		
	}
	stmt = conn.prepareStatement("SELECT count(*) FROM employees_employees;");	
	rs = stmt.executeQuery();
	if(rs.next()){
		employeesDB = rs.getInt("count(*)");		
	}
	stmt = conn.prepareStatement("SELECT count(*) FROM employees_salaries;");	
	rs = stmt.executeQuery();
	if(rs.next()){
		salariesDB = rs.getInt("count(*)");		
	}
	stmt = conn.prepareStatement("SELECT count(*) FROM employees_titles;");	
	rs = stmt.executeQuery();
	if(rs.next()){
		titlesDB = rs.getInt("count(*)");		
	}
	stmt = conn.prepareStatement("SELECT count(*) FROM employees_qna;");	
	rs = stmt.executeQuery();
	if(rs.next()){
		qnaDB = rs.getInt("count(*)");		
	}
%>


<div id="demo" class="carousel slide" data-ride="carousel">

  <!-- Indicators -->
  <ul class="carousel-indicators">
    <li data-target="#demo" data-slide-to="0" class="active bg-danger"></li>
    <li data-target="#demo" data-slide-to="1" class="bg-danger"></li>
    <li data-target="#demo" data-slide-to="2" class="bg-danger"></li>
    <li data-target="#demo" data-slide-to="3" class="bg-danger"></li>
    <li data-target="#demo" data-slide-to="4" class="bg-danger"></li>
    <li data-target="#demo" data-slide-to="5" class="bg-danger"></li>
  </ul>
  
  <!-- The slideshow -->
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="<%=request.getContextPath() %>/imgs/departments.JPG" alt="departments" width="1100" height="500">
    </div>
    <div class="carousel-item">
      <img src="<%=request.getContextPath() %>/imgs/employees.JPG" alt="employees" width="1100" height="500">
    </div>
    <div class="carousel-item">
      <img src="<%=request.getContextPath() %>/imgs/dept_emp.JPG" alt="deptEmp" width="1100" height="500">
    </div>
    <div class="carousel-item">
      <img src="<%=request.getContextPath() %>/imgs/dept_manager.JPG" alt="deptManager" width="1100" height="500">
    </div>
    <div class="carousel-item">
      <img src="<%=request.getContextPath() %>/imgs/titles.JPG" alt="titles" width="1100" height="500">
    </div>
    <div class="carousel-item">
      <img src="<%=request.getContextPath() %>/imgs/salaries.JPG" alt="salaries" width="1100" height="500">
    </div>
  </div>
  
  <!-- Left and right controls -->
  <a class="carousel-control-prev" href="#demo" data-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </a>
  <a class="carousel-control-next" href="#demo" data-slide="next">
    <span class="carousel-control-next-icon"></span>
  </a>
</div>

	








	<div class="row m-5">
		<div class="col-xl-3"></div>
		<div class="col-xl-6">
			<h1>Employees Databases</h1>
			
			
			<!-- 테이블 조회 -->
			<table class="table table-striped table-hover" style="margin: auto; text-align: center">
				<thead class="table-info">
					<tr>
						<th style="width: 50%">Database Name</th>
						<th style="width: 50%">Database Size</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><a href="<%=request.getContextPath()%>/departments/departmentsList.jsp">departments</a></td>
						<td><%=departmentDB %></td>
					</tr>
					
					<tr>
						<td><a href="<%=request.getContextPath()%>/employees/employeesList.jsp">employees</a></td>
						<td><%=employeesDB %></td>
					</tr>
					<tr>
						<td><a href="<%=request.getContextPath()%>/deptEmp/deptEmpList.jsp">deptEmp</a></td>
						<td><%=deptEmpDB %></td>
					</tr>
					<tr>
						<td><a href="<%=request.getContextPath()%>/deptManager/deptManagerList.jsp">deptManager</a></td>
						<td><%=deptManagerDB %></td>
					</tr>
					<tr>
						<td><a href="<%=request.getContextPath()%>/titles/titlesList.jsp">titles</a></td>
						<td><%=titlesDB %></td>
					</tr>
					<tr>
						<td><a href="<%=request.getContextPath()%>/salaries/salariesList.jsp">salaries</a></td>
						<td><%=salariesDB %></td>
					</tr>
					<tr>
						<td><a href="<%=request.getContextPath()%>/qna/qnaList.jsp">qna</a></td>
						<td><%=qnaDB %></td>
					</tr>
				</tbody>

			</table>	
		
		
		
		</div>
		<div class="col-xl-3"></div>
	</div>



</div>
</body>
</html>