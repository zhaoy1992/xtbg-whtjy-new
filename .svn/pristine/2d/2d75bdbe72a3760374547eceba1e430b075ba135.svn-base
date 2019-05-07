<%--
　　描述：配置右边页面
　　作者：黄艺平
　　版本：1.0
　　日期：2013-08-1
--%>
<%@page import="com.chinacreator.xtbg.core.form.entity.OaMdTableBean"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.form.service.impl.FormserviceImpl"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	String userName = control.getUserName();
	String userId = control.getUserID(); 
	String path = request.getContextPath();

	String template_id = request.getParameter("template_id");
	String orgId = request.getParameter("org_id");
	String msg = "";
	WordTemplateBean wordTemplateBean = new WordTemplateBean();
	try{
		WordTemplateServiceIfc wordTemplate = new  WordTemplateServiceImpl();
		wordTemplateBean = wordTemplate.getWordTemplateInfoByMbId(template_id);
	}catch(Exception e){
		e.printStackTrace();
		msg = "error";
	}
	FormserviceImpl FormserviceImpl = new FormserviceImpl();
	List<OaMdTableBean> oaMdTableBeanlist = FormserviceImpl.getTableList();//获取表LIST
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
	jQuery("#table_code").val("<%=StringUtil.deNull(wordTemplateBean.getTable_code())%>");
});

