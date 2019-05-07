<%--
描述：公文管理-来文管理
作者：邹拓
版本：1.0
日期：2013-12-16
UTF-8
--%>
<%@page import="com.chinacreator.xtbg.core.archive.gwcs.services.ReceiveGwService"%>
<%@page import="com.chinacreator.xtbg.core.archive.gwcs.services.impl.ReceiveGwServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.gwcs.bean.GwreceiveBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileTypeBean"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileTypeServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileTypeServiceImpl"%>
<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FilePurviewBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileDocService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileDocServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String responseCode="";//1:回调js,2:ajax
Object responseObj=null;
String responseObj_SUCCESS="操作成功";
String responseObj_FIAL="操作失败";

//1:分类处理请求
String action = request.getParameter("action");
//1.1:增 改FileTypeInfo
if("addGwreceiveBean".equals(action)){
	responseCode = "1";
	GwreceiveBean bean = new GwreceiveBean();
	bean = (GwreceiveBean)RequestBeanUtils.getValuesByRequest(request,bean);
	ReceiveGwService service = new ReceiveGwServiceImpl();
	String beanId = service.insertOrUpdateGwreceiveBean(bean);
	if(beanId!=null&&beanId.length()>0){
		responseObj = responseObj_SUCCESS;
	}else{
		responseObj = responseObj_FIAL;
	}
}

//1.2:删GwreceiveBean
if("deleteGwreceiveBean".equals(action)){
	responseCode = "1";
	String deleteStr = request.getParameter("delete1");
	String[] deleteArr = deleteStr.split(",");
	boolean flag = false;
	if(deleteArr.length>0){
		ReceiveGwService service = new ReceiveGwServiceImpl();
		flag = service.deleteGwreceiveBeanByIds(deleteArr);
		if(flag){
			responseObj = responseObj_SUCCESS;
		}else{
			responseObj = responseObj_FIAL;
		}
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