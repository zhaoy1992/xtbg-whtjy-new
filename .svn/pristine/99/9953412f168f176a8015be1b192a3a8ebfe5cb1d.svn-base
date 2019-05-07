<%--
描述：OA工作台
作者：王博
版本：1.0
时间：2013-6-24
 --%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.workbench.cache.WorkbenchUserCache"%>
<%@page import="com.chinacreator.xtbg.core.workbench.cache.WorkbenchConfCache"%>
<%@page import="com.chinacreator.xtbg.core.workbench.entity.OnlineTopBean"%>
<%@page import="com.chinacreator.xtbg.core.workbench.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.workbench.entity.SystemBean"%>
<%@page import="com.chinacreator.xtbg.core.workbench.session.SessionListener"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.workbench.entity.ShowItemBean"%>
<%@page import="com.chinacreator.xtbg.tjy.processing.dao.ProFlowBusiSearchDao"%>
<%@page import="com.chinacreator.xtbg.tjy.processing.dao.Impl.ProFlowBusiSearchDaoImpl"%>
<%@page import="java.util.List"%>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	if(!accesscontroler.checkAccess(request, response)){
		return;
	}
	
	String userid = accesscontroler.getUserID();//获得当前登录用户id
	String userRealName = accesscontroler.getUserName();//获得当前登录用户name
	String path1 = request.getContextPath();
	OnlineTopBean onlineTopBean = WorkbenchUserCache.getOnlineTopBean();
	UserCacheBean userCacheBean = WorkbenchUserCache.getUserCache(userid);
	SystemBean systemBean = WorkbenchConfCache.getSystemBean();
	List<ShowItemBean> showItemList = WorkbenchConfCache.getShowItemList();
	
	String serverName = (String) request.getServerName();
	String serverPort = String.valueOf(request.getServerPort());
	String contextPath = (String) request.getContextPath();
	String path = "/servlet/workbenchServlet";
	String servletPath = contextPath + path;
	ProFlowBusiSearchDao dao = new ProFlowBusiSearchDaoImpl();
	dao.updateClgl();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页</title>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../js/workbench.js"></script>
<script type="text/javascript" src="../../../xtbg/openfire/popup.js"></script>
<script type="text/javascript">
	
	
	
$(function(){

	});
	

	$(document).ready(function(){
		init();
		//setTimeout("init()",60000000);// 开发环境去掉这个   --------1分钟运行一次
		$("#weatherForecast").attr("src","<%=systemBean.getWeather_url() %>");
		
	});
	
	function init(){
		welcomeTime();//workbench.js
		loadWaitTask("<%=servletPath%>");//workbench.js
		loadOnlineUser("<%=servletPath%>");//workbench.js
		loadShowItem("<%=servletPath%>");//workbench.js
		loadWorkMessage("<%=userid%>"); //持证预警消息提醒
		//加载院内简报通知数据
<%-- 		loadShowhostNoticItem("user_id=<%=userid%>");//workbench.js  --%>
	}

	
	function loginsView() {
		var url = '<%=path1%>/ccapp/oa/common/main/loginviewmain.jsp';
		openAlertWindows('windowId',url,'在线用户查看','400px','500px','5%','25%');
	}
