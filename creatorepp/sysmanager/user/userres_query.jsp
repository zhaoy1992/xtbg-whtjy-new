<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="com.chinacreator.config.model.ResourceInfo"%>
<%@ page import="com.chinacreator.config.ResourceInfoQueue"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.ResManager"%>
<%@ page import="com.chinacreator.config.model.Operation,
				com.chinacreator.config.ConfigManager"%>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);

String userId = (String)request.getParameter("userId");
String orgId = (String)request.getParameter("orgId");
String typeName = (String)request.getParameter("typeName");

//��ѯ��Դ�б�
List resQueue = null;
ResourceManager resManager = new ResourceManager();
resQueue = resManager.getResourceInfos();
 for(int i = 0; i < resQueue.size(); i ++)
        {
            ResourceInfo res = (ResourceInfo)resQueue.get(i);
            if(!res.isUsed())
                continue;
            String listId = res.getId();
            String listName = res.getName();
		 }
request.setAttribute("resList",resQueue);


%>
<html>
<head>    
 <title>�û�����Ȩ����Դ��ѯ</title>
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">

function sub(){
	var auto = "";
	if(document.all("auto")){
		auto = document.all("auto").value;
	}
	userreslist.action="userres_querylist.jsp?restypeId="+document.all("resourcetype").value+"&resId="+
		document.all("resId").value+"&opId="+document.all("operategroup").value+
		"&resName="+document.all("resName").value+"&typeName=<%=typeName%>&auto="+auto;
	userreslist.submit();
}

function getOperateType(id){
		getopergroup.location.href = "../user/resChange.jsp?restypeId="+id;
}
</SCRIPT>
<link href="../css/windows.css" rel="stylesheet" type="text/css">
<style>

body{
    SCROLLBAR-HIGHLIGHT-COLOR: #ffffff;
	SCROLLBAR-SHADOW-COLOR: #ffffff;
	SCROLLBAR-3DLIGHT-COLOR: #ffffff;
	SCROLLBAR-ARROW-COLOR: #ffffff;
	SCROLLBAR-TRACK-COLOR: #ffffff;
	SCROLLBAR-DARKSHADOW-COLOR: #ffffff;
	SCROLLBAR-FACE-COLOR: #ffffff;	
}
</style>
</head>

<%@ include file="/epp/css/cssControl.jsp"%><body  scrolling="no">
<div id="contentborder" valign="top" align="center" >
	<form name = "userreslist" method="post" target="forDocList">
	<input type="hidden" name="userId" value="<%=userId%>">
	<input type="hidden" name="orgId" value="<%=orgId%>">

		<table width="100%" border="0"   cellpadding="0" cellspacing="0" class="thin">
			<tr>
				<td height='20'>
					��Դ��ʶ��<input type="text" name="resId" size="15"/>
					��Դ���ƣ�<input type="text" name="resName" size="15"/>
				    <select class="select" id="resourcetype" name="resourcetype" onchange="getOperateType(this.options[this.selectedIndex].value)">
				      	<option value="">--��ѡ����Դ����--</option>
				      	<pg:list requestKey="resList" needClear="false">
						    	<option value="<pg:cell colName="id"/>">
						        	<pg:cell colName="name"/>
								</option>
						</pg:list>
					</select>
					<select class="select" name="operategroup" id="operategroup">
				      	<option value="">--��ѡ����Դ����--</option>
						
					</select>
					<% 
					if(ConfigManager.getInstance().getConfigBooleanValue("enablerresmanaer", false))
					{
					%>
					<select class="select" name="auto" id="auto">
				      	<option value="">--��Դ���--</option>
						<option value="0">ϵͳ��Դ</option>
						<option value="1">�Զ�����Դ</option>
					</select>
					<% 
					}
					%>
				</td>
				<td>
					<input name="search" type="button" class="input" value="��ѯ" onClick="sub()">
					<input name="reset" type="reset" class="input" value="����">
				</td>
				</tr>
		</table>	
	</form>	
</div>
<iframe id="getopergroup" src="" border="0" height="0" width="0"></iframe>
</body>

</html>