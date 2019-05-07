<%--
　　描述：会议通知 申请 基本作息 明细页面
　　作者：黄海
　　版本：1.0
　　日期：2013-6-22
--%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamConstant"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmConstants"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingHandleServiceImpl" %>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.impl.SysParamServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String times = DateUtil.getCurrentDate_Time();
%>
<title>会议通知申请页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<!-- 引入提示 -->
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>

<script type="text/javascript" src="../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
	
<!-- 引入上传控件 -->
<link rel="stylesheet" href="../resources/plug/fancyupload/fancyupload.css" type="text/css" />
<script type="text/javascript" src="../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>

<!-- 引入formvValidatetion -->
<script src="../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>


<!-- 公共部分引用结束 -->
<script type="text/javascript">
function checkTitle(){
	        openAlertWindows('showReleaselist'
	                ,getCurrentFilePath()+'newsreleaselist.jsp?windowId=showReleaselist','新闻发布列表',800,450,'10%','10%');
}
function backTemplate(result){
	jQuery("#n_title").val(result.ins_name);
	jQuery("#n_org_id").val(result.org_id);
	jQuery("#n_org_name").text(result.org_name);
	jQuery("#ins_id").val(result.ins_id);
}
function lookContent(){
	var ins_id =  jQuery("#ins_id").val();
	if(ins_id==""){
		alert("请选择发布信息");
		return false;
	}
	 var json =  {
			 ins_id : jQuery("#ins_id").val(),
				action : 'look'
			};
	 var url = "newslookdo.jsp";
		jQuery.ajax({
			url : url,
			type : 'POST',
			dataType : 'json',
			data : json,
			async : true,
			success : function(data) {
				var url = '<%=path %>' + data.result.action_form + "?ins_id="+data.result.ins_id+"&busi_id="+data.result.busi_id+"&list_type=worklis&operType=yiban&act_name="+data.result.act_name+"&actiontype_code=04&busiTypeCode="+data.result.busiTypeCode
	  			  +"&template_id="+data.result.template_id+"&Template=word"+data.result.template_id+"&openType=openType";
		    	var height = window.screen.availHeight;
				var width = window.screen.availWidth;
				url= url+"&height="+height+"&width="+width;
			openAlertWindows('windowsId',url,data.result.ins_name,width,height,'0%','0%');
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("error:" + textStatus);
			}
		});
	 
	    
}
function saveTab() {
	var content = iframe_ewebeditor.getHTML(); //正文
	var title = jQuery("#n_title").val();
	if(title==""){
		alert("标题为空");
		return false;
	}
	if(title.length > 50){
		alert("标题不能超过50个汉字");
		return false;
	}
	if(content==""){
		alert("内容为空");
		return false;
	}
	var newsBeanjson =  {
			action : "insert",
			n_title : jQuery("#n_title").val(),
			n_org_id : jQuery("#n_org_id").val(),
			n_org_name : jQuery("#n_org_name").text(),	
			n_content : content,
			ins_id : jQuery("#ins_id").val()
		};
		var okF = function() {
			var params = {
				newsBeanjson : newsBeanjson
			};
			var url = "newsreleasedo.jsp";
			jQuery.ajax({
				url : url,
				type : 'POST',
				dataType : 'json',
				data : newsBeanjson,
				async : true,
				success : function(flag) {
					if (flag) {
						alert("操作成功！");
						location.href="newsrelease.jsp";
					} else {
						alert("操作失败！");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("error:" + textStatus);
				}
			});
		};
		var p = {
			headerText : '提示',
			okName : '确认',
			okFunction : okF,
			cancelName : '取消'
		};
		//toFrame(0);
		alert("确定发布吗？", p);
	}	
</script>
</head>
<body>
<form action="" id="form1" name="form1" method="post" >
<input type="hidden" id="n_org_id" name="n_org_id" value="" />
<input type="hidden" id="ins_id" name="ins_id" value="" />
<div id="maindiv" class="vcenter" style="height:500px; overflow:auto;">
	<div style="float: left; width: 990px;">
		<div class="content_02_box" style="width: 990px;">
		<div  class="content_02" style="overflow:hidden;" id="_top">
				            <div class="content_02_top" style="margin-bottom:10px;" >
				                <input name="PUBLISHED"   id="PUBLISHED"   value="发布"  onclick="saveTab();"  type="button" class="but_y_01" />
				                <input name="look"   id="look"   value="查看正文"  onclick="lookContent();"  type="button" class="but_y_01" />
				            </div>  
				        </div>
			<div class="content_02_box_title_bg" style="width: 98%;">
				<span>新闻信息发布</span>
			</div>
			<div class="content_02_box_div" style="width: 98%;">
				<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width: 100%;">
					<tr>
						<th class="content_02_box_div_table_th" style="width:150px">
							<span class="color_red">*</span>标题：
						</th>
						<td class="content_02_box_div_table_td" colspan="5" id ="p_title_test_id">
							<input type="text" class="validate[required,maxSize[100]] input_cx_title_240 m_title" 
							 style="width:600px;height:24px;" name="n_title" id="n_title" />
						    <input name="chose_notice_button" id="chose_notice_button"
                                   type="button"  class="but_x" style="display:block;" onclick="checkTitle()"/>
						    
						</td>
					</tr>
					<tr>
						<th  class="content_02_box_div_table_th" style="width:150px">
							所属部门/科室：
						</th>
						<td class="content_02_box_div_table_td" id="n_org_name"></td>
						<th width="200px" class="content_02_box_div_table_th">
							<span class="color_red">*</span>发布时间：
						</th>
						<td class="content_02_box_div_table_td"  colspan="3" id ="p_title_test_id">
							<%=times %>
						</td>
					</tr>
				</table>
			</div>
			<div class="content_02_box">
				<div class="content_02_box_title_bg">
						<span>内容</span>
					
					<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 				&nbsp;&nbsp;&nbsp;&nbsp;
	 			</span>
	 			
	 		 	<!--  <span class="color_red">备注：为规范邮件行文格式，请使用正常字体格式进行编辑！</span> -->
				</div>
				<div class="content_02_box_div">
					<textarea style="DISPLAY: none;" name="content" id="content"></textarea>
					<iframe id="iframe_ewebeditor"
						src="../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=content&style=gray"
						frameborder="0" scrolling="no" width="100%" height="460"></iframe>
				</div>
			</div>
		
		</div>
	</div>
</div>
</form>
</body>
</html>