<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	/* request.setCharacterEncoding("utf-8");

	String sel1 = request.getParameter("sel1");
	String sel2 = request.getParameter("sel2");
	
	
	//sel2의 값은 한글이 올 수도 있는데 sendRedirect는 한글 값을 보낼수가 없음 그러므로 인코딩을 해주어야 함
	String encodedSel2 = URLEncoder.encode(sel2, "UTF-8");


	//System.out.println("Action sel1 : " + sel1);
	//System.out.println("Action sel2 : " + sel2);
	
	
	response.sendRedirect(request.getContextPath() + "/deptManager/deptManagerList.jsp?sel1=" + sel1 + "&sel2=" + encodedSel2); */
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	request.setCharacterEncoding("utf-8");
	
	String deptManagerCheckBoxEmpNo = request.getParameter("deptManagerCheckBoxEmpNo");
	String deptManagerCheckBoxDeptNo = request.getParameter("deptManagerCheckBoxDeptNo");
	String deptManagerCheckBoxFromDate = request.getParameter("deptManagerCheckBoxFromDate");
	String deptManagerCheckBoxToDate = request.getParameter("deptManagerCheckBoxToDate");
	
	//System.out.println(deptEmpCheckBoxEmpNo);
	//System.out.println(deptEmpCheckBoxDeptNo);
	//System.out.println(deptEmpCheckBoxFromDate);
	//System.out.println(deptEmpCheckBoxToDate);
	
	
	
	String deptManagerTextEmpNo = request.getParameter("deptManagerTextEmpNo");
	String deptManagerTextDeptNo = request.getParameter("deptManagerTextDeptNo");
	
	String deptManagerTextFromDateStart = request.getParameter("deptManagerTextFromDateStart");
	String deptManagerTextFromDateEnd = request.getParameter("deptManagerTextFromDateEnd");
	
	String deptManagerTextToDateStart = request.getParameter("deptManagerTextToDateStart");
	String deptManagerTextToDateEnd = request.getParameter("deptManagerTextToDateEnd");
	
	/* System.out.println(deptEmpTextEmpNo);
	System.out.println(deptEmpTextDeptNo);
	System.out.println(deptEmpTextFromDateStart);
	System.out.println(deptEmpTextFromDateEnd);
	System.out.println(deptEmpTextToDateStart);
	System.out.println(deptEmpTextToDateEnd); */
	
	
	String redirectValue = "";
	
	
	
	int selectCount = 0;
	
	
	//EmpNo 검색 안함
	if(deptManagerCheckBoxEmpNo != null && deptManagerCheckBoxEmpNo != ""){
		redirectValue += "selectEmpNo=" + deptManagerTextEmpNo + "&";
		selectCount = selectCount + 1;
	}
		
	if(deptManagerCheckBoxDeptNo != null && deptManagerCheckBoxDeptNo != ""){
		redirectValue += "selectDeptNo=" + deptManagerTextDeptNo + "&";
		selectCount = selectCount + 1;
	}
	
	//FromDate 검색
	if(deptManagerCheckBoxFromDate != null && deptManagerCheckBoxFromDate != ""){
		//FromDate 시작일 검색
	
		if(deptManagerTextFromDateStart == ""){
			redirectValue += "selectFromDateStart=0000-00-00&";			
		}else{
			if(deptManagerTextFromDateStart.length() == 4){
				redirectValue += "selectFromDateStart=" + deptManagerTextFromDateStart + "-00-00&";	
			}else{
				redirectValue += "selectFromDateStart=0000-00-00&";	
			}
			
		}	
		
			
				
		
		if(deptManagerTextFromDateEnd == ""){
			redirectValue += "selectFromDateEnd=9999-12-31&";
		}else{
			if(deptManagerTextFromDateEnd.length() == 4){
				redirectValue += "selectFromDateEnd=" + deptManagerTextFromDateEnd + "-12-31&";	
			}else{
				redirectValue += "selectFromDateEnd=9999-12-31&";	
			}
			
		}	
		
	
		selectCount = selectCount + 1;
	}
		
	//ToDate 검색
	if(deptManagerCheckBoxToDate != null && deptManagerCheckBoxToDate != ""){
		//FromDate 시작일 검색		
		if(deptManagerTextToDateStart == ""){
			redirectValue += "selectToDateStart=0000-00-00&";			
		}else{
			if(deptManagerTextToDateStart.length() == 4){
				redirectValue += "selectToDateStart=" + deptManagerTextToDateStart + "-00-00&";	
			}else{
				redirectValue += "selectToDateStart=0000-00-00&";	
			}			
		}	
			
				
		
		if(deptManagerTextToDateEnd == ""){
			redirectValue += "selectToDateEnd=9999-12-31&";
		}else{
			if(deptManagerTextToDateEnd.length() == 4){
				redirectValue += "selectToDateEnd=" + deptManagerTextToDateEnd + "-12-31&";	
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
	
	
	response.sendRedirect(request.getContextPath() + "/deptManager/deptManagerList.jsp?" + redirectValue);	
%>