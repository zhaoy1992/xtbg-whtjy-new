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
	String templateid="";
	try{
		WordTemplateServiceIfc wordTemplate = new WordTemplateServiceImpl();
		if("dosavewordtemplate".equals(operationType)){//保存/修改模板信息
			WordTemplateBean wordTemplateBean = new WordTemplateBean();
			String template_id = request.getParameter("template_id");
			String moduletype_logo = request.getParameter("moduletype_logo");
			String template_name = request.getParameter("template_name");
			String template_userid = request.getParameter("template_userid");
			String template_username = request.getParameter("template_username");
			String org_id = request.getParameter("org_id");
			String org_name = request.getParameter("org_name");
			String template_remark = request.getParameter("template_remark");
			String is_common = request.getParameter("is_common");
			String template_sn = request.getParameter("template_sn");
			String tableparm = request.getParameter("tableparm");
			String columnparm = request.getParameter("columnparm");
			String singn_config = request.getParameter("singn_config");
			String table_code=request.getParameter("table_code");
			String table_id=request.getParameter("table_id");

			wordTemplateBean.setTemplate_id(template_id);
			wordTemplateBean.setModuletype_logo(moduletype_logo);
			wordTemplateBean.setTemplate_name(template_name);
			wordTemplateBean.setTemplate_userid(template_userid);
			wordTemplateBean.setTemplate_username(template_username);
			wordTemplateBean.setOrg_id(org_id);
			wordTemplateBean.setOrg_name(org_name);
			wordTemplateBean.setTemplate_remark(template_remark);
			wordTemplateBean.setIs_common(is_common);
			wordTemplateBean.setTemplate_sn(template_sn);
			wordTemplateBean.setSingn_config(singn_config);
			wordTemplateBean.setTable_code(table_code);
			wordTemplateBean.setTable_id(table_id);
			
			template_id = wordTemplate.saveWordtemplate(wordTemplateBean);
			templateid=template_id;
			operationType = "saveWordtemplate";//回写mbId
		}else if("dodeletewordtemplate".equals(operationType)){//删除模板信息
			String ids = StringUtil.deNull(request.getParameter("ids"));
			wordTemplate.deleteWordTemplate(ids);
		}else if("dosavewordparam".equals(operationType) || "dosaveruleitem".equals(operationType)){//保存word参数
			RuleItemBean ruleItemBean = new RuleItemBean();
			String tableparm = StringUtil.deNull(request.getParameter("tableparm"));
			String columnparm = StringUtil.deNull(request.getParameter("columnparm"));
			ruleItemBean.setRuleitem_id(StringUtil.deNull(request.getParameter("kj_id")));
			ruleItemBean.setTemplate_id(StringUtil.deNull(request.getParameter("template_id")));//模板id
			ruleItemBean.setRuleitem_name(tableparm + "__" + columnparm);//控件名称
			ruleItemBean.setControl_type(StringUtil.deNull(request.getParameter("kj_type")));//控件类型
			ruleItemBean.setRuleitem_value_type(StringUtil.deNull(request.getParameter("kj_lx")));//取值类型
			ruleItemBean.setRuleitem_value(StringUtil.deNull(request.getParameter("bl_name")));
			ruleItemBean.setRuleitem_help(StringUtil.deNull(request.getParameter("kj_help")));//帮助
			ruleItemBean.setRuleitem_remark(StringUtil.deNull(request.getParameter("kj_remark")));//备注
			ruleItemBean.setData_come_from_table_id(StringUtil.deNull(request.getParameter("data_come_from_table_id")));//备注
			ruleItemBean.setData_come_from_column_id(StringUtil.deNull(request.getParameter("data_come_from_column_id")));//备注
			String table_cell = request.getParameter("table_cell");
			
			ruleItemBean.setTable_id(tableparm);//表ID
			ruleItemBean.setColumn_id(columnparm);//字段ID
			ruleItemBean.setTable_cell(table_cell);
			if(StringUtil.isBlank(StringUtil.deNull(request.getParameter("kj_id")))) {
				operationType = "add";
			} else {
				operationType = "update";
			}
			tempValue = wordTemplate.saveWordParam(ruleItemBean);
			
		}else if("dodeleteruleitem".equals(operationType)){//删除规则项
			String ids = StringUtil.deNull(request.getParameter("ids"));
			wordTemplate.deleteWordParam(ids);
		}else if("dosavevariable".equals(operationType)){//保存变量
			WordVarBean wordVarBean = new WordVarBean();
			
			String var_id = request.getParameter("var_id");
			String template_id = request.getParameter("template_id");
			String var_name = request.getParameter("var_name");
			String var_value = request.getParameter("var_value");
			String var_defaultvalue = request.getParameter("var_defaultvalue");
			String var_desc = request.getParameter("var_desc");
			wordVarBean.setVar_id(var_id);
			wordVarBean.setTemplate_id(template_id);
			wordVarBean.setVar_name(var_name);
			wordVarBean.setVar_value(var_value);
			wordVarBean.setVar_defaultvalue(var_defaultvalue);
			wordVarBean.setVar_desc(var_desc);

			wordTemplate.saveVariable(wordVarBean);
		}else if("dodeletevariable".equals(operationType)){//删除变量
			String ids = StringUtil.deNull(request.getParameter("ids"));
			String template_id = StringUtil.deNull(request.getParameter("template_id"));//模板id
			boolean isUsed = wordTemplate.isUsedVariable(ids,template_id);
			if(!isUsed){
				wordTemplate.deleteVariable(ids);
			}else{
				operationType = operationType + "_isUsed";
			}
		}else if("docopywordtemplate".equals(operationType)){//copy模板信息
			AccessControl control = AccessControl.getInstance();
			control.checkAccess(request, response);
			UserCacheBean userBean= UserCache.getUserCacheBean(control.getUserID());
			String ids = StringUtil.deNull(request.getParameter("ids"));
			if(ids.length()>0){
				if(userBean==null){
					userBean = new UserCacheBean();
				}
				Map<Integer,String> procMap = new HashMap<Integer,String>();
				procMap.put(1,ids);
				procMap.put(2,control.getUserID());
				procMap.put(3,control.getUserName());
				procMap.put(4,StringUtil.deNull(userBean.getOrg_id()));
				procMap.put(5,StringUtil.deNull(userBean.getOrg_name()));
				msg = wordTemplate.copyWordTemplate(procMap);
				templateid=msg;
			}
		}else if("docopywordtextinput".equals(operationType)){//copy模板内textinput信息
			AccessControl control = AccessControl.getInstance();
			control.checkAccess(request, response);
			UserCacheBean userBean= UserCache.getUserCacheBean(control.getUserID());
			if(userBean!=null){
				String template_id_a = StringUtil.deNull(request.getParameter("template_id_a"));
				String template_id_b = StringUtil.deNull(request.getParameter("template_id_b"));
				Map<Integer,String> procMap = new HashMap<Integer,String>();
				procMap.put(1,template_id_a);
				procMap.put(2,template_id_b);
				msg = wordTemplate.copyWordTextinput(procMap);
				templateid=msg;
			}
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
	parent.doReturnOK("<%=operationType%>","<%=templateid%>");//操作成功后调用父页面方法
}

</script>
</head>
<body>

</body>
</html>