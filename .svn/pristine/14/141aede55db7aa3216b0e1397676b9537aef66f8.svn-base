<%-- 
描述：附件处理页面
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
	String n_attach_id = request.getParameter("n_attach_id");
	String is_attachment = request.getParameter("is_attachment");
	String operType = "001";
	String optButName = "";
	if(!StringUtil.isBlank(is_attachment) && "1".equals(is_attachment)){//如果能处理附件权限
		 operType = "111";
		 optButName ="请选择文件";
	}
	
	if(StringUtil.isBlank(n_attach_id)){
		n_attach_id = StringUtil.getUUID();
	}
	String path = request.getContextPath();
	
%>
<title>附件处理页面</title>
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
	MyFancyupload.createUpload('_fileshow'
			,'#_filebut'
			, '<%=path %>'
			, '<%=path %>'+'/servlet/pubFileUpload?buessid='+'<%=n_attach_id %>'
			, true
			, '<%=n_attach_id %>'
			,''
			,''
			,'<%=operType%>');
});

/*
作者:  黄艺平
时间:  2013-6-21
函数:  back
说明:  返回列表
参数:   无
返回值: 无
*/
function back(){
	getParentWindow("windowId").closeAlertWindow();
	removeAlertWindows('windowId',true);
}
var setAttach= function(){
	var datas = "";
	var i=0;
	jQuery("#_fileshow LI").each(function(){
		i=i+1;
		if(i==jQuery("#_fileshow LI").length){
			datas +=i+". "+ this.firstChild.data;
		}else{
			datas +=i+". "+ this.firstChild.data+"\r";
		}
	});
	var fetchAttachMess = getParentWindow("windowId").fetchAttachMess;
	if(fetchAttachMess){
		fetchAttachMess(datas);
	}
	back();
}
</script>

</head>
<body>
<button id=button4 class="but_y_01" onclick="setAttach()">保存</button>
<button id=button8 class="but_y_01" onclick="back()">关闭</button>
<form id="form1" action="" method="post">
<input type="hidden" name="n_attach_id" id="n_attach_id"  value="<%=n_attach_id %>"/>
<!-- 表格    -->
<div id="vcenter" style="float: left; width: 100%;"  >
	<div style="float: left; width: 775px;">
		<div class="content_02_box">
			<div class="content_02_box_div">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_02_box_div_table_02">
					<tr>
						<th class="content_02_box_div_table_th">附件：</th>
			            <td class="content_02_box_div_table_td" style="text-align:left;">
							<a href="#" id="_filebut" style="padding-left: 10px"><%=optButName %></a>			            
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">附件列表：</th>
						<td  class="content_02_box_div_table_td" style="text-align:left;">
						<ul style="padding-left: 10px;height: 20px" id="_fileshow"></ul>
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