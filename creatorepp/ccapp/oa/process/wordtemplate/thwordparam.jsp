<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	String template_id = StringUtil.deNull(request.getParameter("template_id"));
	String kj_id = StringUtil.deNull(request.getParameter("kj_id"));
	String kj_type = StringUtil.deNull(request.getParameter("kj_type"));
	String window_source = StringUtil.deNull(request.getParameter("window_source"));



	
%>	

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>配置word参数</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />

<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="js/wordtemplateutil.js"> </script>
	

<script type="text/javascript">
var obj = getParentWindow('windowId1');
var template_id = "<%=template_id%>";//模版ID
if(template_id == "") {
	template_id = obj.template_id_th;
}
var kj_id = "<%=kj_id%>";//控件ID
var kj_type = "<%=kj_type%>";//控件类型
var kj_name = "";

var window_source = "<%=window_source%>"; //窗体来源 1窗体 2列表
var webOffice = "";
if(window_source == "1") {
    webOffice = obj.document.getElementsByName("WebOffice_WebOffice1")[0];
} 
if(window_source == "2"){
    webOffice = obj.document.getElementsByName("WebOffice_WebOffice1")[0];
}

//初始化
function init() {
    if(kj_id != "") {
        updateKJ();
    }
    isLookElements();
    if(kj_type == "autoText") {
    	$("#titleTd").html("自动文本");
	}
    if(kj_type == "orderlyTable") {
    	$("#titleTd").html("有序表格");
    }
    if(kj_type == "textInput") {
    	$("#titleTd").html("输入框");
    }
    if(kj_type == "dropDown") {
    	$("#titleTd").html("下拉框");
    }
    
}

//显示控制
function isLookElements() {
    if(kj_type != "textInput" && kj_type != "dropDown") {
        $("#help").hide();
        $("#flag").hide();
    }
}

//保存
function kjSave() {
    if(!validate()){
        return;
    }
    doReturnOK();
return;
    var url = "wordtemplatedo.jsp?operationType=dosavewordparam&kj_type="+kj_type;
    document.all.form1.action = url;
    document.all.form1.target = "hiddenFrame";
    document.all.form1.submit();
return;
    //------------------------------------------
    var kjObj = new WordControlVo.WordControl();
    var kjVo = new Object();
    kjVo.KJ_LX = kj_type;
    kjVo.KJ_MC = $("#kj_name").val();
    kjVo.KJ_ID = $("#kj_id").val();
    var kj_lx = $("#kj_lx").val();
    kjVo.KJ_QZ_LX =kj_lx;
    if(kj_lx =="1") {
        kjVo.KJ_QZ = $("#bl_name").val();
    } else {
        kjVo.KJ_QZ = $("#sjj_name").val();
    }
    kjVo.MB_ID = template_id;
    kjVo.KJ_ZT = $("#kj_flag").val(); //状态
    kjVo.KJ_BZ = $("#kj_help").val(); //帮助
    kjVo.KJ_REMARK = $("#kj_remark").val(); //备注
    kjVo.IWEBOFFICE= webOffice ;
    var returnValue = WordControl.addWordControl(kjVo);
    if(returnValue){
        alert("保存数据信息成功");
        kjClose();
    }else{
        alert("保存数据信息失败");
    }
}

//修改控件
function updateKJ() {
    var kj_result = [];
    if(kj_type == "autoText") {
       kj_result = WordControl.selectWordAutoTextControl(kj_id);
    }
    if(kj_type == "orderlyTable") {
       kj_result = WordControl.selectWordOrderlyTextControl(kj_id);
    }
    if(kj_type == "textInput") {
       kj_result = WordControl.selectWordTextInputControl(kj_id);
    }
    if(kj_type == "dropDown") {
       kj_result = WordControl.selectWordDropDownControl(kj_id);
    }
    $("#kj_id").val(kj_result[0][1]);
    $("#kj_name").val(kj_result[0][2]);
    $("#kj_name").attr("readonly","readonly");
    $("#kj_remark").val(kj_result[0][4]);
    $("input[name=kj_lx]").val(kj_result[0][5])
    //setRadioValue("kj_lx", kj_result[0][5]);
    if(kj_result[0][5] == "1") {
        $("#bl_name").val(kj_result[0][3]);
        $("#sjj_name").val("");
    } else {
        $("#sjj_name").val(kj_result[0][3]);
        $("#bl_name").val("");
    }
    if(kj_type == "textInput" || kj_type == "dropDown") {
        $("#kj_help").val(kj_result[0][7]);
        $("#kj_flag").val(kj_result[0][8]);
    }
}

function validate() {
    var kj_mc = $("#kj_name").val();
    var kj_id = $("#kj_id").val();
    var kj_lx = $("input[name=kj_lx]").val();
    var bl_name = $("#bl_name").val();
    var sjj_name = $("#sjj_name").val();
    if(template_id == "" || template_id == "null") {
        alert("模版基本信息未保存，请先保存");
        return false;
    }
    if(kj_mc == "") {
        alert("控件名称不能为空");
        return false;
    }
    /*
    if(kj_id == "") {
        var countNum = WordControl.isUnique(mb_id,kj_mc);
        if(parseInt(countNum) != 0) {
            alert("同一模版中的控件名称相同，请重新输入");
            return false;
        }
    }
    */
    if(kj_lx == "") {
        alert("请选择控件取值");
        return false;
    }  
    if(kj_lx =="1" && bl_name =="") {
        alert("请选择变量");
        return false;
    }
    if(kj_lx =="2" && sjj_name =="") {
        alert("请选择数据集");
        return false;
    }
    if(kj_type == "orderlyTable") {
        var wordSelection = webOffice.WebObject.ActiveWindow.Selection;
        if (!wordSelection.Information(wdWithInTable)) {
            alert("请先在WORD模版中创建表格");
            return false;
        }
    }
    return true;
}

