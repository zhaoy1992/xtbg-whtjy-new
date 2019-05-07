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
        	var iframeSrcArr = new Array();
        	iframeSrcArr[iframeSrcArr.length] = "personaladdressbook.jsp?is_public=0";
        	iframeSrcArr[iframeSrcArr.length] = "personworkmain.jsp";
        	iframeSrcArr[iframeSrcArr.length] = "personaladdressbook.jsp?is_public=1";
            $("#tabs").tabs({
                select : function(event, ui) {
                    var iframeitem = $(ui.panel).find("iframe");
                    $(iframeitem).attr("src", iframeSrcArr[ui.index]);
                }
            });
            $("#_top").css('display','block');
            adaptationWH('_top','frame1',0);
            adaptationWH('_top','frame2',0);
            adaptationWH('_top','frame3',0);
        });
</script>
<title>通讯录</title>
</head>
<body >
    <table style="WIDTH: 100%;">
        <tr>
            <td>
                <div>
                    <div id="tabs">
                        <div style="display:none;" id="_top">
                            <ul>
                                <li><a href="#tabs-1">个人通讯录</a></li>
                                <li><a href="#tabs-2">单位通讯录</a></li>
                                <li><a href="#tabs-3">公共通讯录</a></li>
                            </ul>
                        </div>
                        <div id="tabs-1">
                            <iframe src="personaladdressbook.jsp?is_public=0" id="frame1" frameborder="0"
                                width="100%"></iframe>
                        </div>
                        <div id="tabs-2">
                            <iframe src="" id="frame2" frameborder="0"
                                width="100%"></iframe>
                        </div>
                        <div id="tabs-3">
                            <iframe src="" id="frame3" frameborder="0"
                                width="100%"></iframe>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</body>
</html>