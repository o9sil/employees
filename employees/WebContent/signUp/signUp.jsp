<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signUp</title>
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
                document.getElementById("signUpAddress1").value = addr;                    
                document.getElementById("signUpAddress1").value += extraAddr;
                // 커서를 상세주소 필드로 이동한다.                
                document.getElementById("signUpAddress2").focus();
            }
        }).open();
    }
</script>

</head>

<body>



<%

	

	String idcheck = "ID 중복 체크를 해주세요";
	String pw1check = "";
	String pw2check = "";
	String namecheck = "";
	
	int checkIDnum = 0;
	
	if(request.getParameter("dbCount") != null){
		if(request.getParameter("dbCount").equals("1")){
			//중복된 DB 존재
			idcheck = "동일한 ID가 있습니다";
			checkIDnum = 0;
		}else if(request.getParameter("dbCount").equals("2")){
			//아이디 입력 안함
			idcheck = "ID를 입력하세요";
			checkIDnum = 0;
		}else if(request.getParameter("dbCount").equals("0")){
			//중복된 DB 없음
			idcheck = "사용 가능한 ID 입니다";
			checkIDnum = 1;
		}
	}
	
	//아이디 빈칸일 경우
	if(request.getParameter("idCheck") != null && request.getParameter("idCheck") != ""){
		if(request.getParameter("idCheck").equals("checkNull")){
			idcheck = "아이디를 입력하세요";
		}else{
			idcheck = "";
		}	
	}
	
	
	//pw1 빈칸일 경우
	if(request.getParameter("pw1Check") != null && request.getParameter("pw1Check") != ""){
		if(request.getParameter("pw1Check").equals("checkNull")){
			pw1check = "비밀번호를 입력하세요";
		}else{
			pw1check = "";
		}	
	}
	
	//pw2 빈칸일 경우
	if(request.getParameter("pw2Check") != null && request.getParameter("pw2Check") != ""){
		if(request.getParameter("pw2Check").equals("checkNull")){
			pw2check = "비밀번호를 입력하세요";
		}else{
			pw2check = "";
		}	
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
			namecheck = "이름을 입력하세요";
		}else{
			namecheck = "";
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
				<h1>signUp</h1>
				
				<form method="post" class="form-inline" name="userinput">
				<!-- <form method="post" action="<%=request.getContextPath() %>/signUp/signUpAction.jsp" class="form-inline" name="userinput" onsubmit="return checkIt()"> -->
								
					<input type="hidden" name="signUpIdCheck" value="<%=checkIDnum%>">
	  				
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
								<%
									if(request.getParameter("Id") != null && request.getParameter("Id") != ""){										
								%>
										<input type="text" class="form-control" id="signUpId" name="signUpId" value=<%=request.getParameter("Id")%>>
								<%
									}else{
								%>
										<input type="text" class="form-control" id="signUpId" name="signUpId">
								<%		
									}
								%>
									<!-- <input type="text" class="form-control" id="signUpId" name="signUpId">		 -->
									
									<input type="submit" class="btn btn-secondary" value="중복확인" onclick="javascript: form.action='<%=request.getContextPath()%>/signUp/signUpIdCheckAction.jsp';">
									
									<%=idcheck %>
																	
								</td>
															
							</tr>
							
							<tr>
								<td>* 비밀번호</td>
								<td>
								<%
									if(request.getParameter("Pw1") != null && request.getParameter("Pw1") != ""){
								%>
									<input type="password" class="form-control" id="signUpPw1" name="signUpPw1" value="<%=request.getParameter("Pw1")%>">
								<%	
									}else{
								%>
									<input type="password" class="form-control" id="signUpPw1" name="signUpPw1">
								<%
									}
								%>			
								
									<%=pw1check %>														
									
								</td>							
							</tr>
							
							<tr>
								<td>* 비밀번호 확인</td>
								<td>
								<%
									if(request.getParameter("Pw2") != null && request.getParameter("Pw2") != ""){
								%>
									<input type="password" class="form-control" id="signUpPw2" name="signUpPw2" value="<%=request.getParameter("Pw2")%>">
								<%
									}else{
								%>	
									<input type="password" class="form-control" id="signUpPw2" name="signUpPw2">
								<%
									}
								%>
								
									<%=pw2check %>	
									
								</td>							
							</tr>
							
							<tr>
								<td>* 이름</td>
								<td>
								<%
									if(request.getParameter("Name") != null && request.getParameter("Name") != ""){
								%>
									<input type="text" class="form-control" id="signUpName" name="signUpName" value="<%=request.getParameter("Name")%>">
								<%
									}else{
								%>
									<input type="text" class="form-control" id="signUpName" name="signUpName">
								<%
									}
								%>	
								
									<%=namecheck %>	
								</td>							
							</tr>
							
							<tr>
								<td>성별</td>
								<td>
								<%
									if(request.getParameter("Gender") != null && request.getParameter("Gender") != ""){
										if(request.getParameter("Gender").equals("M")){
								%>
								
											<div class="custom-control custom-radio custom-control-inline">
		    									<input type="radio" class="custom-control-input" id="customRadio" name="signUpRadioGender" value="M" checked="checked">
		    									<label class="custom-control-label" for="customRadio">Male</label>
		  									</div>
		  									<div class="custom-control custom-radio custom-control-inline">
		    									<input type="radio" class="custom-control-input" id="customRadio2" name="signUpRadioGender" value="F">
		    									<label class="custom-control-label" for="customRadio2">Female</label>
		  									</div>
  								
  								<%
										}else if(request.getParameter("Gender").equals("F")){
								%>
											<div class="custom-control custom-radio custom-control-inline">
		    									<input type="radio" class="custom-control-input" id="customRadio" name="signUpRadioGender" value="M">
		    									<label class="custom-control-label" for="customRadio">Male</label>
		  									</div>
		  									<div class="custom-control custom-radio custom-control-inline">
		    									<input type="radio" class="custom-control-input" id="customRadio2" name="signUpRadioGender" value="F" checked="checked">
		    									<label class="custom-control-label" for="customRadio2">Female</label>
		  									</div>
								<%
										}
  								%>	
  								
  								<%
									}else{
  								%>
	  									<div class="custom-control custom-radio custom-control-inline">
	    									<input type="radio" class="custom-control-input" id="customRadio" name="signUpRadioGender" value="M">
	    									<label class="custom-control-label" for="customRadio">Male</label>
	  									</div>
	  									<div class="custom-control custom-radio custom-control-inline">
	    									<input type="radio" class="custom-control-input" id="customRadio2" name="signUpRadioGender" value="F">
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
									if(request.getParameter("Email") != null && request.getParameter("Email") != ""){
								%>
										<input type="text" class="form-control" id="signUpemail" name="signUpemail" value=<%=request.getParameter("Email") %>>
								<%
									}else{
								%>
										<input type="text" class="form-control" id="signUpemail" name="signUpemail">
								<%
									}
								%>	
								</td>							
							</tr>
							
							<tr>
								<td>주소</td>
								<td>
								<%
									if(request.getParameter("Address1") != null && request.getParameter("Address1") != ""){
								%>
										<input type="text" class="form-control" id="signUpAddress1" name="signUpAddress1" value=<%=request.getParameter("Address1") %>>
								<%
									}else{
								%>	
										<input type="text" class="form-control" id="signUpAddress1" name="signUpAddress1">
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
									if(request.getParameter("Address2") != null && request.getParameter("Address2") != ""){
								%>
										<input type="text" class="form-control" id="signUpAddress2" name="signUpAddress2" value=<%=request.getParameter("Address2") %>>
								<%
									}else{
								%>
										<input type="text" class="form-control" id="signUpAddress2" name="signUpAddress2">
								<%
									}
								%>
								</td>
															
							</tr>
							
							<tr>
								<td>휴대폰</td>
								<td>
								<%
									if(request.getParameter("Cellphone") != null && request.getParameter("Cellphone") != ""){
								%>
										<input type="text" class="form-control" id="signUpCellPhone" name="signUpCellphone" value=<%=request.getParameter("Cellphone") %>>
								<%
									}else{
								%>
										<input type="text" class="form-control" id="signUpCellPhone" name="signUpCellphone">	
								<%
									}
								%>
								</td>
															
							</tr>
							
						</tbody>
		
					</table>
				  
				  	<div style="text-align: center;">
				  		<!-- <button type="submit" class="btn btn-primary">회원 가입</button> -->
				  		<input type="submit" class="btn btn-primary" value="회원가입" onclick="javascript: form.action='<%=request.getContextPath()%>/signUp/signUpAction.jsp';">
				  		<a href="<%=request.getContextPath()%>/signUp/signUp.jsp" class="btn btn-info">다시 입력</a>
				  		<!-- <button type="reset" class="btn btn-info">다시 입력</button> -->									
				  	</div>
				  	
			  	</form>
				
			</div>
			<div class="col-xl-3"></div>
		</div>
	

</div>



</body>
</html>