<%--
描述：知识库知识分类处理页面
作者：肖杰
版本：1.0
日期：2013-08-07
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.kbm.entity.KbmDocTypeRightConfig"%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.impl.KbmDocTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.KbmDocTypeServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.kbm.entity.KbmDocTypeBean"%>
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
KbmDocTypeServiceIfc service=new KbmDocTypeServiceImpl();
//1.1:增 改FileTypeInfo
if("addDocTypeInfo".equals(action)){
	responseCode = "1";
	KbmDocTypeBean bean = new KbmDocTypeBean();
	bean = (KbmDocTypeBean)RequestBeanUtils.getValuesByRequest(request,bean);
	
	String beanId = service.insertOrUpdateKbmDocTypeBean(bean);
	if(beanId!=null&&beanId.length()>0){
		responseObj = responseObj_SUCCESS+","+beanId;
	}else{
		responseObj = responseObj_FIAL;
	}
}

//1.2:删FileTypeInfo
if("deleteDocTypeInfo".equals(action)){
	responseCode = "1";
	String deleteStr = request.getParameter("delete");
	String[] deleteArr = deleteStr.split(",");
	boolean flag = false;
	String flag1="";
	if(deleteArr.length>0){
		flag1 = service.deleteDocTypeInfoByIds(deleteArr);
		if("true".equals(flag1)){
			flag=true;
			responseObj=responseObj_SUCCESS;
		}else if("number".equals(flag1)){
			flag=true;
			responseObj="分类或子类被引用，不能删除！";
		}
	}
	
	if(flag){
		responseObj = responseObj;
	}else{
		responseObj = responseObj_FIAL;
	}
}


//1.3:添加档案分类密级
if("addFilePurviewInfo".equals(action)){
	responseCode = "1";
	String k_role_range1=request.getParameter("k_role_range1");
	KbmDocTypeRightConfig bean = (KbmDocTypeRightConfig)RequestBeanUtils.getValuesByRequest(request,new KbmDocTypeRightConfig());
	if("1".equals(k_role_range1)){
		bean.setK_role_range(k_role_range1);
	}
	if(StringUtil.isBlank(bean.getK_role_range())){
		bean.setK_role_range("");
		bean.setK_role_range_name("");
	}
	boolean flag =service.insertOrUpdateDocConfigBean(bean);
	if(flag){
		responseObj = responseObj_SUCCESS;
	}else{
		responseObj = responseObj_FIAL;
	}
}

//1.4:删除档案分类密级
if("deleteFilePurviewInfo".equals(action)){
	responseCode = "1";
	String deleteStr = request.getParameter("delete");
	String[] deleteArr = deleteStr.split(",");
	boolean flag = false;
	if(deleteArr.length>0){
		flag = service.deleteDocTypeConfigInfoByIds(deleteArr);
	}
	if(flag){
		responseObj = "delete,"+responseObj_SUCCESS;
	}else{
		responseObj = "delete,"+responseObj_FIAL;
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