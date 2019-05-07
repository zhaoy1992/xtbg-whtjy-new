<%--
描述：信息报送模版管理基础界面
作者：黄海
版本：1.0
日期：2013-09-13
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
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);

	Map<String, String> bean = new HashMap<String, String>();

	String actionName = request.getParameter("actionName");
	String actionNameStr = "";
	String user_id = accesscontroler.getUserID();
	//当前模版ID
	String p_template_id = request.getParameter("p_template_id");

	UserCacheBean userBean = UserCache.getUserCacheBean(accesscontroler
			.getUserID());
	if (userBean == null) {
		userBean = new UserCacheBean();
	}
	
	//单位ID
	String p_unit = userBean.getUnit_id();

	//模版管理
	PaperTemplateService service = new PaperTemplateServiceImpl();
	if ("insert".equals(actionName)) {
		//单位信息
		bean.put("p_template_unitid", userBean.getUnit_id());
		bean.put("p_template_unit", userBean.getUnit_name());
		//用户信息
		bean.put("create_userid", accesscontroler.getUserID());
		bean.put("create_username", accesscontroler.getUserName());
		//登记日期
		bean.put("create_time", DateUtil.getCurrentDateTime());

	} else {
		bean = service.getPaperTemplateBean(p_template_id);
		//模版ID
		bean.put("p_template_id", bean.get("p_template_id"));
		//模版名称
		bean.put("p_template_name", bean.get("p_template_name"));
		//模版类型
		bean.put("p_template_typeid", bean.get("p_template_typeid"));
		//单位
		bean.put("p_template_unitid", bean.get("p_template_unitid"));
		bean.put("p_template_unit", bean.get("p_template_unit"));
		//登记日期
		bean.put("p_creater_time", bean.get("p_creater_time"));
		//内容
		bean.put("content",bean.get("content"));
	}
	//下拉框  选中的id由bean存的值确定
    String p_template_type = "p_template_type";//年份
    String p_type_id_selectHtml = DictDropDownList.buildSelect4DictType(p_template_type,"p_template_typeid" ,StringUtil.deNull(bean.get("p_template_typeid")), "" , false, "" ,"" ,"class='select_100_box_type'","" );

	//界面名称
	if ("update".equals(actionName) || "insert".equals(actionName)) {
		actionNameStr = "模版管理明细界面";
	} else if ("query".equals(actionName)) {
		actionNameStr = "模版管理明细界面";
	}
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
	<!-- 引入资料个人js -->
	<script type="text/javascript" src="../resources/js/papertemplate.js" ></script>
	
	<script type="text/javascript">
	//路径
	var path = "<%=path%>";
	//当前用户ID
	var user_id ="<%=user_id%>";
	//单位ID
	var p_unit="<%=p_unit%>";
	//界面按钮事件
	updateFn = function(flag,inputObj){
				try{
					inputObj.disabled=true;
					if(flag==='save'){
						var isFlag = jQuery('#formTable').validationEngine('validate'); //是否全部验证通过
						var str = eWebEditor1.getHTML();
						jQuery('#content').val(str);
							if(IsSpace(jQuery('#content').val())){
								alert("模版内容不能为空！");
								inputObj.disabled=false;
								return false;
							}
						if (isFlag){
							jQuery("#hidden_action").val("addPaperTemplateInfo");
							jQuery("#onlyFrom").submit();
						}
					}else if(flag==='back'){
						var p={
							headerText:'提示',
							okName:'确认',
					        okFunction:function(){
					        	removeWindows('paperTemplateinfo',true);
					        },
					        cancelName:'取消'
						};
						alert("返回后，数据将不会保存，确定返回？",p);
					}
					inputObj.disabled=false;
				}catch(e){alert(e.description);inputObj.disabled=false;}
			};
			
			<%--提交后回调--%>
			afterSubmitFn=function(result){
				try{
					if(result.indexOf("delete")!=-1){
						alert(result.split(",")[1]);
						searchData();
					}else{
						if(result.split(",").length>1){
								result = result.split(",");
								alert(result[0]);
								window.location.href="<%=path%>/ccapp/oa/paper/jsp/papertemplatelist.jsp";
						} else {
							alert(result);
							window.location.href="<%=path%>/ccapp/oa/paper/jsp/papertemplatelist.jsp";
						}
						
					}
				}catch(e){alert(e.description);}
			};
	</script>
