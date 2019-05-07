<%--
　　描述：配置右边页面
　　作者：黄艺平
　　版本：1.0
　　日期：2013-08-1
--%>
<%@page import="com.chinacreator.xtbg.core.common.iweboffice.bean.ThWordTemplateBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String userName = control.getUserName();
	String userId = control.getUserID(); 
	String path = request.getContextPath();

	String template_id_th = request.getParameter("template_id_th");
	String msg = "";
	ThWordTemplateBean bean = new ThWordTemplateBean();
	try{
		WordTemplateServiceIfc wordTemplate = new  WordTemplateServiceImpl();
		bean = wordTemplate.getThWordTemplateInfoByMbId(template_id_th);
	}catch(Exception e){
		e.printStackTrace();
		msg = "error";
	}
	
	String sql = "select t.busitype_code,t.busitype_name from oa_flow_busitype t where t.is_valid='Y'";
	String busitypeCodeHtml = DictDropDownList.buildSelect(sql,"busitype_code",StringUtil.deNull(bean.getBusitype_code()),"",true,"","width:188px");//流程业务类型
%>

<%@page import="com.chinacreator.xtbg.core.common.iweboffice.bean.WordTemplateBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.common.iweboffice.service.impl.WordTemplateServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript" ></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" ></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" ></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" ></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>

<script language="javascript" src="js/wordtemplateutil.js"> </script>
<script type="text/javascript">
var path = "<%=path%>";
var defalutTable = "";
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

var mb_id = $("#template_id_th").val();
function createrDiv(msg){
	var bgObj=document.createElement("div");  
	bgObj.setAttribute('id','EV_bgModeAlertDiv');  
	bgObj.setAttribute('class','_lock_div');
	bgObj.setAttribute('style','z-index: 1999; height:1050px; font-size: 80px;line-height:768px;MARGIN-RIGHT: auto;MARGIN-LEFT: auto;text-align :center;');  
	bgObj.innerHTML = 'Loading......';
	//document.body.appendChild(bgObj);
	window.body.appendChild(bgObj);
}

/*
	函数：init
	描述：初始化
	参数：
	返回值：
*/
function init() {

    if(mb_id != "") {
        getTempLateInfo(); //如果是编辑，取模版
    }
}

/*
	函数：getTempLateInfo
	描述：得到word模版信息
	参数：
	返回值：
*/
function getTempLateInfo() {
    var template_result =  WordReport.getWordReport(mb_id);
    $("#module_name").val(template_result[0][1]);
    $("#module_remark").val(template_result[0][2]);
}

/*
	函数：saveWordReport
	描述：添加/修改模版
	参数：
	返回值：
*/
function saveWordReport() {
    if(!validate()){
        return;
    }    
    parent.frames["mainFrame"].$("#WebOffice1").hide();
    var url = "thwordtemplatedo.jsp?operationType=dosavethwordtemplate";
    document.all.rightform.action = url;
    document.all.rightform.target = "rightHiddenFrame";
    document.all.rightform.submit();	
}

/*
	函数：validate
	描述：验证
	参数：
	返回值：
*/
function validate() {
	if(!jQuery("#rightform").validationEngine("validateform"))
		return false;
    var module_name = $("#template_name_th").val();
    if(module_name == "") {
        alert("模版名称不能为空");
        return false;
    }
    var template_sn = $("#template_sn_th").val();
    if(isNaN(template_sn)){
    	alert("模版序号只能为数字");
    	return false;
    }
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
	$("#template_id_th").val(mbId);

}
//选择机构
var chooseOrg = function (){
	parent.frames["mainFrame"].$("#WebOffice1").hide();
    var s = new jQuery.z_tree();
      s.treeID='mian';
      s.treetypestr='radio';
      s.isShowSeacher=true;
      s.treeName="选取单位";
      s.isType='dept';
      s.headerName="选取单位";
      s.item_id = 'org_id';
      s.selectedIds=jQuery('#org_id').val();
      s.type='AORG';
      s.callbackcancel=back;
      s.returnFunction=function(orgObj){
          if(!IsSpace(orgObj)){
                 jQuery('#org_id').val(orgObj.id);
                 jQuery('#org_name').val(orgObj.name);
             }else{
                 jQuery('#org_id').val("");
                 jQuery('#org_name').val("");
             }
	      //jQuery("#EV_bgModeAlertDiv").remove();
	      window.body.removeChild(window.body.lastChild);
	      parent.frames["mainFrame"].$("#WebOffice1").show();
          
         }
      s.init();
      createrDiv();
}
/**
 *回调 弹出树
 */
