<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container-fluid">
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
	
	<form method="post" action="<%=request.getContextPath()%>/departments/insertDepartmentsAction.jsp">
	
	<div class="row m-5">
		<div class="col-xl-3"></div>
		<div class="col-xl-6">
			<h1>부서 입력</h1>
			<div class="input-group mb-3">
				<input type="text" class="form-control" name="deptName">
				<div class="input-group-append">	
		   			<button class="btn btn-success" type="submit">부서입력</button>
		  		</div>
			</div>		
		</div>
		<div class="col-xl-3"></div>
	</div>
		
	</form>
</div>

</body>
</html>