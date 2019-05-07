<%@page import="com.chinacreator.xtbg.pub.workflow.entity.InstanceBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.FlowClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.entity.FlowWfactionBean"%>
<%@page import="com.alibaba.fastjson.JSONObject"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.service.impl.InitFlowServiceImpl"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.service.InitFlowServiceIfc"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.entity.FlowWfactionExtBean"%>
<%@page import="com.chinacreator.xtbg.pub.common.Constant"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.entity.FlowDefinfoBean"%>
<%@page import="com.chinacreator.eform.business.InstanceIdManager"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.dao.imploracle.FlowUtilDaoImpl"%>
<%@page import="com.chinacreator.xtbg.pub.workflow.dao.FlowUtilDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<% 
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String path = request.getContextPath();
	
	String userName = accesscontroler.getUserAccount();  //用户名称
	String userRealName = accesscontroler.getUserName();
	String orgId = accesscontroler.getChargeOrgId();  //用户的机构ID
	String user_id = accesscontroler.getUserID();
	String entrance = request.getParameter("entrance");
	
	String flow_version = "";  //流程版本
	String flow_defid = "";  //流程定义ID
	String package_id = "";  //流程包
	String action_id = ""; //活动ID
	String action_name = "";  //活动名称
	String action_alias ="";//活动别名
	String fromPage = "tabs-1"; 
	
	String list_type = request.getParameter("list_type"); //从那个列表来 tobe_work(暂存)
	String mgrName = request.getParameter("mgrName");
	String actInsId = request.getParameter("actInsId");  //活动实例ID
	String procId = request.getParameter("procId");
	String action_form = request.getParameter("action_form");  //表单
	String action_defid = request.getParameter("action_defid");  //活动定义ID
	String actiontype_code = request.getParameter("actiontype_code");  //活动类型编号
	String def_id = request.getParameter("def_id");//流程定义ID
	String ins_id = request.getParameter("ins_id");  //实例ID
	String cc_form_instanceid = request.getParameter("cc_form_instanceid");  //平台业务ID
	String busi_id = request.getParameter("busi_id");  //业务ID
	String operType = request.getParameter("operType");  //操作类型
	//String action_name_value = request.getParameter("action_name");  //活动名称
	String actionPage = request.getParameter("actionPage");

	if("daiban".equals(operType)) {
		fromPage = "tabs-1";
	} else if ("nosend".equals(operType)) {
		fromPage = "tabs-2";
	} else if("yiban".equals(operType)){
		fromPage = "tabs-3";
	} 
	
	String isDynamicSelectAndAct = Constant.STATUS_FALSE;//是否动态选择下一步与活动
	String isDynamicSelectUser = Constant.STATUS_FALSE; //是否动态选择或活动执行人
	String isShowBack = Constant.STATUS_FALSE;  //是否回退 
	String isSignJoinByOrder = Constant.STATUS_FALSE;  //是否按顺序会签
	
	String opType = "isShowActSelectText@isShowUserText@isShowBackButton@isShowRecycle@isShowCompleteWorkflow@isShowTempSaveForm@isShowTerminate@isShowSuspend@isShowResume";//流程行为标识
	InitFlowServiceIfc initFlowServiceIfc = new InitFlowServiceImpl();
	
	Map<String,String> initmap = new HashMap<String,String>();
	//初始化要用的参数
	initmap.put("initType","2");
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
	initmap.put("opType", opType);
	
	String flowinfo = "";//流程信息
	String actionAliasAndOrderStr = "";  //环节别名与排序
	FlowDefinfoBean flowDefinfoBean = null; //流程定义Bean
	FlowWfactionBean flowWfactionBean = null; //活动定义Bean
	FlowWfactionExtBean flowWfactionExtBean = null;  //流程活动扩展Bean
	InstanceBean instanceBean = null; //实例Bean
	
	Map<String, Object> map = initFlowServiceIfc.init(initmap);
	
	if(map.get("instanceBean") != null){
		instanceBean = (InstanceBean)map.get("instanceBean");//活动定义Bean
		initmap.put("status_code", instanceBean.getStatus_code());
		initmap.put("busitype_code", instanceBean.getBusitype_code());
	}
	if(map.get("flowDefinfoBean") != null){
		flowDefinfoBean = (FlowDefinfoBean)map.get("flowDefinfoBean");//流程定义Bean
		mgrName = flowDefinfoBean.getPackage_id() + "#" + flowDefinfoBean.getFlow_version() + "#" + flowDefinfoBean.getFlow_defid();
		initmap.put("mgrName",mgrName);
		//initmap.put("action_defid",flowDefinfoBean.getAction_defid());
		initmap.put("flow_id",flowDefinfoBean.getFlow_id());
		initmap.put("action_form",flowDefinfoBean.getAction_form());
		action_form = flowDefinfoBean.getAction_form();
		
	}
	
	if(map.get("flowWfactionBean") != null){
		flowWfactionBean = (FlowWfactionBean)map.get("flowWfactionBean");//活动定义Bean
		initmap.put("def_id", flowWfactionBean.getDef_id());
		initmap.put("action_id", flowWfactionBean.getAction_id());
		initmap.put("action_name", flowWfactionBean.getAction_name());
		initmap.put("action_alias", flowWfactionBean.getAction_alias());
		action_alias =  flowWfactionBean.getAction_alias();
		action_name = flowWfactionBean.getAction_name();
	}
	
	if(map.get("flowWfactionExtBean") != null){
		flowWfactionExtBean = (FlowWfactionExtBean)map.get("flowWfactionExtBean");//活动定义Bean
		isDynamicSelectUser = flowWfactionExtBean.getIsshowuser();
		isShowBack = flowWfactionExtBean.getIsshowback();
		isSignJoinByOrder = flowWfactionExtBean.getIssignjoinbyorder();
		if("Y".equals(isDynamicSelectUser)) {
			isDynamicSelectUser = "true";
		}
		if("Y".equals(isShowBack.trim())) {
			isShowBack = "true";
		}
		if("Y".equals(isSignJoinByOrder)){
			isSignJoinByOrder = "true";
		}
		initmap.put("isSignJoinByOrder",isSignJoinByOrder.trim());
	}
	
	if(map.get("flowinfo") != null){
		flowinfo = map.get("flowinfo").toString();//流程信息
	}

	if(map.get("actionAliasAndOrderStr") != null) {
		actionAliasAndOrderStr = map.get("actionAliasAndOrderStr").toString();//环节别名与排序
	}
	
	JSONObject pageParmsjson = new JSONObject();
	pageParmsjson.put("flowParmJson", initmap);	//将map对

	String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
	String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
	
	String doCompleteWorkButStr =  CacheCommonManageProxy.getSystemParam("workflow.doCompleteWorkButStr");
	if(StringUtil.nullOrBlank(doCompleteWorkButStr)){
		doCompleteWorkButStr = "完成"+action_alias;
	}
		
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%><html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>公用流程启去页面</TITLE>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<script type="text/javascript" src="../resources/js/commonflowapprove.js"  charset="utf-8"></script>
<script src="../../../../resources/js/util/public.js" type="text/javascript"></script>

