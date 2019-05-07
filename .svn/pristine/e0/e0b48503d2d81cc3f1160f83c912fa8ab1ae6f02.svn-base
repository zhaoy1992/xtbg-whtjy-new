<%@ include file="../include/global1.jsp"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.*"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Job,com.chinacreator.sysmgrcore.manager.JobManager,com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>

<%AccessControl accesscontroler = AccessControl.getInstance();
            accesscontroler.checkAccess(request, response);
            String pkgId = request.getParameter("pkgId");
            System.out.println("pkgId:" + pkgId);
            if (pkgId == null)
                pkgId = (String) request.getAttribute("pkgId");
            System.out.println("pkgId:" + pkgId);
            String pkgName = request.getParameter("pkgName");
            if (pkgName == null)
                pkgName = (String) request.getAttribute("pkgName");
            String procDefId = request.getParameter("procDefId");
            if (procDefId == null)
                procDefId = (String) request.getAttribute("procDefId");
            String procDefName = request.getParameter("procDefName");
            if (procDefName == null)
                procDefName = (String) request.getAttribute("procDefName");
            String enProcDefId = "";
            if (procDefId != null)
            {
                enProcDefId = StringUtil.encode(procDefId);
            } else
            {
                enProcDefId = procDefId;
            }
            procDefId = enProcDefId;
            

            %>

