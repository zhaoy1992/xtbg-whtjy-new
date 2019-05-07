<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.workflow.business.model.AssignmentDevolveManager"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
 
<%@page import="com.chinacreator.security.AccessControl"%>
<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="../../css/windows.css">
<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
<%AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);
			String userId = accesscontroler.getUserID();

		%>
<script language="JavaScript">
function canceldevolve(procDefId)
{

var popmsg="您确信要取消委托吗？";
if(confirm(popmsg))
{
location.href='canceldevolve.jsp?procDefId='+procDefId;
}
}

function selectprocess(procDefId,procDefName)
{

window.open('selectprocess.jsp?procDefName='+procDefName+'&procDefId='+procDefId,'newwindow','height=150,width=600,top=300,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
}

function cancelall()
{
var popmsg="您确信要取消所有委托吗?";
if(confirm(popmsg))
{
location.href='cancelall.jsp';
}
}

function devolveall()
{
var popmsg="您确信要全部委托吗？";
if(confirm(popmsg))
{

window.open('selectprocess.jsp?procDefId=all'+'&procDefName=全部流程','newwindow','height=150,width=600,top=300,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
}
}

</script>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

		<title>任务委托</title>

	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form>
				<table width="100%" cellpadding="1" cellspacing="1" bordercolor="#EEEEEE">
					<tr>
						<td height='30' class="detailtitle" align=center colspan=8>
							<b>流程权限列表</b>
						</td>
					</tr>
					<pg:listdata dataInfo="AssignmentDevolveList" keyName="AssignmentDevolveList" />

					<pg:pager maxPageItems="10" scope="request" data="AssignmentDevolveList" isList="false">
						<tr>
							<!--设置分页表头-->
							<th class="headercolor">
								#
							</th>
							<!--序号-->
							<th class="headercolor">
								流程名称
							</th>
							<th class="headercolor">
								包名称
							</th>
							<th class="headercolor">
								版本号
							</th>
							<th class="headercolor">
								代理人
							</th>
							<th class="headercolor">
								开始时间
							</th>
							<th class="headercolor">
								结束时间
							</th>
							<th class="headercolor">
								操作
							</th>


						</tr>

						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height="18px">
								<td colspan=100 align='center'>
									暂时没有流程
								</td>
							</tr>
						</pg:notify>


						<pg:list>
							<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'")" >

								<td height='20' align=center class="tablecells">
									<pg:rowid increament="1" offset="true"/>
								</td>
								<td height='20' align=center class="tablecells">
									<pg:cell colName="procDefName" defaultValue=" " />
								</td>
								<td height='20' align=center class="tablecells">
									<pg:notnull colName="procDescript">
										<pg:cell colName="pkgName" defaultValue=" " />
									</pg:notnull>
								</td>
								<td height='20' align=center class="tablecells">
									version
									<pg:cell colName="version" defaultValue=" " />
								</td>
								<td height='20' align=center class="tablecells">
									<pg:equal colName="agentName" value="">&nbsp;</pg:equal>
									<pg:cell colName="agentName" defaultValue="" />
								</td>
								<td height='20' align=center class="tablecells">
									<pg:notnull colName="startTime">
										<pg:equal colName="startTime" value="">&nbsp;</pg:equal>
										<pg:cell colName="startTime" defaultValue="" />
									</pg:notnull>
									<pg:null colName="startTime">&nbsp;</pg:null>
								</td>
								<td height='20' align=center class="tablecells">
									<pg:notnull colName="endTime">
									<pg:equal colName="endTime" value="">&nbsp;</pg:equal>
										<pg:cell colName="endTime" defaultValue=" " />
									</pg:notnull>
									<pg:null colName="endTime">&nbsp;</pg:null>
								</td>
								<td height='20' align=center class="tablecells">
									<pg:equal colName="isHasDevolved" value="true">
										<input type=button class="input" onclick="canceldevolve('<pg:cell colName="procDefId" defaultValue=""/>')" value=" 取消委托">
									</pg:equal>
									<pg:equal colName="isHasDevolved" value="false">
										<input type=button class="input" onclick="selectprocess('<pg:cell colName="procDefId" defaultValue=""/>','<pg:cell colName="procDefName" defaultValue=""/>')" value="任务委托">
									</pg:equal>

								</td>

							</tr>
						</pg:list>
						<tr height="18px">
							<td colspan=100 align='right' class="detailcontent">
								<input type=button class="devolveinput" onclick="javascript:cancelall()" value="取消所有委托">
								<input type=button class="input" onclick="devolveall()" value="全权委托">
							</td>
						</tr>
						<tr height="18px">
							<td colspan=100 align='center' class="detailcontent">
								共<pg:rowcount/>条记录
								<pg:index />
								<input type="hidden" name="queryString" value="<pg:querystring/>">
							</td>
						</tr>
					</pg:pager>

				</table>
			</form>
		</div>
<%@include file="../../sysMsg.jsp" %>
	</body>
</html>
