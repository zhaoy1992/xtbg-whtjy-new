<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarManageApplyinfoServiceImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.CarManageApplyinfoServiceIfc"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageCarDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.dao.CarManageApplyinfoDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>派车审批是否通过form</title>
</head>
<% 
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String urlpar = request.getParameter("urlpar");
	String subid = request.getParameter("subid");
	String spInfo = request.getParameter("spInfo");
	String shan = request.getParameter("shan");
	String spply_id = request.getParameter("spply_id");
	String selectCar_num = request.getParameter("selectCar_num");
	String meg="";
	String meg2="";
	//多加了一个删除方法
	CarManageCarDao carManageCarDao = (CarManageCarDao)DaoImplClassUtil.getDaoImplClass("carManageCarDaoImplymj");
	if(shan.equals("shan")){
		carManageCarDao.delCarCheckChange(spply_id);
	}
	
	//获得派车审批中的判断派车的doCheckPC()做派车判断的提示问题
	CarManageApplyinfoDao carManageApplyinfoDao = (CarManageApplyinfoDao)DaoImplClassUtil.getDaoImplClass("carManageApplyinfoDaoImplymj");
	if(!("").equals(selectCar_num)&&selectCar_num!=null){
		 meg = carManageApplyinfoDao.doCheckPC(spply_id,selectCar_num,"1");
		 meg2 = carManageApplyinfoDao.doCheckPC(spply_id,selectCar_num,"2");
	}
	
		CarManageApplyinfoServiceIfc carManageApplyinfoServiceIfc = new CarManageApplyinfoServiceImpl();
		
		boolean flag = false;
	
	if(meg!=""||meg2!=""){
		flag = false;
	}else{
		try{
			flag = carManageApplyinfoServiceIfc.updateCarManageApplyStateByApplyID(spInfo);
		}catch(Exception e){
			e.printStackTrace();
			flag = false;
		}
	}
%>
<body>
<script type="text/javascript">
var mes = "";
var bool = true;
var urlpar = '<%=urlpar%>';
if(<%=flag%>){
	mes = "操作成功";
	bool = true;
}else{
	mes = "<%=meg%><%=meg2%>"	;
	bool = false;
}

var OKF = function(){
	if(urlpar=="clbg"){
		if(bool){
			//var obj = getParentWindow("windowId");
			//obj.parent.back();//掉父页面的方法 
			 window.parent.back1();//掉父页面的方法 
		}
	}else{
		if(bool){
			 window.parent.back();//掉父页面的方法 
		}
	}
}
window.top.alert(mes,{headerText:'提示',okName:'确认',okFunction:OKF});


</script>
</body>
</html>