<%--
描述：待办列表总页面
作者：黄艺平
版本：1.0
时间：2013-7-3
 --%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.xtbg.core.workbench.cache.WorkbenchConfCache"%>
<%@page import="com.chinacreator.xtbg.core.workbench.entity.PendingItemBean"%>
<%@page import="java.util.List"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String pagefrom = request.getParameter("pagefrom");
String homepage = request.getParameter("flag");
String index = request.getParameter("index");
String indexReturn = request.getParameter("indexReturn");

String pageId = request.getParameter("pageId");
List<PendingItemBean> pendingItemBeanList = WorkbenchConfCache.getPendingBean().getList();
PendingItemBean pendingItemBean = null;
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"  type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 引入其它 -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript">
	var index = '<%=index%>';
	var indexReturn = '<%=indexReturn%>';
		$(function() {
			var iframeSrcArr = new Array();
			<%
			for(int j = 0; j < pendingItemBeanList.size(); j++) {
				pendingItemBean = new PendingItemBean();
				pendingItemBean = pendingItemBeanList.get(j);
			%>
        	iframeSrcArr[iframeSrcArr.length] = "<%=path + pendingItemBean.getIframurl() %>";
        	<%
			}
			%>
			$("#tabs").tabs({
				select : function(event, ui) {
					var iframeitem = $(ui.panel).find("iframe");
					//$(iframeitem).attr("src", $(iframeitem).attr("src"));
					$(iframeitem).attr("src", iframeSrcArr[ui.index]);
				}
			});
			$("#titleids").css('display','block');
			$("#tabs").tabs('select', '#' + '<%=pageId%>');
			$("#tabs").tabs('select',"tabs-<%=pageId%>");
			
		});
		
		//打开页面
		function openForms(url, flowname){
			var height = window.screen.availHeight;
			var width = window.screen.availWidth;
			url= url+"&height="+height+"&width="+width;
			openAlertWindows('newwindows',url,flowname,width,height,'0%','0%');
		}		
	</script>
	<title>待办列表总页面</title>
</head>
<body>
				<div>
					<div id="tabs">
						<%
							
							if(pendingItemBeanList.size() > 0) {
						%>
						<div id="titleids" >
							<ul>
								<%
									for(int i = 0; i < pendingItemBeanList.size(); i++) {
										pendingItemBean = new PendingItemBean();
										pendingItemBean = pendingItemBeanList.get(i);
									
								%>
										<li><a href="#tabs-<%=pendingItemBean.getId() %>"><%=pendingItemBean.getName() %></a></li>
								<%
									}
								%>
							</ul>
						</div>
								<%
									for(int j = 0; j < pendingItemBeanList.size(); j++) {
										pendingItemBean = new PendingItemBean();
										pendingItemBean = pendingItemBeanList.get(j);
										String url = path + pendingItemBean.getIframurl();
								%>
						<div id="tabs-<%=pendingItemBean.getId() %>" >
							<iframe 
								<%
								if(j == 0) {
								%>
								src="<%=path + pendingItemBean.getIframurl() %>" 
								<%
								}
								%>
								id="frame<%=pendingItemBean.getId() %>" frameborder="0"
								width="100%" height="700px" scrolling="no"></iframe>
						</div>
								<%
									}
								%>
						<%
							}
						%>
					</div>
				</div>
</body>
</html>