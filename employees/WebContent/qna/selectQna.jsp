<%@page import="gd.emp.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectQna</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");


	String loginID = "";
	String loginPW = "";
	
	try{
		loginID = (String)session.getAttribute("loginID");
	
		//System.out.println(loginID);
	}catch(NullPointerException e){
		
	}
	

	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	
	
	
	//게시글 수정 시 비밀번호 체크
	String pwCheck = "";
	if(request.getParameter("ck") != null && request.getParameter("ck") != ""){
		pwCheck = request.getParameter("ck");	
	}
	
	
	
	//System.out.println("qnaNo = " + qnaNo);

	//2.0 database
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1234");
	
	// 2.1 현재페이지의 departments 테이블 행들 가져오기
	//ArrayList<QnA> list = new ArrayList<QnA>();
	
	QnA list = new QnA();
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	stmt1 = conn.prepareStatement("SELECT qna_no, qna_title, qna_content, qna_user, qna_date FROM employees_qna WHERE qna_no=?;");
	stmt1.setInt(1, qnaNo);
	
	rs1 = stmt1.executeQuery();
	
	while(rs1.next()){
		//QnA q = new QnA();
		list.qnaNo = rs1.getInt("qna_no");
		list.qnaTitle = rs1.getString("qna_title");	
		list.qnaContent = rs1.getString("qna_content");
		list.qnaUser = rs1.getString("qna_user");		
		list.qnaDate = rs1.getString("qna_date");		
		
		//list.add(q);
	}
	
	
	
	// 1. 코멘트 페이지
	int commentPage = 1;	//현재 페이지
	
	if(request.getParameter("commentPage") != null){
		commentPage = Integer.parseInt(request.getParameter("commentPage"));
	}	
	
	int rowPerPageComment = 5;	// 한 페이지에 몇개씩 보여줄 지	
	
	int beginRow = (commentPage-1) * rowPerPageComment;	//1page = 0~4	2page=5~9	
	
	
	int pagePerGroup = 5;	// 하단 페이지 목록 수

	
	ArrayList<QnAcomment> listQnAcomment = new ArrayList<QnAcomment>();
	
	//QnAcomment listQnAcomment = new QnAcomment();
	
	
	
	// 코멘트 출력
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement("SELECT comment_no, qna_no, comment_user, comment, comment_date, comment_pw FROM employees_qna_comment WHERE qna_no=? order by comment_no desc limit ?,?;");	
	stmt2.setInt(1, qnaNo);
	stmt2.setInt(2, beginRow);
	stmt2.setInt(3, rowPerPageComment);
	
	rs2 = stmt2.executeQuery();
	
	while(rs2.next()){
		QnAcomment qc = new QnAcomment();
		qc.commentNo = rs2.getInt("comment_no");
		qc.qnaNo = rs2.getInt("qna_no");
		qc.commentUser = rs2.getString("comment_user");
		qc.comment = rs2.getString("comment");
		qc.commentDate = rs2.getString("comment_date");
		qc.commentPw = rs2.getString("comment_pw");		
		
		
		listQnAcomment.add(qc);
	}
	
	
	// 3. departments 테이블 전채 행 개수 가져오기
	int totalRow = 0;	// DB에 존재하는 행 개수
	int lastPage = 0;	// 마지막 페이지
	PreparedStatement stmt3 = null;
	ResultSet rs3 = null;
	stmt3 = conn.prepareStatement("SELECT COUNT(*) FROM employees_qna_comment WHERE qna_no=?;");
	stmt3.setInt(1, qnaNo);
	rs3 = stmt3.executeQuery();
	
	if(rs3.next()){
		totalRow = rs3.getInt("COUNT(*)");
		//System.out.println(totalRow);
	}
	
	
	
	// 로그인 정보 확인
	if(loginID == null){
		//비로그인 상태
		
	}else{		
		PreparedStatement stmt4 = conn.prepareStatement("SELECT pw FROM employees_signup WHERE id=?");
		stmt4.setString(1, loginID);
		ResultSet rs4 = stmt4.executeQuery();
		if(rs4.next()){
			loginPW = rs4.getString("pw");
		}
				
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
			<h1>selectQnA</h1>
		
		
		<!-- 게시글 수정 시 패스워드 오류 -->
		<%
			if(request.getParameter("ck") != null && request.getParameter("ck") != ""){
				if(pwCheck.equals("fail")){
		%>
					<div>
						게시글 수정 비밀번호가 틀렸습니다.
					</div>
		
		<%	
				}	
			}
		%>
			
			
			
			
				
	  				<!-- 게시글 보기 -->
					<table class="table table-bordered table-hover">
					
					
						<thead class="table-info" style="text-align: center">
							<tr>
								<th colspan="2">
									<%=list.qnaTitle %>
								</th>														
							</tr>
						</thead>
						
						<tbody>							
							
							<tr>
								<td style="width: 13%; text-align: center">게시글 번호</td>
								<td>
									<%=list.qnaNo %>
								</td>							
							</tr>
							
							<tr>
								<td style="width: 13%; text-align: center">작성일자</td>
								<td>
									<%=list.qnaDate.substring(0, 10) %>
								</td>							
							</tr>
							
							<tr>
								<td style="width: 13%; text-align: center">작성자</td>
								<td>
									<%=list.qnaUser %>
								</td>							
							</tr>
							
							<tr>
								<td style="width: 13%; text-align: center">내용</td>
								<td>
									<%=list.qnaContent %>
								</td>							
							</tr>
							
							
							
						</tbody>
					
					
				
						
						
		
					</table>
				  
				  	<div style="text-align: center">
				  		<a class="btn btn-info"
							href="<%=request.getContextPath()%>/qna/qnaList.jsp">목록으로
						</a>
				  	
				  	<%
						//비로그인 상태
						if(loginID == null){
					%>
							<a class="btn btn-success disabled"
									href="<%=request.getContextPath()%>/qna/updateQnaForm.jsp?qnaNo=<%=qnaNo %>">수정하기
							</a>
						
							<a class="btn btn-danger disabled"
								href="<%=request.getContextPath()%>/qna/deleteQnaForm.jsp?qnaNo=<%=qnaNo %>">삭제하기
							</a>
					<%		
						}else{
							if(list.qnaUser.equals(loginID)){
					%>				  		
					  			<a class="btn btn-success"
									href="<%=request.getContextPath()%>/qna/updateQnaForm.jsp?qnaNo=<%=qnaNo %>">수정하기
								</a>
						
								<a class="btn btn-danger"
									href="<%=request.getContextPath()%>/qna/deleteQnaForm.jsp?qnaNo=<%=qnaNo %>">삭제하기
								</a>
					<%
							}else{
					%>
								<a class="btn btn-success disabled"
									href="<%=request.getContextPath()%>/qna/updateQnaForm.jsp?qnaNo=<%=qnaNo %>">수정하기
								</a>
						
								<a class="btn btn-danger disabled"
									href="<%=request.getContextPath()%>/qna/deleteQnaForm.jsp?qnaNo=<%=qnaNo %>">삭제하기
								</a>	
					<%
							}
						}
					%>
						
						
				  	</div>
				  	
				  	
				  	
				  
				  <%
				  	//댓글이 없을 경우
				  	if(totalRow == 0){
				  		//댓글이 없을 경우 댓글 목록 창 숨기기
				  	}else{
				  %>
				  
				  
				  
				  <!-- 댓글 보기 -->
					<table class="table table-striped" style="margin-top: 20px">
						<thead class="table-info" style="text-align: center">
							<tr>
								<th colspan="2">
									댓글 목록
								</th>														
							</tr>
						</thead>
					
						
						<%
							for(QnAcomment qc : listQnAcomment){
						%>
												
						<tr>
							<td style="width:85%">						
							<small><b><%=qc.commentUser %></b> <small><%=qc.commentDate.substring(0, 19) %></small></small><br>
								<%=qc.comment %>  
							</td>
							
							<td>
							<%
								if(loginID != null){
									if(qc.commentUser.equals(loginID)){		
							%>
										<a class="btn btn-light" 
											href="<%=request.getContextPath()%>/qna/deleteCommentForm.jsp?commentNo=<%=qc.commentNo%>&qnaNo=<%=qc.qnaNo%>">삭제하기
										</a>
							<%
									}else{
							%>
										<a class="btn btn-light disabled" 
											href="<%=request.getContextPath()%>/qna/deleteCommentForm.jsp?commentNo=<%=qc.commentNo%>&qnaNo=<%=qc.qnaNo%>">삭제하기
										</a>
							<%									
									}
								}else{
							%>		
									<a class="btn btn-light disabled" 
										href="<%=request.getContextPath()%>/qna/deleteCommentForm.jsp?commentNo=<%=qc.commentNo%>&qnaNo=<%=qc.qnaNo%>">삭제하기
									</a>
							<%	
								}
							%>
								
							</td>
							
						</tr>
						
						<%
							}
						%>
					
				
		
					</table>
				  
				  
				  <!-- 댓글 페이징 작업 1~5페이지 출력 -->
				  
				  <!-- 1페이지로 이동 -->
				<ul class="pagination" style="justify-content: center;">
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/selectQna.jsp?qnaNo=<%=qnaNo %>&&commentPage=1">첫번째</a>						
					</li>



					<!-- 이전 페이지(이전 10페이지(마지막 페이지 출력) - 현재 페이지 1~10일 경우 1페이지 출력) -->
					<%
				if(commentPage > pagePerGroup){
					int e = ((commentPage - pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
					if(commentPage%pagePerGroup == 0){
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/selectQna.jsp?qnaNo=<%=qnaNo %>&&commentPage=<%=commentPage-pagePerGroup%>">이전</a>
					</li>
					<%		
					}else{
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/selectQna.jsp?qnaNo=<%=qnaNo %>&&commentPage=<%=e+pagePerGroup-1%>">이전</a>
					</li>

					<%				
					}
			
				}else{
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/selectQna.jsp?qnaNo=<%=qnaNo %>&&commentPage=1">이전</a>
					</li>
					<%
				}
			%>



					<%
				// 전체 몇 페이지가 필요한 지 체크
				// 10의 배수가 아닐 경우 +1 ex) 19개 데이터 => 19 / 10 = 몫:1 -> 2페이지 필요
				if((totalRow % rowPerPageComment) == 0){
					lastPage = totalRow / rowPerPageComment;
				}else{
					lastPage = (totalRow / rowPerPageComment) + 1;
				}
				
				//1~10page 그룹 시작페이지
				int groupStartPage = 0;	// 0=1~10페이지		1=11~20페이지
				
				//하단 1~10 페이지 출력
				//페이지 그룹으로 총 10 * x개의 그룹 확인
				//10의 배수일 경우  - 1
				if(commentPage % pagePerGroup == 0){
					groupStartPage = commentPage / pagePerGroup - 1;
					//System.out.println(groupStartPage);
					for(int i=(groupStartPage*pagePerGroup)+1; i<=(groupStartPage*pagePerGroup)+pagePerGroup; i=i+1){
						//현재 페이지 색 다르게
						if(i == commentPage){
			%>
							<li class="page-item"><a class="btn btn-secondary"
								href="<%=request.getContextPath() %>/qna/selectQna.jsp?qnaNo=<%=qnaNo %>&&commentPage=<%=i%>"><%=i%></a>
							</li>
			<%				
						}else{			
			%>
							<li class="page-item"><a class="btn btn-info"
								href="<%=request.getContextPath() %>/qna/selectQna.jsp?qnaNo=<%=qnaNo %>&&commentPage=<%=i%>"><%=i%></a>
							</li>
			<%
						}
					}
				}else{
					groupStartPage = commentPage / pagePerGroup;
					//System.out.println(groupStartPage);
					if(lastPage < (groupStartPage*pagePerGroup)+pagePerGroup){
						for(int i=(groupStartPage*pagePerGroup)+1; i<=lastPage; i=i+1){
							//현재 페이지 색 다르게							
							if(i == commentPage){
			%>
								<li class="page-item"><a class="btn btn-secondary"
									href="<%=request.getContextPath() %>/qna/selectQna.jsp?qnaNo=<%=qnaNo %>&&commentPage=<%=i%>"><%=i%></a>
								</li>
			<%									
							}else{
			%>
								<li class="page-item"><a class="btn btn-info"
									href="<%=request.getContextPath() %>/qna/selectQna.jsp?qnaNo=<%=qnaNo %>&&commentPage=<%=i%>"><%=i%></a>
								</li>
			<%				
							}
						}
					}else{
						for(int i=(groupStartPage*pagePerGroup)+1; i<=(groupStartPage*pagePerGroup)+pagePerGroup; i=i+1){
							//현재 페이지 색 다르게
							if(i == commentPage){
			%>
								<li class="page-item"><a class="btn btn-secondary"
								href="<%=request.getContextPath() %>/qna/selectQna.jsp?qnaNo=<%=qnaNo %>&&commentPage=<%=i%>"><%=i%></a>
								</li>
			<%
							}else{
			%>
								<li class="page-item"><a class="btn btn-info"
								href="<%=request.getContextPath() %>/qna/selectQna.jsp?qnaNo=<%=qnaNo %>&&commentPage=<%=i%>"><%=i%></a>
								</li>
			<%
							}	
						}
					}		
				}
			%>


					<!-- 다음 페이지(다음 10페이지(다음 10개중 첫번째 출력) - 마지막 10개중 한 페이지일 경우 마지막 페이지 출력) -->
					<%
				if((commentPage/pagePerGroup) == (lastPage/pagePerGroup)){
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/selectQna.jsp?qnaNo=<%=qnaNo %>&&commentPage=<%=lastPage%>">다음</a>
					</li>
					<%
				}else{
					if((commentPage%pagePerGroup)==0){
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/selectQna.jsp?qnaNo=<%=qnaNo %>&&commentPage=<%=commentPage+1%>">다음</a>
					</li>
					<%	
					}else{
						int e = ((commentPage + pagePerGroup) / pagePerGroup) * pagePerGroup + 1;
			%>
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/selectQna.jsp?qnaNo=<%=qnaNo %>&&commentPage=<%=e%>">다음</a>
					</li>
					<%
					}
				}
			%>


					<!-- 마지막 페이지로 이동 -->
					<li class="page-item"><a class="btn btn-info"
						href="<%=request.getContextPath() %>/qna/selectQna.jsp?qnaNo=<%=qnaNo %>&&commentPage=<%=lastPage%>">마지막</a>
					</li>



				</ul>
				  
			<%
				  	}
			%>
				  
				  
				  	
				  	
				  	
				  <!-- ~댓글 페이징 작업 1~5페이지 출력 -->	
				  	
				  	
				  	<!-- 댓글 입력폼 -->
				  	
				  	<form method="post" action="<%=request.getContextPath()%>/qna/insertCommentAction.jsp" style="margin-top: 20px">
				  		<!-- 댓글 목록 -->
				  		
				  	
				  	
				  		<input type="hidden" name="qnaNo" value=<%=qnaNo %>>			
				  		<input type="hidden" name="commentUser" value=<%=loginID %>>
				  		<input type="hidden" name="commentPw" value=<%=loginPW %>>	  		
				  		
				  		<%
				  		//	System.out.println("QNANO = " + qnaNo);
				  		//	System.out.println("commentUser = " + loginID);
				  		//	System.out.println("commentPw = " + loginPW);
				  		%>
				  		
				  		<table class="table table-borderless" style="margin: auto">			  			
							
							<tr>	
										
							<%
								if(loginID == null){
							%>
									<td width="80%">
										<textarea class="form-control" id="comment" name="comment" rows="2" placeholder="로그인 후 코멘트 입력이 가능합니다" ></textarea>	
									</td>
									<td>
										<button type="submit" class="btn btn-primary" style="width: 100%; height: 100%" disabled="disabled">댓글입력</button>
									</td>
							<%	
								}else{
							%>	
									<td width="80%">
										<textarea class="form-control" id="comment" name="comment" rows="2" placeholder="코멘트를 입력하세요" ></textarea>	
									</td>
									<td>
										<button type="submit" class="btn btn-primary" style="width: 100%; height: 100%">댓글입력</button>
									</td>				
							<%
								}
							%>
							</tr>
						
							<!-- <tr>	
								<td style="width:40%">
									<input type="text" class="form-control" id="commentUser" name="commentUser" placeholder="작성자명을 입력하세요">
								</td>
																					
								<td style="width:40%">
									<input type="password" class="form-control" id="commentPw" name="commentPw" placeholder="비밀번호를 입력하세요">
								</td>
								<td>
									<button type="submit" class="btn btn-primary" style="width: 100%; height: 100%">댓글입력</button>
								</td>			
										
							</tr> -->
				  		
				  		
				  		</table>
				  		
				  		
				  		
				  		
				  		
				  						  		
				  	
				  	</form>
				  	
				  	<!-- 댓글 목록 -->
				  	
			 
			
		</div>
		<div class="col-xl-3"></div>
	</div>
</div>

</body>
</html>