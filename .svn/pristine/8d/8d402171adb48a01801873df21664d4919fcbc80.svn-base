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
	
	String openFlag = request.getParameter("openFlag");//取得removewindow的id；
	
	String actionPage = request.getParameter("actionPage");
	//当为上网材料时不归档
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
	//初始化要用的参数
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
		initmap.put("flow_id",flowDefinfoBean.getFlow_id());
		initmap.put("action_form",flowDefinfoBean.getAction_form());
		action_form = flowDefinfoBean.getAction_form();
		
	}
	
	if(map.get("flowWfactionBean") != null){
		flowWfactionBean = (FlowWfactionBean)map.get("flowWfactionBean");//活动定义Bean
		initmap.put("def_id", flowWfactionBean.getDef_id());
		initmap.put("action_id", flowWfactionBean.getAction_id());
		initmap.put("action_name", flowWfactionBean.getAction_name());
		action_name = flowWfactionBean.getAction_name();
		action_id =flowWfactionBean.getAction_id();
	}
	JSONObject pageParmsjson = new JSONObject();
	pageParmsjson.put("flowParmJson", initmap);	//将map对
	
	String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>

<TITLE>公用流程办结页面</TITLE>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="utf-8"></script>
<!-- 引入其它 -->
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

var parms = <%=pageParmsjson%>;  //将java Json对象赋值给JS对象

/*
	函数:   init
	说明:   初始化公共流程处理开始页面
	参数:   无
	返回值: 无
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
</HEAD>
<BODY onload="init()">
<form name="form1" method="post" id="form1" action="">
<div>
<table width="100%" >
	<!-- 流程操作区 -->
	<tr height="10px">
		<td id="_top" style="padding-left: 32px;">
		<div style="float:left;padding-right: 5px;padding-left:5px;" id="startflawdiv">
			<input class='but_y_01'  type="button"
			 name="startflaw" id="startflaw" value="办结" onClick="doFinishWorkflow('<%=entrance %>','<%=StringUtil.deNull(userArea)%>')" />
		</div>
			 <%if("421000".equals(StringUtil.deNull(userArea))) {%>
			 <div style="float:left;padding-right: 5px;padding-left:5px;">
			 <input class='but_y_01'   type="button" 
			 name="arch_but" id="arch_but"  value="归档" onclick="archives();" />
			 </div>
			 <%} %>
			 <div style="float:left;padding-right: 5px;padding-left:5px;">
			 <input class='but_y_01'   type="button" 
			 name="btnreturn" value="返回" onclick="returnPage('<%=fromPage%>','<%=entrance %>','<%=openFlag %>','<%=actionPage%>')" id="btnreturn" />
			 </div>
		</td>
	</tr>
	<!-- 流程操作区 -->
	
	<!-- 业务展示区 -->
	<tr>
		<td id="vcenter">
			<IFRAME style="WIDTH: 100%;" id="subFrame" name="subFrame" src="<%=path + action_form %>?busi_id=<%=busi_id %>&action_form=<%=action_form %>&ins_id=<%=ins_id %>&action_name=<%=action_name %>&action_defid=<%=action_defid %>&operType=<%=operType %>&actiontype_code=<%=actiontype_code %>&action_id=<%=action_id %>" frameborder="0" scrolling="no"></IFRAME>
		</td>
	</tr>
	<!-- 业务展示区 -->
</tabel>
</div>

<IFRAME name=frame1 width=100% height=0> </IFRAME> 

<!-- 隐藏参数区 -->
<input id="flowData" name="flowData" type="hidden"/>
<input id="busiData" name="busiData" type="hidden"/>
<input id="classNameId" name="classNameId" type="hidden"/>
<input id="bigColumnsValue" name="bigColumnsValue" type="hidden"/>
<input id="action_handeridea" name="action_handeridea" type="hidden"/>

<input id="xzspWorkflowType" name="xzspWorkflowType" type="hidden"/>
<input id="flowTache" name="flowTache" type="hidden"/>

<input id="end_type" name="end_type" type="hidden"/>
<input id="receive_userid" name="receive_userid" type="hidden"/>
<%--控制流程环节结束后的跳转 --%>
<input id="actionPage" name="actionPage" value="<%=actionPage%>" type="hidden"/>

<!-- 隐藏参数区 -->
</form>
</BODY>
</HTML>
