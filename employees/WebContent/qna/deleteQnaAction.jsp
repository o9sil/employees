<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");

	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	//System.out.println("qnaNo : " + qnaNo);
	String qnaPw = request.getParameter("qnaPw");
	//System.out.println("qnaPw : " + qnaPw);
	
	
	//2.0 database
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");
	
	
	PreparedStatement stmt1 = null;
	PreparedStatement stmt2 = null;
	
	stmt1 = conn.prepareStatement("DELETE FROM employees_qna WHERE qna_no=? AND qna_pw=?;");	
	stmt1.setInt(1, qnaNo);
	stmt1.setString(2, qnaPw);
	
	int row = stmt1.executeUpdate();
	
	stmt2 = conn.prepareStatement("DELETE FROM employees_qna_comment WHERE qna_no=?");
	stmt2.setInt(1, qnaNo);
	
	//삭제 실패 = 0 성공 = else
	if(row==0){
		response.sendRedirect(request.getContextPath() + "/qna/deleteQnaForm.jsp?qnaNo=" + qnaNo);
	}else{
		//댓글도 전부 삭제
		int row2 = stmt2.executeUpdate();
		//실패
		if(row2==0){
			response.sendRedirect(request.getContextPath() + "/qna/deleteQnaForm.jsp?qnaNo=" + qnaNo);
		}else{
			response.sendRedirect(request.getContextPath() + "/qna/qnaList.jsp");	
		}		
		
	}
	
	
%>
