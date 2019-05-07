<%-- 
描述：短信配置页面
作者：shuqi.liu
版本：1.0
日期：2013-08-27
 --%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>

<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String msg_txt = request.getParameter("msg_txt");
	String isdxtx = request.getParameter("isdxtx");
	String isjsxx = request.getParameter("isjsxx");
	String isyj = request.getParameter("isyj");
	String isznxx = request.getParameter("isznxx");
	
	String path = request.getContextPath();
%>
<title>短信配置页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入其它 -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../resources/plug/fancyupload/mootools-1.2.5-core-jm.js"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/source/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/source/Swiff.Uploader.js"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/source/FancyUpload3.Attach.js"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/myfancyupload.js"></script>
<script type="text/javascript">

jQuery(function() {
	
});

/*
函数:  convertTo01
说明:  选择框checked属性为true时返回1，否则 返回0
作者：  黄海
日期： 2013-05-31
参数:  obj 选择框对象
返回值: 1或0
*/
var convertTo01 = function(obj){
	if (obj.attr("checked")){
		return 1;
	}
	return 0;
}

/*
作者:  shuqi.liu
时间:  2013-8-28
函数:  saveMsgConfig
说明:  保存短信配置
参数:   无
返回值: 无
*/
function saveMsgConfig(){
	var isdxtx = convertTo01(jQuery("#isdxtx"));
	var isyj = convertTo01(jQuery("#isyj"));
	var isznxx = convertTo01(jQuery("#isznxx"));
	var isjsxx = convertTo01(jQuery("#isjsxx"));
	var msg_txt = jQuery("#msg_txt").val();
	getParentWindow("windowId").msgConfigReset(isdxtx,isyj,isznxx,isjsxx,msg_txt);
	removeAlertWindows('',true);
}

</script>

</head>
<body>
<button id=button4 class="but_y_01" onclick="saveMsgConfig()">保存</button>
<button id=button8 class="but_y_01" onclick="removeAlertWindows('',true)">关闭</button>
<form id="form1" action="" method="post">

<!-- 表格    -->
<div id="vcenter" style="float: left; width: 100%;"  >
	<div style="float: left; width: 775px;">
		<div class="content_02_box">
			<div class="content_02_box_div">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="content_02_box_div_table_02">
					<tr>
						<th class="content_02_box_div_table_th">是否发送短信：</th>
			            <td  class="content_02_box_div_table_td" style="text-align: center;">
			                <input type="checkbox" id="isdxtx" name="isdxtx" value="1" <%="1".equals(isdxtx)?"checked":"" %> />
			            </td>
			            <th class="content_02_box_div_table_th">是否发送邮件：</th>
			            <td  class="content_02_box_div_table_td" style="text-align: center;">
			                <input type="checkbox" id="isyj" name="isyj" value="1" <%="1".equals(isyj)?"checked":"" %> />
			            </td>
			            <th class="content_02_box_div_table_th">是否发送站内消息：</th>
			            <td  class="content_02_box_div_table_td" style="text-align: center;">
			                <input type="checkbox" id="isznxx" name="isznxx" value="1" <%="1".equals(isznxx)?"checked":"" %> />
			            </td>
			            <th class="content_02_box_div_table_th">是否发送即时消息：</th>
			            <td  class="content_02_box_div_table_td" style="text-align: center;">
			                <input type="checkbox" id="isjsxx" name="isjsxx" value="1" <%="1".equals(isjsxx)?"checked":"" %> />
			            </td>
					</tr>
					<tr>
						<th valign="top" class="content_02_box_div_table_02_th">短信内容配置：</th>
			            <td colSpan="7" class="content_02_box_div_table_02_td">
			                <textarea class="textarea_575" id="msg_txt" name="msg_txt" style="width:99%;height: 40px; margin:2px 0 2px; "><%=msg_txt %></textarea> 
			            </td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>