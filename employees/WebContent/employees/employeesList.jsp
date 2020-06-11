<%@page import="gd.emp.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>employeesList</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<%
	int currentPage = 1;	//현재 페이지
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;					//한 페이지당 표시할 정보 수
	
	if(request.getParameter("userDisplay") != null){
		rowPerPage = Integer.parseInt(request.getParameter("userDisplay"));
	}
	
	int beginRow = (currentPage-1) * rowPerPage;	//각 페이지 당 최상단 데이터 정보	(1페이지=0/2페이지=10)
	
	int pagePerGroup = 10;					//한 화면당 하단 페이지 목록 수
	
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");
		
	ArrayList<Employees> list = new ArrayList<Employees>();
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	
	
	// 주소 뒤 ?에 올 string 변수
	String selectWhere = "";
	
	// 검색 조건 개수가 몇개인지 확인
	int selectWhereCount = 0;
	int selectWhereCount2 = 0;	
	if(request.getParameter("selectCount") != null){
		selectWhereCount = Integer.parseInt(request.getParameter("selectCount"));
		selectWhereCount2 = selectWhereCount;		
		//System.out.println("검색 조건 개수 = " + selectWhereCount);
	}
	
	

	
	
	String selectEmpNo = "";
	String selectGender = "";
	String selectFirstName = "";
	String selectLastName = "";
	String selectBirthDateStart = "";
	String selectBirthDateEnd = "";
	String selectHireDateStart = "";
	String selectHireDateEnd = "";
	
	
	
	
	String sqlQuery = "SELECT emp_no, birth_date, first_name, last_name, gender, hire_date FROM employees_employees ";
	String sqlQuery2 = "SELECT COUNT(*) FROM employees_employees ";
	
	

	
	//검색 조건이 있을 경우
	if(selectWhereCount > 0){
		//System.out.println("selectWhereCount = " + selectWhereCount);
		sqlQuery += "WHERE ";
		sqlQuery2 += "WHERE ";
		
		if(request.getParameter("selectEmpNo") != null){
			selectEmpNo = request.getParameter("selectEmpNo");
			sqlQuery += "emp_no LIKE '%" + selectEmpNo + "%' ";
			sqlQuery2 += "emp_no LIKE '%" + selectEmpNo + "%' ";
			selectWhere += "selectEmpNo=" + selectEmpNo + "&";
			selectWhereCount = selectWhereCount - 1;
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
		
		if(request.getParameter("selectGender") != null){
			selectGender = request.getParameter("selectGender");
			sqlQuery += "gender = '" + selectGender + "' ";
			sqlQuery2 += "gender = '" + selectGender + "' ";
			selectWhere += "selectGender=" + selectGender + "&";
			selectWhereCount = selectWhereCount - 1;
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
		
		if(request.getParameter("selectFirstName") != null){
			selectFirstName = request.getParameter("selectFirstName");
			sqlQuery += "first_name LIKE '%" + selectFirstName + "%' ";
			sqlQuery2 += "first_name LIKE '%" + selectFirstName + "%' ";
			selectWhere += "selectFirstName=" + selectFirstName + "&";
			selectWhereCount = selectWhereCount - 1;
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
		
		if(request.getParameter("selectLastName") != null){
			selectLastName = request.getParameter("selectLastName");
			sqlQuery += "last_name LIKE '%" + selectLastName + "%' ";
			sqlQuery2 += "last_name LIKE '%" + selectLastName + "%' ";
			selectWhere += "selectLastName=" + selectLastName + "&";
			selectWhereCount = selectWhereCount - 1;
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}	
		
		
		
		if(request.getParameter("selectBirthDateStart") != null){
			selectBirthDateStart = request.getParameter("selectBirthDateStart");
			sqlQuery += "(birth_date BETWEEN '" + selectBirthDateStart + "' ";
			sqlQuery2 += "(birth_date BETWEEN '" + selectBirthDateStart + "' ";	
			selectWhere += "selectBirthDateStart=" + selectBirthDateStart + "&";
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
		
		if(request.getParameter("selectBirthDateEnd") != null){
			selectBirthDateEnd = request.getParameter("selectBirthDateEnd");
			sqlQuery += "'" + selectBirthDateEnd + "') ";
			sqlQuery2 += "'" + selectBirthDateEnd + "') ";
			selectWhere += "selectBirthDateEnd=" + selectBirthDateEnd + "&";
			selectWhereCount = selectWhereCount - 1;
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
		
		
		
		
		if(request.getParameter("selectHireDateStart") != null){
			selectHireDateStart = request.getParameter("selectHireDateStart");
			sqlQuery += "(hire_date BETWEEN '" + selectHireDateStart + "' ";
			sqlQuery2 += "(hire_date BETWEEN '" + selectHireDateStart + "' ";		
			selectWhere += "selectHireDateStart=" + selectHireDateStart + "&";
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
		
		if(request.getParameter("selectHireDateEnd") != null){
			selectHireDateEnd = request.getParameter("selectHireDateEnd");
			sqlQuery += "'" + selectHireDateEnd + "') ";
			sqlQuery2 += "'" + selectHireDateEnd + "') ";
			selectWhere += "selectHireDateEnd=" + selectHireDateEnd + "&";
			selectWhereCount = selectWhereCount - 1;
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
	}
	
	
	
	
	
	
	sqlQuery +=  "order by emp_no limit ?, ?;";	
	//System.out.println(sqlQuery);
	
	
	//stmt1 = conn.prepareStatement("SELECT emp_no, birth_date, first_name, last_name, gender, hire_date FROM employees order by emp_no limit ?, ?;");
	stmt1 = conn.prepareStatement(sqlQuery);
	stmt1.setInt(1, beginRow);
	stmt1.setInt(2, rowPerPage);
	rs1 = stmt1.executeQuery();

	
	//data read
	while(rs1.next()){
		Employees e = new Employees();
		e.empNo = rs1.getInt("emp_no");
		e.birthDate = rs1.getString("birth_date");
		e.firstName = rs1.getString("first_name");
		e.lastName = rs1.getString("last_name");
		e.gender = rs1.getString("gender");
		e.hirdDate = rs1.getString("hire_date");		
		
		list.add(e);
	}
	
	
	
	
	
	
	
	
	int totalRow = 0;		//전체 데이터 수
	int lastPage = 0;		//마지막 페이지 번호
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	//stmt2 = conn.prepareStatement("SELECT COUNT(*) FROM employees;");
	stmt2 = conn.prepareStatement(sqlQuery2);
	rs2 = stmt2.executeQuery();
	
	if(rs2.next()){
		totalRow = rs2.getInt("COUNT(*)");
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
			
				<h1>employeesList</h1>
				
				
				<!-- 검색하기 창 -->
				<button type="button" class="btn btn-outline-info btn-sm" data-toggle="collapse" data-target="#demo">검색하기</button>
	  				<div id="demo" class="collapse">
	    				<!-- 하단 검색 창 -->
	
						<form method="post" action="<%=request.getContextPath()%>/employees/searchEmployeesAction.jsp">						
							<div class="row">		
								<table class="table table-borderless" style="margin-top: 10px">
									<tbody>
										<tr>
											<td style="width: 15%">																								
												<div class="custom-control custom-checkbox">
													<input type="checkbox" id="employeesCheckBoxEmpNo" class="custom-control-input" name="employeesCheckBoxEmpNo" value="empNo">	
													<label class="custom-control-label" for="employeesCheckBoxEmpNo">emp_no</label>
												</div>
											</td>
											
											<td>												
												<input type="text" name="employeesTextEmpNo">
											</td>
											
											<td style="width: 15%">																								
												<div class="custom-control custom-checkbox">
													<input type="checkbox" id="employeesCheckBoxGender" class="custom-control-input" name="employeesCheckBoxGender" value="gender">	
													<label class="custom-control-label" for="employeesCheckBoxGender">gender</label>
												</div>
											</td>
											
											<td>
												<div class="custom-control custom-radio custom-control-inline">
    												<input type="radio" class="custom-control-input" id="customRadio" name="employeesRadioGender" value="M">
    												<label class="custom-control-label" for="customRadio">Male</label>
  												</div>
  												<div class="custom-control custom-radio custom-control-inline">
    												<input type="radio" class="custom-control-input" id="customRadio2" name="employeesRadioGender" value="F">
    												<label class="custom-control-label" for="customRadio2">Female</label>
  												</div>
											</td>
											
																				
											<td>
												<!--  -->
											</td>
										</tr>
									
										
										
										<tr>
											<td style="width: 15%">
												<div class="custom-control custom-checkbox">
													<input type="checkbox" id="employeesCheckBoxFirstName" class="custom-control-input" name="employeesCheckBoxFirstName" value="firstName">	
													<label class="custom-control-label" for="employeesCheckBoxFirstName">first_name</label>
												</div>
											</td>
											
											<td>												
												<input type="text" name="employeesTextFirstName">
											</td>
											
											<td style="width: 15%">																								
												<div class="custom-control custom-checkbox">
													<input type="checkbox" id="employeesCheckBoxLastName" class="custom-control-input" name="employeesCheckBoxLastName" value="lastName">	
													<label class="custom-control-label" for="employeesCheckBoxLastName">last_name</label>
												</div>
											</td>
											
											<td>
												<input type="text" name="employeesTextLastName">
											</td>
											
																				
											<td>
												<!--  -->
											</td>
										</tr>
										
										<tr>
											<td style="width: 15%">																								
												<div class="custom-control custom-checkbox">
													<input type="checkbox" id="employeesCheckBoxBirthDate" class="custom-control-input" name="employeesCheckBoxBirthDate" value="birthDate">	
													<label class="custom-control-label" for="employeesCheckBoxBirthDate">birth_date</label>
												</div>
											</td>
											
											<td colspan="3">
												<input type="text" name="deptEmpTextBrithDateStart">												
												&nbsp; ~ &nbsp;												
												<input type="text" name="deptEmpTextBrithDateEnd">
											    &nbsp; (예 : 1998 ~ 2011)
											   
											</td>		
											
											<td>
											
											</td>									
											
										</tr>
										
										<tr>
											<td style="width: 15%">																								
												<div class="custom-control custom-checkbox">
													<input type="checkbox" id="employeesCheckBoxHireDate" class="custom-control-input" name="employeesCheckBoxHireDate" value="hireDate">	
													<label class="custom-control-label" for="employeesCheckBoxHireDate">hire_date</label>
												</div>
											</td>
											
											<td colspan="3">
												<input type="text" name="deptEmpTextHireDateStart">												
												&nbsp; ~ &nbsp;												
												<input type="text" name="deptEmpTextHireDateEnd">
											    &nbsp; (예 : 1998 ~ 2011)
											   
											</td>		
											
											<td>
												<button type="submit" class="btn btn-outline-info btn-sm">검색하기</button>
											</td>									
											
										</tr>
										
										
										
										
									
									</tbody>								
								</table>								
										
								
							</div>
						
						</form>
		
					
  					</div>
				
				
				
				
				
				<div class="row">
					<div class="col-xl-1">						
					</div>
					<div class="col-xl-10">
					</div>
					<div class="col-xl-1">
						<ul class="nav nav-tabs">
						
							<li class="dropdown"><a class="dropdown-toggle"
								data-toggle="dropdown" href="#"><%=rowPerPage %>개씩<span class="caret"></span></a>
								<ul class="dropdown-menu">
										<%
											//if(request.getParameter("sel1") != null && request.getParameter("sel2") != null){
											if(selectWhereCount2 > 0){
		
										%>
								
												<li><a href="<%=request.getContextPath()%>/employees/employeesList.jsp?userDisplay=5&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">5개씩</a></li>
				      							<li><a href="<%=request.getContextPath()%>/employees/employeesList.jsp?userDisplay=10&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">10개씩</a></li>
				      							<li><a href="<%=request.getContextPath()%>/employees/employeesList.jsp?userDisplay=15&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">15개씩</a></li>
				      							<li><a href="<%=request.getContextPath()%>/employees/employeesList.jsp?userDisplay=20&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">20개씩</a></li>
	      							
	      								<%
											}else{
	      								
	      								%>
	      										<li><a href="<%=request.getContextPath()%>/employees/employeesList.jsp?userDisplay=5">5개씩</a></li>
				      							<li><a href="<%=request.getContextPath()%>/employees/employeesList.jsp?userDisplay=10">10개씩</a></li>
				      							<li><a href="<%=request.getContextPath()%>/employees/employeesList.jsp?userDisplay=15">15개씩</a></li>
				      							<li><a href="<%=request.getContextPath()%>/employees/employeesList.jsp?userDisplay=20">20개씩</a></li>
	      								
	      								<%
											}
	      								%>
								</ul></li>						
						</ul>
					</div>
				</div>
				
				
				
				
				

				<table class="table table-striped table-hover">
					<thead class="table-info">
						<tr>
							<th>emp_no</th>
							<th>birth_date</th>
							<th>first_name</th>
							<th>last_name</th>
							<th>gender</th>
							<th>hire_date</th>
						</tr>
					</thead>
					<tbody>
						<%
							for (Employees e : list) {
						%>
						<tr>
							<td><%=e.empNo%></td>
							<td><%=e.birthDate%></td>
							<td><%=e.firstName%></td>
							<td><%=e.lastName%></td>
							<td><%=e.gender%></td>
							<td><%=e.hirdDate%></td>
						</tr>
						<%
							}
						%>
					</tbody>

				</table>
			</div>
			<div class="col-xl-3"></div>
		</div>
		
		<!-- 하단 페이지 넘버 -->


		<%
			//if(request.getParameter("sel1") != null && request.getParameter("sel2") != null){
			if(totalRow > 0){
				if(selectWhereCount2 > 0){
		
		%>





		<div class="row m-3">
			<div class="col-xl-3"></div>
			<div class="col-xl-6">

				<!-- 1페이지로 이동 -->
				<ul class="pagination" style="justify-content: center;">
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=1&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">첫번째</a>
					</li>







					<!-- 이전 페이지(이전 10페이지(마지막 페이지 출력) - 현재 페이지 1~10일 경우 1페이지 출력) -->
					<%
						if (currentPage > pagePerGroup) {
							int e = ((currentPage - pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
							if (currentPage % pagePerGroup == 0) {
					%>
					
					
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=currentPage - pagePerGroup%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">이전</a>
					</li>
					<%
						} else {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=e + pagePerGroup - 1%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">이전</a>
					</li>
					<%
						}

						} else {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=1&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">이전</a>
					</li>
					<%
						}
					%>


					<!-- 현재 페이지 번호 -->
					<%
						// 전체 몇 페이지가 필요한 지 체크
						// 10의 배수가 아닐 경우 +1 ex) 19개 데이터 => 19 / 10 = 몫:1 -> 2페이지 필요
						if ((totalRow % rowPerPage) == 0) {
							lastPage = totalRow / rowPerPage;
						} else {
							lastPage = (totalRow / rowPerPage) + 1;
						}

						//1~10page 그룹 시작페이지
						int groupStartPage = 0; // 0=1~10페이지		1=11~20페이지

						//하단 1~10 페이지 출력
						//페이지 그룹으로 총 10 * x개의 그룹 확인
						//10의 배수일 경우  - 1
						if (currentPage % pagePerGroup == 0) {
							groupStartPage = currentPage / pagePerGroup - 1;
							//System.out.println(groupStartPage);
							for (int i = (groupStartPage * pagePerGroup) + 1; i <= (groupStartPage * pagePerGroup) + pagePerGroup; i = i + 1) {
								//현재페이지 색 다르게
								if(i == currentPage){
					%>
									<li class="page-item"><a class="btn btn-secondary"
									href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>"><%=i%></a>
									</li>
					<%				
								}else{
					%>
									<li class="page-item"><a class="btn btn-info"
									href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>"><%=i%></a>
									</li>
					<%
								}
							}
						} else {
							groupStartPage = currentPage / pagePerGroup;
							//System.out.println(groupStartPage);
							if (lastPage < (groupStartPage * pagePerGroup) + pagePerGroup) {
								for (int i = (groupStartPage * pagePerGroup) + 1; i <= lastPage; i = i + 1) {
									//현재 페이지 색 다르게
									if(i == currentPage){
					%>
										<li class="page-item"><a class="btn btn-secondary"
										href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>"><%=i%></a>
										</li>
					<%					
									}else{
					%>
										<li class="page-item"><a class="btn btn-info"
										href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>"><%=i%></a>
										</li>
					<%
									}
								}
							} else {
								for (int i = (groupStartPage * pagePerGroup) + 1; i <= (groupStartPage * pagePerGroup) + pagePerGroup; i = i + 1) {
									//현재 페이지 색 다르게
									if(i == currentPage){
					%>
										<li class="page-item"><a class="btn btn-secondary"
										href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>"><%=i%></a>
										</li>
					<%					
									}else{
					%>
										<li class="page-item"><a class="btn btn-info"
										href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>"><%=i%></a>
										</li>
					<%
									}
								}
							}
						}
					%>


					<!-- 다음 페이지(다음 10페이지(다음 10개중 첫번째 출력) - 마지막 10개중 한 페이지일 경우 마지막 페이지 출력) -->
					<%
						if ((currentPage / pagePerGroup) == (lastPage / pagePerGroup)) {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=lastPage%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">다음</a>
					</li>
					<%
						} else {
							if ((currentPage % pagePerGroup) == 0) {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=currentPage + 1%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">다음</a>
					</li>
					<%
						} else {
								int e = ((currentPage + pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=e%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">다음</a>
					</li>
					<%
						}
						}
					%>


					<!-- 마지막 페이지로 이동 -->
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=lastPage%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">마지막</a>
					</li>


				</ul>
			</div>
			<div class="col-xl-3"></div>
		</div>
		
		
		
		
		
		<%
			}else{
				
			
		
		%>
			<div class="row m-3">
			<div class="col-xl-3"></div>
			<div class="col-xl-6">

				<!-- 1페이지로 이동 -->
				<ul class="pagination" style="justify-content: center;">
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=1&&userDisplay=<%=rowPerPage%>">첫번째</a>
					</li>







					<!-- 이전 페이지(이전 10페이지(마지막 페이지 출력) - 현재 페이지 1~10일 경우 1페이지 출력) -->
					<%
						if (currentPage > pagePerGroup) {
							int e = ((currentPage - pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
							if (currentPage % pagePerGroup == 0) {
					%>
					
					
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=currentPage - pagePerGroup%>&&userDisplay=<%=rowPerPage%>">이전</a>
					</li>
					<%
						} else {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=e + pagePerGroup - 1%>&&userDisplay=<%=rowPerPage%>">이전</a>
					</li>
					<%
						}

						} else {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=1&&userDisplay=<%=rowPerPage%>">이전</a>
					</li>
					<%
						}
					%>


					<!-- 현재 페이지 번호 -->
					<%
						// 전체 몇 페이지가 필요한 지 체크
						// 10의 배수가 아닐 경우 +1 ex) 19개 데이터 => 19 / 10 = 몫:1 -> 2페이지 필요
						if ((totalRow % rowPerPage) == 0) {
							lastPage = totalRow / rowPerPage;
						} else {
							lastPage = (totalRow / rowPerPage) + 1;
						}

						//1~10page 그룹 시작페이지
						int groupStartPage = 0; // 0=1~10페이지		1=11~20페이지

						//하단 1~10 페이지 출력
						//페이지 그룹으로 총 10 * x개의 그룹 확인
						//10의 배수일 경우  - 1
						if (currentPage % pagePerGroup == 0) {
							groupStartPage = currentPage / pagePerGroup - 1;
							//System.out.println(groupStartPage);
							for (int i = (groupStartPage * pagePerGroup) + 1; i <= (groupStartPage * pagePerGroup) + pagePerGroup; i = i + 1) {
								//현재페이지 색 다르게
								if(i == currentPage){
					%>
									<li class="page-item"><a class="btn btn-secondary"
									href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
									</li>
					<%				
								}else{
					%>
									<li class="page-item"><a class="btn btn-info"
									href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
									</li>
					<%
								}
							}
						} else {
							groupStartPage = currentPage / pagePerGroup;
							//System.out.println(groupStartPage);
							if (lastPage < (groupStartPage * pagePerGroup) + pagePerGroup) {
								for (int i = (groupStartPage * pagePerGroup) + 1; i <= lastPage; i = i + 1) {
									//현재 페이지 색 다르게
									if(i == currentPage){
					%>
										<li class="page-item"><a class="btn btn-secondary"
										href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
										</li>
					<%					
									}else{
					%>
										<li class="page-item"><a class="btn btn-info"
										href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
										</li>
					<%
									}
								}
							} else {
								for (int i = (groupStartPage * pagePerGroup) + 1; i <= (groupStartPage * pagePerGroup) + pagePerGroup; i = i + 1) {
									//현재 페이지 색 다르게
									if(i == currentPage){
					%>
										<li class="page-item"><a class="btn btn-secondary"
										href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
										</li>
					<%					
									}else{
					%>
										<li class="page-item"><a class="btn btn-info"
										href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
										</li>
					<%
									}
								}
							}
						}
					%>


					<!-- 다음 페이지(다음 10페이지(다음 10개중 첫번째 출력) - 마지막 10개중 한 페이지일 경우 마지막 페이지 출력) -->
					<%
						if ((currentPage / pagePerGroup) == (lastPage / pagePerGroup)) {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=lastPage%>&&userDisplay=<%=rowPerPage%>">다음</a>
					</li>
					<%
						} else {
							if ((currentPage % pagePerGroup) == 0) {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=currentPage + 1%>&&userDisplay=<%=rowPerPage%>">다음</a>
					</li>
					<%
						} else {
								int e = ((currentPage + pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=e%>&&userDisplay=<%=rowPerPage%>">다음</a>
					</li>
					<%
						}
						}
					%>


					<!-- 마지막 페이지로 이동 -->
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/employees/employeesList.jsp?currentPage=<%=lastPage%>&&userDisplay=<%=rowPerPage%>">마지막</a>
					</li>


				</ul>
			</div>
			<div class="col-xl-3"></div>
		</div>
		
		<%
				}
			}
		%>
		
		
		
	
	</div>
</body>
</html>