<%--
描述：知识库资料分类处理页面
作者：肖杰
版本：1.0
日期：2013-08-20
--%>
<%@page import="com.chinacreator.xtbg.core.data.entity.DataTypeBean"%>
<%@page import="com.chinacreator.xtbg.core.data.service.impl.DataTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.data.service.DataTypeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FilePurviewBean"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String responseCode="";//1:回调js,2:ajax
Object responseObj=null;
String responseObj_SUCCESS="操作成功";
String responseObj_FIAL="操作失败";

//1:分类处理请求
String action = request.getParameter("action");
DataTypeService service=new DataTypeServiceImpl();
//1.1:增 改dataTypeInfo
if("addDataTypeInfo".equals(action)){
	responseCode = "1";
	DataTypeBean bean=new DataTypeBean();
	bean = (DataTypeBean)RequestBeanUtils.getValuesByRequest(request,bean);
	
	String beanId = service.insertOrUpdateDataTypeBean(bean);
	if(beanId!=null&&beanId.length()>0){
		responseObj = responseObj_SUCCESS+","+beanId;
	}else{
		responseObj = responseObj_FIAL;
	}
}

//1.2:删dataTypeInfo
if("deleteDataTypeInfo".equals(action)){
	responseCode = "1";
	String deleteStr = request.getParameter("delete");
	String[] deleteArr = deleteStr.split(",");
	boolean flag = false;
	String flag1="";
	if(deleteArr.length>0){
		flag1 = service.deleteDataTypeInfoByIds(deleteArr);
		if("true".equals(flag1)){
			flag=true;
			responseObj=responseObj_SUCCESS;
		}else if("parent".equals(flag1)){
			flag=true;
			responseObj="分类下存在子类，请先删除子类！";
		}else if("number".equals(flag1)){
			flag=true;
			responseObj="分类下存在资料，请先删除相应资料！";
		}
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
</html>
		<%
	}
}else if("2".equals(responseCode)){
	if(responseObj!=null){
		if(responseObj instanceof String){
			out.print(responseObj.toString());
		}else{
			out.write(JSON.toJSONString(responseObj,true));//输出list或者对象
		}
	}
}
%>