<script src="../../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<script src="../resources/js/workflow.js" type="text/javascript" charset="utf-8"></script>
<script src="../resources/js/commonflowstart.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="../../ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../ifrom/js/ifrom-ui-tree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../public/flowinfoconfig/resources/js/tree.js" charset="utf-8"></script>
<script type="text/javascript" src="../../ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../resources/js/commonflowend.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<script src="../../../../resources/plug/workflow/resources/js/workflow-extend.js" type="text/javascript"  charset="utf-8"></script>

<script type="text/javascript">

var parms = <%=pageParmsjson%>;  //将java Json对象赋值给JS对象

var actionAliasAndOrderStr = "<%=actionAliasAndOrderStr%>";



/*
	函数:   init
	说明:   初始化公共流程处理开始页面
	参数:   无
	返回值: 无
*/
function init() {
	initDynamicWorkflow();
	wf.initDynamicSelectDiv();
	initDynamicSelectUser();
	
	if(wf.isEx()){ //workflow-extend.js 中提供的扩展方法，用于控制动态选择执行人的功能
		<%if(CacheCommonManageProxy.getBooleanSystemParam("workflow.isUseWfEx_newModel")){ %>
			wf_Ex.newModel.init();
		<%} %>
	}
	<%if(CacheCommonManageProxy.getBooleanSystemParam("NextActName")){%>
		var nextActName = wf_Ex.newModel.getCurr_NextActObj().actionName;
		jQuery("#next_act_name").val(nextActName);
	<%}%>
	var h = adaptationWH('_top','vcenter',30);
	//autoSetTabSize("subFrame");
	jQuery("#subFrame").height(h+8);
}

