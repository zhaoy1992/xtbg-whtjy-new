<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.directory.entity.DirectoryBean"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.impl.DirectoryServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.DirectoryServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=GBK"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>

<title>JGRID</title>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String urls = request.getParameter("urls");
	String orgid = request.getParameter("orgid");
	String typeid = request.getParameter("typeid");
	
	String orgname = DaoUtil.SqlToField("select org_name from td_sm_organization where org_id = '"+orgid+"'");
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
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->

<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 公共部分结束 -->
<script type="text/javascript">

$(function() {
	if("男"=="<%=StringUtil.deNull(directoryBean.getDirectorysex())%>"){
		$("#userSex").html("<option value='M'>男</option><option value='F'>女</option><option value=''>未知</option>");
	}else if("女"=="<%=StringUtil.deNull(directoryBean.getDirectorysex())%>"){
		$("#userSex").html("<option value='F'>女</option><option value='M'>男</option><option value=''>未知</option>");
	}else{
		$("#userSex").html("<option value='M'>男</option><option value='F'>女</option><option value=''>未知</option>");
	}
	
	$("#politics").val("<%=StringUtil.deNull(directoryBean.getPolitics())%>");
	<%-- if("中共党员"=="<%=StringUtil.deNull(directoryBean.getPolitics())%>"){
		$("#politics").val("1");
	}else if("中共预备党员"=="<%=StringUtil.deNull(directoryBean.getPolitics())%>"){
		$("#politics").val("2");
	}else if("共青团员"=="<%=StringUtil.deNull(directoryBean.getPolitics())%>"){
		$("#politics").val("3");
	}else if("民革党员"=="<%=StringUtil.deNull(directoryBean.getPolitics())%>"){
		$("#politics").val("4");
	}else if("民盟盟员"=="<%=StringUtil.deNull(directoryBean.getPolitics())%>"){
		$("#politics").val("5");
	}else if("民建会员"=="<%=StringUtil.deNull(directoryBean.getPolitics())%>"){
		$("#politics").val("6");
	}else if("民进会员"=="<%=StringUtil.deNull(directoryBean.getPolitics())%>"){
		$("#politics").val("7");
	}else if("农工党党员"=="<%=StringUtil.deNull(directoryBean.getPolitics())%>"){
		$("#politics").val("8");
	}else if("致公党党员"=="<%=StringUtil.deNull(directoryBean.getPolitics())%>"){
		$("#politics").val("9");
	}else if("九三学社社员"=="<%=StringUtil.deNull(directoryBean.getPolitics())%>"){
		$("#politics").val("10");
	}else if("台盟盟员"=="<%=StringUtil.deNull(directoryBean.getPolitics())%>"){
		$("#politics").val("11");
	}else if("无党派民主人士"=="<%=StringUtil.deNull(directoryBean.getPolitics())%>"){
		$("#politics").val("12");
	}else if("群众"=="<%=StringUtil.deNull(directoryBean.getPolitics())%>"){
		$("#politics").val("13");
	}else{
		$("#politics").val("");
	} --%>
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
function updatesubmit(){
	var isFlag = $('#form1').validationEngine('validate'); //是否全部验证通过
	if(isFlag){
		$("#form1").submit();
	}else{
   		$("body").scrollTop(0);
		return;
	}
	
}
function closed(){
	removeAlertWindows('',true);
	//parent.JqueryDialog.Close();
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
					<td class="content_02_box_title_bg">基本资料</td>
				</tr>
			</table>
			<div>
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th">身份证：<%=StringUtil.deNull(directoryBean.getUserid())%></th>
					<td class="content_02_box_div_table_td">
					 <input  name="userIdcard" id="userIdcard" style="width:178px" class="validate[checkidcard] input_185" value="<%=StringUtil.deNull(directoryBean.getIdnumber())%>"/> &nbsp;
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
				<%-- 	<%=StringUtil.deNull(directoryBean.getDirectorysex())%>&nbsp; --%>
					</td>
					<th class="content_02_box_div_table_th">出生年月：</th>
					<td class="content_02_box_div_table_td">
					  <input  id="userBirthday" name="userBirthday" class="input_185" value="<%=StringUtil.deNull(directoryBean.getDirectoryyear())%>"
					  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />&nbsp;
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
					<%-- <%=StringUtil.deNull(directoryBean.getPolitics())%>&nbsp; --%>
					</td>
					<th class="content_02_box_div_table_th">职务：</th>
					<td class="content_02_box_div_table_td">
					<input id="duties" name="duties" class="validate[maxSize[30]] input_185" value="<%=StringUtil.deNull(directoryBean.getPost())%>"/>&nbsp;</td>
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
					<%-- <%=StringUtil.deNull(directoryBean.getDirectorylevel())%>&nbsp; --%>
					</td>
					<th class="content_02_box_div_table_th">是否党政一把手：</th>
					<td class="content_02_box_div_table_td">
					<input type="checkbox" name="numberOne" id="numberOne" value="是"/> &nbsp;
					</td>
					
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">毕业院校：</th>
					<td class="content_02_box_div_table_td">
					<input id="school" name="school" style="width:178px" class="validate[maxSize[50]] input_185" value="<%=StringUtil.deNull(directoryBean.getSchool())%>"/>&nbsp;</td>
					<th class="content_02_box_div_table_th">学位：</th>
					<td class="content_02_box_div_table_td">
					<input id='degree' name='degree' class="validate[maxSize[50]] input_185" value="<%=StringUtil.deNull(directoryBean.getDegree())%>"/>&nbsp;
					</td>
				</tr>

				<tr>
				
					<th class="content_02_box_div_table_th">学历：</th>
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
					<%-- <input value="<%=StringUtil.deNull(directoryBean.getEducation())%>"/>&nbsp; --%>
					</td>
					<th class="content_02_box_div_table_th">参加工作时间：</th>
					<td class="content_02_box_div_table_td">
					<input  id="worktime" name="worktime" class="input_185"  value="<%=StringUtil.deNull(directoryBean.getWorktime())%>"
					 onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>&nbsp;</td>
					
				</tr>

				<tr>
					<%-- <th class="content_02_box_div_table_th">排序：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDirectory_sn())%>&nbsp;</td> --%>
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
					 onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>&nbsp;</td>
				</tr>

			</table>
			</div>

			<table class="content_02_box_div_table">
				<tr>
					<td class="content_02_box_title_bg">联系方式</td>
				</tr>
			</table>
			
			<div>
			<table class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th"> 办公手机：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;">
					<input id="userMobiletel1" name="userMobiletel1" style="width:175px" class="validate[custom[phone]] input_185" value="<%=StringUtil.deNull(directoryBean.getMobile())%>"/>&nbsp;</td>
					<th class="content_02_box_div_table_th"> 常用手机：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;">
					<input id="userMobiletel2" name="userMobiletel2" style="width:175px" class="validate[custom[phone]] input_185" value="<%=StringUtil.deNull(directoryBean.getMobile2())%>"/>&nbsp;</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">电子邮箱：</th>
					<td class="content_02_box_div_table_td">
					<input id="mail" name="mail" style="width:175px" class="validate[custom[email]] input_185" value="<%=StringUtil.deNull(directoryBean.getEmail())%>"/>&nbsp;</td>
					<th class="content_02_box_div_table_th">办公电话：</th>
					<td class="content_02_box_div_table_td">
					<input id ="userWorktel" name ="userWorktel" style="width:175px" class="validate[custom[phone]] input_185" value="<%=StringUtil.deNull(directoryBean.getWorkphone())%>"/>&nbsp;</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">住宅地址：</th>
					<td class="content_02_box_div_table_td">
					<input id="homeadress" name="homeadress" style="width:175px" class="validate[maxSize[100]] input_185" value="<%=StringUtil.deNull(directoryBean.getHomeadress())%>"/>&nbsp;</td>
					<th class="content_02_box_div_table_th">住宅电话：</th>
					<td class="content_02_box_div_table_td">
					<input id ="homePhone" name ="homePhone" style="width:175px" class="validate[custom[phone]] input_185" value="<%=StringUtil.deNull(directoryBean.getHomephone())%>"/>&nbsp;</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" >工作职责：</th>
					<td colspan="3" class="content_02_box_div_table_td">
					<textarea cols="60" class="validate[maxSize[100]]" id="duty" name="duty"><%=StringUtil.deNull(directoryBean.getDuty())%></textarea>
					
					&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th" >个人履历：</th>
					<td colspan="3" class="content_02_box_div_table_td">
					<textarea cols="60"  class="validate[maxSize[100]]" id="resume" name="resume"><%=StringUtil.deNull(directoryBean.getResume())%></textarea>
					&nbsp;</td>
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