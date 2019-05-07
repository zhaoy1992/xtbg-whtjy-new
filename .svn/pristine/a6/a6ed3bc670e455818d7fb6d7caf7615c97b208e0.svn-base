<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	//用户信息（用户真实名称：用户帐号[用户ID]）
	String userInfo = control.getUserAttribute("userAccount") + ":"
			+ control.getUserAttribute("userName") + "["
			+ control.getUserAttribute("userID") + "]  ";
	//操作的ip地址
	String remoteAddr = request.getRemoteAddr();

	String action = (String) request.getAttribute("action");

	String app_id = request.getParameter("app_id") != null ? request
			.getParameter("app_id") : "";
	String remark = request.getParameter("remark") != null ? request
			.getParameter("remark") : "";
%>
<html>
	<head>
		<title>应用删除</title>

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js" type="text/javascript"></script>

		<!-- dwr begin-->
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/engine.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/util.js'> </script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/interface/applyChange.js'></script>
		<!-- dwr end -->
		
		<!-- 提交后页面变灰 -->
		<script language="javascript" type="text/javascript" src="../pageGrey.js" ></script>
		
		<script language="JavaScript">
		
		function delApply(){
			//提交后页面变灰
			popSignFlow(1);
			applyChange.delApply("<%=app_id%>","<%=userInfo%>","<%=remoteAddr%>",result);
		}
		
		function result(obj){
			alert(obj);
			window.close();
			window.returnValue="refresh";
		}
	

</script>
		<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no" onLoad="<%if(action!=null)out.print("updateAfter()");%>">
		<div id="contentborder" align="center">
			<form name="ApplyForm" action="applyinfo.jsp" method="post">
				<input type="hidden" name="app_id" value="<%=app_id%>">
				<br>
				<br>
				<fieldset style="width: 90%;">
					<LEGEND align=center>
						<FONT size="2">应用删除</FONT>
					</LEGEND>
					<br />
					<table width="100%" border="0" cellpadding="0" cellspacing="1" class="thin">


						<pg:listdata dataInfo="com.chinacreator.epp.applymanager.menu.DelApplyList" keyName="ApplyList" />
						<!--分页显示开始,分页标签初始化-->
						<pg:pager maxPageItems="10" scope="request" data="ApplyList" isList="false">
							<pg:param name="app_id" />
							<tr class="labeltable_middle_td">
								<!--设置分页表头-->
								<td height='20' class="headercolor">
									应用名称
								</td>
								<input class="text" type="hidden" name="selectId">
								<input name="delSingle" type="hidden" validator="string" maxlength="100" value="false">
								<td height='20' class="headercolor">
									数据库用户名
								</td>
								<td height='20' class="headercolor">
									缺省表空间
								</td>
								<td height='20' class="headercolor">
									临时表空间
								</td>
								<%--<td height='20' class="headercolor">
								文件夹名称
							</td>
							<td height='20' class="headercolor">
								访问路径
							</td>--%>
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
								<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" onclick="getApplyInfo(this,'<pg:cell colName="app_id" defaultValue=""/>')" onDBLclick="editApply()" id="app_<pg:cell colName="app_id" defaultValue=""/>"
									enablestatus="<pg:cell colName="enablestatus" defaultValue=""/>">

									<td height='20' align=left class="tablecells">
										<pg:cell colName="app_name" defaultValue="" />
									</td>
									<td height='20' align=left class="tablecells">
										<pg:cell colName="dbuser" defaultValue="" />
									</td>
									<td height='20' align=left class="tablecells">
										<pg:cell colName="deftablespace" defaultValue="" />
									</td>
									<td height='20' align=left class="tablecells">
										<pg:cell colName="temptablespace" defaultValue="" />
									</td>
									<%--<td height='20' align=left class="tablecells">
									<pg:cell colName="workfoledr" defaultValue="" />
								</td>
								<td height='20' align=left class="tablecells">
									<pg:equal colName="enablestatus" expressionValue="0">
										<pg:cell colName="accpath" defaultValue="" />
									</pg:equal>

									<pg:equal colName="enablestatus" expressionValue="1">
										<a href='<pg:cell colName="accpath" defaultValue="" />'
											target="new"> <pg:cell colName="accpath" defaultValue="" />
										</a>
									</pg:equal>
								</td>--%>
									<td height='20' align=left class="tablecells">
										<pg:cell colName="remark" defaultValue="" />
									</td>
									<td height='20' align=left class="tablecells">
										<pg:equal colName="enablestatus" expressionValue="0">已注销</pg:equal>
										<pg:equal colName="enablestatus" expressionValue="1">已激活</pg:equal>
									</td>
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
				</fieldset>
				<%
				if (control.isAdmin()) {
				%>
				<input type="button" class="input" value="确认删除" onClick="delApply();">
				<%
				}
				%>

				<div align="center">
				</div>
			</form>
		</div>

	</body>
</html>
