<%--
描述：办公用品入库数据处理页面
作者：童佳
版本：1.0
日期：2014-03-11
--%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.AddOrUpdateOsExaObjectServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	String responseCode="";//1:回调js
	Object responseObj=null;
	String responseObj_SUCCESS="操作成功";
	String responseObj_FIAL="操作失败";
	boolean flag = false;
	String action = request.getParameter("action");
	AddOrUpdateOsExaObjectServiceImpl service= new AddOrUpdateOsExaObjectServiceImpl();
	boolean flag_two = false;
	boolean upState = false;
	try{
		if("addOsMore".equals(action)){
			responseCode = "1";
			flag = service.saveBusiInfo(request, null);
			if(flag){
				responseObj = responseObj_SUCCESS;
			}else{
				responseObj = responseObj_FIAL;
			}
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
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
<html>
	<head></head>
	<body>
	<script>
		try{
			var result='<%=result%>';
			eval("parent.afterSubmitFn('"+result+"');");
		}catch(e){alert(e.description);}
	</script>
	</body>
	<%
		}
	}
	%>