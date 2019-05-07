<%--
describe: 会议纪要登记的主页面
author:dailianchun
date: 2013-6-26
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
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
            $("#tabs").tabs({
                select : function(event, ui) {
                    var iframeitem = $(ui.panel).find("iframe");
                    $(iframeitem).attr("src", $(iframeitem).attr("src"));
                }
            });
            $("#titleids").css('display','block');
            adaptationWH('_top','frame1',40);
            adaptationWH('_top','frame2',30);
        });
</script>
<title>会议纪要</title>
</head>
<body >
    <table style="WIDTH: 100%;">
        <tr>
            <td>
                <div>
                    <div id="tabs">
                        <div id="titleids" style="display:none;" id="_top">
                            <ul>
                                <li><a href="#tabs-1">暂存列表</a></li>
                                <li><a href="#tabs-2">已发布列表</a></li>
                            </ul>
                        </div>
                        <div id="tabs-1">
                            <iframe src="meetingminutelist4unreleased.jsp?flag=0" id="frame1" frameborder="0"
                                width="100%"></iframe>
                        </div>
                        <div id="tabs-2">
                            <iframe src="meetingminutelist4released.jsp?flag=1" id="frame2" frameborder="0"
                                width="100%"></iframe>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    </body>
</html>