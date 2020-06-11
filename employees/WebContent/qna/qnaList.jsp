<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@page import="gd.emp.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>qnaList</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>



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




	//2.0 database
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");
	
	// 2.1 현재페이지의 departments 테이블 행들 가져오기
	ArrayList<QnA> list = new ArrayList<QnA>();
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	
	
	
	// 조건 검색 변수 선언
	String sel1 = "";
	String sel2 = "";
	String sel3 = "";
	String sel4 = "";
	
	if(request.getParameter("sel1") != null){
		sel1 = request.getParameter("sel1");
		//System.out.println(sel1);
	}
	
	if(request.getParameter("sel2") != null){
		sel2 = request.getParameter("sel2");
		//System.out.println(sel2);
	}
	
	if(request.getParameter("sel3") != null){
		sel3 = request.getParameter("sel3");
		//System.out.println(sel2);
	}
	
	if(request.getParameter("sel4") != null){
		sel4 = request.getParameter("sel4");
		//System.out.println(sel2);
	}
	
	
	String sqlQuery = "SELECT qna_no, qna_title, qna_content, qna_user, qna_pw, qna_date, qna_ip FROM employees_qna ";
	String sqlQuery2 = "SELECT COUNT(*) FROM employees_qna ";
	
	
	if(request.getParameter("sel1") != null && request.getParameter("sel2") != null){		
		sqlQuery += "WHERE " + sel1 + " LIKE '%" + sel2 + "%' ";
		sqlQuery2 += "WHERE " + sel1 + " LIKE '%" + sel2 + "%' ";
		//System.out.println(sqlQuery);		
	}
	
	// 2개 검색시(제목 + 내용 검색)
	if(request.getParameter("sel3") != null && request.getParameter("sel4") != null){
		sqlQuery += "OR " + sel3 + " LIKE '%" + sel4 + "%' ";
		sqlQuery2 += "OR " + sel3 + " LIKE '%" + sel4 + "%' ";
	}
	
	sqlQuery +=  "order by qna_no desc limit ?, ?;";	
	//System.out.println(sqlQuery);
	
	
	
	
	//stmt1 = conn.prepareStatement("SELECT qna_no, qna_title, qna_content, qna_user, qna_pw, qna_date, qna_ip FROM qna order by qna_no desc limit ?, ?;");
	stmt1 = conn.prepareStatement(sqlQuery);
	stmt1.setInt(1, beginRow);
	stmt1.setInt(2, rowPerPage);
	
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
	
	
	
	
	// 3. departments 테이블 전채 행 개수 가져오기
	int totalRow = 0;	// DB에 존재하는 행 개수
	int lastPage = 0;	// 마지막 페이지
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	//stmt2 = conn.prepareStatement("SELECT COUNT(*) FROM qna;");
	stmt2 = conn.prepareStatement(sqlQuery2);
	rs2 = stmt2.executeQuery();
	
	if(rs2.next()){
		totalRow = rs2.getInt("COUNT(*)");
	}
	
	
	// 오늘 날짜 구하기
	String todayString = "";
	Calendar today = Calendar.getInstance();
	int year = today.get(Calendar.YEAR);
	int mon = today.get(Calendar.MONTH) + 1;
	int day = today.get(Calendar.DAY_OF_MONTH);
		
	
	//오늘 날짜 문자열 ex)2020-01-01 형식
	todayString = String.format("%04d", year) + "-" + String.format("%02d", mon) + "-" + String.format("%02d", day);
	
	//System.out.println("오늘 날짜 : " + todayString);
	
%>