//重置
function kjResert() {
    if(window_source == "2") {
        $("#kj_name").val("");
        $("#kj_id").val("");
    }
    $("#bl_name").val("-1");
    $("#sjj_name").val("-1");
    $("input[name=kj_lx]").first().prop("checked", true);
    
    //document.getElementsByName("kj_lx")[0].checked;
    $("#kj_remark").val("");
    $("#kj_name").val("");
    if(kj_type == "textInput" || kj_type == "dropDown") {
    	$("#kj_help").val("");
    	$("#kj_flag").val("");
    }
}

var listValue  = new Array();//全局参数，在wordtemplatedo.jsp中赋值   
function doReturnOK(){
	
    if(kj_type == "textInput") {
    	kj_name = "ti_" + $("#kj_name").val();
    	var tempValue = $("#temp_value").val().split("#")[1];//wordtemplatedo.jsp中赋值    	
    	var options = {
				statusText : $("#kj_flag").val(),
				helpText : $("#kj_help").val(),
				defaultValue : tempValue
		};
    	createTextInput(webOffice.WebObject,kj_name,options);//创建手工输入文本区域
    }

    var okF=function(){
    	kjClose();
    }
		
	var p={
		headerText:'提示',
		okName:'确认',
		okFunction:okF
	};
	alert("操作成功",p)
	
	
}



//关闭事件
function kjClose() {
	obj.closeAlertWindowFun();
	removeAlertWindows('windowId1',false,true,'',false,'',true);

    //window.returnValue =true;
    //window.close();
}
</script>
</head>
<body onload = init();>
<form name="form1" method="post">
<input type = "hidden" name = "template_id" value = "<%=template_id %>"/>
<input type = "hidden" id="temp_value" name = "temp_value" value = ""/>

<div  id="vcenter" style=" width:362px; overflow-x:hidden;overflow-y:hidden;" >
	<div style=" width: 100%; ">
		 <div  >
		 <div >
				<table  border="0" cellspacing="0" cellpadding="0"  >
				 <TR>
					<TD class=content_02_box_div_table_th height=20 colspan = 4 id = "titleTd"></TD>
				</TR>
				<tr>
		           	   <th class="content_02_box_div_table_th" style="width:20%"><FONT color=red>*</FONT>控件名称：</th>
			           <td class="content_02_box_div_table_td" colSpan=3>
						<input id="kj_name" class="input_185" name = "kj_name" type="text" />
			           </td>
		         </tr>
				 <tr>
		           	   <th class="content_02_box_div_table_th"><FONT color=red>*</FONT>控件取值 <INPUT
				id=kj_id name="kj_id" type="hidden"> <INPUT id=temp_id name = "temp_id"
				name="temp_id" type="hidden"></th>
			           <td class="content_02_box_div_table_td">
			          <INPUT type=radio value=1 name=kj_lx checked>变量
			           </td>
					   <td class="content_02_box_div_table_td">
			          <SELECT id="bl_name" name = "bl_name" style="width: 120px">
						<OPTION value="-1" selected>--请选择--</OPTION>
						<pg:list requestKey="variableSelect">
										<option value='<pg:cell colName="value"/>'>
										<pg:cell colName="name"/>
										</option>
						</pg:list>	
					</SELECT>
			           </td>
		         </tr>	
				  <tr>
		           	   <th class="content_02_box_div_table_th">描述：</th>
			           <td class="content_02_box_div_table_td" colSpan=3>
			          <TEXTAREA id="kj_remark" name  ="kj_remark"
				style="WIDTH: 100%; HEIGHT: 40px" class=cTextarea ></TEXTAREA>
			           </td>
		         </tr>	
				  <tr id=help>
		           	   <th class="content_02_box_div_table_th">帮助：</th>
			           <td class="content_02_box_div_table_td" colSpan=3>
			           <TEXTAREA id="kj_help" name = "kj_help" 
				style="WIDTH: 100%; HEIGHT: 40px" class=cTextarea ></TEXTAREA>
			           </td>
		         </tr>	
				  <tr id=help>
		           	   <th class="content_02_box_div_table_th">状态：</th>
			           <td class="content_02_box_div_table_td" colSpan=3>
			           <TEXTAREA id="kj_flag" name = "kj_flag"
				style="WIDTH: 100%; HEIGHT: 40px" class=cTextarea ></TEXTAREA>
			           </td>
		         </tr>	
				 <tr>
						<td colspan=4 align="center">
						<input class=but_y_01 type="button" id=btnSave onclick="kjSave()" value="保存">
						<input class=but_y_01 type="button" id=btnSave onclick="kjResert()" value="重置">
						</td>
					</tr>
				</table>
			</div>
			</div>

	</div>
</div>
<iframe name = "hiddenFrame" width = "100%" height= "0"></iframe>
</form>
</body>
</html>