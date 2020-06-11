<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%



/* 	request.setCharacterEncoding("utf-8");

	String sel1 = request.getParameter("sel1");
	String sel2 = request.getParameter("sel2");
	
	
	//sel2의 값은 한글이 올 수도 있는데 sendRedirect는 한글 값을 보낼수가 없음 그러므로 인코딩을 해주어야 함
	String encodedSel2 = URLEncoder.encode(sel2, "UTF-8");


	
	response.sendRedirect(request.getContextPath() + "/deptEmp/deptEmpList.jsp?sel1=" + sel1 + "&sel2=" + encodedSel2); */
	
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	request.setCharacterEncoding("utf-8");
	
	String deptEmpCheckBoxEmpNo = request.getParameter("deptEmpCheckBoxEmpNo");
	String deptEmpCheckBoxDeptNo = request.getParameter("deptEmpCheckBoxDeptNo");
	String deptEmpCheckBoxFromDate = request.getParameter("deptEmpCheckBoxFromDate");
	String deptEmpCheckBoxToDate = request.getParameter("deptEmpCheckBoxToDate");
	
	//System.out.println(deptEmpCheckBoxEmpNo);
	//System.out.println(deptEmpCheckBoxDeptNo);
	//System.out.println(deptEmpCheckBoxFromDate);
	//System.out.println(deptEmpCheckBoxToDate);
	
	
	
	String deptEmpTextEmpNo = request.getParameter("deptEmpTextEmpNo");
	String deptEmpTextDeptNo = request.getParameter("deptEmpTextDeptNo");
	
	String deptEmpTextFromDateStart = request.getParameter("deptEmpTextFromDateStart");
	String deptEmpTextFromDateEnd = request.getParameter("deptEmpTextFromDateEnd");
	
	String deptEmpTextToDateStart = request.getParameter("deptEmpTextToDateStart");
	String deptEmpTextToDateEnd = request.getParameter("deptEmpTextToDateEnd");
	
	/* System.out.println(deptEmpTextEmpNo);
	System.out.println(deptEmpTextDeptNo);
	System.out.println(deptEmpTextFromDateStart);
	System.out.println(deptEmpTextFromDateEnd);
	System.out.println(deptEmpTextToDateStart);
	System.out.println(deptEmpTextToDateEnd); */
	
	
	String redirectValue = "";
	
	
	
	int selectCount = 0;
	
	
	//EmpNo 검색 안함
	if(deptEmpCheckBoxEmpNo != null && deptEmpCheckBoxEmpNo != ""){
		redirectValue += "selectEmpNo=" + deptEmpTextEmpNo + "&";
		selectCount = selectCount + 1;
	}
		
	if(deptEmpCheckBoxDeptNo != null && deptEmpCheckBoxDeptNo != ""){
		redirectValue += "selectDeptNo=" + deptEmpTextDeptNo + "&";
		selectCount = selectCount + 1;
	}
	
	//FromDate 검색
	if(deptEmpCheckBoxFromDate != null && deptEmpCheckBoxFromDate != ""){
		//FromDate 시작일 검색
	
		if(deptEmpTextFromDateStart == ""){
			redirectValue += "selectFromDateStart=0000-00-00&";			
		}else{
			if(deptEmpTextFromDateStart.length() == 4){
				redirectValue += "selectFromDateStart=" + deptEmpTextFromDateStart + "-00-00&";	
			}else{
				redirectValue += "selectFromDateStart=0000-00-00&";	
			}
			
		}	
		
			
				
		
		if(deptEmpTextFromDateEnd == ""){
			redirectValue += "selectFromDateEnd=9999-12-31&";
		}else{
			if(deptEmpTextFromDateEnd.length() == 4){
				redirectValue += "selectFromDateEnd=" + deptEmpTextFromDateEnd + "-12-31&";	
			}else{
				redirectValue += "selectFromDateEnd=9999-12-31&";	
			}
			
		}	
		
	
		selectCount = selectCount + 1;
	}
		
	//ToDate 검색
	if(deptEmpCheckBoxToDate != null && deptEmpCheckBoxToDate != ""){
		//FromDate 시작일 검색		
		if(deptEmpTextToDateStart == ""){
			redirectValue += "selectToDateStart=0000-00-00&";			
		}else{
			if(deptEmpTextToDateStart.length() == 4){
				redirectValue += "selectToDateStart=" + deptEmpTextToDateStart + "-00-00&";	
			}else{
				redirectValue += "selectToDateStart=0000-00-00&";	
			}			
		}	
			
				
		
		if(deptEmpTextToDateEnd == ""){
			redirectValue += "selectToDateEnd=9999-12-31&";
		}else{
			if(deptEmpTextToDateEnd.length() == 4){
				redirectValue += "selectToDateEnd=" + deptEmpTextToDateEnd + "-12-31&";	
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
	
	
	response.sendRedirect(request.getContextPath() + "/deptEmp/deptEmpList.jsp?" + redirectValue);	
	
%>