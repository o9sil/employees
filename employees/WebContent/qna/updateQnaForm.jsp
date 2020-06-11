<%@page import="gd.emp.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateQnaForm</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>




</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	int qnaNo = Integer.parseInt(request.getParameter("qnaNo")); 

	//2.0 database
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");
	
	// 2.1 현재페이지의 departments 테이블 행들 가져오기
	ArrayList<QnA> list = new ArrayList<QnA>();
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	stmt1 = conn.prepareStatement("SELECT qna_no, qna_title, qna_content, qna_user, qna_pw, qna_date, qna_ip FROM employees_qna WHERE qna_no=?;");
	stmt1.setInt(1, qnaNo);
	
	rs1 = stmt1.executeQuery();
	
	while(rs1.next()){
		QnA q = new QnA();
		q.qnaNo = rs1.getInt("qna_no");
		q.qnaTitle = rs1.getString("qna_title");	
		q.qnaContent = rs1.getString("qna_content");
		q.qnaUser = rs1.getString("qna_user");
		q.qnaPw = rs1.getString("qna_pw");
		q.qnaDate = rs1.getString("qna_date");
		q.qnaIp = rs1.getString("qna_ip");
		
		list.add(q);
	}

%>

<div class="container-fluid">
	
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
	
	<!-- 리스트 목록 -->
	<div class="row m-5">
		<div class="col-xl-3"></div>
		<div class="col-xl-6">
			<h1>updateQnA</h1>
				
			
			<%
					for(QnA q : list){
						
					
			%>
			
			<form method="post" action="<%=request.getContextPath()%>/qna/updateQnaAction.jsp?qnaNo=<%=q.qnaNo%>">				
				
				
				
  				<!-- 부서 리스트 -->
				<table class="table table-bordered table-hover" style="text-align: center">
					<thead class="table-info">
						<tr>
							<th colspan="2">질문 게시글 수정</th>														
						</tr>
					</thead>
					<tbody>
						
						<tr>
							<td style="width: 10%">제목</td>
							<td>
								<input type="text" class="form-control" id="qnaTitle" name="qnaTitle" value="<%=q.qnaTitle%>">		
							</td>							
						</tr>
						
						<tr>
							<td>내용</td>
							<td>
								<textarea class="form-control" rows="10" id="qnaContent" name="qnaContent"><%=q.qnaContent %>
	  							</textarea>	
							</td>							
						</tr>
						
						<tr>
							<td>작성자</td>
							<td>
								<input type="text" class="form-control" id="qnaUser" name="qnaUser" value="<%=q.qnaUser%>">	
							</td>							
						</tr>
						
						<tr>
							<td>비밀번호</td>
							<td>
								<input type="password" class="form-control" id="qnaPw" name="qnaPw">
							</td>							
						</tr>
						
					</tbody>
	
				</table>
			  
			  	<div style="text-align: center">			  		
			  		<button type="submit" class="btn btn-primary" name="updateButton">수정 완료</button>
			  		
			  		<a class="btn btn-info"
						href="<%=request.getContextPath()%>/qna/selectQna.jsp?qnaNo=<%=q.qnaNo %>">수정 취소
					</a>
			  	</div>
			  	
			  	
			  	<%
					}
			  	%>
		  	</form>

				
			
				
			 
			
		</div>
		<div class="col-xl-3"></div>
	</div>
</div>
</body>
</html>
