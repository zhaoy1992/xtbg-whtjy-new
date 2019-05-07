<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	
	String processId = (String)request.getParameter("processId");
	String processName = (String)request.getParameter("processName");
	if(processId == null)
    {
		processId = "";
	}
	if(processName == null)
    {
		processName = "";
	}
%>
<html>
	<head>
		<title>属性容器</title>

		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script src="xpdl.js"></script>
		<script type="text/javascript">
			function queryForm()
			{	
				var sUrl="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/jawe/jawe_default.jsp";
				ApplyForm.action=sUrl;
				ApplyForm.submit();	
			}
			
			function openXpdl(mgrName,pid,ecid)
			{
				//首先验证是否已经打开
				var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=valIsOpen&pid="+pid);
				if(retX=="true")
				{
					alert("该文件已经被其他用户打开,请稍后再试！");
					return false;
				}
				//var tmp = escape(mgrName);
				//var tmp = mgrName;
				var reg=/#/g;
				//alert(mgrName.replace(reg,"~"));
				mgrName=mgrName.replace(reg,"~");
				//var url = encodeURI("xpdl_open.jsp?ec_id="+<%=request.getParameter("ec_id")%>+"&op=modify&mgrName="+mgrName);
				//var retx=window.showModalDialog(url);
				
				//retx=window.showModalDialog("xpdl_open.jsp?ec_id="+<%=request.getParameter("ec_id")%>+"&op=modify&mgrName="+mgrName,"help:no");
				//if(retx) window.location.reload();
				//retx=window.showModalDialog("xpdl_open.jsp?ec_id="+<%=request.getParameter("ec_id")%>+"&op=modify&mgrName="+mgrName,"myFrame");
				document.getElementById("divProcessing").style.display="block";
				document.getElementById("myFrame").src="xpdl_open.jsp?ec_id="+ecid+"&op=modify&mgrName="+mgrName;
			}
			
			function showXpdlHistory(pname,ecid)
			{
				var retx=window.showModalDialog("xpdl_history.jsp?ec_id="+ecid+"&op=modify&pname="+pname,window);
				if(retx) window.location.reload();
			}
			
			// 复选框全部选中
			function checkAll(totalCheck,checkName){	
		 	 		var selectAll = document.getElementsByName(totalCheck);
		  			var o = document.getElementsByName(checkName);
		  			if(selectAll[0].checked==true){
		   			for (var i=0; i<o.length; i++){
		     	  			if(!o[i].disabled){
		     	  				o[i].checked=true;
		     	  			}
		   			}
		  			}else{
		   			for (var i=0; i<o.length; i++){
		  	  	 	 		o[i].checked=false;
		  	   			}
		  			}
			}
		
		   
			// 单个选中复选框
			function checkOne(totalCheck,checkName){
		  			var selectAll = document.getElementsByName(totalCheck);
		  			var o = document.getElementsByName(checkName);
				var cbs = true;
				for (var i=0;i<o.length;i++){
					if(!o[i].disabled){
						if (o[i].checked==false){
							cbs=false;
						}
					}
				}
				if(cbs){
					selectAll[0].checked=true;
				}else{
					selectAll[0].checked=false;
				}
			}
			//发布流程
			function publish(pId,pName,userName)
			{
				var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=publish&pId="+pId+"&pName="+pName+"&userName=<%=control.getUserName()%>&userId=<%=control.getUserID()%>&userAccount=<%=control.getUserAccount()%>");
				alert(retX);
				window.location.reload();	
			}
			//取消发布	
			function cancelPublish(pId)
			{
				var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=cancelPublish&pId="+pId+"&userName=<%=control.getUserName()%>&userId=<%=control.getUserID()%>&userAccount=<%=control.getUserAccount()%>");
				alert(retX);
				window.location.reload();	
			}
			
			//发布SOA
			function publishSoa(pName,pid,ecid)
			{
				var reg=/#/g;
				pName=pName.replace(reg,"~");
				//var retx=window.showModalDialog("publish_soa.jsp?mgr_name="+pName+"&pid="+pid,window);
				var retx=window.showModalDialog("../uddi/processPara.jsp?mgr_name="+pName+"&pid="+pid,window,'dialogWidth:900px;dialogHeight:500px');		
				if(retx)
				{
					//retx是服务名
					//业务类别名称
					var ecName=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=ec_id&ec_id="+ecid);
					//alert(ecName);
					window.location.href="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/uddi/rightFrame.jsp?typeid="+ecid+"&typename="+ecName+"&name="+retx;
				}
				else
				{
					window.location.reload();
				}
			}
			
		//取消发布soa	
	function cancelPublishSOA(pName,pId)
    {
        var msg="是否确认此操作(单击确认后Schema文件将被删除)";
        if(confirm(msg))
        {
	        var reg=/#/g;
	        pName=pName.replace(reg,"~");
			var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/buildSchema?op=cancelPublishSOA&mgr_name="+pName+"&pId="+pId);
			alert(retX);
			window.location.reload();	
        }
	}

	//服务注册
	function regiestSOA(pName,pid)
	{
		window.location.href="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/uddi/rightFrame.jsp?typeid=<%=request.getParameter("ec_id")%>&name="+pName;
	}
	
	function regiestDEL(pName){
	 if(confirm("确定要从注册中心注销此流程服务吗?")){ 
	 	window.location.href="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/jawe/serviceFolwDel.jsp?pName="+pName;   
       }else{      
       	return false;   
      }		
	}
	function createAllXpdls()
	{
		//生成所有的XPDL文件
		var retx = SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=createall");
		document.getElementById("divProcessing").style.display="block";
		alert(retx);
		document.getElementById("divProcessing").style.display="none";
		window.location.reload();
	}
	
	function openWSDL(pName){	
	window.open("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/epp/process/openWSDL.jsp?pName="+pName);
	}	
		</script>
	</head>
	
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no"
		onLoad="">
		<div id="contentborder" align="center">
			<form name="ApplyForm" action="" method="post">
				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
					<tr>
						<td class="detailtitle" width="10%" align=right>
							流程编号：
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="processId" style="width:70%" value="<%= processId%>">
						</td>
					</tr>
					<tr>
						<td class="detailtitle" width="10%" align=right>
							流程名称：
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="processName" style="width:70%" value="<%= processName%>">
						</td>
					</tr>
					<tr>
						<td width="16%">
						</td>
						<td class="detailcontent" width="30%" align="right">

							<input name="Submit4" type="submit" class="input" value="查询" onClick="queryForm()">
							<input name="Submit22" type="reset" class="input" value="重置">
						</td>
					</tr>
					
					<%--生成所有流程文件的按钮，平时隐藏--%>
					<tr>
						<td colspan="2" class="detailcontent" width="30%" align="right">
							<input type="button" class="input" onclick="createAllXpdls();" value="生成所有的流程文件"/>
						</td>
					</tr>
					
				</table>
				<hr width="100%">
				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">
					<pg:listdata dataInfo="com.chinacreator.epp.processmanage.dbmanager.ProcessSearchList" keyName="XpdlProcessList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request" data="XpdlProcessList"
						isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll"
										onclick="checkAll('checkBoxAll','checkBoxOne')">
								</P>
							</td>
							<td height='20' class="headercolor">
								流程编号
							</td>
							<td height='20' class="headercolor">
								流程名称
							</td>
							<td height='20' class="headercolor">
								流程描述
							</td>
							<td height='20' class="headercolor">
								发布日期
							</td>
							<td height='20' class="headercolor">
								发布人
							</td>
							<td height='20' class="headercolor">
								发布状态
							</td>							
							<!--<td height='20' class="headercolor">
								服务查看
							</td>
							--><input class="text" type="hidden" name="selectId"/>
							<input name="delSingle" type="hidden" validator="string"
									maxlength="100" value="false"/>
						</tr>

						<pg:param name="ec_id" />
						
						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有流程
								</td>
							</tr>
						</pg:notify>		
									
						
						<!--list标签循环输出每条记录-->
						<pg:list>
							<tr class="labeltable_middle_tr_01"
								onMouseOver="this.className='mousestyle1'"
								onMouseOut="this.className= 'mousestyle2'"
								>
								<td class="tablecells" nowrap="true">
									<P align="left">
										<INPUT type="checkbox" name="checkBoxOne"
											onclick="checkOne('checkBoxAll','checkBoxOne')"
											value='<pg:cell colName="pId" defaultValue=""/>'>
									</P>
								</td>
								<td height='20' align="left" class="tablecells" onclick="showXpdlHistory('<pg:cell colName="pName" defaultValue=""/>','<pg:cell colName="ecId" defaultValue=""/>')">
									<pg:cell colName="pId" defaultValue="" />
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<%=dataSet.getString("pName").split("#")[0]%>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="remark" defaultValue="" />
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="publishTime" defaultValue="" dateformat="yyyy-MM-dd HH:mm"/>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:cell colName="publisher" defaultValue=""/>
								</td>
								<td height='20' align="left" class="tablecells">
									<pg:equal colName="publishState" value="0">流程未发布</pg:equal>
									<pg:equal colName="publishState" value="1">流程已发布</pg:equal>
									<pg:equal colName="publishState" value="2">服务已发布</pg:equal>
									<pg:equal colName="publishState" value="3">服务已注册</pg:equal>
								</td>								
								<!--<td height='20' align="left" class="tablecells">
									<pg:equal colName="publishState" value="0">服务未发布</pg:equal>
									<pg:equal colName="publishState" value="1">服务未发布</pg:equal>
									<pg:equal colName="publishState" value="2"><input type="button" value="查看服务" onclick="openWSDL('<pg:cell colName="pName" defaultValue=""/>')"/></pg:equal>
									<pg:equal colName="publishState" value="3"><input type="button" value="查看服务" onclick="openWSDL('<pg:cell colName="pName" defaultValue=""/>')"/></pg:equal>	
								</td>
								--></tr>
						</pg:list>
						
						
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								共
								<pg:rowcount />
								条记录
								<pg:index />
							</td>
						</tr>
					</pg:pager>

				</table>
			</form>
		</div>
	<div id="divProcessing" style="width:200px;height:30px;position:absolute;left:100px;top:260px;display:none">
			<table border="0" cellpadding="0" cellspacing="1" bgcolor="#000000" width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...处理中...请等待...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<iframe id="myFrame" scrolling="no" noresize frameborder="0"/>
</html>