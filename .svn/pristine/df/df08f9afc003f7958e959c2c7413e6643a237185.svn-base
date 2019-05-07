<%--
　　描述：模板Top页面
　　作者：黄艺平
　　版本：1.0
　　日期：2013-07-31
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	String template_id_th = StringUtil.deNull(request.getParameter("template_id_th"));
	String path = request.getContextPath();
%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=uft-8">
<title>WORD　TOP页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js" ></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" ></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
</head>
<script type="text/javascript">
var template_id_th = "<%=template_id_th%>";//模版ID
/*
	函数：textInputWindow
	描述：输入框方法
	参数：
	返回值：
*/
function textInputWindow() {
  var url = "wordparam.jsp?template_id_th="+template_id_th+"&kj_type=textInput&window_source=1";
  parent.frames["mainFrame"].$("#WebOffice1").hide();
  openAlertWindows('windowId1','<%=path %>/ccapp/oa/process/wordtemplate/thwordparam.jsp?template_id_th='+template_id_th+'&kj_type=textInput&window_source=1&windowsId=windowId1','选择输入框','420px','310px','25%','25%',closeAlertWindowFun);
}
/*
	函数：closeAlertWindowFun
	描述：输入框方法回调方法
	参数：
	返回值：
*/
function closeAlertWindowFun(){
	parent.frames["mainFrame"].$("#WebOffice1").show();
}
</script>
<body>
<form action="" name="form1" method="post">
</form>
</body>
</html>