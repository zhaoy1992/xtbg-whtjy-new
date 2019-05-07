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
	
	String userName = accesscontroler.getUserAccount(); //用户名称
	String userRealName = accesscontroler.getUserName();
	String orgId = accesscontroler.getChargeOrgId(); //用户的机构ID
	String user_id = accesscontroler.getUserID();
	String entrance = request.getParameter("entrance");
	String backtype =request.getParameter("backtype");//从哪个入口进来的标志
	String actiontype_code = request.getParameter("actiontype_code");
	String openType = request.getParameter("openType");//取得标示（文件接收情况）
	String srid = request.getParameter("srid");//取得主键id（文件接收情况）
	String userOrgId_spcli = request.getParameter("userOrgId");//从文件接收情况的列表进入到页面
	String openFlag = request.getParameter("openFlag");//取得removewindow的id；
	String actionPage = request.getParameter("actionPage");
	
	//当前用户的机构id和机构名
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
	
	String flow_version = ""; //流程版本
	String flow_defid = ""; //流程定义ID
	String package_id = ""; //流程包
	String action_id = ""; //活动ID
	String action_name = ""; //活动名称
	String fromPage = "tabs-1";

	String list_type = request.getParameter("list_type"); //从那个列表来 tobe_work(暂存)
	String mgrName = request.getParameter("mgrName");
	String action_form = request.getParameter("action_form"); //表单
	String action_defid = request.getParameter("action_defid"); //活动定义ID
	String ins_code = request.getParameter("ins_code"); //实例编码
	String flow_id = request.getParameter("flow_id");//流程ID
	String def_id = request.getParameter("def_id");//流程定义ID

	String fromtype = request.getParameter("fromtype"); //fromtype = "newaccept" 新受理, fromtype = "temp" 暂存, fromtype = "fristpage" 首页
	String ins_id = request.getParameter("ins_id"); //实例ID
	String actInsId = request.getParameter("actInsId"); //活动实例ID
	String busi_id = request.getParameter("busi_id"); //业务ID
	String cc_form_instanceid = request
			.getParameter("cc_form_instanceid"); //平台业务ID
	String busiTypeCode = request.getParameter("busiTypeCode"); //流程类型编码
	String operType = request.getParameter("operType"); //操作类型
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
		ins_code = FlowClassUtil.getNewInstanceCode(busiTypeCode); //实例编号
	}

	if (StringUtil.isBlank(cc_form_instanceid)) { //新受理生成平台业务ID
		cc_form_instanceid = InstanceIdManager.getFormInstanceId();
	}
	String isDynamicSelectAndAct = Constant.STATUS_FALSE;//是否动态选择下一步与活动
	String isDynamicSelectUser = Constant.STATUS_FALSE; //是否动态选择或活动执行人

	String opType = "isShowActSelectText@isShowUserText@isShowBackButton@isShowRecycle@isShowCompleteWorkflow@isShowTempSaveForm@isShowTerminate@isShowSuspend@isShowResume";//流程行为标识
	InitFlowServiceIfc initFlowServiceIfc = new InitFlowServiceImpl();

	Map<String, String> initmap = new HashMap<String, String>();
	//初始化要用的参数
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
	String flowinfo = "";//流程信息
	String actionAliasAndOrderStr = ""; //环节别名与排序
	FlowDefinfoBean flowDefinfoBean = null; //流程定义Bean
	FlowWfactionBean flowWfactionBean = null; //活动定义Bean
	FlowWfactionExtBean flowWfactionExtBean = null; //流程活动扩展Bean
	InstanceBean instanceBean = null; //实例Bean

	Map<String, Object> map = initFlowServiceIfc.init(initmap);

	if (map.get("instanceBean") != null) {
		instanceBean = (InstanceBean) map.get("instanceBean");//活动定义Bean
		initmap.put("status_code", instanceBean.getStatus_code());
	}

	if (map.get("flowDefinfoBean") != null) {
		flowDefinfoBean = (FlowDefinfoBean) map.get("flowDefinfoBean");//流程定义Bean
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
				.get("flowWfactionBean");//活动定义Bean
		initmap.put("def_id", flowWfactionBean.getDef_id());
		def_id = flowWfactionBean.getDef_id();
		initmap.put("action_id", flowWfactionBean.getAction_id());
		initmap.put("action_name", flowWfactionBean.getAction_name());
		action_name = flowWfactionBean.getAction_name();
	}

	if (map.get("flowWfactionExtBean") != null) {
		flowWfactionExtBean = (FlowWfactionExtBean) map
				.get("flowWfactionExtBean");//活动定义Bean
		isDynamicSelectUser = flowWfactionExtBean.getIsshowuser();
		if ("Y".equals(isDynamicSelectUser)) {
			isDynamicSelectUser = "true";
		}
	}

	if (map.get("flowinfo") != null) {
		flowinfo = map.get("flowinfo").toString();//流程信息
	}

	if (map.get("actionAliasAndOrderStr") != null) {
		actionAliasAndOrderStr = map.get("actionAliasAndOrderStr")
				.toString();//环节别名与排序
	}

	JSONObject pageParmsjson = new JSONObject();
	pageParmsjson.put("flowParmJson", initmap); //将map对
	//System.out.println(action_form);
	String startButtonName="";
	//教育考试院  所有流程的启动按钮，统一修改名称为启动流程
	if(CacheCommonManageProxy.getBooleanSystemParam("workflow.startButtonName")){
		startButtonName = "启动流程";
	} else {
		startButtonName ="启动"+action_name;
	}
	if(action_name.indexOf("请假")>=0){
		actionPage="qingjia";
	}else if(action_name.indexOf("起草")>=0){
		actionPage="gongwen";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>公用流程启去页面</TITLE>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"  charset="utf-8"></script>
<!-- 引入其它 -->
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

var parms = <%=pageParmsjson%>;  //将java Json对象赋值给JS对象
var actionAliasAndOrderStr = "<%=actionAliasAndOrderStr%>";
/*
	函数:   init
	说明:   初始化公共流程处理开始页面
	参数:   无
	返回值: 无
*/
function init() {

	initByListType();
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
	var h = adaptationWH('_top','vcenter',-20);
	jQuery("#subFrame").height(h-12);
	
	//autoSetTabSize("subFrame");
}

/* 初始化动态选择执行人和动态选择执行活动，视情况隐藏或展示 */
function initDynamicWorkflow(){
    var ret = initDynamicWorkflowSet("<%=flowinfo%>","start", "<%=actionAliasAndOrderStr%>"); //初始化动态选择
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
	<tr height="10px" id="flow_top_toolbar">	<!-- add by 陈建华，增加这行的id，有特殊用途，勿删！！！ -->
		<td id="_top" valign="top">
				<div id="itemBtnDiv" style="white-space: nowrap;float:left; width:100%;">
				<div id="xzsp_workflowControl_selectAndAct" style="DISPLAY: none; float:left; width:20%;">
					<div id="xzsp_selectAndAct_memo" style="font-size:12px;">选下一步环节</div> 
							<INPUT type="text" style="width=100px" class="cText_out" id="XZSPNEXTACT_NAME" name="XZSPNEXTACT_NAME"  onclick="openAndSelectActView()" readOnlysize=14> 
							<INPUT type="text" class="cText_out" id="XZSPNEXTACT" name="XZSPNEXTACT" style="DISPLAY: none">
				</div> &nbsp;&nbsp;&nbsp;
				<div id="xzsp_workflowControl_selectOrAct" style="DISPLAY: none;float:left;margin-left: 10px;">
							<font style="font-size:12px;float:left; border:none; cursor:pointer; margin-top: 3px">选下一步环节：</font>
							<SELECT id="xzsp_workflowControl_selectAct"></SELECT>

				</div>
					<div id="xzsp_workflowControl_selectUser" style="DISPLAY: none;float:left;margin-left: 35px;margin-right: 10px;">
						<font style="font-size:12px;float:left; border:none; cursor:pointer; margin-top: 5px">选执行人： </font>
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
						name="btnTemp" value="暂存<%=action_name %>" onClick="doTemp('<%=entrance%>','<%=action_name %>','<%=actionPage %>')" id="btnTemp" />
					</div>
						<div style="float:left; padding-right: 15px">
						<input class='but_y_06' onMouseOver=javascript:jQuery(this).attr('class','but_y_07'); 
						onMouseOut=javascript:jQuery(this).attr('class','but_y_06'); style="margin-top: 2px" type="button"
				        name="startflaw" value="<%=startButtonName%>" onClick="doStartFlow('<%=entrance%>','<%=action_name%>','<%=actionPage %>')" id="startflaw" />
				        </div>
				        <div style="float:left;padding-right: 15px">
				        <input class='but_y_01' onMouseOver=javascript:jQuery(this).attr('class','but_y_02'); 
						onMouseOut=javascript:jQuery(this).attr('class','but_y_01'); style="margin-top: 2px" type="button"
						name="btnreturn" value="返回" onclick="returnPage('<%=fromPage%>','<%=entrance%>','<%=openFlag %>','<%=actionPage%>')" id="btnreturn" />
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
			<IFRAME style="WIDTH: 100%;" id="subFrame" name="subFrame" src="<%=path + action_form%>?busi_id=<%=busi_id%>&action_name=<%=action_name%>&backtype=<%=backtype %>&entrance=<%=entrance %>&operType=<%=operType %>&actiontype_code=<%=actiontype_code %>&srid=<%=srid %>&action_defid=<%=action_defid %>&ins_id=<%=ins_id %>&action_name=<%=action_name %>&def_id=<%=def_id %>" frameborder="0" scrolling="no"></IFRAME>
		</td>
	</tr>
	<!-- 业务展示区 -->
</table>


<IFRAME name=frame1 width=100% height=0> </IFRAME> 

<!-- 隐藏参数区 -->
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

<!-- 隐藏参数区 -->
</form>
</BODY>
</HTML>
