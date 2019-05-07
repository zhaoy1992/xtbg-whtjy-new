<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.impl.PurchaseApplyServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.PurchaseApplyServiceIfc"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.PurchaseApplyDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.PurchaseApplyDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.PurchaseApplyBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OrderGoods"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.security.AccessControl"%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>采购申请处室审批form</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	boolean flag = true;
	request.setCharacterEncoding("UTF-8");
	String windowsId = request.getParameter("widowsid");
	
	String apply_id = request.getParameter("apply_id");
	String apply_ids = request.getParameter("apply_ids");
	//价格
	String[] apply_price = request.getParameterValues("apply_price");
	//物品ID
	String[] goods_id = request.getParameterValues("goods_id");  
	String whatDo = request.getParameter("whatDo");
	//审批状态 
	String approvalStatus = request.getParameter("ApprovalStatus"); 
	
	//service对象
 	PurchaseApplyDao  purchaseApplyDao = (PurchaseApplyDao)new PurchaseApplyDaoImpl();
	try{
		if("1".equals(whatDo)){//办公室采购
			ArrayList<OrderGoods> orders=new ArrayList<OrderGoods>();
			if(goods_id!=null){
				for(int i=0;i<goods_id.length;i++){
					OrderGoods goods=new OrderGoods();
					if(!"".equals(apply_id)){
						goods.setApply_id(apply_id);
						goods.setGoods_id(goods_id[i]);
					}
					goods.setGoods_price(apply_price[i]);
					orders.add(goods);
				}
			}
			//采购申请实体类
			PurchaseApplyBean purchAbean = new PurchaseApplyBean();
			//申请Id
			purchAbean.setApply_id(apply_id);
			//审批状态
			purchAbean.setState(approvalStatus);
			purchaseApplyDao.setDetailApproval(purchAbean,orders);
			
		} else if("2".equals(whatDo)){//批处理采购
			if(apply_ids!=null&&!"".equals(apply_ids)){
				String[] apply_Array = apply_ids.split(",");
				for(int i=0;i<apply_Array.length;i++){
					String id  = apply_Array[i];
					//采购申请实体类
					PurchaseApplyBean purchAbean = new PurchaseApplyBean();
					//申请Id
					purchAbean.setApply_id(id);
					//审批状态
					purchAbean.setState(approvalStatus);
					//purchaseApplyDao.setDetailApproval(purchAbean);
				}
			}
		}
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
	if("2"==<%=whatDo%>){
		window.parent.location.reload();
	} else{
		removeWindows('<%=StringUtil.deNull(request.getParameter("widowsid"))%>',true,false,true);
	}
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