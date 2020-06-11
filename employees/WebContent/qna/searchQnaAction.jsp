<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8");

	String sel1 = request.getParameter("sel1");
	String sel2 = request.getParameter("sel2");
	
	
	
	//sel2의 값은 한글이 올 수도 있는데 sendRedirect는 한글 값을 보낼수가 없음 그러므로 인코딩을 해주어야 함
	String encodedSel2 = URLEncoder.encode(sel2, "UTF-8");


	//System.out.println("Action sel1 : " + sel1);
	//System.out.println("Action sel2 : " + sel2);
	
	String qnaTitle = "qna_title";
	String qnaContent = "qna_content";
	
	if(sel1.equals("qna_title_content")){
		response.sendRedirect(request.getContextPath() + "/qna/qnaList.jsp?sel1=" + qnaTitle + "&sel2=" + encodedSel2 + "&sel3=" + qnaContent + "&sel4=" + encodedSel2);
	}else{
		response.sendRedirect(request.getContextPath() + "/qna/qnaList.jsp?sel1=" + sel1 + "&sel2=" + encodedSel2);	
	}
	
	
	
%>