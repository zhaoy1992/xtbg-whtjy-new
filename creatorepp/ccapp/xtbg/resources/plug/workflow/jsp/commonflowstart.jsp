<%@page import="com.chinacreator.xtbg.pub.tree.entity.ResourceRoleUserBean"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.impl.ResouceConfigDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.tree.dao.ResourceConfigDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.entity.InstanceBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.FlowClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.entity.FlowWfactionBean"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.service.impl.InitFlowServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.service.InitFlowServiceIfc"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.entity.FlowWfactionExtBean"%>
<%@page import="com.chinacreator.xtbg.pub.common.Constant"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.entity.FlowDefinfoBean"%>
<%@page import="com.chinacreator.eform.business.InstanceIdManager"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.dao.imploracle.FlowUtilDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.dao.FlowUtilDao"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	
	String userName = accesscontroler.getUserAccount(); //�û�����
	String userRealName = accesscontroler.getUserName();
	String orgId = accesscontroler.getChargeOrgId(); //�û��Ļ���ID
	String user_id = accesscontroler.getUserID();
	String entrance = request.getParameter("entrance");
	String backtype =request.getParameter("backtype");//���ĸ���ڽ����ı�־
	String actiontype_code = request.getParameter("actiontype_code");
	String openType = request.getParameter("openType");//ȡ�ñ�ʾ���ļ����������
	String srid = request.getParameter("srid");//ȡ������id���ļ����������
	String userOrgId_spcli = request.getParameter("userOrgId");//���ļ�����������б���뵽ҳ��
	String openFlag = request.getParameter("openFlag");//ȡ��removewindow��id��
	String actionPage = request.getParameter("actionPage");
	
	//��ǰ�û��Ļ���id�ͻ�����
	ResourceConfigDao resourceRoleConfigDao = new ResouceConfigDaoImpl();
	ResourceRoleUserBean rruBean = new ResourceRoleUserBean();
	if (!StringUtil.nullOrBlank(user_id)) {
		rruBean = resourceRoleConfigDao.queryUserMatchOrg(user_id);
	}
	String userOrgId = "";
	String userOrgName = "";
	if (!StringUtil.isBlank(rruBean.getOrgid())) {
		userOrgId = rruBean.getOrgid();
	}
	if(("ycxsw").equals(openType))
	{
		userOrgId=userOrgId_spcli;
	}
	
	String flow_version = ""; //���̰汾
	String flow_defid = ""; //���̶���ID
	String package_id = ""; //���̰�
	String action_id = ""; //�ID
	String action_name = ""; //�����
	String fromPage = "tabs-1";

	String list_type = request.getParameter("list_type"); //���Ǹ��б��� tobe_work(�ݴ�)
	String mgrName = request.getParameter("mgrName");
	String action_form = request.getParameter("action_form"); //��
	String action_defid = request.getParameter("action_defid"); //�����ID
	String ins_code = request.getParameter("ins_code"); //ʵ������
	String flow_id = request.getParameter("flow_id");//����ID
	String def_id = request.getParameter("def_id");//���̶���ID

	String fromtype = request.getParameter("fromtype"); //fromtype = "newaccept" ������, fromtype = "temp" �ݴ�, fromtype = "fristpage" ��ҳ
	String ins_id = request.getParameter("ins_id"); //ʵ��ID
	String actInsId = request.getParameter("actInsId"); //�ʵ��ID
	String busi_id = request.getParameter("busi_id"); //ҵ��ID
	String cc_form_instanceid = request
			.getParameter("cc_form_instanceid"); //ƽ̨ҵ��ID
	String busiTypeCode = request.getParameter("busiTypeCode"); //�������ͱ���
	String operType = request.getParameter("operType"); //��������
	String theRootOrgid = DaoUtil
			.SqlToField("select org_id from td_sm_organization where parent_id='0'");
	if ("daiban".equals(operType)) {
		fromPage = "tabs-1";
	} else if ("nosend".equals(operType)) {
		fromPage = "tabs-2";
	} else if ("yiban".equals(operType)) {
		fromPage = "tabs-3";
	}
	if (StringUtil.isBlank(ins_id)) {
		ins_code = FlowClassUtil.getNewInstanceCode(busiTypeCode); //ʵ�����
	}

	if (StringUtil.isBlank(cc_form_instanceid)) { //����������ƽ̨ҵ��ID
		cc_form_instanceid = InstanceIdManager.getFormInstanceId();
	}
	String isDynamicSelectAndAct = Constant.STATUS_FALSE;//�Ƿ�̬ѡ����һ����
	String isDynamicSelectUser = Constant.STATUS_FALSE; //�Ƿ�̬ѡ���ִ����

	String opType = "isShowActSelectText@isShowUserText@isShowBackButton@isShowRecycle@isShowCompleteWorkflow@isShowTempSaveForm@isShowTerminate@isShowSuspend@isShowResume";//������Ϊ��ʶ
	InitFlowServiceIfc initFlowServiceIfc = new InitFlowServiceImpl();

	Map<String, String> initmap = new HashMap<String, String>();
	//��ʼ��Ҫ�õĲ���
	initmap.put("initType", "1");
	initmap.put("orgId", userOrgId);
	initmap.put("busiTypeCode", busiTypeCode);
	initmap.put("ins_id", ins_id);
	initmap.put("opType", opType);
	initmap.put("actInsId", actInsId);
	initmap.put("user_id", user_id);
	initmap.put("cc_form_instanceid", cc_form_instanceid);
	initmap.put("userName", userName);
	initmap.put("userRealName", userRealName);
	initmap.put("ins_code", ins_code);
	initmap.put("def_id", def_id);
	initmap.put("operType", operType);
	//initmap.put("srid",srid);
	String flowinfo = "";//������Ϣ
	String actionAliasAndOrderStr = ""; //���ڱ���������
	FlowDefinfoBean flowDefinfoBean = null; //���̶���Bean
	FlowWfactionBean flowWfactionBean = null; //�����Bean
	FlowWfactionExtBean flowWfactionExtBean = null; //���̻��չBean
	InstanceBean instanceBean = null; //ʵ��Bean

	Map<String, Object> map = initFlowServiceIfc.init(initmap);

	if (map.get("instanceBean") != null) {
		instanceBean = (InstanceBean) map.get("instanceBean");//�����Bean
		initmap.put("status_code", instanceBean.getStatus_code());
	}

	if (map.get("flowDefinfoBean") != null) {
		flowDefinfoBean = (FlowDefinfoBean) map.get("flowDefinfoBean");//���̶���Bean
		mgrName = flowDefinfoBean.getPackage_id() + "#"
				+ flowDefinfoBean.getFlow_version() + "#"
				+ flowDefinfoBean.getFlow_defid();
		initmap.put("mgrName", mgrName);
		initmap.put("action_defid", flowDefinfoBean.getAction_defid());
		initmap.put("flow_id", flowDefinfoBean.getFlow_id());
		initmap.put("action_form", flowDefinfoBean.getAction_form());
		action_form = flowDefinfoBean.getAction_form();

	}

	if (map.get("flowWfactionBean") != null) {
		flowWfactionBean = (FlowWfactionBean) map
				.get("flowWfactionBean");//�����Bean
		initmap.put("def_id", flowWfactionBean.getDef_id());
		def_id = flowWfactionBean.getDef_id();
		initmap.put("action_id", flowWfactionBean.getAction_id());
		initmap.put("action_name", flowWfactionBean.getAction_name());
		action_name = flowWfactionBean.getAction_name();
	}

	if (map.get("flowWfactionExtBean") != null) {
		flowWfactionExtBean = (FlowWfactionExtBean) map
				.get("flowWfactionExtBean");//�����Bean
		isDynamicSelectUser = flowWfactionExtBean.getIsshowuser();
		if ("Y".equals(isDynamicSelectUser)) {
			isDynamicSelectUser = "true";
		}
	}

	if (map.get("flowinfo") != null) {
		flowinfo = map.get("flowinfo").toString();//������Ϣ
	}

	if (map.get("actionAliasAndOrderStr") != null) {
		actionAliasAndOrderStr = map.get("actionAliasAndOrderStr")
				.toString();//���ڱ���������
	}

	JSONObject pageParmsjson = new JSONObject();
	pageParmsjson.put("flowParmJson", initmap); //��map��
	//System.out.println(action_form);
	String startButtonName="";
	//��������Ժ  �������̵�������ť��ͳһ�޸�����Ϊ��������
	if(CacheCommonManageProxy.getBooleanSystemParam("workflow.startButtonName")){
		startButtonName = "��������";
	} else {
		startButtonName ="����"+action_name;
	}
	if(action_name.indexOf("���")>=0){
		actionPage="qingjia";
	}else if(action_name.indexOf("���")>=0){
		actionPage="gongwen";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>����������ȥҳ��</TITLE>
<!-- ����jQuery -->
<script type="text/javascript" src="../../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"  charset="utf-8"></script>
<!-- �������� -->
<!-- <script type="text/javascript" src="../resources/js/commonflowapprove.js" ></script> -->
<script src="../../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<script src="../resources/js/workflow.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/js/commonflowstart.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script src="../../../../resources/plug/workflow/resources/js/workflow-extend.js" type="text/javascript"  charset="utf-8"></script>


<script type="text/javascript">

var parms = <%=pageParmsjson%>;  //��java Json����ֵ��JS����
var actionAliasAndOrderStr = "<%=actionAliasAndOrderStr%>";
/*
	����:   init
	˵��:   ��ʼ���������̴���ʼҳ��
	����:   ��
	����ֵ: ��
*/
function init() {

	initByListType();
	initDynamicWorkflow();
	wf.initDynamicSelectDiv();
	initDynamicSelectUser();
	if(wf.isEx()){ //workflow-extend.js ���ṩ����չ���������ڿ��ƶ�̬ѡ��ִ���˵Ĺ���
		<%if(CacheCommonManageProxy.getBooleanSystemParam("workflow.isUseWfEx_newModel")){ %>
			wf_Ex.newModel.init();
		<%} %>
	}
	<%if(CacheCommonManageProxy.getBooleanSystemParam("NextActName")){%>
	var nextActName = wf_Ex.newModel.getCurr_NextActObj().actionName;
	jQuery("#next_act_name").val(nextActName);
	<%}%>
	var h = adaptationWH('_top','vcenter',-20);
	jQuery("#subFrame").height(h-12);
	
	//autoSetTabSize("subFrame");
}

/* ��ʼ����̬ѡ��ִ���˺Ͷ�̬ѡ��ִ�л����������ػ�չʾ */
function initDynamicWorkflow(){
    var ret = initDynamicWorkflowSet("<%=flowinfo%>","start", "<%=actionAliasAndOrderStr%>"); //��ʼ����̬ѡ��
    jQuery("#xzspWorkflowType").val(ret["xzspWorkflowType"]);
    jQuery("#isDynamicSelectAct").val(ret["isDynamicSelectAct"]);
    //jQuery("#isDynamicSelectUser").val(ret["isDynamicSelectUser"]);
    jQuery("#isDynamicSelectAndAct").val(ret["isDynamicSelectAndAct"]);
    jQuery("#nextActList").val(ret["nextActList"]);
}

function initDynamicSelectUser() {
	initDynamicSelectUserSet("<%=isDynamicSelectUser%>");
}



</script>
<style type="text/css">

.input_160{font:12px;
}
.but_x{
height:28px;
}

</style>
</HEAD>
<BODY onload="init();">
<form name="form1" method="post" id="form1" action="" >
	<table width="100%">
	<tr height="10px" id="flow_top_toolbar">	<!-- add by �½������������е�id����������;����ɾ������ -->
		<td id="_top" valign="top">
				<div id="itemBtnDiv" style="white-space: nowrap;float:left; width:100%;">
				<div id="xzsp_workflowControl_selectAndAct" style="DISPLAY: none; float:left; width:20%;">
					<div id="xzsp_selectAndAct_memo" style="font-size:12px;">ѡ��һ������</div> 
							<INPUT type="text" style="width=100px" class="cText_out" id="XZSPNEXTACT_NAME" name="XZSPNEXTACT_NAME"  onclick="openAndSelectActView()" readOnlysize=14> 
							<INPUT type="text" class="cText_out" id="XZSPNEXTACT" name="XZSPNEXTACT" style="DISPLAY: none">
				</div> &nbsp;&nbsp;&nbsp;
				<div id="xzsp_workflowControl_selectOrAct" style="DISPLAY: none;float:left;margin-left: 10px;">
							<font style="font-size:12px;float:left; border:none; cursor:pointer; margin-top: 3px">ѡ��һ�����ڣ�</font>
							<SELECT id="xzsp_workflowControl_selectAct"></SELECT>

				</div>
					<div id="xzsp_workflowControl_selectUser" style="DISPLAY: none;float:left;margin-left: 35px;margin-right: 10px;">
						<font style="font-size:12px;float:left; border:none; cursor:pointer; margin-top: 5px">ѡִ���ˣ� </font>
						<INPUT class="validate[required] input_161" onmouseover="this.title=this.value"
							 id="DYNAMICPERFORMER_REALNAME" name="DYNAMICPERFORMER_REALNAME" 
							value=""
							readOnly   >
						<input name="" id="DYNAMICPERFORMER_BUT" type="button" value="" class="but_x" style="float:left;" />
						<INPUT type="hidden" class="cText_out" id="DYNAMICPERFORMER" name="DYNAMICPERFORMER" /> 
						<INPUT type="hidden" class="cText_out" id="DYNAMICPERFORMER_ID" name="DYNAMICPERFORMER_ID" />
					</div> 
					<div style="float:left;padding-right: 15px;padding-left: 10px;">
						<input class='but_y_06' onMouseOver=javascript:jQuery(this).attr('class','but_y_07'); 
						onMouseOut=javascript:jQuery(this).attr('class','but_y_06');
						 style="margin-top: 2px" type="button"
						name="btnTemp" value="�ݴ�<%=action_name %>" onClick="doTemp('<%=entrance%>','<%=action_name %>','<%=actionPage %>')" id="btnTemp" />
					</div>
						<div style="float:left; padding-right: 15px">
						<input class='but_y_06' onMouseOver=javascript:jQuery(this).attr('class','but_y_07'); 
						onMouseOut=javascript:jQuery(this).attr('class','but_y_06'); style="margin-top: 2px" type="button"
				        name="startflaw" value="<%=startButtonName%>" onClick="doStartFlow('<%=entrance%>','<%=action_name%>','<%=actionPage %>')" id="startflaw" />
				        </div>
				        <div style="float:left;padding-right: 15px">
				        <input class='but_y_01' onMouseOver=javascript:jQuery(this).attr('class','but_y_02'); 
						onMouseOut=javascript:jQuery(this).attr('class','but_y_01'); style="margin-top: 2px" type="button"
						name="btnreturn" value="����" onclick="returnPage('<%=fromPage%>','<%=entrance%>','<%=openFlag %>','<%=actionPage%>')" id="btnreturn" />
						</div>
						
						  <div style="float:left;padding-right: 15px;margin-top: 5px;" id="next_act_name_div">
						 <%if(CacheCommonManageProxy.getBooleanSystemParam("NextActName")){%>
						<!-- ��һ���ڵĻ������� -->
						��һ�������ƣ�<input type="text" readonly="readonly"  style="width: 80px;border: 0px;color:#000;"
						 id="next_act_name" name="next_act_name"/>
						<%}%>
						</div>
				</div>
				
		</td>
	</tr>
	<!-- ���̲����� -->
	<!-- ҵ��չʾ�� -->
	<tr>
		<td id="vcenter">
			<IFRAME style="WIDTH: 100%;" id="subFrame" name="subFrame" src="<%=path + action_form%>?busi_id=<%=busi_id%>&action_name=<%=action_name%>&backtype=<%=backtype %>&entrance=<%=entrance %>&operType=<%=operType %>&actiontype_code=<%=actiontype_code %>&srid=<%=srid %>&action_defid=<%=action_defid %>&ins_id=<%=ins_id %>&action_name=<%=action_name %>&def_id=<%=def_id %>" frameborder="0" scrolling="no"></IFRAME>
		</td>
	</tr>
	<!-- ҵ��չʾ�� -->
</table>


<IFRAME name=frame1 width=100% height=0> </IFRAME> 

<!-- ���ز����� -->
<input id="flowData" name="flowData" type="hidden"/>
<input id="busiData" name="busiData" type="hidden"/>
<input id="classNameId" name="classNameId" type="hidden"/>
<input id="bigColumnsValue" name="bigColumnsValue" type="hidden"/>
<input id="action_handeridea" name="action_handeridea" type="hidden"/>
<input id="xzspWorkflowType" name="xzspWorkflowType" type="hidden"/>
<input id="flowTache" name="flowTache" type="hidden"/>
<input id="isDynamicSelectAct" name="isDynamicSelectAct" type="hidden"/>
<input id="isDynamicSelectUser" name="isDynamicSelectUser" value="<%=isDynamicSelectUser%>" type="hidden"/>
<input id="isDynamicSelectAndAct" name="isDynamicSelectAndAct" type="hidden"/>
<input id="nextActList" name="nextActList" type="hidden"/>
<input id="nextActId" name="nextActId" type="hidden"/>
<input id="actionPage" name="actionPage" value="<%=actionPage%>" type="hidden"/>

<!-- ���ز����� -->
</form>
</BODY>
</HTML>
