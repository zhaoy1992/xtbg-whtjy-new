<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountManagerBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountManageService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAccountManageServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountBean"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAccountServiceImpl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultMap"%>
<%@page import="com.chinacreator.xtbg.core.common.util.ResultCode"%>
<%
	String path = request.getContextPath();
	
	String method = request.getParameter("method");
	
	OsAccountManagerBean bean = new OsAccountManagerBean();
	bean = (OsAccountManagerBean)RequestBeanUtils.getValuesByRequest(request,bean); 
	bean.setOrg_id(DaoUtil.sqlToField("select org_id from td_sm_organization where org_name = '"+bean.getOrg_name()+"'"));
		
	OsAccountManageService service = new OsAccountManageServiceImpl();
	//搜索选固资用
	OsAccountBean accountBean = new OsAccountBean();
	OsAccountService accountService = new OsAccountServiceImpl();
	
	boolean flag = false;
	if(method.equals("insert")){
		flag = service.insertManager(bean,request);
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
<script type="text/javascript">
	var flag = "<%=flag%>";
	var method = "<%=method%>";
	if(flag){
		if(method == "delete"){
			parent.userSearch();
		}else{
			location.href = "<%=path%>/ccapp/xtbg/tjy/account/jsp/officeaccountmanagelist.jsp";
		}
	}else{
		parent.alert("操作失败")
	}
</script>
</head>
<body>

</body>

</html>