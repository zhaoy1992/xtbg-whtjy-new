<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.WordArchiveService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean"%>
<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String user_name =accesscontroler.getUserName();
	String user_id=accesscontroler.getUserID();
	String busi_id = request.getParameter("busi_id");
	String number_type_id = request.getParameter("number_type");
	String number_type = DataControlUtil.pageUnEscape(StringUtil.deNull(request.getParameter("number_type")));
	String number_year = StringUtil.deNull(request.getParameter("number_year"));
	String number_code = "";
	String optType = "papersave";
	
	String sql = "select i.busitype_code, i.busitype_name from OA_FLOW_BUSITYPE i where i.is_valid = 'Y' ";
	String str = DictDropDownList.buildSelect(sql,"busitype_code","","",true,"");
	
	 //下拉框  选中的id由bean存的值确定
	
    //String number_type_html = DictDropDownList.buildSelect4DictType("gwbhlx","number_type" ,  StringUtil.deNull(number_type_id), "" , true, "" ,"" ,"class='validate[required] select_240'","" );
   
    //下拉框  选中的id由bean存的值确定
	
    //String number_year_html = DictDropDownList.buildSelect4DictType("nianfen","number_year" ,  StringUtil.deNull(number_year), "" , true, "" ,"" ,"class='validate[required] select_240'","" );
	//获取编号规则
	String[] serialnumberchar = StringUtil.getPropertiesChar("serialnumberchar",",");
	if(serialnumberchar==null || serialnumberchar.length!= 2){
		serialnumberchar[0] = "〔";
		serialnumberchar[1] = "〕";
	}
    
%>
<title>公文编号页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入其它 -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<!-- 引入formvValidatetion -->
<script src="../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript"></script>

<script type="text/javascript">

jQuery(function() {
	jQuery("#title").focus();
});

/*
作者:  shuqi.liu
时间:  2013-8-28
函数:  saveMsgConfig
说明:  保存短信配置
参数:   无
返回值: 无
*/
function saveNumber(){
	if(jQuery("#form1").validationEngine("validateform")){
		var number_type = jQuery("#number_type").val();
		var number_year = jQuery("#number_year").val();
		var number_code = jQuery("#number_code").val();
		var busitype_code = jQuery("#busitype_code").val();
		var title = jQuery("#title").val();
		var busi_id = jQuery("#busi_id").val();
		
		var jsonparam = "{'number_type':'"+number_type
						+"','number_year':'"+number_year
	  				    +"','number_code':'"+number_code
	  				    +"','archive_type':'"+busitype_code
	  				    +"','archive_title':'"+title
	  				    +"','is_paper':'1'"
	  				    +",'archive_user':'<%=user_name%>"
	  				  	+"','archive_userid':'<%=user_id%>"
	   				    +"','busi_id':'"+busi_id+"'}";
	   	jQuery("#jsonparam").val(descape(escape(jsonparam)));
		var fm = document.getElementById("form1");
		fm.action = "serialnumberdo.jsp";
		fm.target = "hiddenFrame";
		jQuery('#form1').submit();
		
	}
}
//根据编号类型，编号年度 获取最大的编号
function getMaxNum(){
	var number_type = jQuery("#number_type").val();
	var number_year = jQuery("#number_year").val();
	var optType = "getMax";
	var busi_id = jQuery("#busi_id").val();
	var url="serialnumberdo.jsp";
	var params = {'number_type':number_type,'number_year':number_year,'busi_id':busi_id,'optType':optType};
	jQuery.ajax({
		url: url,
		type: 'POST',
		dataType:'json',
		data: params,
		async:false,
		success: function(data){
				jQuery("#number_code").val(data.result);
		},
		error: function(jqXHR, textStatus, errorThrown){
		
		}
	})
}

//赋值公文编号
function setNumber(){
	var number_type = jQuery("#number_type").find("option:selected").attr("title");
	var number_year = jQuery("#number_year").find("option:selected").attr("title");
	var number_code	= jQuery("#number_code").val();
	//TODO 此处需要配置编号
	var txtValue = number_type+"<%=serialnumberchar[0]%>"+number_year+"<%=serialnumberchar[0]%>"+number_code+"号";
	getParentWindow("windowIds").setSelectionValue(txtValue);
	removeAlertWindows('windowIds',true);
}

function afterSubmitFn(flag){
	var submitAlertOK = function(){
		getParentWindow('').refreshGrid();
		removeAlertWindows('',true);
	}
	var p={
			headerText:'操作信息',
			okName:'确认',
	        okFunction:submitAlertOK
	};
	var mes = "";
	if(flag=='true'){
		mes = "编号成功"; 
		alert(mes,p);
	}else if(flag=="isReadNumber"){
		mes = "编号已被占用";
		alert(mes);
	} else{
		mes = "编号失败"	;
		alert(mes);
	}
}
</script>

</head>
<body>
<button id=button4 class="but_y_01" onclick="saveNumber()">保存</button>
<button id=button8 class="but_y_01" onclick="removeAlertWindows('',true)">关闭</button>
<form id="form1" action="" method="post">
<input id="busi_id" name="busi_id" type="hidden" value ="<%=busi_id %>"/>
<input id="jsonparam" name="jsonparam" type="hidden" />
<input id="optType" name="optType" type="hidden" value="<%=optType %>"/>
<!-- 表格    -->
<div id="vcenter" style="float: left; width: 100%;"  >
	<div style="float: left; width: 775px;">
		<div class="content_02_box">
			<div class="content_02_box_div">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="content_02_box_div_table_02">
					<tr>
						<th class="content_02_box_div_table_th">文件标题：</th>
						<td  class="content_02_box_div_table_td" style="text-align: center;">
			           	 <input type="text" class="validate[required,maxSize[80]] input_title_text"  name="title" id="title"/>
			            </td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">文件类型：</th>
			            <td class="content_02_box_div_table_td" style="width: 290px">
							<%=str%>
						<script type="text/javascript">
							jQuery("#busitype_code").addClass("validate[required]")
						</script>
					    </td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">编号类型：</th>
			           <td class="content_02_box_div_table_td" style="width: 290px">
			           		<input type="text" class="input_title_text" name="number_type" readonly="readonly" id="number_type"  value="<%=number_type %>"/>
					    </td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">编号年度：</th>
			            <td  class="content_02_box_div_table_td" style="width: 290px">
			            	<input type="text" class="input_title_text" name="number_year" readonly="readonly" id="number_year" value="<%=number_year %>"/>
			            </td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">编号号码：</th>
			            <td  class="content_02_box_div_table_td" style="text-align: center;">
			            <input type="text" class="validate[required,maxSize[20]] input_cx_title_240" onclick="getMaxNum()" name="number_code" id="number_code" value ="<%=number_code %>" />
			            </td>
				   </tr>
				</table>
			</div>
		</div>
	</div>
</div>
</form>
<iframe name="hiddenFrame" width=0 height=0 ></iframe>
</body>
</html>