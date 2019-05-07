<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.impl.PurchaseApplyServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.service.PurchaseApplyServiceIfc"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.PurchaseApplyBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OrderGoods"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<%@page import="com.chinacreator.xtbg.pub.util.DateUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>采购申请信息保存form</title>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();//获得当前登录用户id
	boolean flag = true;
	request.setCharacterEncoding("UTF-8");
	String windowsId = request.getParameter("widowsid");
	
	//动作状态
	String whatDo = request.getParameter("whatDo");
	//采购信息Id
	String apply_Id =request.getParameter("apply_id");
	//采购信息
	String apply_room = request.getParameter("apply_room");
	String apply_title = request.getParameter("apply_title");
	String apply_date = request.getParameter("apply_date");
	String apply_remarks = request.getParameter("apply_remarks");
	//物品信息
	String apply_goodsId[] = request.getParameterValues("apply_goodsId");
 	String apply_goods[] = request.getParameterValues("apply_goods");
	String apply_unit[] = request.getParameterValues("apply_unit");
	String apply_count[] = request.getParameterValues("apply_count");
	String apply_price[] = request.getParameterValues("apply_price");
	//审批状态 
	String approvalStatus = request.getParameter("ApprovalStatus"); 
	//处室审批人ID
	String andit_userId = request.getParameter("andit_userId");
	//处室审批意见
	String room_opinion = request.getParameter("room_opinion");
	//处室审批时间
	String room_Date = request.getParameter("room_Date");
	//办公室审批意见
	String office_opinion = request.getParameter("office_opinion");
	//办公室审批时间
	String office_Date = request.getParameter("office_Date");
	
	//采购申请实体类
	PurchaseApplyBean purchAbean = new PurchaseApplyBean();
	//采购ID
	purchAbean.setApply_id(apply_Id);
	//申请人
	purchAbean.setApply_users(userid);
	//申请处室
	purchAbean.setApply_room(apply_room);
	//申请日期
	purchAbean.setApply_date(apply_date);
	//申请标题
	purchAbean.setApply_title(apply_title);
	//申请备注
	purchAbean.setApply_remarks(apply_remarks);
	//用户角色判断
	String rolesState ="1";
	String rolesNames = "";//查询是否为办公室审批角色或处室审批角色 办公室一般用户
	AuthRole authRoles[] = accesscontroler.getAllRoleofUser(accesscontroler.getUserAccount());
	StringBuffer buf = new StringBuffer();
	for(int i=0;i<authRoles.length;i++){
		buf.append(authRoles[i].toString()+ ",");
	} 
	rolesNames = buf.toString();
	if(rolesNames.length()>0){
		rolesNames = rolesNames.substring(0,rolesNames.length()-1);
	} 
	
	if(rolesNames.indexOf("处室审批角色")!=-1){
		rolesState = "2";
	} 
	if(rolesNames.indexOf("办公室一般用户角色")!=-1){
		rolesState = "4";
	}
	if(rolesNames.indexOf("办公室审批角色")!=-1){
		rolesState = "3";
	}
	//用户角色
	purchAbean.setApply_UserRoles(rolesState);

	//审批状态
	purchAbean.setState(approvalStatus);
	//采购审批处室
	if("2".equals(whatDo)){
		//处室审批人ID
		purchAbean.setAndit_userId(userid);
		//处室审批意见
		purchAbean.setRoom_opinion(room_opinion);
		//处室时间
		purchAbean.setRoom_date(DateUtil.getCurrentDateTime());
	}
	//办公室审批
	if("3".equals(whatDo)){
		//处室审批人Id
		purchAbean.setAndit_userId(andit_userId);
		//处室审批意见
		purchAbean.setRoom_opinion(room_opinion);
		//处室时间
		purchAbean.setRoom_date(room_Date);
		//办公室审批人ID
		purchAbean.setOffice_andit_userId(userid);
		//办公室审批意见
		purchAbean.setOffice_opinion(office_opinion);
		//办公室审批时间
		purchAbean.setOffice_date(DateUtil.getCurrentDateTime());
	}
	
	ArrayList<OrderGoods> orders=new ArrayList<OrderGoods>();
	if(apply_goods!=null){
		for(int i=0;i<apply_goods.length;i++){
			OrderGoods goods=new OrderGoods();
			if(!"".equals(apply_Id)){
				goods.setApply_id(apply_Id);
				goods.setGoods_id(apply_goodsId[i]);
			}
			goods.setGoods_name(apply_goods[i]);
			goods.setGoods_unit(apply_unit[i]);
			goods.setGoods_count(apply_count[i]); 
			goods.setGoods_price(apply_price[i]);
			goods.setGoods_rcount(apply_count[i]);
			orders.add(goods);
		}
	}
	
	//service对象
 	PurchaseApplyServiceIfc purchaseApplyServiceIfc = new PurchaseApplyServiceImpl();
	try{
		//新增
		if("".equals(apply_Id)){
			 flag = purchaseApplyServiceIfc.saveOe(purchAbean, orders);
		//修改
		}else{
			 //删除物品信息
			 flag = purchaseApplyServiceIfc.deleteOe(apply_Id);
			 //修改物品信息
			 flag = purchaseApplyServiceIfc.updateOe(purchAbean, orders);
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
	removeWindows('<%=StringUtil.deNull(request.getParameter("widowsid"))%>',true,false,true);
	parent.backTo();
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