/* 初始化动态选择执行人和动态选择执行活动，视情况隐藏或展示 */
function initDynamicWorkflow(){
    var ret = initDynamicWorkflowSet("<%=flowinfo %>","middle", "<%=actionAliasAndOrderStr%>"); //初始化动态选择
    jQuery("#xzspWorkflowType").val(ret["xzspWorkflowType"]);
    jQuery("#isDynamicSelectAct").val(ret["isDynamicSelectAct"]);
    //jQuery("#isDynamicSelectUser").val(ret["isDynamicSelectUser"]);
    jQuery("#isDynamicSelectAndAct").val(ret["isDynamicSelectAndAct"]);
    jQuery("#nextActList").val(ret["nextActList"]);
}

function initDynamicSelectUser() {
	initDynamicSelectUserSet("<%=isDynamicSelectUser%>","<%=isShowBack%>");
	
}

/**
 * 检查 会签环节是否 之前还有用户未处理
 */
function signJoinByOrder(){
	if(wf.isEx() && !IsSpace(parms.flowParmJson.isSignJoinByOrder) && 'N' != parms.flowParmJson.isSignJoinByOrder){
		var checkIsAllSignJoin = wf_Ex.newModel.checkIsAllSignJoin(parms.flowParmJson.ins_id,parms.flowParmJson.action_id,parms.flowParmJson.user_id,parms.flowParmJson.isSignJoinByOrder);
		if((IsSpace(checkIsAllSignJoin.isAllSignJoin)||"false"==checkIsAllSignJoin.isAllSignJoin)&&!IsSpace(checkIsAllSignJoin.readSignUsers)){
			alert("在您之前还有"+checkIsAllSignJoin.readSignUsers+"未处理！");
			return ;
		}
	}
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
				wName : '归档',
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
<style type="text/css">
.input_160{
font:12px;
}
.but_x{
height:28px;
}


</style>
</HEAD>
<BODY onload="init()">
<form name="form1" method="post" id="form1" action="">
<div style="overflow-y:hidden;">
<table width="100%" >
	<!-- 流程操作区 -->
	<tr height="10px">
		<td id="_top">
			<div id="itemBtnDiv" style="white-space: nowrap;float:left; width:100%;">
				<div id="xzsp_workflowControl_selectAndAct" style="DISPLAY: none; float:left; width:20%;">
					<div id="xzsp_selectAndAct_memo" style="font-size:12px;">选下一步环节</div> 
							<INPUT type="text" style="width=100px" class="cText_out" id="XZSPNEXTACT_NAME" name="XZSPNEXTACT_NAME"  onclick="openAndSelectActView()" readOnlysize=14> 
							<INPUT type="text" class="cText_out" id="XZSPNEXTACT" name="XZSPNEXTACT" style="DISPLAY: none">
				</div> &nbsp;&nbsp;&nbsp;
				<div id="xzsp_workflowControl_selectOrAct" style="DISPLAY: none;float:left;margin-left: 32px;">
							<font style="font-size:12px;float:left; border:none; cursor:pointer; margin-top: 3px">选下一步环节：</font>
							<SELECT id="xzsp_workflowControl_selectAct"></SELECT>
					</div>
					<div id="xzsp_workflowControl_selectUser" style="DISPLAY: none;float:left;margin-left: 10px;">
						<font style="font-size:12px;float:left; border:none; cursor:pointer; margin-top: 6px">选执行人： </font>
						<INPUT class="validate[required] input_161" onmouseover="this.title=this.value"
							 id="DYNAMICPERFORMER_REALNAME" name="DYNAMICPERFORMER_REALNAME" 
							value=""
							readOnly  ><input name="" id="DYNAMICPERFORMER_BUT" type="button" value="" class="but_x" style="float:left;" />
						<INPUT type="hidden" class="cText_out" id="DYNAMICPERFORMER" name="DYNAMICPERFORMER" /> 
						<INPUT type="hidden" class="cText_out" id="DYNAMICPERFORMER_ID" name="DYNAMICPERFORMER_ID" />
					</div> 
				
				<div style="float:left;padding-right: 15px;padding-left:32px;" id="btnCompleteActdiv">
					<input class='but_y_06' onMouseOver=javascript:$(this).attr('class','but_y_07'); 
						onMouseOut=javascript:$(this).attr('class','but_y_06'); type="button" 
						 name="btnCompleteAct" value="<%=doCompleteWorkButStr %>" onClick="doCompleteWorkflow('<%=entrance%>')" id="btnCompleteAct" />
					</div>
						 <div style="float:left; padding-right: 15px; " id="terminationFlow_div">
						<input class='but_y_06' onMouseOver=javascript:$(this).attr('class','but_y_07'); 
						onMouseOut=javascript:$(this).attr('class','but_y_06'); type="button"
						 name="terminationFlow" value="终止<%=action_alias %>" onClick="doTerminationFlow('<%=entrance%>')" id="terminationFlow" />
						 </div>
						 <div style="float:left; padding-right: 15px;" id="btnBack_div">
						<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); 
						onMouseOut=javascript:$(this).attr('class','but_y_01'); type="button" 
						name="btnBack" value="回退" onclick="doFlowBack('<%=entrance%>')" id="btnBack" />
						</div>
						<div style="float:left; padding-right: 15px;">
						<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02');
						 onMouseOut=javascript:$(this).attr('class','but_y_01'); type="button" 
						name="btnreturn" value="返回" onclick="returnPage('<%=fromPage%>','<%=entrance%>','<%=action_name %>','<%=actionPage %>')" id="btnreturn" />
						</div>
						
						 <div style="float:left;padding-right: 15px;margin-top: 5px;" id="next_act_name_div">
						 <%if(CacheCommonManageProxy.getBooleanSystemParam("NextActName")){%>
						<!-- 下一环节的环节名称 -->
						下一环节名称：<input type="text" readonly="readonly"  style="width: 80px;border: 0px;color:#000;"
						 id="next_act_name" name="next_act_name"/>
						
						<%}%>
						</div>
			</div>
		</td>
	</tr>
	<!-- 流程操作区 -->
	<!-- 业务展示区 -->
	<tr>
		<td id="vcenter">
			<IFRAME style="WIDTH: 100%;" id="subFrame" name="subFrame" src="<%=path + action_form%>?busi_id=<%=busi_id %>&action_form=<%=action_form %>&action_name=<%=action_name %>&ins_id=<%=ins_id %>&action_defid=<%=action_defid %>&actiontype_code=<%=actiontype_code%>&def_id=<%=def_id%>&operType=<%=operType%>" frameborder="0" scrolling="no"></IFRAME>
		</td>
	</tr>
	<!-- 业务展示区 -->
