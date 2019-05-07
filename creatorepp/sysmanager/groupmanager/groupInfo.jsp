<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.GroupManagerImpl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%

	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(pageContext);

	//String parentId = (String) request.getAttribute("parentId");
	String groupId = (String) request.getParameter("groupId");
	String groupName="",groupDesc="",parentId="0";
	if(groupId!=null)
	{
		//������ID��ȡ��ǰ��ѡ��Ļ�����Ϣ
		GroupManager groupManager=SecurityDatabase.getGroupManager();
		Group group=groupManager.getGroupByID(groupId);
		if(group!=null)
		{
			groupName=group.getGroupName();
			groupDesc=group.getGroupDesc();
			parentId=group.getParentId()+"";
		}
	}
	else
	{
		groupId="-1";
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>�û��������Ϣ</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="sysmanager/css/tab.winclassic.css">

		<script language="javascript">	 		  
          //if("<%=groupId%>"!=""){
          	//getNavigatorContent().location.href ="groupTree.jsp?collapse=<%=parentId%>&request_scope=request&selectedNode=<%=groupId%>";
          //}
          //�½��û���
		  function editGroup() 
		  {
		  	getPropertiesContent().location.href="groupInfo_edit.jsp?groupId=" + <%=groupId%>;
		  }
		  //�����û���
		  function saveGroup() 
		  {
		    var submitFlag=0;
			if(groupForm.groupName.value == "" || groupForm.groupName.value.length<1 || groupForm.groupName.value.replace(/\s/g,"")=="" || groupForm.groupDesc.value == "" || groupForm.groupDesc.value.length<1 || groupForm.groupName.value.replace(/\s/g,"")=="")
			{
				alert("��*Ϊ������");
				return false;
			}
			if(groupForm.parentId.value == "null" || groupForm.parentId.value.length<1)
			{
				alert("���������ѡ����");
				return false;
			}
			var gn = groupForm.groupName.value;
			var gd = groupForm.groupDesc.value;
			if(gn.search(/[\\\/\|:\*\?<>"']/g)!=-1)
			{
				alert("�����Ʋ�����\\/|:*?<>\"'!�������ַ�");
				return false;
			}
			if(gd.search(/[\\\/\|:\*\?<>"']/g)!=-1)
			{
				alert("������������\\/|:*?<>\"'!�������ַ�");
				return false;
			}
			if(gn.length>100)
			{
				alert("�����ƹ���,������100�ַ�����!");
				return false;
			}
			if(gd.length>100)
			{
				alert("����������,������100�ַ�����!");
				return false;
			}
			if(groupForm.groupId.value !="" && groupForm.groupId.value !="0")
			{
				submitFlag=2;
			}
			else
			{
				submitFlag=1;
			}
			groupForm.action= "submitGroup.jsp?flag="+submitFlag;
			groupForm.target="submitGroup";
			groupForm.submit(); 
		  } 
		  //ɾ���û���
		  function delGroup() 
		  {
			if (groupForm.groupId.value != "") 
			{			
				if (window.confirm("ɾ��������ɾ�����鲢�Ҳ��ɻָ�����ȷ��Ҫɾ������û�����")) 
				{				
					groupForm.action= "submitGroup.jsp?flag=3";
					groupForm.target="submitGroup";
					groupForm.submit();
				}
			} 
			else 
			{
				alert("��������ߵ��û����б���ѡ����Ҫɾ������!");
			}
		  }
		  //�����ʼ������
          function initial()
          {
            document.all.groupId.value="<%=groupId%>";
            document.all.parentId.value="<%=parentId%>";
          	document.all.groupName.value="<%=groupName%>";
          	document.all.oldGroupName.value="<%=groupName%>";
            document.all.groupDesc.value="<%=groupDesc%>";      	 
          }
          
          function addsongroup()
          {
          		document.location = "groupInfo_addson.jsp?groupId="+document.all.groupId.value;
          }
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  onload="initial()" >
	<%if(groupId.equals("")){
	%>
	 <table>
	 <tr>
	 <td class="detailtitle">
	 ��ѡ����ߵ����ٽ��в���
	 </td>
	 </tr> 
	<%
	}else{%>
	        <iframe src="" name="submitGroup" style="display:none"></iframe>
			<form action="" id="groupForm" method="post">
				<table width="100%" height="25" border="0" cellpadding="2" cellspacing="0" class="thin">
					<tr>
					<td colspan="2"><strong>&nbsp;�û��������Ϣ</strong></td>
					</tr>
					<tr>
						<td width="16%" height="25" class="detailtitle">
							<P align="center">
								�û������ƣ�
							</P>
						</td>
						<td width="907" height="25">
							<input name="groupName" type="text" style="width=50%" maxlength="100" readonly/>
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							<P align="center">
								�û���˵����
							</P>
						</td>
						<td height="25">
							<textarea name="groupDesc" rows="4" cols="50" readonly></textarea>
						</td>
					</tr>
			</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="2">
					<tr>
						<td>
							<table width="60%" border="0" align="right" cellpadding="0" cellspacing="0">
								<tr>
									<td align="right">
										<%
										if(groupId!="")
										{
										if (accessControl.checkPermission(groupId,
							                       "editgroup", AccessControl.GROUP_RESOURCE))
							            {
										%>
										<input name="newButton" type="button" class="input" value="�޸�" onclick="editGroup();" />
										<%
										 }
										 if (accessControl.checkPermission(groupId,
							                       "deletegroup", AccessControl.GROUP_RESOURCE))
							            {%>
										<input type="button" class="input" value="ɾ��" onclick="delGroup();" />
										<%
										}
										if (accessControl.checkPermission(groupId,
							                       "addsongroup", AccessControl.GROUP_RESOURCE))
							            {
										%>
										<input type="button" class="input" value="��������" onclick="addsongroup();" />
										<%
										}
										}
										%>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<input type="hidden" name="groupId" />
				<input type="hidden" name="parentId" />
				<input type="hidden" name="oldGroupName" />
			</form>
		<%}%>	
	</body>
</html>