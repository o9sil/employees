<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");


	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	String commentPw = request.getParameter("commentPw");
	
	
	//System.out.println(qnaNo + " " + commentNo + " " + commentPw);


	//2.0 database
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");
		
		
		PreparedStatement stmt1 = null;
		
		stmt1 = conn.prepareStatement("DELETE FROM employees_qna_comment WHERE qna_no=? AND comment_no=? AND comment_pw=?;");	
		stmt1.setInt(1, qnaNo);
		stmt1.setInt(2, commentNo);
		stmt1.setString(3, commentPw);
		
		int row = stmt1.executeUpdate();
		
		//삭제 실패 = 0 성공 = else
		if(row==0){
			response.sendRedirect(request.getContextPath() + "/qna/deleteCommentForm.jsp?qnaNo=" + qnaNo + "&commentNo=" + commentNo);
		}else{
			response.sendRedirect(request.getContextPath() + "/qna/selectQna.jsp?qnaNo=" + qnaNo);
		}


%>

