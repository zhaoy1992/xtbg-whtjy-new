<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String submittedinfoId = request.getParameter("submittedinfoId");
InfoReportManagerDao infoReportdao = (InfoReportManagerDao)DaoImplClassUtil.getDaoImplClass("infoReportManagerDaoImpl");
InfoReportBaseInfoBean infoReportBaseInfoBean = infoReportdao.findInfoReportBaseInfo(submittedinfoId);

String sql = "select i.infotype_id, i.infotype_name from ta_oa_infre_info_type i where i.infotype_source = '"+InfoSource.INFORMATION_COLLECTION+"'";
String infotypeHtml = DictDropDownList.buildSelect(sql,"infotype_id",StringUtil.deNull(infoReportBaseInfoBean.getInfotype_id()),"",false,"");//信息类型下拉框
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoType"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.dao.InfoReportManagerDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoReportBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoSource"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息浏览上报展示(草稿箱)</title>
</head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script
	src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>



<!-- 引入jQuery_dialog -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery_dialog/jquery_dialog.css" />
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<script src="../resources/js/persondetailinfo.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet"
	href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css"
	type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js"
	type="text/javascript" charset="GBK">
	
</script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js"
	type="text/javascript" charset="GBK"></script>
<script type="text/javascript">
jQuery(document).ready(function() {
	// binds form submission and fields to the validation engine
	
	
	//$("#eWebEditor1").append($("#submit_content").val());
	jQuery("#form1").validationEngine();
});

	var saveInfo = function (){
		if(validateForm()){
			var url = "infoinputdetailsaveform.jsp";
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			$('#form1').submit();
		}
		
	}

	function validateForm(){
		var str = eWebEditor1.getHTML();
		
		
		$('#submit_content').val(str);
		if(IsSpace($('#submit_content').val())){
			alert("内容不能为空");
			return false;
		}
		return true;
	}
	
	function reportInfo(){
		if(validateForm()){
			chooseReportUnits();
			if(IsSpace($('#reportunits').val())){
				alert("请选择上报接收人！");
				return;
			}
			var url = "infoinputreportsaveform.jsp";
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			$('#form1').submit();
		}
	}

	var chooseReportUnits = function(){
		//var url = "../../tree/jsp/reportunittree.jsp?ischeck=true";
		var url = "../../tree/jsp/orguserroletree.jsp?ischeck=true&resourceType=INFOREPORT";

		 var orgObj= null;
		 orgObj = window.showModalDialog(url,"","dialogWidth=286px;dialogHeight=596px;center:yes;scroll:no");
		 if(!IsSpace(orgObj)){
		 	$('#reportunits').val(orgObj.id);
		 }
	}

	function backTo(){
		var url = "inforejectionlist.jsp";
		location.href = url;
	}
</script>
<body>
<form action="" id="form1" name="form1" method="post">
<input id="reportunits" name="reportunits" type="hidden" value=""></input>
	<table class="cQueryTableArea">
		<tr>
			<td colspan="4" align="left">
				<input class="cButton_4text" type="button" name="operation" value="上报" onclick="reportInfo()" id="reportinfo"/>
				<input class="cButton_4text" type="button" name="operation" value="保存" onclick="saveInfo()" id="saveinfo"/>
				<input class="cButton_4text" type="button" name="operation" value="返回" onclick="backTo()" id="backto"/>
			</td>
		</tr>
		<tr>
			<td class="tableLable"><FONT style="COLOR: red">*</FONT>标题
						<input type="hidden" id="submittedinfo_id" name="submittedinfo_id" value="<%=submittedinfoId %>" /></td>
			<td class="tableValue"><input class="validate[required] cText_out" id="submittedinfo_title" name="submittedinfo_title" value="<%=infoReportBaseInfoBean.getSubmittedinfo_title() %>" /></td>
			<td class="tableLable"><FONT style="COLOR: red">*</FONT>信息类型</td>
			<td class="tableValue"><%=infotypeHtml %></td>
		</tr>
		<tr>
			<td class="tableLable">录入部门</td>
			<td class="tableValue">
			<input class="cText_out" disabled="disabled" type="text" value="<%=infoReportBaseInfoBean.getOrg_name() %>" id="orgname" name="orgname"></input>
			</td>
			<td class="tableLable">录入者</td>
			<td class="tableValue">
			<input class="cText_out" disabled="disabled" type="text" value="<%=infoReportBaseInfoBean.getInputuser_name() %>" id="inputuser_name" name="inputuser_name"></input>
			</td>
		</tr>
		<tr>
			<td class="tableLable">关键字</td>
			<td class="tableValue"><input class="cText_out" id="keyword" name="keyword" value="<%=infoReportBaseInfoBean.getKeyword() %>"/></td>
			<td class="tableLable">退稿时间</td>
			<td class="tableValue"><input class="cText_out" id="release_time" name="release_time" disabled="disabled" value="<%=infoReportBaseInfoBean.getRelease_time() %>"></input></td>
		</tr>
		<tr>
			<td class="tableLable">退稿原因</td>
			<td class="tableValue" colspan="3">
				<input class="cText_out" id="andit_opinion" name="andit_opinion" value="<%=infoReportBaseInfoBean.getAndit_infos().size()>0?infoReportBaseInfoBean.getAndit_infos().get(0).getAndit_opinion():"" %>"/>
			</td>
		</tr>
		<tr>
			<td class="tableLable"><FONT style="COLOR: red">*</FONT>内容</td>
			<td colspan="3">
			<textarea id=submit_content name="submit_content" rows="1" cols="1" style="DISPLAY: none;"><%=infoReportBaseInfoBean.getSubmit_content()%></textarea>
			<iframe id="eWebEditor1" src="../../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=submit_content" frameborder="0" scrolling="no" width="100%" height="350"></iframe> 
			</td>
		</tr>
	</table>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>