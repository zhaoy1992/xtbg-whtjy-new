
<%@page import="com.chinacreator.xtbg.core.directory.entity.HeTongBean"%>
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

<title>JGRID</title>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String typeid = request.getParameter("typeid");	
	
	String strRoles = request.getParameter("strRoles");
	
	DirectoryServiceIfc directoryServiceIfc = new DirectoryServiceImpl();
	String numberOne = "否";
	DirectoryBean directoryBean = new DirectoryBean();
	HeTongBean heTongBean = new HeTongBean();
	if (!StringUtil.isBlank(typeid)) {
		directoryBean = directoryServiceIfc
		.getTypeBeanById(typeid,"view");
		if("是".equals(directoryBean.getNumberone())){
			numberOne ="是";
		}
		
		heTongBean = directoryServiceIfc.getHeTongBeanById(typeid);
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
	
	if("bnzg"=="<%=StringUtil.deNull(directoryBean.getNew_user_type())%>"){
		$("#zgzt").show();
	}else{
		$("#zgzt").hide();  //隐藏在岗状态
	}
	jQuery("#userIdcard").focus();
	
	if("男"=="<%=StringUtil.deNull(directoryBean.getDirectorysex())%>"){
		$("#userSex").html("<option value='M'>男</option><option value='F'>女</option><option value=''>未知</option>");
	}else if("女"=="<%=StringUtil.deNull(directoryBean.getDirectorysex())%>"){
		$("#userSex").html("<option value='F'>女</option><option value='M'>男</option><option value=''>未知</option>");
	}else{
		$("#userSex").html("<option value='M'>男</option><option value='F'>女</option><option value=''>未知</option>");
	}
	
	$("#politics").val("<%=StringUtil.deNull(directoryBean.getPolitics())%>");
	
	$("#directorylevel").val("<%=StringUtil.deNull(directoryBean.getDirectorylevel())%>");
	
	
	if("研究生"=="<%=StringUtil.deNull(directoryBean.getEducation())%>"){
		$("#education").val("phd");
	}else if("本科"=="<%=StringUtil.deNull(directoryBean.getEducation())%>"){
		$("#education").val("undergraduate");
	}else if("专科"=="<%=StringUtil.deNull(directoryBean.getEducation())%>"){
		$("#education").val("specialist");
	}else if("高中"=="<%=StringUtil.deNull(directoryBean.getEducation())%>"){
		$("#education").val("highschool");
	}else if("中专"=="<%=StringUtil.deNull(directoryBean.getEducation())%>"){
		$("#education").val("secondary");
	}else if("初中"=="<%=StringUtil.deNull(directoryBean.getEducation())%>"){
		$("#education").val("juniorhighschool");
	}else if("小学"=="<%=StringUtil.deNull(directoryBean.getEducation())%>"){
		$("#education").val("primaryschool");
	}else if("其他"=="<%=StringUtil.deNull(directoryBean.getEducation())%>"){
		$("#education").val("other");
	}else{
		$("#education").val("");
	}
	
	if("1"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("1");
	}else if("2"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("2");
	}else if("3"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("3");
	}else if("4"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("4");
	}else if("5"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("5");
	}else if("6"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("6");
	}else if("7"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("7");
	}else if("8"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("8");
	}else if("9"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("9");
	}else if("10"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("10");
	}else if("11"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("11");
	}else if("12"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("12");
	}else if("13"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("13");
	}else if("14"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("14");
	}else if("15"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("15");
	}else if("16"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("16");
	}else if("17"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("17");
	}else if("18"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("18");
	}else if("19"=="<%=StringUtil.deNull(directoryBean.getPost())%>"){
		$("#duties").val("19");
	}else{
		$("#duties").val("");
	}
	
	if("bnzg"=="<%=StringUtil.deNull(directoryBean.getNew_user_type())%>"){
		$("#new_user_type").val("bnzg");
	}else if("bwzg"=="<%=StringUtil.deNull(directoryBean.getNew_user_type())%>"){
		$("#new_user_type").val("bwzg");
	}else if("txzg"=="<%=StringUtil.deNull(directoryBean.getNew_user_type())%>"){
		$("#new_user_type").val("txzg");
	}else{
		$("#new_user_type").val("");
	}
	
	if("glgw"=="<%=StringUtil.deNull(directoryBean.getNew_job_set())%>"){
		$("#new_job_set").val("glgw");
	}else if("zjgw"=="<%=StringUtil.deNull(directoryBean.getNew_job_set())%>"){
		$("#new_job_set").val("zjgw");
	}else if("gqgw"=="<%=StringUtil.deNull(directoryBean.getNew_job_set())%>"){
		$("#new_job_set").val("gqgw");
	}else{
		$("#new_job_set").val("");
	}
	
	if("bs"=="<%=StringUtil.deNull(directoryBean.getDegree())%>"){
		$("#degree").val("bs");
	}else if("ss"=="<%=StringUtil.deNull(directoryBean.getDegree())%>"){
		$("#degree").val("ss");
	}else if("xs"=="<%=StringUtil.deNull(directoryBean.getDegree())%>"){
		$("#degree").val("xs");
	}else{
		$("#degree").val("");
	}
	
	if("bs"=="<%=StringUtil.deNull(directoryBean.getNew_zg_xw())%>"){
		$("#new_zg_xw").val("bs");
	}else if("ss"=="<%=StringUtil.deNull(directoryBean.getNew_zg_xw())%>"){
		$("#new_zg_xw").val("ss");
	}else if("xs"=="<%=StringUtil.deNull(directoryBean.getNew_zg_xw())%>"){
		$("#new_zg_xw").val("xs");
	}else{
		$("#new_zg_xw").val("");
	}
	
	if("phd"=="<%=StringUtil.deNull(directoryBean.getNew_zg_xl())%>"){
		$("#new_zg_xl").val("phd");
	}else if("undergraduate"=="<%=StringUtil.deNull(directoryBean.getNew_zg_xl())%>"){
		$("#new_zg_xl").val("undergraduate");
	}else if("specialist"=="<%=StringUtil.deNull(directoryBean.getNew_zg_xl())%>"){
		$("#new_zg_xl").val("specialist");
	}else if("highschool"=="<%=StringUtil.deNull(directoryBean.getNew_zg_xl())%>"){
		$("#new_zg_xl").val("highschool");
	}else if("secondary"=="<%=StringUtil.deNull(directoryBean.getNew_zg_xl())%>"){
		$("#new_zg_xl").val("secondary");
	}else if("juniorhighschool"=="<%=StringUtil.deNull(directoryBean.getNew_zg_xl())%>"){
		$("#new_zg_xl").val("juniorhighschool");
	}else if("primaryschool"=="<%=StringUtil.deNull(directoryBean.getNew_zg_xl())%>"){
		$("#new_zg_xl").val("primaryschool");
	}else if("other"=="<%=StringUtil.deNull(directoryBean.getNew_zg_xl())%>"){
		$("#new_zg_xl").val("other");
	}else{
		$("#new_zg_xl").val("");
	}
	//专业级别（最高学历）
	if("1"=="<%=StringUtil.deNull(directoryBean.getNew_jb_zy())%>"){
		$("#new_jb_zy").val("1");
	}else if("2"=="<%=StringUtil.deNull(directoryBean.getNew_jb_zy())%>"){
		$("#new_jb_zy").val("2");
	}else if("3"=="<%=StringUtil.deNull(directoryBean.getNew_jb_zy())%>"){
		$("#new_jb_zy").val("3");
	} else{
		$("#new_jb_zy").val("");
	}
	
	if("yjygjgcs"=="<%=StringUtil.deNull(directoryBean.getNew_jszc())%>"){
		$("#new_jszc").val("yjygjgcs");
	}else if("gjgcs"=="<%=StringUtil.deNull(directoryBean.getNew_jszc())%>"){
		$("#new_jszc").val("gjgcs");
	}else if("gcs"=="<%=StringUtil.deNull(directoryBean.getNew_jszc())%>"){
		$("#new_jszc").val("gcs");
	}else if("zlgcs"=="<%=StringUtil.deNull(directoryBean.getNew_jszc())%>"){
		$("#new_jszc").val("zlgcs");
	}else if("jsy"=="<%=StringUtil.deNull(directoryBean.getNew_jszc())%>"){
		$("#new_jszc").val("jsy");
	}else if("gjjjs"=="<%=StringUtil.deNull(directoryBean.getNew_jszc())%>"){
		$("#new_jszc").val("gjjjs");
	}else if("jjs"=="<%=StringUtil.deNull(directoryBean.getNew_jszc())%>"){
		$("#new_jszc").val("jjs");
	}else if("zljjs"=="<%=StringUtil.deNull(directoryBean.getNew_jszc())%>"){
		$("#new_jszc").val("zljjs");
	}else if("gjkjy"=="<%=StringUtil.deNull(directoryBean.getNew_jszc())%>"){
		$("#new_jszc").val("gjkjy");
	}else if("zlkjy"=="<%=StringUtil.deNull(directoryBean.getNew_jszc())%>"){
		$("#new_jszc").val("zlkjy");
	}else if("kjy"=="<%=StringUtil.deNull(directoryBean.getNew_jszc())%>"){
		$("#new_jszc").val("kjy");
	}else if("kjs"=="<%=StringUtil.deNull(directoryBean.getNew_jszc())%>"){
		$("#new_jszc").val("kjs");
	}else{
		$("#new_jszc").val("");
	}
	
	if("1"=="<%=StringUtil.deNull(directoryBean.getNew_job_state())%>"){
		$("#new_job_state").val("1");
	}else if("2"=="<%=StringUtil.deNull(directoryBean.getNew_job_state())%>"){
		$("#new_job_state").val("2");
	}else if("3"=="<%=StringUtil.deNull(directoryBean.getNew_job_state())%>"){
		$("#new_job_state").val("3");
	}else if("4"=="<%=StringUtil.deNull(directoryBean.getNew_job_state())%>"){
		$("#new_job_state").val("4");
	}else if("5"=="<%=StringUtil.deNull(directoryBean.getNew_job_state())%>"){
		$("#new_job_state").val("5");
	}else if("6"=="<%=StringUtil.deNull(directoryBean.getNew_job_state())%>"){
		$("#new_job_state").val("6");
	}else{
		$("#new_job_state").val("");
	}
	
	if("timeHT"=="<%=StringUtil.deNull(heTongBean.getHetong_type())%>"){
		$("#hetong_type").val("timeHT");
	}else if("notimeHT"=="<%=StringUtil.deNull(heTongBean.getHetong_type())%>"){
		$("#hetong_type").val("notimeHT");
	}else if("notimeHTCB"=="<%=StringUtil.deNull(heTongBean.getHetong_type())%>"){
		$("#hetong_type").val("notimeHTCB");
	}else if("lwpqHT"=="<%=StringUtil.deNull(heTongBean.getHetong_type())%>"){
		$("#hetong_type").val("lwpqHT");
	}else if("lwHT"=="<%=StringUtil.deNull(heTongBean.getHetong_type())%>"){
		$("#hetong_type").val("lwHT");
	}else{
		$("#hetong_type").val("");
	}
	
	if("1"=="<%=StringUtil.deNull(heTongBean.getHetong_isold())%>"){
		$("#hetong_isold_box").attr("checked","checked");
		$("#hetong_isold").val("1");
	}
	if("1"=="<%=StringUtil.deNull(heTongBean.getHetong_isyl())%>"){
		$("#hetong_isyl_box").attr("checked","checked");
		$("#hetong_isyl").val("1");
	}
	if("1"=="<%=StringUtil.deNull(heTongBean.getHetong_issy())%>"){
		$("#hetong_issy_box").attr("checked","checked");
		$("#hetong_issy").val("1");
	}
	if("1"=="<%=StringUtil.deNull(heTongBean.getHetong_isgs())%>"){
		$("#hetong_isgs_box").attr("checked","checked");
		$("#hetong_isgs").val("1");
	}
	if("1"=="<%=StringUtil.deNull(heTongBean.getHetong_isshiye())%>"){
		$("#hetong_isshiye_box").attr("checked","checked");
		$("#hetong_isshiye").val("1");
	}
	if("1"=="<%=StringUtil.deNull(heTongBean.getHetong_isydwgm())%>"){
		$("#hetong_ydwgm_box").attr("checked","checked");
		$("#hetong_ydwgm").val("1");
	}
	

	if("在职"=="<%=StringUtil.deNull(Sitting)%>"){
		$("#directorystate").val("jobing");
	}else if("离职"=="<%=StringUtil.deNull(Sitting)%>"){
		$("#directorystate").val("departure");
	}else if("退休"=="<%=StringUtil.deNull(Sitting)%>"){
		$("#directorystate").val("retirement");
	}else{
		$("#directorystate").val("");
	}
	if("是"=="<%=StringUtil.deNull(numberOne)%>"){
		$("#numberOne").attr("checked","checked");
	}
	
	$("#new_user_type").change(function(){  //如果选择了编内职工 则显示在岗状态
		if($("#new_user_type").val() == "bnzg"){
			$("#zgzt").show();
		}else{
			$("#zgzt").hide();
		}
	});
	//编辑框按ESC键退出无效，但展示的各下拉框类型的控件全部变成请选择。
	$("input").bind("keydown",function(e){
		if(e.keyCode==27){
			return false;
		}
	})
	
});


