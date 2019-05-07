<%--
描述：档案管理-档案移交-移交记录
作者：邹拓
版本：1.0
日期：2013-7-16
UTF-8
参数列表
f_devolve_id:档案分类id
actionName:insert OR update OR query
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesDevolveService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesDevolveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileConstant"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesService"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileFilesDevolveBean"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	
	String actionName = request.getParameter("actionType");
	String busi_id = request.getParameter("busi_id");
	String zipFileName = StringUtil.deNull(request.getParameter("zipFileName"));
	String f_title = request.getParameter("f_title");
	String f_type = request.getParameter("f_type");
	f_title = (f_title!=null)?Escape.unescape(DataControlUtil.replaceStr(f_title)):"档案移交";
	if(zipFileName.length()==0){
		zipFileName = f_title+"["+DateUtil.getCurrentDate()+"]";
	}
	String ciPanName = StringUtil.deNull(request.getParameter("ciPanName"));
	if(ciPanName.length()==0){
		ciPanName = "E:\\";
	}
	//给档次移交的所有文档打包
	if("newZIP".equals(actionName)){
		
	}
	boolean canEdit = false;
	FileFilesDevolveService service = new FileFilesDevolveServiceImpl();
	Map<String,String> bean = new HashMap<String,String>();
	String actionNameStr = "";
	if("insert".equals(actionName)){
		actionNameStr = "增加移交记录";
		canEdit = true;
		bean.put("f_attach_id",StringUtil.getUUID());
		
		bean.put("f_log_user_id",accesscontroler.getUserID());
		bean.put("f_log_user_name",accesscontroler.getUserName());
		
		bean.put("f_log_time",DateUtil.getCurrentDateTime());
		bean.put("f_year",DateUtil.getCurrentYear());
		
		bean.put("f_org_id",userBean.getUnit_id());
		bean.put("f_org_name",userBean.getUnit_name());
		
		bean.put("f_dept_id",userBean.getOrg_id());
		bean.put("f_dept_name",userBean.getOrg_name());
		
		bean.put("f_state",FileFilesDevolveBean.STATE_ONE);
		
		bean.put("f_fonds_no",service.getQZH(userBean.getUnit_id()));
	}else{
		actionNameStr = "修改移交记录";
		String f_devolve_id = request.getParameter("f_devolve_id");
		bean = service.getBeanById(f_devolve_id);
		if("update".equals(actionName)){
			actionNameStr = "修改移交记录";
			canEdit = true;
		}else if("query".equals(actionName)){
			actionNameStr = "查询移交记录";
			canEdit = false;
		}
	}
	//
	String windowId = "updateFileFilesDevolveBean";
	if(request.getParameter("windowId")!=null){
		windowId = request.getParameter("windowId");
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
	<!-- 引入jGrid -->
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	
	<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	
	<link rel='stylesheet' href='../../resources/plug/fancyupload/fancyupload.css' type='text/css' />
	<script type='text/javascript' src='../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js'></script>
	<script type='text/javascript' src='../../resources/plug/fancyupload/source/Fx.ProgressBar.js'></script>
	<script type='text/javascript' src='../../resources/plug/fancyupload/source/Swiff.Uploader.js'></script>
	<script type='text/javascript' src='../../resources/plug/fancyupload/source/FancyUpload3.Attach.js'></script>
	<script type='text/javascript' src='../../resources/plug/fancyupload/myfancyupload.js'></script>
	<script type="text/javascript">
	jQuery(function(){
		initSubmitEvent();
		initElement();
	});
	function initSubmitEvent(){
		jQuery("#submitBtn").click(function(){
			var zipFileName = jQuery("#zipFileName").val();
			if(zipFileName){
				regx = /[\\\\]|[/]|[:]|[*]|[?]|[<]|[>]|[|]|[\"]|[.]/;
				if(regx.test(zipFileName)){
					alert("移交主题不能含有 \\ / : * ? < > | \" .");
				}else{
					jQuery("#formA").submit();
					this.disabled=true;
				}
			}else{
				alert("移交主题不能为空");
			}
		});
	}
	function initElement(){
		<%if("newZIP".equals(actionName)){%>
		jQuery("#submitBtn").attr("disabled","disabled");
		jQuery("#zipFileName").attr("disabled","disabled");
		jQuery("#ciPanName").attr("disabled","disabled");
		<%}%>
	}
	</script>
</head>
<body style="overflow-x: auto;overflow-y: auto;margin-top:-4px;">
<div>
<form id="formA" method="post" action="exportfilefilesdevolveinfo.jsp" >
	<input
		id="actionType" 
		name="actionType" 
		type="hidden"
		value="newZIP"/>
	<input
		id="busi_id" 
		name="busi_id" 
		type="hidden"
		value="<%=busi_id%>"/>
	<input
		id="f_type" 
		name="f_type" 
		type="hidden"
		value="<%=f_type%>"/>
	<table id="queryTable"  border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
		<tr>
			<td>
<table  style="width:100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
	<tr>
		<th class="input_cx_title_th" style="width:260px;">
			导出的压缩文件名称(移交主题)：
		</th>
		<td style="width: 180px" class="cx_title_td">
			<input
				value="<%=zipFileName%>"
				id="zipFileName" 
				name="zipFileName"
				type="text"
				style="width:180px;"
				class="input_cx_title_283"/>
		</td>
		<td style="width:140px;">
			<input value="生成移交文件压缩包" id="submitBtn" type="button" class="but_y_06" style="width:120px;float: left;margin-left: 5px;" />
		</td>
	</tr>
	<tr>
		<th class="input_cx_title_th" style="width: 260px;">
			设置mdb文件中"电子文件名称"列的磁盘编号：
		</th>
		<td style="width: 180px" class="cx_title_td">
			<input
				value="<%=ciPanName%>"
				id="ciPanName" 
				name="ciPanName"
				type="text"
				style="width:180px;"
				class="input_cx_title_283"/>
		</td>
		<td style="width:140px;">&nbsp;</td>
	</tr>
</table>
			</td>
		</tr>
	</table>
</form>
</div>
<script type="text/javascript">
initElement();
</script>
<div>
<textarea readonly="readonly" style="font-size:11px;" rows="10" cols="80" onpropertychange="javascript: jQuery(this).scrollTop(this.scrollHeight);">
<%
Map<String,String> map = null;
if("newZIP".equals(actionName)){
	FileFilesDevolveService s2 = new FileFilesDevolveServiceImpl();
	map = s2.createZIPForDevolve(out,request,busi_id,f_type);
}%>
</textarea>
</div>

<br/>
<div style="width:100%;text-align: center">
<%if(map!=null){
String name = map.get("name");
String url = map.get("url");
%>
<a id='zipDownA' href='#')>点击下载移交文件压缩包</a>
<script>
	var hrefPath = encodeURI(encodeURI('<%=url%>'));
	var zwName = encodeURI(encodeURI('<%=name%>'));
	jQuery("#zipDownA").attr("href","download.jsp?hrefPath="+hrefPath+"&zwName="+zwName);
</script>
<%
}%>
</div>
</body>
</html>