<div class="container-fluid">
	
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
	
	<!-- 리스트 목록 -->
	<div class="row m-5">
		<div class="col-xl-3"></div>
		<div class="col-xl-6">
			<h1>qnaList</h1>
			
  
			<div class="row">
				<div class="col-xl-2">	
					<!-- 부서입력버튼 -->
					<div>
						<!-- <a href="<%=request.getContextPath()%>/qna/insertQnaForm.jsp">QnA 추가</a> -->
						<a href="<%=request.getContextPath()%>/qna/insertQnaLoginCheckAction.jsp">QnA 추가</a>
					</div>			
				</div>
				<div class="col-xl-9">
				</div>
				<div class="col-xl-1">
					<!-- 목록 몇개 출력할지 선택 -->
					<div>
						<ul class="nav nav-tabs">
					
						<li class="dropdown"><a class="dropdown-toggle"
							data-toggle="dropdown" href="#"><%=rowPerPage%>개씩<span class="caret"></span></a>
							<ul class="dropdown-menu">
							<%
								if(request.getParameter("sel1") != null && request.getParameter("sel2") != null){
									if(request.getParameter("sel3") != null && request.getParameter("sel4") != null){
							%>
										<li><a href="<%=request.getContextPath()%>/qna/qnaList.jsp?userDisplay=5&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>">5개씩</a></li>
	      								<li><a href="<%=request.getContextPath()%>/qna/qnaList.jsp?userDisplay=10&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>">10개씩</a></li>
	      								<li><a href="<%=request.getContextPath()%>/qna/qnaList.jsp?userDisplay=15&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>">15개씩</a></li>
	      								<li><a href="<%=request.getContextPath()%>/qna/qnaList.jsp?userDisplay=20&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>">20개씩</a></li>
							<%
									}else{
							%>
										<li><a href="<%=request.getContextPath()%>/qna/qnaList.jsp?userDisplay=5&&sel1=<%=sel1%>&&sel2=<%=sel2%>">5개씩</a></li>
	      								<li><a href="<%=request.getContextPath()%>/qna/qnaList.jsp?userDisplay=10&&sel1=<%=sel1%>&&sel2=<%=sel2%>">10개씩</a></li>
	      								<li><a href="<%=request.getContextPath()%>/qna/qnaList.jsp?userDisplay=15&&sel1=<%=sel1%>&&sel2=<%=sel2%>">15개씩</a></li>
	      								<li><a href="<%=request.getContextPath()%>/qna/qnaList.jsp?userDisplay=20&&sel1=<%=sel1%>&&sel2=<%=sel2%>">20개씩</a></li>
							<%										
									}
							%>
								
      						<%
								}else{
      						%>
      							<li><a href="<%=request.getContextPath()%>/qna/qnaList.jsp?userDisplay=5">5개씩</a></li>
      							<li><a href="<%=request.getContextPath()%>/qna/qnaList.jsp?userDisplay=10">10개씩</a></li>
      							<li><a href="<%=request.getContextPath()%>/qna/qnaList.jsp?userDisplay=15">15개씩</a></li>
      							<li><a href="<%=request.getContextPath()%>/qna/qnaList.jsp?userDisplay=20">20개씩</a></li>
      						<%
								}
      						%>
							</ul></li>						
						</ul>
					</div>
					
				</div>
			</div>
						

			
			
			<!-- 목록 출력 -->
			<table class="table table-striped table-hover">
					<thead class="table-info">											
						<tr style="text-align: center">
							<th style="width:10%">번호</th>
							<th style="width:70%">제목</th>
							<th style="width:20%">글쓴이</th>							
						</tr>
					</thead>
					<tbody>
						<%
							for (QnA q : list) {				
								String qnaDateSub = q.qnaDate.substring(0,10);
						%>
						<tr style="text-align: center">
							<td><%=q.qnaNo%></td>
							<td>
								<a href="<%=request.getContextPath()%>/qna/selectQna.jsp?qnaNo=<%=q.qnaNo %>"><%=q.qnaTitle%></a>
								<%
									if(qnaDateSub.equals(todayString)){
								%>
										<span class="badge badge-warning">new</span>
								<%
									}
								%>
							</td>
							<td><%=q.qnaUser %></td>				
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
		if(totalRow < 1){
			
		}else{
			
		
	
		if(request.getParameter("sel1") != null && request.getParameter("sel2") != null){
			
			if(request.getParameter("sel3") != null && request.getParameter("sel4") != null){
	%>
				<!-- 하단 페이지 넘버 -->


		<div class="row">
			<div class="col-xl-3"></div>
			<div class="col-xl-6">
				<!-- 1페이지로 이동 -->
				<ul class="pagination" style="justify-content: center;">
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=1&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>">첫번째</a>						
					</li>



					<!-- 이전 페이지(이전 10페이지(마지막 페이지 출력) - 현재 페이지 1~10일 경우 1페이지 출력) -->
					<%
				if(currentPage > pagePerGroup){
					int e = ((currentPage - pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
					if(currentPage%pagePerGroup == 0){
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=currentPage-pagePerGroup%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>">이전</a>
					</li>
					<%		
					}else{
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=e+pagePerGroup-1%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>">이전</a>
					</li>

					<%				
					}
			
				}else{
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=1&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>">이전</a>
					</li>
					<%
				}
			%>



					<%
				// 전체 몇 페이지가 필요한 지 체크
				// 10의 배수가 아닐 경우 +1 ex) 19개 데이터 => 19 / 10 = 몫:1 -> 2페이지 필요
				if((totalRow % rowPerPage) == 0){
					lastPage = totalRow / rowPerPage;
				}else{
					lastPage = (totalRow / rowPerPage) + 1;
				}
				
				//1~10page 그룹 시작페이지
				int groupStartPage = 0;	// 0=1~10페이지		1=11~20페이지
				
				//하단 1~10 페이지 출력
				//페이지 그룹으로 총 10 * x개의 그룹 확인
				//10의 배수일 경우  - 1
				if(currentPage % pagePerGroup == 0){
					groupStartPage = currentPage / pagePerGroup - 1;
					//System.out.println(groupStartPage);
					for(int i=(groupStartPage*pagePerGroup)+1; i<=(groupStartPage*pagePerGroup)+pagePerGroup; i=i+1){
						//현재 페이지 색 다르게
						if(i == currentPage){
			%>
							<li class="page-item"><a class="btn btn-secondary"
								href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>"><%=i%></a>
							</li>
			<%				
						}else{			
			%>
							<li class="page-item"><a class="btn btn-info"
								href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>"><%=i%></a>
							</li>
			<%
						}
					}
				}else{
					groupStartPage = currentPage / pagePerGroup;
					//System.out.println(groupStartPage);
					if(lastPage < (groupStartPage*pagePerGroup)+pagePerGroup){
						for(int i=(groupStartPage*pagePerGroup)+1; i<=lastPage; i=i+1){
							//현재 페이지 색 다르게							
							if(i == currentPage){
			%>
								<li class="page-item"><a class="btn btn-secondary"
									href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>"><%=i%></a>
								</li>
			<%									
							}else{
			%>
								<li class="page-item"><a class="btn btn-info"
									href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>"><%=i%></a>
								</li>
			<%				
							}
						}
					}else{
						for(int i=(groupStartPage*pagePerGroup)+1; i<=(groupStartPage*pagePerGroup)+pagePerGroup; i=i+1){
							//현재 페이지 색 다르게
							if(i == currentPage){
			%>
								<li class="page-item"><a class="btn btn-secondary"
								href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>"><%=i%></a>
								</li>
			<%
							}else{
			%>
								<li class="page-item"><a class="btn btn-info"
								href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>"><%=i%></a>
								</li>
			<%
							}	
						}
					}		
				}
			%>


					<!-- 다음 페이지(다음 10페이지(다음 10개중 첫번째 출력) - 마지막 10개중 한 페이지일 경우 마지막 페이지 출력) -->
					<%
				if((currentPage/pagePerGroup) == (lastPage/pagePerGroup)){
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=lastPage%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>">다음</a>
					</li>
					<%
				}else{
					if((currentPage%pagePerGroup)==0){
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=currentPage+1%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>">다음</a>
					</li>
					<%	
					}else{
						int e = ((currentPage + pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=e%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>">다음</a>
					</li>
					<%
					}
				}
			%>


					<!-- 마지막 페이지로 이동 -->
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=lastPage%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>&sel3=<%=sel3%>&sel4=<%=sel4%>">마지막</a>
					</li>



				</ul>

			</div>
			<div class="col-xl-3"></div>
		</div>
	
	
	
	
	<%
			}else{
	
	%>
	
	
	<!-- 하단 페이지 넘버 -->


		<div class="row">
			<div class="col-xl-3"></div>
			<div class="col-xl-6">
				<!-- 1페이지로 이동 -->
				<ul class="pagination" style="justify-content: center;">
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=1&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>">첫번째</a>						
					</li>



					<!-- 이전 페이지(이전 10페이지(마지막 페이지 출력) - 현재 페이지 1~10일 경우 1페이지 출력) -->
					<%
				if(currentPage > pagePerGroup){
					int e = ((currentPage - pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
					if(currentPage%pagePerGroup == 0){
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=currentPage-pagePerGroup%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>">이전</a>
					</li>
					<%		
					}else{
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=e+pagePerGroup-1%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>">이전</a>
					</li>

					<%				
					}
			
				}else{
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=1&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>">이전</a>
					</li>
					<%
				}
			%>



					<%
				// 전체 몇 페이지가 필요한 지 체크
				// 10의 배수가 아닐 경우 +1 ex) 19개 데이터 => 19 / 10 = 몫:1 -> 2페이지 필요
				if((totalRow % rowPerPage) == 0){
					lastPage = totalRow / rowPerPage;
				}else{
					lastPage = (totalRow / rowPerPage) + 1;
				}
				
				//1~10page 그룹 시작페이지
				int groupStartPage = 0;	// 0=1~10페이지		1=11~20페이지
				
				//하단 1~10 페이지 출력
				//페이지 그룹으로 총 10 * x개의 그룹 확인
				//10의 배수일 경우  - 1
				if(currentPage % pagePerGroup == 0){
					groupStartPage = currentPage / pagePerGroup - 1;
					//System.out.println(groupStartPage);
					for(int i=(groupStartPage*pagePerGroup)+1; i<=(groupStartPage*pagePerGroup)+pagePerGroup; i=i+1){
						//현재 페이지 색 다르게
						if(i == currentPage){
			%>
							<li class="page-item"><a class="btn btn-secondary"
								href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>"><%=i%></a>
							</li>
			<%				
						}else{			
			%>
							<li class="page-item"><a class="btn btn-info"
								href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>"><%=i%></a>
							</li>
			<%
						}
					}
				}else{
					groupStartPage = currentPage / pagePerGroup;
					//System.out.println(groupStartPage);
					if(lastPage < (groupStartPage*pagePerGroup)+pagePerGroup){
						for(int i=(groupStartPage*pagePerGroup)+1; i<=lastPage; i=i+1){
							//현재 페이지 색 다르게							
							if(i == currentPage){
			%>
								<li class="page-item"><a class="btn btn-secondary"
									href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>"><%=i%></a>
								</li>
			<%									
							}else{
			%>
								<li class="page-item"><a class="btn btn-info"
									href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>"><%=i%></a>
								</li>
			<%				
							}
						}
					}else{
						for(int i=(groupStartPage*pagePerGroup)+1; i<=(groupStartPage*pagePerGroup)+pagePerGroup; i=i+1){
							//현재 페이지 색 다르게
							if(i == currentPage){
			%>
								<li class="page-item"><a class="btn btn-secondary"
								href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>"><%=i%></a>
								</li>
			<%
							}else{
			%>
								<li class="page-item"><a class="btn btn-info"
								href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>"><%=i%></a>
								</li>
			<%
							}	
						}
					}		
				}
			%>


					<!-- 다음 페이지(다음 10페이지(다음 10개중 첫번째 출력) - 마지막 10개중 한 페이지일 경우 마지막 페이지 출력) -->
					<%
				if((currentPage/pagePerGroup) == (lastPage/pagePerGroup)){
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=lastPage%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>">다음</a>
					</li>
					<%
				}else{
					if((currentPage%pagePerGroup)==0){
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=currentPage+1%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>">다음</a>
					</li>
					<%	
					}else{
						int e = ((currentPage + pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=e%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>">다음</a>
					</li>
					<%
					}
				}
			%>


					<!-- 마지막 페이지로 이동 -->
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=lastPage%>&&userDisplay=<%=rowPerPage%>&&sel1=<%=sel1%>&&sel2=<%=sel2%>">마지막</a>
					</li>



				</ul>

			</div>
			<div class="col-xl-3"></div>
		</div>












	<%
			}
		}else{
	%>
		<!-- 하단 페이지 넘버 -->


		<div class="row">
			<div class="col-xl-3"></div>
			<div class="col-xl-6">
				<!-- 1페이지로 이동 -->
				<ul class="pagination" style="justify-content: center;">
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=1&&userDisplay=<%=rowPerPage%>">첫번째</a>						
					</li>



					<!-- 이전 페이지(이전 10페이지(마지막 페이지 출력) - 현재 페이지 1~10일 경우 1페이지 출력) -->
					<%
				if(currentPage > pagePerGroup){
					int e = ((currentPage - pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
					if(currentPage%pagePerGroup == 0){
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=currentPage-pagePerGroup%>&&userDisplay=<%=rowPerPage%>">이전</a>
					</li>
					<%		
					}else{
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=e+pagePerGroup-1%>&&userDisplay=<%=rowPerPage%>">이전</a>
					</li>

					<%				
					}
			
				}else{
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=1&&userDisplay=<%=rowPerPage%>">이전</a>
					</li>
					<%
				}
			%>



					<%
				// 전체 몇 페이지가 필요한 지 체크
				// 10의 배수가 아닐 경우 +1 ex) 19개 데이터 => 19 / 10 = 몫:1 -> 2페이지 필요
				if((totalRow % rowPerPage) == 0){
					lastPage = totalRow / rowPerPage;
				}else{
					lastPage = (totalRow / rowPerPage) + 1;
				}
				
				//1~10page 그룹 시작페이지
				int groupStartPage = 0;	// 0=1~10페이지		1=11~20페이지
				
				//하단 1~10 페이지 출력
				//페이지 그룹으로 총 10 * x개의 그룹 확인
				//10의 배수일 경우  - 1
				if(currentPage % pagePerGroup == 0){
					groupStartPage = currentPage / pagePerGroup - 1;
					//System.out.println(groupStartPage);
					for(int i=(groupStartPage*pagePerGroup)+1; i<=(groupStartPage*pagePerGroup)+pagePerGroup; i=i+1){
						//현재 페이지 색 다르게
						if(i == currentPage){
			%>
							<li class="page-item"><a class="btn btn-secondary"
								href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
							</li>
			<%				
						}else{			
			%>
							<li class="page-item"><a class="btn btn-info"
								href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
							</li>
			<%
						}
					}
				}else{
					groupStartPage = currentPage / pagePerGroup;
					//System.out.println(groupStartPage);
					if(lastPage < (groupStartPage*pagePerGroup)+pagePerGroup){
						for(int i=(groupStartPage*pagePerGroup)+1; i<=lastPage; i=i+1){
							//현재 페이지 색 다르게							
							if(i == currentPage){
			%>
								<li class="page-item"><a class="btn btn-secondary"
									href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
								</li>
			<%									
							}else{
			%>
								<li class="page-item"><a class="btn btn-info"
									href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
								</li>
			<%				
							}
						}
					}else{
						for(int i=(groupStartPage*pagePerGroup)+1; i<=(groupStartPage*pagePerGroup)+pagePerGroup; i=i+1){
							//현재 페이지 색 다르게
							if(i == currentPage){
			%>
								<li class="page-item"><a class="btn btn-secondary"
								href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
								</li>
			<%
							}else{
			%>
								<li class="page-item"><a class="btn btn-info"
								href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=i%>&&userDisplay=<%=rowPerPage%>"><%=i%></a>
								</li>
			<%
							}	
						}
					}		
				}
			%>


					<!-- 다음 페이지(다음 10페이지(다음 10개중 첫번째 출력) - 마지막 10개중 한 페이지일 경우 마지막 페이지 출력) -->
					<%
				if((currentPage/pagePerGroup) == (lastPage/pagePerGroup)){
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=lastPage%>&&userDisplay=<%=rowPerPage%>">다음</a>
					</li>
					<%
				}else{
					if((currentPage%pagePerGroup)==0){
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=currentPage+1%>&&userDisplay=<%=rowPerPage%>">다음</a>
					</li>
					<%	
					}else{
						int e = ((currentPage + pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=e%>&&userDisplay=<%=rowPerPage%>">다음</a>
					</li>
					<%
					}
				}
			%>


					<!-- 마지막 페이지로 이동 -->
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/qnaList.jsp?currentPage=<%=lastPage%>&&userDisplay=<%=rowPerPage%>">마지막</a>
					</li>



				</ul>

			</div>
			<div class="col-xl-3"></div>
		</div>
	<%
			}
		}
	%>
		
		
		<!-- 하단 검색 창 -->
	
		<form method="post" action="<%=request.getContextPath()%>/qna/searchQnaAction.jsp">
		
			<div class="row">		
				<div class="col-xl-3"></div>
				<div class="col-xl-6">
					<div class="row">
							
						<div class="col-xl-3"></div>
						<div class="col-xl-6" style="text-align: center">
									<div class="input-group mt-3 mb-3">
										
										
										<select class="form-control" name="sel1">
									        <option value="qna_title">제목</option>
									        <option value="qna_title_content">제목+내용</option>
									        <option value="qna_content">내용</option>
											<option value="qna_user">사용자</option>										
									    </select>									
									    	
										
										<input type="text" class="form-control" name="sel2">
										<div class="input-group-append">
										    <button class="btn btn-success" type="submit">검색</button>
										</div>
									</div>
						
						</div>
						<div class="col-xl-3"></div>	
				
					</div>			
				
				</div>
				<div class="col-xl-3"></div>
			</div>
		
		</form>
		

</div>
</body>
</html>