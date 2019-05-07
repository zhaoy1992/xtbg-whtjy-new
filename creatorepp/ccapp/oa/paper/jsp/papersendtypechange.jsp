<%--
描述：信息报送管理
作者：黄海
版本：1.0
日期：2013-09-28
--%>
<%@page import="com.chinacreator.xtbg.core.paper.service.impl.PaperTemplateServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.PaperTemplateService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>

<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String actionName = request.getParameter("actionName");
	String actionNameStr = "信息发布";
	String user_id = accesscontroler.getUserID();
	UserCacheBean userBean = UserCache.getUserCacheBean(accesscontroler.getUserID());
	if (userBean == null) {
		userBean = new UserCacheBean();
	}
	//单位ID
	String p_unit = userBean.getUnit_id();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">jQuery.noConflict();</script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<!-- 引入formvValidatetion -->
	<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
	<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script type="text/javascript" src="../../resources/util/public.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<!-- 引入上传控件 -->
	<link rel="stylesheet" href="../../resources/plug/fancyupload/fancyupload.css" type="text/css" />
	<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
	<!-- 引入jGrid -->
	<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	<script type="text/javascript" src="../../resources/util/jsonutil.js" ></script>
	<script type="text/javascript">
	//win
	var windowId = "<%=StringUtil.deNull(request.getParameter("windowId"))%>";
	//路径
	var path = "<%=path%>";
	//当前用户ID
	var user_id ="<%=user_id%>";
	//单位ID
	var p_unit="<%=p_unit%>";
	//界面按钮事件
	sendFn = function(flag,inputObj){
		try{
			inputObj.disabled=true;
			if(flag==='send'){
				var isFlag = jQuery('#formTable').validationEngine('validate'); //是否全部验证通过
				if (isFlag){
					jQuery("#hidden_action").val("SaveReceiveInfo");
					jQuery("#onlyFrom").submit();
				}
			}
			inputObj.disabled=false;
		}catch(e){alert(e.description);inputObj.disabled=false;}
	};
	
	<%--提交后回调--%>
	afterSubmitFn=function(result){
		result=JSON.parse(result);
		if(result.flag==true){
			alert(result.info);
			closeAlertWindows(windowId,true,true);
		}else{
			alert(result.info);
		}
	};
	
	
	
	/*
	函数:  chooseCheckOrg
	说明:  选择多选单位
	参数：   orgId（回填父页面的控件id）,orgName（回填父页面的控件id）
	*/
	var chooseCheckOrg = function(orgId,orgName) {
		var s = new jQuery.z_tree();
		s.treeID = 'mian';
		s.treetypestr='checkbox';
		s.isShowSeacher = true;
		s.treeName = "选取单位";
		s.isType = 'dept';
		s.headerName = "选取单位";
		s.selectedIds = jQuery('#p_template_unitid').val();
		s.type = 'AORG';
		s.returnFunction = function(orgObj) {
			if (!IsSpace(orgObj)) {
				jQuery('#'+orgId).val(orgObj.id);
				jQuery('#'+orgName).val(orgObj.name);
			} else {
				jQuery('#'+orgId).val("");
				jQuery('#'+orgName).val("");
			}
		}
		s.init();
	}

	/*
	函数:  chooseCheckPerson
	说明:  选择多选人员
	参数：   userId（回填父页面的控件id）,userName（回填父页面的控件id）
	*/
	var chooseCheckPerson = function(userId,userName) {
		var s = new jQuery.z_tree();
		s.treeID = 'mianUser';
		s.treetypestr='checkbox';
		s.isShowSeacher = true;
		s.treeName = "选取人员";
		s.headerName = "选取人员";
		s.selectedIds = jQuery('#p_paper_userid').val();
		s.type = 'APERSON';
		s.returnFunction = function(userObj) {
			if (!IsSpace(userObj)) {
				jQuery('#'+userId).val(userObj.id);
				jQuery('#'+userName).val(userObj.name);
			} else {
				jQuery('#'+userId).val("");
				jQuery('#'+userName).val("");
			}
		}
		s.init();
	}

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
	</script>
</head>
<body style="overflow-x: auto;" onload="adaptationWH('_top','tabs1',0);">
<div id='tabs1' style="width:100%">
<%--button list--%>
<div class="content_02_top" style="margin-bottom:10px;width:99%" id="divA">
		<input type="button" class="but_y_01" value="保存" onclick="sendFn('send',this);" id="btn_send"/>
		<input type="button" class="but_y_01" value="返回" onclick="closed();" id="btn_close"/>
</div>
<%--button list--%>

<form id="onlyFrom" name="onlyFrom" method="post" action="papersendtypechangedo.jsp" target="fileTempleateinfodoJSPhiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<input type='hidden' name='p_manage_ids' value='<%=request.getParameter("p_manage_ids")%>' />
<table>
	<tr>
		<td width="98%" align="left" valign="top">
			<div id="vcenter" style="float:left;width:100%; overflow:hidden">
				<div class="content_02_box">
					<div class="content_02_box_title_bg">
						<span><%=actionNameStr%></span>
					</div>
					<div class="content_02_box_div">
						<table id='formTable' border="0" cellspacing="0"
							cellpadding="0" class="content_02_box_div_table">
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;"><input type="radio" name="sendType" value="0" checked="checked">普发&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<td class="content_02_box_div_table_td" style="width: 210px;" colspan="3">
								&nbsp;
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;"><input type="radio" name="sendType" value="1">定向单位&nbsp;</th>
									<td class="content_02_box_div_table_td" style="width: 210px;"
										colspan="3">
										<input value="" name="p_paper_unit" id="p_paper_unit" type="text" readonly="readonly" class="input_160" style="width: 180px; height: 22px;" /> 
										<input name="p_type_name_button" id="p_type_name_button" type="button" class="but_x" style="height: 24px;" onclick="chooseCheckOrg('p_paper_unitid','p_paper_unit');" />
										<input value="" name="p_paper_unitid" id="p_paper_unitid" type="hidden" />
									</td>
								</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;"><input type="radio" name="sendType" value="2">定向个人&nbsp;</th>
								<td class="content_02_box_div_table_td" style="width: 210px;" colspan="3">
									<input
									value=""
									name="p_paper_user" id="p_paper_user" type="text"
									readonly="readonly"
									class="input_160"
									style="width: 180px; height: 22px;" />
									<input
									name="p_type_name_button" id="p_type_name_button"
									type="button" class="but_x" style="height: 24px;" onclick="chooseCheckPerson('p_paper_userid','p_paper_user');"/> <input
									value=""
									name="p_paper_userid" id="p_paper_userid" type="hidden" />
								</td>
							</tr>
						</table>
					</div>
				</div>
							
		</td>
	</tr>
</table>
</form>
<iframe name="fileTempleateinfodoJSPhiddenFrame" width=0 height=0></iframe>
</div>
<script>
if(jQuery("#vcenter").width()>jQuery("body").width()){<%--1024*?分辨率下,拉长divA宽度--%>
	jQuery("#divA").width(jQuery("#vcenter").width()+10);
}else{<%--1440*?分辨率下,缩短divA宽度,防止横向滚动条出现--%>
	jQuery("#divA").width(jQuery("body").width()-19);
}
</script>
</body>
<script type="text/javascript" >
jQuery(function(){
	jQuery("#formTable").validationEngine();
});
</script>
</html>
