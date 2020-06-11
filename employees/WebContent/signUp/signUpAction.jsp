<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	String resultValue = "";
	
	// 회원가입폼으로 되돌아갈지 0=되돌아감 1=회원가입성공
	int signUpActionNum = 1;
	
	
	String signupInsertDB = "INSERT INTO employees_SIGNUP(id, pw, pw2, NAME, gender, email, address, address2, cellphone) VALUES(";

	if(request.getParameter("signUpId") == null || request.getParameter("signUpId") == ""){
		//아이디 공백
		resultValue += "&idCheck=checkNull";
		signUpActionNum = 0;
	}else{
		resultValue += "&Id=" + request.getParameter("signUpId");
		signupInsertDB += "'" + request.getParameter("signUpId") +"', ";
	}
	
	
	if(request.getParameter("signUpIdCheck").equals("0")){
		//아이디 중복 혹은 미확인일 경우
		signUpActionNum = 0;
	}	
	
	
	if(request.getParameter("signUpPw1") == null || request.getParameter("signUpPw1") == ""){
		//비밀번호 1 공백
		resultValue += "&pw1Check=checkNull";
		signUpActionNum = 0;
	}else{
		resultValue += "&Pw1=" + request.getParameter("signUpPw1");
		signupInsertDB += "'" + request.getParameter("signUpPw1") +"', ";
	}
	
	if(request.getParameter("signUpPw2") == null || request.getParameter("signUpPw2") == ""){
		//비밀번호 2 공백
		resultValue += "&pw2Check=checkNull";
		signUpActionNum = 0;
	}else{
		resultValue += "&Pw2=" + request.getParameter("signUpPw2");
		signupInsertDB += "'" + request.getParameter("signUpPw2") +"', ";
	}
	
	if(request.getParameter("signUpPw1") == null || request.getParameter("signUpPw1") == "" ||
			request.getParameter("signUpPw2") == null || request.getParameter("signUpPw2") == ""){		
		
	}else{
		if(request.getParameter("signUpPw1").equals(request.getParameter("signUpPw2"))){
			
		}else{
			resultValue += "&pwEquals=false";
			signUpActionNum = 0;
		}
	}
	
	if(request.getParameter("signUpName") == null || request.getParameter("signUpName") == ""){
		//이름 공백
		resultValue += "&nameCheck=checkNull";
		signUpActionNum = 0;
	}else{
		resultValue += "&Name=" + URLEncoder.encode(request.getParameter("signUpName"), "utf-8");
		//resultValue += "&Name=" + request.getParameter("signUpName");
		signupInsertDB += "'" + request.getParameter("signUpName") +"', ";
	}
	
	if(request.getParameter("signUpRadioGender") == null || request.getParameter("signUpRadioGender") == ""){
		signupInsertDB += "NULL, ";		
	}else{		
		resultValue += "&Gender=" + request.getParameter("signUpRadioGender");
		signupInsertDB += "'" + request.getParameter("signUpRadioGender") +"', ";
	}
	
	if(request.getParameter("signUpemail") == null || request.getParameter("signUpemail") == ""){
		signupInsertDB += "NULL, ";		
	}else{		
		resultValue += "&Email=" + request.getParameter("signUpemail");
		signupInsertDB += "'" + request.getParameter("signUpemail") +"', ";
	}
	
	if(request.getParameter("signUpAddress1") == null || request.getParameter("signUpAddress1") == ""){
		signupInsertDB += "NULL, ";		
	}else{		
		resultValue += "&Address1=" + URLEncoder.encode(request.getParameter("signUpAddress1"), "utf-8");
		//resultValue += "&Address1=" + request.getParameter("signUpAddress1");
		signupInsertDB += "'" + request.getParameter("signUpAddress1") +"', ";
	}
	
	if(request.getParameter("signUpAddress2") == null || request.getParameter("signUpAddress2") == ""){
		signupInsertDB += "NULL, ";		
	}else{		
		resultValue += "&Address2=" + URLEncoder.encode(request.getParameter("signUpAddress2"), "utf-8");
		//resultValue += "&Address2=" + request.getParameter("signUpAddress2");
		signupInsertDB += "'" + request.getParameter("signUpAddress2") +"', ";
	}
	
	if(request.getParameter("signUpCellphone") == null || request.getParameter("signUpCellphone") == ""){
		signupInsertDB += "NULL";		
	}else{
		resultValue += "&Cellphone=" + request.getParameter("signUpCellphone");
		signupInsertDB += "'" + request.getParameter("signUpCellphone") +"'";
	}
	
	signupInsertDB += ");";
	
	
	//System.out.println(signupInsertDB);
	
	// signUpActionNum 0=회원가입폼 1=회원가입 성공
	if(signUpActionNum == 0){
		response.sendRedirect(request.getContextPath() + "/signUp/signUp.jsp?" + resultValue);	
		return;
	}else{
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");					
		PreparedStatement stmt1 = conn.prepareStatement(signupInsertDB);
		stmt1.executeUpdate();
		
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}	


%>