<%@page import="com.chinacreator.xtbg.pub.workflow.entity.InstanceBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.FlowClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.entity.FlowWfactionBean"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.service.impl.InitFlowServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.service.InitFlowServiceIfc"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.entity.FlowWfactionExtBean"%>
<%@page import="com.chinacreator.xtbg.pub.common.Constant"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.entity.FlowDefinfoBean"%>
<%@page import="com.chinacreator.eform.business.InstanceIdManager"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.dao.imploracle.FlowUtilDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.dao.FlowUtilDao"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<% 
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String path = request.getContextPath();
	
	String userName = accesscontroler.getUserAccount();  //�û�����
	String userRealName = accesscontroler.getUserName();
	String orgId = accesscontroler.getChargeOrgId();  //�û��Ļ���ID
	String user_id = accesscontroler.getUserID();
	String entrance = request.getParameter("entrance");
	String flow_version = "";  //���̰汾
	String flow_defid = "";  //���̶���ID
	String package_id = "";  //���̰�
	String action_id = ""; //�ID
	String action_name = "";  //�����
	String fromPage = "tabs-1";
	
	String list_type = request.getParameter("list_type"); //���Ǹ��б��� tobe_work(�ݴ�)
	String mgrName = request.getParameter("mgrName");
	String actInsId = request.getParameter("actInsId");  //�ʵ��ID
	String procId = request.getParameter("procId");
	String action_form = request.getParameter("action_form");  //��
	String action_defid = request.getParameter("action_defid");  //�����ID
	String actiontype_code = request.getParameter("actiontype_code");  //����ͱ��
	String def_id = request.getParameter("def_id");//���̶���ID
	String ins_id = request.getParameter("ins_id");  //ʵ��ID
	String cc_form_instanceid = request.getParameter("cc_form_instanceid");  //ƽ̨ҵ��ID
	String busi_id = request.getParameter("busi_id");  //ҵ��ID
	String operType = request.getParameter("operType");  //��������
	
	String openFlag = request.getParameter("openFlag");//ȡ��removewindow��id��
	
	String actionPage = request.getParameter("actionPage");
	//��Ϊ��������ʱ���鵵
	//String flow = action_defid;
	//String flowName =flow.substring(0, flow.indexOf("_"));
	
	if("daiban".equals(operType)) {
		fromPage = "tabs-1";
	} else if ("nosend".equals(operType)) {
		fromPage = "tabs-2";
	} else if("yiban".equals(operType)){
		fromPage = "tabs-3";
	}
	
	InitFlowServiceIfc initFlowServiceIfc = new InitFlowServiceImpl();
	
	Map<String,String> initmap = new HashMap<String,String>();
	//��ʼ��Ҫ�õĲ���
	initmap.put("initType","3");
	initmap.put("orgId", orgId);
	initmap.put("ins_id", ins_id);
	initmap.put("actInsId",actInsId);
	initmap.put("user_id", user_id);
	initmap.put("cc_form_instanceid",cc_form_instanceid);
	initmap.put("userName",userName);
	initmap.put("userRealName", userRealName);
	initmap.put("def_id", def_id);
	initmap.put("actiontype_code", actiontype_code);
	initmap.put("procId", procId);
	initmap.put("action_defid", action_defid);
	initmap.put("operType", operType);
	
	String flowinfo = "";//������Ϣ
	String actionAliasAndOrderStr = "";  //���ڱ���������
	FlowDefinfoBean flowDefinfoBean = null; //���̶���Bean
	FlowWfactionBean flowWfactionBean = null; //�����Bean
	FlowWfactionExtBean flowWfactionExtBean = null;  //���̻��չBean
	InstanceBean instanceBean = null; //ʵ��Bean
	
	Map<String, Object> map = initFlowServiceIfc.init(initmap);
	
	if(map.get("instanceBean") != null){
		instanceBean = (InstanceBean)map.get("instanceBean");//�����Bean
		initmap.put("status_code", instanceBean.getStatus_code());
		initmap.put("busitype_code", instanceBean.getBusitype_code());
	}
	
	if(map.get("flowDefinfoBean") != null){
		flowDefinfoBean = (FlowDefinfoBean)map.get("flowDefinfoBean");//���̶���Bean
		mgrName = flowDefinfoBean.getPackage_id() + "#" + flowDefinfoBean.getFlow_version() + "#" + flowDefinfoBean.getFlow_defid();
		initmap.put("mgrName",mgrName);
		initmap.put("flow_id",flowDefinfoBean.getFlow_id());
		initmap.put("action_form",flowDefinfoBean.getAction_form());
		action_form = flowDefinfoBean.getAction_form();
		
	}
	
	if(map.get("flowWfactionBean") != null){
		flowWfactionBean = (FlowWfactionBean)map.get("flowWfactionBean");//�����Bean
		initmap.put("def_id", flowWfactionBean.getDef_id());
		initmap.put("action_id", flowWfactionBean.getAction_id());
		initmap.put("action_name", flowWfactionBean.getAction_name());
		action_name = flowWfactionBean.getAction_name();
		action_id =flowWfactionBean.getAction_id();
	}
	JSONObject pageParmsjson = new JSONObject();
	pageParmsjson.put("flowParmJson", initmap);	//��map��
	
	String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>

