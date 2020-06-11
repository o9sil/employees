<%@page import="java.net.URLEncoder"%>
<%@page import="java.beans.Encoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String resultValue = "";
	
	// 회원가입폼으로 되돌아갈지 0=되돌아감 1=회원가입성공
	int updateUserActionNum = 1;
	
	
	String updateUserDB = "UPDATE employees_signup SET ";


	
	if(request.getParameter("updatePw1") == null || request.getParameter("updatePw1") == ""){
		//비밀번호 1 공백
		resultValue += "&pw1Check=checkNull";
		updateUserActionNum = 0;
	}else{
		resultValue += "&Pw1=" + request.getParameter("updatePw1");
		updateUserDB += "pw='" + request.getParameter("updatePw1") +"', ";
	}
	
	if(request.getParameter("updatePw2") == null || request.getParameter("updatePw2") == ""){
		//비밀번호 2 공백
		resultValue += "&pw2Check=checkNull";
		updateUserActionNum = 0;
	}else{
		resultValue += "&Pw2=" + request.getParameter("updatePw2");
		updateUserDB += "pw2='" + request.getParameter("updatePw2") +"', ";
	}
	
	if(request.getParameter("updatePw1") == null || request.getParameter("updatePw1") == "" ||
			request.getParameter("updatePw2") == null || request.getParameter("updatePw2") == ""){		
		
	}else{
		if(request.getParameter("updatePw1").equals(request.getParameter("updatePw2"))){
			
		}else{
			resultValue += "&pwEquals=false";
			updateUserActionNum = 0;
		}
	}
	
	if(request.getParameter("updateName") == null || request.getParameter("updateName") == ""){
		//이름 공백
		resultValue += "&nameCheck=checkNull";		
		updateUserActionNum = 0;
	}else{
		resultValue += "&Name=" + URLEncoder.encode(request.getParameter("updateName"), "utf-8");
		//resultValue += "&Name=" + request.getParameter("updateName");
		updateUserDB += "name='" + request.getParameter("updateName") +"', ";
	}


	
	if(request.getParameter("updateRadioGender") == null || request.getParameter("updateRadioGender") == ""){
		updateUserDB += "gender=NULL, ";
		resultValue += "&Gender=Null";
	}else{		
		resultValue += "&Gender=" + request.getParameter("updateRadioGender");
		updateUserDB += "gender='" + request.getParameter("updateRadioGender") +"', ";
	}
	
	if(request.getParameter("updateemail") == null || request.getParameter("updateemail") == ""){
		updateUserDB += "email=NULL, ";
		resultValue += "&Email=Null";
	}else{		
		resultValue += "&Email=" + request.getParameter("updateemail");
		updateUserDB += "email='" + request.getParameter("updateemail") +"', ";
	}
	
	if(request.getParameter("updateAddress1") == null || request.getParameter("updateAddress1") == ""){
		updateUserDB += "address=NULL, ";		
		resultValue += "&Address1=Null";
	}else{
		resultValue += "&Address1=" + URLEncoder.encode(request.getParameter("updateAddress1"), "utf-8");
		//resultValue += "&Address1=" + request.getParameter("updateAddress1");
		updateUserDB += "address='" + request.getParameter("updateAddress1") +"', ";
	}
	
	if(request.getParameter("updateAddress2") == null || request.getParameter("updateAddress2") == ""){
		updateUserDB += "address2=NULL, ";		
		resultValue += "&Address2=Null";
	}else{		
		resultValue += "&Address2=" + URLEncoder.encode(request.getParameter("updateAddress2"), "utf-8");
		//resultValue += "&Address2=" + request.getParameter("updateAddress2");
		updateUserDB += "address2='" + request.getParameter("updateAddress2") +"', ";
	}
	
	if(request.getParameter("updateCellphone") == null || request.getParameter("updateCellphone") == ""){
		updateUserDB += "cellphone=NULL ";		
		resultValue += "&Cellphone=Null";
	}else{
		resultValue += "&Cellphone=" + request.getParameter("updateCellphone");
		updateUserDB += "cellphone='" + request.getParameter("updateCellphone") +"' ";
	}
	
	
	
	updateUserDB += "WHERE id='" + request.getParameter("updateId") +"';";


	//System.out.println(resultValue);
	//System.out.println(updateUserDB);
	
	// signUpActionNum 0=회원가입폼 1=회원가입 성공
	if(updateUserActionNum == 0){
		response.sendRedirect(request.getContextPath() + "/signUp/updateUser.jsp?" + resultValue);	
		return;
	}else{
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");					
		PreparedStatement stmt1 = conn.prepareStatement(updateUserDB);
		stmt1.executeUpdate();
		
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}	
%>