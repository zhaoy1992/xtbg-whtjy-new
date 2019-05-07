<%-- 
描述：退稿原因
作者：黄海
版本：1.0
日期：2013-09-25
 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.paper.util.PaperConstants"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%
String p_manage_id = StringUtil.deNull(request.getParameter("p_manage_id"));
String windowId = StringUtil.deNull(request.getParameter("windowId"));
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
%>
<html>
<head>
<title>退稿原因</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript">
var windowId = "<%=windowId%>";
//关闭弹窗
function closed(){
	var p={
		headerText:'提示',
		okName:'确认',
        okFunction:function(){
        	removeAlertWindows(windowId,true);
        },
        cancelName:'取消'
	};
	alert("关闭后，数据将不会保存，确定关闭？",p);
}
function saved(f,n){
	if(isSpace(jQuery("#p_unacc_remark").val())){
		alert("请填写退稿原因！");
		return;
	}
	var okF = function() {
		url = "paperlist4reporteddetaildo.jsp";
		jQuery.ajax({
			url : url,
			type : 'POST',
			dataType : 'json',
			data : {
				action:"unaccpaper",
				p_manage_id: "<%=p_manage_id%>",
			    p_unacc_user_id: "<%=accesscontroler.getUserID()%>",
			    p_unacc_user_name: "<%=accesscontroler.getUserName()%>",
			    p_unacc_remark: jQuery("#p_unacc_remark").val()
			},
			async : true,
			success : function(data) {
				if (data.flag) {
					alert("操作成功！");
					getParentWindow(windowId).location="paperlist4acc.jsp";
					setTimeout(function(){
						removeAlertWindows(windowId,true);
					},300);
				} else {
					alert("操作失败！");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("error:" + textStatus);
				removeAlertWindows(windowId,true);
			}
		});
	};
	var p = {
		headerText : '提示',
		okName : '确认',
		okFunction : okF,
		cancelName : '取消'
	};
	alert("确定要退稿吗？", p);	
	
}
</script>
</head>
<body>
<form id="form1" action="" method="post">
<input type="hidden" name="p_manage_id" id="p_manage_id"  value="<%=p_manage_id %>" />
<!-- 操作-->
<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-bottom: 10px;">
		<input name="fbbt" id="fbbt" value="确定" onclick="saved();"  type="button" class="but_y_01" /> 
		<input name="" value="取消" onclick="closed()" type="button" class="but_y_01" />
	</div>
</div>
<!-- 操作-->
<!-- 表格-->
<div style="float: left; width: 100%;">
	<div class="content_02_box" style="width: 580px;">
		<div class="content_02_box_title_bg" style="width: 580px;"><span>退稿原因</span></div>
		<div class="content_02_box_div" style="width: 580px;">
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table"  style="width: 580px;">
				<tr>
					<td class="content_02_box_div_table_02_td" style="float: center;">
						<textarea onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[maxSize[250]] textarea_575" style="width:570px;height:50px" name="p_unacc_remark" id="p_unacc_remark"  ></textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
</form>
</body>
</html>