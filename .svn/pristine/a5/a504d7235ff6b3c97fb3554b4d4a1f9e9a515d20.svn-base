
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.ElectDaoImpl"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.service.impl.ElectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.impl.ResouceConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoBean"%>

<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBean"%>
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import ="java.util.Map"%>
<%@ page contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>JGRID</title>

<%
		AccessControl accesscontroler = AccessControl.getAccessControl();
		accesscontroler.checkAccess(request, response);
		String userid=accesscontroler.getUserID();
		String username = accesscontroler.getUserName();
		String userAccout = accesscontroler.getUserAccount();
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		ResourceConfigDao resourceRoleConfigDao = new ResouceConfigDaoImpl();
		ResourceRoleUserBean rruBean = resourceRoleConfigDao.queryUserMatchOrg(userid);
		String orgname=rruBean.getOrgname();
		String orgid=rruBean.getOrgid();
		boolean flag = true;
		String dept_id=accesscontroler.getChargeOrgId();
		String dept_name=accesscontroler.getChargeOrgName();
		String end_ip = request.getParameter("end_ip");
		String end_time = request.getParameter("end_time");
		String date_time=request.getParameter("datetime");
		String rest_time=request.getParameter("rest_time");
		ElectInfoBean electInfoBean = new ElectInfoBean();
		ElectInfoBean electInfoBean1 = new ElectInfoBean();
		ElectResetBean electResetBean = new ElectResetBean();
		electInfoBean.setDept_id(dept_id);
		electInfoBean.setDept_name(dept_name);
		electInfoBean.setReset_time(rest_time);
		electInfoBean.setDatetime(date_time);
		electInfoBean.setEnd_time(end_time);
		
		electInfoBean.setOrgid(orgid);
		electInfoBean.setOrgname(orgname);
		electInfoBean.setUserid(userid);
		electInfoBean.setUsername(username);
		electInfoBean.setReset_time(rest_time);
		electInfoBean.setEnd_ip(end_ip);
		ElectInfoDao poeManagerDao = (ElectInfoDao)DaoImplClassUtil.getDaoImplClass("electInfoDaoImpls");
		ElectDaoImpl dao = new ElectDaoImpl();
		electInfoBean1= poeManagerDao.isAddOrUpdate(electInfoBean);//获得基本信息上班时间
		electResetBean=dao.querySetRecord(userid);//获得设置时间的上下班时间
		//获知打卡状态
		ElectServiceImpl electdaoimpl= new ElectServiceImpl();		
		String strtime = StringUtil.deNull(electInfoBean1.getStart_time()) + " " +electInfoBean.getEnd_time() ;
		
		//add by tieshan.he 判断是否是半天假
		Map<String,String> map = null;
		boolean isHalf = false;
		map = poeManagerDao.ishalfDay(userAccout);
		if(map.size()>0 && "1".equals(map.get("date_type"))){
			isHalf = true;
		}
		if(isHalf){
			electInfoBean.setState(electdaoimpl.judgeHalfState(userid,date_time+"",strtime,"",map.get("title"),map.get("type")));
		}else{
			electInfoBean.setState(electdaoimpl.judgeState(userid,date_time+"",strtime,""));
		}
		poeManagerDao.updateEndTime(electInfoBean);//更新上班状态下班未打卡
		
	
%>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript"
			src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=flag%>){
	mes = "操作成功"; 
}else{
	mes = "操作失败"	;
	bool = false;
}
var ok=function(){
	window.parent.location.reload();
}
if(removeAlertWindows('',false,bool,mes,true)){
	if(bool){
		window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
	}
	else{
		window.top.alert(mes)
	}
}
</script>
<body>
</body> 
</html>