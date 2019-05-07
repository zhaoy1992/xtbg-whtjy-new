<%-- 
	描述：机构人员配置页面
	作者：黄艺平
	版本：1.0
	日期：2013-07-24
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
	String orgId = request.getParameter("orgId");
	List<Map<String, String>> listMap = new ArrayList<Map<String, String>>();
	List<Map<String, String>> userBeanListMap = new ArrayList<Map<String, String>>();
	DataResourcesServiceIfc dataResourcesServiceIfc = new DataResourcesServiceImpl();
	listMap = dataResourcesServiceIfc.getDataResourcesBeanMap();
	
	userBeanListMap = dataResourcesServiceIfc.getUserBeanMap(orgId);
	Map<String, String> dataResourcesMap = null;
	Map<String, String> userBeanMap = null;
	
	List<String> resourceIdList = new ArrayList<String>();
	List<String> boxlist=new ArrayList<String>();
	boxlist = dataResourcesServiceIfc.getChooseOrgUser(orgId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.security.AccessControl"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.core.dataresources.service.DataResourcesServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.dataresources.service.impl.DataResourcesServiceImpl"%>
<%@page import="java.util.HashMap"%><html>
<head>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>

<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-remote.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-treetools.js"></script>

<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/js/orgresourceconfig.js" ></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>资源配置列表</title>

</head>
<body >
	<div class="orgpzscroll" id="maindiv" >
		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="content_02_box_div">
		<table class="content_02_box_div_table_02" >
			<tr align="center">
				<td width="120px" ></td>
				<%
					for (int i = 0; i < listMap.size(); i++) {
						dataResourcesMap = new HashMap<String, String>();
						dataResourcesMap = listMap.get(i);
						resourceIdList.add(dataResourcesMap.get("resources_id"));
				%>
				<td width="140px"><%=dataResourcesMap.get("resources_name")%></td>
				<%
					}
				%>
			</tr>
			<%
					for (int j = 0; j < userBeanListMap.size(); j++) {
						userBeanMap = new HashMap<String, String>();
						userBeanMap = userBeanListMap.get(j);
			%>
			<tr>
				<td><%=userBeanMap.get("user_realname")%></td>
				<%
					for (int k = 0; k < listMap.size(); k++) {
						dataResourcesMap = new HashMap<String, String>();
						dataResourcesMap = listMap.get(k);
				%>
				<td align="center"><input type="checkbox" id="<%=userBeanMap.get("user_id")%><%=dataResourcesMap.get("resources_id")%>" name="<%=dataResourcesMap.get("resources_id")%>" value="<%=userBeanMap.get("user_id")%>" ></input></td>
				<%
					}
				%>
			</tr>
			<%
					}
				
			%>
		</table>
		<input type="button" id="save" value="保存" class="but_y_01 user_oper" onclick="save()">
		<input type="button" id="clear" value="清除所有" class="but_y_01 user_oper" onclick="clearAll()">
		</div>
		
		<form id="form1" name="form1" method="post" action="">
			<input id="boxvalue" name="boxvalue" value="" type="hidden" ></input>
			<input id="orgId" name="orgId" value="" type="hidden" ></input>
		</form>
		<iframe name="hiddenFrame" width="0" height="0"></iframe>
	</div>

</body>
<script type="text/javascript">
var resourceIdList = <%=resourceIdList %>;
var boxlist = <%=boxlist %>;
var orgId = "<%=orgId%>";
</script>
</html>