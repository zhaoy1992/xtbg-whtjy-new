<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%
	String template_id = StringUtil.deNull(request.getParameter("template_id"));

%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>WORD　TOP页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>



<!-- 引入其它 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

</head>
<script type="text/javascript">
var template_id = "<%=template_id%>";//模版ID


		
//textInput属性对话框
function textInputWindow() {
  var url = "wordparam.jsp?template_id="+template_id+"&kj_type=textInput&window_source=1";
  //features = "dialogWidth:450px;dialogHeight:410px;";
  //var returnValue = window.showModalDialog(url,window,features);
	parent.frames["mainFrame"].$("#WebOffice1").hide();
  openAlertWindows('windowId1','../../../resources/plug/wordtemplate/wordparam.jsp?template_id='+template_id+'&kj_type=textInput&window_source=1&windowsId=windowId1','选择输入框','420px','350px','25%','25%',closeAlertWindowFun);
  
}

function closeAlertWindowFun(){
	parent.frames["mainFrame"].$("#WebOffice1").show();
}


</script>
<body>
<form action="" name="form1" method="post">
<div  id="vcenter" style="float:left; width:100%; overflow-x:hidden;overflow-y:hidden;" >
	<div style="float: left; width: 775px; ">
		 <div class="content_02_box" >
		 
		 <div class="content_02_box_div">
				<table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" >
				 
				 <TR>
						<TD colspan=2 align=right>
						<input class=but_y_01 type="button" id=btnSave onclick="textInputWindow()" value="输入框">
						</TD>
					</TR>
				</table>
			</div>
			</div>

	</div>
</div>

</form>
</body>
</html>