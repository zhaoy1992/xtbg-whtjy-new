<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsHavaObjectBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsKucunService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsKucunServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsUserTypeItemService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsUserTypeItemServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.entity.OsuserTypeItemBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%
String path = request.getContextPath();
String actionName = request.getParameter("actionName");
OsHavaObjectBean bean = new OsHavaObjectBean();
bean = (OsHavaObjectBean)RequestBeanUtils.getValuesByRequest(request,bean);

OsKucunService service = new OsKucunServiceImpl();
OsUserTypeItemService itemService = new OsUserTypeItemServiceImpl();
boolean flag = false;
if(actionName.equals("insert")){
	bean.setT_ha_id(DaoUtil.getUUID());//���id
	flag = service.insert(bean);
}else if(actionName.equals("update")){
	flag = service.update(bean);
}else if(actionName.equals("delete")){
	String ids = request.getParameter("ids");//���id
	String it_ids = request.getParameter("it_ids");//���id
	flag = service.delete(ids,it_ids);
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
<script type="text/javascript">
	var flag = "<%=flag%>";
	var actionName = "<%=actionName%>";
	if(flag){
		if(actionName == "delete"){
			parent.userSearch();
		}
	}else{
		parent.alert("����ʧ��")
	}
</script>
</head>
<body>

</body>

</html>
