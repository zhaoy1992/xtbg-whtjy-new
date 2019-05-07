<%--
描述：信息报送模版管理处理
作者：黄海
版本：1.0
日期：2013-09-13
--%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.core.dict.service.impl.DictServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.dict.service.DictServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.paper.entity.PaperTemplateBean"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.PaperTemplateService"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.impl.PaperTemplateServiceImpl"%>
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
	//1:分类处理请求
	String action = request.getParameter("action");
	PaperTemplateService service=new PaperTemplateServiceImpl();
	//1.1:增 改PsdataBaseInfo
	if("addPaperTemplateInfo".equals(action)){
		responseCode = "1";
		PaperTemplateBean bean = new PaperTemplateBean();
		DictServiceIfc dictServiceIfc = new DictServiceImpl();
		bean = (PaperTemplateBean)RequestBeanUtils.getValuesByRequest(request,bean);
		//获取字典表中信息报送类型模版
		HashMap<String,String> dictDataBean =(HashMap<String,String>) dictServiceIfc.getDictDataBean(bean.getP_template_typeid());
		//模版名称
		String p_template_typename = (String)dictDataBean.get("dictdata_name");
	    bean.setP_template_typename(p_template_typename);
	    //保存或者修改
		String beanId = service.insertOrUpdateTemplateBean(bean);
		
		if(beanId!=null&&beanId.length()>0){
			responseObj = responseObj_SUCCESS+","+beanId;
		}else{
			responseObj = responseObj_FIAL;
		}
	}

	//1.2:删PsdataBaseInfo
	if("deletePaperTemplateInfo".equals(action)){
		responseCode = "1";
		String deleteStr = request.getParameter("delete");
		String[] deleteArr = deleteStr.split(",");
		String flagStr = "false";
		if(deleteArr.length>0){
			flagStr = service.deletePaperTemplateByIds(deleteArr);
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