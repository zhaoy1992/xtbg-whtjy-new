<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.OfficeStockDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.OfficeEquipmentTypeDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.OfficeStockDaoImple"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.OfficeEquipmentTypeDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeStocklistBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeStock"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeEquipmentTypeBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.security.AccessControl"%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>办公设备 采购入库单form</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
	//获得当前登录用户id
	String userid = accesscontroler.getUserID();
	boolean flag = true;
	request.setCharacterEncoding("UTF-8");
	String action = request.getParameter("action");
	String windowsId = request.getParameter("widowsid");
	OfficeStockDao  officeStockDao = (OfficeStockDao)new OfficeStockDaoImple();
	try{
		//办公设备入库
		if("add".equals(action)){
			//入库时间
			String stock_date = request.getParameter("stock_data");
			//类别ID
			String[] type_ids = request.getParameterValues("type_ids");
			//设备名称
			String[] equipment_names = request.getParameterValues("equipment_name");
			//设备编号
			String[] equipment_nos  =request.getParameterValues("equipment_no");
			//型号
			String [] equipment_models = request.getParameterValues("equipment_model");
			//价格
			String[] equipment_prices = request.getParameterValues("equipment_price");
			//供货厂商
			String [] suppliers = request.getParameterValues("suppliers");
			//销售电话
			String [] service_phones =request.getParameterValues("service_phone");
			//设备采购编号
			String [] goodsids =request.getParameterValues("goodsid");
			//备注
			String remark = request.getParameter("remark");
			
			OfficeEquipmentTypeDao officeEquipmentTypeDao =(OfficeEquipmentTypeDao)new OfficeEquipmentTypeDaoImpl();
			//库存
			List<OfficeStock> listOfficeStocks = new ArrayList<OfficeStock>();
			//库存明细
			List<OfficeStocklistBean> listOfficeStocklistBeans = new ArrayList<OfficeStocklistBean>();
				for(int i=0;i<type_ids.length;i++){
					    	OfficeStock officeStock= new OfficeStock();
					 		officeStock.setStock_data(stock_date);
					 		officeStock.setStock_applyer(userid);
					 		officeStock.setRemark(remark);
					 		officeStock.setType_id(type_ids[i]);
					 		OfficeEquipmentTypeBean officeEquipmentTypeBean= (OfficeEquipmentTypeBean)officeEquipmentTypeDao.getTypeBeanById(type_ids[i]);
					 		officeStock.setType_name(officeEquipmentTypeBean.getOetype_name());
					 		officeStock.setEquipment_name(equipment_names[i]);
					 		officeStock.setEquipment_no(equipment_nos[i]);
					 		officeStock.setEquipment_model(equipment_models[i]);
					 		officeStock.setSuppliers(suppliers[i]);
					 		officeStock.setService_phone(service_phones[i]);
					 		officeStock.setEquipment_price(equipment_prices[i]);
							if("410003".equals(userArea)){
								officeStock.setGoodsid(goodsids[i]);
							}
					 		officeStock.setState("1");
					 		//操作
					 		officeStock.setAction("入库");
					 		//操作人
					 		officeStock.setAction_name(accesscontroler.getUserName());
					 		//领用人
					 		officeStock.setCollar_userName("");
					 		listOfficeStocks.add(officeStock);
					 		
				}
				//添加库存信息
		 		officeStockDao.addOe(listOfficeStocks);
		//删除办公设备库存
		} else if("del".equals(action)){
			String ids = request.getParameter("userIds2");
			flag = officeStockDao.delEqStock(ids);
		}
		
	}catch(Exception e){
		e.printStackTrace();
		flag = false;
	}
%>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
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
//入库
if("add"=="<%=action%>"){
	var ok=function(){
		removeWindows('<%=StringUtil.deNull(request.getParameter("widowsid"))%>',true,false,true);
	}
	if(bool){
		window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
	}
	else{
		window.top.alert(mes);
	}
//删除
} else if("del"=="<%=action%>"){
	var ok=function(){
		window.parent.location.reload();
	}
	if(window.top.removeAlertWindows('<%=StringUtil.deNull(request.getParameter("widowsid"))%>',false,bool,mes,true)){
		if(bool){
			window.top.alert(mes,{headerText:'处理结果',okName:'确认',okFunction:ok})
		}
		else{
			window.top.alert(mes)
		}
	}
}
</script>
</body>
</html>