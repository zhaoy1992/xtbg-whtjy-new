<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.CollarConEqStockDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.CollarConEqStockDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.CollarConEqBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.ConsumeStockDao"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.ConsumeStockDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.ConSumeStockListBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.security.AccessControl"%>	
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>易耗品 领用登记单form</title>
<%
	String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");//421003贸促会
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
	//备注
	String remark = request.getParameter("remark");
	//库存数量
	String[] conStock_count =request.getParameterValues("conStock_count");
	//领用数量
	String[]collar_count= request.getParameterValues("collar_count");
	//类别名称
	String[]conEq_types =request.getParameterValues("conEq_type");
	//类别ID
	String[] type_ids = request.getParameterValues("type_id");
	//品名
	String[] conEq_names = request.getParameterValues("conEq_name");
	List<CollarConEqBean> collarConEqBeans = new ArrayList<CollarConEqBean>();
	ConsumeStockDao  consumeStockDao = (ConsumeStockDao)new ConsumeStockDaoImpl();
	CollarConEqStockDao  collarConEqStockDao = (CollarConEqStockDao)new CollarConEqStockDaoImpl();
	try{
		  for(int i=0;i<stock_ids.length;i++){
			 CollarConEqBean collarConEqBean= new CollarConEqBean();
			 collarConEqBean.setCollarCon_user(user_id);
			 collarConEqBean.setCollarCon_userName(user_name);
			 collarConEqBean.setCollarCon_depart(org_id);
			 collarConEqBean.setCollarCon_departName(org_name);
			 collarConEqBean.setCollarCon_date(apply_date);
			 collarConEqBean.setStock_Id(stock_ids[i]);
			 collarConEqBean.setRemark(remark.trim());
			 collarConEqBean.setConStock_count(conStock_count[i].trim());
			 collarConEqBean.setCollar_count(collar_count[i].trim());
			 
		 	//操作人
		 	collarConEqBean.setAction_name(accesscontroler.getUserName());
		 	//剩余数量
		 	int	leave_count=0;
		 	if(conStock_count[i].equals("")){
		 		leave_count=0;
		 	}else{
			 	leave_count = Integer.parseInt(conStock_count[i])-Integer.parseInt(collar_count[i]);
		 	}
		 	collarConEqBean.setLeave_count(leave_count+"");
		 	//出库
		 	collarConEqBean.setOut_count(collar_count[i]);
		 	//入库
		 	collarConEqBean.setInto_count("0");
		 	//类别名称
		 	collarConEqBean.setConEq_type(conEq_types[i]);
		 	//类别ID
		 	collarConEqBean.setType_id(type_ids[i]);
		 	//品名
		 	collarConEqBean.setConEq_name(conEq_names[i]);
		 	//时间
		 	collarConEqBean.setCollarCon_date(apply_date);
		 	collarConEqBeans.add(collarConEqBean);
		  }
		  
		//领用
		collarConEqStockDao.addToBean(collarConEqBeans);
		//修改库存
		collarConEqStockDao.updateConEqStockBean(collarConEqBeans);
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