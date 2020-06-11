<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	// 열: dept_no, dept_name
	// dept_name
	String deptName = request.getParameter("deptName");

	// dept_no	?
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");		
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	//마지막 dept_no 번호 가져오기
	stmt = conn.prepareStatement("SELECT dept_no FROM employees_departments ORDER BY dept_no DESC LIMIT 0, 1;");
	rs = stmt.executeQuery();
	
	String deptNo = "";
		
	if(rs.next()){
		deptNo = rs.getString("dept_no");		
	}
	

	//dept_no 번호에 1 추가해서 번호 생성	
	int deptNoInt = Integer.parseInt(deptNo.substring(1)) + 1;
	String deptNoString = String.format("%03d", deptNoInt);	
	deptNoString = "d" + deptNoString;	
	
	PreparedStatement stmt2 = conn.prepareStatement("insert into employees_departments(dept_no, dept_name) values(?, ?)");
	stmt2.setString(1, deptNoString);
	stmt2.setString(2, deptName);
	
	stmt2.executeUpdate();
	
	response.sendRedirect(request.getContextPath() + "/departments/departmentsList.jsp");

	
%>
</body>
</html>