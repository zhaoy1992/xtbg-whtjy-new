<%--
描述：名录管理更新用户信息
作者：戴连春
日期：2013-06-13
 --%>
 <%@page import="com.chinacreator.xtbg.core.directory.entity.HeTongBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page	import="com.chinacreator.xtbg.core.directory.entity.UserinfoBean"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.*"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.impl.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	
	UserinfoBean userinfoBean = new UserinfoBean();
	userinfoBean.setUserid(request.getParameter("userid"));
	userinfoBean.setUserIdcard(request.getParameter("userIdcard"));
	userinfoBean.setUserRealname(request.getParameter("userRealname"));
	userinfoBean.setUserSex(request.getParameter("userSex"));
	userinfoBean.setUserBirthday(request.getParameter("userBirthday"));
	userinfoBean.setUserMobiletel1(request
			.getParameter("userMobiletel1"));
	userinfoBean.setUserMobiletel2(request
			.getParameter("userMobiletel2"));
	userinfoBean.setMail(request.getParameter("mail"));
	userinfoBean.setHomePhone(request.getParameter("homePhone"));
	userinfoBean.setUserWorktel(request.getParameter("userWorktel"));

	userinfoBean.setNation(request.getParameter("nation"));
	userinfoBean.setNatives(request.getParameter("natives"));
	userinfoBean.setPolitics(request.getParameter("politics"));
	userinfoBean.setDuties(request.getParameter("duties"));
	userinfoBean.setDirectorylevel(request
			.getParameter("directorylevel"));
	userinfoBean.setNumberOne(request.getParameter("numberOne"));
	userinfoBean.setSchool(request.getParameter("school"));
	userinfoBean.setDegree(request.getParameter("degree"));
	userinfoBean.setEducation(request.getParameter("education"));
	userinfoBean.setWorktime(request.getParameter("worktime"));
	userinfoBean.setDirectorystate(request
			.getParameter("directorystate"));
	userinfoBean.setJoinparttime(request.getParameter("joinparttime"));
	userinfoBean.setDuty(request.getParameter("duty"));
	userinfoBean.setResume(request.getParameter("resume"));
	userinfoBean.setHomeadress(request.getParameter("homeadress"));
	
	userinfoBean.setRemark4(request.getParameter("remark4"));  //短号
	
	userinfoBean.setNew_user_type(request.getParameter("new_user_type"));
	userinfoBean.setNew_job_state(request.getParameter("new_job_state"));
	userinfoBean.setNew_job_no(request.getParameter("new_job_no"));
	userinfoBean.setNew_job_set(request.getParameter("new_job_set"));
	userinfoBean.setNew_join_zzdate(request.getParameter("new_join_zzdate"));
	userinfoBean.setNew_in_hosb(request.getParameter("new_in_hosb"));
	userinfoBean.setNew_toother_date(request.getParameter("new_toother_date"));
	userinfoBean.setNew_first_xingshi(request.getParameter("new_first_xingshi"));
	userinfoBean.setNew_first_zy(request.getParameter("new_first_zy"));
	userinfoBean.setNew_first_bydate(request.getParameter("new_first_bydate"));
	userinfoBean.setNew_zg_byyx(request.getParameter("new_zg_byyx"));
	userinfoBean.setNew_zg_xl(request.getParameter("new_zg_xl"));
	userinfoBean.setNew_zg_xw(request.getParameter("new_zg_xw"));
	userinfoBean.setNew_zg_xingshi(request.getParameter("new_zg_xingshi"));
	userinfoBean.setNew_zg_zy(request.getParameter("new_zg_zy"));
	userinfoBean.setNew_jb_zy(request.getParameter("new_jb_zy"));
	userinfoBean.setNew_zg_bydate(request.getParameter("new_zg_bydate"));
	userinfoBean.setNew_jszc(request.getParameter("new_jszc"));
	userinfoBean.setNew_zc_getdate(request.getParameter("new_zc_getdate"));
	userinfoBean.setNew_zc_pydate(request.getParameter("new_zc_pydate"));
	//离职日期
	userinfoBean.setLeavetime(request.getParameter("leavetime"));
	//特检院 OA  追加 薪酬信息 start
	userinfoBean.setNew_xc_gwgz(request.getParameter("new_xc_gwgz"));
	userinfoBean.setNew_xc_xjgz(request.getParameter("new_xc_xjgz"));
	userinfoBean.setNew_xc_yfgz(request.getParameter("new_xc_yfgz"));
	userinfoBean.setNew_xc_yb(request.getParameter("new_xc_yb"));
	userinfoBean.setNew_xc_ylbx(request.getParameter("new_xc_ylbx"));
	userinfoBean.setNew_xc_sybx(request.getParameter("new_xc_sybx"));
	userinfoBean.setNew_xc_gjj(request.getParameter("new_xc_gjj"));
	userinfoBean.setNew_xc_cb(request.getParameter("new_xc_cb"));
	userinfoBean.setNew_xc_cbhj(request.getParameter("new_xc_cbhj"));
	userinfoBean.setNew_xc_sfhj(request.getParameter("new_xc_sfhj"));
	//特检院 OA  追加 薪酬信息  end
	HeTongBean heTongBean = new HeTongBean();
	heTongBean.setHetong_isold(request.getParameter("hetong_isold"));
	heTongBean.setHetong_isyl(request.getParameter("hetong_isyl"));
	heTongBean.setHetong_issy(request.getParameter("hetong_issy"));
	heTongBean.setHetong_isgs(request.getParameter("hetong_isgs"));
	heTongBean.setHetong_isshiye(request.getParameter("hetong_isshiye"));
	heTongBean.setHetong_isydwgm(request.getParameter("hetong_ydwgm"));
	heTongBean.setHetong_type(request.getParameter("hetong_type"));
	heTongBean.setHetong_number(request.getParameter("hetong_number"));
	heTongBean.setHetong_first_date(request.getParameter("hetong_first_date"));
	heTongBean.setHetong_nowstart_date(request.getParameter("hetong_nowstart_date"));
	heTongBean.setHetong_nowsend_date(request.getParameter("hetong_nowsend_date"));
	heTongBean.setHetong_trystart_date(request.getParameter("hetong_trystart_date"));
	heTongBean.setHetong_tryend_date(request.getParameter("hetong_tryend_date"));
	heTongBean.setHetong_busiid(request.getParameter("hetong_busiid"));
	
	
	
	DirectoryServiceIfc service = new DirectoryServiceImpl();
	service.updateUserinfo(userinfoBean, heTongBean);
%>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script language="javascript">
var mes = "操作成功";
var bool = true;
var ok=function(){
	/* window.parent.location.reload(); */
	if(getParentWindow('windowId').userSearch){
		getParentWindow('windowId').userSearch();
	}
}
if(!window.top.removeAlertWindows('',false,bool,mes,false)){
	if(bool){
		ok();
	}
	else{
		window.top.alert(mes)
	}
}
</script>