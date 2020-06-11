<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	request.setCharacterEncoding("utf-8");
	
	String empDataCheckBoxEmpNo = request.getParameter("empDataCheckBoxEmpNo");
	String empDataCheckBoxGender = request.getParameter("empDataCheckBoxGender");
	String empDataCheckBoxFirstName = request.getParameter("empDataCheckBoxFirstName");
	String empDataCheckBoxLastName = request.getParameter("empDataCheckBoxLastName");
	String empDataCheckBoxDeptName = request.getParameter("empDataCheckBoxDeptName");
	String empDataCheckBoxFromDate = request.getParameter("empDataCheckBoxFromDate");
	String empDataCheckBoxToDate = request.getParameter("empDataCheckBoxToDate");
	
	
	
	String empDataTextEmpNo = request.getParameter("empDataTextEmpNo");
	String empDataTextGender = request.getParameter("empDataRadioGender");
	
	String empDataTextFirstName = request.getParameter("empDataTextFirstName");
	String empDataTextLastName = request.getParameter("empDataTextLastName");
	
	String empDataTextDeptName = request.getParameter("empDataTextDeptName");
	
	String empDataTextFromDateStart = request.getParameter("empDataTextFromDateStart");
	String empDataTextFromDateEnd = request.getParameter("empDataTextFromDateEnd");
	
	String empDataTextToDateStart = request.getParameter("empDataTextToDateStart");
	String empDataTextToDateEnd = request.getParameter("empDataTextToDateEnd");
	
	
	
	String redirectValue = "";
	
	
	int selectCount = 0;
	
	
	//EmpNo 검색 안함
	if(empDataCheckBoxEmpNo != null && empDataCheckBoxEmpNo != ""){
		redirectValue += "selectEmpNo=" + empDataTextEmpNo + "&";
		selectCount = selectCount + 1;
	}
	
	if(empDataCheckBoxGender != null && empDataCheckBoxGender != ""){
		redirectValue += "selectGender=" + empDataTextGender + "&";
		selectCount = selectCount + 1;
	}
	
	if(empDataCheckBoxFirstName != null && empDataCheckBoxFirstName != ""){
		redirectValue += "selectFirstName=" + empDataTextFirstName + "&";
		selectCount = selectCount + 1;
	}
	
	if(empDataCheckBoxLastName != null && empDataCheckBoxLastName != ""){
		redirectValue += "selectLastName=" + empDataTextLastName + "&";
		selectCount = selectCount + 1;
	}
	
	if(empDataCheckBoxDeptName != null && empDataCheckBoxDeptName != ""){
		redirectValue += "selectDeptName=" + empDataTextDeptName + "&";
		selectCount = selectCount + 1;
	}
	
	//FromDate 검색
	if(empDataCheckBoxFromDate != null && empDataCheckBoxFromDate != ""){
		//FromDate 시작일 검색
	
		if(empDataTextFromDateStart == ""){
			redirectValue += "selectFromDateStart=0000-00-00&";			
		}else{
			if(empDataTextFromDateStart.length() == 4){
				redirectValue += "selectFromDateStart=" + empDataTextFromDateStart + "-00-00&";	
			}else{
				redirectValue += "selectFromDateStart=0000-00-00&";	
			}
			
		}	
		
			
				
		
		if(empDataTextFromDateEnd == ""){
			redirectValue += "selectFromDateEnd=9999-12-31&";
		}else{
			if(empDataTextFromDateEnd.length() == 4){
				redirectValue += "selectFromDateEnd=" + empDataTextFromDateEnd + "-12-31&";	
			}else{
				redirectValue += "selectFromDateEnd=9999-12-31&";	
			}
			
		}	
		
	
		selectCount = selectCount + 1;
	}
	
	//ToDate 검색
	if(empDataCheckBoxToDate != null && empDataCheckBoxToDate != ""){
		//FromDate 시작일 검색		
		if(empDataTextToDateStart == ""){
			redirectValue += "selectToDateStart=0000-00-00&";			
		}else{
			if(empDataTextToDateStart.length() == 4){
				redirectValue += "selectToDateStart=" + empDataTextToDateStart + "-00-00&";	
			}else{
				redirectValue += "selectToDateStart=0000-00-00&";	
			}			
		}	
			
				
		
		if(empDataTextToDateEnd == ""){
			redirectValue += "selectToDateEnd=9999-12-31&";
		}else{
			if(empDataTextToDateEnd.length() == 4){
				redirectValue += "selectToDateEnd=" + empDataTextToDateEnd + "-12-31&";	
			}else{
				redirectValue += "selectToDateEnd=9999-12-31&";
			}
			
		}	
				
		
		selectCount = selectCount + 1;
	}
	
	if(selectCount > 0) {
		redirectValue += "selectCount=" + selectCount + "&";
	}
	
	
	//System.out.println(redirectValue);
	
	
	response.sendRedirect(request.getContextPath() + "/empData/empDataList.jsp?" + redirectValue);
	
%>