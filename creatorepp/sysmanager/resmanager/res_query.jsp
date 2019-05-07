<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.config.model.ResourceInfo"%>
<%@ page import="com.chinacreator.security.AccessControl
				,com.chinacreator.config.ConfigManager"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.resource.ResourceManager"%>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);

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
String isUserRes = request.getParameter("isUserRes");//���Ʋ�ѯ��������,Ϊisʱ,��ѯ�û�Ϊ��ǰ�û�
String userName = "";
if("is".equals(isUserRes))
	userName = accesscontroler.getUserAccount();
	
String typeName = request.getParameter("typeName");	
	
%>
<html>
<head>    
 <title>Ȩ����Դ��ѯ</title>
<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">

function isUserRes(){
	var userName = "<%=userName%>";
	userreslist.action="../user/userres_querylist.jsp?opId="+document.all("operategroup").value
						+"&type=user&name="+userName+"&typeName=<%=typeName%>";
	userreslist.submit();
	
}
   
function sub(){
	//���嵱ǰ�����Ķ�����ʾ
	var type = document.all("type").value;
	var typeName ;
	if(type == "user"){
		typeName = "�û�";
	}else if(type == "role"){
		typeName = "��ɫ";
	}else if(type == "org"){
		typeName = "����";
	}else if(type == "job"){
		typeName = "��λ";
	}else if(type == "orgjob"){
		typeName = "������λ";
	}
	if(document.userreslist.name.length == 0 || document.userreslist.name.value == "") 
	{
		alert("������" + typeName + "����!");
		document.userreslist.name.focus();	
		return false;	
	}
	
	//document.all.currentname.innerHTML = "��ǰ��ѯ��<B>"+typeName+"</B>Ϊ��"+document.all.name.value;
	if(typeName=="�û�"){
		typeName = "USER";
	}
	userreslist.action="../user/userres_querylist.jsp?opId="+document.all("operategroup").value+"&typeName="+typeName;
	userreslist.submit();
}

function del(){
	var type = document.all("type").value;
	delop.location.href = "../resmanager/delRedundance.jsp?type="+type;
 	var typeName ;
	if(type == "user"){
		typeName = "�û�";
	}else if(type == "role"){
		typeName = "��ɫ";
	}else if(type == "org"){
		typeName = "����";
	}else if(type == "job"){
		typeName = "��λ";
	}else if(type == "orgjob"){
		typeName = "������λ";
	}
	alert("ɾ��"+typeName+"����ɹ���"); 
}

function getOperateType(){
		getopergroup.location.href = "../user/resChange.jsp?restypeId="+document.all.restypeId.value;
}

function change(){
	document.all.typename.innerText = document.all.type.options[document.all.type.selectedIndex].text+"����*��";
	document.all.name.value = "";
	document.all.name.title = "������F1ѡ��"+document.all.type.options[document.all.type.selectedIndex].text;
	if(document.all.type.value == "orgjob")
	{
		document.all.name.readonly = true;
	}
	else
	{
		document.all.name.readonly = false;
	}
}

function chooseorgjob()
{
	if(document.all.type.value == "orgjob")
	{
		var orgjob = document.all.orgjob.value;
		orgjob = orgjob.split(":");
		var returnValue = window.showModalDialog('../resmanager/orgJobTree.jsp?defaultValue='+orgjob,'newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')
		if(returnValue){
			document.all.name.value = returnValue.substring(0,returnValue.indexOf(","));
			document.all.orgjob.value = returnValue.substring(returnValue.indexOf(",")+1,returnValue.length);
		}
	}
	if(document.all.type.value == "user")
	{
		var returnValue = window.showModalDialog('../resmanager/orgUserTree.jsp',window,'scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')
		if(returnValue){
			document.all.name.value = returnValue;
		}
	}
	if(document.all.type.value == "role")
	{
		var returnValue = window.showModalDialog('../resmanager/roleTree.jsp','newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')
		
		if(returnValue){
			document.all.name.value = returnValue;
		}
	}
	if(document.all.type.value == "org")
	{
		var orgNames = document.all.name.value; 
		var returnValue = window.showModalDialog('../resmanager/orgSelectTree.jsp?orgNames='+orgNames,'newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250')
		if(returnValue){
			document.all.name.value = returnValue.split("^")[0];
		}
	}
	
}

