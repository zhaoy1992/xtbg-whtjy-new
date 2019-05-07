<%--  
描述：人员信息保存
作者：戴连春
版本：1.0
日期：2013-06-13
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.impl.PersonInfoServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.PersonInfoServiceIfc"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>人员信息保存form</title>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String baseinfoJson = request.getParameter("baseinfoJson");
	String phoneVOList = request.getParameter("phoneVOList");
	String foxVOList = request.getParameter("foxVOList");
	String emailVOList = request.getParameter("emailVOList");
	String qqVOList = request.getParameter("qqVOList");
	String birthVOList = request.getParameter("birthVOList");
	String companyVOList = request.getParameter("companyVOList");
	String positionVOList = request.getParameter("positionVOList");
	String addressVOList = request.getParameter("addressVOList");
	String websiteVOList = request.getParameter("websiteVOList");

	//个人通讯录操作的service
	PersonInfoServiceIfc service = new PersonInfoServiceImpl();

	boolean flag = true;
	//保存通讯录人员信息
	String	personId = service.savePersonInfo(baseinfoJson,
				phoneVOList, foxVOList, emailVOList, qqVOList,
				birthVOList, companyVOList, positionVOList,
				addressVOList, websiteVOList);
	if("".equals(personId)){
		flag = false;
	}
%>
</head>
<body>
<script type="text/javascript">

	var mes = "";
	var bool = true;
	//是否操作成功的标记
	var flag = <%=flag%>;
	
	if(flag){
		mes = "操作成功";
	}else{
		mes = "操作失败";
		bool = false;
	}
	
	var OKF = function(){
		if(window.top.removeWindows('',true)){
			window.parent.person_id = '<%=personId%>';
			window.parent.saveBack();//调用父页面的方法
		}
	}
	window.top.alert(mes,{headerText:'提示',okName:'确认',okFunction:OKF});

</script>
</body>
</html>