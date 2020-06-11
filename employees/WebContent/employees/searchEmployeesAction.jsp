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
	
	
	response.sendRedirect(request.getContextPath() + "/employees/employeesList.jsp?sel1=" + sel1 + "&sel2=" + encodedSel2); */
	
	
	////////////////////////////////////////////////////////////////////
	
	request.setCharacterEncoding("utf-8");
	
	String employeesCheckBoxEmpNo = request.getParameter("employeesCheckBoxEmpNo");				//null
	String employeesCheckBoxGender = request.getParameter("employeesCheckBoxGender");			//null
	String employeesCheckBoxFirstName = request.getParameter("employeesCheckBoxFirstName");		//null
	String employeesCheckBoxLastName = request.getParameter("employeesCheckBoxLastName");		//null
	String employeesCheckBoxBirthDate = request.getParameter("employeesCheckBoxBirthDate");		//null
	String employeesCheckBoxHireDate = request.getParameter("employeesCheckBoxHireDate");		//null
	
	/* System.out.println(employeesCheckBoxEmpNo + "ck EmpNo");
	System.out.println(employeesCheckBoxGender + "ck Gender");
	System.out.println(employeesCheckBoxFirstName + "ck FirstName");
	System.out.println(employeesCheckBoxLastName + "ck LastName");
	System.out.println(employeesCheckBoxBirthDate + "ck BirthDate");
	System.out.println(employeesCheckBoxHireDate + "ck HireDate"); */
	
	
	
	
	String employeesTextEmpNo = request.getParameter("employeesTextEmpNo");
	String employeesRadioGender = request.getParameter("employeesRadioGender");
	
	String employeesTextFirstName = request.getParameter("employeesTextFirstName");
	String employeesTextLastName = request.getParameter("employeesTextLastName");
	
	String deptEmpTextBrithDateStart = request.getParameter("deptEmpTextBrithDateStart");
	String deptEmpTextBrithDateEnd = request.getParameter("deptEmpTextBrithDateEnd");
	
	String deptEmpTextHireDateStart = request.getParameter("deptEmpTextHireDateStart");
	String deptEmpTextHireDateEnd = request.getParameter("deptEmpTextHireDateEnd");
	
	/* System.out.println(employeesTextEmpNo + "TextEmpNo");						// ""
	System.out.println(employeesRadioGender + "RadioGender");					// null
	System.out.println(employeesTextFirstName + "TextFirstName");				// ""
	System.out.println(employeesTextLastName + "TextLastName");					// ""
	System.out.println(deptEmpTextBrithDateStart + "TextBirthDateStart");		// ""
	System.out.println(deptEmpTextBrithDateEnd + "TextBirthDateEnd");			// ""
	System.out.println(deptEmpTextHireDateStart + "TextHireDateStart");			// ""
	System.out.println(deptEmpTextHireDateEnd + "TextHireDateEnd");				// "" */
	
	
	String redirectValue = "";
	
	
	
	int selectCount = 0;
	
	
	//EmpNo 검색 안함
	if(employeesCheckBoxEmpNo != null && employeesCheckBoxEmpNo != ""){
		redirectValue += "selectEmpNo=" + employeesTextEmpNo + "&";
		selectCount = selectCount + 1;
	}	 
	
	//Gender 검색 안함	
	if(employeesCheckBoxGender != null && employeesCheckBoxGender != ""){
		redirectValue += "selectGender=" + employeesRadioGender + "&";
		selectCount = selectCount + 1;
	}
	
	//FirstName 검색 안함
	if(employeesCheckBoxFirstName != null && employeesCheckBoxFirstName != ""){
		redirectValue += "selectFirstName=" + employeesTextFirstName + "&";
		selectCount = selectCount + 1;
	}
	
	//LastName 검색 안함
	if(employeesCheckBoxLastName != null && employeesCheckBoxLastName != ""){
		redirectValue += "selectLastName=" + employeesTextLastName + "&";
		selectCount = selectCount + 1;
	}

	//BirthDate 검색
	if(employeesCheckBoxBirthDate != null && employeesCheckBoxBirthDate != ""){
		//FromDate 시작일 검색
	
		if(deptEmpTextBrithDateStart == ""){
			redirectValue += "selectBirthDateStart=0000-00-00&";			
		}else{
			if(deptEmpTextBrithDateStart.length() == 4){
				redirectValue += "selectBirthDateStart=" + deptEmpTextBrithDateStart + "-00-00&";	
			}else{
				redirectValue += "selectBirthDateStart=0000-00-00&";	
			}
			
		}	
		
			
				
		
		if(deptEmpTextBrithDateEnd == ""){
			redirectValue += "selectBirthDateEnd=9999-12-31&";
		}else{
			if(deptEmpTextBrithDateEnd.length() == 4){
				redirectValue += "selectBirthDateEnd=" + deptEmpTextBrithDateEnd + "-12-31&";	
			}else{
				redirectValue += "selectBirthDateEnd=9999-12-31&";	
			}
			
		}	
		
	
		selectCount = selectCount + 1;
	}
	
	
	
	//HireDate 검색
	if(employeesCheckBoxHireDate != null && employeesCheckBoxHireDate != ""){
		//FromDate 시작일 검색
	
		if(deptEmpTextHireDateStart == ""){
			redirectValue += "selectHireDateStart=0000-00-00&";			
		}else{
			if(deptEmpTextHireDateStart.length() == 4){
				redirectValue += "selectHireDateStart=" + deptEmpTextHireDateStart + "-00-00&";	
			}else{
				redirectValue += "selectHireDateStart=0000-00-00&";	
			}
			
		}	
		
			
				
		
		if(deptEmpTextHireDateEnd == ""){
			redirectValue += "selectHireDateEnd=9999-12-31&";
		}else{
			if(deptEmpTextHireDateEnd.length() == 4){
				redirectValue += "selectHireDateEnd=" + deptEmpTextHireDateEnd + "-12-31&";	
			}else{
				redirectValue += "selectHireDateEnd=9999-12-31&";	
			}
			
		}	
		
	
		selectCount = selectCount + 1;
	}
	
	
	
	
	if(selectCount > 0) {
		redirectValue += "selectCount=" + selectCount + "&";
	} 
	
	System.out.println(redirectValue);
	
	
	response.sendRedirect(request.getContextPath() + "/employees/employeesList.jsp?" + redirectValue);
%>