<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("loginId");
	String pw = request.getParameter("loginPw");
	
	String nullCheck = "?Id=";
	
	if(id == "" || id == null || pw == "" || pw == null){
		if(id == "" || id == null){
			nullCheck += "no";
		}else{
			nullCheck += "yes";
		}
		
		nullCheck += "&Pw=";
		
		if(pw == "" || pw == null){
			nullCheck += "no";
		}else{
			nullCheck += "yes";
		}
		
		//공백 있음
		response.sendRedirect(request.getContextPath() + "/signUp/login.jsp" + nullCheck + "&loginSuccess=false");	
		
		return;
	}
	
	
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");
	PreparedStatement stmt = conn.prepareStatement("SELECT id, pw FROM employees_signup WHERE id = ?;");
	stmt.setString(1, id);
	ResultSet rs = stmt.executeQuery();
	
	if(rs.next()){
		if(rs.getString("id").equals(id) && rs.getString("pw").equals(pw)){
			//System.out.println("로그인 성공");	
			session.setAttribute("loginID", id);
		}else{
			//System.out.println("로그인 실패");
			response.sendRedirect(request.getContextPath() + "/signUp/login.jsp?loginSuccess=false");
			
			return;
		}
	}
	
	response.sendRedirect(request.getContextPath() + "/index.jsp");
	

%>