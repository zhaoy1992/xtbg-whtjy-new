<%-- 
	��������ɫ��Դ��ѯҳ��
	���ߣ�����ƽ
	�汾��1.0
	���ڣ�2013-05-30
 --%>
 
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.resource.ResourceManager"%>



<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);

	String name = (String)request.getParameter("name");
	String type = (String)request.getParameter("type");
    
	//��ѯ��Դ�б�
	List resQueue = null;
	ResourceManager resManager = new ResourceManager();
	resQueue = resManager.getResourceInfos();
	
	request.setAttribute("resList",resQueue);


%>
<html>
	<head>    
 		<title>�û�����Ȩ����Դ��ѯ</title>
		<script language="JavaScript" src="../scripts/common.js" type="text/javascript"></script>		
		<script language="JavaScript" src="../scripts/pager.js" type="text/javascript"></script>
		<SCRIPT language="javascript">
		
		function sub(){
			userreslist.action="roleres_querylist.jsp?restypeId="
				+ document.all("resourcetype").value + "&resId="
				+ document.all("resId").value + "&opId="
				+ document.all("operategroup").value+ "&resName="
				+ document.all("resName").value ;
				
			userreslist.submit();
		}
		
		function getOperateType(id){
				getopergroup.location.href = "resChange.jsp?restypeId="+id;
		}
		</SCRIPT>
		<link href="../css/windows.css" rel="stylesheet" type="text/css">
		<link href="../css/treeview.css" rel="stylesheet" type="text/css">
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
			<input type="hidden" name="name" value="<%=name%>">
			<input type="hidden" name="type" value="<%=type%>">
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