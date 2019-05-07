<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(pageContext);


String userId = request.getParameter("userId");

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
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/toolbar.css">


<script language="javascript" src="../../sysmanager/scripts/toolbar.js"></script>
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
						
		getPropertiesContent().location.href="../member/memberManager.do?method=getMember&memberId="+temp.value;
		
	}else{
	if(!userId)
	{
		
		return;
	}
	if(!userId.length )
	{
		if(!userId.checked)
		{
			alert("��ѡ��Ҫ�鿴�Ļ�Ա��˫����");
			return;
		}
		//��Ȩ
		getPropertiesContent().location.href="../member/memberManager.do?method=getMember&memberId="+userId.value;
		
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
			alert("��ѡ��Ҫ�鿴�Ļ�Ա��˫����");
			return;
		}
		else if(count == 1)
		{
			//��Ȩ
			getPropertiesContent().location.href="../member/memberManager.do?method=getMember&memberId="+userId[index].value;
			
		}
		else
		{
			alert("ֻ��ѡ��һ����Ա���в鿴��");
			return;
		}
	  }	
	}
}



//----------------------------------------------------------------------------------------------------------------------
function userrole()
{
	//��ɫ����	
	var userId = getPropertiesContent().document.all.item("checkBoxOne");
	var userId1 = getPropertiesContent().document.all.item("userId");
	if(userId1 == null)
	{
		userId1 = getPropertiesContent().userId;
	}
	
	
		
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
		  getPropertiesContent().location.href="../member/memberManager.do?method=getRoleList&userId="+temp.value;
		}else{	
	if(!userId)
	{
		
		return;
	}
	if(!userId.length )
	{
		if(!userId.checked)
		{
			alert("��ѡ��Ҫ�鿴�Ļ�Ա��");
			return;
		}
		//��Ȩ
		 getPropertiesContent().location.href="../member/memberManager.do?method=getRoleList&userId="+userId.value;
		
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
			alert("��ѡ��Ҫ�鿴�Ļ�Ա��");
			return;
		}
		else if(count == 1)
		{
			//��Ȩ
			 getPropertiesContent().location.href="../member/memberManager.do?method=getRoleList&userId="+userId[index].value;
		}
		else
		{
			alert("ֻ��ѡ��һ����Ա���в鿴��");
			return;
		}
		
	}
  }
}





var uId = "<%=userId%>";

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
		
		if(action != 6 && (uId == null || uId == "" ))
		{
			alert("���ڻ�Ա��Ϣ�б���ѡ��һ����Ա��");
			return;
		}
		     if(action == 6&&getPropertiesContent()){
		        getPropertiesContent().location.href="../sitemember/memberList.jsp";
		    }
		  	
	  }




	
</script>
</head>
<body class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">

<table width="100%"  cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="center" width=25 ><img
			class="normal" src="../../sysmanager/images/actions.gif"></td>
		<td valign="middle"
			align="left"  nowrap class="text">��Ա����</td>
		<td id="doubleclickcolumn" title="˫�������" valign="middle"
			align="right" width="*"  nowrap class="text">
		<table  cellpadding=0 cellspacing=0 border=0>
		<tr>
		
			<td class=normal name="tool1" id="tools1" title="��Ա�б�" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(6)" ><table border=0 cellPadding=0 cellSpacing=0 class="text">
			  <tr><td valign=center>&nbsp;<img src="../../sysmanager/images/new.gif" alt="��Ա�б�" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��Ա�б�&nbsp;</td></tr></table></td>
			      
<!------------------------------------------------------------------------------------------------------------------>
			
			<td class=normal name="tool1" id="tools1" title="��Ա������Ϣ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="userinfo()" ><table border=0 cellPadding=0 cellSpacing=0 class="text">
			  <tr><td valign=center>&nbsp;<img src="../../sysmanager/images/new.gif" alt="��Ա������Ϣ" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��Ա������Ϣ&nbsp;</td></tr></table></td>

<!------------------------------------------------------------------------------------------------------------------>
			        
			 <td class=normal name="tool3" id="tools3" title="��Ա��ɫ����" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="userrole()" ><table border=0 cellPadding=0 cellSpacing=0 class="text">
			  <tr><td valign=center>&nbsp;<img src="../../sysmanager/images/edit.gif" alt="��Ա��ɫ����" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��Ա��ɫ����&nbsp;</td></tr></table></td>
		
			
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
