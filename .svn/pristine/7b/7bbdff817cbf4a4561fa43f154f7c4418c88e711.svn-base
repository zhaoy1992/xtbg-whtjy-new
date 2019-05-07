
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectResetBeanXt"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.service.impl.ElectViewServiceImpl"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.service.ElectViewServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.impl.ResouceConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao"%>
<%@page import="com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectResetDao"%>
<%@page import="com.chinacreator.eform.util.Escape"%>

<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String userid=accesscontroler.getUserID();
String ids=request.getParameter("ids");
String action =request.getParameter("action");
String username = accesscontroler.getUserName();
String orgname=request.getParameter("orgname");
String orgid=request.getParameter("orgid");
String reset_time=request.getParameter("reset_time");
String start_time=request.getParameter("start_time");
String end_time=request.getParameter("end_time");
String isauto=request.getParameter("isauto");
String isuse=request.getParameter("isuse");
String am_end_time=request.getParameter("am_end_time");
String pm_start_time=request.getParameter("pm_start_time");
String[] allkey={"elect_id"};
ElectResetBeanXt electResetInfoBean = new ElectResetBeanXt("SX_TA_OA_ELECTCHECK",allkey);
electResetInfoBean.setRest_time(reset_time);
electResetInfoBean.setEnd_time(end_time);
electResetInfoBean.setStart_time(start_time);
electResetInfoBean.setAuto_check(isauto);
electResetInfoBean.setOrgid(orgid);
electResetInfoBean.setOrgname(orgname);
electResetInfoBean.setUserid(userid);
electResetInfoBean.setUsername(username);
electResetInfoBean.setAm_end_time(am_end_time);
electResetInfoBean.setPm_start_time(pm_start_time);
ElectViewServiceIfc electViewServiceIfc=new ElectViewServiceImpl(); 
boolean flag=true;
try{
	if("save".equals(action)){
		electViewServiceIfc.saveset(electResetInfoBean);
	}else if("del".equals(action)){
		electViewServiceIfc.del(ids);
	}
	
}catch(Exception e){
	e.printStackTrace();
	flag=false;
}




%>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript"
			src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var flag="<%=flag%>";
if(flag=="true"){
	var mes = "";
	var bool = true;
	alert("操作成功!");
 	window.parent.location.href="electsetlist.jsp";
}else{
	alert("操作失败!");
}
	
    

</script>
<body>
</body> 
</html>