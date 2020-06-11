<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
    
    
<%
	request.setCharacterEncoding("utf-8");

	// 게시글 번호 확인
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	

	//request 인코딩 설정
	request.setCharacterEncoding("utf-8");

	// request 매개값	
	String qnaTitle = request.getParameter("qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	String qnaUser = request.getParameter("qnaUser");
	String qnaPw = request.getParameter("qnaPw");
	
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");
	PreparedStatement stmt = conn.prepareStatement("SELECT qna_pw FROM employees_qna WHERE qna_no=?;");
	ResultSet rs = null;	
	stmt.setInt(1, qnaNo);
	
	rs = stmt.executeQuery();
	
	if(rs.next()){
		//비밀번호 일치시
		if(rs.getString("qna_pw").equals(qnaPw)){
			
			stmt = conn.prepareStatement("UPDATE employees_qna SET qna_title=?, qna_content=?, qna_user=? WHERE qna_no=?;");	
			//System.out.println("stmt : " + stmt);
			stmt.setString(1, qnaTitle);
			stmt.setString(2, qnaContent);
			stmt.setString(3, qnaUser);
			stmt.setInt(4, qnaNo);		
			
			
			rs = stmt.executeQuery();
			//System.out.println("rs :" + rs);
			
			
		}else{
			response.sendRedirect(request.getContextPath() + "/qna/selectQna.jsp?ck=fail&&qnaNo=" + qnaNo);
			
			return;		// 코드진행(명령)을 끝낸다.			
		}
	}
	

	response.sendRedirect(request.getContextPath() + "/qna/selectQna.jsp?qnaNo=" + qnaNo);


%>