//F1
function window.onhelp(){  
  chooseorgjob();
  return false;
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
<% if("is".equals(isUserRes)){ %>
	<%@ include file="/epp/css/cssControl.jsp"%><body  scrolling="no" onLoad="isUserRes()">
<% }else{ %>
	<%@ include file="/epp/css/cssControl.jsp"%><body  scrolling="no" onLoad="change()">
<% } %>
<div id="contentborder" valign="top" align="center" >
	<form name = "userreslist" method="post" target="forDocList">
		<table width="100%" border="0"   cellpadding="0" cellspacing="0" class="thin">
		<% if("no".equals(isUserRes)){ %>
			<tr>
				<td height='20' colspan="1" nowrap align=right width="20%">
					��ѡ��Ҫ��ѯ�Ķ���
				</td>
				<td height='20' colspan="1" nowrap width="20%">
						<select class="select" name="type" id="type" onChange="change()">
							<option value="user">�û�</option>
							<option value="role">��ɫ</option>
							<!-- <option value="job">��λ</option> -->
							<%
							if(ConfigManager.getInstance().getConfigBooleanValue("enableorgrole", true))
							{
							%>
							<option value="org">����</option>
							<%
							}
							%>
							<%
							if(ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction", true))
							{
							%>
							<option value="orgjob">������λ</option>
							<%
							}
							%>
						</select>
				</td>
				<td height='20' colspan="2" nowrap align=center width="40%">
					<table border="0" height="100%" cellpadding="0" cellspacing="0" width="100%">
						<tr>
							<td height="20" width="50%" align=right ><div name="typename" id="typename" style="width:100"></div></td>
							<td height="20" width="100%" >
								<input type="text" name="name" width="100%" id="name" readonly="true" onclick="chooseorgjob()" title="������F1ѡ���û�" >
								<input name="orgjob" type="hidden" value="" >
							</td>
						</tr>
					</table>				
			    </td>
				<!-- <td align=center width="20%">
					<div id="currentname" name="currentname"></div>
				</td> -->
				<td align=center width="20%">
				<% 
					if(ConfigManager.getInstance().getConfigBooleanValue("enablerresmanaer", false))
					{
				%>
				��Դ���<select class="select" name="auto" id="auto">
				      	<option value="">--��Դ���--</option>
						<option value="0">ϵͳ��Դ</option>
						<option value="1">�Զ�����Դ</option>
					</select>
				<%} %>
				</td>
			</tr>
		<% } %>
			<tr>
				<td height='20' align=right width="20%">
					��Դ��ʶ��
				</td>
				<td height='20' width="20%">
					<input type="text" name="resId"  />
				</td>
				<td height='20' align=right width="20%">
					��Դ���ƣ�
				</td>
				<td height='20' width="20%">
					<input type="text" name="resName"/>
				</td>
				<td height='20' colspan="2" align=center width="20%" >
					<!-- <input type="button" value="ɾ������" class="input" onClick="del()"/> -->
				</td>
			</tr>
			<tr>
					<td align=right width="20%">
					��Դ���ͣ�
					</td>
					<td width="20%">
				    <select class="select" id="restypeId" name="restypeId" onChange="getOperateType()">
				      	<option value="">--��ѡ��--</option>
				      	<pg:list requestKey="resList" needClear="false">
				      		
						    	<option value="<pg:cell colName="id"/>">
						        	<pg:cell colName="name"/>
								</option>
							
						</pg:list>
					</select>
					</td>
					<td height='20' align=right width="20%">
					�������ͣ�
					</td>
					<td width="20%">
					<select class="select" name="operategroup" id="operategroup">
				      	<option value="">--��ѡ��--</option>
						
					</select>
				</td>
				<td colspan="2" align=center width="20%">
				<% if("is".equals(isUserRes)){ %>
					<input name="search" type="button" class="input" value="��ѯ" onClick="isUserRes()">
				<% }else{ %>
					<input name="search" type="button" class="input" value="��ѯ" onClick="sub()">
				<% } %>
					<input name="reset" type="reset" class="input" value="����">
				</td>
		  </tr>
		</table>
	</form>
</div>
<iframe id="getopergroup" src="" border="0" height="0" width="0"></iframe>
<iframe id="delop" src="" border="0" height="0" width="0"></iframe>
</body>

</html>