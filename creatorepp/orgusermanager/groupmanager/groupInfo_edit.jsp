<%
/*
 * <p>Title: �û����޸�ҳ��</p>
 * <p>Description: ���û�����Ϣ�����޸�</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%

	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);


	String groupId = (String) request.getParameter("groupId");
	String groupName="";
	String groupDesc="";
	String parentId="0";
	
	String userName="";
	String userRealName="";

	if(groupId != null && !"".equals(groupId))
	{
		//������ID��ȡ��ǰ��ѡ��Ļ�����Ϣ
		GroupManager groupManager=SecurityDatabase.getGroupManager();
		UserManager userManager=SecurityDatabase.getUserManager();
		Group group=groupManager.getGroupByID(groupId);
		if(group != null)
		{
			groupName=group.getGroupName();
			groupDesc=group.getGroupDesc();
			parentId=group.getParentId()+"";
			
			String groupOwnerId=String.valueOf(group.getOwner_id());
			User user=userManager.getUserById(groupOwnerId);
			userName=user.getUserName();
			userRealName=user.getUserRealname();			
		}
	}
	else
	{
		groupId="";
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>��<%=groupName%>���û��������Ϣ</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
	   <link rel="stylesheet" type="text/css" href="../css/treeview.css">

		<script language="javascript">	 		  
         
       
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
			
			document.all.divProcessing.style.display = "block";
			document.all.SaveButton.disabled = true;
	        document.all.BackButton.disabled = true;
	        
	        
			groupForm.action= "submitGroup.jsp?flag=2";
			groupForm.target="submitGroup";
			groupForm.submit(); 
		  } 
		 
		  //�����ʼ������
          function initial()
          {
            document.all.groupId.value='<%=groupId%>';
            document.all.parentId.value='<%=parentId%>';
          	document.all.groupName.value='<%=groupName%>';
          	document.all.oldGroupName.value='<%=groupName%>';
            document.all.groupDesc.value='<%=groupDesc%>';      	 
          }
          
          function back()
          {
          	window.returnValue = true;
          	window.close();
          }
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body  onload="initial()" scroll="no">
	        <iframe src="" name="submitGroup" style="display:none"></iframe>
			<form action="" id="groupForm" method="post">
				<table width="100%" height="25" border="0" cellpadding="2" cellspacing="0" class="thin">
					<tr>
					<td colspan="2"><strong>&nbsp;�û��������Ϣ</strong></td>
					</tr>
					<tr>
						<td width="16%" height="25" class="detailtitle">
							<P align="center">
								<STRONG>�û������ƣ�</STRONG>
							</P>
						</td>
						<td width="907" height="25">
							<input name="groupName" type="text" readonly style="width=50%" maxlength="100"/>
						</td>
					</tr>
					<tr>
						<td height="25" class="detailtitle">
							<P align="center">
								<STRONG>�û���˵��*��</STRONG>
							</P>
						</td>
						<td height="25">
							<textarea name="groupDesc" rows="4" cols="50" ></textarea>
						</td>
					</tr>
					<tr>
					<td width="16%" height="25" class="detailtitle">
						<P align="center">
							��������Ϣ��
						</P>
					</td>
					<td width="907" height="25">
						<input name="creatorName" id="creatorName" type="text" value="<%=userName%>��<%=userRealName%>��" style="width=50%" maxlength="100" disabled=true/>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="2" >
					<tr>
						<td>
							<table width="60%" border="0" align="center" cellpadding="0" cellspacing="0">
								<tr>
									<td align="center">
									 <br>
										<input type="button" name="SaveButton" class="input" value="����" onclick="saveGroup();" />
										&nbsp;&nbsp;
										<input type="button" name="BackButton" class="input" value="����" onclick="back()"/>
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
		
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:200px;top:260px;display:none">
			<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...������...��ȴ�...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>