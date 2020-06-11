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
		
		
		response.sendRedirect(request.getContextPath() + "/salaries/salariesList.jsp?sel1=" + sel1 + "&sel2=" + encodedSel2); */

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	request.setCharacterEncoding("utf-8");

	String salariesCheckBoxEmpNo = request.getParameter("salariesCheckBoxEmpNo");
	String salariesCheckBoxSalary = request.getParameter("salariesCheckBoxSalary");
	String salariesCheckBoxFromDate = request.getParameter("salariesCheckBoxFromDate");
	String salariesCheckBoxToDate = request.getParameter("salariesCheckBoxToDate");

	//System.out.println(deptEmpCheckBoxEmpNo);
	//System.out.println(deptEmpCheckBoxDeptNo);
	//System.out.println(deptEmpCheckBoxFromDate);
	//System.out.println(deptEmpCheckBoxToDate);

	String salariesTextEmpNo = request.getParameter("salariesTextEmpNo");
	//String titlesTextTitle = request.getParameter("titlesTextTitle");
	
	String salariesTextDownSalary = request.getParameter("salariesTextDownSalary");
	String salariesTextUpSalary = request.getParameter("salariesTextUpSalary");
	

	String salariesTextFromDateStart = request.getParameter("salariesTextFromDateStart");
	String salariesTextFromDateEnd = request.getParameter("salariesTextFromDateEnd");

	String salariesTextToDateStart = request.getParameter("salariesTextToDateStart");
	String salariesTextToDateEnd = request.getParameter("salariesTextToDateEnd");

	/* System.out.println(deptEmpTextEmpNo);
	System.out.println(deptEmpTextDeptNo);
	System.out.println(deptEmpTextFromDateStart);
	System.out.println(deptEmpTextFromDateEnd);
	System.out.println(deptEmpTextToDateStart);
	System.out.println(deptEmpTextToDateEnd); */

	String redirectValue = "";

	int selectCount = 0;

	//EmpNo 검색 안함
	if (salariesCheckBoxEmpNo != null && salariesCheckBoxEmpNo != "") {
		redirectValue += "selectEmpNo=" + salariesTextEmpNo + "&";
		selectCount = selectCount + 1;
	}

	//Salary 검색
	if (salariesCheckBoxSalary != null && salariesCheckBoxSalary != "") {
		//FromDate 시작일 검색

		if (salariesTextDownSalary == "") {
			redirectValue += "selectDownSalary=00000000&";
		} else {			
			redirectValue += "selectDownSalary=" + salariesTextDownSalary + "&";
		}

		if (salariesTextUpSalary == "") {
			redirectValue += "selectUpSalary=99999999&";
		} else {
			redirectValue += "selectUpSalary=" + salariesTextUpSalary + "&";
		}

		selectCount = selectCount + 1;
	}
	
	
	
	

	//FromDate 검색
	if (salariesCheckBoxFromDate != null && salariesCheckBoxFromDate != "") {
		//FromDate 시작일 검색

		if (salariesTextFromDateStart == "") {
			redirectValue += "selectFromDateStart=0000-00-00&";
		} else {
			if (salariesTextFromDateStart.length() == 4) {
				redirectValue += "selectFromDateStart=" + salariesTextFromDateStart + "-00-00&";
			} else {
				redirectValue += "selectFromDateStart=0000-00-00&";
			}

		}

		if (salariesTextFromDateEnd == "") {
			redirectValue += "selectFromDateEnd=9999-12-31&";
		} else {
			if (salariesTextFromDateEnd.length() == 4) {
				redirectValue += "selectFromDateEnd=" + salariesTextFromDateEnd + "-12-31&";
			} else {
				redirectValue += "selectFromDateEnd=9999-12-31&";
			}

		}

		selectCount = selectCount + 1;
	}

	//ToDate 검색
	if (salariesCheckBoxToDate != null && salariesCheckBoxToDate != "") {
		//FromDate 시작일 검색		
		if (salariesTextToDateStart == "") {
			redirectValue += "selectToDateStart=0000-00-00&";
		} else {
			if (salariesTextToDateStart.length() == 4) {
				redirectValue += "selectToDateStart=" + salariesTextToDateStart + "-00-00&";
			} else {
				redirectValue += "selectToDateStart=0000-00-00&";
			}
		}

		if (salariesTextToDateEnd == "") {
			redirectValue += "selectToDateEnd=9999-12-31&";
		} else {
			if (salariesTextToDateEnd.length() == 4) {
				redirectValue += "selectToDateEnd=" + salariesTextToDateEnd + "-12-31&";
			} else {
				redirectValue += "selectToDateEnd=9999-12-31&";
			}

		}

		selectCount = selectCount + 1;
	}

	if (selectCount > 0) {
		redirectValue += "selectCount=" + selectCount + "&";
	}

	System.out.println(redirectValue);

	response.sendRedirect(request.getContextPath() + "/salaries/salariesList.jsp?" + redirectValue);
%>