var mb_id = $("#template_id").val();

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
    jQuery("#table_id").val(jQuery("#table_code option:selected").attr("code"));
    parent.frames["mainFrame"].$("#WebOffice1").hide();
    var url = "wordtemplatedo.jsp?operationType=dosavewordtemplate";
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
function doReturnOK(operationType,id){
	var okF=function(){
		if("saveWordtemplate"==operationType){
			jQuery("#template_id").val(id);
			search();
			//window.location.reload();
		}else{
			var windowId = 'windowId1';
			removeAlertWindowByWindowID(windowId);
			
		}
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

}

$(function() {
	$("#gridTable").jqGrid({
		url: path + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.common.iweboffice.list.WordTextInputList',  
		datatype: "json",
		mtype: "POST",	
		height: "100%",//270
		autowidth: true,
		shrinkToFit:true,
		colModel: [ 
        {
        	label:"输入文本ID",
			name: 'ruleitem_id',
			index: 'ruleitem_id',
			hidden: true
		},
		{
        	label:"模板ID",
			name: 'template_id',
			index: 'template_id',
			hidden: true
		},
		{
			label:"名称",
			name: 'ruleitem_name',
			index: 'ruleitem_name',
			width: '50%',
			editable: true
		},
		{
			label:"列名",
			name: 'column_name',
			index: 'column_name',
			width: '30%',
			editable: true
		},
		{
			label:"表格位置",
			name: 'table_cell',
			index: 'table_cell',
			width: '20%',
		},
		{
			label:"类型",
			name: 'ruleitem_value_typename',
			index: 'ruleitem_value_typename',
			width: '15%',
		},
		{
			label:"操作",
			name: 'oper',
			index: 'oper',
			width: '19%',
			editable: true,
			formatter : function(value,column,model){
				return "<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02');"
				+" onMouseOut=javascript:$(this).attr('class','but_y_01'); id=delete type='button' onclick='deleteParm(\""+model.ruleitem_id+"\",\""+model.ruleitem_name+"\")' value='删除'/>";
        	}
		}
		
		],
		sortname: 'ruleitem_id',
		sortorder: '',
		viewrecords: true,
		isPage:true,
		jsonReader: { 
			repeatitems: false
		},
		search : toUserParamJosn(),
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 6,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [6, 12, 24],
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		filterOptionsDefValue:[0],
		prmNames: {
			rows: "rows",
			sort: "sidx",
			order: "sord",
			search : "search"
		},
		//multiselect: true,
		ondblClickRow:function(id,iCol){
			if(iCol != 0 )
			{
				updateWordTextInput(id);
			}
		},
		onCellSelect:function(id,iCol){
			if(iCol != 0 )
			{
				selectWordTextInput(id);
			}
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh:false
	});
	$("#t_gridTable").append("<div>").append("</div>");
});

	 
/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
*/

var toUserParamJosn = function() {
	var str = "{'template_id':'"+$('#template_id').val()+"'}";
	return descape(escape(str));
}

/*
	函数:  search
	说明:  查询
	参数:   无
	返回值: 
*/
var search = function() {
   var sdata = { //构建查询需要的参数 
       paramJson : toUserParamJosn()
   }; //获得当前postData选项的值  
   var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
   $.extend(postData, sdata);
   $("#gridTable").jqGrid("setGridParam", {
       search : true
   // 将jqGrid的search选项设为true  
   }).trigger("reloadGrid", [ {
       page : 1
   } ]); //重新载入Grid表格，以使上述设置生效 
}

/*
	函数:  updateWordTextInput
	说明:  修改文本框
	参数:   无
	返回值: 
*/
function updateWordTextInput(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var url = "<%=path %>/ccapp/oa/process/wordtemplate/wordparam.jsp?template_id="+model.template_id+"&kj_type=textInput&window_source=1&windowsId=windowId1&kj_id="+model.ruleitem_id;
	//parent.frames["mainFrame"].$("#WebOffice1").hide();
	openAlertWindows('windowId1',url,'选择输入框','30%','60%','10%','68%',closeAlertWindowFun,'',true);
}

/*
函数：textInputWindow
描述：添加表格属性
参数：
返回值：
*/
function textInputWindow() {
	var template_id = $('#template_id').val();	
	//parent.frames["mainFrame"].$("#WebOffice1").hide();
	var url = '<%=path %>/ccapp/oa/process/wordtemplate/wordparam.jsp?template_id='+template_id+'&kj_type=textInput&window_source=1&windowsId=windowId1&defalutTable='+defalutTable;
	openAlertWindows('windowId1',url,'选择输入框','30%','60%','10%','68%',closeAlertWindowFun,'',true);
}
/*
函数：textInputWindow
描述：复制
参数：
返回值：
*/
function textInputCopyWindow() {
	var template_id = $('#template_id').val();
	if(template_id){
		var url = '<%=path %>/ccapp/oa/process/wordtemplate/wordtemplateforcopylist.jsp?template_id='+template_id+'&window_source=1&windowsId=windowId1';
		//parent.frames["mainFrame"].$("#WebOffice1").hide();
		openAlertWindows('windowId1',url,'选择复制信息','810px','484px','15%','15%',closeAlertWindowFun,'',true);
	}else{
		alert("模版基本信息未保存，请先保存");
	}
}
//selectWordTextInput 选定行的时候定位到单元格
function selectWordTextInput(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var tabelCell = model.table_cell;
	var tbaleDef = tabelCell.split(",");
	if(tbaleDef.length == 3){
		var iWebOffice = parent.frames["mainFrame"].document.getElementsByName("WebOffice")[0];
		if(iWebOffice.WebObject.Tables.Count>=tbaleDef[0]){//如果WORD里的表格数大于定义的表格数。
				var tables = iWebOffice.WebObject.Tables.Item(tbaleDef[0]);
				if(tables.Columns.Count>=tbaleDef[2]  && tables.Rows.Count >= tbaleDef[1]){//如果行列存在
					var cell = tables.Cell(tbaleDef[1],tbaleDef[2]);
					var selection = tables.Application.selection;//获取光标单元格
					if(cell){
						cell.Select();
						//selection.Text = selection.Text+"测试";
					}
				}
		}
	}
}

//关闭
function closeAlertWindowFun(){
	//parent.frames["mainFrame"].$("#WebOffice1").show();
}

/*
	函数:  deleteParm
	说明:  删除参数
	参数:   无
	返回值: 
*/
function deleteParm(textinput_id, ruleitem_name) {
	jQuery.ajax({
	      type: "post", 
	      url:  path+"/ajaxServlet?className=com.chinacreator.xtbg.core.common.iweboffice.action.TextInputAction&method=delTextInput",
	      contentType: "application/x-www-form-urlencoded; charset=utf-8",
	      data : {
	          textinput_id : textinput_id    
	      },
	      dataType: "json", 
	      success: function (data) {
	    	parent.frames["mainFrame"].$("#WebOffice1").hide();
	    	var okF=function(){
	    		if(data.flag) {
	    			var webOffice = parent.frames["mainFrame"].document.getElementsByName("WebOffice")[0];
		    		deleteTextInput(webOffice.WebObject, ruleitem_name);
		    		parent.frames["mainFrame"].saveTemplet(true);
			    }
	    		parent.frames["mainFrame"].$("#WebOffice1").show();
	        }
		    var p={
		    		headerText:'提示',
		    		okName:'确认',
		    		okFunction:okF
		    };
		    alert(data.msg,p);
		    search();
	      }, 
	      error: function (XMLHttpRequest, textStatus, errorThrown) { 
	          alert("出现异常，请稍后再试！");
	      } 
	});
}

/**
 *设置默认的表
 */
function setDefalutTable(defalutTable1){
	defalutTable = defalutTable1;
}
</script>	
	
	
</head>
<body  style="overflow-y:hidden;">
<form action="" id="rightform" name="rightform" method="post">
<input type = "hidden" name = "template_userid" value = "<%=userId %>">
<input type = "hidden" name = "template_username" value = "<%=userName %>">
<input type = "hidden" name = "table_id" id="table_id" value = "">
<input type = "hidden" name = "org_id" value = "<%=orgId %>">
<INPUT id="template_id" name="template_id" type="hidden" value = "<%=StringUtil.deNull(wordTemplateBean.getTemplate_id()) %>">
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
		           	   <th class="content_02_box_div_table_th">模版内容配置：（#段落,*表格）</th>
			           <td class="content_02_box_div_table_td">
			          <INPUT id="singn_config" class=" input_185" name = "singn_config" type="text" value = "<%=StringUtil.deNull(wordTemplateBean.getSingn_config()) %>">
			           </td>
		         </tr>
		          <tr>
		           	   <th class="content_02_box_div_table_th"><FONT color="red">*</FONT>选择表：</th>
			           <td class="content_02_box_div_table_td">
				          
				          <select id="table_code" name="table_code" style="width:210px;" onchange="">
							<option value="">请选择</option>
							<%for(int i=0; i<oaMdTableBeanlist.size(); i++){
								%>
								<option value="<%= oaMdTableBeanlist.get(i).getTable_code() %>"  code="<%= oaMdTableBeanlist.get(i).getTable_id() %>"  
								  title="<%= oaMdTableBeanlist.get(i).getTable_code()+"["+oaMdTableBeanlist.get(i).getTable_name()+"]" %>"
								  >
								  <%= oaMdTableBeanlist.get(i).getTable_code()+"["+oaMdTableBeanlist.get(i).getTable_name()+"]" %>
								</option>
							<% } %>
							
						 </select>
			           </td>
		         </tr>	
				  <tr>
		           	   <th class="content_02_box_div_table_th">模版序号：</th>
			           <td class="content_02_box_div_table_td">
			          <INPUT id="template_sn" class="validate[custom[onlyNumberSp],maxSize[5]] input_185" name = "template_sn" type="text" value = "<%=StringUtil.deNull(wordTemplateBean.getTemplate_sn()) %>">
			           </td>
		         </tr>	
				  <tr>
		           	   <th class="content_02_box_div_table_th">描述：</th>
			           <td class="content_02_box_div_table_td">
			           <TEXTAREA id="template_remark" class="cTextarea" name = "template_remark"
							style="62px; HEIGHT: 40px"><%=StringUtil.deNull(wordTemplateBean.getTemplate_remark()) %></TEXTAREA>
			           </td>
		         </tr>	
				 <tr>
						<td colspan="2" align="right" style="height: 10px">
						</td>
				</tr>
				 <tr>
						<td colspan="2" align="right">
						<input class="but_y_01" type="button" id="btnSave" onclick="textInputWindow()" value="添加">
						<input class="but_y_01" type="button" id="btnCopy" onclick="textInputCopyWindow()" value="复制">
						</td>
				</tr>
				</table>
			</div>
		</div>
			<div class="cGridArea" style="margin-top: 320px; ">
				<table id="gridTable"></table>
			</div>
	</div>
<iframe name = "rightHiddenFrame" width = "0" height = "0"></iframe>
</form>
</body>
</html>