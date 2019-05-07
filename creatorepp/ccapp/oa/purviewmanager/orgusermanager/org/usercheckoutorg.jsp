<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../../../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.dbmanager.UserCheckOutOrgDBManager"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.api.UserCheckOrgFactory"%>
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
	String userNames = userCheckOutOrgDBManager
			.getUserNameStrByUserIDs(userID);
	//屏蔽被借调用户  彭盛 2011-3-10
	StringBuffer secondUserName = new StringBuffer();
	boolean isSecondUser = UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUser(userID,secondUserName);
	
	//是否拥有超级管理员角色
	StringBuffer adminName = new StringBuffer();
	boolean isRoleAdmin = false;
	if(!isSecondUser){
		isRoleAdmin = userCheckOutOrgDBManager.isRoleAdmin(accesscontroler,userID,adminName);		
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
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js"
			type="text/javascript"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>
		<!-- 提交后页面变灰 -->
		<script language="javascript" type="text/javascript" src="pagegrey.js" charset="utf-8">
		</script>
		
		<!-- dwr begin-->
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/interface/userCheckOrgDWRManager.js'></script>
		<!-- dwr end -->

		<script language="JavaScript" type="text/javascript">
			function init() {
				//提交后页面变灰
				popSignFlow(1);
				if("<%=userID%>"==""){
					alert("请选择需要调出的用户！");
					window.close();				
				}
				if("<%=orgID%>"==""){
					alert("机构ID为空！");
					window.close();	
				}
				if("<%=isSecondUser%>"=="true"){
					alert("不能调出被借调用户：<%=secondUserName%>");
					window.close();	
				}
				if("<%=isRoleAdmin%>"=="true"){
					alert("不能调出超级管理员用户：<%=adminName%>");
					window.close();
				}
				//页面变灰恢复正常
				cancelSign();
			}
		
			//得到选择的机构ID
			function getSelOrgID(){
				var checkbox = document.getElementsByName("selorgid");
				var selorgid = "";
				for(var i=0;i<checkbox.length;i++){
					if(checkbox[i].checked){
						selorgid += checkbox[i].value+",";
					}
				}
				return selorgid;
			}
			//得到调出方式
			function getOperationSel(){
				var operationSel = document.getElementsByName("operation_sel");
				for(var i=0;i<operationSel.length;i++){
					if(operationSel[i].checked){
						return operationSel[i].value;
					}
				}
				return 0;
			}
			//得到借调期结束操作方式
			function getSelSecondEndOperation(){				
				return document.myform.selSecondEndOperation.value;
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
				var selorgid = getSelOrgID();
				var operationsel = getOperationSel();
				var cacheTime = document.getElementById("cache_time").value;
				var endTime = document.getElementById("end_time").value;
				var selsecondendoperation = getSelSecondEndOperation();
				var selapp = getSelApp();
				
				if(selorgid==""){
					alert("请选择调入的机构！");
					return false;
				}
				if(operationsel==0){
					alert("请选择调出的方式（兼职、借调）！");
					return false;
				}else{
					if(operationsel=="second"){
						if(cacheTime==""){
							alert("请选择借调缓冲期！");
							return false;
						}
						if(endTime==""){
							alert("请选择借调结束期！");
							return false;
						}
						var cacheDate = new Date(cacheTime.replace(/-/g, "/")); 
						var endDate = new Date(endTime.replace(/-/g, "/"));
						var currDate = new Date();
						
						if(currDate.getTime()-endDate.getTime()>0){
							alert("借调结束期不能小于当前时间！");
							return false;
						}
						
						if(cacheDate.getTime()-endDate.getTime()>0){
							alert("借调缓冲期不能大于借调结束期！");
							return false;
						}
						
						if(selsecondendoperation==""){
							alert("请选择借调期结束操作！");
							return false;
						}
					}
					//提交后页面变灰
					popSignFlow(1);
					
					userCheckOrgDWRManager.saveUserCheckOutOrg("<%=userID%>",selorgid,operationsel,cacheTime,endTime,selsecondendoperation,selapp,saveResult);
				}
			}
			function saveResult(obj){
				DWREngine.setPreHook(function() {});				
				DWREngine.setPostHook(function() {});
				
				//页面变灰恢复正常
				cancelSign();
				if(obj[0]=="false"){
					alert(obj[1]);
				}else{
					alert("调出成功！");
					window.returnValue = "ok";
					window.close();
				}
			}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no" onload="init()">
		<form name="myform" action="usercheckoutorg.jsp" method="post">
			<div id="contentborder" align="center">
				<br />
				<br />
				<fieldset style="width: 90%;height: 500px;">
					<LEGEND align=center>
						<FONT size="2">用户调出选择</FONT>
					</LEGEND>
					<br />
					<table width="85%">
						<tr>
							<td colspan="2" align="center">
								需要调出的用户：<%=userNames%>
								<hr/>								
							</td>
						</tr>
						<tr>
							<td width="35%"></td>
							<td align="left" width="65%">
							<div style="border:0px solid ; padding:5px;height:200px;overflow:auto;" > 
								<tree:tree tree="org_tree_userorgmanager" node="org_tree.node"
									imageFolder="../../../../../purviewmanager/images/tree_images/" collapse="true"
									includeRootNode="true" href="../../../../../purviewmanager/userorgmanager/user/userquery_content_tab.jsp"
									target="org_userlist" mode="static-dynamic">
									<tree:param name="orgID" value="<%=orgID %>" />
									<tree:param name="userID" value="<%=userID %>" />
									<tree:checkbox name="selorgid" />
									<tree:treedata
										treetype="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.menu.UserCheckOutOrgTree"
										scope="request" rootid="0" rootName="机构树" expandLevel="1"
										showRootHref="false" needObserver="false"
										enablecontextmenu="false" />
								</tree:tree>
							</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<hr/>
								<input type="radio" name="operation_sel" value="part"
									checked="checked" onclick="showSecondOperation('part')" />
								兼职调动 &nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="operation_sel" value="second"
									onclick="showSecondOperation('second')" />
								借调调动
								<div style="display: none;" id="second_operation">
									<table width="85%">
										<tr>
											<td align="right">
												借调缓冲期：
											</td>
											<td align="left">
												<input type="text" name="cache_time" id="cache_time"
													onClick="showdate(this)" readonly="readonly" style="cursor: hand;">
											</td>
										</tr>
										<tr>
											<td align="right">
												借调结束期：
											</td>
											<td align="left">
												<input type="text" name="end_time" id="end_time"
													onClick="showdate(this)" readonly="readonly" style="cursor: hand;">
											</td>
										</tr>
										<tr>
											<td align="right">
												借调期结束操作：
											</td>
											<td align="left">
												<select name="selSecondEndOperation" class="select">
													<option value="0" selected>
														仅提醒
													</option>
													<option value="1">
														自动调回
													</option>
												</select>
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
								<hr/>
								选择同步应用
								<div style="border:0px solid ; padding:5px;height:150px;overflow:auto;" > 
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
														if(userCheckOrgDBManager.isUserExist(userID,dataSet.getString("app_id"))){
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
					<table width="25%" border="0" align="right" cellpadding="0"
						cellspacing="0">
						<tr>
							<td>
								<div align="left">
									<input name="Submit" type="button" class="input" value="上一步"
										onClick="jumpPage()">
									<input type="reset" class="input" value="重置"
										onclick="showSecondOperation('part')">
									<input type="button" class="input" value="调出" onclick="save()">
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</form>
	</body>
</html>
