<%@page import="com.ibm.db2.jcc.a.b"%>
<%@page
	import="com.chinacreator.eform.util.PLSQL3jParser.literal_return"%>
<%@page import="java.util.ArrayList"%>
<%@page
	import="com.chinacreator.xtbg.pub.tree.entity.ResourceConfigBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();

	IOrgManagerExt om = new OrgManagerExtImpl();

	List<UserOrgStatusBean> orglist = om.getCurrentOrg(userId);
	for(UserOrgStatusBean uosbean : orglist){
		System.out.println(om.isCurOrgManager(uosbean.getOrgID(),userId));
	}
	

	//获得orgid
	String orgId = request.getParameter("orgId");
	List<ResourceConfigBean> list = new ArrayList<ResourceConfigBean>();
	List resourceIdList = new ArrayList();
	List resourceNameList = new ArrayList();
	List userIdList = new ArrayList();
	List userNameList = new ArrayList();
	List boxlist=new ArrayList();
	ResourceConfigServiceIfc rIfc = new ResourceConfigServiceImpl();
	list = rIfc.queryRescource();
	for (int i = 0; i < list.size(); i++) {
		ResourceConfigBean resourceConfigBean = new ResourceConfigBean();
		resourceConfigBean = (ResourceConfigBean) list.get(i);
		resourceIdList.add(resourceConfigBean.getResources_id());
		resourceNameList.add(resourceConfigBean.getResources_name());
	}
	if (orgId != null) {
		list = rIfc.queryUserId(orgId);
		for (int i = 0; i < list.size(); i++) {
			ResourceConfigBean resourceConfigBean = new ResourceConfigBean();
			resourceConfigBean = (ResourceConfigBean) list.get(i);
			userIdList.add(resourceConfigBean.getUserid());
			userNameList.add(resourceConfigBean.getUsername());
		}
		boxlist=rIfc.backchoose(resourceIdList, orgId);
	}
	//System.out.println(orgId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page
	import="com.chinacreator.xtbg.pub.tree.service.ResourceConfigServiceIfc"%>
<%@page
	import="com.chinacreator.xtbg.pub.tree.service.impl.ResourceConfigServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.List"%>

<%@page import="com.chinacreator.sysmgrcore.entity.Organization"%>
<%@page import="org.frameworkset.spi.BaseSPIManager"%>
<%@page import="com.chinacreator.sysmgrcoreext.manager.IOrgManagerExt"%>
<%@page import="com.chinacreator.sysmgrcoreext.manager.db.OrgManagerExtImpl"%>
<%@page import="com.chinacreator.sysmgrcoreext.manager.bean.UserOrgStatusBean"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>资源配置列表</title>
<!-- 引入其它 -->

</head>
<body >
<input type="hidden" class="initload" submitKey="select" actionId="resouceConfig" methodName="initResourceConfig" successful="initsucessful"/>
	<div class="orgpzscroll" id="maindiv" >
		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="content_02_box_div">
		<table class="content_02_box_div_table_02" >
			<tr align="center">
				<td width="120px" ></td>
				<%
					for (int i = 0; i < resourceIdList.size(); i++) {
				%>
				<td width="140px"><%=resourceNameList.get(i)%></td>
				<%
					}
					;
				%>
			</tr>
			<%
				if (userIdList.size() != 0) {
					for (int i = 0; i < userIdList.size(); i++) {
			%>
			<tr>
				<td><%=userNameList.get(i)%></td>
				<%
					for (int j = 0; j < resourceIdList.size(); j++) {
				%>
				<td align="center"><input type="checkbox"  id="<%=userIdList.get(i)%><%=resourceIdList.get(j)%>" name="<%=resourceIdList.get(j)%>" value="<%=userIdList.get(i)%>" ></input></td>
				<%
					}
				%>
			</tr>
			<%
					}
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
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-remote.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-treetools.js"></script>

<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.exedit-3.0.js"></script>
<script type="text/javascript" src="../resources/js/orgresourceconfig.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<script type="text/javascript">

var resourceIdList = <%=resourceIdList%>;
var boxlist = <%=boxlist%>;
var orgId = "<%=orgId%>";
$(function(){
	$("#maindiv").attr("style","height:"+($(parent).height()*1-9)+"px")
})

</script>
</html>