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
	
	
	response.sendRedirect(request.getContextPath() + "/departments/departmentsList.jsp?sel1=" + sel1 + "&sel2=" + encodedSel2); */
	
	
	
	
	//--------------------------------------------------------------------------------
	
	
	
	request.setCharacterEncoding("utf-8");
	
	String departmentsCheckBoxDeptNo = request.getParameter("departmentsCheckBoxDeptNo");
	String departmentsCheckBoxDeptName = request.getParameter("departmentsCheckBoxDeptName");
	

	
	
	
	String departmentsTextDeptNo = request.getParameter("departmentsTextDeptNo");
	String departmentsTextDeptName = request.getParameter("departmentsTextDeptName");
	
	
	
	
	
	String redirectValue = "";
	
	
	
	int selectCount = 0;
	
	
	//EmpNo 검색 안함
	if(departmentsCheckBoxDeptNo != null && departmentsCheckBoxDeptNo != ""){
		redirectValue += "selectDeptNo=" + departmentsTextDeptNo + "&";
		selectCount = selectCount + 1;
	}
		
	if(departmentsCheckBoxDeptName != null && departmentsCheckBoxDeptName != ""){
		redirectValue += "selectDeptName=" + departmentsTextDeptName + "&";
		selectCount = selectCount + 1;
	}
	
	
		
	
	
	if(selectCount > 0) {
		redirectValue += "selectCount=" + selectCount + "&";
	}
	
	
	System.out.println(redirectValue);
	
	
	response.sendRedirect(request.getContextPath() + "/departments/departmentsList.jsp?" + redirectValue);	
%>

