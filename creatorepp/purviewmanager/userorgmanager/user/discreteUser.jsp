
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkManagerAccess(request,response);

String userId = request.getParameter("userId");
String qstring = request.getParameter("qstring");
String qqstring = qstring;
if(qstring != null){
	qstring = java.net.URLEncoder.encode(qstring);
}
//������û�����session
if(userId != null){
	session.setAttribute("currUserId",Integer.valueOf(userId));
}
if(userId == null){
	session.setAttribute("currUserId",null);
	userId = "";
}
%>
<html>
<head>
<title>��������������</title>
<link rel="stylesheet" type="text/css" href="../css/toolbar.css">

<script language="javascript" src="../scripts/toolbar.js"></script>
<script language="javascript">
function userinfo()
{
	//������Ϣ	
	var userId = getPropertiesContent().document.all.item("checkBoxOne");
	var userId1 = getPropertiesContent().document.all.item("userId");
	if(userId1!=null){
		var temp = "";
	
		if(!userId1)
		{
			return;
		}
		if(userId1.length)
		{
			temp = userId1[0]; 
		}
		else
		{
			temp = userId1; 
		}
		
		
		getPropertiesContent().location.href="../user/userManager.do?method=getUser&dUserInfo=1&qstring=<%=qstring%>&userId="+temp.value;
	    
	}else{
	if(!userId)
	{
		
		return;
	}
	if(!userId.length )
	{
		if(!userId.checked)
		{
			alert("��ѡ��Ҫ�鿴���û���");
			return;
		}
		//��Ȩ
		
		getPropertiesContent().location.href="../user/userManager.do?method=getUser&dUserInfo=1&qstring=<%=qstring%>&userId="+userId.value;
		
		}
	
	if(userId.length)
	{
		
		var count = 0 ;
		var index = -1;
		for(var i = 0; i < userId.length; i ++)
		{
			if(!userId[i].checked)
			{
				continue;
			}
			else
			{				
				count ++;
				index = i;
			}
		}
		
		if(count == 0)
		{
			alert("��ѡ��Ҫ�鿴���û���");
			return;
		}
		else if(count == 1)
		{
			//��Ȩ
			getPropertiesContent().location.href="../user/userManager.do?method=getUser&dUserInfo=1&qstring=<%=qstring%>&userId="+userId[index].value;
			
		}
		else
		{
			alert("ֻ��ѡ��һ���û����в鿴��");
			return;
		}
	  }	
	}
}
//-------------------------------------------------------------------------------------------------------------------
function userorg()
{
	//�������
	var userId = getPropertiesContent().document.all.item("checkBoxOne");
	//var orgId = getPropertiesContent().document.all.item("orgId");
	var userId1 = getPropertiesContent().document.all.item("userId");
		
		if(userId1!=null){
		var temp = "";
	
		if(!userId1)
		{
			return;
		}
		if(userId1.length)
		{
			temp = userId1[0]; 
		}
		else
		{
			temp = userId1; 
		}
		
		 
		  getPropertiesContent().location.href="../user/org2discrete.jsp?userId="+temp.value;
		}else{	
	if(!userId)
	{
		
		return;
	}
	if(!userId.length )
	{
		if(!userId.checked)
		{
			alert("��ѡ��Ҫ������û���");
			return;
		}
		//��Ȩ
		// getPropertiesContent().location.href="../user/user2group.jsp?orgId="+orgId.value+"&userId="+userId.value;
		getPropertiesContent().location.href="../user/org2discrete.jsp?userId="+userId.value;
		}
	
	if(userId.length)
	{
		
		var count = 0 ;
		var index = -1;
		for(var i = 0; i < userId.length; i ++)
		{
			if(!userId[i].checked)
			{
				continue;
			}
			else
			{				
				count ++;
				index = i;
			}
		}
		
		if(count == 0)
		{
			alert("��ѡ��Ҫ������û���");
			return;
		}
		else if(count == 1)
		{
			//��Ȩ
			getPropertiesContent().location.href="../user/org2discrete.jsp?&userId="+userId[index].value;
		}
		else
		{
			alert("ֻ��ѡ��һ���û����е��룡");
			return;
		}
		
	}
  }
}
var qstring="<%=qstring%>";
var uId = "<%=userId%>";
var orgid = "0";
//alert("uId.length():"+uId.length);
//alert("uId:" + uId);
if(uId ==""){
	getPropertiesContent();
	getPropertiesContent().location.href="../user/discreteUserList.jsp";


}

	function getElementByName(eName){
		var elements = document.body.all;
		for(i = 0;i< elements.length;i++){
           if (elements[i].name==eName) return elements[i];
		}
		return null;
	}
	function selectTool(toolName) {
	    var tool=getElementByName(toolName);
		if (tool) {
		    tool.onclick();
		}
	}

	function bussinessAction(action){
		if(action != 6 && uId == "")
		{
			alert("������ɢ�û��б���ѡ��һ���û�!");
			return;
		}

	    if(action == 1 && getPropertiesContent()){
			getPropertiesContent().location.href="../user/userManager.do?method=getUser&dUserInfo=1&qstring=<%=qstring%>&userId=<%=userId%>";
	    }
	    else if(action == 3&&getPropertiesContent()){
	    //   getPropertiesContent().location.href="../user/userOrg.do?method=getOrgList&orgId="+orgid;
	    	getPropertiesContent().location.href="../user/org2discrete.jsp?uid="+uId;
	    	
	    }
	    else if(action == 6&&getPropertiesContent()){
	        getPropertiesContent().location.href="../user/discreteUserList.jsp?<%=qqstring%>";
	    }
	}
</script>
<style type="text/css">
<!--
.style1 {color: #CCCCCC}
-->
</style>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
<div id="toolbarborder">

<table width="100%" height=25 cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="center" width=25 height=25><img
			class="normal" src="../images/actions.gif"></td>
		<td valign="middle"
			align="left" height=25 nowrap class="text">�û�����</td>
		<td id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����" title="˫�����" valign="middle"
			align="right" width="*" height=25 nowrap class="text">
		<table height=25 cellpadding=0 cellspacing=0 border=0>
		<tr>
			
			<td class=normal name="tool1" id="tools1" title="�û��б�" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(6)" height=25><table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="�û��б�" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;<span class="style1">�û��б�</span>&nbsp;</td>
			</tr></table></td>
			

			<%
			 if (accessControl.checkPermission("lisan",
                         "lisanusermanager", AccessControl.ORGUNIT_RESOURCE))
            {%>
			<td class=normal name="tool1" id="tools1" title="�û�������Ϣ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="userinfo()" height=25><table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="�û�������Ϣ" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;<span class="style1">�û�������Ϣ&nbsp;</span></td>
			</tr></table></td>
			<%}%>

			<%
			 if (accessControl.checkPermission("lisan",
                         "lisanusertoorg", AccessControl.ORGUNIT_RESOURCE))
            {%>
            <!--
			<td class=normal name="tool3" id="tools3" title="�������" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="userorg()" height=25><table cellSpacing=0 cellPadding=0 border=0><tr><td valign=center>&nbsp;<img src="../images/edit.gif" alt="�������" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;<span class="style1">�������&nbsp;</span></td>
			</tr></table></td>
			-->
			<%}%>

			</tr>
		</table>
		</td>
	</tr>
</table>
</div>

</body>
</html>
