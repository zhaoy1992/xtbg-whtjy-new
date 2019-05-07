<%
/*
 * <p>Title: ������Դ��ѯҳ��</p>
 * <p>Description: ������Դ��ѯҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-26
 * @author liangbing.tao
 * @version 1.0
 *
 */
 %>
 
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.resource.ResourceManager,
				com.chinacreator.config.ConfigManager"%>



<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);

	String userId = (String)request.getParameter("userId");
	String orgId = (String)request.getParameter("orgId");
	String typeName = (String)request.getParameter("typeName");

	//��ѯ��Դ�б�
	List resQueue = null;
	ResourceManager resManager = new ResourceManager();
	resQueue = resManager.getResourceInfos();
	
	request.setAttribute("resList",resQueue);

	// Ȩ���Ƿ��������
	// ��ʢ 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);

%>
<html>
	<head>    
 		<title>�û�����Ȩ����Դ��ѯ</title>
		<script language="JavaScript" src="../../scripts/common.js" type="text/javascript"></script>		
		<script language="JavaScript" src="../../scripts/pager.js" type="text/javascript"></script>
		<SCRIPT language="javascript">
		
		function sub(){
			if("<%=isrolerelatedorg%>"=="true"){
				userreslist.action="userres_querylist.jsp?restypeId="
					+ document.all("resourcetype").value + "&resId="
					+ document.all("resId").value + "&opId="
					+ document.all("operategroup").value+ "&resName="
					+ document.all("resName").value + "&typeName=<%=typeName%>"
					+ document.all("isCurrOrg").value;
			}else{
				userreslist.action="userres_querylist.jsp?restypeId="
					+ document.all("resourcetype").value + "&resId="
					+ document.all("resId").value + "&opId="
					+ document.all("operategroup").value+ "&resName="
					+ document.all("resName").value + "&typeName=<%=typeName%>";
			}
				
			userreslist.submit();
		}
		
		function getOperateType(id){
				getopergroup.location.href = "resChange.jsp?restypeId="+id;
		}
		</SCRIPT>
		<link href="../../css/windows.css" rel="stylesheet" type="text/css">
		<link href="../../css/treeview.css" rel="stylesheet" type="text/css">
		<style>
			body
			{
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
							if(isrolerelatedorg){
							%>
							<select class="select" name="isCurrOrg" id="isCurrOrg">						      	
								<option value="false">����Ȩ��</option>
								<option value="true">��ǰ������Ȩ��</option>
							</select>
							<%} %>
						</td>
						<td>
							<input name="search" type="button" class="input" value="��ѯ" onClick="sub()">
							<input name="reset" type="reset" class="input" value="���">
						</td>
						</tr>
				</table>	
			</form>	
		</div>
	<iframe id="getopergroup" src="" border="0" height="0" width="0"></iframe>
	</body>

</html>