</table>
</div>

<IFRAME name=frame1 width=100% height=0> </IFRAME> 

<!-- 隐藏参数区 -->
<input id="flowData" name="flowData" type="hidden"/>
<input id="busiData" name="busiData" type="hidden"/>
<input id="classNameId" name="classNameId" type="hidden"/>
<input id="bigColumnsValue" name="bigColumnsValue" type="hidden"/>
<input id="action_handeridea" name="action_handeridea" type="hidden"/>

<input id="xzspWorkflowType" name="xzspWorkflowType" type="hidden"/>
<input id="flowTache" name="flowTache" type="hidden" value="middle"/>
<input id="isDynamicSelectAct" name="isDynamicSelectAct" type="hidden"/>
<input id="isDynamicSelectUser" name="isDynamicSelectUser" value="<%=isDynamicSelectUser %>" type="hidden"/>
<input id="isDynamicSelectAndAct" name="isDynamicSelectAndAct" type="hidden"/>
<input id="nextActList" name="nextActList" type="hidden"/>
<input id="nextActId" name="nextActId" type="hidden"/>
<input id="end_type" name="end_type" type="hidden"/>
<input id="receive_userid" name="receive_userid" type="hidden"/>
<%--流程事项提交类型，默认是完成类型，但有时候在点该完成时是办结类型，所以就加了此隐藏域 --%>
<input id="submitType" value="docompleteworkflow" type="hidden">
<%--控制流程环节结束后的跳转 --%>
<input id="actionPage" name="actionPage" value="<%=actionPage%>" type="hidden"/>

<%--流程会签中  取得会签中所有用户ID --%>
<input id="notify_UserId" name="notify_UserId" value="" type="hidden"/>

<!-- 隐藏参数区 -->
</form>
</BODY>
</HTML>
