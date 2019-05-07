<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.directory.entity.DirectoryBean"%>
<%@page
	import="com.chinacreator.xtbg.pub.directory.service.impl.DirectoryServiceImpl"%>
<%@page
	import="com.chinacreator.xtbg.pub.directory.service.DirectoryServiceIfc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>

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
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分结束 -->
<script type="text/javascript">
jQuery(document).ready(function() {
	// binds form submission and fields to the validation engine
	//jQuery("#form1").validationEngine();
});
$(function() {
	$("#directoryyear").datepicker({
		showOn: "button",
		buttonImage: "../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/demos/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"yy-mm-dd"
	});
	$("#worktime").datepicker({
		showOn: "button",
		buttonImage: "../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/demos/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"yy-mm-dd"
	});
	$("#joinparttime").datepicker({
		showOn: "button",
		buttonImage: "../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/demos/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"yy-mm-dd"
	});

});

function closed(){
	removeAlertWindows('',true);
	//parent.JqueryDialog.Close();
}
</script>
</head>
<body style="overflow-x:auto;" class="vcenter">
	<form id="form1" action="addorupdatedirectorydo.jsp" method="post"
		class="formular">
		<input type="hidden" name="directoryid" id="directoryid"
			value="<%=StringUtil.deNull(directoryBean.getDirectoryid())%>" />
		<input type="hidden" name="orgid" id="orgid"
			value="<%=StringUtil.nullOrBlank(directoryBean.getOrgid())?orgid:directoryBean.getOrgid()%>" />
		<!-- <input type="hidden" name="orgname" id="orgname"
			value="<%=StringUtil.deNull(directoryBean.getOrgname())%>"> -->
		<input type="hidden" name="duties" id="duties"
			value="<%=StringUtil.deNull(directoryBean.getDuties())%>" /> 
		<input type="hidden" name="paramjosn" id="paramjosn" /> 
		<input type="hidden" name="action" id="action" />

		<div >
			<table class="content_02_box_div_table">
				<tr>
					<td class="content_02_box_title_bg">基本资料</td>
				</tr>
			</table>
			<div>
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th">身份证：</th>
					<td class="content_02_box_div_table_td" style="width: 150px;"><%=StringUtil.deNull(directoryBean.getIdnumber())%>&nbsp;</td>
					<th class="content_02_box_div_table_th"> 姓名：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDirectoryname())%>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">性别：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;"><%=StringUtil.deNull(directoryBean.getDirectorysex())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">出生年月：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDirectoryyear())%>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">民族：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getNation())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">籍贯：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getNatives())%>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">政治面貌：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getPolitics())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">职务：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getPost())%>&nbsp;</td>
				</tr>

				<%-- <tr>
					<th class="content_02_box_div_table_th">所属单位：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.nullOrBlank(directoryBean.getOrgname())?orgname:directoryBean.getOrgname()%>&nbsp;</td>
					<th class="content_02_box_div_table_th">所在科室：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDepartment())%>&nbsp;</td>
				</tr> --%>
				
				<%-- <tr>
					<th class="content_02_box_div_table_th">兼职单位：</th>
					<td class="content_02_box_div_table_td" colspan="3"><%=StringUtil.nullOrBlank(directoryBean.getDeptName())?"&nbsp;":directoryBean.getDeptName()%>&nbsp;</td>
				</tr> --%>

				<tr>
					<th class="content_02_box_div_table_th">级别：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDirectorylevel())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">是否党政一把手：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(numberOne)%>&nbsp;
					</td>
					
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">毕业院校：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getSchool())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">学位：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDegree())%>&nbsp;
					</td>
				</tr>

				<tr>
				
					<th class="content_02_box_div_table_th">学历：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getEducation())%>&nbsp;
					</td>
					<th class="content_02_box_div_table_th">参加工作时间：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getWorktime())%>&nbsp;</td>
					
				</tr>

				<tr>
					<%-- <th class="content_02_box_div_table_th">排序：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDirectory_sn())%>&nbsp;</td> --%>
					<th class="content_02_box_div_table_th">在职状态：</th>
					<td class="content_02_box_div_table_td" ><%=StringUtil.deNull(Sitting)%>&nbsp;</td>
					<th class="content_02_box_div_table_th">入党时间：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getJoinparttime())%>&nbsp;</td>
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
					<td class="content_02_box_div_table_td" style="width: 190px;"><%=StringUtil.deNull(directoryBean.getMobile())%>&nbsp;</td>
					<th class="content_02_box_div_table_th"> 常用手机：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;"><%=StringUtil.deNull(directoryBean.getMobile2())%>&nbsp;</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">办公地址：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getWorkadress())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">办公电话：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getWorkphone())%>&nbsp;</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">住宅地址：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getHomeadress())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">住宅电话：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getHomephone())%>&nbsp;</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">电子邮箱：</th>
					<td class="content_02_box_div_table_td" colspan="3"><%=StringUtil.deNull(directoryBean.getEmail())%>&nbsp;</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th" colspan="1">工作职责：</th>
					<td colspan="3" class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDuty())%>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th" colspan="1">个人履历：</th>
					<td colspan="3" class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getResume())%>&nbsp;</td>
				</tr>
			</table>
		</div>
			<table class="cue_box_foot" style="display: none;">
				<tr>
					<td><input class="but_h_01" type="reset" id="resert"
						value="关闭" onclick="closed()" /></td>
				</tr>
			</table>
		</div>
	</form>
</body>
</html>