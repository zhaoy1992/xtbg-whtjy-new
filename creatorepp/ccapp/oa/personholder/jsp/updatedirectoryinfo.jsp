
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
	//学历
	String new_zg_xl = directoryBean.getNew_zg_xl();
	if("phd".equals(new_zg_xl))
	{
		new_zg_xl = "研究生";
	}
	else if("undergraduate".equals(new_zg_xl))
	{
		new_zg_xl = "本科";
	}
	else if("specialist".equals(new_zg_xl))
	{
		new_zg_xl = "专科";
	}
	else if("highschool".equals(new_zg_xl))
	{
		new_zg_xl = "高中";
	}
	else if("secondary".equals(new_zg_xl))
	{
		new_zg_xl = "中专";
	}
	else if("juniorhighschool".equals(new_zg_xl))
	{
		new_zg_xl = "初中";
	}
	else if("primaryschool".equals(new_zg_xl))
	{
		new_zg_xl = "小学";
	}
	else if("other".equals(new_zg_xl))
	{
		new_zg_xl = "其它";
	}else{
		new_zg_xl = "";
	}
	
	//技术职称
	String new_jszc = directoryBean.getNew_jszc();
	if("yjygjgcs".equals(new_jszc))
	{
		new_jszc = "研究员级高级工程师";
	}
	else if("gjgcs".equals(new_jszc))
	{
		new_jszc = "高级工程师";
	}
	else if("gcs".equals(new_jszc))
	{
		new_jszc = "工程师";
	}
	else if("zlgcs".equals(new_jszc))
	{
		new_jszc = "助理工程师";
	}
	else if("jsy".equals(new_jszc))
	{
		new_jszc = "技术员";
	}
	else if("gjjjs".equals(new_jszc))
	{
		new_jszc = "高级经济师";
	}
	else if("jjs".equals(new_jszc))
	{
		new_jszc = "经济师";
	}
	else if("zljjs".equals(new_jszc))
	{
		new_jszc = "助理经济师";
	}
	else if("gjkjy".equals(new_jszc))
	{
		new_jszc = "高级会计师";
	}
	else if("zlkjy".equals(new_jszc))
	{
		new_jszc = "助理会计师";
	}
	else if("kjy".equals(new_jszc))
	{
		new_jszc = "会计员";
	}else{
		new_jszc = "";
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
var userids = "<%=StringUtil.deNull(typeid)%>";
$(function() {

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
	
});

/**
 * 更新
 */
function updatesubmit(){
	var isFlag = $('#form1').validationEngine('validate'); //是否全部验证通过
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

/**
 * 综合打印
 */
function exportFile(){
	    
		var url = "${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/ajaxexcel.jsp";
	    var html = new Array();
	    html.push("<div id='export_excel'>");
	    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
	    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
	    html.push("<input type='hidden' name='userids' value='"+userids+"' /> ");
	    html.push("<input type='hidden' name='excelname' value='人员持证综合信息' /> ");//导出的主题
	    html.push("<input type='hidden' name='excelImplClass' value='holderDaoExcelImpl' /> ");//导入导出的实现类，要提前在spring中或orcleConfig中配置好
	    html.push("<input type='hidden' name='excelTemplateFilePath' value='printHolderAll_excelTemplateFilePath' /> ");//导出的excel模版路径，要提前在系统properties中配置好
	    html.push('</form>');
	    html.push("</div>");
	    //加载到body，提交后再删除
	    jQuery(html.join("")).appendTo("body");
	    jQuery("#downFrom").submit();
	    jQuery("#export_excel").remove();
	}
</script>
</head>
<body style="overflow-x:auto;" class="vcenter">
	<form id="form1" action="updateUserInfo.jsp" method="post"
		class="formular">
		<input type="hidden" name="userid" id="userid" value="<%=StringUtil.deNull(typeid)%>" />
		
	<div >
			<table class="content_02_box_div_table">
				<tr>
					<td class="content_02_box_title_bg"><span>基本资料</span><input type="button" value="综合打印" onclick="exportFile();" style="margin-top: 5px;" class="but_y_01"/></td>
				</tr>
			</table>
			<div>
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th">姓名：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDirectoryname())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">性别：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;"><%=StringUtil.deNull(directoryBean.getDirectorysex())%>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">第一学历：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;"><%=StringUtil.deNull(directoryBean.getEducation())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">所学专业：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getNew_first_zy())%>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">毕业院校：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getSchool())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">最高学历：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(new_zg_xl)%>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">所学专业（最高学历）：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getNew_zg_zy())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">毕业院校（最高学历）：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getNew_zg_byyx())%>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">职称：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(new_jszc)%>&nbsp;</td>
					<th class="content_02_box_div_table_th">获得时间：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getNew_zc_getdate())%>&nbsp;
					</td>					
				</tr>

			</table>
			</div>
			<div class="content_02_box"  style="width:780px;border: 1px;">
			<div class="content_02_box_title_bg" style="width: 760px"><span>持证信息管理</span></div>
			<div class="content_02_box_div"  style="width: 788px;">
			<iframe
				frameborder="0"
				style="padding: 0px; border: 0px; width: 97%; height: 200px"
				id="question_manage" name="question_manage"
				src="persionholderlist.jsp?windowsId=windowId&hold_usesnid=<%=StringUtil.deNull(typeid)%>"></iframe>
			</div>
			</div>
			<div class="content_02_box"  style="width:780px;border: 1px;">
			<div class="content_02_box_title_bg" style="width: 760px"><span>培训记录管理</span></div>
			<div class="content_02_box_div"  style="width: 788px;">
			<iframe
				frameborder="0"
				style="padding: 0px; border: 0px; width: 97%; height: 200px"
				id="question_manage" name="question_manage"
				src="trainlist.jsp?subid=windowId&tr_usersn=<%=StringUtil.deNull(typeid)%>"></iframe>
			</div>
			</div>
			
		</div>
		</div>
	</form>
</body>
</html>