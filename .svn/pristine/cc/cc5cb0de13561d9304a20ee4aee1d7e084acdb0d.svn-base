<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<%
	String path_ = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path_ + "/";
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
			
	String channel = request.getParameter("channel");
	if (channel == null)
		channel = "";
%>
	<title>选项查看</title>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<script language="javascript" src="../inc/js/func.js"></script>
	<script language="JavaScript" src="../include/pager.js"
		type="text/javascript"></script>
	<script language="JavaScript"
		src="<%=basePath%>sysmanager/scripts/selectTime.js"></script>
	<script src="<%=basePath%>public/datetime/calender.js"
		language="javascript"></script>
	<script src="<%=basePath%>public/datetime/calender_date.js"
		language="javascript"></script>
	<script src="js/list.js" language="javascript"></script>
	<link href="css/main.css" rel="stylesheet" type="text/css">
	</head>
	<%
		AccessControl accesscontroler = AccessControl.getInstance();
		accesscontroler.checkAccess(request, response);

		String deptID = accesscontroler.getChargeOrgId();
		String deptName = accesscontroler.getChargeOrgName();

		if (accesscontroler.isAdmin()
				|| accesscontroler.isGrantedRole(channel + "管理员")) {
			deptName = "admin";
		}

		session.setAttribute("deptID", deptID);
		session.setAttribute("deptName", deptName);
	%>
	<body>


		<form name="voteList" method="post">

			<table width="98%" border="0" align="center" cellspacing="0">
				<tr>
				<td>
					<table width="100%" border="0" cellpadding="0" align="center"
						cellspacing="0">
						<tr>
							<td>
								<table width="100%" border="0"  class="table01">
									<tr>
										<td height="23">
											&nbsp; 当前位置:<%=channel%> >> 主题管理</td>
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
													value="<% if(surveyTitle!=null&&!surveyTitle.equals("")) out.print(surveyTitle);%>" />
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
													value="<% if(createDateFrom!=null&&!createDateFrom.equals("")) out.print(createDateFrom);%>" />
												<input name="button" type="button"
													onClick="showdate(document.all('createDateFrom'))"
													value="..." class="button1"/>
											</div>										</td>
										<td align="right">到：</td>
										<td width="26%" height='30' align="center" valign='middle'>
											<div align="left">
												
											    <%
													String createDateTo = request.getParameter("createDateTo");
												%>
												<input name="createDateTo" id="createDateTo" type="text"
													size="16" readonly class="cms_text"
													value="<% if(createDateTo!=null&&!createDateTo.equals("")) out.print(createDateTo);%>" />
												<input name="button" type="button"
													onClick="showdate(document.all('createDateTo'))"
													value="..." class="button1"/>
											</div>
											<div align="right"></div></td>
									    <td width="19%" align="center" valign='middle'><input name="search" type="button" class="button2"value=" 查 询 " onClick="return cleanpart();" />&nbsp;
                                          <input name="search" type="button" class="button2"value="显示所有" onClick="return clean();"></td>
									</tr>
								</table>
							</td>
						</tr>
				  </table>
				</td>
				</tr>
		  </table>
			<table width="98%" border="0" align="center" cellpadding="5" cellspacing="0"
				class="Atable">
								<tr>
					<td height='25' colspan="11">
						
							<span class="text">操作：</span>
						
						<%
							if ((channel.equals("网上调查") && accesscontroler.checkPermission(
									"dchmanager", "create", "titleManager"))
									|| (channel.equals("网上测评") && accesscontroler
											.checkPermission("wscpManager", "create",
													"wscpTitleManager"))) {
						%>
						
						 <input name="button" type="button" onClick="newq('<%=channel%>')" class="buttons3" value=" 新 增 " />
						<%
							}
							if ((channel.equals("网上调查") && accesscontroler.checkPermission(
									"dchmanager", "delete", "titleManager"))
									|| (channel.equals("网上测评") && accesscontroler
											.checkPermission("wscpManager", "delete",
													"wscpTitleManager")))
							// if(accesscontroler.checkPermission("dchmanager","delete","titleManager"))
							{
						%>
						
						 <input name="button" type="button" onClick="return myAction('delete','<%=channel%>')" class="buttons3" value=" 删 除 " />
						<%
							}
							if ((channel.equals("网上调查") && accesscontroler.checkPermission(
									"dchmanager", "audit", "titleManager"))
									|| (channel.equals("网上测评") && accesscontroler
											.checkPermission("wscpManager", "audit",
													"wscpTitleManager")))
							// if(accesscontroler.checkPermission("dchmanager","audit","titleManager"))
							{
						%>
						
						 <input name="button" type="button" onClick="surveyActivate('<%=channel%>');" class="buttons3" value=" 审 核 " />
						<%
							}
							if ((channel.equals("网上调查") && accesscontroler.checkPermission(
									"dchmanager", "stopaudit", "titleManager"))
									|| (channel.equals("网上测评") && accesscontroler
											.checkPermission("wscpManager", "stopaudit",
													"wscpTitleManager")))
							//if(accesscontroler.checkPermission("dchmanager","stopaudit","titleManager"))
							{
						%>
						
						 <input name="button" type="button" onClick="surveyUnActivate('<%=channel%>');" class="buttons3" value="取消审核" />
						<%
							}
							if ((channel.equals("网上调查") && accesscontroler.checkPermission(
									"dchmanager", "top", "titleManager"))
									|| (channel.equals("网上测评") && accesscontroler
											.checkPermission("wscpManager", "top",
													"wscpTitleManager")))
							//if(accesscontroler.checkPermission("dchmanager","top","titleManager"))
							{
						%>
						
						 <input name="button" type="button" onClick="return myAction('settop','<%=channel%>');" class="buttons3" value="问卷置顶" />
						<%
							}
							if ((channel.equals("网上调查") && accesscontroler.checkPermission(
									"dchmanager", "stoptop", "titleManager"))
									|| (channel.equals("网上测评") && accesscontroler
											.checkPermission("wscpManager", "stoptop",
													"wscpTitleManager")))
							//if(accesscontroler.checkPermission("dchmanager","stoptop","titleManager"))
							{
						%>
						
						 <input name="button" type="button" onClick="return myAction('canceltop','<%=channel%>');" class="buttons3" value="取消置顶" />
						<%
							}
							if ((channel.equals("网上调查") && accesscontroler.checkPermission(
									"dchmanager", "cancellook", "titleManager"))
									|| (channel.equals("网上测评") && accesscontroler
											.checkPermission("wscpManager", "cancellook",
													"wscpTitleManager")))
							// if(accesscontroler.checkPermission("dchmanager","cancellook","titleManager"))
							{
						%>
						
						 <input name="button" type="button" onClick="return myAction('cancellook','<%=channel%>');" class="buttons3" value="取消查看" />
						<%
							}
							if ((channel.equals("网上调查") && accesscontroler.checkPermission(
									"dchmanager", "look", "titleManager"))
									|| (channel.equals("网上测评") && accesscontroler
											.checkPermission("wscpManager", "look",
													"wscpTitleManager")))
							//if(accesscontroler.checkPermission("dchmanager","look","titleManager"))
							{
						%>
						
						 <input name="button" type="button" onClick="return myAction('look','<%=channel%>');" class="buttons3" value="恢复查看" />
						<%
							}
							if ((channel.equals("网上调查") && accesscontroler.checkPermission(
									"dchmanager", "cleartitle", "titleManager"))
									|| (channel.equals("网上测评") && accesscontroler
											.checkPermission("wscpManager", "cleartitle",
													"wscpTitleManager")))
							//if(accesscontroler.checkPermission("dchmanager","cleartitle","titleManager"))
							{
						%>
						
						 <input name="button" type="button" onClick="return myAction('clearvote','<%=channel%>');" class="buttons3" value="投票清零" />
						<%
							}
							if (channel.equals("网上测评")
									&& accesscontroler.checkPermission("wscpManager", "copy",
											"wscpTitleManager")) {
						%>
						
						 <input name="button" type="button" onClick="return myAction('copy','<%=channel%>');" class="buttons3" value="复制测评" />
						<%
							}
							if ((channel.equals("网上调查") && accesscontroler.checkPermission(
									"dchmanager", "questionlist", "titleManager"))
									|| (channel.equals("网上测评") && accesscontroler
											.checkPermission("wscpManager", "questionlist",
													"wscpTitleManager")))
							//if(accesscontroler.checkPermission("dchmanager","questionlist","titleManager"))
							{
						%>
						
						 <input name="button" type="button" onClick="listquestion('<%=channel%>');" class="buttons3" value="问题列表" />
						<%
							}
						%>
						<!-- <a style="cursor:hand" href="vote_tag.jsp"><div class="DocumentOper"><img src="../images/new_doc.gif" class="operStyle">发布预览</div></a>-->
					</td>
				</tr>
				<!--分页显示开始,分页标签初始化-->
				<pg:listdata dataInfo="com.chinacreator.cms.votemanager.Votelist"
					keyName="Votelist" />

				<pg:pager maxPageItems="30" scope="request" data="Votelist"
					isList="false">
					<!--检测当前页面是否有记录-->
					<!--list标签循环输出每条记录-->
					<TR>
						<!--设置分页表头-->
						<td class="c1" align="center" width="2%"></td>
						<TD width="2%" class="c1" align="center">
							<INPUT type="checkbox" name="checkBoxAll"
								onclick="checkAll('checkBoxAll','checkBoxOne')" value="on"
								class="checkbox">
						</TD>
						<TD  class="c1" align="center" width="9%">
							问卷号
						</TD>
						<TD  class="c1" align="center" width="7%">
							置顶
						</TD>
						<TD  class="c1" align="center">
							问卷标题
						</TD>
						<TD  class="c1" align="center">
							所属部门
						</TD>
						<TD  class="c1" align="center" width="5%">
							审核
						</TD>
						<TD  class="c1" align="center" width="5%">
							查看
						</TD>
						<TD  class="c1" align="center" width="10%">
							创建时间
						</TD>
						<TD  class="c1" align="center" width="10%">
							创建人
						</TD>
						<TD  class="c1" align="center" width="10%">
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
							<td class="tablecells" nowrap="nowrap" width="3%">
								<div align="left">
									<img src="../images/note.gif" width="16" height="15">
								</div>
							</td>
							<td class="tablecells" align=center>
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
							<td class="tablecells" nowrap="true" align="center"
								title="点击这里查看详细信息"
								onClick="view('<pg:cell colName='id' defaultValue=''/>','<%=channel%>')"
								style="cursor: hand">
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
							<td class="tablecells" nowrap="nowrap" align="center">
								<pg:equal colName="islook" value="1">否</pg:equal>
								<pg:equal colName="islook" value="0">是</pg:equal>
							</td>
							<td class="tablecells" nowrap="true" align="center"> 
								<pg:cell colName="foundDate" defaultValue="" />
							</td>
							<td class="tablecells" nowrap="true" align="center">
								<pg:cell colName="foundername" defaultValue="" />
							</td>
							<td class="tablecells" nowrap="true" align="center">
								<%
									boolean ff = false;
														if ((channel.equals("网上调查") && accesscontroler
																.checkPermission("dchmanager", "edit",
																		"titleManager"))
																|| (channel.equals("网上测评") && accesscontroler
																		.checkPermission("wscpManager",
																				"edit",
																				"wscpTitleManager")))
														// if(accesscontroler.checkPermission("dchmanager","edit","titleManager"))
														{
															ff = true;
								%>
								<a  href="#"
									onclick="modify('<pg:cell colName='id' defaultValue=''/>','<%=channel%>')" />
									修改</a>

								<%
									}
														if ((channel.equals("网上调查") && accesscontroler
																.checkPermission("dchmanager",
																		"browse", "titleManager"))
																|| (channel.equals("网上测评") && accesscontroler
																		.checkPermission("wscpManager",
																				"browse",
																				"wscpTitleManager")))
														//if(accesscontroler.checkPermission("dchmanager","browse","titleManager"))
														{
															ff = true;
								%>
								|
								<a  href="#"
									onclick="havealook('<pg:cell colName='id' defaultValue=''/>')" />
									预览</a>

								<%
									}
														if ((channel.equals("网上调查") && accesscontroler
																.checkPermission("dchmanager", "count",
																		"titleManager"))
																|| (channel.equals("网上测评") && accesscontroler
																		.checkPermission("wscpManager",
																				"count",
																				"wscpTitleManager")))
														//if(accesscontroler.checkPermission("dchmanager","count","titleManager"))
														{
															ff = true;
								%>|
								<a  href="#"
									onclick="getResult('<pg:cell colName='id' defaultValue=''/>')" />
									统计</a>
								<%
									}
														if (!ff) {
								%>无权限<%
									}
								%>
							</td>

						</tr>
					</pg:list>
					<tr >
						<td colspan=11 align="right" class="c2">
							共
							<pg:rowcount />
							条记录
							<pg:index />
						</td>

					</tr>

					<P align="center">
						<input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">
					</P>
				</pg:pager>

		  </table>
			<input type="hidden" value="" name="actioinType">
		</form>
		<P align="center">
		</P>
		<iframe name="hidFrm" width="0" height="0"></iframe>
	</body>
</html>

