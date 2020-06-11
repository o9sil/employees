<%@page import="gd.emp.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>



<title>empDataList</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	// 1. 페이지 값 읽기(넘어올 경우 있고 안넘어올 경우 있음)
	int currentPage = 1;	//현재 페이지
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}	
	
	int rowPerPage = 10;	// 한 페이지에 몇개씩 보여줄 지
	
	if(request.getParameter("userDisplay") != null){
		rowPerPage = Integer.parseInt(request.getParameter("userDisplay"));
	}
	
	
	int beginRow = (currentPage-1) * rowPerPage;	//1page = 0~9	2page=10~19	
	
	
	int pagePerGroup = 10;	// 하단 페이지 목록 수
	
	
	
	
	
	
	// 2.0 database
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");
	
	// 2.1 현재페이지의 departments 테이블 행들 가져오기
	ArrayList<EmpData> list = new ArrayList<EmpData>();
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
	
	// 조건 검색 변수 선언
	String selectEmpNo = "";
	String selectFirstName = "";
	String selectLastName = "";
	String selectGender = "";
	String selectDeptName = "";
	String selectFromDateStart = "";
	String selectFromDateEnd = "";
	String selectToDateStart = "";
	String selectToDateEnd = "";	
	
	
	String sqlQuery = "SELECT ep.emp_no, ep.first_name, ep.last_name, ep.gender, dp.dept_name, de.from_date, de.to_date FROM employees_dept_emp de inner join employees_employees ep ON ep.emp_no = de.emp_no INNER JOIN employees_departments dp ON de.dept_no = dp.dept_no ";
	String sqlQuery2 = "SELECT COUNT(*) FROM employees_dept_emp de inner join employees_employees ep ON ep.emp_no = de.emp_no INNER JOIN employees_departments dp ON de.dept_no = dp.dept_no ";
	

	//검색 조건이 있을 경우
	if(selectWhereCount > 0){
		//System.out.println("selectWhereCount = " + selectWhereCount);
		sqlQuery += "WHERE ";
		sqlQuery2 += "WHERE ";
		
		if(request.getParameter("selectEmpNo") != null){
			selectEmpNo = request.getParameter("selectEmpNo");
			sqlQuery += "ep.emp_no LIKE '%" + selectEmpNo + "%' ";
			sqlQuery2 += "ep.emp_no LIKE '%" + selectEmpNo + "%' ";
			selectWhere += "selectEmpNo=" + selectEmpNo + "&";
			selectWhereCount = selectWhereCount - 1;
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
		
		if(request.getParameter("selectFirstName") != null){
			selectFirstName = request.getParameter("selectFirstName");
			sqlQuery += "ep.first_name LIKE '%" + selectFirstName + "%' ";
			sqlQuery2 += "ep.first_name LIKE '%" + selectFirstName + "%' ";
			selectWhere += "selectFirstName=" + selectFirstName + "&";
			selectWhereCount = selectWhereCount - 1;
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
		
		if(request.getParameter("selectLastName") != null){
			selectLastName = request.getParameter("selectLastName");
			sqlQuery += "ep.last_name LIKE '%" + selectLastName + "%' ";
			sqlQuery2 += "ep.last_name LIKE '%" + selectLastName + "%' ";
			selectWhere += "selectLastName=" + selectLastName + "&";
			selectWhereCount = selectWhereCount - 1;
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
		
		if(request.getParameter("selectGender") != null){
			selectGender = request.getParameter("selectGender");
			sqlQuery += "ep.gender = '" + selectGender + "' ";
			sqlQuery2 += "ep.gender = '" + selectGender + "' ";
			selectWhere += "selectGender=" + selectGender + "&";
			selectWhereCount = selectWhereCount - 1;
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
		
		if(request.getParameter("selectDeptName") != null){
			selectDeptName = request.getParameter("selectDeptName");
			sqlQuery += "dp.dept_name LIKE '%" + selectDeptName + "%' ";
			sqlQuery2 += "dp.dept_name LIKE '%" + selectDeptName + "%' ";
			selectWhere += "selectDeptName=" + selectDeptName + "&";
			selectWhereCount = selectWhereCount - 1;
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
		
		if(request.getParameter("selectFromDateStart") != null){
			selectFromDateStart = request.getParameter("selectFromDateStart");
			sqlQuery += "(de.from_date BETWEEN '" + selectFromDateStart + "' ";
			sqlQuery2 += "(de.from_date BETWEEN '" + selectFromDateStart + "' ";	
			selectWhere += "selectFromDateStart=" + selectFromDateStart + "&";
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
		
		if(request.getParameter("selectFromDateEnd") != null){
			selectFromDateEnd = request.getParameter("selectFromDateEnd");
			sqlQuery += "'" + selectFromDateEnd + "') ";
			sqlQuery2 += "'" + selectFromDateEnd + "') ";	
			selectWhere += "selectFromDateEnd=" + selectFromDateEnd + "&";
			selectWhereCount = selectWhereCount - 1;
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
		
		if(request.getParameter("selectToDateStart") != null){
			selectToDateStart = request.getParameter("selectToDateStart");
			sqlQuery += "(de.to_date BETWEEN '" + selectToDateStart + "' ";
			sqlQuery2 += "(de.to_date BETWEEN '" + selectToDateStart + "' ";
			selectWhere += "selectToDateStart=" + selectToDateStart + "&";
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
		
		if(request.getParameter("selectToDateEnd") != null){
			selectToDateEnd = request.getParameter("selectToDateEnd");
			sqlQuery += "'" + selectToDateEnd + "') ";
			sqlQuery2 += "'" + selectToDateEnd + "') ";
			selectWhere += "selectToDateEnd=" + selectToDateEnd + "&";
			selectWhereCount = selectWhereCount - 1;
			
			if(selectWhereCount > 0){
				sqlQuery += "AND ";
				sqlQuery2 += "AND ";
			}
		}
	}
	
	sqlQuery +=  "order by ep.emp_no limit ?, ?;";	
	//System.out.println(sqlQuery);
	
	stmt1 = conn.prepareStatement(sqlQuery);
	stmt1.setInt(1, beginRow);
	stmt1.setInt(2, rowPerPage);
	rs1 = stmt1.executeQuery();

	
	//data read
	while(rs1.next()){
		EmpData e = new EmpData();
		e.empNo = rs1.getInt("ep.emp_no");
		e.firstName = rs1.getString("ep.first_name");
		e.lastName = rs1.getString("ep.last_name");
		e.gender = rs1.getString("ep.gender");
		e.deptName = rs1.getString("dp.dept_name");
		e.fromDate = rs1.getString("de.from_date");
		e.toDate = rs1.getString("de.to_date");
						
		
		list.add(e);
	}
	
	
	
	
	
	
	
	
	
	int totalRow = 0;		//전체 데이터 수
	int lastPage = 0;		//마지막 페이지 번호
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;	
	stmt2 = conn.prepareStatement(sqlQuery2);
	rs2 = stmt2.executeQuery();
	
	if(rs2.next()){
		totalRow = rs2.getInt("COUNT(*)");
	}
	
	
%>


<div class="container-fluid">
<!-- Navigation MainMenu -->
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>		
	</div>
	
	<!-- 리스트 목록 -->
		<div class="row m-5">
			<div class="col-xl-3"></div>
			<div class="col-xl-6">
				<h1>empDataList</h1>
				
				<!-- 검색하기 창 -->
				<button type="button" class="btn btn-outline-info btn-sm" data-toggle="collapse" data-target="#demo">검색하기</button>
	  				<div id="demo" class="collapse">
	    				<!-- 하단 검색 창 -->
	
						<form method="post" action="<%=request.getContextPath()%>/empData/searchEmpDataAction.jsp">						
							<div class="row">		
								<table class="table table-borderless" style="margin-top: 10px">
									<tbody>
										<tr>
											<td style="width: 15%">																								
												<div class="custom-control custom-checkbox">
													<input type="checkbox" id="empDataCheckBoxEmpNo" class="custom-control-input" name="empDataCheckBoxEmpNo" value="empNo">	
													<label class="custom-control-label" for="empDataCheckBoxEmpNo">dept_no</label>
												</div>
											</td>
											
											<td>												
												<input type="text" name="empDataTextEmpNo">
											</td>
											
											<td style="width: 15%">
												<div class="custom-control custom-checkbox">
													<input type="checkbox" id="empDataCheckBoxGender" class="custom-control-input" name="empDataCheckBoxGender" value="gender">	
													<label class="custom-control-label" for="empDataCheckBoxGender">gender</label>
												</div>																								
												
											</td>
											
											<td>
												<div class="custom-control custom-radio custom-control-inline">
    												<input type="radio" class="custom-control-input" id="customRadio" name="empDataRadioGender" value="M">
    												<label class="custom-control-label" for="customRadio">Male</label>
  												</div>
  												<div class="custom-control custom-radio custom-control-inline">
    												<input type="radio" class="custom-control-input" id="customRadio2" name="empDataRadioGender" value="F">
    												<label class="custom-control-label" for="customRadio2">Female</label>
  												</div>
											</td>
											
																				
											<td>
												
											</td>
										</tr>
										
										<tr>
											<td style="width: 15%">																								
												<div class="custom-control custom-checkbox">
													<input type="checkbox" id="empDataCheckBoxFirstName" class="custom-control-input" name="empDataCheckBoxFirstName" value="firstName">	
													<label class="custom-control-label" for="empDataCheckBoxFirstName">first_name</label>
												</div>
											</td>
											
											<td>												
												<input type="text" name="empDataTextFirstName">
											</td>
											
											<td style="width: 15%">
													<div class="custom-control custom-checkbox">
													<input type="checkbox" id="empDataCheckBoxLastName" class="custom-control-input" name="empDataCheckBoxLastName" value="lastName">	
													<label class="custom-control-label" for="empDataCheckBoxLastName">last_name</label>
												</div>			
											</td>
											
											<td>												
												<input type="text" name="empDataTextLastName">
											</td>
											
																				
											<td>
												
											</td>
										</tr>
										
										<tr>
											<td style="width: 15%">																								
												<div class="custom-control custom-checkbox">
													<input type="checkbox" id="empDataCheckBoxDeptName" class="custom-control-input" name="empDataCheckBoxDeptName" value="deptName">	
													<label class="custom-control-label" for="empDataCheckBoxDeptName">dept_name</label>
												</div>
											</td>
											
											<td>												
												<input type="text" name="empDataTextDeptName">
											</td>
											
											<td style="width: 15%">
														
											</td>
											
											<td>												
												
											</td>
											
																				
											<td>
												
											</td>
										</tr>
										
										<tr>
											<td style="width: 15%">																								
												<div class="custom-control custom-checkbox">
													<input type="checkbox" id="empDataCheckBoxFromDate" class="custom-control-input" name="empDataCheckBoxFromDate" value="fromDate">	
													<label class="custom-control-label" for="empDataCheckBoxFromDate">from_date</label>
												</div>
											</td>
											
											<td colspan="3">
												<input type="text" name="empDataTextFromDateStart">												
												&nbsp; ~ &nbsp;												
												<input type="text" name="empDataTextFromDateEnd">
											    &nbsp; (예 : 1998 ~ 2011)
											   
											</td>		
											
											<td>
											
											</td>									
											
										</tr>
										
										<tr>
											<td style="width: 15%">																								
												<div class="custom-control custom-checkbox">
													<input type="checkbox" id="empDataCheckBoxToDate" class="custom-control-input" name="empDataCheckBoxToDate" value="toDate">	
													<label class="custom-control-label" for="empDataCheckBoxToDate">to_date</label>
												</div>
											</td>
											
											<td colspan="3">
												<input type="text" name="empDataTextToDateStart">												
												&nbsp; ~ &nbsp;												
												<input type="text" name="empDataTextToDateEnd">
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
				
				
				<!-- ------------------------------------------------------------------------------------------ -->
				
				
				
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
										<li><a href="<%=request.getContextPath()%>/empData/empDataList.jsp?userDisplay=5&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">5개씩</a></li>
		      							<li><a href="<%=request.getContextPath()%>/empData/empDataList.jsp?userDisplay=10&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">10개씩</a></li>
		      							<li><a href="<%=request.getContextPath()%>/empData/empDataList.jsp?userDisplay=15&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">15개씩</a></li>
		      							<li><a href="<%=request.getContextPath()%>/empData/empDataList.jsp?userDisplay=20&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">20개씩</a></li>
	      							<%
										}else{
	      							%>
		      							<li><a href="<%=request.getContextPath()%>/empData/empDataList.jsp?userDisplay=5">5개씩</a></li>
		      							<li><a href="<%=request.getContextPath()%>/empData/empDataList.jsp?userDisplay=10">10개씩</a></li>
		      							<li><a href="<%=request.getContextPath()%>/empData/empDataList.jsp?userDisplay=15">15개씩</a></li>
		      							<li><a href="<%=request.getContextPath()%>/empData/empDataList.jsp?userDisplay=20">20개씩</a></li>
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
							<th>first_name</th>
							<th>last_name</th>
							<th>gender</th>
							<th>dept_name</th>
							<th>from_date</th>
							<th>to_date</th>
						</tr>
					</thead>
					<tbody>
						<%
							for (EmpData e : list) {
						%>
						<tr>
							<td><%=e.empNo%></td>
							<td><%=e.firstName%></td>
							<td><%=e.lastName%></td>
							<td><%=e.gender%></td>
							<td><%=e.deptName%></td>
							<td><%=e.fromDate%></td>
							<td><%=e.toDate%></td>							
						</tr>
						<%
							}
						%>
					</tbody>

				</table>
			</div>
			<div class="col-xl-3"></div>
		</div>


		<%
			//if(request.getParameter("sel1") != null && request.getParameter("sel2") != null){
			if(totalRow > 0){
				if(selectWhereCount2 > 0){
				
		%>




		<!-- 하단 페이지 넘버 -->
		<div class="row m-3">
			<div class="col-xl-3"></div>
			<div class="col-xl-6">

				<!-- 1페이지로 이동 -->
				<ul class="pagination" style="justify-content: center;">
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=1&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">첫번째</a>
					</li>







					<!-- 이전 페이지(이전 10페이지(마지막 페이지 출력) - 현재 페이지 1~10일 경우 1페이지 출력) -->
					<%
						if (currentPage > pagePerGroup) {
							int e = ((currentPage - pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
							if (currentPage % pagePerGroup == 0) {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=currentPage - pagePerGroup%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">이전</a>
					</li>
					<%
						} else {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=e + pagePerGroup - 1%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">이전</a>
					</li>
					<%
						}

						} else {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=1&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">이전</a>
					</li>
					<%
						}
					%>




					<!-- 1~10 페이지 번호 -->
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
								//현재 페이지 색 다르게
								if(i == currentPage){
					%>
									<li class="page-item"><a class="btn btn-secondary"
									href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>"><%=i%></a>
									</li>
					<%				
								}else{
					%>
									<li class="page-item"><a class="btn btn-info"
									href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>"><%=i%></a>
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
										href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>"><%=i%></a>
										</li>
					<%					
									}else{
					%>
										<li class="page-item"><a class="btn btn-info"
										href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>"><%=i%></a>
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
										href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>"><%=i%></a>
										</li>
					<%					
									}else{
					%>
										<li class="page-item"><a class="btn btn-info"
										href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>"><%=i%></a>
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
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=lastPage%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">다음</a>
					</li>
					<%
						} else {
							if ((currentPage % pagePerGroup) == 0) {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=currentPage + 1%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">다음</a>
					</li>
					<%
						} else {
								int e = ((currentPage + pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=e%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">다음</a>
					</li>
					<%
						}
						}
					%>


					<!-- 마지막 페이지로 이동 -->
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=lastPage%>&&userDisplay=<%=rowPerPage%>&selectCount=<%=selectWhereCount2%>&<%=selectWhere%>">마지막</a>
					</li>


				</ul>
			</div>
			<div class="col-xl-3"></div>
		</div>
		
		<%
			}else{
		%>
			<!-- 하단 페이지 넘버 -->
			<div class="row m-3">
			<div class="col-xl-3"></div>
			<div class="col-xl-6">

				<!-- 1페이지로 이동 -->
				<ul class="pagination" style="justify-content: center;">
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=1&&userDisplay=<%=rowPerPage%>">첫번째</a>
					</li>







					<!-- 이전 페이지(이전 10페이지(마지막 페이지 출력) - 현재 페이지 1~10일 경우 1페이지 출력) -->
					<%
						if (currentPage > pagePerGroup) {
							int e = ((currentPage - pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
							if (currentPage % pagePerGroup == 0) {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=currentPage - pagePerGroup%>&&userDisplay=<%=rowPerPage%>">이전</a>
					</li>
					<%
						} else {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=e + pagePerGroup - 1%>&&userDisplay=<%=rowPerPage%>">이전</a>
					</li>
					<%
						}

						} else {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=1&&userDisplay=<%=rowPerPage%>">이전</a>
					</li>
					<%
						}
					%>




					<!-- 1~10 페이지 번호 -->
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
								//현재 페이지 색 다르게
								if(i == currentPage){
					%>
									<li class="page-item"><a class="btn btn-secondary"
									href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
									</li>
					<%				
								}else{
					%>
									<li class="page-item"><a class="btn btn-info"
									href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
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
										href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
										</li>
					<%					
									}else{
					%>
										<li class="page-item"><a class="btn btn-info"
										href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
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
										href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
										</li>
					<%					
									}else{
					%>
										<li class="page-item"><a class="btn btn-info"
										href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
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
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=lastPage%>&&userDisplay=<%=rowPerPage%>">다음</a>
					</li>
					<%
						} else {
							if ((currentPage % pagePerGroup) == 0) {
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=currentPage + 1%>&&userDisplay=<%=rowPerPage%>">다음</a>
					</li>
					<%
						} else {
								int e = ((currentPage + pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
					%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=e%>&&userDisplay=<%=rowPerPage%>">다음</a>
					</li>
					<%
						}
						}
					%>


					<!-- 마지막 페이지로 이동 -->
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath()%>/empData/empDataList.jsp?currentPage=<%=lastPage%>&&userDisplay=<%=rowPerPage%>">마지막</a>
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