<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

/* 	request.setCharacterEncoding("utf-8");

	String sel1 = request.getParameter("sel1");
	String sel2 = request.getParameter("sel2");
	
	
	//sel2의 값은 한글이 올 수도 있는데 sendRedirect는 한글 값을 보낼수가 없음 그러므로 인코딩을 해주어야 함
	String encodedSel2 = URLEncoder.encode(sel2, "UTF-8");


	//System.out.println("Action sel1 : " + sel1);
	//System.out.println("Action sel2 : " + sel2);
	
	
	response.sendRedirect(request.getContextPath() + "/titles/titlesList.jsp?sel1=" + sel1 + "&sel2=" + encodedSel2); */
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	request.setCharacterEncoding("utf-8");
	
	String titlesCheckBoxEmpNo = request.getParameter("titlesCheckBoxEmpNo");
	String titlesCheckBoxTitle = request.getParameter("titlesCheckBoxTitle");
	String titlesCheckBoxFromDate = request.getParameter("titlesCheckBoxFromDate");
	String titlesCheckBoxToDate = request.getParameter("titlesCheckBoxToDate");
	
	//System.out.println(deptEmpCheckBoxEmpNo);
	//System.out.println(deptEmpCheckBoxDeptNo);
	//System.out.println(deptEmpCheckBoxFromDate);
	//System.out.println(deptEmpCheckBoxToDate);
	
	
	
	String titlesTextEmpNo = request.getParameter("titlesTextEmpNo");
	String titlesTextTitle = request.getParameter("titlesTextTitle");
	
	String titlesTextFromDateStart = request.getParameter("titlesTextFromDateStart");
	String titlesTextFromDateEnd = request.getParameter("titlesTextFromDateEnd");
	
	String titlesTextToDateStart = request.getParameter("titlesTextToDateStart");
	String titlesTextToDateEnd = request.getParameter("titlesTextToDateEnd");
	
	/* System.out.println(deptEmpTextEmpNo);
	System.out.println(deptEmpTextDeptNo);
	System.out.println(deptEmpTextFromDateStart);
	System.out.println(deptEmpTextFromDateEnd);
	System.out.println(deptEmpTextToDateStart);
	System.out.println(deptEmpTextToDateEnd); */
	
	
	String redirectValue = "";
	
	
	
	int selectCount = 0;
	
	
	//EmpNo 검색 안함
	if(titlesCheckBoxEmpNo != null && titlesCheckBoxEmpNo != ""){
		redirectValue += "selectEmpNo=" + titlesTextEmpNo + "&";
		selectCount = selectCount + 1;
	}
		
	if(titlesCheckBoxTitle != null && titlesCheckBoxTitle != ""){
		redirectValue += "selectTitle=" + titlesTextTitle + "&";
		selectCount = selectCount + 1;
	}
	
	//FromDate 검색
	if(titlesCheckBoxFromDate != null && titlesCheckBoxFromDate != ""){
		//FromDate 시작일 검색
	
		if(titlesTextFromDateStart == ""){
			redirectValue += "selectFromDateStart=0000-00-00&";			
		}else{
			if(titlesTextFromDateStart.length() == 4){
				redirectValue += "selectFromDateStart=" + titlesTextFromDateStart + "-00-00&";	
			}else{
				redirectValue += "selectFromDateStart=0000-00-00&";	
			}
			
		}	
		
			
				
		
		if(titlesTextFromDateEnd == ""){
			redirectValue += "selectFromDateEnd=9999-12-31&";
		}else{
			if(titlesTextFromDateEnd.length() == 4){
				redirectValue += "selectFromDateEnd=" + titlesTextFromDateEnd + "-12-31&";	
			}else{
				redirectValue += "selectFromDateEnd=9999-12-31&";	
			}
			
		}	
		
	
		selectCount = selectCount + 1;
	}
		
	//ToDate 검색
	if(titlesCheckBoxToDate != null && titlesCheckBoxToDate != ""){
		//FromDate 시작일 검색		
		if(titlesTextToDateStart == ""){
			redirectValue += "selectToDateStart=0000-00-00&";			
		}else{
			if(titlesTextToDateStart.length() == 4){
				redirectValue += "selectToDateStart=" + titlesTextToDateStart + "-00-00&";	
			}else{
				redirectValue += "selectToDateStart=0000-00-00&";	
			}			
		}	
			
				
		
		if(titlesTextToDateEnd == ""){
			redirectValue += "selectToDateEnd=9999-12-31&";
		}else{
			if(titlesTextToDateEnd.length() == 4){
				redirectValue += "selectToDateEnd=" + titlesTextToDateEnd + "-12-31&";	
			}else{
				redirectValue += "selectToDateEnd=9999-12-31&";
			}
			
		}	
				
		
		selectCount = selectCount + 1;
	}
	
	if(selectCount > 0) {
		redirectValue += "selectCount=" + selectCount + "&";
	}
	
	
	System.out.println(redirectValue);
	
	
	response.sendRedirect(request.getContextPath() + "/titles/titlesList.jsp?" + redirectValue);
%>