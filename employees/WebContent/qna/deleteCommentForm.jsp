<%@page import="gd.emp.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteCommentForm</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	

	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	//System.out.println("qnaNo : " + qnaNo);
	//System.out.println("commentNo : " + commentNo);	


%>


	<div class="container-fluid">
	
		<div>
			<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
		</div>
	
	
		<!-- 리스트 목록 -->
		<div class="row m-5">
			<div class="col-xl-3"></div>
			<div class="col-xl-6">
	
			<h1>deleteCommentForm</h1>
			
			
			<!-- 부서 리스트 -->
			<form method="post" action="<%=request.getContextPath()%>/qna/deleteCommentAction.jsp">
			
				<input type="hidden" name="qnaNo" value="<%=qnaNo %>">
				<input type="hidden" name="commentNo" value="<%=commentNo %>">
				<table class="table table-bordered table-hover" style="text-align: center">
					<thead class="table-info">
						<tr>
							<th colspan="3">댓글 삭제</th>														
						</tr>
					</thead>
					<tbody>
						
						<tr>
							<td style="width: 10%">비밀번호</td>
							<td style="width: 65%">
								<input type="password" class="form-control" id="commentPw" name="commentPw">
							</td>							
							<td>
								<button type="submit" class="btn btn-danger">삭제하기</button>
								<a class="btn btn-info"
									href="<%=request.getContextPath()%>/qna/selectQna.jsp?qnaNo=<%=qnaNo%>">뒤로가기
								</a>
							</td>
						</tr>
						
					
						
					</tbody>
	
				</table>
		
			</form>
		</div>
		<div class="col-xl-3"></div>
		
		
	</div>




</div>


</body>
</html>