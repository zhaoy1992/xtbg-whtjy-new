<%@page import="com.chinacreator.xtbg.pub.util.BeanUtil"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.entity.IbraryBookInfoBean"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.impl.IbraryBookInfoServiceImpl"%>
<%@page import="com.chinacreator.xtbg.caizhengting.ibrary.service.IbraryBookInfoService"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.caizhengting.press.service.PressService"%>
<%@page import="com.chinacreator.xtbg.caizhengting.press.service.impl.PressServiceImpl"%>
<%@page import="com.chinacreator.xtbg.caizhengting.press.entity.PressBean"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
 <title>
 </title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID();
	String user_orgid = accesscontroler.getChargeOrgId();
	String path = request.getContextPath();
	String logUserTime = DateUtil.getCurrentDateTime();//最近更新时间为录入时间
	String accessory = request.getParameter("accessory");
	BeanUtil<IbraryBookInfoBean> beanUtil = new BeanUtil<IbraryBookInfoBean>();
	IbraryBookInfoBean bean = beanUtil.requestToBean(request,IbraryBookInfoBean.class);
	bean.setAccessory(accessory);
	String action = request.getParameter("actiontype");
	String id = request.getParameter("book_id"); //copy ID 
	String[] ids = request.getParameter("book_id").split(","); //删除ID 
	
	
	PressService pressService = new PressServiceImpl();
	
	String book_id = request.getParameter("book_id");
	IbraryBookInfoService service = new IbraryBookInfoServiceImpl();
	String flag = "";
	if("insert".equals(action)) {
		flag = service.addbookinfo(bean);
	} else if("update".equals(action)){
		flag = service.updatebookinfo(bean);
	} else if("del".equals(action)) {
		flag = service.delbookinfo(ids);
	} else if("copy".equals(action)) {
		IbraryBookInfoBean copybean = new IbraryBookInfoBean();
		copybean.setBooker_date(logUserTime);
		copybean.setBooker_id(user_id);
		copybean.setBooker_dept_id(user_orgid);
		copybean.setBook_id(id);
		flag = service.copybookinfo(copybean);
	}
%>
<script type="text/javascript">
var mes = "<%=flag%>";
var bool = true;
if(mes=="操作失败"){
   bool = false;
}
var ok=function(){
	window.parent.parent.location.href="<%=path%>/ccapp/xtbg/caizhengting/ibrary/jsp/ibrarybookrindex.jsp";
}
if(window.top.removeAlertWindows('',false,bool,mes,true)){
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
