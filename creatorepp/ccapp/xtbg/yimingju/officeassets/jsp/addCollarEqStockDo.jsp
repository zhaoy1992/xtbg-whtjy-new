<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.CollarStockDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.OfficeStockDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.OfficeStockDaoImple"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.CollarStockDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.CollarBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeStocklistBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.security.AccessControl"%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>办公设备 领用登记单form</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	//获得当前登录用户id
	String userid = accesscontroler.getUserID();
	boolean flag = true;
	request.setCharacterEncoding("UTF-8");
	String windowsId = request.getParameter("widowsid");
	//领用人ID
	String user_id = request.getParameter("user_id");
	//领用人
	String user_name = request.getParameter("collar_user");
	//领用部门ID
	String org_id = request.getParameter("org_id");
	//领用部门名称
	String org_name = request.getParameter("org_name");
	//领用时间
	String apply_date = request.getParameter("apply_date");
	//库存ID
	String[] stock_ids=request.getParameterValues("stock_id");
	//设备名称
	String[] equipment_name  =request.getParameterValues("equipment_name");
	//设备编号
	String []equipment_nos= request.getParameterValues("equipment_no");
	//类别ID
	String [] type_id = request.getParameterValues("type_id");
	//类别名称
	String[] type_name = request.getParameterValues("type_name");
	//备注
	String remark = request.getParameter("remark");
	List<CollarBean> collarBeans = new ArrayList<CollarBean>();
	CollarStockDao  collarStockDao = (CollarStockDao)new CollarStockDaoImpl();
	OfficeStockDao  officeStockDao = (OfficeStockDao)new OfficeStockDaoImple();
	try{
		  for(int i=0;i<stock_ids.length;i++){
			 CollarBean collarBean= new CollarBean();
			 collarBean.setCollar_user(user_id);
			 collarBean.setCollar_userName(user_name);
			 collarBean.setCollar_depart(org_id);
			 collarBean.setCollar_departName(org_name);
			 collarBean.setCollar_date(apply_date);
			 collarBean.setStock_Id(stock_ids[i]);
			 collarBean.setRemark(remark);
			//领用人
			 collarBean.setCollar_userName(user_name);
			 //操作人
			 collarBean.setAction_name(accesscontroler.getUserName());
			 //操作
			 collarBean.setAction("领用");
			 //设备类别ID
			 collarBean.setEq_typeId(type_id[i]);
			 //设备类别名称
			 collarBean.setEq_type(type_name[i]);
			 //设备编号
			 collarBean.setEq_no(equipment_nos[i]);
			 //设备名称
			 collarBean.setEq_name(equipment_name[i]);
			 //库存状态
			 collarBean.setState("2");
			 //领用状态
			 collarBean.setCollarState("2");
			 
			 collarBeans.add(collarBean);
		  }
		  
		  //领用
		  collarStockDao.addToBean(collarBeans);
		  //修改库存
		  collarStockDao.updateStockBean(collarBeans);
		  
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