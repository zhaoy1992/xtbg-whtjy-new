<%@ include file="../../include/global1.jsp"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.config.ConfigManager"%>
<%

AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(pageContext);

String jobid = request.getParameter("selected");
if(jobid==null)jobid="";
%> 
<html>
<head>
<title>��������������</title>
<link rel="stylesheet" type="text/css" href="../../css/toolbar.css">
<%

%>


<jsp:include page="../../base/scripts/panes.jsp" />
<script language="javascript" src="../../scripts/toolbar.js"></script>
<script language="javascript">
function jobinfo()
{
	//��λ������Ϣ	
	var jobId = getPropertiesContent().document.all.item("checkBoxOne");
	var jobId1 = getPropertiesContent().document.all.item("jobId");
	if(jobId1!=null){
		var temp = "";
	
		if(!jobId1)
		{
			return;
		}
		if(jobId1.length)
		{
			temp = jobId1[0]; 
		}
		else
		{
			temp = jobId1; 
		}
		
		getPropertiesContent().location.href="jobmain.jsp?jobId="+temp.value;;
		
	}else{
	if(!jobId)
	{
		
		return;
	}
	if(!jobId.length )
	{
		if(!jobId.checked)
		{
			alert("��ѡ��Ҫ�鿴�ĸ�λ��");
			return;
		}
		//��Ȩ
		getPropertiesContent().location.href="jobmain.jsp?jobId="+jobId.value;
		
		}
	
	if(jobId.length)
	{
		
		var count = 0 ;
		var index = -1;
		for(var i = 0; i < jobId.length; i ++)
		{
			if(!jobId[i].checked)
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
			alert("��ѡ��Ҫ�鿴�ĸ�λ��");
			return;
		}
		else if(count == 1)
		{
			//��Ȩ
			getPropertiesContent().location.href="jobmain.jsp?jobId="+jobId[index].value;
			
		}
		else
		{
			alert("ֻ��ѡ��һ����λ���в鿴��");
			return;
		}
	  }	
	}
}
//------------------------------------------------------------------------------------------------------------------------------------
function suborg()
{
	//��������
	var jobId = getPropertiesContent().document.all.item("checkBoxOne");
	var jobId1 = getPropertiesContent().document.all.item("jobId");
	
	if(jobId1!=null){
		var temp = "";
	
		if(!jobId1)
		{
			return;
		}
		if(jobId1.length)
		{
			temp = jobId1[0]; 
		}
		else
		{
			temp = jobId1; 
		}
		
		getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/jobsuborglist.jsp?jobId="+temp.value;;
		
	}else{
	if(!jobId)
	{
		
		return;
	}
	if(!jobId.length )
	{
		if(!jobId.checked)
		{
			alert("��ѡ��Ҫ�鿴�ĸ�λ��");
			return;
		}
		//��Ȩ
		getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/jobsuborglist.jsp?jobId="+jobId.value;
		
		}
	
	if(jobId.length)
	{
		
		var count = 0 ;
		var index = -1;
		for(var i = 0; i < jobId.length; i ++)
		{
			if(!jobId[i].checked)
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
			alert("��ѡ��Ҫ�鿴�ĸ�λ��");
			return;
		}
		else if(count == 1)
		{
			//��Ȩ
			getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/jobsuborglist.jsp?jobId="+jobId[index].value;
			
		}
		else
		{
			alert("ֻ��ѡ��һ����λ���в鿴��");
			return;
		}
	  }	
	}
}
//------------------------------------------------------------------------------------------------------------------------------------
function roleop()
{
	//��ɫ����
	var jobId = getPropertiesContent().document.all.item("checkBoxOne");
	var jobId1 = getPropertiesContent().document.all.item("jobId");
	
	if(jobId1!=null){
		var temp = "";
	
		if(!jobId1)
		{
			return;
		}
		if(jobId1.length)
		{
			temp = jobId1[0]; 
		}
		else
		{
			temp = jobId1; 
		}
		
		getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/joborglist.jsp?jobId="+temp.value;
	}else{
	if(!jobId)
	{
		
		return;
	}
	if(!jobId.length )
	{
		if(!jobId.checked)
		{
			alert("��ѡ��Ҫ�鿴�ĸ�λ��");
			return;
		}
		//��Ȩ
		getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/joborglist.jsp?jobId="+jobId.value;
		}
	
	if(jobId.length)
	{
		
		var count = 0 ;
		var index = -1;
		for(var i = 0; i < jobId.length; i ++)
		{
			if(!jobId[i].checked)
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
			alert("��ѡ��Ҫ�鿴�ĸ�λ��");
			return;
		}
		else if(count == 1)
		{
			//��Ȩ
			getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/joborglist.jsp?jobId="+jobId[index].value;
		}
		else
		{
			alert("ֻ��ѡ��һ����λ���в鿴��");
			return;
		}
	  }	
	}
}
//------------------------------------------------------------------------------------------------------------------------------------
function resop()
{
	//��ԴȨ�޲�ѯ
	var jobId = getPropertiesContent().document.all.item("checkBoxOne");
	var jobId1 = getPropertiesContent().document.all.item("jobId");
	
	if(jobId1!=null){
		var temp = "";
	
		if(!jobId1)
		{
			return;
		}
		if(jobId1.length)
		{
			temp = jobId1[0]; 
		}
		else
		{
			temp = jobId1; 
		}
		window.showModalDialog("<%=rootpath%>/sysmanager/jobmanager/A03/jobres_queryframe.jsp?jobId="+temp.value,"","dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
		//getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/jobres_queryframe.jsp?jobId="+temp.value;
		
	}else{
	if(!jobId)
	{
		
		return;
	}
	if(!jobId.length )
	{
		if(!jobId.checked)
		{
			alert("��ѡ��Ҫ�鿴�ĸ�λ��");
			return;
		}
		//��Ȩ
		window.showModalDialog("<%=rootpath%>/sysmanager/jobmanager/A03/jobres_queryframe.jsp?jobId="+jobId.value,"","dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
		//getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/jobres_queryframe.jsp?target=blank&jobId="+jobId.value;
		
		}
	
	if(jobId.length)
	{
		
		var count = 0 ;
		var index = -1;
		for(var i = 0; i < jobId.length; i ++)
		{
			if(!jobId[i].checked)
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
			alert("��ѡ��Ҫ�鿴�ĸ�λ��");
			return;
		}
		else if(count == 1)
		{
			//��Ȩ
			window.showModalDialog("<%=rootpath%>/sysmanager/jobmanager/A03/jobres_queryframe.jsp?jobId="+jobId[index].value,"","dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no");
			//getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/jobres_queryframe.jsp?jobId="+jobId[index].value;
			
		}
		else
		{
			alert("ֻ��ѡ��һ����λ���в鿴��");
			return;
		}
	  }	
	}
}
//------------------------------------------------------------------------------------------------------------------------------------

function conferorg()
{
	//��λ�������
	var jobId = getPropertiesContent().document.all.item("checkBoxOne");
	var jobId1 = getPropertiesContent().document.all.item("jobId");
	
	if(jobId1!=null){
		var temp = "";
	
		if(!jobId1)
		{
			return;
		}
		if(jobId1.length)
		{
			temp = jobId1[0]; 
		}
		else
		{
			temp = jobId1; 
		}
		
		getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/job2org.jsp?jobId="+temp.value;;
		
	}else{
	if(!jobId)
	{
		
		return;
	}
	if(!jobId.length )
	{
		if(!jobId.checked)
		{
			alert("��ѡ��Ҫ�鿴�ĸ�λ��");
			return;
		}
		//��Ȩ
		getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/job2org.jsp?jobId="+jobId.value;
		
		}
	
	if(jobId.length)
	{
		
		var count = 0 ;
		var index = -1;
		for(var i = 0; i < jobId.length; i ++)
		{
			if(!jobId[i].checked)
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
			alert("��ѡ��Ҫ�鿴�ĸ�λ��");
			return;
		}
		else if(count == 1)
		{
			//��Ȩ
			getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/job2org.jsp?jobId="+jobId[index].value;
			
		}
		else
		{
			alert("ֻ��ѡ��һ����λ���в鿴��");
			return;
		}
	  }	
	}
} 
//------------------------------------------------------------------------------------------------------------------------------------
function post()
{
	//�û���ְ���
	var jobId = getPropertiesContent().document.all.item("checkBoxOne");
	var jobId1 = getPropertiesContent().document.all.item("jobId");
	
	if(jobId1!=null){
		var temp = "";
	
		if(!jobId1)
		{
			return;
		}
		if(jobId1.length)
		{
			temp = jobId1[0]; 
		}
		else
		{
			temp = jobId1; 
		}
		
		getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/jobSee_tab.jsp?jobId="+temp.value;;
		
	}else{
	if(!jobId)
	{
		
		return;
	}
	if(!jobId.length )
	{
		if(!jobId.checked)
		{
			alert("��ѡ��Ҫ�鿴�ĸ�λ��");
			return;
		}
		//��Ȩ
		getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/jobSee_tab.jsp?jobId="+jobId.value;
		
		}
	
	if(jobId.length)
	{
		
		var count = 0 ;
		var index = -1;
		for(var i = 0; i < jobId.length; i ++)
		{
			if(!jobId[i].checked)
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
			alert("��ѡ��Ҫ�鿴�ĸ�λ��");
			return;
		}
		else if(count == 1)
		{
			//��Ȩ
			getPropertiesContent().location.href="<%=request.getContextPath()%>/sysmanager/jobmanager/A03/jobSee_tab.jsp?jobId="+jobId[index].value;
			
		}
		else
		{
			alert("ֻ��ѡ��һ����λ���в鿴��");
			return;
		}
	  }	
	}
}
var jobid="<%=jobid%>"; 
 if(jobid!=""){
	//alert(getPropertiesContent().location.href) 
 	getPropertiesContent().location.href="jobmain.jsp?jobId="+jobid;	
 }
</script>
<meta http-equiv="Content-Type" content="text/html; charset=GBK"></head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">

<table width="100%"  cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="center" width=25 ><img
			class="normal" src="../../images/actions.gif"></td>
		<td valign="middle"
			align="left"  nowrap class="text">ҵ�����</td>
		<td id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����" title="˫�����" valign="middle"
			align="right" width="*"  nowrap class="text">
		<table  cellpadding=0 cellspacing=0 border=0>
		<tr>
				<%
				if (accessControl.checkPermission(jobid,
	                       AccessControl.WRITE_PERMISSION, AccessControl.JOB_RESOURCE))
	            {%>
				<td class=normal name="tool1" id="tools1" title="��λ������Ϣ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="jobinfo()"><table border=0 cellPadding=0 cellSpacing=0 class="text">
				  <tr><td valign=center>&nbsp;<img src="../../images/new.gif" alt="�����ҵ��" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��λ������Ϣ&nbsp;</td></tr></table></td>
				<%}%>
				
<!------------------------------------------------------------------------------------------------------------------>
				
				<!-- ��λ������ɫ���� ��Ϊ ��λ����������ѯ -->
				<%
				 if (accessControl.checkPermission(jobid,
	                       "roleset", AccessControl.JOB_RESOURCE))
	            {%>
				<td class=normal name="tool5" id="tools5" title="��λ����������ѯ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="roleop()"><table border=0 cellPadding=0 cellSpacing=0 class="text">
				  <tr><td valign=center>&nbsp;<img src="../../images/edit.gif" alt="��λ����������ѯ" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��λ����������ѯ&nbsp;</td></tr></table></td>
				<%}%>
				
<!------------------------------------------------------------------------------------------------------------------>
				<%
				if(ConfigManager.getInstance().getConfigBooleanValue("enablejob", false))
				{
				%>
								
<!------------------------------------------------------��������������ɫ������ѯ��------------------------------------------------------------>
				<%
				 if (false && accessControl.checkPermission(jobid,
	                       "respurviewsearch", AccessControl.JOB_RESOURCE))
	            {%>
				<td class=normal name="tool6" id="tools6" title="��ԴȨ�޲�ѯ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="resop()">
				<table border=0 cellPadding=0 cellSpacing=0 class="text">
				  <tr><td valign=center>&nbsp;<img src="../../images/edit.gif" alt="��ԴȨ�޲�ѯ" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��ԴȨ�޲�ѯ&nbsp;</td></tr></table></td>
				<%}%>
<!------------------------------------------------------------------------------------------------------------------>
           	
            	<%
				 if (accessControl.checkPermission(jobid,
                       "orgset", AccessControl.JOB_RESOURCE))
		        {%>
				<td class=normal name="tool3" id="tools3" title="��λ�������" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="conferorg()" ><table border=0 cellPadding=0 cellSpacing=0 class="text">
				  <tr><td valign=center>&nbsp;<img src="../../images/edit.gif" alt="��λ�������" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��λ�������&nbsp;</td></tr></table></td>
		        <%}%>
		        
<!------------------------------------------------------------------------------------------------------------------>
		         <%
				 if (accessControl.checkPermission(jobid,
                       "userholdpost", AccessControl.JOB_RESOURCE))
		        {%>
				<td class=normal name="tool4" id="tools4" title="�û���ְ���" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="post()" ><table border=0 cellPadding=0 cellSpacing=0 class="text">
				  <tr><td valign=center>&nbsp;<img src="../../images/edit.gif" alt="�û���ְ���" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;�û���ְ���&nbsp;</td></tr></table></td>
		        <%}}%>
		     
            </tr>
		</table>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>