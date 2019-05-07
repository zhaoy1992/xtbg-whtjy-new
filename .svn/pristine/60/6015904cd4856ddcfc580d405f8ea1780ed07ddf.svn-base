<%@page import="com.chinacreator.xtbg.core.common.iweboffice.bean.ThWordTemplateBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page import="com.chinacreator.xtbg.core.common.iweboffice.bean.WordTemplateBean"%>
<%@ page import="com.chinacreator.xtbg.core.common.iweboffice.service.WordTemplateServiceIfc"%>
<%@ page import="com.chinacreator.xtbg.core.common.iweboffice.service.impl.WordTemplateServiceImpl"%>
<%@ page import="com.chinacreator.xtbg.core.common.iweboffice.bean.RuleItemBean"%>
<%@ page import="com.chinacreator.xtbg.core.common.iweboffice.bean.WordVarBean"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>  
<%
	String operationType = StringUtil.deNull(request.getParameter("operationType"));
	String msg = "";
	String tempValue = "";
	String[] listValueArray = null;

	try{
		WordTemplateServiceIfc wordTemplate = new WordTemplateServiceImpl();
		if("dosavethwordtemplate".equals(operationType)){//保存/修改套红模板信息
			ThWordTemplateBean wordTemplateBean = new ThWordTemplateBean();
			String template_id_th = request.getParameter("template_id_th");
			String template_name = request.getParameter("template_name_th");
			String template_userid = request.getParameter("template_userid_th");
			String template_username = request.getParameter("template_username_th");
			String org_id = request.getParameter("org_id");
			String org_name = request.getParameter("org_name");
			String template_remark = request.getParameter("template_remark_th");
			String is_common = request.getParameter("is_common_th");
			String template_sn = request.getParameter("template_sn_th");
			String busitype_code = request.getParameter("busitype_code");
			
			wordTemplateBean.setTemplate_id_th(template_id_th);
			wordTemplateBean.setTemplate_name_th(template_name);
			wordTemplateBean.setTemplate_userid_th(template_userid);
			wordTemplateBean.setTemplate_username_th(template_username);
			wordTemplateBean.setOrg_id(org_id);
			wordTemplateBean.setOrg_name(org_name);
			wordTemplateBean.setTemplate_remark_th(template_remark);
			wordTemplateBean.setIs_common_th(is_common);
			wordTemplateBean.setTemplate_sn_th(template_sn);
			wordTemplateBean.setBusitype_code(busitype_code);
			template_id_th = wordTemplate.saveThWordtemplate(wordTemplateBean);
			operationType = operationType + "_"+template_id_th;//回写mbId
		}else if("dodeletewordtemplate".equals(operationType)){//删除模板信息
			String ids = StringUtil.deNull(request.getParameter("ids"));
			wordTemplate.deleteThWordTemplate(ids);
		}
	}catch(Exception e){
		e.printStackTrace();
		msg = "error";
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<title></title>
<script type="text/javascript">
/**********将java数组转换成Js的Array对象*******************/
var listValue = new Array();
<%for(int i = 0 ;  null != listValueArray && i < listValueArray.length ; i++){%>
	listValue[<%=i%>] = "<%=listValueArray[i]%>"; 
<%}%>

if("<%=msg%>" == "error"){
	alert("操作失败");
}else{
	if("<%=operationType%>" == "dosaveruleitem" || "<%=operationType%>" == "dosavewordparam" ){
		$("#temp_value",parent.document).val("<%=tempValue%>");
		parent.listValue = listValue;//全局参数
	}
	parent.doReturnOK("<%=operationType%>","<%=msg%>");//操作成功后调用父页面方法
}

</script>
</head>
<body>

</body>
</html>