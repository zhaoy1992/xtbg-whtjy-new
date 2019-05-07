<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@page import="com.chinacreator.xtbg.home.entity.ToDoWorkListBean"%>
<%
	String index = request.getParameter("index");
	AccessControl accesscontroler = AccessControl.getInstance();
	
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();//获得当前登录用户id
	String username = accesscontroler.getUserAccount();
	String todoworktabstype =request.getParameter("todoworktabstype");
	String entrance = request.getParameter("entrance");
	String pagefrom1=request.getParameter("pagefrom");
	/*获取待办列表统计数据start*/
	HomeBusinessDao hbDao = (HomeBusinessDao) DaoImplClassUtil
						.getDaoImplClass("homeBusinessDaoImpl");
		int waiting4approvalTotal = 0;//待办处理统计
		int waiting4readTotal = 0;//待办阅读统计
		int waitingTotal = 0;//待办总计
		int individualwork = 0;//公文待办
		ToDoWorkListBean tdwlBean=new ToDoWorkListBean();
		ToDoWorkSearchBean toDoWorkSearchBean = new ToDoWorkSearchBean();
		toDoWorkSearchBean.setInputuser_id(userid);
		toDoWorkSearchBean.setListtype("waitingapproval");
		
		waiting4approvalTotal = hbDao.getToDoWorkListTotal(toDoWorkSearchBean,tdwlBean);
		toDoWorkSearchBean.setListtype("waitingread");
		waiting4readTotal = hbDao.getToDoWorkListTotal(toDoWorkSearchBean,tdwlBean);
		
		waitingTotal = waiting4approvalTotal + waiting4readTotal;
		
		String waittotal=request.getParameter("waittotal");
		int mettingTotal =0;//会议通知
		tdwlBean.setInfo_type("会议通知");
		toDoWorkSearchBean.setListtype("waitingapproval");
		mettingTotal = hbDao.getToDoWorkListTotal(toDoWorkSearchBean,tdwlBean);
		
		tdwlBean.setInfo_type("公文待办");
		toDoWorkSearchBean.setListtype("waitingapproval");
		individualwork =hbDao.getToDoWorkListTotal(toDoWorkSearchBean,tdwlBean);
	/*获取待办列表统计数据end*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.home.dao.HomeBusinessDao"%>
<%@page import="com.chinacreator.xtbg.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.home.entity.ToDoWorkSearchBean"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!--公共部分结束  -->
<script type="text/javascript">
		$(function() {
			$("#tabs").tabs({
				select : function(event, ui) {
					var iframeitem = $(ui.panel).find("iframe");
					$(iframeitem).attr("src", $(iframeitem).attr("src"));
				}
			});
			$("#tabs").tabs("select","<%=pagefrom1%>");
			if(!IsSpace("<%=index%>")){//初始化tabs选中指定的tab
			if('<%=todoworktabstype%>' == 'flag')
				{
					//判断阅读
					if('<%=waiting4readTotal%>'== 0)
					{
						//判断审批
						if('<%=waiting4approvalTotal %>' == 0)
					     {
							   //判断会议
								if('<%=mettingTotal%>' == 0)
								{
									//公文待办
									if('<%=individualwork%>' == 0)
									{
										$("#tabs").tabs('select',"<%=index%>");
									}
									else
									{
										$("#tabs").tabs('select',"4");
									}
								}
								else
								{
									$("#tabs").tabs('select',"3");
								}
					   	 }
						else
						{
							$("#tabs").tabs('select',"1");
						}
					}
					else
					{
						$("#tabs").tabs('select',"<%=index%>");
					}
				}
				if('flag1' =='<%=todoworktabstype%>')
				{
					$("#tabs").tabs('select',"<%=index%>");
				}
			}
			$("#titleids").css('display','block');
			window.top.$("#workCount").html(<%=waiting4approvalTotal+waiting4readTotal+mettingTotal +individualwork%>);
		});
	</script>
<title>待办事项</title>
</head>
<body onload="adaptationWH('_top','frame1',39);adaptationWH('_top','frame2',39);adaptationWH('_top','frame4',39);">
	<TABLE style="WIDTH: 100%;">
		<TR>
			<TD>
				<div>
					<div id="tabs">
						<div id="titleids" style="display:none;" id="_top">
							<ul>
								
								<li><a href="#tabs-2" >等待阅读(<span  id="titleids2"><%=waiting4readTotal %>)</span></a></li>
								<li><a href="#tabs-1">等待审批(<span  id="titleids1"><%=waiting4approvalTotal %>)</span></a></li>
								<li><a href="#tabs-3">会议通知(<span  id="titleids3"><%=mettingTotal%>)</span></a></li>
								<li><a href="#tabs-4">公文待办(<span  id="titleids4"><%=individualwork%>)</span></a></li>
							<!-- <li><a href="#tabs-3">等待待办(2)</a></li>
								 <li><a href="#tabs-4">备用列表</a></li>-->
							</ul>
						</div>
						<div id="tabs-1">
							<iframe src="waiting4approval.jsp?waittotal=<%=waittotal %>&type=true" id="frame1" frameborder="0"
								width="100%" ></iframe>
						</div>
						<div id="tabs-2">
							<iframe src="waiting4read.jsp?waittotal=<%=waittotal %>" id="frame2" frameborder="0"
								width="100%"></iframe>
						</div>
						<div id="tabs-3">
							<iframe src="conference-registration.jsp?type=true" id="frame4" frameborder="0"
								width="100%" height="510px"></iframe>
						</div>
						<div id="tabs-4">
							<iframe src="../../workflow/jsp/doworklist.jsp?type=true&entrance=<%=entrance %>" id="frame5" frameborder="0"
								width="100%" height="510px"></iframe>
						</div>
					</div>
				</div>
			</TD>
		</TR>
	</TABLE>

</body>
</html>