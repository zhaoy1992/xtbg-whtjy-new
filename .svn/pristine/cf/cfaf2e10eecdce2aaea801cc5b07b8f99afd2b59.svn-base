<%--
描述：知识库首页
作者：黄艺平
版本：1.0
时间：2013-8-15
 --%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="java.util.List"%>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	if(!accesscontroler.checkAccess(request, response)){
		return;
	}
	
	String userid = accesscontroler.getUserID();//获得当前登录用户id
	String userRealName = accesscontroler.getUserName();//获得当前登录用户name
	String path1 = request.getContextPath();
	List<ShowItemBean> showItemList = KbmConfCache.getShowItemList();
	
	String serverName = (String) request.getServerName();
	String serverPort = String.valueOf(request.getServerPort());
	String contextPath = (String) request.getContextPath();
	String path = "/servlet/kbmServlet";
	String servletPath = "http://" + serverName + ":" + serverPort + contextPath + path;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.xtbg.core.kbm.entity.ShowItemBean"%>
<%@page import="com.chinacreator.xtbg.core.kbm.cache.KbmConfCache"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页</title>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/js/kbmfrist.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		init();
		//setTimeout("init()",60000);//1分钟运行一次
		
	});
	
	function init(){
		loadShowItem("<%=servletPath%>");//kbmfrist.js
	}
</script>
</head>
<body style="width: 100%">
	<table width="90%" border="0" align="center" cellpadding="0"
		cellspacing="0" style="float: left; margin-left: 20px;">
		<tr>
			<td>
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
					</table>
				</td>
			</tr>
		</table>
</body>
</html>

