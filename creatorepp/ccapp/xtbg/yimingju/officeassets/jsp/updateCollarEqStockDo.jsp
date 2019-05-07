<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.CollarStockDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.CollarStockDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.OfficeStockDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.OfficeStockDaoImple"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.CollarBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeStock"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeStocklistBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.security.AccessControl"%>	
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>办公设备领用库存form</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	//获得当前登录用户id
	String userid = accesscontroler.getUserID();
	boolean flag = true;
	request.setCharacterEncoding("UTF-8");
	String windowsId = request.getParameter("widowsid");
	//库存ID
	String stock_ids=request.getParameter("stock_Id");
	//状态
	String state = request.getParameter("state");
	//当前时间
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
	String time= format.format(new Date());
	CollarStockDao  collarStockDao = (CollarStockDao)new CollarStockDaoImpl();
	OfficeStockDao  officeStockDao = (OfficeStockDao)new OfficeStockDaoImple();
	try{
			List<CollarBean> collarBeans = new ArrayList<CollarBean>();
			 CollarBean collarBean= new CollarBean();
			 collarBean.setStock_Id(stock_ids);
			 collarBean.setState(state);
			 collarBean.setCollarState(state);
			 
			//查找设备库存信息
			OfficeStock officeStock= officeStockDao.getTypeBeanById(stock_ids);
			
		 	//领用人
		 	collarBean.setCollar_userName("");
		 	//操作人
		 	collarBean.setAction_name(accesscontroler.getUserName());
		 	//操作
		 	if("1".equals(state)){
		 		collarBean.setAction("归还");
		 	}else{
		 		collarBean.setAction("报废");
		 	}
		 	//设备类别ID
		 	collarBean.setEq_typeId(officeStock.getType_id());
		 	//设备类别名称
		 	collarBean.setEq_type(officeStock.getType_name());
		 	//设备编号
		 	collarBean.setEq_no(officeStock.getEquipment_no());
		 	//设备名称
		 	collarBean.setEq_name(officeStock.getEquipment_name());
		 	//日期
		 	collarBean.setCollar_date(time);
		 	collarBean.setStock_Id(stock_ids);
		 
			collarBeans.add(collarBean);
			//修改库存
			collarStockDao.updateStockBean(collarBeans);
			//删除领用信息
			collarStockDao.deleteStockApply(collarBeans);
	}catch(Exception e){
		e.printStackTrace();
		flag=false;
	}
%>
<script type="text/javascript"
			src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
</head>
<body>
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
	removeWindows('<%=StringUtil.deNull(request.getParameter("widowsid"))%>',true,false,true);
}
if(bool){
	window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
}
else{
	window.top.alert(mes);
}
</script>
</body>
</html>