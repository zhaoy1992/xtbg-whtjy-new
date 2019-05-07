<%--
描述：车辆司机信息处理页面
作者：童佳
版本：1.0
日期：2013-10-25
--%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarDrivaerServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.CarDriverService"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.DriverBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.chinacreator.security.AccessControl"%>

<%@ page contentType="text/html; charset=GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>

<html>
<head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script> 

<!-- 引入其它 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<title>车辆司机信息处理页面</title>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String method = StringUtil.deNull(request.getParameter("method"));
	String subid = request.getParameter("subid");	
	
	String driver_id = request.getParameter("driver_id");
	String driver_name = request.getParameter("driver_name");
	String driver_sex = request.getParameter("driver_sex");
	String driver_car_no = request.getParameter("driver_car_no");
	String driver_org_id = request.getParameter("driver_org_id");
	String driver_org_name = request.getParameter("driver_org_name");
	String driver_berdate = request.getParameter("driver_ber_date");
	String driver_sort_id = request.getParameter("driver_sort_id");
	String driver_no = request.getParameter("driver_no");
	String driver_cardate = request.getParameter("driver_car_date");
	String driver_photo = request.getParameter("driver_photo");
	String driver_tel = request.getParameter("driver_tel");
	String driver_indate = request.getParameter("driver_in_date");
	String driver_outdate = request.getParameter("driver_out_date");
	String driver_fj_id = request.getParameter("driver_fj_id");
	String driver_bz = request.getParameter("driver_bz");
	String driver_ids = request.getParameter("driver_ids");
	
	
	
	DriverBean driverBean = new DriverBean();
	
	
	if(!StringUtil.isBlank(driver_id)){
		driverBean.setDriver_id(driver_id);
	}
	
	Timestamp  driver_ber_date;
	Timestamp  driver_car_date;
	Timestamp  driver_in_date;
	Timestamp  driver_out_date;
	DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	if(!StringUtil.isBlank(driver_berdate)){
		driver_ber_date = new Timestamp(sdf.parse(driver_berdate).getTime());
		driverBean.setDriver_ber_date(driver_ber_date);
	}
	if(!StringUtil.isBlank(driver_cardate)){
		driver_car_date = new Timestamp(sdf.parse(driver_cardate).getTime());
		driverBean.setDriver_car_date(driver_car_date);
	}
	if(!StringUtil.isBlank(driver_indate)){
		driver_in_date = new Timestamp(sdf.parse(driver_indate).getTime());
		driverBean.setDriver_in_date(driver_in_date);
	}
	if(!StringUtil.isBlank(driver_outdate)){
		driver_out_date = new Timestamp(sdf.parse(driver_outdate).getTime());
		driverBean.setDriver_out_date(driver_out_date);
	}
	
	driverBean.setDriver_name(driver_name);
	driverBean.setDriver_sex(driver_sex);
	driverBean.setDriver_car_no(driver_car_no);
	driverBean.setDriver_org_id(driver_org_id);
	driverBean.setDriver_org_name(driver_org_name);
	driverBean.setDriver_sort_id(driver_sort_id);
	driverBean.setDriver_no(driver_no);
	driverBean.setDriver_photo(driver_photo);
	driverBean.setDriver_tel(driver_tel);
	driverBean.setDriver_fj_id(driver_fj_id);
	driverBean.setDriver_bz(driver_bz);
	
	boolean flag = false;
	CarDriverService carDriverService = new CarDrivaerServiceImpl();
	if("add".equals(method)){
		flag = carDriverService.insertDriver(driverBean);
	}else if("update".equals(method)){
		flag = carDriverService.updateDriver(driverBean);
	}else if("del".equals(method)){
		flag = carDriverService.deleteDriver(driverBean, driver_ids);
	}
	
%>
<script type="text/javascript">
var mes = "";
var bool = true;
<% if("del".equals(method)){%>
if(<%=flag%>){
	mes = "操作成功"; 
	  var submitAlertOK = function(){
		  if(removeWindows('<%=subid%>',true,false,true)){
	    		window.parent.location.reload();
	    	  }
	       }
	    	var p={
	    			headerText:'操作信息',
	    			okName:'确认',
	    	        okFunction:submitAlertOK
	    	};
	    	alert('操作成功',p);
	    	 //window.top.getIFrameDOM("_document_body_mian_firstPagerAAAS").location.reload();
}else{
	mes = "操作失败"	;
	bool = false;
}
<% }else{%>
if(<%=flag%>){
	mes = "操作成功"; 
	  var submitAlertOK = function(){
		  if(removeWindows('<%=subid%>',true,false,true)){
			  window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
	    	  }
	       }
	    	var p={
	    			headerText:'操作信息',
	    			okName:'确认',
	    	        okFunction:submitAlertOK
	    	};
	    	alert('操作成功',p);
	    	 //window.top.getIFrameDOM("_document_body_mian_firstPagerAAAS").location.reload();
}else{
	mes = "操作失败"	;
	bool = false;
}
<%}%>

</script>
<body>
</body> 
</html>