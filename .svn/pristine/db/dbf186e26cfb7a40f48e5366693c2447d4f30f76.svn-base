<%@page import="com.chinacreator.xtbg.core.directory.constant.DirectoryConstant"%>
<%@page import="com.chinacreator.xtbg.core.directory.entity.HeTongBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.directory.entity.DirectoryBean"%>
<%@page
	import="com.chinacreator.xtbg.core.directory.service.impl.DirectoryServiceImpl"%>
<%@page
	import="com.chinacreator.xtbg.core.directory.service.DirectoryServiceIfc"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
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
	//当前用户ID
	String user_id = accesscontroler.getUserID();
	String orgname = DaoUtil.sqlToField("select org_name from td_sm_organization where org_id = '"+orgid+"'");
	DirectoryServiceIfc directoryServiceIfc = new DirectoryServiceImpl();
	String numberOne = "否";
	DirectoryBean directoryBean = new DirectoryBean();
	String peizhiUserIds = "";
	HeTongBean heTongBean = new HeTongBean();
	if (!StringUtil.isBlank(typeid)) {
		directoryBean = directoryServiceIfc
		.getTypeBeanById(typeid,"view");
		if("是".equals(directoryBean.getNumberone())){
			numberOne ="是";
		}
		heTongBean = directoryServiceIfc.getHeTongBeanById(typeid);
		
		peizhiUserIds = directoryServiceIfc.getPeizhiUserId(user_id);
	}
	if(!StringUtil.isBlank(peizhiUserIds)){
		peizhiUserIds = peizhiUserIds + ",";
	}
	String hetongtype = heTongBean.getHetong_type();
	if("timeHT".equals(hetongtype))
	{
		hetongtype = "固定期劳动合同";
	}
	else if("notimeHT".equals(hetongtype))
	{
		hetongtype = "无固定期劳动合同";
	}
	else if("notimeHTCB".equals(hetongtype))
	{
		hetongtype = "无固定期劳动合同(参编)";
	}
	else if("lwpqHT".equals(hetongtype))
	{
		hetongtype = "劳务派遣合同";
	}
	else if("lwHT".equals(hetongtype))
	{
		hetongtype = "劳务合同";
	}else{
		hetongtype = "";
	}
	String postString = directoryBean.getPost();
	if("1".equals(postString))
	{
		postString = "院长";
	}
	else if("2".equals(postString))
	{
		postString = "党委书记";
	}
	else if("3".equals(postString))
	{
		postString = "副院长";
	}
	else if("4".equals(postString))
	{
		postString = "省院总工程师";
	}
	else if("5".equals(postString))
	{
		postString = "纪检书记";
	}
	else if("6".equals(postString))
	{
		postString = "部长";
	}
	else if("7".equals(postString))
	{
		postString = "分院院长";
	}
	else if("8".equals(postString))
	{
		postString = "省院副总工程师";
	}
	else if("9".equals(postString))
	{
		postString = "副部长";
	}
	else if("10".equals(postString))
	{
		postString = "分院副院长";
	}
	else if("11".equals(postString))
	{
		postString = "分院总工";
	}
	else if("12".equals(postString))
	{
		postString = "院长助理";
	}
	else if("13".equals(postString))
	{
		postString = "主任";
	}
	else if("14".equals(postString))
	{
		postString = "副主任";
	}
	else if("15".equals(postString))
	{
		postString = "部长兼省院副总工程师";
	}
	else if("16".equals(postString))
	{
		postString = "总经理";
	}
	else if("17".equals(postString))
	{
		postString = "副总经理";
	}
	else if("18".equals(postString))
	{
		postString = "工会主席";
	}
	else if("19".equals(postString))
	{
		postString = "分院工会主席";
	}else{
		postString = "";
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
	String new_user_type = directoryBean.getNew_user_type();
	if("bnzg".equals(new_user_type))
	{
		new_user_type = "编内职工";
	}
	else if("bwzg".equals(new_user_type))
	{
		new_user_type = "编外职工";
	}
	else if("txzg".equals(new_user_type))
	{
		new_user_type = "退休职工";
	}else{
		new_user_type = "";
	}
	String new_job_state = directoryBean.getNew_job_state();
	if("1".equals(new_job_state))
	{
		new_job_state = "编内在岗职工";
	}
	else if("2".equals(new_job_state))
	{
		new_job_state = "省院内部借调职工";
	}
	else if("3".equals(new_job_state))
	{
		new_job_state = "质监系统借调职工";
	}
	else if("4".equals(new_job_state))
	{
		new_job_state = "在编不在岗职工";
	}
	else if("5".equals(new_job_state))
	{
		new_job_state = "无固定期劳动合同(参编职工)";
	}else if("6".equals(new_job_state))
	{
		new_job_state = "岳阳事业部编内";
	}else{
		new_job_state = "";
	}
	String new_job_set = directoryBean.getNew_job_set();
	if("glgw".equals(new_job_set))
	{
		new_job_set = "管理岗位";
	}
	else if("zjgw".equals(new_job_set))
	{
		new_job_set = "专技岗位";
	}
	else if("gqgw".equals(new_job_set))
	{
		new_job_set = "工勤岗位";
	}else{
		new_job_set = "";
	}
	String degree = directoryBean.getDegree();
	if("bs".equals(degree))
	{
		degree = "博士";
	}
	else if("ss".equals(degree))
	{
		degree = "硕士";
	}
	else if("xs".equals(degree))
	{
		degree = "学士";
	}else{
		degree = "";
	}
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
	String new_zg_xw = directoryBean.getNew_zg_xw();
	if("bs".equals(new_zg_xw))
	{
		new_zg_xw = "博士";
	}
	else if("ss".equals(new_zg_xw))
	{
		new_zg_xw = "硕士";
	}
	else if("xs".equals(new_zg_xw))
	{
		new_zg_xw = "学士";
	}else{
		new_zg_xw = "";
	}
	
	String new_jb_zy = directoryBean.getNew_jb_zy(); //专业级别(最高学历)
	if("1".equals(new_jb_zy)){
		new_jb_zy ="承压类";
	
	} else if("2".equals(new_jb_zy)){
		new_jb_zy ="机电类";
	
	} else if("3".equals(new_jb_zy)){
		new_jb_zy ="综合类";
	
	} else{
		new_jb_zy ="";
	}
	
%>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分结束 -->
<script type="text/javascript">
$(function(){
	if("1"=="<%=StringUtil.deNull(heTongBean.getHetong_isold())%>"){
		$("#hetong_isold_box").attr("checked","checked");
		$("#hetong_isold").val("1");
	}
	if("1"=="<%=StringUtil.deNull(heTongBean.getHetong_isyl())%>"){
		$("#hetong_isyl_box").attr("checked","checked");
		$("#hetong_isold").val("1");
	}
	if("1"=="<%=StringUtil.deNull(heTongBean.getHetong_issy())%>"){
		$("#hetong_issy_box").attr("checked","checked");
		$("#hetong_isold").val("1");
	}
	if("1"=="<%=StringUtil.deNull(heTongBean.getHetong_isgs())%>"){
		$("#hetong_isgs_box").attr("checked","checked");
		$("#hetong_isold").val("1");
	}
	if("1"=="<%=StringUtil.deNull(heTongBean.getHetong_isshiye())%>"){
		$("#hetong_isshiye_box").attr("checked","checked");
		$("#hetong_isold").val("1");
	}
});
/**
 * 关闭
 */
function closed(){
	removeAlertWindows('',true);
}
</script>
</head>
<body style='width:100%;height:420px;overflow-y:auto;' class="vcenter">
	<form id="form1" action="" method="post"
		class="formular">
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
					<th class="content_02_box_div_table_th">姓名：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDirectoryname())%>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">性别：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;"><%=StringUtil.deNull(directoryBean.getDirectorysex())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">出生年月：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDirectoryyear())%>&nbsp;</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th">人员类别：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;"><%=StringUtil.deNull(new_user_type)%>&nbsp;</td>
					<th class="content_02_box_div_table_th">职工工号：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getNew_job_no())%>&nbsp;</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th">在岗状态：</th>
					<td class="content_02_box_div_table_td"  colspan="3" style="width: 190px;"><%=StringUtil.deNull(new_job_state)%>&nbsp;</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th">岗位设置：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;"><%=StringUtil.deNull(new_job_set)%>&nbsp;
				    </td>
					<th class="content_02_box_div_table_th">参加组织日期：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getNew_join_zzdate())%>&nbsp;
					</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th">入院时间：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;"><%=StringUtil.deNull(directoryBean.getNew_in_hosb())%>&nbsp;
				    </td>
					<th class="content_02_box_div_table_th">借调时间：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getNew_toother_date())%>&nbsp;
					</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">民族：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getNation())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">籍贯：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getNatives())%>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">政治面貌：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(DirectoryConstant.parsePolitics(directoryBean.getPolitics(),true))%>&nbsp;</td>
					<th class="content_02_box_div_table_th">职务：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(postString)%>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">级别：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getDirectorylevel())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">是否党政一把手：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(numberOne)%>&nbsp;
					</td>					
				</tr>

				<tr>
				    <th class="content_02_box_div_table_th">参加工作时间：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getWorktime())%>&nbsp;
					</td>
					 <th class="content_02_box_div_table_th">离职日期：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getLeavetime())%>&nbsp;
					</td>
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
					<td class="content_02_box_title_bg">学历职称信息</td>
				</tr>
			</table>
			
			<div>
			<table class="content_02_box_div_table" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th class="content_02_box_div_table_th">毕业院校(第一学历)：</th>
					<td class="content_02_box_div_table_td">
					  <%=StringUtil.deNull(directoryBean.getSchool())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">学位(第一学历)：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(degree)%>&nbsp;
					</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">学历(第一学历)：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getEducation())%>&nbsp;
					</td>
					<th class="content_02_box_div_table_th">学习形式(第一学历)：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_first_xingshi())%>&nbsp;
					</td>
					
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th">专业(第一学历)：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_first_zy())%>&nbsp;
					</td>
					<th class="content_02_box_div_table_th">毕业时间(第一学历)：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_first_bydate())%>&nbsp;
					</td>
				</tr>

               <tr>
					<th class="content_02_box_div_table_th">毕业院校(最高学历)：</th>
					<td class="content_02_box_div_table_td">
					   <%=StringUtil.deNull(directoryBean.getNew_zg_byyx())%>&nbsp;
					</td>
					<th class="content_02_box_div_table_th">学位(最高学历)：</th>
					<td class="content_02_box_div_table_td">
                       <%=StringUtil.deNull(new_zg_xw)%>&nbsp;				   
					</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">学历(最高学历)：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(new_zg_xl)%>&nbsp;
					</td>
					<th class="content_02_box_div_table_th">学习形式(最高学历)：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_zg_xingshi())%>&nbsp;
					</td>
					
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th">专业(最高学历)：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_zg_zy())%>&nbsp;
					</td>
					<th class="content_02_box_div_table_th">专业级别(最高学历)：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(new_jb_zy)%>&nbsp;
					</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">毕业时间(最高学历)：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_zg_bydate())%>&nbsp;
					</td>
					<th class="content_02_box_div_table_th">技术职称：</th>
					<td class="content_02_box_div_table_td" >
					    <%=StringUtil.deNull(new_jszc)%>&nbsp;
					</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th">职称获取时间：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_zc_getdate())%>&nbsp;
					</td>
					<th class="content_02_box_div_table_th">职称聘任时间：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_zc_pydate())%>&nbsp;
					</td>
				</tr>
			</table>
		</div> 

			<table class="content_02_box_div_table">
				<tr>
					<td class="content_02_box_title_bg">联系方式</td>
				</tr>
			</table>
			
			<div>
			<table class="content_02_box_div_table" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th class="content_02_box_div_table_th"> 办公手机：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;"><%=StringUtil.deNull(directoryBean.getMobile())%>&nbsp;</td>
					<th class="content_02_box_div_table_th"> 常用手机：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;"><%=StringUtil.deNull(directoryBean.getMobile2())%>&nbsp;</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">办公电话：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getWorkphone())%>&nbsp;</td>
				    <th class="content_02_box_div_table_th">住宅地址：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getHomeadress())%>&nbsp;</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">办公地址：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getWorkadress())%>&nbsp;</td>
					<th class="content_02_box_div_table_th">住宅电话：</th>
					<td class="content_02_box_div_table_td"><%=StringUtil.deNull(directoryBean.getHomephone())%>&nbsp;</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">电子邮箱：</th>
					<td class="content_02_box_div_table_td" colspan="3"><%=StringUtil.deNull(directoryBean.getEmail())%>&nbsp;</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">短号：</th>
					<td class="content_02_box_div_table_td" colspan="3"><%=StringUtil.deNull(directoryBean.getRemark4())%>&nbsp;</td>
					
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
		
		<%--  <table class="content_02_box_div_table">
				<tr>
					<td class="content_02_box_title_bg">保险合同</td>
				</tr>
			</table>
			<div>
			<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th">是否参加的保险：</th>
					<td class="content_02_box_div_table_td">
					    <input type="checkbox" id="hetong_isold_box" name="hetong_isold_box" disabled="disabled"/>&nbsp;养老&nbsp;&nbsp;
					    <input type="hidden" id="hetong_isold" name="hetong_isold" value="0"/>
					    <input type="checkbox" id="hetong_isyl_box" name="hetong_isyl_box" disabled="disabled"/>&nbsp;医疗&nbsp;&nbsp;
					    <input type="hidden" id="hetong_isyl" name="hetong_isyl" value="0"/>
					    <input type="checkbox" id="hetong_issy_box" name="hetong_issy_box" disabled="disabled"/>&nbsp;生育&nbsp;&nbsp;
					    <input type="hidden" id="hetong_issy" name="hetong_issy" value="0"/>
					    <input type="checkbox" id="hetong_isgs_box" name="hetong_isgs_box" disabled="disabled"/>&nbsp;工伤&nbsp;&nbsp;
					    <input type="hidden" id="hetong_isgs" name="hetong_isgs" value="0"/>
					    <input type="checkbox" id="hetong_isshiye_box" name="hetong_isshiye_box" disabled="disabled"/>&nbsp;失业&nbsp;&nbsp;
					    <input type="hidden" id="hetong_isshiye" name="hetong_isshiye" value="0"/>
					</td>
					<th class="content_02_box_div_table_th">合同编号：</th>
					<td class="content_02_box_div_table_td">
                        <input id="hetong_busiid" name="hetong_busiid" style="width:175px" class="input_185" value="<%=heTongBean.getHetong_busiid()%>"/>&nbsp;
                    </td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">合同类别：</th>
					<td class="content_02_box_div_table_td" style="width: 190px;"><%=hetongtype %>&nbsp;</td>
					<th class="content_02_box_div_table_th">08年后劳动合同签订次数：</th>
					<td class="content_02_box_div_table_td"><%=heTongBean.getHetong_number() %>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">首次合同签订日期：</th>
					<td class="content_02_box_div_table_td" colspan="3" ><%=heTongBean.getHetong_first_date()%>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">现合同起始期：</th>
					<td class="content_02_box_div_table_td"><%=heTongBean.getHetong_nowstart_date()%>&nbsp;</td>
					<th class="content_02_box_div_table_th">现合同终止期：</th>
					<td class="content_02_box_div_table_td"><%=heTongBean.getHetong_nowsend_date()%>&nbsp;</td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">合同试用起始期：</th>
					<td class="content_02_box_div_table_td"><%=heTongBean.getHetong_trystart_date()%>&nbsp;</td>
					<th class="content_02_box_div_table_th">合同试用终止期：</th>
					<td class="content_02_box_div_table_td"><%=heTongBean.getHetong_tryend_date()%>&nbsp;
					</td>					
				</tr>

			</table>
			</div> --%>
			
		<%--  <%if((!StringUtil.isBlank(peizhiUserIds)) && (peizhiUserIds.indexOf((typeid+","))>-1)){ %>
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
                        <%=StringUtil.deNull(directoryBean.getNew_xc_gwgz())%>&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">薪级工资：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_xjgz())%>&nbsp;
                    </td>
				</tr>

				<tr>
					<th class="content_02_box_div_table_th">应发合计：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_yfgz())%>&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">医保：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_yb())%>&nbsp;
                    </td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">养老保险：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_ylbx())%>&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">失业保险：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_sybx())%>&nbsp;
                    </td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">公积金：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_gjj())%>&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">补扣：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_cb())%>&nbsp;
                    </td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">扣款合计：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_cbhj())%>&nbsp;
                    </td>
					<th class="content_02_box_div_table_th">实发合计：</th>
					<td class="content_02_box_div_table_td">
						<%=StringUtil.deNull(directoryBean.getNew_xc_sfhj())%>&nbsp;
                    </td>
				</tr>

			</table>
			</div>
		     <%} %>  --%>
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