</script>
</head>
<body style="width: 100%;overflow:auto;" class="vcenter" >
	<table width="90%" border="0" align="center" cellpadding="0"
		cellspacing="0" style="float: left; margin-left: 20px;">
		<tr>
			<td>
				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td id="peningfrist">
							<table width="98%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="top_left_biaoti" valign="top">
										<span class="fontf00" id="userName" name="userName"><%=userRealName%></span>
										<span class="fontf00" id="welcomeTime"></span>
										<span class="fontf00">!</span>
										<br />
										您有 <span class="fontf00" name="waitingTotal" id="waitingTotal"></span>&nbsp;条待办任务需要处理：<br />
										<div name="penging" id="penging">
										</div>
									</td>
								</tr>
							</table>
						</td>
						<td id="piningtd"></td>
						<td id="pininglast">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td>
									<li>
										<iframe id="weatherForecast" width="140" height="20" src=""
											 marginwidth="0" marginheight="0" hspace="0" vspace="0" frameborder="0" scrolling="no"></iframe>
									</li>
									<li>
										<span>&nbsp;</span>
										<%-- 此次是您第<span class="color_red" id="loginTotal" name="loginTotal"><%=userCacheBean.getLoginnumber() %></span>次登录<span name="sysName"><%=systemBean.getSys_name() %></span> --%>
									</li>
									<li>
										<span>&nbsp;</span>
										<%-- 您上次登录平台的时间是：<span class="color_red" id="lastTime" name="lastTime"><%=DateUtil.getFormatTime(userCacheBean.getLastlogin()) %> </span> --%>
									</li>
									<li>
										<a onclick="loginsView()">
											当前在线人数：<span class="color_red" id="inSystemTotal" name="inSystemTotal"><%=SessionListener.getOnlineUser().size() %></span>
											最高在线人数：<span class="color_red" id="topInSysTotal" name="topInSysTotal"><%=onlineTopBean.getPersonnum() %></span>
										</a>
									</li>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="itemList">
					<tr>
					<%
						int count = 1;//一行两个计数器
						for(ShowItemBean bean : showItemList){
							int rowNum = bean.getMaxRownum();
					%>
						<td valign="top" name="showItem" id="<%=bean.getId() %>" title="<%=bean.getName() %>">
							<table border="0" cellpadding="0" cellspacing="0" class="main_table100">
								<tr>
									<td height="29" class="main_table_hong">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td height="28" align="left" class="main_table_hong_zi">
													<a>&nbsp;<%=bean.getName() %></a>
												</td>
												<td class="main_table_hong_pic">&nbsp;</td>
												<td class="main_table_hong_more" id="more">
													<a href="javascript:void(0)" onclick="newwin('<%=request.getContextPath()+bean.getMoreUrl() %>','<%=bean.getName() %>','<%=bean.getId() %>')">更多>></a>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="main_hui" id="itemList_<%=bean.getId() %>">
											
										</table>
									</td>
								</tr>
							</table>
						</td>
							<%if(count % 2 == 0) {//偶数模块%>
						</tr>
								<%if(count < showItemList.size()) {%>
						<tr>
								<%}%>
							<%}else{ %>
						<td name="piningtd1">&nbsp;</td>
							<%}count ++;} %>
						<%if(count % 2 ==0) {%>
							<td>
								&nbsp;
							</td>
						</tr>
						<%} %>
						<tr style="height: 10px"></tr>
				</table>
				<%-- <!--院内简报 -->
				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="itemNoticList">
					<tr>
						<td valign="top"  id="hostNotic" title="湖南特检简报" colspan="4">
							<table border="0" cellpadding="0" cellspacing="0" class="main_table100">
								<tr>
									<td height="29" class="main_table_hong">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td height="28" align="left" class="main_table_hong_zi">
													<a>&nbsp;湖南特检简报</a>
												</td>
												<td class="main_table_hong_pic">&nbsp;</td>
												<td class="main_table_hong_more" id="more" >
													<a href="javascript:void(0)" onclick="newwin('<%=request.getContextPath()+"/ccapp/oa/notice/jsp/noticespecialtypelist.jsp?n_type=3" %>','湖南特检简报','<%=userid%>')">更多>></a>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td width="100%">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="main_hui">
											<tr id="notic_trid">
												
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table> --%>
				</td>
			</tr>
		</table>
		

<div id="message_div" style="position: absolute;bottom: 0;right: 0;width: 250px;height: 150px;background: #ccc;border:1px solid #000;display: none;">
	<div style="width:230px; height: 30px;line-height: 30px;padding: 0 10px;border-bottom: 1px solid #999 ">
		<div style="width: 130px;text-align: left;float: left;">消息提示：</div>
		<div style="width: 100px;text-align: right;float: right;"><a id="message_close" href="###" >关闭</a> </div>
	</div>
	<div style="width: 230px;padding: 0 10px;">
		<p>你好：</p>
		<p><a id="message_href" href="###" style="color: blue;">你有<span id="amount">0</span>条持证预警的消息</a>，请注意查看！</p>
	</div>
</div>
</body>
</html>

