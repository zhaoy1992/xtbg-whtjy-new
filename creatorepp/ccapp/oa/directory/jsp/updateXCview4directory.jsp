<%--
描述：更新用户薪酬信息
作者：童佳
日期：2014-03-25
 --%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.directory.entity.DirectoryBean"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.impl.DirectoryServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.DirectoryServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title>更新用户薪酬信息</title>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String typeid = request.getParameter("typeid");	
	DirectoryServiceIfc directoryServiceIfc = new DirectoryServiceImpl();
	String numberOne = "否";
	DirectoryBean directoryBean = new DirectoryBean();
	if (!StringUtil.isBlank(typeid)) {
		directoryBean = directoryServiceIfc
		.getTypeBeanById(typeid,"view");
		if("是".equals(directoryBean.getNumberone())){
			numberOne ="是";
		}
		
	}
	
	String Sitting = directoryBean.getDirectorystate();
	if("jobing".equals(Sitting))
	{
		Sitting = "在职";
	}
	else if("departure".equals(Sitting))
	{
		Sitting = "离职";
	}
	else if("retirement".equals(Sitting))
	{
		Sitting = "退休";
	}else{
		Sitting = "";
	}
%>
<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->

<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>


<script type="text/javascript">
$(function() {
	
});

/**
 * 更新
 */
function updatesubmit(){
	var isFlag = $('#form1').validationEngine('validate'); //是否全部验证通过
	
	//特检院 OA 追加薪酬信息  2012-02-25 start  
	//岗位工资
	isFlag = myValidateNums('new_xc_gwgz');
	//薪级工资
	isFlag = myValidateNums('new_xc_xjgz');
	//医保
	isFlag = myValidateNums('new_xc_yb');
	//养老保险
	isFlag = myValidateNums('new_xc_ylbx');
	//失业保险
	isFlag = myValidateNums('new_xc_sybx');
	//公积金
	isFlag = myValidateNums('new_xc_gjj');
	//补扣
	isFlag = myValidateNums('new_xc_cb');
	//特检院 OA 追加薪酬信息  2012-02-25 end  
	if(isFlag){
		$("#form1").submit();
	}else{
		$("body").scrollTop(0);
		return;
	}
	
}

/**
 * 关闭弹出窗
 */
function closed(){
	removeAlertWindows('',true);
}

//特检院 OA 追加薪酬信息  2012-02-25 start  
/**
 * 岗位应发合计函数
 */
function yfcount(valName){
	var isFlag = myValidateNums(valName);
	if(isFlag){
		$("#new_xc_yfgz").val("");
		//岗位工资
		var new_xc_gwgz = $("#new_xc_gwgz").val();
		//薪级工资
		var new_xc_xjgz = $("#new_xc_xjgz").val();
		if(IsSpace(new_xc_gwgz)==true){
			new_xc_gwgz="0";
		}
		if(IsSpace(new_xc_xjgz)==true){
			new_xc_xjgz="0";
		}
		//计算应发
		var new_xc_yfgz = parseFloat(new_xc_gwgz)+ parseFloat(new_xc_xjgz);
		$("#new_xc_yfgz").val(new_xc_yfgz.toFixed(2));
		
	}else{
		return;
	}
}

/**
 * 扣款合计函数
 */
function ckcount(valName){
	var isFlag = myValidateNums(valName);
	if(isFlag){
		$("#new_xc_cbhj").val("");
		//医保
		var new_xc_yb = $("#new_xc_yb").val();
		//养老保险
		var new_xc_ylbx = $("#new_xc_ylbx").val();
		//失业保险
		var new_xc_sybx = $("#new_xc_sybx").val();
		//公积金
		var new_xc_gjj = $("#new_xc_gjj").val();
		//扣补
		var new_xc_cb = $("#new_xc_cb").val();
		if(IsSpace(new_xc_yb)==true){
			new_xc_yb ="0";
		}
		if(IsSpace(new_xc_ylbx)==true){
			new_xc_ylbx ="0";
		}
		if(IsSpace(new_xc_sybx)==true){
			new_xc_sybx ="0";
		}
		if(IsSpace(new_xc_gjj)==true){
			new_xc_gjj ="0";
		}
		if(IsSpace(new_xc_cb)==true){
			new_xc_cb ="0";
		}
		
		var new_xc_cbhj = parseFloat(new_xc_yb)+ parseFloat(new_xc_ylbx)+
				parseFloat(new_xc_sybx)+ parseFloat(new_xc_gjj)+ parseFloat(new_xc_cb);
		$("#new_xc_cbhj").val(new_xc_cbhj.toFixed(2));
			
		//实发金额
		if(IsSpace($("#new_xc_yfgz").val())==false){
			//实发金额
			$("#new_xc_sfhj").val("");
			//扣补
			var new_xc_cbhj = $("#new_xc_cbhj").val();
			//应发
			var new_xc_yfgz = $("#new_xc_yfgz").val();
			var new_xc_sfhj = parseFloat(new_xc_yfgz)- parseFloat(new_xc_cbhj)
			$("#new_xc_sfhj").val(new_xc_sfhj.toFixed(2));
		}
	}else{
		return;
	}
}

/**
 * 实发合计 计算
 */
function sfcount(){
	
	if(IsSpace($("#new_xc_yfgz").val())==false&&IsSpace($("#new_xc_cbhj").val())==false){
		//实发金额
		$("#new_xc_sfhj").val("");
		//扣补
		var new_xc_cbhj = $("#new_xc_cbhj").val();
		//应发
		var new_xc_yfgz = $("#new_xc_yfgz").val();
		var new_xc_sfhj = parseFloat(new_xc_yfgz)- parseFloat(new_xc_cbhj)
		$("#new_xc_sfhj").val(new_xc_sfhj.toFixed(2));
	}
}