<script language="javascript">

	var pkgId = "<%=pkgId%>";
	var procDefId = "<%=enProcDefId%>";
	var procDefName = "<%=procDefName%>";
	var pkgName = "<%=pkgName%>";
	function addjob(actorId)
	{
	    window.open('selectjob.jsp?displayNameInput=usernames&pkgId='+pkgId+'&procDefName='+procDefName+'&pkgName='+pkgName+'&procDefId='+procDefId+'&actorId='+actorId+'&displayValueInput=userIds','newWin','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
		//document.forms[0].submit();
	}
	
	function adduser(actorId)
	{
	    window.open('selectuser.jsp?displayNameInput=usernames&pkgId='+pkgId+'&procDefName='+procDefName+'&pkgName='+pkgName+'&procDefId='+procDefId+'&actorId='+actorId+'&displayValueInput=userIds','addUser','scrollbars=no,status=no,titlebar=no,toolbar=no,z-lock=yes,width=616,height=500,top=150,left=250');
		//document.forms[0].submit();
	}
	function unbind(actorId,userName,userType)
	{
		document.forms[0].action="../workflowmanager/Usermapping.do?method=unbindUser&pkgId="+pkgId+"&procDefId="+procDefId+"&actorId="+actorId+"&userId="+userName + "&userType=" + userType;
		document.forms[0].submit();	
	}
	
	function checkAll(totalCheck,checkName){	//复选框全部选中
	   var selectAll = document.all.item(totalCheck);
	   
	   var o = document.all.item(checkName);
	   
	   if(selectAll.checked==true){
		   for (var i=0; o && o.length && i<o.length; i++){
	      	  if(!o[i].disabled){
	      	  	o[i].checked=true;
	      	  }
		   }
		   if(o && !o.length && !o.checked)
			{
				o.checked=true;
			}
		   
	   }else{
		   for (var i=0; o && o.length && i<o.length; i++){
	   	  	  o[i].checked=false;
	   	   }
	   	   if(o && !o.length && !o.checked)
			{
				o.checked=false;
			}
	   	   
	   }
	}
	//单个选中复选框
	function checkOne(totalCheck,checkName){

	   var selectAll = document.all.item(totalCheck);
	   var o = document.all.item(checkName);
		var cbs = true;

		for (var i=0;o && o.length && i < o.length;i++){
			if(!o[i].disabled){
				if (o[i].checked==false){
					cbs=false;
				}
			}
		}
		if(o && !o.length && !o.checked)
		{
			cbs = false;
		}
		if(cbs){
			selectAll.checked=true;
		}
		else{
			selectAll.checked=false;
		}
	}
	
	function batchUnbind() {
		document.forms[0].action="../workflowmanager/Usermapping.do?method=batchUnbindUser&pkgId="+pkgId+"&procDefId="+procDefId;
		document.forms[0].submit();	
	}
</script>

<html>
	<head>

		<title>角色绑定</title>

	</head>

	<link rel="stylesheet" type="text/css" href="../css/windows.css">
	<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
	<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
	<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
	<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
		<form name="UsermappingForm" method="post">
			
			<div id="contentborder">
				<table width="100%" cellpadding="1" cellspacing="1" class="thin">
					<tr>
						<td class="detailtitle" align=center colspan=7>
							<%if (pkgId == null)
            {%>
							<b>请选择包！</b>
							<%} else if (procDefId == null||procDefId.equals("null"))
            {%>
							<b><%=pkgName%>的角色列表</b>
							<%} else
            {%>
							<b><%=pkgName%>的<%=procDefName%>的流程角色列表</b>
							<%}%>
						</td>
					</tr>
					<pg:listdata dataInfo="UserMappingList" keyName="UserMappingList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="18" scope="request" data="UserMappingList" isList="false">
						<pg:param name="pkgId" />
						<pg:param name="pkgName" />
						<pg:param name="procDefId" />
						<pg:param name="procDefName" />
						<td class="headercolor" width="10">
							<input type="checkBox" name="checkBox" onClick="checkAll('checkBox','ID')">
						</td>
						<Td class="headercolor">
							角色/用户
						</Td>
						<Td class="headercolor">
							用户类型
						</Td>
						<Td class="headercolor" align='center'>
							操作
						</Td>

						<pg:list>
							<!-- 显示角色信息  -->
							<pg:equal colName="isActor" value="1">
								<tr class="input" bgcolor="#d0f5ff">
									<td class="tablecells" width="5%" nowrap="nowrap">
										<input name="pkgName" type="hidden" value="<%=pkgName%>">
										<input type="hidden" name="procDefName" value="<%=procDefName%>">
										<input name="usern ames" type="hidden" >
										<input type="hidden" name="userIds" >
									</td>
									
									<td class="tablecells" width="20%" nowrap="nowrap">
										<pg:equal colName="actorName" value="">未命名</pg:equal>
										<pg:cell colName="actorName" defaultValue="" />
									</td>
									<td class="tablecells" width="20%" nowrap="nowrap">
									</td>
									<td width="15%" align='left' nowrap="nowrap">
										&nbsp
										<input type="button" class="input" value="增加用户绑定" onclick="adduser('<pg:cell colName="actorId" defaultValue="" />')">
										<input type="button" class="input" value="增加岗位绑定" onclick="addjob('<pg:cell colName="actorId" defaultValue="" />')">
										
									</td>
								</tr>
							</pg:equal>
							<!-- 显示角色绑定的用户信息  -->
							<pg:equal colName="isActor" value="0">
								<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'">
									<td class="tablecells" width="5%" nowrap="nowrap">
										<input type="checkBox" name="ID" onClick="checkOne('checkBox','ID')" value="<pg:cell colName="userName" defaultValue=""/>+<pg:cell colName="actorId" defaultValue=""/>+<pg:cell colName="type" defaultValue=""/>">
									</td>
									<td class="tablecells" width="20%" nowrap="nowrap">
										&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
										<pg:equal colName="userName" value="">&nbsp</pg:equal>
										<pg:equal colName="type" value="1"><pg:cell colName="userName" defaultValue="" /></pg:equal>
										<pg:equal colName="type" value="2">
											<%
												String jobid = dataSet.getString("userName");
												if(jobid != null && !jobid.equals(""))
												{
													JobManager jobManager = SecurityDatabase.getJobManager();
													
                    								Job job = jobManager.getJobById(jobid);
                    								if(job != null)
                    									out.print(job.getJobName());
												}
											%>
										</pg:equal>
										</td>
									<td>
										<pg:equal colName="type" value="1">用户</pg:equal>
										<pg:equal colName="type" value="2">用户组</pg:equal>
					  				</td>
									<td width="15%" align='left' nowrap="nowrap">
										&nbsp&nbsp
										<pg:equal colName="type" value="1"><input type="button" class="input" value="取消当前绑定" onclick="unbind('<pg:cell colName="actorId" defaultValue="" />','<pg:cell colName="userName" defaultValue="" />',1)"></pg:equal>
										<pg:equal colName="type" value="2"><input type="button" class="input" value="取消当前绑定" onclick="unbind('<pg:cell colName="actorId" defaultValue="" />','<pg:cell colName="userName" defaultValue="" />',2)"></pg:equal>
										<input type="hidden" name="userType" value="<pg:cell colName="type"/>">
									</td>
								</tr>
							</pg:equal>
						</pg:list>
						<tr height="18px">
							<td class="detailcontent" colspan=7 align='right'>
								<pg:index />
								<input type="button" class="input" value="取消选定绑定" onclick="batchUnbind();">
								<input type="hidden" name="queryString" value="<pg:querystring/>">
							</td>
						</tr>
					</pg:pager>
				</TABLE>
			</div>
		</form>
		
	<%@ include file="../sysMsg.jsp"%> 
	</body>
</html>
