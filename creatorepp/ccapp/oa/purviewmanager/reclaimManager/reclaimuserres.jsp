<%--
�������˵���Ȩҳ��
���ߣ�����ƽ
�汾��1.0
ʱ�䣺2013-5-30
 --%>
<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.config.ConfigManager,
                 com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl,
                 com.chinacreator.sysmgrcore.purviewmanager.PurviewManager"%>
<%@ page import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.api.UserCheckOrgFactory"%>   
<!-- ����jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- �������� -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>              
<%
    AccessControl control = AccessControl.getInstance();
   	control.checkManagerAccess(request,response);
    String userIds =  request.getParameter("userIds") == null ? "":request.getParameter("userIds");
    PurviewManager manager = new PurviewManagerImpl();
    String userNames = manager.getUserNamesByUserIds(userIds);
    String orgId = request.getParameter("orgId");
    
	//���α�����û�  ��ʢ 2011-3-10
	StringBuffer secondUserName = new StringBuffer();
	boolean isSecondUser = UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUserByOrgIDToMess(userIds,orgId,secondUserName);
%>
<html>
	<head>
		<title>�����û���<%=userNames%>��Ȩ��</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/treeview.css">
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onload="init()">
		<br>
		<form name="form1" method="post" target="hiddenFrame" >
		<input type="hidden" name="userIds" value="<%=userIds%>">
		<fieldset>
		<legend class="td"><font size="2">�����û���<%=userNames%>��Ȩ��</font></legend>	
				<br>
				<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% >
					<tr align="left">
					    <td class="td"><b>��ѡ����ӦȨ�޽��л���:</b></td>				    
					</tr>
					<tr>
					    <td></td>				    
					</tr>
				</table>
				<table cellspacing="1" cellpadding="0" border="0" align="center"  bordercolor="#EEEEEE" width=80% >					
					<tr>
					    <td class="td"><input type="checkbox" name="directRes" value="directRes">ֱ�������û���Ȩ��</td>
					</tr>
					<tr>
					    <td class="td"><input type="checkbox" name="userRoleRes" value="userRoleRes">�û��Ľ�ɫȨ��</td>				    
					</tr>
					<% 
						if(ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction",false)){
					%>  
					<tr>
					    <td class="td"><input type="checkbox" name="userOrgJobRes" value="userOrgJobRes">�û��Ļ�����λȨ��</td>				    
					</tr>
					<% 
						}
					%>
					<% 
						if(ConfigManager.getInstance().getConfigBooleanValue("enablergrouprole",false)){
					%>
					<tr>
					    <td class="td"><input type="checkbox" name="userGroupRes" value="userGroupRes">�û��������û���Ȩ��</td>				    
					</tr>				
					<% 
						}
					%>
				</table>
				<br>			
		</fieldset>
		<br>
		<fieldset>
		<legend><font size="2">������</font></legend>
		<table cellspacing="1" cellpadding="0" border="0" align="center"  bordercolor="#EEEEEE" width=50% >					
			<tr>
			    <td class="td"><input type="button" class="input" value="����" onclick="reclaim()">
			    &nbsp;&nbsp;&nbsp;&nbsp;
			    <input type="button" class="input" value="�ر�" onclick="removeAlertWindows('',true)">
			</td>
			</tr>			
		</table>
		<br>
		</fieldset>
		</form>
	</body>
	<script language="javascript">
		function init(){
			if("<%=isSecondUser%>"=="true"){
				alert("������û��ڸû����²��ܱ������ɫ��<%=secondUserName%>");
				window.close();
			}
		}
	
	    function reclaim(){
	        var directRes = "";
	        var userRoleRes = "";
	        var userOrgJobRes = "";	   
	        var userGroupRes = "";//�û����û���Ȩ��     
	        if(document.all.userRoleRes && document.all.userRoleRes.checked){
	            directRes = document.all.userRoleRes.value;
	        }
	        if(document.all.directRes && document.all.directRes.checked){
	            userRoleRes = document.all.directRes.value;
	        }
	        if(document.all.userOrgJobRes && document.all.userOrgJobRes.checked){
	            userOrgJobRes = document.all.userOrgJobRes.value;
	        }
	        if(document.all.userGroupRes && document.all.userGroupRes.checked){
	        	userGroupRes = document.all.userGroupRes.value;
	        }
	        if(directRes == "" && userRoleRes == "" && userOrgJobRes == "" && userGroupRes == ""){
	            alert("û��ѡ������κ�Ȩ��!");
	            return false;
	        }else{	   
		        document.form1.target = "hiddenFrame";
		        document.form1.action = "reclaimuserres_do.jsp?orgId=<%=orgId%>";
		        document.form1.submit();
	        }
	    }
	</script>
	<iframe id="hiddenFrame" name="hiddenFrame" src="" width=0 height=0></iframe>
</html>
