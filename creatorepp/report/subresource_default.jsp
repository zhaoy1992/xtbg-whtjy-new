<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);
	String resource_id= request.getParameter("resource_id");
	String resource_name= request.getParameter("resource_name");
	String resource_type= request.getParameter("resource_type");
	resource_id= (resource_id == null)?"":resource_id;
	resource_name= (resource_name == null)?"":resource_name;
	resource_type= (resource_type == null)?"":resource_type;
%>
<html>
<head>

	<script src="report.js"></script>

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
  	
  	
  	//图片预览2
  	function showPicture(resource_id) {
  		showModalDialog("show_picture.jsp?resource_id="+resource_id,null,"dialogWidth:250px;dialogHeight:380px;dialogLeft:160px;dialogTop:200px;help:no");
  	}
  	
  	//资源下载
  	function download(resource_id,resource_type,resource_suffix,resource_name){
  		window.open("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/downLoadJrxml.jsp?resource_suffix="+resource_suffix+"&resource_id="+resource_id+"&resource_type="+resource_type+"&resource_name="+resource_name);
  	}
  
	//打开远程设计器
	function openJrxmlDesigner(resource_id,resource_type){
		window.open("<%=request.getContextPath()%>/report/ireporthandle.jsp?rep_id="+resource_id+"&rep_stype="+resource_type);
	}
	//运行子报表
	function runSubReport(resource_id) {
		window.open("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/showreport.jsp?raq="+resource_id+"&type=subresource");
	}
	//新增子资源
	function addSubresource(){
		var returnValue = window.showModalDialog("subresource_new.jsp","properties");
        if(returnValue == "true"){
           window.location.reload();
        }
	}

	//清空
	function myclear()
	{
		document.subResourceForm.resource_id.value="";
		document.subResourceForm.resource_name.value="";
	}

	function queryForm()
	{
		var resource_id = document.subResourceForm.resource_id.value;
		var resource_name = document.subResourceForm.resource_name.value;
		var resource_type = document.subResourceForm.resource_type.value;
		subResourceForm.action = "http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/subresource_default.jsp?resource_id="
		+resource_id
		+"&resource_name="
		+resource_name
		+"&resource_type="
		+resource_type;
		
		subResourceForm.submit();
	}
	
	function setSelectId()
	{
		var els=document.getElementsByName("checkBoxOne");
		var count= 0;
		var obj= document.all.selectId;
		obj.value="";
		for(var i=0;i<els.length;i++)
		{
			if(els[i].checked)
			{
				count++;
				obj.value = els[i].value;
			}
		}
		
		return count;
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
	function delcheck(statu,rid){
		if(statu==1){
		alert(rid);
		alert(1111);
		return;
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
	
	//删除前查询子资源的副报表信息进行提示
	function alertWarnWhenDelete() {
		var b=document.all.selectId;
		var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/reportglobalservlet?@action=when_delete_subresource&ids="+b.value);
		if(retX != "") {
			if(window.confirm(retX)){
				var ret=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/reportglobalservlet?@action=delete_subresource&ids="+b.value);
				alert(ret);
				window.location.reload();
				}
				return;
		}
		if(window.confirm("确定删除吗？")){
		var re=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/report/reportglobalservlet?@action=delete_subresource&ids="+b.value);
		alert(re);
		window.location.reload();
		}
	}
	
	function deleteResource() {
		//删除子资源
		var count= setSelectId();
		if(count==1)
		{
				alertWarnWhenDelete();
		}
		else if(count==0)
		{
			alert("请选择要删除的资源!");
		}else {
			alert("只能删除一个");
		}
	}
	
  </script>

</head>

<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" scroll="no">
	<form name="subResourceForm"  method="post">
		<div id="contentborder" align="center">
			
				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="thin">
					<tr>
						<td class="detailtitle" width="10%" align=right>
							资源编号：
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="resource_id" style="width:70%" value="<%=resource_id%>">
						</td>
					</tr>
					<tr>
						<td class="detailtitle" width="10%" align=right>
							资源名称：
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="resource_name" style="width:70%" value="<%=resource_name%>">
						</td>
					</tr>
					<tr>
						<td class="detailtitle" width="10%" align=right>
							资源类型：
						</td>
						<td class="detailcontent" width="90%">
							<select name="resource_type">
								<option value="">请选择资源类型
								<option value="1">报表
								<option value="2">图片
							</select>
						</td>
					</tr>
					<tr>
						<td width="16%">
						</td>
						<td class="detailcontent" width="30%" align="right">
							<input name="Submit4" type="submit" class="input" value="查询" onClick="queryForm()">
							<input name="Submit22" type="button" class="input" value="清空" onClick="myclear()">
						</td>
					</tr>
				</table>
				<hr width="100%">

				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">

					<tr>
						<td height='30' class="detailtitle" align=center colspan=10>
							<b>报表子资源列表</b>
						</td>
					</tr>
					<pg:listdata dataInfo="com.chinacreator.epp.reportmanage.menu.SubResourceList" keyName="com.chinacreator.epp.reportmanage.menu.SubResourceList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request" data="com.chinacreator.epp.reportmanage.menu.SubResourceList"
						>
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll"
										onclick="checkAll('checkBoxAll','checkBoxOne')">
								</P>
							</td>
							<td height='20' class="headercolor">
								资源编号
							</td>
							<td height='20' class="headercolor">
								资源名称
							</td>
							<td height='20' class="headercolor">
								资源类型
							</td>
							<td height='20' class="headercolor">
								资源后缀
							</td>
							
							<td height='20' class="headercolor">
								资源操作
							<input class="text" type="hidden" name="selectId"/>
							</td>
							
						</tr>

						<!-- 检测当前页面是否有记录 -->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									目前没有符合条件的子资源
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
									<P align="left" >
										<INPUT type="checkbox" name="checkBoxOne"
											onclick="checkOne('checkBoxAll','checkBoxOne')"
											value='<pg:cell colName="resource_id" defaultValue=""/>'>
									</P>
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<pg:cell colName="resource_id" defaultValue="" />
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<pg:cell colName="resource_name" defaultValue="" />
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
										<pg:equal colName="resource_type" value="1">
											报表
										</pg:equal>
										<pg:equal colName="resource_type" value="2">
											图片
										</pg:equal>
										
								</td>
								
								<td height='20' align="left" class="tablecells" onclick="">
									<pg:cell colName="resource_suffix" defaultValue="" />
								</td>
								
								<td height='20' align="left" class="tablecells">
									<pg:equal colName="resource_type" value="1">
										<input type="button" value="修改" onclick="openJrxmlDesigner('<pg:cell colName="resource_id" defaultValue=""/>','<pg:cell colName="resource_type" defaultValue=""/>')"/>
										<input type="button" value="运行" onclick="runSubReport('<pg:cell colName="resource_id" defaultValue="" />')"/>
									</pg:equal>
									<pg:equal colName="resource_type" value="2">
										<input type="button" value="预览" onclick="showPicture('<pg:cell colName="resource_id" defaultValue=""/>')"/>
									</pg:equal>
									<input type="button" value="下载" onclick="download('<pg:cell colName="resource_id" defaultValue=""/>','<pg:cell colName="resource_type" defaultValue=""/>','<pg:cell colName="resource_suffix" defaultValue=""/>'),'<pg:cell colName="resource_name" defaultValue=""/>'"/>
								</td>
								</tr>
								<pg:param name="resource_name"/>
								<pg:param name="resource_type"/>
						</pg:list>


						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align="right">
								共
								<pg:rowcount />
								条记录
								<pg:index />

								<input name="addbutton" type="button" class="input" value="新增"
									onclick="addSubresource()"/>
								<input type="button" value="删除" class="input"
									onclick="deleteResource()"/>
								
							</td>
						</tr>
					</pg:pager>

				</table>
				</div>
			</form>
		
	</body>
	<iframe name="properties" style="display:none"></iframe>
</html>
