<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	//System.out.println("qnaNo :" + qnaNo);
	String commentUser = request.getParameter("commentUser");
	String comment = request.getParameter("comment");
	String commentPw = request.getParameter("commentPw");
	
	/* System.out.println("commentUser : " + commentUser);
	System.out.println("comment : " + comment);
	System.out.println("commentPw : " + commentPw); */
	
	if(commentUser == "" || commentUser == null || comment == "" || comment == null || commentPw == "" || commentPw == null){
		response.sendRedirect(request.getContextPath() + "/qna/selectQna.jsp?qnaNo=" + qnaNo);
		
		return;
	}
	
	

	int commentNo = 1;
	//2.0 database
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");	
	PreparedStatement stmt1 = conn.prepareStatement("SELECT MAX(comment_no) FROM employees_qna_comment;"); 
	ResultSet rs1 = stmt1.executeQuery();	
	
	if(rs1.next()){
		commentNo = rs1.getInt("MAX(comment_no)") + 1;
		System.out.println(commentNo);
	}
	
	PreparedStatement stmt2 = conn.prepareStatement("INSERT INTO employees_qna_comment(comment_no, qna_no, comment_user, comment, comment_date, comment_pw) VALUES(?, ?, ?, ?, NOW(), ?)");
	stmt2.setInt(1, commentNo);
	stmt2.setInt(2, qnaNo);
	stmt2.setString(3, commentUser);
	stmt2.setString(4, comment);
	stmt2.setString(5, commentPw);	
	
	stmt2.executeUpdate();
	
	
	response.sendRedirect(request.getContextPath() + "/qna/selectQna.jsp?qnaNo=" + qnaNo);

%>