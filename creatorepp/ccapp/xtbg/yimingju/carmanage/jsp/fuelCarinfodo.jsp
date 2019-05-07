<%--
描述：特检院油卡管理处理界面
作者：邱炼
版本：1.0
日期：2014-03-25
--%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.FuelCardInfoBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarManageCarBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.FuelCardmangeService"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.FuelCardmangeServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String responseCode="";//1:回调js
	Object responseObj=null;
	String responseObj_SUCCESS="操作成功";
	String responseObj_FIAL="操作失败";
	
	boolean flag = false;
	//1:分类处理请求
	String action = request.getParameter("action");
	FuelCardmangeService service = new FuelCardmangeServiceImpl();
	//1.1:增 改
	if("addInfo".equals(action)){
		responseCode = "1";
		CarManageCarBean bean = new CarManageCarBean();
		bean = (CarManageCarBean)RequestBeanUtils.getValuesByRequest(request,bean);
		String beanId = service.insertOrUpdateFuelCardmange(bean);
		
		if(beanId!=null&&beanId.length()>0){
			responseObj = responseObj_SUCCESS+","+beanId;
		}else{
			responseObj = responseObj_FIAL;
		}
	}
	//油卡，充值 登记处理
	if("addfuelCarinfo".equals(action)){
		responseCode = "1";
		FuelCardInfoBean bean = new FuelCardInfoBean();
		bean = (FuelCardInfoBean)RequestBeanUtils.getValuesByRequest(request,bean);
		String beanId = service.insertOrUpdateFuelCardinfo(bean);
		
		if(beanId!=null&&beanId.length()>0){
			responseObj = responseObj_SUCCESS+","+beanId;
		}else{
			responseObj = responseObj_FIAL;
		}
	}
	//2:响应页面
	if("1".equals(responseCode)){
		if(responseObj!=null){
			String result = "";
			if(responseObj instanceof String){
				result = responseObj.toString();
			}else{
				result = JSON.toJSONString(responseObj,true);
				Pattern p = Pattern.compile("\\s*|\t|\r|\n");
				Matcher m = p.matcher(result);
				result= m.replaceAll("");
			}
		%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
	<head></head>
	<body>
	<script>
		try{
			var result='<%=result%>';
			eval("parent.afterSubmitFn('"+result+"');");
		}catch(e){alert(e.description);}
	</script>
	</body>
</html>
	<%
		}
	}
	%>