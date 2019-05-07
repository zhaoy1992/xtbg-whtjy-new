<%--
描述：纸质编号处理页面
作者：邱炼
版本：1.0
日期：2014-10-27
--%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.WordArchiveService"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.OaWordNumberBean"%>
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
	WordArchiveService service = new WordArchiveServiceImpl();
	
	//1.2:删PsdataTypeInfo
	if("deleteInfo".equals(action)){
		responseCode = "1";
		OaWordNumberBean bean = new OaWordNumberBean();
		bean = (OaWordNumberBean)RequestBeanUtils.getValuesByRequest(request,bean);
		String bus_ids = request.getParameter("bus_ids");
		String number_codes = request.getParameter("number_codes");
		String[] busIds = bus_ids.split(",");
		String[] numberCodes = number_codes.split(",");
		String flagStr = "false";
		if(busIds.length>0||numberCodes.length>0){
			flagStr = service.deleteWordInfoByIds(busIds,numberCodes,bean);
		}
		if("true".equals(flagStr)){
			flag=true;
			responseObj=responseObj_SUCCESS;
		}else if("number".equals(flagStr)){
			flag=true;
			responseObj="分类被引用，不能删除！";
		}
		
		if(flag){
			responseObj = responseObj;
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