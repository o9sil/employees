<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>



<%
	// request 인코딩 설정
	request.setCharacterEncoding("utf-8");

	// request 매개값
	int qnaNo = 1;
	String qnaTitle = request.getParameter("qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	String qnaUser = request.getParameter("qnaUser");
	String qnaPw = request.getParameter("qnaPw");	
	String qnaIp = request.getRemoteAddr();
	
	
	//qnaNo
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");
	PreparedStatement stmt = conn.prepareStatement("SELECT max(qna_no) FROM employees_qna;");	
	//System.out.println("stmt : " + stmt);
	
	ResultSet rs = stmt.executeQuery();
	//System.out.println("rs :" + rs);
		
	//qna_no DB 확인
	if(rs.next()){		
		qnaNo = rs.getInt("max(qna_no)") + 1;		
	}	
	//System.out.println("qnaNo :" + qnaNo);
	
	
	
	// 매개값 공백이 있으면 폼으로 되돌려 보냄(ck=fail과 함께)
	if(qnaTitle == null || qnaTitle == "" || qnaContent == null || qnaContent == "" || 
			qnaUser == null || qnaUser == "" || qnaPw == null || qnaPw == "" || qnaIp == null || qnaIp == ""){
		//입력값 없는 항목 존재
		response.sendRedirect(request.getContextPath() + "/qna/insertQnaForm.jsp?ck=fail");
		
		return;		// 코드진행(명령)을 끝낸다.
	}
	
	/* System.out.println("qnaTitle : " + qnaTitle);
	System.out.println("qnaContent : " + qnaContent);
	System.out.println("qnaUser : " + qnaUser);
	System.out.println("qnaPw : " + qnaPw);
	System.out.println("local IP : " + qnaIp); */
	
		
	//qnaDate : sql문에서 now 함수 사용
	stmt = conn.prepareStatement("INSERT INTO employees_qna(qna_no, qna_title, qna_content, qna_user, qna_pw, qna_date, qna_ip) VALUES(?, ?, ?, ?, ?, NOW(), ?)");
	stmt.setInt(1, qnaNo);
	stmt.setString(2, qnaTitle);
	stmt.setString(3, qnaContent);
	stmt.setString(4, qnaUser);
	stmt.setString(5, qnaPw);
	stmt.setString(6, request.getRemoteAddr());
	
	stmt.executeUpdate();
	

	response.sendRedirect(request.getContextPath() + "/qna/qnaList.jsp");
%>
