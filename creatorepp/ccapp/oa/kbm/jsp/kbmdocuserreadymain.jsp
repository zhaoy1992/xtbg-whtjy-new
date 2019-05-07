<%--
　　描述：知识库文档管理阅读情况tab主页面
　　作者：黄海
　　版本：1.0
　　日期：2014-4-08
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
//主键ID
String k_doc_id = request.getParameter("k_doc_id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->		
<script type="text/javascript">
	$(function() {
		$("#tabs").tabs({//每个页面只刷新一次
			select : function(event, ui) {
				var iframeitem = $(ui.panel).find("iframe");
				var url;
				if(ui.index == 1){
					url = "kbmdocNoreadylist.jsp?k_doc_id=<%=k_doc_id%>";
				}if(ui.index == 0){
					url = "kbmdocreadylist.jsp?k_doc_id=<%=k_doc_id%>";
				}
				//每次清理地址，然后赋值
				jQuery("#frame"+ui.index).attr("src","");
				$(iframeitem).attr("src", url);
			}
		});
		$("#titleids").css('display','block');
	    adaptationWH('titleids','frame1',40);
		adaptationWH('titleids','frame2',40);
	});
</script>
<title>知识库文档阅读情况</title>
</head>
<body >
	<table style="WIDTH: 100%;">
		<tr>
			<td>
				<div>
					<div id="tabs">
						<div id="titleids" style="display:none;" >
							<ul>
								<li><a href="#tabs-1">已阅读</a></li>
								<li><a href="#tabs-2">未阅读</a></li>
							</ul>
						</div>
						<div id="tabs-1">
							<iframe src="kbmdocreadylist.jsp?k_doc_id=<%=k_doc_id%>" id="frame1" frameborder="0"
								width="100%"></iframe>
						</div>
						<div id="tabs-2">
							<iframe src="kbmdocNoreadylist.jsp?k_doc_id=<%=k_doc_id%>" id="frame2" frameborder="0"
								width="100%"></iframe>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>	