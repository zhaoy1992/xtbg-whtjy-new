<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	//清除页面ie缓存
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
    response.setHeader("Pragma","no-cache");//HTTP 1.0 
    response.setDateHeader ("Expires", -1);
    response.setDateHeader("max-age", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%
			String path_ = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path_ + "/";
		%>
		<title>选项查看</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<script language="javascript" src="../inc/js/func.js"></script>

	</head>

	<script language="JavaScript" src="../include/pager.js"
		type="text/javascript"></script>
	<script language="JavaScript"
		src="<%=basePath%>sysmanager/scripts/selectTime.js"></script>
	<script src="<%=basePath%>public/datetime/calender.js"
		language="javascript"></script>
	<script src="<%=basePath%>public/datetime/calender_date.js"
		language="javascript"></script>
		<link href="css/main.css" rel="stylesheet" type="text/css">
	<SCRIPT language="javascript" src="js/ans_list.js">
   </SCRIPT>
	<%
		AccessControl accesscontroler = AccessControl.getInstance();
		accesscontroler.checkAccess(request, response);

		String deptID = accesscontroler.getChargeOrgId();
		String deptName = accesscontroler.getChargeOrgName();
		String channel = request.getParameter("channel");

		if (accesscontroler.isAdmin()
				|| accesscontroler.isGrantedRole(channel + "管理员")) {
			deptName = "admin";
		}

		session.setAttribute("deptID", deptID);
		session.setAttribute("deptName", deptName);
	%>
	<body>


		<form name="voteList" method="post">
			<input name="channelid" id="channelid" type="hidden">
			<input name="channel" id="channel" type="hidden" value="<%=channel%>">

					<table width="98%" border="0" cellpadding="0" align="center"
						cellspacing="0" class="query_box">
						<tr>
							<td>
								<table width="100%" border="0"  class="table01">
									<tr>
										<td height="23">
											&nbsp; 当前位置:<%=channel%> >> 意见审核</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
															<table width="100%" border="0" align="center" cellpadding="0"
									cellspacing="0" class="table02">
									<tr>
										<td align="right" width="12%">
											问卷标题：										</td>
										<td align="center" valign='middle' width="26%">
											<div align="left">
												<%
													String surveyTitle = request.getParameter("surveyTitle");
												%>
												<input type="hidden" name="channel" value="<%=channel%>" />
												<input name="surveyTitle" id="surveyTitle" type="text"
													size="16" class="cms_text"
													value="<% if(surveyTitle!=null&&!surveyTitle.equals("")) out.print(surveyTitle);%>">
											</div>										</td>
										<td  align="right" width="17%">
											是否审核：										</td>
										<td colspan="2" align="left" valign='middle'>
											<input name="active" id="active" type="radio" value="1" />
											审核
											<input name="active" id="active" type="radio" value="0" />
											未审核
											<input name="active" id="active" type="radio" value="2"
												checked />
											全部										</td>
									</tr>
									<tr>
										<td align="right" width="12%">
											创建时间从：										</td>
										<td align="left" valign='middle'>
											<div align="left">
												<%
													String createDateFrom = request.getParameter("createDateFrom");
												%>
												<input name="createDateFrom" id="createDateFrom" type="text"
													size="16" readonly class="cms_text"
													value="<% if(createDateFrom!=null&&!createDateFrom.equals("")) out.print(createDateFrom);%>">
												<input name="button" type="button"
													onClick="showdate(document.all('createDateFrom'))"
													value="..." class="button1"/>
											</div>										</td>
										<td align="right">到：</td>
										<td width="26%" align="center" valign='middle'>
											<div align="left">
												
											    <%
													String createDateTo = request.getParameter("createDateTo");
												%>
												<input name="createDateTo" id="createDateTo" type="text"
													size="16" readonly class="cms_text"
													value="<% if(createDateTo!=null&&!createDateTo.equals("")) out.print(createDateTo);%>">
												<input name="button" type="button"
													onClick="showdate(document.all('createDateTo'))"
													value="..." class="button1"/>
											</div>
											<div align="right"></div></td>
									    <td width="19%" height='30' align="center" valign='middle'><input name="search" type="button" class="button2"value=" 查 询 " onClick="return cleanpart();">&nbsp;
                                          <input name="search" type="button" class="button2"value="显示所有" onClick="return clean();"></td>
									</tr>
							  </table>
							</td>
						</tr>
				  </table>
			<table width="98%" border="0" align="center" cellpadding="5" cellspacing="0"
				class="Atable">
				<!--分页显示开始,分页标签初始化-->
				<pg:listdata dataInfo="com.chinacreator.cms.votemanager.Votelist"
					keyName="Votelist" />

				<pg:pager maxPageItems="30" scope="request" data="Votelist"
					isList="false">
					<!--检测当前页面是否有记录-->
					<!--list标签循环输出每条记录-->
					<TR class="cms_report_tr">
						<!--设置分页表头-->
						<td   class="c1" align="center" width="2%" ></td>
						<TD width="2%"   class="c1" align="center" >
							<INPUT type="checkbox" name="checkBoxAll"
								onclick="checkAll('checkBoxAll','checkBoxOne')" value="on"
								class="checkbox">
						</TD>
						<TD   class="c1" align="center" width="9%">
							问卷号
						</TD>
						<TD   class="c1" align="center" width="7%">
							置顶
						</TD>
						<TD   class="c1" align="center">
							问卷标题
						</TD>
						<TD   class="c1" align="center">
							所属部门
						</TD>
						<TD   class="c1" align="center" width="7%">
							审核
						</TD>
						<TD   class="c1" align="center" width="10%">
							创建时间
						</TD>
						<TD   class="c1" align="center" width="10%">
							创建人
						</TD>
						<TD   class="c1" align="center" width="10%">
							操作
						</TD>

					</TR>
					<pg:param name="id" />
					<pg:param name="name" />
					<pg:param name="state" />
					<pg:param name="foundername" />
					<pg:param name="surveyTitle" />
					<pg:param name="active" />
					<pg:param name="createDateFrom" />
					<pg:param name="createDateTo" />
					<pg:param name="channel" />

					<%int j = 0; %>
					<pg:list>
					<%
						
						
						j++;
						
					%>
						<tr  <%if(j%2==1) out.print("bgcolor=#EEF2F7"); %>>
							<td class="tablecells" nowrap="nowrap" width="3%" align="center">
								<div align="left">
									<img src="../images/note.gif" width="16" height="15">
								</div>
							</td>
							<td class="tablecells" align="center">
								<INPUT type="checkbox" name="checkBoxOne"
									onclick="checkOne('checkBoxAll','checkBoxOne')"
									value='<pg:cell colName="id" defaultValue=""/>'>
							</td>
							<td class="tablecells" nowrap="true" align="center">
								<pg:cell colName="id" defaultValue="" />
							</td>
							<td class="tablecells" nowrap="nowrap" align="center">
								<pg:equal colName="isTop" value="1">
									<font color="#ff0000">置顶</font>
								</pg:equal>

							</td>
							<td class="tablecells" nowrap="true"
								title="点击这里查看详细信息"
								onClick="audit('<pg:cell colName='id' defaultValue=''/>')"
								style="cursor: hand" align="center">
								<pg:cell colName="name" maxlength="20" replace="..."
									defaultValue="" />
							</td>

							<td class="tablecells" nowrap="true" align="center">
								<pg:cell colName="depart_name" defaultValue="" />
							</td>
							<td class="tablecells" nowrap="nowrap" align="center">
								<pg:equal colName="active" value="0">否</pg:equal>
								<pg:equal colName="active" value="1">是</pg:equal>
							</td>
							<td class="tablecells" nowrap="true" align="center">
								<pg:cell colName="foundDate" defaultValue="" />
							</td>
							<td class="tablecells" nowrap="true" align="center">
								<pg:cell colName="foundername" defaultValue="" />
							</td>
							<td class="tablecells" nowrap="true" align="center">
								<%
									if ((channel.equals("网上调查") && accesscontroler
																.checkPermission("dchmanager1",
																		"adviceaudit", "answerManager"))
																|| (channel.equals("网上测评") && accesscontroler
																		.checkPermission(
																				"wscpManager_1",
																				"adviceaudit",
																				"wscpAnswerManager")))
														//if(accesscontroler.checkPermission("dchmanager1","adviceaudit","answerManager"))
														{
								%>
								<a  href="#"
									onclick="audit('<pg:cell colName='id' defaultValue=''/>')" />
									意见审核</a>
								<%
									} else {
								%>无权限<%
									}
								%>
							</td>
						</tr>
					</pg:list>
					<tr>
						<td colspan=11 align="right" class="c2">
							共
							<pg:rowcount />
							条记录
							<pg:index />
						</td>

					</tr>

					<P align="center">
						<input name="queryString" value="<pg:querystring/>" type="hidden">
					</P>
				</pg:pager>

		  </table>
			<input type="hidden" value="" name="actioinType">
		</form>
	</body>
</html>

<SCRIPT language="javascript">


function clean(){
    document.all("surveyTitle").value= "";
	document.all("createDateFrom").value = "";
	document.all("createDateTo").value = "";
	document.all("active")[2].checked = true;
	document.voteList.submit();
}

function cleanpart(){
	document.voteList.action="voteAnswerlist.jsp?actionType=search";
	
	var createDateFrom = document.all.createDateFrom.value;
	var createDateTo = document.all.createDateTo.value;
	if(createDateTo.length>0 && createDateFrom.length>0)
	if(createDateTo<createDateFrom)
	{
		alert("结束时间不能小于开始时间!");
		return false;
	}
	//bug432:结束时间不能小于开始时间,weida
	
	document.voteList.submit();
}
	
</script>