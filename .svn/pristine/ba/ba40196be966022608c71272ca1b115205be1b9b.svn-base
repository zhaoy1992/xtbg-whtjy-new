<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.ConsumeStockDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.OfficeConsumeTypeDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.ConsumeStockDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.OfficeConsumeTypeDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeConsumStock"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeConsumeTypeBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.ConSumeStockListBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.chinacreator.xtbg.pub.util.DbconnManager"%>



<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>易耗品库存form</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	//获得当前登录用户id
	String userid = accesscontroler.getUserID();
	boolean flag = true;
	request.setCharacterEncoding("UTF-8");
	String action = request.getParameter("action");
	String windowsId = request.getParameter("widowsid");
	String stock_id = request.getParameter("stock_id");//得到易耗品库存id,备用
	ConsumeStockDao  consumeStockDao = (ConsumeStockDao)new ConsumeStockDaoImpl();
	Connection conn = null;
	try{
		//易耗品入库
		 if("add".equals(action)){
			//入库时间
			String stock_date = request.getParameter("stock_data");
			//类别ID
			String[] type_ids = request.getParameterValues("type_ids");
			//品名
			String[] con_names = request.getParameterValues("con_name");
			//规格
			String[] con_rules  =request.getParameterValues("con_rules");
			//数量
			String [] count = request.getParameterValues("count");
			//价格
			String[] con_price = request.getParameterValues("con_price");
			//供货厂商
			String [] suppliers = request.getParameterValues("suppliers");
			//销售电话
			String [] service_phones =request.getParameterValues("service_phone");
			//备注
			String remark = request.getParameter("remark");
			
			OfficeConsumeTypeDao officeConsumeTypeDao =(OfficeConsumeTypeDao)new OfficeConsumeTypeDaoImpl();
			List<OfficeConsumStock> officeConsumStocks = new ArrayList<OfficeConsumStock>();//物品添加
			List<OfficeConsumStock> YJCZ = new ArrayList<OfficeConsumStock>();//已经存在的品名
	 		String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");//421005望城城投
	 		OfficeConsumStock flag_YJCZ = null;
			for(int i=0;i<type_ids.length;i++){
						flag_YJCZ = null;
						OfficeConsumStock officeConsumStock= new OfficeConsumStock();
						officeConsumStock.setStock_data(stock_date);
						officeConsumStock.setStock_applyer(userid);
						officeConsumStock.setRemark(remark);
						officeConsumStock.setType_id(type_ids[i]);
						OfficeConsumeTypeBean officeConsumeTypeBean= (OfficeConsumeTypeBean)officeConsumeTypeDao.getTypeBeanById(type_ids[i]);
						officeConsumStock.setType_name(officeConsumeTypeBean.getOcname_name());
						officeConsumStock.setCon_name(con_names[i]);
				 		officeConsumStock.setCon_rules(con_rules[i]);
				 		officeConsumStock.setCount(count[i]);
				 		officeConsumStock.setSuppliers(suppliers[i]);
				 		officeConsumStock.setService_phone(service_phones[i]);
				 		officeConsumStock.setCon_price(con_price[i]);
				 		
				 		//操作人
				 		officeConsumStock.setCollar_userName(accesscontroler.getUserName());
				 		//剩余数量
				 		officeConsumStock.setLeave_count(count[i]);
				 		//出库
				 		officeConsumStock.setOut_count("0");
				 		//入库
				 		officeConsumStock.setInto_count(count[i]);
				 		//类别名称
				 		officeConsumStock.setType_name(officeConsumeTypeBean.getOcname_name());
				 		//类别ID
				 		officeConsumStock.setType_id(type_ids[i]);
				 		//品名
				 		officeConsumStock.setEq_name(con_names[i]);
				 		if(StringUtil.deNull(userArea).equals("421005") && !StringUtil.isBlank(stock_id)){
				 			//查询出是否有相同的类型下的品名相同，相同返回对应bean，不同返回null
				 			flag_YJCZ = consumeStockDao.queryOfficeConsumStockById(stock_id);//根据id查询
				 		} else if(StringUtil.deNull(userArea).equals("421005")){
				 			flag_YJCZ = consumeStockDao.queryEqueryOfficeconstock(officeConsumStock);//根据品名信息查询
				 		}
				 		if(flag_YJCZ != null && StringUtil.deNull(userArea).equals("421005")){
				 			officeConsumStock.setStock_id(flag_YJCZ.getStock_id());//id
				 			//如果剩余数量不为空
				 			//if(StringUtil.isBlank(flag_YJCZ.getLeave_count())){
				 				//int leaveCount = Integer.valueOf(count[i]);
				 				//如果不是修改，而是入库，数量加
				 				if(StringUtil.isBlank(stock_id)){
				 					//数量
				 					int cons_count = Integer.valueOf(count[i]);
				 					officeConsumStock.setCount(""+(Integer.valueOf(flag_YJCZ.getCount()) +cons_count));//设置数量
				 				} else {//如果是修改，则修改入库数量
				 					int intoCount = Integer.valueOf(count[i])-Integer.valueOf(flag_YJCZ.getCount());
					 				//officeConsumStock.setCount(""+cons_count);//设置数量
					 				officeConsumStock.setInto_count(""+intoCount);//入库数量
				 				}
				 				//officeConsumStock.setLeave_count(""+leaveCount);//设置剩余数量
				 			//}
				 			
				 			YJCZ.add(officeConsumStock);//如果相同，添加到已经存在的品名中
				 		} else if(StringUtil.deNull(userArea).equals("421005")){
							String purchasId = DaoUtil.findBySequencsName("SEQ_OFFICESTOCK");
							officeConsumStock.setStock_id(purchasId);//设置id
				 			officeConsumStocks.add(officeConsumStock);
				 		} else {
				 			officeConsumStocks.add(officeConsumStock);
				 		}
			}
			if(StringUtil.deNull(userArea).equals("421005")){
				conn = DbconnManager.getInstance().getTransactionConnection();
				if(YJCZ.size() > 0){
					consumeStockDao.updateOfficeconstocks(YJCZ,conn);//更新易耗品库存信息
				}
				if(officeConsumStocks.size() > 0){
					consumeStockDao.insertOfficeconstocks(officeConsumStocks,conn);//插入易耗品库存
					
					consumeStockDao.insertConstocklist(officeConsumStocks,conn);//插入易耗品库存明细
				}
				if(YJCZ.size() > 0){
					consumeStockDao.insertConstocklist(YJCZ,conn);//插入易耗品库存明细
				}
				DbconnManager.closeTransactionConnection(conn, true);
			} else {
				//入库易耗品信息
		 		consumeStockDao.addConSumOe(officeConsumStocks);
			}
		//删除易耗品库存信息
		} else if("del".equals(action)){
			String ids = request.getParameter("userIds2");
			flag = consumeStockDao.delSumEqStock(ids);
		}
	}catch(Exception e){
		DbconnManager.closeTransactionConnection(conn, false);
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