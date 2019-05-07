<%--
描述：公告栏信息处理页面
作者：邱炼
版本：1.0
日期：2013-08-12
--%>
<%@page import="com.chinacreator.xtbg.core.notice.service.NoticeHandleServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.notice.service.impl.NoticeHandleServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.notice.entity.NoticeReportAuditBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	//1:处理请求
	String action = request.getParameter("action");
	NoticeHandleServiceIfc service=new NoticeHandleServiceImpl();
	//1.1:增 改addBaseInfo
	if("addBaseInfo".equals(action)){
		responseCode = "1";
		NoticeReportAuditBean bean = new NoticeReportAuditBean();
		bean = (NoticeReportAuditBean)RequestBeanUtils.getValuesByRequest(request,bean);
		String beanId = service.insertOrUpdateNoticeReportBean(bean);
		
		if(beanId!=null&&beanId.length()>0){
			responseObj = responseObj_SUCCESS+","+beanId;
		}else{
			responseObj = responseObj_FIAL;
		}
	}

	//1.2:删deleteBaseInfo
	if("deleteBaseInfo".equals(action)){
		responseCode = "1";
		String deleteStr = request.getParameter("delete");
		String[] deleteArr = deleteStr.split(",");
		String flagStr = "false";
		if(deleteArr.length>0){
			flagStr = service.deleteNoticeReportBeanByid(deleteArr);
		}
		if("true".equals(flagStr)){
			flag=true;
			responseObj=responseObj_SUCCESS;
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