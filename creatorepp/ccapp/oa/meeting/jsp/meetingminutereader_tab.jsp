<%--
describe:阅读情况查看
author:dailianchun
date: 2013-6-26
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- 引入jQuery -->
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"
    href="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script
    src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
    type="text/javascript"></script>

<!-- 引入其它 -->
<script src="<%=path%>/ccapp/oa/resources/util/public.js"
    type="text/javascript"></script>


<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>

<!-- 引入提示 -->
<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

<script type="text/javascript"
    src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>

<script type="text/javascript">
    
        $(function() {
            $("#tabs").tabs({
                select : function(event, ui) {
            	   if("已阅读" == jQuery(ui.tab).text()){
                    //如果页面未加载，则加载页面
                     if(!jQuery("#frame2").attr("src")){
                      jQuery("#frame2").attr("src","meetingminutereaderlist4read.jsp?id=<%=request.getParameter("id")%>");
                     }
                   }                                
                 }
            });            
            $("#titleids").css('display','block');
            jQuery("#frame1").attr("src","meetingminutereaderlist4unread.jsp?id=<%=request.getParameter("id")%>");
            
            //返回
            $("#return").click(function() {
                window.parent.JqueryDialog.SubmitCompleted("", true, true);
            });
        });
    </script>
<title>阅读情况查看</title>
</head>
<body
    onload="adaptationWH('titleids','frame1',400,true);adaptationWH('titleids','frame2',400,true);">

<table style="WIDTH: 100%;">
    <tr>
        <td></td>
    </tr>
    <tr>
        <td>

        <div>
        <div id="tabs">
        <div id="titleids" style="display: none;">
        <ul>
            <li><a href="#read_tabs-1">未阅读</a></li>
            <li><a href="#read_tabs-2">已阅读</a></li>

        </ul>
        </div>
        <div id="read_tabs-1">
            <iframe
            src=""
            id="frame1" frameborder="0" width="100%" scrolling="no"></iframe>
        </div>
        <div id="read_tabs-2">
            <iframe 
             src=""
             id="frame2" frameborder="0" width="100%"></iframe>
        </div>

        </div>
        </div>

        </td>
    </tr>
</table>
</body>
</html>