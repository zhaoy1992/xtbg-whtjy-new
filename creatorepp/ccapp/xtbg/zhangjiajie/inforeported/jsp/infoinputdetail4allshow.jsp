<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.zhangjiajie.inforeported.entity.InfoSource"%><html>
<%
	AccessControl accesscontrol = AccessControl.getAccessControl();
	accesscontrol.checkAccess(request,response);
	String orgname = accesscontrol.getChargeOrgName();
	String orgid = accesscontrol.getChargeOrgId();
	String username = accesscontrol.getUserName();
	String userid = accesscontrol.getUserID();
	
	String sql = "select i.infotype_id, i.infotype_name from ta_oa_infre_info_type i where i.infotype_source = '"+InfoSource.INFORMATION_COLLECTION+"'";
	String infotypeHtml = DictDropDownList.buildSelect(sql,"infotype_id","","",true,"");//信息类型下拉框
%>
<head>
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
	type="text/javascript" charset="GBK">
</script>
<script type="text/javascript">
jQuery(document).ready(function() {
	// binds form submission and fields to the validation engine
	jQuery("#form1").validationEngine();
});

	var saveInfo = function (){
		if(validateForm()){
			var url = "infoinputsubmittedsaveform.jsp";
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
	
	function publishInfo(){
		if(validateForm()){
			var url = "infoinputpublishedsaveform.jsp";
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			$('#form1').submit();
		}
	}

	var choosePartUnits = function(){
		//var url = "../../tree/jsp/publishparttree.jsp?ischeck=true";
		var url = "../../tree/jsp/orguserroletree.jsp?ischeck=true&resourceType=PUBULISH&backchooseuserids="+$("#partunits").val();
		
		 var orgObj= null;
		 orgObj = window.showModalDialog(url,"","dialogWidth=286px;dialogHeight=596px;center:yes;scroll:no");
		 if(!IsSpace(orgObj)){
			$('#partunits').val(orgObj.id);
		 	$('#published_user_name').val(orgObj.name);
		 }
	}

	function backTo(){
		var url = "infoshowalllist.jsp";
		location.href = url;
	}
	
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>信息录入详细页面</title>

</head>
<body>
<form action="" id="form1" name="form1" method="post">
	<table class="cQueryTableArea" >
		<tr>
			<td colspan="5" align="left">
				<input class="cButton_4text" type="button" name="operation" value="保存" onclick="saveInfo()" id="saveinfo"/>
				<input class="cButton_4text" type="button" name="operation" value="发布" onclick="publishInfo()" id="publishinfo"/>
				<input class="cButton_4text" type="button" name="operation" value="返回" onclick="backTo()" id="backto"/>
			</td>
		</tr>
		<tr>
			<td class="tableLable" width="10%"><FONT style="COLOR: red">*</FONT>标题
			</td>
			<td class="tableValue" width="25%"><input class="validate[required] cText_out" type="text" id="submittedinfo_title" name="submittedinfo_title"></input></td>
			<td class="tableLable" width="15%">信息类型</td>
			<td class="tableValue" width="25%">
				<%=infotypeHtml%>
			</td>
			<td width="30%"></td>
		</tr>
		<tr>
			<td class="tableLable">录入部门</td>
			<td class="tableValue">
				<input class="cText_out" readonly="readonly" type="text" value="<%=orgname %>" id="orgname" name="orgname"></input>
				<input type="hidden"  name="orgid" id="orgid" value="<%=orgid %>">
			</td>
			<td class="tableLable">录入者</td>
			<td class="tableValue">
				<input class="cText_out" readonly="readonly" type="text" value="<%=username %>" id="inputuser_name" name="inputuser_name"></input>
				<input type="hidden"  name="inputuser_id" id="inputuser_id" value="<%=userid %>">
			</td>
			<td></td>
		</tr>
		<tr>
			<td class="tableLable">关键字</td>
			<td class="tableValue"><input class="cText_out" type="text" id="keyword" name="keyword"></input></td>
			<td class="tableLable">录入时间</td>
			<td class="tableValue"><input class="cText_out" readonly="readonly" type="text" id="input_date"></input></td>
			<td></td>
		</tr>
		<tr>
			<td class="tableLable"><FONT style="COLOR: red">*</FONT>发布接收人</td>
			<td class="tableValue">
			<INPUT class="validate[required] cText_out" style="width:80%"
			 id="published_user_name" name="published_user_name" 
			value=""
			readOnly size=13 onclick='choosePartUnits()'>
	  		<input type="hidden" id=partunits name="partunits"/>
	  		<IMG
			style="POSITION: static; WIDTH: 18px; HEIGHT: 16px;"
			id=img1  alt=选择受理单位 onclick='chooseOrg()'
			src="../../../resources/images/zoom_in2.gif">
			</td>
			<td class="tableLable"></td>
			<td></td>
		</tr>
		<tr>
			<td colspan="5">
			<textarea id=submit_content name="submit_content" rows="1" cols="1" style="DISPLAY: none;"></textarea>
			<iframe id="eWebEditor1" src="../../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=submit_content" frameborder="0" scrolling="no" width="100%" height="350"></iframe> 
			</td>
		</tr>
		
	</table>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>