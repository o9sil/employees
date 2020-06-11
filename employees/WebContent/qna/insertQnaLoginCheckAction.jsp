<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8");
	
	String loginID = "";
	
	try{
		loginID = (String)session.getAttribute("loginID");
	
		//System.out.println(loginID);
		if(loginID == null){
			// 로그아웃 상태
			response.sendRedirect(request.getContextPath() + "/signUp/login.jsp");
			return;
		}else{
			response.sendRedirect(request.getContextPath() + "/qna/insertQnaForm.jsp");
			return;
		}
	}catch(NullPointerException e){
		
	}


%>