<%@page import="com.chinacreator.xtbg.pub.wordtemplate.entity.WordVarBean"%>
<%@page import="com.chinacreator.xtbg.pub.wordtemplate.entity.WordTemplateBean"%>
<%@page import="com.chinacreator.xtbg.pub.wordtemplate.entity.WordConfigBean"%>
<%@page import="com.chinacreator.xtbg.pub.wordtemplate.service.impl.WordTemplateServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.wordtemplate.service.WordTemplateServiceIfc"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>  
    
<%
	String operationType = StringUtil.deNull(request.getParameter("operationType"));
	String msg = "";
	String tempValue = "";
	String[] listValueArray = null;

	
	try{
		WordTemplateServiceIfc wordTemplate = new WordTemplateServiceImpl();
		if("dosavewordtemplate".equals(operationType)){//����/�޸�ģ����Ϣ
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

			template_id = wordTemplate.saveWordtemplate(wordTemplateBean);
			operationType = operationType + "_"+template_id;//��дmbId
		}else if("dodeletewordtemplate".equals(operationType)){//ɾ��ģ����Ϣ
			String ids = StringUtil.deNull(request.getParameter("ids"));
			wordTemplate.deleteWordTemplate(ids);
		}else if("dosavewordparam".equals(operationType) || "dosaveruleitem".equals(operationType)){//����word����
			RuleItemBean ruleItemBean = new RuleItemBean();
			ruleItemBean.setRuleitem_id(StringUtil.deNull(request.getParameter("kj_id")));
			ruleItemBean.setTemplate_id(StringUtil.deNull(request.getParameter("template_id")));//ģ��id
			ruleItemBean.setRuleitem_name(StringUtil.deNull(request.getParameter("kj_name")));//�ؼ�����
			ruleItemBean.setControl_type(StringUtil.deNull(request.getParameter("kj_type")));//�ؼ�����
			ruleItemBean.setRuleitem_value_type(StringUtil.deNull(request.getParameter("kj_lx")));//ȡֵ����
			ruleItemBean.setRuleitem_value(StringUtil.deNull(request.getParameter("bl_name")));
			ruleItemBean.setRuleitem_flag(StringUtil.deNull(request.getParameter("kj_flag")));//״̬
			ruleItemBean.setRuleitem_help(StringUtil.deNull(request.getParameter("kj_help")));//����
			ruleItemBean.setRuleitem_remark(StringUtil.deNull(request.getParameter("kj_remark")));//��ע
			
			
			tempValue = wordTemplate.saveWordParam(ruleItemBean);
			
		}else if("dodeleteruleitem".equals(operationType)){//ɾ��������
			String ids = StringUtil.deNull(request.getParameter("ids"));
			wordTemplate.deleteWordParam(ids);
		}else if("dosavevariable".equals(operationType)){//�������
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
		}else if("dodeletevariable".equals(operationType)){//ɾ������
			String ids = StringUtil.deNull(request.getParameter("ids"));
			String template_id = StringUtil.deNull(request.getParameter("template_id"));//ģ��id
			boolean isUsed = wordTemplate.isUsedVariable(ids,template_id);
			if(!isUsed){
				wordTemplate.deleteVariable(ids);
			}else{
				operationType = operationType + "_isUsed";
			}
		}else if("dosavedataset".equals(operationType)){//�������ݼ�
			Map<String,String> map = new HashMap<String,String>();
			map.put("mbId",StringUtil.deNull(request.getParameter("mb_id")));//ģ��id
			map.put("sjjMc",StringUtil.deNull(request.getParameter("sjj_mc")));//����
			map.put("sjjSql",StringUtil.deNull(request.getParameter("sjj_sql")));//sql
			map.put("sjjMs",StringUtil.deNull(request.getParameter("sjj_ms")));//����
			map.put("sjjId",StringUtil.deNull(request.getParameter("cur_sjj_id")));//���ݼ�id
			boolean isRight = false;//wordTemplate.isRightSql(StringUtil.deNull(request.getParameter("sjj_sql")));//���ж�sql�Ƿ���ִ��
			if(isRight){
				//wordTemplate.saveDataset(map);
			}else{
				operationType = "dosavedataset_errorsql";//����ҳ�淵��ֵ
			}
		}else if("dodeletedataset".equals(operationType)){//ɾ�����ݼ�
			String ids = StringUtil.deNull(request.getParameter("ids"));
			String mbId = StringUtil.deNull(request.getParameter("mb_id"));//ģ��id
			boolean isUsed = false;//wordTemplate.isUsedDataset(ids,mbId);
			if(!isUsed){
				//wordTemplate.deleteDataset(ids);
			}else{
				operationType = operationType + "_isUsed";
			}
		}else if("dosavewordconfig".equals(operationType)){//����/�޸���������
			String[] actionNameArray = request.getParameterValues("action_name");
			String[] actionDefidArray = request.getParameterValues("action_defid");
			String[] operationTypeArray = request.getParameterValues("operation_type");
			String[] isValidAction = request.getParameterValues("is_valid_action");
			
			List<WordConfigBean> actionList = new ArrayList<WordConfigBean>();
			for(int i = 0 ; i < actionNameArray.length ; i++){
				WordConfigBean wordConfigBean = new WordConfigBean();
				wordConfigBean.setAction_name(actionNameArray[i]);
				wordConfigBean.setOperation_type(operationTypeArray[i]);
				wordConfigBean.setAction_defid(actionDefidArray[i]);
				wordConfigBean.setIs_valid_action(isValidAction[i]);
				wordConfigBean.setEc_id(request.getParameter("ec_id"));
				actionList.add(wordConfigBean);
			}
			Map<String ,String> map = new HashMap<String,String>(); 
			map.put("ecId",StringUtil.deNull(request.getParameter("ec_id")));//����id
			map.put("amanuensisId",StringUtil.deNull(request.getParameter("amanuensis_id")));//����id
			map.put("amanuensisName",StringUtil.deNull(request.getParameter("amanuensis_name")));//��������
			map.put("resourceId",StringUtil.deNull(request.getParameter("resource_id")));//ģ��id
			map.put("componentName",StringUtil.deNull(request.getParameter("component_name")));//�ؼ�����
			map.put("isValidWord",StringUtil.deNull(request.getParameter("is_valid_word")));//�����Ƿ���Ч
			map.put("amanuensisType",StringUtil.deNull(request.getParameter("amanuensis_type")));//��������
			map.put("isSpecial","Y");//�Ƿ���Ի�
			map.put("actionName",StringUtil.deNull(request.getParameter("action_name_hidden")));//������
			map.put("actionDefid",StringUtil.deNull(request.getParameter("action_name")));//����id
			map.put("operationType",StringUtil.deNull(request.getParameter("operation_type")));//��������
			map.put("isValidAction",StringUtil.deNull(request.getParameter("is_valid_action")));//�����Ƿ���Ч
			//wordTemplate.saveWordConfig(map,actionList);
		}else if("dodeletewordconfig".equals(operationType)){//ɾ��word����
			String ids = StringUtil.deNull(request.getParameter("ids"));
			//wordTemplate.deleteWordConfig(ids);
		}else if("dosavewordinstance".equals(operationType)){//����wordʵ��
			String reportInstanceId = request.getParameter("report_instanceid");
			String userId = request.getParameter("user_id");
			String reportId = request.getParameter("report_id");
			String itemInsId = request.getParameter("item_insid");
			String instanceCode = request.getParameter("instance_code");
			String ccFormInstanceId = request.getParameter("cc_form_instanceid");
			String reportName = request.getParameter("report_name");
			String reportType = request.getParameter("report_type");
			String printType = "0";

			Map<String ,String> map = new HashMap<String,String>();
			map.put("reportInstanceId",reportInstanceId);
			map.put("printerId",userId);
			map.put("reportId",reportId);
			map.put("instanceCode",instanceCode);
			map.put("ccFormInstanceId",ccFormInstanceId);
			map.put("reportName",reportName);
			map.put("printType",printType);
			map.put("reportType",reportType);
			if(StringUtil.deNull(request.getParameter("type")).equals("init")){
				operationType = operationType+ "_init";
			}
			//wordTemplate.saveWordInstnace(map);
		}else if("dosavewordcertconfig".equals(operationType)){//����/�޸�֤������
			Map<String ,String> map = new HashMap<String,String>();
			map.put("certId",StringUtil.deNull(request.getParameter("cert_id")));
			map.put("ecId",StringUtil.deNull(request.getParameter("ec_id")));
			map.put("certName",StringUtil.deNull(request.getParameter("cert_name")));
			map.put("certTemplateid",StringUtil.deNull(request.getParameter("resource_id")));
			map.put("certStatus",StringUtil.deNull(request.getParameter("cert_status")));
			map.put("requiredReport",StringUtil.deNull(request.getParameter("required_report")));
			map.put("ccFormInstanceId",StringUtil.deNull(request.getParameter("cc_form_instanceid")));
			//wordTemplate.saveWordCertConfig(map);
		}
	}catch(Exception e){
		e.printStackTrace();
		msg = "error";
	}
%>

<%@page import="com.chinacreator.xtbg.pub.wordtemplate.entity.RuleItemBean"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<!-- ����jQuery -->
<script type="text/javascript" src="../jquery1.6/jquery-1.6.min.js"></script>
<title></title>
<script type="text/javascript">
/**********��java����ת����Js��Array����*******************/
var listValue = new Array();
<%for(int i = 0 ;  null != listValueArray && i < listValueArray.length ; i++){%>
	listValue[<%=i%>] = "<%=listValueArray[i]%>"; 
<%}%>

if("<%=msg%>" == "error"){
	alert("����ʧ��");
}else{
	if("<%=operationType%>" == "dosaveruleitem" || "<%=operationType%>" == "dosavewordparam" ){
		$("#temp_value",parent.document).val("<%=tempValue%>");
		parent.listValue = listValue;//ȫ�ֲ���
	}
	parent.doReturnOK("<%=operationType%>");//�����ɹ�����ø�ҳ�淽��
}

</script>
</head>
<body>

</body>
</html>