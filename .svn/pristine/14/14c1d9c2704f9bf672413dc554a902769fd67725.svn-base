<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../../../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.dbmanager.UserCheckOutOrgDBManager"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.dbmanager.UserCheckOrgDBManager"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request, response);

	String userID = StringUtil.replaceNull(request
			.getParameter("userID"), "");
	String orgID = StringUtil.replaceNull(
			request.getParameter("orgID"), "");
	UserCheckOrgDBManager userCheckOrgDBManager = new UserCheckOrgDBManager();
	UserCheckOutOrgDBManager userCheckOutOrgDBManager = new UserCheckOutOrgDBManager();
	String orgName = userCheckOutOrgDBManager
			.getOrgNameStrByOrgIDs(orgID);
	StringBuffer userIDs = new StringBuffer();
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
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js"
			type="text/javascript"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>
		<!-- 提交后页面变灰 -->
		<script language="javascript" type="text/javascript" src="pagegrey.js" charset="utf-8">
		</script>
		<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

		<!-- dwr begin-->
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/interface/userCheckOrgDWRManager.js'></script>
		<!-- dwr end -->

		<script language="JavaScript" type="text/javascript">
			//得到选择的用户ID
			function getSelUserOrgID(){
				var checkbox = document.getElementsByName("checkRadioOne");
				var seluserorgid = "";
				for(var i=0;i<checkbox.length;i++){
					if(checkbox[i].checked){
						return checkbox[i].value;						
					}
				}
				return seluserorgid;
			}
			//得到同步应用
			function getSelApp(){
				var checkbox = document.getElementsByName("checkBoxOne");
				var selApp = "";
				for(var i=0;i<checkbox.length;i++){
					if(checkbox[i].checked){
						selApp += checkbox[i].value+",";
					}
				}
				return selApp;
			}
					
			function edit(){
				var userorgid = getSelUserOrgID();
				if(userorgid==""){
					alert("请选择需要修改的用户！");
					return;
				}
				var url = "editusercheckinorg.jsp?userorgid="+userorgid;
			    var winaddorg = window.showModalDialog(url,window,"dialogWidth:"+(880)+"px;dialogHeight:"+(680)+"px;help:no;scroll:no;status:no;maximize=yes;minimize=0");
				if(winaddorg=="ok")
				{
					window.location=location;
				}
			}
			//页面跳转
			function jumpPage(){
				//提交后页面变灰
				popSignFlow(1);
				document.location.assign("usercheckorgselect.jsp?userID=<%=userID%>&&orgID=<%=orgID%>");
			}
			function showSecondOperation(obj){
				if(obj=="part"){
					document.getElementById("second_operation").style.display="none";
				}else{
					document.getElementById("second_operation").style.display="block";
				}
			}
			function save() {
				var userorgid = getSelUserOrgID();
				var selapp = getSelApp();
				if(userorgid==""){
					alert("请选择需要调回的用户！");
					return;
				}
				
					//提交后页面变灰
					popSignFlow(1);			
					
					userCheckOrgDWRManager.saveUserCheckInOrg(userorgid,selapp,saveResult);
			}
			function saveResult(obj){
				DWREngine.setPreHook(function() {});				
				DWREngine.setPostHook(function() {});
				
				//页面变灰恢复正常
				cancelSign();
				if(obj[0]=="false"){
					alert(obj[1]);
				}else{
					alert("保存成功！");
					window.returnValue = "ok";
					window.location=location;
				}
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
		<form name="myform" action="usercheckinorg.jsp" method="post">
			<div id="contentborder" align="center">
				<br />
				<br />
				<fieldset style="width: 90%; height: 500px;">
					<LEGEND align=center>
						<FONT size="2">用户调回选择</FONT>
					</LEGEND>
					<br />
					<table width="85%">						
						<tr>
							<td align="center">
							<div style="border:0px solid ; padding:5px;height:200px;overflow:auto;" > 
								<table width="100%" border="0" cellpadding="0" cellspacing="1"
									class="thin">
									<pg:listdata
										dataInfo="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.menu.UserCheckInOrgList"
										keyName="userCheckInOrg" />
									<!--分页显示开始,分页标签初始化-->
									<pg:pager maxPageItems="5" scope="request"
										data="userCheckInOrg" isList="false">
										<pg:param name="userID" value="<%=userID %>" />
										<pg:param name="orgID" value="<%=orgID %>" />
										<tr class="labeltable_middle_td">
											<!--设置分页表头-->
											<td class="headercolor" width="6%">
												
											</td>
											<td height='20' class="headercolor">
												被调用户
											</td>
											<td height='20' class="headercolor">
												调入机构
											</td>
											<td height='20' class="headercolor">
												调入类型
											</td>
											<td height='20' class="headercolor">
												开始时间
											</td>
											<td height='20' class="headercolor">
												缓冲时间
											</td>
											<td height='20' class="headercolor">
												结束时间
											</td>
											<td height='20' class="headercolor">
												结束时操作
											</td>
										</tr>
										<!--检测当前页面是否有记录-->
										<pg:notify>
											<tr height='25' class="labeltable_middle_tr_01">
												<td colspan=100 align='center'>
													暂时没有调出用户
												</td>
											</tr>
										</pg:notify>

										<!--list标签循环输出每条记录-->
										<pg:list>
										<%userIDs.append(dataSet.getString("user_id")).append(","); %>
											<tr class="labeltable_middle_tr_01">
												<td class="tablecells" nowrap="true">
													<P align="left">
														<INPUT type="radio" name="checkRadioOne"															
															value='<pg:cell colName="user_id" defaultValue=""/>:<pg:cell colName="org_id" defaultValue=""/>'>
													</P>
												</td>
												<td height='20' align="center" class="tablecells">
													<pg:cell colName="user_realname" />
												</td>
												<td height='20' align="center" class="tablecells">
													<pg:cell colName="org_name" />
												</td>
												<td height='20' align="center" class="tablecells">
													<pg:cell colName="change_name" />
												</td>
												<td height='20' align="center" class="tablecells">
													<pg:cell colName="start_time" />
												</td>
												<td height='20' align="center" class="tablecells">
													<pg:cell colName="cache_time" />
												</td>
												<td height='20' align="center" class="tablecells">
													<pg:cell colName="end_time" />
												</td>
												<td height='20' align="center" class="tablecells">
													<pg:equal colName="end_operation" expressionValue="0">仅提醒</pg:equal>
													<pg:equal colName="end_operation" expressionValue="1">自动调回</pg:equal>
												</td>
											</tr>
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
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<hr/>
								选择同步应用
								<div style="border:0px solid ; padding:5px;height:200px;overflow:auto;" > 
								<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">									
									<pg:listdata dataInfo="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.menu.UserCheckOutOrgSelAppList" keyName="userCheckOutOrgSelAppList" />
									<!--分页显示开始,分页标签初始化-->
									<pg:pager maxPageItems="10" scope="request" data="userCheckOutOrgSelAppList" isList="true">
										<tr class="labeltable_middle_td">
											<!--设置分页表头-->
											<td class="headercolor" width="6%">
												<P align="left">
													<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
												</P>
											</td>
											<td height='20' class="headercolor">
												应用ID
											</td>
											<input class="text" type="hidden" name="selectId">
											<input name="delSingle" type="hidden" validator="string" maxlength="100" value="false">
											<td height='20' class="headercolor">
												应用名称
											</td>														
											<td height='20' class="headercolor">
												描述
											</td>
											<td height='20' class="headercolor">
												状态
											</td>
										</tr>
										<!--检测当前页面是否有记录-->
										<pg:notify>
											<tr height='25' class="labeltable_middle_tr_01">
												<td colspan=100 align='center'>
													暂时没有应用
												</td>
											</tr>
										</pg:notify>
				
										<!--list标签循环输出每条记录-->
										<pg:list>
											<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" id="app_<pg:cell colName="app_id" defaultValue=""/>"
												enablestatus="<pg:cell colName="enablestatus" defaultValue=""/>">
												<td class="tablecells" nowrap="true">
													<P align="left">
														<INPUT type="checkbox" name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="app_id" defaultValue=""/>'
														<%														
														if(userCheckOrgDBManager.isUserExist(userIDs.toString(),dataSet.getString("app_id"))){
														%>
														checked="checked"
														<%}%>
														>
													</P>
												</td>
												<td height='20' align=left class="tablecells">
													<pg:cell colName="app_id" defaultValue="" />
												</td>
												<td height='20' align=left class="tablecells">
													<pg:cell colName="app_name" defaultValue="" />
												</td>								
												<td height='20' align=left class="tablecells">
													<pg:cell colName="remark" defaultValue="" />
												</td>
												<td height='20' align=left class="tablecells">
													<pg:equal colName="enablestatus" expressionValue="0">已注销</pg:equal>
													<pg:equal colName="enablestatus" expressionValue="1">已激活</pg:equal>
												</td>
										</pg:list>
										<tr height="30" class="labeltable_middle_tr_01">
											<td colspan=100 align="center">
												共
												<pg:rowcount />
												条记录
												<pg:index />
											</td>
										</tr>
									</pg:pager>
								</table>
								</div>
							</td>
						</tr>
					</table>
				</fieldset>
				<div align="center">
					<table width="35%" border="0" align="right" cellpadding="0"
						cellspacing="0">
						<tr>
							<td>
								<div align="left">
									<input name="Submit" type="button" class="input" value="上一步"
										onclick="jumpPage()">
									<input type="button" class="input" value="修改" onclick="edit()">
									<input type="button" class="input" value="调回" onclick="save()">
									<input type="button" class="input" value="关闭" onclick="removeAlertWindows('',true);">
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</form>
	</body>
</html>