/**
 * 更新
 */
function updatesubmit(){
	debugger;
	var isFlag = $('#form1').validationEngine('validate'); //是否全部验证通过
	
	var hetong_isold = $("#hetong_isold_box").attr("checked");
	var hetong_isyl = $("#hetong_isyl_box").attr("checked");
	var hetong_issy = $("#hetong_issy_box").attr("checked");
	var hetong_isgs = $("#hetong_isgs_box").attr("checked");
	var hetong_isshiye = $("#hetong_isshiye_box").attr("checked");
	//【参加的保险】字段增加【原单位购买】复选框
	var hetong_ydwgm = $("#hetong_ydwgm_box").attr("checked");
	if("checked"==hetong_isold){
		$("#hetong_isold").val("1");
	} else {
		$("#hetong_isold").val("0");
	}
	if("checked"==hetong_isyl){
		$("#hetong_isyl").val("1");
	} else {
		$("#hetong_isyl").val("0");
	}
	if("checked"==hetong_issy){
		$("#hetong_issy").val("1");
	} else {
		$("#hetong_issy").val("0");
	}
	if("checked"==hetong_isgs){
		$("#hetong_isgs").val("1");
	} else {
		$("#hetong_isgs").val("0");
	}
	if("checked"==hetong_isshiye){
		$("#hetong_isshiye").val("1");
	} else {
		$("#hetong_isshiye").val("0");
	}
	//【参加的保险】字段增加【原单位购买】复选框
	if("checked"==hetong_ydwgm){
		$("#hetong_ydwgm").val("1");
	} else {
		$("#hetong_ydwgm").val("0");
	}
	
	//特检院 OA 追加薪酬信息  2012-02-25 start 
/* 	//岗位工资
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
	isFlag = myValidateNums('new_xc_cb'); */
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
	<form id="form1" action="updateUserInfo.jsp" method="post"
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
					<th class="content_02_box_div_table_th">身份证：<%=StringUtil.deNull(directoryBean.getUserid())%></th>
					<td class="content_02_box_div_table_td">
					   <input  name="userIdcard" id="userIdcard" style="width:178px" class="input_185" value="<%=StringUtil.deNull(directoryBean.getIdnumber())%>"/> &nbsp;
					</td>
					<th class="content_02_box_div_table_th"> 姓名：</th>
					<td class="content_02_box_div_table_td">
					    <input id="userRealname" name="userRealname" class="validate[maxSize[30]] input_185" value="<%=StringUtil.deNull(directoryBean.getDirectoryname())%>"/>&nbsp;
					</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">性别：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;">
						<select style="width: 190px;" name="userSex" id="userSex">
						</select>
				    </td>
					<th class="content_02_box_div_table_th">出生年月：</th>
					<td class="content_02_box_div_table_td">
					  <input  id="userBirthday" name="userBirthday" class="input_185" value="<%=StringUtil.deNull(directoryBean.getDirectoryyear())%>"
					  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />&nbsp;
					</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th">人员类别：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;">
						<select style="width: 190px;" name="new_user_type" id="new_user_type">
						    <option value="">--请选择--</option>
						    <option value="bnzg">编内职工</option>
						    <option value="bwzg">编外职工</option>
						    <option value="txzg">退休职工</option>
						</select>
				    </td>
					<th class="content_02_box_div_table_th">职工工号：</th>
					<td class="content_02_box_div_table_td">
					 <input id="new_job_no" name="new_job_no" class="validate[maxSize[20]] input_185" value="<%=StringUtil.deNull(directoryBean.getNew_job_no())%>"/>&nbsp;
					</td>
				</tr>
				
				<tr id="zgzt">
					<th class="content_02_box_div_table_th">在岗状态：</th>
					<td class="content_02_box_div_table_td" colspan="3" style="width: 190px;">
						<select style="width: 190px;" name="new_job_state" id="new_job_state">
						    <option value=''>--请选择--</option>
							<option value='1'>编内在岗职工</option>
							<option value='2'>省院内部借调职工</option>
							<option value='3'>质监系统借调职工</option>
							<option value='4'>在编不在岗职工</option>
							<option value='5'>无固定期劳动合同(参编职工)</option>
							<option value='6'>岳阳事业部编内</option>
						</select>
				    </td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th">岗位设置：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;">
						<select style="width: 190px;" name="new_job_set" id="new_job_set">
						    <option value="">--请选择--</option>
						    <option value="glgw">管理岗位</option>
						    <option value="zjgw">专技岗位</option>
						    <option value="gqgw">工勤岗位</option>
						</select>
				    </td>
					<th class="content_02_box_div_table_th">参加组织日期：</th>
					<td class="content_02_box_div_table_td">
					 <input id="new_join_zzdate" name="new_join_zzdate" class="input_185" value="<%=StringUtil.deNull(directoryBean.getNew_join_zzdate())%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>&nbsp;
					</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th">入院时间：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;">
						<input id="new_in_hosb" name="new_in_hosb" class="input_185" value="<%=StringUtil.deNull(directoryBean.getNew_in_hosb())%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
				    </td>
					<th class="content_02_box_div_table_th">借调时间：</th>
					<td class="content_02_box_div_table_td">
					 <input id="new_toother_date" name="new_toother_date" class="input_185" value="<%=StringUtil.deNull(directoryBean.getNew_toother_date())%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>&nbsp;
					</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">民族：</th>
					<td class="content_02_box_div_table_td">
					   <input id="nation" name="nation" style="width:178px" class="validate[maxSize[10]] input_185" value="<%=StringUtil.deNull(directoryBean.getNation())%>"/>
					   &nbsp;</td>
					<th class="content_02_box_div_table_th">籍贯：</th>
					<td class="content_02_box_div_table_td">
					   <input id="natives" name="natives" class="validate[maxSize[50]] input_185" value="<%=StringUtil.deNull(directoryBean.getNatives())%>"/>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">政治面貌：</th>
					<td class="content_02_box_div_table_td">
						<select style="width: 190px;" id='politics' name='politics'>
						<option value=''>--请选择--</option>
						<option value='1'>中共党员</option>
						<option value='2'>中共预备党员</option>
						<option value='3'>共青团员</option>
						<option value='4'>民革党员</option>
						<option value='5'>民盟盟员</option>
						<option value='6'>民建会员</option>
						<option value='7'>民进会员</option>
						<option value='8'>农工党党员</option>
						<option value='9'>致公党党员</option>
						<option value='10'>九三学社社员</option>
						<option value='11'>台盟盟员</option>
						<option value='12'>无党派民主人士</option>
						<option value='13'>群众</option>
						</select>
					</td>
					<th class="content_02_box_div_table_th">职务：</th>
					<td class="content_02_box_div_table_td">
					   <select id="duties" name="duties" style="width: 190px;">
					       <option value=''>--请选择--</option>
					       <option value="1">院长</option>
					       <option value="3">副院长</option>
					       <option value="4">省院总工程师</option>
					       <option value="2">党委书记</option>
					       <option value="5">纪检书记</option>
					       <option value="12">院长助理</option>
					       <option value="6">部长</option>
					       <option value="9">副部长</option>
					       <option value="8">省院副总工程师</option>
					       <option value="13">主任</option>
					       <option value="14">副主任</option>
					       <option value="15">部长兼省院副总工程师</option>
					       <option value="16">总经理</option>
					       <option value="17">副总经理</option>
					       <option value="18">工会主席</option>
					       <option value="7">分院院长</option>
					       <option value="10">分院副院长</option>
					       <option value="11">分院总工</option>
					       <option value="19">分院工会主席</option>
					       
					   </select>
					</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">级别：</th>
					<td class="content_02_box_div_table_td">
						<select style="width: 190px;" id='directorylevel' name='directorylevel'>
						<option value=''>--请选择--</option>
						<option value='副厅级'>副厅级</option>
						<option value='正处级'>正处级</option>
						<option value='副处级'>副处级</option>
						<option value='正科级'>正科级</option>
						<option value='副科级'>副科级</option>
						<option value='科员'>科员</option>
						<option value='其他'>其他</option>
						</select>
					</td>
					<th class="content_02_box_div_table_th">是否党政一把手：</th>
					<td class="content_02_box_div_table_td">
					   <input type="checkbox" name="numberOne" id="numberOne" value="是"/> &nbsp;
					</td>
					
				</tr>

				<tr>
				    <th class="content_02_box_div_table_th">参加工作时间：</th>
					<td class="content_02_box_div_table_td">
						<input  id="worktime" name="worktime" class="input_185"  value="<%=StringUtil.deNull(directoryBean.getWorktime())%>"
						 onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					</td>
					<th class="content_02_box_div_table_th">离职时间：</th>
					<td class="content_02_box_div_table_td">
						<input  id="leavetime" name="leavetime" class="input_185"  value="<%=StringUtil.deNull(directoryBean.getLeavetime())%>"
						 onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					</td>
				</tr>
				
				
				<tr>					
					<th class="content_02_box_div_table_th">在职状态：</th>
					<td class="content_02_box_div_table_td" >
						<select style="width: 190px;" id='directorystate' name='directorystate'>
							<option value=''>--请选择--</option>
							<option value='jobing'>在职</option>
							<option value='departure'>离职</option>
							<option value='retirement'>退休</option>
						</select>
					</td>
					<th class="content_02_box_div_table_th">入党时间：</th>
					<td class="content_02_box_div_table_td"  >
						<input  id="joinparttime" name="joinparttime" class="input_185"  value="<%=StringUtil.deNull(directoryBean.getJoinparttime())%>"
						 onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>&nbsp;
					</td>
				</tr>

			</table>
			</div>
		<%if("adminUser".equals(strRoles)){ %>	
			<table class="content_02_box_div_table">
				<tr>
					<td class="content_02_box_title_bg">学历职称信息</td>
				</tr>
			</table>
			<div>
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th">毕业院校(第一学历)：</th>
					<td class="content_02_box_div_table_td">
					   <input id="school" name="school" style="width:178px" class="validate[maxSize[50]] input_185" value="<%=StringUtil.deNull(directoryBean.getSchool())%>"/>&nbsp;</td>
					<th class="content_02_box_div_table_th">学位(第一学历)：</th>
					<td class="content_02_box_div_table_td">
                       <select style="width: 190px;" id='degree' name='degree'>
							<option value=''>--请选择--</option>
							<option value='bs'>博士</option>
							<option value='ss'>硕士</option>
							<option value='xs'>学士</option>
						</select>					   
					</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">学历(第一学历)：</th>
					<td class="content_02_box_div_table_td">
						<select style="width: 190px;" id='education' name='education'>
							<option value=''>--请选择--</option>
							<option value='phd'>研究生</option>
							<option value='undergraduate'>本科</option>
							<option value='specialist'>专科</option>
							<option value='highschool'>高中</option>
							<option value='secondary'>中专</option>
							<option value='juniorhighschool'>初中</option>
							<option value='primaryschool'>小学</option>
							<option value='other'>其他</option>
						</select>
					</td>
					<th class="content_02_box_div_table_th">学习形式(第一学历)：</th>
					<td class="content_02_box_div_table_td">
						<input id="new_first_xingshi" name="new_first_xingshi" class="validate[maxSize[50]] input_185"  value="<%=StringUtil.deNull(directoryBean.getNew_first_xingshi())%>" />&nbsp;
					</td>
					
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th">专业(第一学历)：</th>
					<td class="content_02_box_div_table_td">
						<input id="new_first_zy" name="new_first_zy" class="validate[maxSize[50]] input_185"  value="<%=StringUtil.deNull(directoryBean.getNew_first_zy())%>" />
					</td>
					<th class="content_02_box_div_table_th">毕业时间(第一学历)：</th>
					<td class="content_02_box_div_table_td">
						<input  id="new_first_bydate" name="new_first_bydate" class="input_185"  value="<%=StringUtil.deNull(directoryBean.getNew_first_bydate())%>"
						 onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>&nbsp;
					</td>
				</tr>
				
               <tr>
					<th class="content_02_box_div_table_th">毕业院校(最高学历)：</th>
					<td class="content_02_box_div_table_td">
					   <input id="new_zg_byyx" name="new_zg_byyx" style="width:178px" class="validate[maxSize[50]] input_185" value="<%=StringUtil.deNull(directoryBean.getNew_zg_byyx())%>"/>
					</td>
					<th class="content_02_box_div_table_th">学位(最高学历)：</th>
					<td class="content_02_box_div_table_td">
                       <select style="width: 190px;" id='new_zg_xw' name='new_zg_xw'>
							<option value=''>--请选择--</option>
							<option value='bs'>博士</option>
							<option value='ss'>硕士</option>
							<option value='xs'>学士</option>
						</select>					   
					</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">学历(最高学历)：</th>
					<td class="content_02_box_div_table_td">
						<select style="width: 190px;" id='new_zg_xl' name='new_zg_xl'>
							<option value=''>--请选择--</option>
							<option value='phd'>研究生</option>
							<option value='undergraduate'>本科</option>
							<option value='specialist'>专科</option>
							<option value='highschool'>高中</option>
							<option value='secondary'>中专</option>
							<option value='juniorhighschool'>初中</option>
							<option value='primaryschool'>小学</option>
							<option value='other'>其他</option>
						</select>
					</td>
					<th class="content_02_box_div_table_th">学习形式(最高学历)：</th>
					<td class="content_02_box_div_table_td">
						<input  id="new_zg_xingshi" name="new_zg_xingshi" class="validate[maxSize[50]] input_185"  value="<%=StringUtil.deNull(directoryBean.getNew_zg_xingshi())%>" />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">专业(最高学历)：</th>
					<td class="content_02_box_div_table_td">
						<input  id="new_zg_zy" name="new_zg_zy" class="validate[maxSize[50]] input_185"  value="<%=StringUtil.deNull(directoryBean.getNew_zg_zy())%>" />
					</td>
					<th class="content_02_box_div_table_th">专业级别(最高学历)：</th>
					<td class="content_02_box_div_table_td">
						<select style="width: 190px;" id='new_jb_zy' name='new_jb_zy'>
							<option value=''>--请选择--</option>
							<option value='1'>承压类</option>
							<option value='2'>机电类</option>
							<option value='3'>综合类</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th">毕业时间(最高学历)：</th>
					<td class="content_02_box_div_table_td">
						<input  id="new_zg_bydate" name="new_zg_bydate" class="input_185"  value="<%=StringUtil.deNull(directoryBean.getNew_zg_bydate())%>"
						 onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					</td>
				    <th class="content_02_box_div_table_th">技术职称：</th>
					<td class="content_02_box_div_table_td">
						 <select style="width: 190px;" id='new_jszc' name='new_jszc'>
							<option value=''>--请选择--</option>
							<option value='yjygjgcs'>研究员级高级工程师</option>
							<option value='gjgcs'>高级工程师</option>
							<option value='gcs'>工程师</option>
							<option value='zlgcs'>助理工程师</option>
							<option value='jsy'>技术员</option>
							<option value='gjjjs'>高级经济师</option>
							<option value='jjs'>经济师</option>
							<option value='zljjs'>助理经济师</option>
							<option value='gjkjy'>高级会计师</option>
							<option value='zlkjy'>助理会计师</option>
							<option value='kjy'>会计员</option>
							<option value='kjs'>会计师</option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th">职称获取时间：</th>
					<td class="content_02_box_div_table_td">
						<input  id="new_zc_getdate" name="new_zc_getdate" class="input_185"  value="<%=StringUtil.deNull(directoryBean.getNew_zc_getdate())%>"
						 onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					</td>
					<th class="content_02_box_div_table_th">职称聘任时间：</th>
					<td class="content_02_box_div_table_td">
						<input  id="new_zc_pydate" name="new_zc_pydate" class="input_185"  value="<%=StringUtil.deNull(directoryBean.getNew_zc_pydate())%>"
						 onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>&nbsp;
					</td>
				</tr>
			</table>
			</div>
        <%} %>
			<table class="content_02_box_div_table">
				<tr>
					<td class="content_02_box_title_bg">联系方式</td>
				</tr>
			</table>
			
			<div>
			<table class="content_02_box_div_table" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th class="content_02_box_div_table_th"> 办公手机：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;">
					   <input id="userMobiletel1" name="userMobiletel1" style="width:175px" class="validate[custom[phone]] input_185" value="<%=StringUtil.deNull(directoryBean.getMobile())%>"/>&nbsp;
					</td>
					<th class="content_02_box_div_table_th"> 常用手机：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;">
					   <input id="userMobiletel2" name="userMobiletel2" style="width:175px" class="validate[custom[phone]] input_185" value="<%=StringUtil.deNull(directoryBean.getMobile2())%>"/>&nbsp;
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">办公电话：</th>
					<td class="content_02_box_div_table_td">
					   <input id ="userWorktel" name ="userWorktel" style="width:175px" class="input_185" value="<%=StringUtil.deNull(directoryBean.getWorkphone())%>"/>&nbsp;
					</td>
					<th class="content_02_box_div_table_th">住宅地址：</th>
					<td class="content_02_box_div_table_td">
					   <input id="homeadress" name="homeadress" style="width:175px" class="validate[maxSize[100]] input_185" value="<%=StringUtil.deNull(directoryBean.getHomeadress())%>"/>&nbsp;
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">住宅电话：</th>
					<td class="content_02_box_div_table_td">
					   <input id ="homePhone" name ="homePhone" style="width:175px" class="validate[custom[phone]] input_185" value="<%=StringUtil.deNull(directoryBean.getHomephone())%>"/>&nbsp;
					</td>
					<th class="content_02_box_div_table_th">电子邮箱：</th>
					<td class="content_02_box_div_table_td">
					   <input id="mail" name="mail" style="width:175px" class="validate[custom[email]] input_185" value="<%=StringUtil.deNull(directoryBean.getEmail())%>"/>&nbsp;
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">短号：</th>
					<td class="content_02_box_div_table_td" colspan="3">
					<input id="remark4" name="remark4" style="width:175px" class="validate[maxSize[100]] input_185" value="<%=StringUtil.deNull(directoryBean.getRemark4())%>"/>&nbsp;
				    </td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >工作职责：</th>
					<td colspan="3" class="content_02_box_div_table_td">
					   <textarea cols="60" class="validate[maxSize[100]]" id="duty" name="duty"><%=StringUtil.deNull(directoryBean.getDuty())%></textarea>
					   &nbsp;
					</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th" >个人履历：</th>
					<td colspan="3" class="content_02_box_div_table_td">
						<textarea cols="60"  class="validate[maxSize[100]]" id="resume" name="resume"><%=StringUtil.deNull(directoryBean.getResume())%></textarea>
						&nbsp;
					</td>
				</tr>
			</table>
		</div>
		
		<table class="content_02_box_div_table">
				<tr>
					<td class="content_02_box_title_bg">保险合同</td>
				</tr>
			</table>
			<div>
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th">是否参加的保险：</th>
					<td colspan="3" class="content_02_box_div_table_td">
					    <input type="checkbox" id="hetong_isold_box" name="hetong_isold_box"/>&nbsp;养老&nbsp;&nbsp;
					    <input type="hidden" id="hetong_isold" name="hetong_isold" value="0"/>
					    <input type="checkbox" id="hetong_isyl_box" name="hetong_isyl_box"/>&nbsp;医疗&nbsp;&nbsp;
					    <input type="hidden" id="hetong_isyl" name="hetong_isyl" value="0"/>
					    <input type="checkbox" id="hetong_issy_box" name="hetong_issy_box"/>&nbsp;生育&nbsp;&nbsp;
					    <input type="hidden" id="hetong_issy" name="hetong_issy" value="0"/>
					    <input type="checkbox" id="hetong_isgs_box" name="hetong_isgs_box"/>&nbsp;工伤&nbsp;&nbsp;
					    <input type="hidden" id="hetong_isgs" name="hetong_isgs" value="0"/>
					    <input type="checkbox" id="hetong_isshiye_box" name="hetong_isshiye_box"/>&nbsp;失业&nbsp;&nbsp;
					    <input type="hidden" id="hetong_isshiye" name="hetong_isshiye" value="0"/>
					    <input type="checkbox" id="hetong_ydwgm_box" name="hetong_ydwgm_box"/>&nbsp;原单位购买&nbsp;&nbsp;
					    <input type="hidden" id="hetong_ydwgm" name="hetong_ydwgm" value="0"/>
					</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">合同类别：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;">
                        <select style="width: 190px;" id='hetong_type' name='hetong_type'>
							<option value=''>--请选择--</option>
							<option value='timeHT'>固定期劳动合同</option>
							<option value='notimeHT'>无固定期劳动合同</option>
							<option value='notimeHTCB'>无固定期劳动合同(参编)</option>
							<option value='lwpqHT'>劳务派遣合同</option>
							<option value='lwHT'>劳务合同</option>
						</select>
                    </td>
					<th class="content_02_box_div_table_th">08年后劳动合同签订次数：</th>
					<td class="content_02_box_div_table_td">
                        <input id="hetong_number" name="hetong_number" style="width:175px" class="input_185" value="<%=heTongBean.getHetong_number()%>"/>&nbsp;
                    </td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">合同编号：</th>
					<td class="content_02_box_div_table_td">
                        <input id="hetong_busiid" name="hetong_busiid" style="width:175px" class="input_185" value="<%=StringUtil.deNull(heTongBean.getHetong_busiid())%>"/>
                    </td>
					<th class="content_02_box_div_table_th">首次合同签订日期：</th>
					<td class="content_02_box_div_table_td">
                        <input id="hetong_first_date" name="hetong_first_date" style="width:175px" class="input_185" value="<%=heTongBean.getHetong_first_date()%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>&nbsp;
                    </td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">现合同起始期：</th>
					<td class="content_02_box_div_table_td">
                        <input id="hetong_nowstart_date" name="hetong_nowstart_date" style="width:175px" class="input_185" value="<%=heTongBean.getHetong_nowstart_date()%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">现合同终止期：</th>
					<td class="content_02_box_div_table_td">
                        <input id="hetong_nowsend_date" name="hetong_nowsend_date" style="width:175px" class="input_185" value="<%=heTongBean.getHetong_nowsend_date()%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>&nbsp;
                    </td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">合同试用起始期：</th>
					<td class="content_02_box_div_table_td">
                        <input id="hetong_trystart_date" name="hetong_trystart_date" style="width:175px" class="input_185" value="<%=heTongBean.getHetong_trystart_date()%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">合同试用终止期：</th>
					<td class="content_02_box_div_table_td">
					    <input id="hetong_tryend_date" name="hetong_tryend_date" style="width:175px" class="input_185" value="<%=heTongBean.getHetong_tryend_date()%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>&nbsp;
					</td>					
				</tr>

			</table>
			</div>
			<%-- <%if("adminUser".equals(strRoles)){ %>	
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
		<%} %>	 --%>
		
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