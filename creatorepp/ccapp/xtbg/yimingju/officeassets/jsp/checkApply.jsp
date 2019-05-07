<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.PurchaseApplyBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OrderGoods"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.PurchaseApplyDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%><%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	JSONObject jsonObj = new JSONObject();
    String apply_id=request.getParameter("apply_id");
	String apply_goodsId=request.getParameter("apply_goodsId");
	//采购申请实体类
	PurchaseApplyBean purchAbean = new PurchaseApplyBean();
	//采购ID
	purchAbean.setApply_id(apply_id);
	PurchaseApplyDao dao = (PurchaseApplyDao)DaoImplClassUtil.getDaoImplClass("purchaseApplyDaoImpl");
	//物品列表
	ArrayList<OrderGoods> orders = new ArrayList<OrderGoods>();
	if(!"".equals(apply_id)){
		orders = dao.getGoodsBeanById(apply_id);
	}
	
	PurchaseApplyBean bean =(PurchaseApplyBean)dao.getTypeBeanById(apply_id);
	StringBuffer jsonStr=new StringBuffer("{'title':'"+ bean.getApply_title() +"','apply_remarks':'"+bean.getApply_remarks()+"',");
	String goodName = "";
	String goodsUint ="";
	String goodsCount = "";
	String goodsPirce = "";
	for(int i = 0;i<orders.size();i++){
		OrderGoods orderGood = (OrderGoods)orders.get(i);
		goodName = goodName + orderGood.getGoods_name()+ ",";
		goodsUint = goodsUint + orderGood.getGoods_unit() + ",";
		goodsCount = goodsCount + orderGood.getGoods_count() + ",";
		goodsPirce = goodsPirce + orderGood.getGoods_price() + ",";
	}
	jsonStr.append("'goodName':'"+goodName+"',");
	jsonStr.append("'goodsUint':'"+goodsUint+"',");
	jsonStr.append("'goodsCount':'"+goodsCount+"',");
	jsonStr.append("'goodsPirce':'"+goodsPirce+"'");
	jsonStr.append("}");
	jsonObj=JSONObject.parseObject(jsonStr.toString());
	response.getWriter().print(jsonObj);
%>
