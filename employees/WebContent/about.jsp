<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>about</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>



<style>
	tbody, tr, td {
		text-align: center;
		vertical-align: middle;
	}
</style>

</head>
<body>
<div class="container-fluid">

	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
	
	<div class="row m-3">
		
		<div class="col-xl-3"></div>
		<div class="col-xl-6">
			
			<!-- 기본정보 -->
			<table class="table table-bordered">
				<tbody>
					<tr style="text-align: center; vertical-align: middle;">					
						<td rowspan="3" style="text-align: center; vertical-align: middle; line-height:0">							
							<img src="<%=request.getContextPath()%>/imgs/jschoi.jpg" style="width: 120px; height: 160px; margin:0; padding:0">
						</td>
						<td rowspan="2" style="text-align: center; vertical-align: middle;" class="table-active">성명</td>
						<td style="text-align: center; vertical-align: middle;">최지선</td>
						<td style="text-align: center; vertical-align: middle;" class="table-active">생년월일</td>
						<td style="text-align: center; vertical-align: middle;">1994.02.13</td>
					</tr>
					
					<tr>
						
						
						<td style="text-align: center; vertical-align: middle;">Choi jisun</td>
						<td style="text-align: center; vertical-align: middle;" class="table-active">휴대폰</td>
						<td style="text-align: center; vertical-align: middle;">010-8590-8216</td>
					</tr>
					
					<tr>
						
						<td style="text-align: center; vertical-align: middle;" class="table-active">현주소</td>
						<td style="text-align: center; vertical-align: middle;">경기도 광명시 안현로 34 305-804<br>
						</td>
						<td style="text-align: center; vertical-align: middle;" class="table-active">이메일</td>
						<td style="text-align: center; vertical-align: middle;">sungooza@naver.com</td>
					</tr>
				</tbody>	
			</table>
				
			<!-- 학력사항 -->
			<table class="table table-bordered">
				<tbody>
					<tr class="table-active">
						<td rowspan="5" style="text-align: center; vertical-align: middle">
							학<br>
							력<br>
							사<br>
							항
						</td>
						<td>졸업일</td>
						<td>학교명</td>
						<td>전 공</td>
						<td>졸업여부</td>
						<td>소재지</td>
						<td>성적</td>
					</tr>
				
				
				
					<tr>
						
						<td>2012년 2월</td>
						<td>소하 고등학교</td>
						<td> - </td>
						<td>졸업</td>
						<td>경기도 광명시</td>
						<td> - </td>
					</tr>	
					
					<tr>
						
						<td>2018년 2월</td>
						<td>대전 대학교</td>
						<td>컴퓨터공학</td>
						<td>졸업</td>
						<td>대전광역시</td>
						<td> - </td>
					</tr>
					
					<tr>
						
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					
					<tr>
						
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					
						
				</tbody>	
			</table>
			
			<!-- 경력사항 -->
			<table class="table table-bordered">
				<tbody>
					<tr class="table-active">
						<td rowspan="4" style="text-align: center; vertical-align: middle;">
							경<br>
							력<br>
							사<br>
							항
						</td>
						<td>근 무 기 간</td>
						<td>회 사 명</td>
						<td>직 위</td>
						<td>담 당 업 무</td>
						<td>퇴사사유</td>
					</tr>
					
					<tr>
						
						<td>2018.01.02 ~ 2019.09.11</td>
						<td>한위드정보기술</td>
						<td>사원</td>
						<td>C 프로그래밍 개발</td>
						<td>개인사정</td>
					</tr>
					
					<tr>
						
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					
					<tr>
						
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</tbody>
			</table>
			
			<!-- 기타사항 -->
			<table class="table table-bordered">
				<tbody>
					<tr>
						<td rowspan="6" style="text-align: center; vertical-align: middle;" class="table-active">
							기<br>
							타<br>
							사<br>
							항
						</td>
						<td class="table-active">신 장</td>
						<td>177cm</td>
						<td class="table-active">체 중</td>
						<td>61kg</td>
						<td class="table-active">시 력</td>
						<td>1.0 / 1.0</td>
					</tr>
					
					<tr>
						
						<td class="table-active">취 미</td>
						<td>&nbsp;</td>
						<td class="table-active">특 기</td>
						<td>&nbsp;</td>
						<td class="table-active">종 교</td>
						<td>무교</td>
					</tr>
					
					<tr>
						
						<td rowspan="4" style="text-align: center; vertical-align: middle;" class="table-active">전산능력</td>
						<td class="table-active">프로그램명</td>
						<td class="table-active">활용도</td>
						<td colspan="3" class="table-active">자격증 보유 현황</td>
						
						
					</tr>
					
					<tr>
						
						
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="3">&nbsp;</td>
						
						
					</tr>
					
					<tr>
						
						
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="3">&nbsp;</td>
						
		
					</tr>
					
					<tr>
						
						
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td colspan="3">&nbsp;</td>
						
		
					</tr>
				</tbody>	
			</table>
			
		
		
		
		</div>
		<div class="col-xl-3"></div>	
	</div>
	
	
	


</div>
</body>
</html>