
<%@page import="java.util.UUID"%>
<%@page import="com.chinacreator.xtbg.core.directory.entity.WorkIPBean"%>
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
	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
	ResourceConfigDao resourceRoleConfigDao = new ResouceConfigDaoImpl();
	ResourceRoleUserBean rruBean = resourceRoleConfigDao.queryUserMatchOrg(userid);
	String orgname=rruBean.getOrgname();
	String orgid=rruBean.getOrgid();

	String dept_id=accesscontroler.getChargeOrgId();
	String dept_name=accesscontroler.getChargeOrgName();
	String workip_id = request.getParameter("workip_id");
	String workip_start_ip = request.getParameter("workip_start_ip");
	String workip_end_ip=request.getParameter("workip_end_ip");
	String workip_remark = request.getParameter("workip_remark");
	String dowhat=request.getParameter("dowhat");
	
	String ids = request.getParameter("ids");
	
	WorkIPBean workIPBean = new WorkIPBean();
	workIPBean.setWorkip_start_ip(workip_start_ip);
	workIPBean.setWorkip_end_ip(workip_end_ip);
	workIPBean.setWorkip_remark(workip_remark);
	
	boolean flag = false;
	
	ElectInfoDao poeManagerDao = (ElectInfoDao)DaoImplClassUtil.getDaoImplClass("electInfoDaoImpls");
	
	if("addorupdate".equals(dowhat)){
		if(StringUtil.isBlank(workip_id)){
			workIPBean.setWorkip_id(UUID.randomUUID().toString());
			poeManagerDao.insertWorkIPBean(workIPBean);
			flag = true;
		}else{
			workIPBean.setWorkip_id(workip_id);
			poeManagerDao.updateWorkIPBean(workIPBean);
			flag = true;
		}
	}else if("delete".equals(dowhat)){
		flag = poeManagerDao.deleteWorkIPBean(ids);
	}
	
	
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
if("delete" == "<%=dowhat%>"){
	window.parent.location.reload();
}else{
	if(removeAlertWindows('',false,bool,mes,true)){
		if(bool){
			window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
		}
		else{
			window.top.alert(mes)
		}
	}
}
</script>
<body>
</body> 
</html>