<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsAccountService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsAccountServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsAccountBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%
String path = request.getContextPath();

String method = request.getParameter("action");
boolean flag = false;

OsAccountBean bean = new OsAccountBean();
bean = (OsAccountBean)RequestBeanUtils.getValuesByRequest(request,bean);
OsAccountService service = new OsAccountServiceImpl();
if(method.equals("insert")){
	flag = service.insertAccount(bean);
}else if(method.equals("update")){
	flag = service.updateAccount(bean);
}else if(method.equals("delete")){
	String ids = request.getParameter("ids");
	String[] idsArr = ids.split(",");
	if(idsArr.length>0){
		flag = service.deleteAccount(idsArr);
	}
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
			location.href = "<%=path%>/ccapp/xtbg/tjy/account/jsp/officedetaillist.jsp?classify=<%=bean.getClassify()%>&org_id=<%=bean.getLocation_org_id()%>";
		}
	}else{
		parent.alert("²Ù×÷Ê§°Ü")
	}
</script>
</head>
<body>

</body>

</html>
