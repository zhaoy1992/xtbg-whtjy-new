<%@page contentType="text/html;charset=GBK"%>
<%@ include file="../../include/global1.jsp"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page
	import="com.chinacreator.epp.applymanager.dbmanager.ApplyManager"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();

	String applybackground = request.getParameter("applybackground");
	String applylogo = request.getParameter("applylogo");
%>
<HTML>
	<HEAD>
		<TITLE>科创应用支撑平台</TITLE>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/toolbar.css">
		<script language="javascript"
			src="<%=request.getContextPath()%>/sysmanager/scripts/toolbar.js"></script>
		<script language="javascript"
			src="<%=request.getContextPath()%>/sysmanager/common/CommonFunc.js"></script>

		<META content="MSHTML 6.00.2800.1522" name=GENERATOR>

	</HEAD>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="gtoolbarbodymargin">

		<div id="globaltoolbar">
			<table>
				<tr>
					<td id="s" style='position:relative;left:0px;top:0px;'>
						<table width="1024" height="59" cellpadding=3 cellspacing=0
							border=0>
							<tr>
								<td class="text" nowrap valign="middle" align="center"
									width="75" height=25>
									<%
									if (!applylogo.trim().equals("")) {
									%>
									<img class="normal" src="<%=applylogo%>" width="75" height="25"
										border="0" title="科创应用支撑平台">
									<%
									}
									%>
								</td>
								<td class="text" nowrap valign="middle" align="left" width="200"
									height=25>

								</td>

								<td class="text" nowrap valign="middle" align="center"
									width="100%" height=25></td>
								<td class="text" nowrap valign="middle" align="right"
									width="260" height=25>
									<table width="100%" height=16 cellpadding=0 cellspacing=0
										border=0>
										<tr>
											<td valign="middle" align="right" width=* height=25></td>
											<td valign="middle" align="right" width="210" height=25
												nowrap>
												&nbsp;
											</td>
											<td class=normal valign="middle" align="center" height=25
												onmousedown="mousedown(this)" onmouseout="mouseout(this)"
												onmouseover="mouseover(this)" onmouseup="mouseup(this)">
												<table cellpadding=0 cellspacing=0 border=0>
													<tr>
														<td valign="middle" align="center" nowrap="nowrap">
															&nbsp;
															<img alt="在线用户数" title="在线用户数"
																src="<%=request.getContextPath()%>/epp/eppTemplate/images/index_2.gif"
																width="16" height="16">
															&nbsp;
														</td>
														<td valign="middle" nowrap="nowrap" id="user_counts">
															<font color="blue"> 在线用户数<%=accesscontroler.getLoginUserCount()%>(人)</font>&nbsp;
														</td>
													</tr>
												</table>
											</td>

											<td class=normal valign="middle" align="center" onclick=""
												width=80 height=25 onmousedown="mousedown(this)"
												onmouseout="mouseout(this)" onmouseover="mouseover(this)"
												onmouseup="mouseup(this)">
												<table cellpadding=0 cellspacing=0 border=0>
													<tr>
														<td valign="middle" align="center" nowrap="nowrap">
															&nbsp;
															<img alt="当前用户" title="当前用户"
																src="<%=request.getContextPath()%>/epp/eppTemplate/images/index_3.gif"
																width="16" height="16">
															&nbsp;
														</td>
														<td valign="middle" nowrap="nowrap">
															<font color="blue"> <%=accesscontroler.getUserName()%>(<%=accesscontroler.getUserAccount()%>)</font>&nbsp;
														</td>
													</tr>
												</table>
											</td>

											<td style="display:all" class=normal valign="middle"
												align="center" width=80 height=25 onclick=""
												onmousedown="mousedown(this)" onmouseout="mouseout(this)"
												onmouseover="mouseover(this)" onmouseup="mouseup(this)">
												<table cellpadding=0 cellspacing=0 border=0>
													<tr style="display:all">
														<td valign="middle" align="center" nowrap="nowrap">
															&nbsp;
															<img alt="SP信息服务系统帮助" title="SP信息服务系统使用帮助"
																src="<%=request.getContextPath()%>/epp/eppTemplate/images/index_4.gif"
																align="top" width="16" height="16">
															&nbsp;
														</td>
														<td valign="middle" nowrap="nowrap">
															帮助&nbsp;
														</td>
													</tr>
												</table>
											</td>
											<td class=normal valign="middle" align="center" width=80
												height=25 onmousedown="mousedown(this)"
												onmouseout="mouseout(this)" onmouseover="mouseover(this)"
												onmouseup="mouseup(this)" style="display: all;">
												<table cellpadding=0 cellspacing=0 border=0>
													<tr style="display:all">
														<td valign="middle" align="center" nowrap="nowrap">
															&nbsp;
															<img alt="关于SP信息服务系统" title="关于SP信息服务系统"
																src="<%=request.getContextPath()%>/epp/eppTemplate/images/index_5.gif"
																align="top" width="16" height="16">
															&nbsp;
														</td>
														<td valign="middle" nowrap="nowrap">
															关于&nbsp;
														</td>
													</tr>
												</table>
											</td>

											<td class=normal valign="middle" align="center" width=80
												height=20 title="退出" onmousedown="mousedown(this)"
												onmouseout="mouseout(this)"
												onmouseover="mouseover(this);cursor=1"
												onmouseup="mouseup(this)">
												<table cellpadding=0 cellspacing=0 border=0>
													<tr>
														<td valign="middle" align="center" nowrap="nowrap">
															&nbsp;
															<img
																src="<%=request.getContextPath()%>/epp/eppTemplate/images/index_6.gif"
																align="top" width="16" height="16">
															&nbsp;
														</td>
														<td valign="middle" nowrap="nowrap">
															退出&nbsp;
														</td>
													</tr>
												</table>
											</td>

										</tr>

									</table>
								</td>
								<td class="text" nowrap valign="middle" align="center" width="5"
									height=25></td>
							</tr>
							<tr>
								<td colspan="4" bgcolor="#93bee2" width="100%" height=1px></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<script language="javascript">
	var s = document.getElementById("s");
	var TdHeight=s.offsetHeight-2;
	var TdWidth=s.offsetWidth-2;
	var applybackground = "<%=applybackground%>";
	var interHTML="<img src='"+applybackground+"' style='position:absolute;top:0px;left:0px;width:"
	+TdWidth
	+"px;height:"
	+TdHeight
	+"px;z-index:-1' id='oImg'>";
	s.innerHTML+=interHTML;
</script>
</html>
