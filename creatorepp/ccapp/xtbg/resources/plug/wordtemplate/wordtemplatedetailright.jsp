<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.wordtemplate.service.impl.WordTemplateServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.wordtemplate.service.WordTemplateServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.wordtemplate.entity.WordTemplateBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String userName = control.getUserName();
	String userId = control.getUserID(); 

	String template_id = request.getParameter("template_id");
	String orgId = control.getChargeOrgId();
	
	String sql = "select moduletype_logo, moduletype_name from ta_oa_moduletype";
	String str = "";
	
	
	String msg = "";
	WordTemplateBean wordTemplateBean = new WordTemplateBean();
	try{
		
		WordTemplateServiceIfc wordTemplate = new  WordTemplateServiceImpl();
		wordTemplateBean = wordTemplate.getWordTemplateInfoByMbId(template_id);
		str = DictDropDownList.buildSelect(sql,"moduletype_logo",StringUtil.deNull(wordTemplateBean.getModuletype_logo()),"",true,"");
		
	}catch(Exception e){
		e.printStackTrace();
		msg = "error";
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>


<!-- 引入其它 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">


$(function() {
	jQuery("#rightform").validationEngine();
	$("#tabs").tabs({
		select : function(event, ui) {
			var iframeitem = $(ui.panel).find("iframe");
			$(iframeitem).attr("src", $(iframeitem).attr("src"));
		}
	});
	$("#titleids").css('display','block');
	$("#tabs").tabs('select', '#tabs-1');
	$("#moduletype_logo").addClass("validate[required]");
});

var mb_id = $("#template_id").val();//creator_getQueryString("mb_id")== "null"?"":creator_getQueryString("mb_id");//模版ID

/*
    描述：初始化
*/
function init() {

    if(mb_id != "") {
        getTempLateInfo(); //如果是编辑，取模版
    }
}

/*
    描述：得到word模版信息
*/
function getTempLateInfo() {
    var template_result =  WordReport.getWordReport(mb_id);
    $("#module_name").val(template_result[0][1]);
    $("#module_remark").val(template_result[0][2]);
}

/*
    描述：添加/修改模版
*/
function saveWordReport() {
	
    if(!validate()){
        return;
    }    
    parent.frames["mainFrame"].$("#WebOffice1").hide();
    var url = "wordtemplatedo.jsp?operationType=dosavewordtemplate";
    document.all.rightform.action = url;
    document.all.rightform.target = "rightHiddenFrame";
    document.all.rightform.submit();	
}

function validate() {
	if(!jQuery("#rightform").validationEngine("validateform"))
		return false;
    var module_name = $("#template_name").val();
    if(module_name == "") {
        alert("模版名称不能为空");
        return false;
    }
    var template_sn = $("#template_sn").val();
    if(isNaN(template_sn)){
    	alert("模版序号只能为数字");
    	return false;
    }
    /*
    if(mb_id == "") {
        var num = WordReport.isWordReportOnlyOne(module_name);
        if(parseInt(num) != 0) {
            alert("WORD模版名称相同，请重新输入");
            return false;
        }
    }
    */
    return true;
}

function displaytab(tab,selfObj){
	var tag = document.getElementById("tabInfo").getElementsByTagName("div");
	var taglength = tag.length;
	for(i=0; i<taglength; i++){
		tag[i].className = "ditch-tab ditch-unfocused";
	}
	setTabHidden("true","ruleItemTab");
	setTabHidden("true","variableTab");
	setTabHidden("true","datasetTab");
	selfObj.className = "ditch-tab ditch-focused";	
	document.getElementById(tab).style.display="block";		
}
function doReturnOK(operationType){
	var okF=function(){
		var windowId = 'windowId1';
		removeAlertWindowByWindowID(windowId);
		
		parent.frames["mainFrame"].$("#WebOffice1").show();
    }
		
	var p={
		headerText:'提示',
		okName:'确认',
		okFunction:okF
	};
	alert("操作成功",p)

	var mbId = operationType.split("_")[1];
	$("#template_id").val(mbId);

	//parent.window.opener.document.location.reload();
}


</script>	
	
	
</head>
<body  style="overflow-y:hidden;">
<form action="" id="rightform" name="rightform" method="post">
<input type = "hidden" name = "template_userid" value = "<%=userId %>">
<input type = "hidden" name = "template_username" value = "<%=userName %>">
<input type = "hidden" name = "org_id" value = "<%=orgId %>">

<div  id="vcenter" style="float:left; width:100%; overflow-x:hidden;overflow-y:hidden;" >
	<div style="float: left; width: 775px; ">
		 <div class="content_02_box" >
		 <div class="content_02_box_title_bg"><span>模版基本信息</span></div>
		 <div class="content_02_box_div">
				<table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" >
				 <tr>
		           	   <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>模版分类：<INPUT id=template_id name="template_id" 
							type="hidden" value = "<%=StringUtil.deNull(wordTemplateBean.getTemplate_id()) %>"></th>
			           <td class="content_02_box_div_table_td">
							<%=str%>
			           </td>
		         </tr>
				<tr>
		           	   <th class="content_02_box_div_table_th">是否是通用模板：</th>
			           <td class="content_02_box_div_table_td">
						<SELECT id="is_common" name = "is_common" >
								<OPTION value="N" <%if("N".equals(wordTemplateBean.getIs_common())) {%>selected<%} %>>否</OPTION>
								<OPTION value="Y" <%if("Y".equals(wordTemplateBean.getIs_common())) {%>selected<%} %>>是</OPTION>
							</SELECT>
			           </td>
		         </tr>
				 <tr>
		           	   <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>模版名称：</th>
			           <td class="content_02_box_div_table_td">
			           <INPUT id="template_name" class="validate[required,maxSize[100]] input_185" name = "template_name" type="text" value = "<%=StringUtil.deNull(wordTemplateBean.getTemplate_name()) %>"/>
			           </td>
		         </tr>	
				  <tr>
		           	   <th class="content_02_box_div_table_th">模版序号：</th>
			           <td class="content_02_box_div_table_td">
			          <INPUT id="template_sn" class="input_185" name = "template_sn" type="text" value = "<%=StringUtil.deNull(wordTemplateBean.getTemplate_sn()) %>">
			           </td>
		         </tr>	
				  <tr>
		           	   <th class="content_02_box_div_table_th">描述：</th>
			           <td class="content_02_box_div_table_td">
			           <TEXTAREA id="template_remark" class="cTextarea" name = "template_remark"
							style="WIDTH: 100%; HEIGHT: 40px"><%=StringUtil.deNull(wordTemplateBean.getTemplate_remark()) %></TEXTAREA>
			           </td>
		         </tr>	
				 <TR>
						<TD colspan=2 align=right>
						<input class=but_y_01 type="button" id=btnSave onclick="saveWordReport()" value="保存">
						</TD>
					</TR>
				</table>
			</div>
			</div>

	</div>
</div>
<iframe name = "rightHiddenFrame" width = "0" height = "0"></iframe>
</form>
</body>
</html>