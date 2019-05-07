<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.security.AccessControl,
                 org.apache.commons.lang.StringUtils,
                 com.chinacreator.epp.businessClassManager.businessManager.FormClassManager,
                 com.chinacreator.epp.businessClassManager.vo.FormClass"%>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0); 
	
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
	
	String processId = (String)request.getParameter("processId");
	String processName = (String)request.getParameter("processName");
	String ec_id = (String)request.getParameter("ec_id");
	//String class_name = (String)request.getParameter("class_name");

	FormClassManager formClassManager = new FormClassManager();
	FormClass formClass = new FormClass();
	formClass = formClassManager.getFormClassByClassId(ec_id);
//	String eform_class_name = formClass.getEc_name()==null?"":"("+formClass.getEc_name()+")";
	String class_name = (formClass.getEc_name()==null||"null".equals(formClass.getEc_name()))?"":""+formClass.getEc_name()+"";

	if(processId == null)
    {
		processId = "";
	}
	if(ec_id == null)
    {
		ec_id = "";
	}
	if(processName == null)
    {
		processName = "";
	}
%>
<html>
<head>  

	<script src="xpdl.js"></script>

  <title>属性容器</title>
  
  	<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
	<META HTTP-EQUIV="Expires" CONTENT="0">
  
   <link rel="stylesheet" type="text/css" href="../css/windows.css">
   <link rel="stylesheet" type="text/css" href="../css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
  <link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
  <link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
  <script type="text/javascript">
  	function val_input(input)
  	{
  		//验证输入的是否为合法字符
	     var patten=/^[a-zA-Z0-9]+$/;
	  	 if(patten.test(input))
	  	 {
	  		 return true;
	  	 }else
	  	 {
	   	     return false;
	     }
  	}
  	
  	function newXPDL(ec_id)
	{	
		var retx=window.showModalDialog("<%=request.getContextPath() %>/jawe/xpdl_new.jsp?ec_id="+ec_id,window);
	}
	//修改流程基本信息 add by minghua.guo 090616
  	function editXPDLMes(pId)
	{	
		var retx=window.showModalDialog("<%=request.getContextPath() %>/jawe/xpdl_edit.jsp?pId="+pId,window);
		if(retx=='true') window.location.reload();
	}
	function openXpdl(mgrName,pid)
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
		document.getElementById("myFrame").src="xpdl_open.jsp?ec_id="+<%=request.getParameter("ec_id")%>+"&op=modify&mgrName="+mgrName+"&pid="+pid;
	}
	
	function showXpdlHistory(pname)
	{
		var retx=window.showModalDialog("xpdl_history.jsp?ec_id="+<%=request.getParameter("ec_id")%>+"&op=modify&pname="+pname,window);
		if(retx) window.location.reload();
	}
	
	function deleteProcess(forceToDel)
	{
		//删除流程记录
		setSelectId();
		var obj1=document.all.selectId;
		if(IsSpace(obj1.value))
		{
		   alert("没有选择任何记录！");
		   return false;
		}
		else
		{
			if(forceToDel=='true')
			{
				//强制删除
				if(!window.confirm("进行该删除操作会将所有将该流程的运行数据都删除,是否确定删除？"))
				{
					return false;
				}
			}
			else
			{
				if(!window.confirm("是否确定删除？"))
					return false;
			}
				var url = "http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=processDelete&userName=<%=control.getUserName()%>&userId=<%=control.getUserID()%>&userAccount=<%=control.getUserAccount()%>&pid="+obj1.value;
				if(forceToDel=='true')
				{
					url += "&forceToDel=true";
				}
				document.all.divProcessing.style.display="block";
				var retX=SendHttp(url);
				alert(retX);
				window.location.reload();
		}
	}
	
	function setSelectId()
	{
		var els=document.getElementsByName("checkBoxOne");
		var obj1=document.all.selectId;
		obj1.value="";
		for(var i=0;i<els.length;i++)
		{
			if(els[i].checked) obj1.value+=els[i].value+",";
		}
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
	function publishSoa(pName,pid)
	{
		var reg=/#/g;
		pName=pName.replace(reg,"~");		
		var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/buildSchema?op=checkBakFile&mgr_name="+pName+"&pid="+pid);		
		if(retX){
			if(confirm(retX)){
				var retM=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/buildSchema?op=recoverFile&mgr_name="+pName+"&pid="+pid);
				alert(retM);
				window.location.reload();
			}else{
				var retP=window.showModalDialog("../uddi/processPara.jsp?op=constructSchema&mgr_name="+pName+"&pid="+pid,window,'dialogWidth:1000px;dialogHeight:600px',"scroll:yes" );		
				if(retP){			
					var ecName=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=ec_id&ec_id=<%=request.getParameter("ec_id") %>");
					window.location.href="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/uddi/rightFrame.jsp?typeid=<%=request.getParameter("ec_id") %>&typename="+ecName+"&name="+retP;
				}else{
					window.location.reload();
				}
			}
		}else{
			var retP=window.showModalDialog("../uddi/processPara.jsp?op=constructSchema&mgr_name="+pName+"&pid="+pid,window,'dialogWidth:1000px;dialogHeight:600px',"scroll:yes" );		
			if(retP){			
				var ecName=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=ec_id&ec_id=<%=request.getParameter("ec_id") %>");
				window.location.href="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/uddi/rightFrame.jsp?typeid=<%=request.getParameter("ec_id") %>&typename="+ecName+"&name="+retP;
			}else{
				window.location.reload();
			}
		}
		
	}
	
	
	//取消发布soa	
	function cancelPublishSOA(pName,pId){
        var bakmsg="取消服务之前是否需要备份服务文件";
        var msg="是否确认要取消服务";
        var reg=/#/g;
	     	pName=pName.replace(reg,"~");
        if(confirm(bakmsg)){
        var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/buildSchema?op=bakFile&mgr_name="+pName+"&pId="+pId);
			alert(retX);
        }        
        if(confirm(msg))
        {	        
			var retS=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/buildSchema?op=cancelPublishSOA&mgr_name="+pName+"&pId="+pId);
			alert(retS);
			window.location.reload();	
        }
        
	}

		//服务注册
	function regiestSOA(pName,pid){			
		window.location.href="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/uddi/rightFrame.jsp?typeid=<%=request.getParameter("ec_id")%>&name="+pName;		
	}
	function regiestDEL(pName){
	 if(confirm("确定要从注册中心注销此流程服务吗?")){ 
	 	window.location.href="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/jawe/serviceFolwDel.jsp?typeid=<%=request.getParameter("ec_id")%>&class_name=<%=class_name%>&pName="+pName;   
       }else{      
       	return false;   
      }		
	}
	function queryForm()
	{	
		var processId = document.all("processId").value;
		var processName = document.all("processName").value;
		var sUrl="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/jawe/properties_content.jsp?processId="+processId+"&processName="+processName+"&bool=true&ec_id=<%=ec_id%>&class_name=<%=class_name%>";
		ApplyForm.action=sUrl;
		ApplyForm.submit();	
	}
	function openWSDL(pName){	
	window.open("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/epp/process/openWSDL.jsp?pName="+pName);
	}		
  </script>

</head>

<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" scroll="no">
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
							<input name="Submit22" type="button" class="input" value="重置" onClick='document.all("processName").value="";document.all("processId").value="";queryForm();'>
						</td>
					</tr>
				</table>
				<hr width="100%">

				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">

					<tr>
						<td height='30' class="detailtitle" align=center colspan=9>
							<b>流程列表(<%=class_name %>)</b>
						</td>
					</tr>
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
							<td height='20' class="headercolor" nowrap>
								流程编号
							</td>
							<td height='20' class="headercolor" nowrap>
								流程名称
							</td>
							<td height='20' class="headercolor" nowrap>
								流程描述
							</td>
							<td height='20' class="headercolor" nowrap>
								发布日期
							</td>
							<td height='20' class="headercolor" nowrap>
								发布人
							</td>
							<td height='20' class="headercolor" nowrap>
								发布状态
							</td>
							<td height='20' class="headercolor" nowrap>
								操作
							</td>
							<!-- <td height='20' class="headercolor">
								服务查看
							</td> -->
							<input class="text" type="hidden" name="selectId"/>
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
							<pg:param name="class_name" value="<%=class_name %>"/>
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
								<td height='20' align="left" class="tablecells" onclick="showXpdlHistory('<pg:cell colName="pName" defaultValue=""/>')">
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

								<td height='20' align="left" class="tablecells">
									<pg:equal colName="publishState" value="0">
										<input type="button" value="修改" onclick="openXpdl('<pg:cell colName="pName" defaultValue=""/>','<pg:cell colName="pId" defaultValue=""/>')"/>
										<input type="button" value="查看历史版本" onclick="showXpdlHistory('<pg:cell colName="pName" defaultValue=""/>')"/>
										<input type="button" value="发布" onclick="publish('<pg:cell colName="pId" defaultValue="" />','<pg:cell colName="pName" defaultValue=""/>','<%=control.getUserName()%>')"/>
									</pg:equal>
									<pg:equal colName="publishState" value="1">
										<input type="button" value="取消发布" onclick="cancelPublish('<pg:cell colName="pId" defaultValue="" />')"/>
										<!-- <input type="button" value="发布为服务" onclick="publishSoa('<pg:cell colName="pName" defaultValue="" />','<pg:cell colName="pId" defaultValue="" />')"/> -->
									</pg:equal>
									<pg:equal colName="publishState" value="2">
										<input type="button" value="取消服务发布"
											onclick="cancelPublishSOA('<pg:cell colName="pName" defaultValue="" />','<pg:cell colName="pId" defaultValue="" />')" />
										<input type="button" value="服务注册"
											onclick="regiestSOA('<pg:cell colName="pName" defaultValue="" />','<pg:cell colName="pId" defaultValue="" />')" />
									</pg:equal>
									<pg:equal colName="publishState" value="3">
									<input type="button" value="注销注册"	onclick="regiestDEL('<%=dataSet.getString("pName").split("#")[0]%>')" />
									</pg:equal>
									<input type="button" value="修改信息" onclick="editXPDLMes('<pg:cell colName="pId" defaultValue=""/>')"/>
								</td>
								<!-- <td height='20' align="left" class="tablecells">
									<pg:equal colName="publishState" value="0">服务未发布</pg:equal>
									<pg:equal colName="publishState" value="1">服务未发布</pg:equal>
									<pg:equal colName="publishState" value="2"><input type="button" value="查看服务" onclick="openWSDL('<pg:cell colName="pName" defaultValue=""/>')"/></pg:equal>
									<pg:equal colName="publishState" value="3"><input type="button" value="查看服务" onclick="openWSDL('<pg:cell colName="pName" defaultValue=""/>')"/></pg:equal>	
								</td> -->
								</tr>
						</pg:list>
						
						
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								共
								<pg:rowcount />
								条记录
								<pg:index />
								<input name="Submit" type="button" class="input" value="新增"
									onClick="newXPDL('<%=request.getParameter("ec_id") %>')"/>
								<input type="button" value="删除" class="input"
									onclick="deleteProcess('false')"/>
								
								<!-- //强制删除liuc -->
								<input type="button" value="强制删除" class="input"
									onclick="deleteProcess('true')"/>
								
							</td>
						</tr>
					</pg:pager>
				</table>
				<div align="center">
				</div>
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
