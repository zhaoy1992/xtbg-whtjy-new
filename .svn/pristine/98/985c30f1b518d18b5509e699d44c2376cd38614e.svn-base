<%--
描述：常用物品处理页面
作者：邱炼
版本：1.0
日期：2014-02-18
--%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.entity.OsupplieUseType"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.OsupplieUseTypeService"%>
<%@page import="com.chinacreator.xtbg.tjy.canteenitemssupplies.service.impl.OsupplieUseTypeServiceImpl"%>
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
	OsupplieUseTypeService service = new OsupplieUseTypeServiceImpl();
	//1.1:增 改osupplieusetypeinfo
	if("addOsupplieUsetypeInfo".equals(action)){
		responseCode = "1";
		OsupplieUseType bean = new OsupplieUseType();
		bean = (OsupplieUseType)RequestBeanUtils.getValuesByRequest(request,bean);
		String beanId = service.insertOrUpdateOsUserTypeBean(bean);
		
		if(beanId!=null&&beanId.length()>0){
			responseObj = responseObj_SUCCESS+","+beanId;
		}else{
			responseObj = responseObj_FIAL;
		}
	}

	//1.2:删deleteOsupplieTypeInfo
	if("deleteOsupplieTypeInfo".equals(action)){
		responseCode = "1";
		String deleteStr = request.getParameter("delete");
		String[] deleteArr = deleteStr.split(",");
		String flagStr = "false";
		if(deleteArr.length>0){
			flagStr = service.deleteOsUsTypeInfoByIds(deleteArr);
		}
		if("true".equals(flagStr)){
			flag=true;
			responseObj=responseObj_SUCCESS;
		}else if("number".equals(flagStr)){
			flag=true;
			responseObj="已关联规格，无法删除！";
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