function back(){
	window.body.removeChild(window.body.lastChild);
	parent.frames["mainFrame"].$("#WebOffice1").show();
}
/**
 *设置默认的表
 */
function setDefalutTable(defalutTable1){
	defalutTable = defalutTable1;
}
</script>	
	
	
</head>
<body  style="overflow-y:hidden;" id="bodyid">
<form action="" id="rightform" name="rightform" method="post">
<input type = "hidden" name = "template_userid_th" value = "<%=userId %>">
<input type = "hidden" name = "template_username_th" value = "<%=userName %>">
<INPUT id="template_id_th" name="template_id_th" type="hidden" value = "<%=StringUtil.deNull(bean.getTemplate_id_th()) %>">
<div  id="vcenter" style="float:left; width:100%; overflow-x:hidden;overflow-y:hidden;" >
	<div style="float: left; width: 775px; ">
		 <div class="content_02_top" style="margin-bottom: 10px;" id="_top">
			<input id="saveButton" name="saveButton" type="button" class="but_y_01"
			    value="保存" onClick="saveWordReport();" /> 
		 </div>
		 <div class="content_02_box_title_bg"><span>模版基本信息</span></div>
		 <div class="content_02_box_div">
				<table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" >
				<tr>
		           	   <th class="content_02_box_div_table_th">是否是套红模板：</th>
			           <td class="content_02_box_div_table_td">
						<SELECT id="is_common_th" name = "is_common_th" >
								<OPTION value="Y" <%if("Y".equals(bean.getIs_common_th())) {%>selected<%} %>>是</OPTION>
								<OPTION value="N" <%if("N".equals(bean.getIs_common_th())) {%>selected<%} %>>否</OPTION>
							</SELECT>
			           </td>
		         </tr>
				 <tr>
		           	   <th class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>模版名称：</th>
			           <td class="content_02_box_div_table_td">
			           <INPUT id="template_name_th" class="validate[required,maxSize[100]] input_185" name = "template_name_th" type="text" value = "<%=StringUtil.deNull(bean.getTemplate_name_th()) %>"/>
			           </td>
		         </tr>
		         <tr>
		           	  <th class="content_02_box_div_table_th"><span style="color: red">*</span>所属机构：</th>
       	 			  <td class="content_02_box_div_table_td"><INPUT class="validate[required] input_160"
            			onmouseover="this.title=this.value" id="org_name" name="org_name"
           				value="<%=StringUtil.deNull(bean.getOrg_name())%>" readOnly
            			onclick='chooseOrg()' style="width: 185px" > <input name="" type="button" value=""
           				class="but_x" onclick="chooseOrg()" /> <input type="hidden"
            			id=org_id name=org_id
            			value="<%=StringUtil.deNull(bean.getOrg_id())%>" /></td>
		         </tr>	
				  <tr>
		           	   <th class="content_02_box_div_table_th">模版序号：</th>
			           <td class="content_02_box_div_table_td">
			          <INPUT id="template_sn_th" class="validate[custom[onlyNumberSp],maxSize[5]] input_185" name = "template_sn_th" type="text" value = "<%=StringUtil.deNull(bean.getTemplate_sn_th()) %>">
			           </td>
		         </tr>	
				  <tr>
		           	   <th class="content_02_box_div_table_th">描述：</th>
			           <td class="content_02_box_div_table_td">
			           <TEXTAREA id="template_remark_th" class="cTextarea" name = "template_remark_th"
							style="62px; HEIGHT: 40px"><%=StringUtil.deNull(bean.getTemplate_remark_th()) %></TEXTAREA>
			           </td>
		         </tr>
		         <tr>
		           	   <th class="content_02_box_div_table_th">流程类型：</th>
			           <td class="content_02_box_div_table_td">
			           		<%=busitypeCodeHtml%>
			           </td>
		         </tr>	
				 <tr>
						<td colspan="2" align="right" style="height: 10px">
						</td>
				</tr>
				</table>
			</div>
		</div>
			<div class="cGridArea" style="margin-top: 290px; ">
				<table id="gridTable"></table>
			</div>
	</div>
<iframe name = "rightHiddenFrame" width = "0" height = "0"></iframe>
</form>
</body>
</html>