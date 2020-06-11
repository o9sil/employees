<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertQnaForm</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>


</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	String msg = "";
	if(request.getParameter("ck") != null){
		msg = "빈값이 있습니다.";
	}
	
	
	String loginID = "";
	String loginPW = "";
	
	try{
		loginID = (String)session.getAttribute("loginID");
	
		//System.out.println(loginID);
		if(loginID == null){
						
			return;
		}else{
			Class.forName("org.mariadb.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");
			PreparedStatement stmt = conn.prepareStatement("SELECT id, pw FROM employees_signup WHERE id = ?;");
			stmt.setString(1, loginID);
			ResultSet rs = stmt.executeQuery();
			
			if(rs.next()){
				loginPW = rs.getString("pw");
			}
			
		}
	}catch(NullPointerException e){
		
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
			<h1>insertQnAForm<small><%=msg %></small></h1>
			
				
			
			
				<form method="post" action="<%=request.getContextPath()%>/qna/insertQnaAction.jsp">				
					
	  				<!-- 부서 리스트 -->
					<table class="table table-bordered table-hover" style="text-align: center">
						<thead class="table-info">
							<tr>
								<th colspan="2">질문 게시글 작성</th>														
							</tr>
						</thead>
						<tbody>
							
							<tr>
								<td style="width: 13%">제목</td>
								<td>
									<input type="text" class="form-control" id="qnaTitle" name="qnaTitle">		
								</td>							
							</tr>
							
							<tr>
								<td>내용</td>
								<td>
									<textarea class="form-control" rows="10" id="qnaContent" name="qnaContent">
		  							</textarea>	
								</td>							
							</tr>
							
							<tr>
								<td>작성자</td>
								<td>
									<input type="text" class="form-control" id="qnaUser" name="qnaUser" value=<%=loginID %> readonly="readonly">	
								</td>							
							</tr>
							
							<tr>
								<td>비밀번호</td>
								<td>
									<input type="password" class="form-control" id="qnaPw" name="qnaPw" value=<%=loginPW %> readonly="readonly">	
								</td>							
							</tr>
							
						</tbody>
		
					</table>
				  
				  	<div style="text-align: center">
				  		<button type="submit" class="btn btn-primary">작성 완료</button>
				  		<a class="btn btn-info"
							href="<%=request.getContextPath()%>/qna/qnaList.jsp">작성 취소
						</a>
				  	</div>
				  	
			  	</form>

					
		</div>
		<div class="col-xl-3"></div>
	</div>
	
	
	

</div>
</body>
</html>