</head>
<body style="overflow-x: auto;" onload="adaptationWH('_top','tabs1',0);">
<div id='tabs1' style="width:100%">
<%--button list--%>
<div class="content_02_top" style="margin-bottom:10px;width:99%" id="divA">
		<input type="button" class="but_y_01" value="保存" onclick="updateFn('save',this);" id="btn_insert"/>
		<input type="button" class="but_y_01" value="返回" onclick="updateFn('back',this);" id="btn_update"/>
</div>
<%--button list--%>

<form id="onlyFrom" name="onlyFrom" method="post" action="papertemplateinfodo.jsp" target="fileTempleateinfodoJSPhiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<input value="<%=StringUtil.deNull(bean.get("p_template_id"))%>" type='hidden' name='p_template_id' id="p_template_id"/>
<input value="<%=StringUtil.deNull(bean.get("create_userid"))%>" type='hidden' name='create_userid' id="create_userid"/>
<input value="<%=StringUtil.deNull(bean.get("create_username"))%>" type='hidden' name='create_username' id="create_username"/>
<input value="<%=StringUtil.deNull(bean.get("create_time"))%>" type='hidden' name='create_time' id="create_time"/>

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
											<th class="content_02_box_div_table_th" style="width: 150px;"><span
												style="color: red;">*</span>模版名称：</th>
											<td class="content_02_box_div_table_td" style="width: 220px;"
												colspan="3"><input
												value="<%=StringUtil.deNull(bean.get("p_template_name"))%>"
												type="text" name="p_template_name" id="p_template_name"
												class="validate[required,maxSize[200]] input_title_text" />
											</td>
										</tr>
										<tr>
											<th class="content_02_box_div_table_th" style="width: 150px;">模板类型：</th>
											<td class="content_02_box_div_table_td" style="width: 210px;"
												colspan="3">
												 <%=p_type_id_selectHtml %>
												</td>
										</tr>
										<tr>
											<th class="content_02_box_div_table_th" style="width: 150px;">使用单位：</th>
											<td class="content_02_box_div_table_td" style="width: 210px;"
												colspan="3">
												<input
												value="<%=StringUtil.deNull(bean.get("p_template_unit"))%>"
												name="p_template_unit" id="p_template_unit" type="text"
												readonly="readonly"
												class="validate[required,maxSize[100]] input_160"
												style="width: 180px; height: 22px;" />
												<input
												name="p_type_name_button" id="p_type_name_button"
												type="button" class="but_x" style="height: 24px;" onclick="chooseOrg('p_template_unitid','p_template_unit');"/> <input
												value="<%=StringUtil.deNull(bean.get("p_template_unitid"))%>"
												name="p_template_unitid" id="p_template_unitid" type="hidden" /></td>
										</tr>
									</table>
								</div>
							</div>
							<div class="content_02_box">
								<div class="content_02_box_title_bg">
									<span>模版内容</span> <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</span>
									<!-- <span class="color_red">备注：为保证您发送的内容在移动端显示美观，请您使用规范的行文字体格式进行编辑！</span> -->
									<span class="color_red">提示：可以直接粘贴word、excel表格</span>
									<div class="content_02_box_add" id="t2">
										<span id="selAreaImg" class="tabs_search_text_but"></span>
									</div>
								</div>
								<div class="content_02_box_div">
									<table border="0" cellspacing="0" cellpadding="0"
										class="content_02_box_div_table">
										<tr>
											<td colspan="4"><textarea id=edit_content_phone
													name="edit_content_phone" rows="1" cols="1"
													style="DISPLAY: none;"><%=StringUtil.deNull(bean.get("content"))%></textarea><textarea
													style="display: none" name="content" id="content"><%=StringUtil.deNull(bean.get("content"))%></textarea> <iframe
													id="eWebEditor1"
													src="../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=content&style=gray"
													frameborder="0" scrolling="no" width="100%" height="400"></iframe>
											</td>
										</tr>
									</table>
								</div>
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
