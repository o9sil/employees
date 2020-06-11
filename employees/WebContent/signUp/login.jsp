<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>


</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	String loginID = "";
	
	try{
		loginID = (String)session.getAttribute("loginID");
	
		//System.out.println(loginID);
	}catch(NullPointerException e){
		
	}

	String loginSuccess = "";
	try{
		loginSuccess = request.getParameter("loginSuccess");
	}catch(NullPointerException e){
		
	}

%>

<div class="container-fluid">
<!-- Navigation MainMenu -->
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>		
	</div>
	
	
		<div class="row m-5">
			<div class="col-xl-3"></div>
			<div class="col-xl-6">
				<h1>Login</h1>
				
				<form method="post" class="form-inline" name="logininput">
					<table class="table">
						<thead class="table-info">
							<tr>
								<th colspan="2" style="text-align: center">로그인</th>														
							</tr>
						</thead>
						<tbody>
							<tr>
								<td style="width: 20%">
									아이디 
								</td>
								
								<td>
									<input type="text" class="form-control" id="loginId" name="loginId">
									<%
										if(loginSuccess != "" && loginSuccess != null){
											if(loginSuccess.equals("false")){
									%>
											로그인에 실패하셨습니다.
									<%
											}
										}
									%>
								</td>
							</tr>
							
							<tr>
								<td>
									비밀번호 
								</td>
								
								<td>
									<input type="password" class="form-control" id="loginPw" name="loginPw">
								</td>
							</tr>						
						</tbody>
					</table>
					
					<input type="submit" class="btn btn-info" value="로그인" onclick="javascript: form.action='<%=request.getContextPath()%>/signUp/loginAction.jsp';">
					&nbsp; &nbsp;
					<input type="submit" class="btn btn-success" value="회원가입" onclick="javascript: form.action='<%=request.getContextPath()%>/signUp/signUp.jsp';">					
					
				</form>
				
				
				
			</div>
			<div class="col-xl-3"></div>
		</div>
</div>

</body>
</html>