/**
 * 验证是否填写数字
 */
function myValidateNums(valName){
	var pattern = "^(([0-9]+)([\.,]([0-9]+))?|([\.,]([0-9]+))?)*$"; //只能是数字
	var value = document.getElementById(valName).value; //排序号值
	if(value.search(pattern)!=0 ){
			alert("只能是数字");
			document.getElementById(valName).focus();
			return false;
		}   
	if (document.getElementById(valName).value != ""
			&& document.getElementById(valName).value < 0) {
		alert("必须大于0！");
		document.getElementById(valName).focus();
		return false;
	}
	return true;
}
//特检院 OA 追加薪酬信息  2012-02-25 end

</script>
</head>
<body style="overflow-x:auto;" class="vcenter">
	<form id="form1" action="updateUserXCInfo.jsp" method="post"
		class="formular">
		<input type="hidden" name="userid" id="userid" value="<%=StringUtil.deNull(typeid)%>" />
		
		<div >
			<table class="content_02_box_div_table">
				<tr>
					<td class="content_02_box_title_bg">基本资料</td>
				</tr>
			</table>
			<div>
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th"> 姓名：</th>
					<td class="content_02_box_div_table_td">
					    <input id="userRealname" name="userRealname" class="validate[maxSize[30]] input_185" value="<%=StringUtil.deNull(directoryBean.getDirectoryname())%>"/>&nbsp;
					</td>
					<th class="content_02_box_div_table_th">工作部门：</th>
					<td class="content_02_box_div_table_td">
					   <input  name="org_name" id="org_name" style="width:178px" class="input_185" value="<%=StringUtil.deNull(directoryBean.getDepartment())%>"/> &nbsp; 
					</td>
				</tr>
			</table>
			</div>
			
			<table class="content_02_box_div_table">
				<tr>
					<td class="content_02_box_title_bg">薪酬信息</td>
				</tr>
			</table>
			<div>
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th">岗位工资：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;">
                        <input id="new_xc_gwgz" name="new_xc_gwgz" style="width:175px" onblur="yfcount('new_xc_gwgz');" class="input_185" value="<%=StringUtil.deNull(directoryBean.getNew_xc_gwgz())%>" />&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">薪级工资：</th>
					<td class="content_02_box_div_table_td">
						<input id="new_xc_xjgz" name="new_xc_xjgz" style="width:175px" onblur="yfcount('new_xc_xjgz');" class="input_185" value="<%=StringUtil.deNull(directoryBean.getNew_xc_xjgz())%>" />&nbsp;
                    </td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">应发合计：</th>
					<td class="content_02_box_div_table_td">
						<input id="new_xc_yfgz" name="new_xc_yfgz" style="width:175px" class="validate[maxSize[30],custom[number]] input_185" value="<%=StringUtil.deNull(directoryBean.getNew_xc_yfgz())%>" readonly="readonly" />&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">医保：</th>
					<td class="content_02_box_div_table_td">
						<input id="new_xc_yb" name="new_xc_yb" style="width:175px" onblur="ckcount('new_xc_yb');" class="validate[maxSize[30],custom[number]] input_185" value="<%=StringUtil.deNull(directoryBean.getNew_xc_yb())%>" />&nbsp;
                    </td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">养老保险：</th>
					<td class="content_02_box_div_table_td">
						<input id="new_xc_ylbx" name="new_xc_ylbx" style="width:175px" onblur="ckcount('new_xc_ylbx');" class="validate[maxSize[30],custom[number]] input_185" value="<%=StringUtil.deNull(directoryBean.getNew_xc_ylbx())%>" />&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">失业保险：</th>
					<td class="content_02_box_div_table_td">
						<input id="new_xc_sybx" name="new_xc_sybx" style="width:175px" onblur="ckcount('new_xc_sybx');" class="validate[maxSize[30],custom[number]] input_185" value="<%=StringUtil.deNull(directoryBean.getNew_xc_sybx())%>" />&nbsp;
                    </td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">公积金：</th>
					<td class="content_02_box_div_table_td">
						<input id="new_xc_gjj" name="new_xc_gjj" style="width:175px" onblur="ckcount('new_xc_gjj');" class="validate[maxSize[30],custom[number]] input_185"  value="<%=StringUtil.deNull(directoryBean.getNew_xc_gjj())%>" />&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">补扣：</th>
					<td class="content_02_box_div_table_td">
						<input id="new_xc_cb" name="new_xc_cb" style="width:175px" onblur="ckcount('new_xc_cb');" class="validate[maxSize[30],custom[number]] input_185" value="<%=StringUtil.deNull(directoryBean.getNew_xc_cb())%>"/>&nbsp;
                    </td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">扣款合计：</th>
					<td class="content_02_box_div_table_td">
						<input id="new_xc_cbhj" name="new_xc_cbhj" readonly="readonly" style="width:175px" class="validate[maxSize[30],custom[number]] input_185" value="<%=StringUtil.deNull(directoryBean.getNew_xc_cbhj())%>"/>&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">实发合计：</th>
					<td class="content_02_box_div_table_td">
						<input id="new_xc_sfhj" name="new_xc_sfhj" onfocus="sfcount();" readonly="readonly" style="width:175px" class="validate[maxSize[30],custom[number]] input_185" value="<%=StringUtil.deNull(directoryBean.getNew_xc_sfhj())%>" />&nbsp;
                    </td>
				</tr>

			</table>
			</div>
		
			<table class="cue_box_foot">
				<tr>
					<td>
					   <input class="but_h_01" type="button" id="resert" value="保存" onclick="updatesubmit()" />
					</td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>