<TITLE>�������̰��ҳ��</TITLE>
<!-- ����jQuery -->
<script type="text/javascript" src="../../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="utf-8"></script>
<!-- �������� -->
<script src="../../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<script src="../resources/js/commonflowend.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/js/workflow.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="../../ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/js/commonflowapprove.js"  charset="utf-8"></script>
<script src="../resources/js/commonflowstart.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="../../ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../ifrom/js/ifrom-ui-tree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../public/flowinfoconfig/resources/js/tree.js" charset="utf-8"></script>
<script type="text/javascript" src="../../JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>

<script type="text/javascript">

var parms = <%=pageParmsjson%>;  //��java Json����ֵ��JS����

/*
	����:   init
	˵��:   ��ʼ���������̴���ʼҳ��
	����:   ��
	����ֵ: ��
*/
function init() {
	var h = adaptationWH('_top','vcenter',30);
	//autoSetTabSize("subFrame");
	$("#subFrame").height(h+10);
	
}

function archives(){
	//urlParams
	var p = {
					busi_id : '<%=busi_id %>',
					ins_id : '<%=ins_id %>',
					action_name : '<%=action_name %>',
					action_defid : '<%=action_defid %>',
					operType : '<%=operType %>',
					actiontype_code : '<%=actiontype_code %>',
					action_form : '<%=action_form %>',
					isSendEmail : 'false'
				 };
	 //windowParams
	var wP = {
				wName : '�鵵',
				wWidth : '800',
				wHeight : '200',
				wTop : '30%',
				wLeft : '30%'
			 };
	if("20" == "<%=instanceBean.getBusitype_code().trim()%>" || 
		"23" == "<%=instanceBean.getBusitype_code().trim()%>"){
		p.isSendEmail = 'true';
		wP.wHeight = '250';
	}
	openAlertWindows('windowId','../../../yimingju/workflow/jsp/archives.jsp?'+$.param(p),wP.wName,wP.wWidth,wP.wHeight,wP.wTop,wP.wLeft);
}
</script>
</HEAD>
<BODY onload="init()">
<form name="form1" method="post" id="form1" action="">
<div>
<table width="100%" >
	<!-- ���̲����� -->
	<tr height="10px">
		<td id="_top" style="padding-left: 32px;">
		<div style="float:left;padding-right: 5px;padding-left:5px;" id="startflawdiv">
			<input class='but_y_01'  type="button"
			 name="startflaw" id="startflaw" value="���" onClick="doFinishWorkflow('<%=entrance %>','<%=StringUtil.deNull(userArea)%>')" />
		</div>
			 <%if("421000".equals(StringUtil.deNull(userArea))) {%>
			 <div style="float:left;padding-right: 5px;padding-left:5px;">
			 <input class='but_y_01'   type="button" 
			 name="arch_but" id="arch_but"  value="�鵵" onclick="archives();" />
			 </div>
			 <%} %>
			 <div style="float:left;padding-right: 5px;padding-left:5px;">
			 <input class='but_y_01'   type="button" 
			 name="btnreturn" value="����" onclick="returnPage('<%=fromPage%>','<%=entrance %>','<%=openFlag %>','<%=actionPage%>')" id="btnreturn" />
			 </div>
		</td>
	</tr>
	<!-- ���̲����� -->
	
	<!-- ҵ��չʾ�� -->
	<tr>
		<td id="vcenter">
			<IFRAME style="WIDTH: 100%;" id="subFrame" name="subFrame" src="<%=path + action_form %>?busi_id=<%=busi_id %>&action_form=<%=action_form %>&ins_id=<%=ins_id %>&action_name=<%=action_name %>&action_defid=<%=action_defid %>&operType=<%=operType %>&actiontype_code=<%=actiontype_code %>&action_id=<%=action_id %>" frameborder="0" scrolling="no"></IFRAME>
		</td>
	</tr>
	<!-- ҵ��չʾ�� -->
</tabel>
</div>

<IFRAME name=frame1 width=100% height=0> </IFRAME> 

<!-- ���ز����� -->
<input id="flowData" name="flowData" type="hidden"/>
<input id="busiData" name="busiData" type="hidden"/>
<input id="classNameId" name="classNameId" type="hidden"/>
<input id="bigColumnsValue" name="bigColumnsValue" type="hidden"/>
<input id="action_handeridea" name="action_handeridea" type="hidden"/>

<input id="xzspWorkflowType" name="xzspWorkflowType" type="hidden"/>
<input id="flowTache" name="flowTache" type="hidden"/>

<input id="end_type" name="end_type" type="hidden"/>
<input id="receive_userid" name="receive_userid" type="hidden"/>
<%--�������̻��ڽ��������ת --%>
<input id="actionPage" name="actionPage" value="<%=actionPage%>" type="hidden"/>

<!-- ���ز����� -->
</form>
</BODY>
</HTML>
