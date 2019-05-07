<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.dbmanager.UserCheckInOrgDBManager"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.bean.UserChangeOrgDateBean"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.dbmanager.UserCheckOrgDBManager"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request, response);

	String userorgid = StringUtil.replaceNull(request
			.getParameter("userorgid"), "");
	String userID = "";
	String orgID = "";
	if(null!=userorgid && !userorgid.trim().equals("")){
		String[] temp = userorgid.split(":");
		if(temp.length==2){
			userID = temp[0];
			orgID = temp[1];
		}
	}
	
	UserCheckOrgDBManager userCheckOrgDBManager = new UserCheckOrgDBManager();
	UserCheckInOrgDBManager userCheckInOrgDBManager = new UserCheckInOrgDBManager();
	UserChangeOrgDateBean userChangeOrgDateBean = userCheckInOrgDBManager
			.getUserChangeOrgDateBeanByUserID(userID,orgID);
	
	boolean isUserCacheType = userCheckOrgDBManager.isUserCacheType(userID,orgID,null);
%>
<html>
	<head>
		<title>用户调出修改</title>

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
		<script language="javascript" type="text/javascript" src="pageGrey.js">
		</script>

		<!-- dwr begin-->
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/engine.js'></script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/util.js'></script>
		<script language="javascript" type="text/javascript"
			src='<%=request.getContextPath()%>/dwr/interface/userCheckOrgDWRManager.js'></script>
		<!-- dwr end -->

		<script language="JavaScript" type="text/javascript">
		function init(){
			document.myform.reset();
			var editbuttion = document.myform.editbuttion;
			var resetbuttion = document.myform.resetbuttion;
			if("0"=="<%=userChangeOrgDateBean.getChange_type()%>"){
				editbuttion.disabled=true;
				resetbuttion.disabled=true;
			}else{
				var end_time = document.myform.end_time;
				var cache_time = document.myform.cache_time;
				var selSecondEndOperation=document.myform.selSecondEndOperation;
				end_time.value = "<%=userChangeOrgDateBean.getEnd_time()%>";
				cache_time.value = "<%=userChangeOrgDateBean.getCache_time()%>";
				for(var i=0;i<selSecondEndOperation.options.length;i++){
					if(selSecondEndOperation.options[i].value=="<%=userChangeOrgDateBean.getEnd_operation()%>"){
						selSecondEndOperation.options[i].selected=true;
					}
				}
			}
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
		function edit() {
			if("0"=="<%=userChangeOrgDateBean.getChange_type()%>"){
				alert("兼职用户不能被修改！");
			}else{
				var end_time_value = document.myform.end_time.value;
				var cache_time_value = document.myform.cache_time.value;
				var selSecondEndOperation_value = document.myform.selSecondEndOperation.value;
				var selapp = getSelApp();
				if(cache_time_value==""){
					alert("请选择借调缓冲期！");
					return false;
				}
				if(end_time_value==""){
					alert("请选择借调结束期！");
					return false;
				}
				var cacheDate = new Date(cache_time_value.replace(/-/g, "/")); 
				var endDate = new Date(end_time_value.replace(/-/g, "/"));
				
				if(cacheDate.getTime()-endDate.getTime()>0){
					alert("借调缓冲期不能大于借调结束期！");
					return false;
				}
				
				if(selSecondEndOperation_value==""){
					alert("请选择借调期结束操作！");
					return false;
				}
				//提交后页面变灰
				popSignFlow(1);
				userCheckOrgDWRManager.editUserCheckInOrgBySecondUser("<%=userID%>","<%=orgID%>",cache_time_value,end_time_value,selSecondEndOperation_value,selapp,editResult);
			}
		}
		function editResult(obj){
			DWREngine.setPreHook(function() {});				
			DWREngine.setPostHook(function() {});
			
			//页面变灰恢复正常
			cancelSign();
			if(obj[0]=="false"){
				alert(obj[1]);
			}else{
				alert("修改成功！");
				window.returnValue = "ok";
				window.close();
			}
		}
</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no" onload="init();">
		<form name="myform" action="userCheckInOrg.jsp" method="post">
			<div id="contentborder" align="center">
				<br />
				<br />
				<fieldset style="width: 90%; height: 500px;">
					<LEGEND align=center>
						<FONT size="2">用户调出修改</FONT>
					</LEGEND>
					<br />
					<table width="85%" class=thin>
						<tr>
							<td align="right" >
								被调用户：
							</td>
							<td align="left">
								<%=userChangeOrgDateBean.getUser_realname()%>
							</td>
						</tr>
						<tr>
							<td align="right">
								调入机构：
							</td>
							<td align="left">
								<%=userChangeOrgDateBean.getOrg_name()%>
							</td>
						</tr>
						<tr>
							<td align="right">
								调入类型：
							</td>
							<td align="left">
								<%=userChangeOrgDateBean.getChange_name()%>
							</td>
						</tr>
						<tr>
							<td align="right">
								开始时间：
							</td>
							<td align="left">
								<%=userChangeOrgDateBean.getStart_time()%>
							</td>
						</tr>
						<%if("1".equals(userChangeOrgDateBean.getChange_type())){ %>
						<tr>
							<td align="right">
								借调缓冲期：
							</td>
							<%if(isUserCacheType){ %>
							<td align="left">								
								<input type="text"
									value="<%=userChangeOrgDateBean.getCache_time()%>"
									name="cache_time" id="cache_time"
									readonly="readonly">
								缓冲期已结束，不能修改
							</td>
							<%}else{ %>
							<td align="left">
								<input type="text"
									value="<%=userChangeOrgDateBean.getCache_time()%>"
									name="cache_time" id="cache_time" onClick="showdate(this)"
									readonly="readonly">
							</td>	
							<%} %>
						</tr>
						<tr>
							<td align="right">
								借调结束期：
							</td>
							<td align="left">
								<input type="text"
									value="<%=userChangeOrgDateBean.getEnd_time()%>"
									name="end_time" id="end_time" onClick="showdate(this)"
									readonly="readonly">
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
						<tr>
							<td colspan="2" align="center">
								<hr/>
								选择同步应用
								<div style="border:0px solid ; padding:5px;height:250px;overflow:auto;" > 
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
						<%} %>
					</table>
				</fieldset>
				<div align="center">
					<table width="25%" border="0" align="right" cellpadding="0"
						cellspacing="0">
						<tr>
							<td>
								<div align="left">
									
									<input type="button" name="editbuttion" class="input" value="修改" onclick="edit();">									
									<input type="button" name="resetbuttion" class="input" value="重置" onclick="init();">
									<input type="button" class="input" value="返回" onclick="window.close();">
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</form>
	</body>
</html>
