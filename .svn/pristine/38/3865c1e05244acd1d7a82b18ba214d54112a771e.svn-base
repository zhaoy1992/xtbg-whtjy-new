
<%@page import="com.chinacreator.sysmgrcore.manager.db.UserManagerImpl"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.chinacreator.sysmgrcore.entity.UserAndSn"%>
<%@page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.xtbg.pub.directory.dao.DirectoryDao"%>
<%@page import="com.chinacreator.xtbg.pub.directory.dao.imploracle.DirectoryDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.directory.entity.UserinfoBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.DirectoryServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.directory.service.impl.DirectoryServiceImpl"%>
<%
/*
 * <p>Title: 更新用户信息主页面</p>
 * <p>Description: 更新用户信息主页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-21
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=utf-8"%>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.sql.Date" %>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>


<%
	
	String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
	AccessControl accesscontroler = AccessControl.getInstance();	
	if("431003".equals(userArea)){
		accesscontroler.checkAccess(request, response);
	} else if("421005".equals(userArea)){
		accesscontroler.checkAccess(request, response);	//望城不需要角色权限
	} else{
		accesscontroler.checkManagerAccess(request,response); 
	}
    DirectoryDao directoryDao = new DirectoryDaoImpl();
    UserinfoBean userinfoBean = new UserinfoBean();
    User user=new User();
    UserAndSn userAndSn =new UserAndSn();
    if("421005".equals(userArea)){
    		//td_sm_user表字段
    		user.setUser_id(request.getParameter("userid"));
    		user.setUserRealname(request.getParameter("userrealname"));
    		user.setUserSex(request.getParameter("sex"));
    		user.setUserMobiletel1(request.getParameter("user_mobiletel1"));
    		user.setUserWorktel(request.getParameter("user_worktel"));
    		user.setUserHometel(request.getParameter("user_hometel"));
    		user.setUser_email(request.getParameter("email"));
    		System.out.println(request.getParameter("email"));
    		user.setUserPostalcode(request.getParameter("postalcode"));
    		user.setUserAddress(request.getParameter("homeadress"));
    		user.setUserIdcard(request.getParameter("idcard"));
    		user.setUser_fax(request.getParameter("fax"));
    		//ta_oa_userandsn表字段
    		userAndSn.setUsernumber(request.getParameter("usernumber"));
    		userAndSn.setOldusername(request.getParameter("oldusername"));
    		userAndSn.setNation(request.getParameter("nation"));
    		userAndSn.setNatives(request.getParameter("natives"));
    		userAndSn.setPolitics(request.getParameter("politics"));
    		userAndSn.setEducation(request.getParameter("education"));
    		userAndSn.setIsmarry(request.getParameter("ismarry"));
    		userAndSn.setDegree(request.getParameter("degree"));
    		userAndSn.setSpecialty(request.getParameter("specialty"));
    		userAndSn.setSchool(request.getParameter("school"));
    		userAndSn.setWorktime(request.getParameter("worktime"));
    		userAndSn.setDuties(request.getParameter("duties"));
    		userAndSn.setJointime(request.getParameter("jointime"));
    		userAndSn.setUserfilespace(request.getParameter("userfilespace"));
    		userAndSn.setLanguagelevel(request.getParameter("languagelevel"));
    		userAndSn.setLanguagetype(request.getParameter("languagetype"));
    		userAndSn.setUsertype(request.getParameter("usertype"));
    		userAndSn.setResume(request.getParameter("resume"));
    		userAndSn.setFamilymembers(request.getParameter("familymembers"));
    		userAndSn.setBirthday(request.getParameter("birthday"));
    		userAndSn.setTitles(request.getParameter("titles"));
    		userAndSn.setTitletype(StringUtil.deNull(request.getParameter("titletype")));
    		userAndSn.setNativesaddress(StringUtil.deNull(request.getParameter("nativesaddress")));
    		userAndSn.setCertificate(request.getParameter("certificate"));
    		userAndSn.setRemark(request.getParameter("remark"));
    		userAndSn.setPicid(request.getParameter("attachmentid"));
    		userAndSn.setAttachmentid(request.getParameter("attachmentid"));
    		
    		userAndSn.setHealth_state(request.getParameter("health_state"));
    		userAndSn.setBlood_type(request.getParameter("blood_type"));
    		userAndSn.setStature(request.getParameter("stature"));
    		userAndSn.setVision(request.getParameter("vision"));
    		
    		String userData = request.getParameter("userdata");
    		
    		user.setUserAndSn(userAndSn);
    		//directoryDao.updateUserinfowc(user);
    		DirectoryServiceIfc directoryServiceIfc = new DirectoryServiceImpl();
    		directoryServiceIfc.updateUserinfowc(user,userData);
    }else{
    	    userinfoBean.setUserid(request.getParameter("userid")) ;
    	    userinfoBean.setUserIdcard(request.getParameter("userIdcard")) ;
    	    userinfoBean.setUserRealname(request.getParameter("userRealname")) ;
    	    userinfoBean.setUserSex(request.getParameter("userSex")) ;
    	    userinfoBean.setUserBirthday(request.getParameter("userBirthday")) ;
    	    userinfoBean.setUserMobiletel1(request.getParameter("userMobiletel1")) ;
    	    userinfoBean.setUserMobiletel2(request.getParameter("userMobiletel2")) ;
    	    userinfoBean.setMail(request.getParameter("mail")) ;
    	    userinfoBean.setHomePhone(request.getParameter("homePhone")) ;
    	    userinfoBean.setUserWorktel(request.getParameter("userWorktel"));
    	    
    		 userinfoBean.setNation(request.getParameter("nation"));
    		 userinfoBean.setNatives(request.getParameter("natives"));
    		 userinfoBean.setPolitics(request.getParameter("politics"));
    		 userinfoBean.setDuties(request.getParameter("duties"));
    		 userinfoBean.setDirectorylevel(request.getParameter("directorylevel"));
    		 userinfoBean.setNumberOne(request.getParameter("numberOne"));
    		 userinfoBean.setSchool(request.getParameter("school"));
    		 userinfoBean.setDegree(request.getParameter("degree"));
    		 userinfoBean.setEducation(request.getParameter("education"));
    		 userinfoBean.setWorktime(request.getParameter("worktime"));
    		 userinfoBean.setDirectorystate(request.getParameter("directorystate"));
    		 userinfoBean.setJoinparttime(request.getParameter("joinparttime"));
    		 userinfoBean.setDuty(request.getParameter("duty"));
    		 userinfoBean.setResume(request.getParameter("resume"));
    		 userinfoBean.setHomeadress(request.getParameter("homeadress"));
    		 directoryDao.updateUserinfo(userinfoBean);
    }
%>

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