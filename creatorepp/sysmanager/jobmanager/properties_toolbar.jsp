<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.config.ConfigManager" %>
<%

	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(pageContext);
	
	String jobid = request.getParameter("selected");
	if(jobid==null)jobid="";
	//System.out.println("jobid=....."+jobid);
%> 
<html>
<head>
<title>��������������</title>
<link rel="stylesheet" type="text/css" href="../css/toolbar.css">
<%
	
%>


<jsp:include page="../base/scripts/panes.jsp" />
<script language="javascript" src="../scripts/toolbar.js"></script>
<script language="javascript">


var jobid="<%=jobid%>"; 
 if(jobid!=""){
 getPropertiesContent().location.href="../../jobmanager/job.do?method=getJobInfo&jobId="+jobid;	
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
		if(jobid == ""){
			alert("��ѡ����ߵĸ�λ��ѡ��һ����λ���в��� ��");
			return;
			//getPropertiesContent().location.href="../jobmanager/A03/nojob.jsp";
			       	       
		}

		 
		if(jobid!=""){ 		
	    if(action == 1 && getPropertiesContent()){	      
			getPropertiesContent().location.href="../../jobmanager/job.do?method=getJobInfo&jobId="+jobid;       	       
	    }	   
	    else if(action == 2&& getPropertiesContent()){	//��������		
			getPropertiesContent().location.href="../jobmanager/A03/jobsuborglist.jsp?jobId="+jobid;                     
	   	 }
	   	 else if(action == 3&& getPropertiesContent()){	
	   	 	getPropertiesContent().location.href="../jobmanager/A03/job2org.jsp?jobId="+jobid;                     
	   	 }
	   	  else if(action == 4&& getPropertiesContent()){	
	   	 	getPropertiesContent().location.href="../jobmanager/A03/jobSee_tab.jsp?jobId="+jobid;                     
	   	 }
	   	 
	   }
	   
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=GBK"></head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="toolbarbodymargin">
<div id="toolbarborder">
<div id="toolbar" ondblclick="switchFrameworks(<%=Framework.SWITCH_WORKSPACE%>,<%=Framework.SWITCH_SCOPE_PERSPECTIVEMAIN%>,document.all.doubleclickcolumn);">

<table width="100%"  cellpadding=0 cellspacing=0 border=0>
	<tr>
		<td valign="middle" align="center" width=25 ><img
			class="normal" src="../images/actions.gif"></td>
		<td valign="middle"
			align="left"  nowrap class="text">ҵ�����</td>
		<td id="doubleclickcolumn" recover="˫���ָ�" maxtitle="˫�����"  title="˫�����" valign="middle"
			align="right" width="*"  nowrap class="text">
		<table  cellpadding=0 cellspacing=0 border=0>
		<tr>
				<%
				 if (accessControl.checkPermission("jobbaseinfo",
	                       AccessControl.WRITE_PERMISSION, AccessControl.JOB_RESOURCE))
	            {%>
				<td class=normal name="tool1" id="tools1" title="��λ������Ϣ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick=bussinessAction(1) ><table border=0 cellPadding=0 cellSpacing=0 class="text">
				  <tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="�����ҵ��" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��λ������Ϣ&nbsp;</td></tr></table></td>
				<%}else if(accessControl.checkPermission("jobbaseinfo",
	                       AccessControl.READ_PERMISSION, AccessControl.JOB_RESOURCE)){%>
	            <td class=normal name="tool1" id="tools1" title="��λ������Ϣ" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this)  ><table border=0 cellPadding=0 cellSpacing=0 class="text">
				  <tr><td valign=center>&nbsp;<img src="../images/new.gif" alt="�����ҵ��" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��λ������Ϣ&nbsp;</td></tr></table></td>
	            <%}%>
<!------------------------------------------------------------------------------------------------------------------>
				<%
				 if (accessControl.checkPermission("jobsubjectionorg",
	                       AccessControl.WRITE_PERMISSION, AccessControl.JOB_RESOURCE))
	            {%>
				<td class=normal name="tool2" id="tools2" title="��������" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(2)" ><table border=0 cellPadding=0 cellSpacing=0 class="text">
				  <tr><td valign=center>&nbsp;<img src="../images/edit.gif" alt="�޸Ĵ�ҵ��" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��������&nbsp;</td></tr></table></td>
            	<%}else if(accessControl.checkPermission("jobsubjectionorg",
	                       AccessControl.READ_PERMISSION, AccessControl.JOB_RESOURCE)){%>
				<td class=normal name="tool2" id="tools2" title="��������" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this)  ><table border=0 cellPadding=0 cellSpacing=0 class="text">
				  <tr><td valign=center>&nbsp;<img src="../images/edit.gif" alt="�޸Ĵ�ҵ��" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��������&nbsp;</td></tr></table></td>
				<%}%>                      
<!------------------------------------------------------------------------------------------------------------------>
           	
            	 <%
				 if (accessControl.checkPermission("jobconferorg",
                       AccessControl.WRITE_PERMISSION, AccessControl.JOB_RESOURCE))
		        {%>
				<td class=normal name="tool3" id="tools3" title="��λ�������" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(3)" ><table border=0 cellPadding=0 cellSpacing=0 class="text">
				  <tr><td valign=center>&nbsp;<img src="../images/edit.gif" alt="��λ�������" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��λ�������&nbsp;</td></tr></table></td>
		        <%}else if(accessControl.checkPermission("jobconferorg",
                       AccessControl.READ_PERMISSION, AccessControl.JOB_RESOURCE))
			    {%>
			    <td class=normal name="tool3" id="tools3" title="��λ�������" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this)><table border=0 cellPadding=0 cellSpacing=0 class="text">
				  <tr><td valign=center>&nbsp;<img src="../images/edit.gif" alt="��λ�������" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;��λ�������&nbsp;</td></tr></table></td>
			    <%}%>
		        
<!------------------------------------------------------------------------------------------------------------------>
		        
		         <%
				 if (accessControl.checkPermission("jobsee",
                       AccessControl.WRITE_PERMISSION, AccessControl.JOB_RESOURCE))
		        {%>
				<td class=normal name="tool4" id="tools4" title="�û���ְ���" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this) onclick="bussinessAction(4)" ><table border=0 cellPadding=0 cellSpacing=0 class="text">
				  <tr><td valign=center>&nbsp;<img src="../images/edit.gif" alt="�û���ְ���" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;�û���ְ���&nbsp;</td></tr></table></td>
		        <%}else if(accessControl.checkPermission("jobsee",
                       AccessControl.READ_PERMISSION, AccessControl.JOB_RESOURCE))
		        {%>
		        <td class=normal name="tool4" id="tools4" title="�û���ְ���" valign=middle align=center onmousedown=mousedown(this) onmouseout=mouseout(this) onmouseover=mouseover(this) onmouseup=mouseup(this)  ><table border=0 cellPadding=0 cellSpacing=0 class="text">
				  <tr><td valign=center>&nbsp;<img src="../images/edit.gif" alt="�û���ְ���" width=16 height=16 border=0 class="normal"></td><td valign=center>&nbsp;�û���ְ���&nbsp;</td></tr></table></td>
		        <%}%>
            </tr>
		</table>
		</td>
	</tr>
</table>
</div>
</div>
</body>
</html>
