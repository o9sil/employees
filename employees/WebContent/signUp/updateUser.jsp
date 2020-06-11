<%@page import="java.sql.*"%>
<%@page import="gd.emp.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UpdateUser</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

               
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.                                    
               

                // 우편번호와 주소 정보를 해당 필드에 넣는다.                
                document.getElementById("updateAddress1").value = addr;                    
                document.getElementById("updateAddress1").value += extraAddr;
                // 커서를 상세주소 필드로 이동한다.                
                document.getElementById("updateAddress2").focus();
            }
        }).open();
    }
</script>

</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	String loginID = "";
	
	String pw1check = "";
	String pw2check = "";
	String namecheck = "";
	

	
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	SignUp signup = new SignUp();
	
	try{
		loginID = (String)session.getAttribute("loginID");		
		Class.forName("org.mariadb.jdbc.Driver");
		
		conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");					
		stmt = conn.prepareStatement("SELECT id, pw, pw2, name, gender, email, address, address2, cellphone FROM employees_signup WHERE id=?");
		stmt.setString(1, loginID);
		rs = stmt.executeQuery();
		
		if(rs.next()){
			signup.pw = rs.getString("pw");
			signup.pw2 = rs.getString("pw2");
			signup.name = rs.getString("name");
			signup.gender = rs.getString("gender");
			signup.email = rs.getString("email");
			signup.address = rs.getString("address");
			signup.address2 = rs.getString("address2");
			signup.cellphone = rs.getString("cellphone");
		}
		
		
		
		
	}catch(NullPointerException e){
		
	}
	
	//pw1 빈칸일 경우
	if(request.getParameter("pw1Check") != null && request.getParameter("pw1Check") != ""){
		if(request.getParameter("pw1Check").equals("checkNull")){
			signup.pw = "";
			pw1check = "비밀번호를 입력하세요";
		}else{
			pw1check = "";
		}	
	}
	
	if(request.getParameter("Pw1") != null && request.getParameter("Pw1") != ""){
		signup.pw = request.getParameter("Pw1");
	}
	
	//pw2 빈칸일 경우
	if(request.getParameter("pw2Check") != null && request.getParameter("pw2Check") != ""){
		if(request.getParameter("pw2Check").equals("checkNull")){
			signup.pw2 = "";
			pw2check = "비밀번호를 입력하세요";
		}else{
			pw2check = "";
		}	
	}
	
	if(request.getParameter("Pw2") != null && request.getParameter("Pw2") != ""){
		signup.pw2 = request.getParameter("Pw2");
	}
	
	if(request.getParameter("pwEquals") != null && request.getParameter("pwEquals") != ""){
		if(request.getParameter("pwEquals").equals("false")){
			//비밀번호 불일치
			pw1check = "비밀번호가 일치하지 않습니다";
			pw2check = "";
		}
	}	
	
	
	//이름 빈칸일 경우
	if(request.getParameter("nameCheck") != null && request.getParameter("nameCheck") != ""){
		if(request.getParameter("nameCheck").equals("checkNull")){
			signup.name = "";
			namecheck = "이름을 입력하세요";
		}else{
			namecheck = "";
		}	
	}
	
	if(request.getParameter("Name") != null && request.getParameter("Name") != ""){
		signup.name = request.getParameter("Name");
	}
		
	
	if(request.getParameter("Gender") != null && request.getParameter("Gender") != ""){
		if(request.getParameter("Gender").equals("Null")){
			signup.gender= null;
		}else if(request.getParameter("Gender").equals("M")){
			signup.gender= "M";		
		}else if(request.getParameter("Gender").equals("F")){
			signup.gender= "F";		
		}
	}
	
	if(request.getParameter("Email") == null || request.getParameter("Email") == ""){
		
	}else{
		if(request.getParameter("Email").equals("Null")){
			signup.email = "";
		}else{
			signup.email = request.getParameter("Email");
		}
	}
	
	if(request.getParameter("Address1") == null || request.getParameter("Address1") == ""){
		
	}else{
		if(request.getParameter("Address1").equals("Null")){
			signup.address = "";
		}else{
			signup.address = request.getParameter("Address1");
		}
	}
	
	if(request.getParameter("Address2") == null || request.getParameter("Address2") == ""){
		
	}else{
		if(request.getParameter("Address2").equals("Null")){
			signup.address2 = "";
		}else{
			signup.address2 = request.getParameter("Address2");
		}
	}
	
	if(request.getParameter("Cellphone") == null || request.getParameter("Cellphone") == ""){
		
	}else{
		if(request.getParameter("Cellphone").equals("Null")){
			signup.cellphone = "";
		}else{
			signup.cellphone = request.getParameter("Cellphone");
		}
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
				<h1>UpdateUser</h1>
				
				<form method="post" class="form-inline" name="logininput">
					<table class="table">
						<thead class="table-info">
							<tr>
								<th colspan="3" style="text-align: center">회원 가입</th>														
							</tr>
						</thead>
						<tbody>
							
							<tr>
								<td style="width: 20%">* 아이디</td>
								<td>								
									<input type="text" class="form-control" id="updateId" name="updateId" value=<%=loginID %> readonly="readonly">							
																	
								</td>
															
							</tr>
							
							<tr>
								<td>* 비밀번호</td>
								<td>
									<input type="password" class="form-control" id="updatePw1" name="updatePw1" value="<%=signup.pw%>">		
									
									<%=pw1check %>								
								</td>							
							</tr>
							
							<tr>
								<td>* 비밀번호 확인</td>
								<td>								
									<input type="password" class="form-control" id="updatePw2" name="updatePw2" value="<%=signup.pw2%>">
									
									<%=pw2check %>	
								</td>							
							</tr>
							
							<tr>
								<td>* 이름</td>
								<td>								
									<input type="text" class="form-control" id="updateName" name="updateName" value="<%=signup.name%>">								
									
									<%=namecheck %>	
								</td>							
							</tr>
							
							<tr>
								<td>성별</td>
								<td>
								<%
									if(signup.gender == null){
								%>
										<div class="custom-control custom-radio custom-control-inline">
	    									<input type="radio" class="custom-control-input" id="customRadio" name="updateRadioGender" value="M">
	    									<label class="custom-control-label" for="customRadio">Male</label>
	  									</div>
	  									<div class="custom-control custom-radio custom-control-inline">
	    									<input type="radio" class="custom-control-input" id="customRadio2" name="updateRadioGender" value="F">
	    									<label class="custom-control-label" for="customRadio2">Female</label>
	  									</div>
								<%
									}else if(signup.gender.equals("M")){
								%>
										<div class="custom-control custom-radio custom-control-inline">
	    									<input type="radio" class="custom-control-input" id="customRadio" name="updateRadioGender" value="M" checked="checked">
	    									<label class="custom-control-label" for="customRadio">Male</label>
	  									</div>
	  									<div class="custom-control custom-radio custom-control-inline">
	    									<input type="radio" class="custom-control-input" id="customRadio2" name="updateRadioGender" value="F">
	    									<label class="custom-control-label" for="customRadio2">Female</label>
	  									</div>
								<%
									}else if(signup.gender.equals("F")){
								%>
										<div class="custom-control custom-radio custom-control-inline">
	    									<input type="radio" class="custom-control-input" id="customRadio" name="updateRadioGender" value="M">
	    									<label class="custom-control-label" for="customRadio">Male</label>
	  									</div>
	  									<div class="custom-control custom-radio custom-control-inline">
	    									<input type="radio" class="custom-control-input" id="customRadio2" name="updateRadioGender" value="F" checked="checked">
	    									<label class="custom-control-label" for="customRadio2">Female</label>
	  									</div>
								<%
									}
								%>
									
 								
								</td>							
							</tr>
							
							<tr>
								<td>이메일</td>
								<td>								
								<%
									if(signup.email == null){
								%>
										<input type="text" class="form-control" id="updateemail" name="updateemail">
								<%
									}else{
								%>
										<input type="text" class="form-control" id="updateemail" name="updateemail" value="<%=signup.email%>">
								<%										
									}
								%>
									
								
								</td>							
							</tr>
							
							<tr>
								<td>주소</td>
								<td>
								<%
									if(signup.address == null){
								%>
										<input type="text" class="form-control" id="updateAddress1" name="updateAddress1">
								<%
									}else{
								%>
										<input type="text" class="form-control" id="updateAddress1" name="updateAddress1" value="<%=signup.address%>">
								<%	
									}
								%>									
							
									<input type="button" class="btn btn-secondary" onclick="execDaumPostcode()" value="주소 찾기"><br>	
								</td>
															
							</tr>
							
							<tr>
								<td>상세주소</td>
								<td>	
								<%
									if(signup.address2 == null){
								%>
										<input type="text" class="form-control" id="updateAddress2" name="updateAddress2">
								<%
									}else{
								%>
										<input type="text" class="form-control" id="updateAddress2" name="updateAddress2" value="<%=signup.address2%>">
								<%
									}
								%>							
																	
								</td>
															
							</tr>
							
							<tr>
								<td>휴대폰</td>
								<td>		
								<%
									if(signup.cellphone == null){
								%>
										<input type="text" class="form-control" id="updateCellPhone" name="updateCellphone">
								<%
									}else{
								%>
										<input type="text" class="form-control" id="updateCellPhone" name="updateCellphone" value="<%=signup.cellphone%>">
								<%
									}
								%>						
									
								
								</td>
															
							</tr>
							
						</tbody>
		
					</table>
				  
				  	<div style="text-align: center;">				  		
				  		<input type="submit" class="btn btn-primary" value="회원정보수정" onclick="javascript: form.action='<%=request.getContextPath()%>/signUp/updateUserAction.jsp';">				  		
				  											
				  	</div>
				</form>
			<div class="col-xl-3"></div>
			</div>
		</div>
</div>
				

</body>
</html>