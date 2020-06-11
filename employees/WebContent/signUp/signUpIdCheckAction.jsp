<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String checkID = request.getParameter("signUpId");
		

	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");
	PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM employees_signup WHERE id = ?;");
	stmt.setString(1, checkID);
	ResultSet rs = stmt.executeQuery();

	
	int resultValue = 0;
	
	if(checkID == "" || checkID == null){
		resultValue = 2;
	}
	
	if(rs.next()) {
		int dbCount = rs.getInt("COUNT(*)");		
		if(dbCount == 1){
			resultValue = 1;	
		}		
	}
	
	String inputText = "";
	
	//DB조회 및 ID 중복 여부
	inputText = "dbCount=" + resultValue + "&Id=" + checkID;
	//System.out.println(inputText);
	
	//System.out.println("PW1 : " + request.getParameter("signUpPw1"));
	if(request.getParameter("signUpPw1") != null && request.getParameter("signUpPw1") != ""){
		inputText += "&Pw1=" + request.getParameter("signUpPw1");
	}
	
	if(request.getParameter("signUpPw2") != null && request.getParameter("signUpPw2") != ""){
		inputText += "&Pw2=" + request.getParameter("signUpPw2");
	}
	
	if(request.getParameter("signUpName") != null && request.getParameter("signUpName") != ""){
		inputText += "&Name=" + request.getParameter("signUpName");
	}
	
	if(request.getParameter("signUpRadioGender") != null && request.getParameter("signUpRadioGender") != ""){
		inputText += "&Gender=" + request.getParameter("signUpRadioGender"); 
	}
	
	if(request.getParameter("signUpemail") != null && request.getParameter("signUpemail") != ""){
		inputText += "&Email=" + request.getParameter("signUpemail"); 
	}
	
	if(request.getParameter("signUpAddress1") != null && request.getParameter("signUpAddress1") != ""){
		inputText += "&Address1=" + request.getParameter("signUpAddress1"); 
	}
	
	if(request.getParameter("signUpAddress2") != null && request.getParameter("signUpAddress2") != ""){
		inputText += "&Address2=" + request.getParameter("signUpAddress2"); 
	}
	
	if(request.getParameter("signUpCellphone") != null && request.getParameter("signUpCellphone") != ""){
		inputText += "&Cellphone=" + request.getParameter("signUpCellphone"); 
	}
	
	
	
	//System.out.println(inputText);
	response.sendRedirect(request.getContextPath() + "/signUp/signUp.jsp?" + inputText);
%>