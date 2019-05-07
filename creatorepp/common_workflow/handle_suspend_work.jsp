<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl
,org.enhydra.shark.api.client.wfmodel.WfActivity
,org.enhydra.shark.SharkUtilities
,org.enhydra.shark.xpdl.elements.Activity
,java.util.List,com.frameworkset.util.StringUtil
,com.chinacreator.workflow.shark.SharkEngine
,com.chinacreator.workflow.shark.ActivityBackward
,com.chinacreator.spi.impl.local.EformManagerImpl
,com.chinacreator.commonworkflow.WorkflowOpertionWrapper
,org.enhydra.shark.api.SharkTransaction
,com.chinacreator.workflow.shark.SharkUtil
,com.lutris.appserver.server.sql.DBConnection,org.apache.log4j.Logger
,com.chinacreator.spi.api.EformManager
,com.chinacreator.commonworkflow.ComponentFactory 
,com.chinacreator.commonworkflow.util.FormUtils
,com.chinacreator.workflow.shark.procconfig.ProcessConfigManager
,com.chinacreator.epp.util.EgpManager"%>

<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="org.enhydra.shark.SharkEngineManager"%>
<%@page import="org.enhydra.shark.api.common.SharkConstants"%>
<%! 
	private static final Logger logger = Logger
			.getLogger("handle_suspend_work");
%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String actInsId = request.getParameter("actInsId");
	String procInsId = request.getParameter("procInsId");
	
	//动态跳转
	String url = "";
	String listFolder = StringUtil.replaceNull(request.getParameter("url"));
	if(listFolder.length() > 0) {
		url = "/"+listFolder+"/";
	}else{
		url = "/common_workflow/";
	}
	url += "suspend_work_list.jsp";
	String backUrl = "../"+url;

	String busiId = request.getParameter("busiId");
	String isError = (String) request.getAttribute("isError");
	String message = (String) request.getAttribute("message");
	String moduleId = (String) request.getParameter("moduleId");//add by luming。tang
	//获取模块数据源，如果是非平台配置的模块数据源，需要替换此处
//	String moduleDBName = EgpManager.getMenuDBNameByMenuID(accesscontroler.getCurrentSystemID(),moduleId);
	
    if(isError == null)
	{
		isError = "";
	}	

	ActivityBackward activityBackward = new ActivityBackward();

	String isShowUser = "true";
	String userName = accesscontroler.getUserAccount();
	String procDefId="";
	String mgrName="";
	String mgrNameEncode="";
	String procDefName="";
	String actDefId="";
	String actDefName="";
	//活动表单的定义id
	String formDefId = "";
	boolean isShowRecycleButton = true;
    boolean hasFlowButt = false;
    boolean isEformPage = true;//是否为eform页面 add by luming.tang at 2009-6-23
    SharkTransaction t=null;
    DBConnection dbConn = null;    
    SharkEngine shark = SharkEngine.getInstance();
    try{
    	t=SharkUtil.createTransaction();
    	shark.loginWorkflowServer(t,userName,"");
    	dbConn = SharkUtil.getDBConnection(t);	
	if (procInsId == null || procInsId.length() < 1) {
		WorkflowOpertionWrapper impl = new WorkflowOpertionWrapper();
		procInsId = impl.getProcIdByactInsId(t,actInsId);
	}
	    if(procInsId == null || procInsId.length() < 1){
	    	isShowRecycleButton = false;  
	    }else{	    
	    	try{
	    		WfActivity act = SharkUtil.currentLoginInfo()
	    		.getExecutionAdministration().getActivity(t, actInsId);
	    		procDefId = act.container(t).manager(t).process_definition_id(t);
	    		mgrName = act.container(t).manager(t).name(t);
	    		mgrNameEncode = StringUtil.encode(mgrName);
	    		procDefName = act.container(t).manager(t).process_definition_name(t);
	    		Activity actDefObj = SharkUtilities.getActivityDefinition(t, actInsId);
	    		actDefId = actDefObj.getId();
	    		actDefName = actDefObj.getName();    		
	      
	    		//formDefId = shark.getFormDefIdFromActIns(t,actInsId);
    		//这里从外围配置中获取活动配置的表单,如果没有则从定义中取 add by luming.tang at 2009-6-23
			ProcessConfigManager procConfigManager = new ProcessConfigManager();
			formDefId = procConfigManager.getActivityFormByInsId(procInsId, actInsId);
			if(formDefId==null || "".equals(formDefId)){
				formDefId = shark.getFormDefIdFromActIns(t, actInsId);
			}
			// 判断表单是否包含工作流控件
			//EformManager eformImpl = ComponentFactory.getEformManagerInstance();
			//hasFlowButt = eformImpl.hasWorkFlowButton(formDefId);
			//add by luming.tang at 2009-6-23
			isEformPage=(!FormUtils.isURL(formDefId));
			if(isEformPage){
				EformManager eformImpl = ComponentFactory.getEformManagerInstance();
				hasFlowButt = eformImpl.hasWorkFlowButton(formDefId);
			}else{//如果表单是jsp页面
				hasFlowButt =  false;
			} 		  		
	    		 //判断该节点是否允许收回
	    		List list = activityBackward.validateRedo(t,procInsId,actInsId);
	            if(list == null|| list.size() == 0){            
	            	isShowRecycleButton = false;
	            }
	            
	    	}catch(Exception e){	    		
	    		e.printStackTrace();
	    	}    
	    }
	 // 提交事务
		SharkUtil.commitTransaction(t);	
    }catch(Exception e){  
    	logger.error("handle_done_work.jsp:工作流接口异常。");
		try {
			// 回滚事务
			SharkUtil.rollbackTransaction(t,dbConn);
		} catch (Exception ex) {
			logger.error("exception in rollbackTransaction:", ex);				
		}
    }finally {
		//add by minghua.guo 2010-7-30 关闭连接
		if(dbConn != null){
			dbConn.release();
		}
		shark.logoutWorkflowServer(t);// 退出工作流
		try {
			// 释放事务
			SharkUtil.releaseTransaction(t);
		} catch (Exception e) {
			logger.error("exception in releaseTransaction:",e);				
		}
	}

	//add by minghua.guo[2011-04-14] 获取用户名，设置登录用户机构id到工作流引擎
	String user_name = (String) request.getParameter("userName");
	//当前待办任务用户处理机构id
	String login_orgid = "";
	if(SharkEngineManager.getInstance().isSys_user_enablemutiorg()){//判断是否启动兼职借调
		//shark.setLogin_orgid(user_name);
		if(user_name!= null && user_name.indexOf(SharkConstants.USER_ORG_TOKEN) > 0){
			login_orgid = user_name.substring(user_name.indexOf(SharkConstants.USER_ORG_TOKEN) + SharkConstants.USER_ORG_TOKEN.length());
		}else{
			login_orgid = "";
		}
	}
%>
<html>
<title></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
<script language="JavaScript" 
		src="<%=request.getContextPath()%>/eformsys/fceform/js/openDjUrl.js"
		type="text/javascript">
</script>
<script src="<%=request.getContextPath()%>/eformsys/fceform/js/fcpub.js"></script>
<script language="JavaScript">
<%if(isError.equals("true")){%>
	alert("<%=message%>");
<%}%>
function resume()
{
	displayBut();
	document.workflowform.action="<%=request.getContextPath()%>/common_workflow/commonworkflow.jsp?method=resumeSuspendedAct";
	document.workflowform.submit();	
}
function displayBut()
{
	if(document.workflowform.cmplt_form)document.workflowform.cmplt_form.style.display = "none";
	if(document.workflowform.but_back)document.workflowform.but_back.style.display = "none";
}
function back()
{
	displayBut();
    document.location = "<%=backUrl%>";
}
</script>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" >
<%
if (hasFlowButt) {
%>
	<div style="display:none;">
<%
}
%>
	<DIV valign=top style="width:100%;height:0;overflow:auto;">
	<form name="workflowform" action="handle_form.jsp" method="post">
	<input type="hidden" name="busiId" value="">
	<input type="hidden" name="actInsId" value="<%=actInsId%>">
	<input type="hidden" name="curUserName" value="<%=userName%>">
	<input type="hidden" name="formDefId" value="<%=formDefId%>">
	<input type="hidden" name="url" value="<%=url%>">
	  <table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
		<tr>
		  <td align="right">
			<input class="input" type="button" name="cmplt_form" value="恢复" onClick="resume()">
	        <input class="input" type="button" name="but_back" value="返回" onClick="back()">
		  </td>
		</tr>	
	  </table>
	</form>
	</DIV>
<%
if (hasFlowButt) {
%>
	</div>
<%
}
%>
<div style="width:100%;height:530;overflow:auto">
<form name="eform" action="" method="post">
 <table width="99%" cellpadding="0" cellspacing="0" border="1" style="padding:2 " bordercolorlight="#3B4D61" bordercolordark="#ffffff">
 <tr>
   <td  valign="top">
   	 <iframe name="r_down" height=500px width="100%" src=""  frameborder="0" ></iframe>
   </td>
 </tr>
</table>
</form>
</div>
</body>
<script language="JavaScript">
//设置处理机构
//fcpubdata.login_orgid="<%=login_orgid %>";
<%
//设置处理机构
request.getSession().setAttribute(busiId, login_orgid);
//改变系统默认数据源
//if(moduleDBName!=null && !"".equals(moduleDBName)){
//	session.setAttribute("menuDatasource",moduleDBName);
//}else{
//	session.setAttribute("menuDatasource",EgpManager.getAppDBName());
//}
//add by minghua.guo 20-04-11 加actDefId和自定义参数
String queryString = request.getQueryString();
// 非正常菜单页面打开会重复
if(queryString.indexOf("&cc_form_instanceid=undefined")>-1)
{
	queryString = queryString.replace("&cc_form_instanceid=undefined"," ");
}
if(isEformPage){%> 
 r_down.document.location=kcpubdata.openDjUrl+"<%=formDefId%>&cc_form_instanceid=<%=busiId%>"
 + "&workflowId=<%=procDefId%>&oid=<%=actDefId%>&procInsId=<%=procInsId%>&actInsId=<%=actInsId%>"
 + "&mgrName=<%=mgrNameEncode%>&procDefName=<%=procDefName%>&actDefName=<%=actDefName%>&operType=suspend&moduleId=<%=moduleId%>&actDefId=<%=actDefId%>&<%=queryString %>";
  <%}else{//如果不是eform表单
 	String formUrl = request.getContextPath()+formDefId+((formDefId.indexOf("?")==-1)?"?":"&")
 				+"cc_form_instanceid="+busiId+"&workflowId="+procDefId
 				+"&oid="+actDefId+"&procInsId="+procInsId+"&operType=suspend"
 				+"&procDefName="+procDefName+"&actDefId="+actDefId
 				+"&actInsId="+actInsId+"&mgrName="+mgrNameEncode
 				+"&actDefName="+actDefName+"&moduleId="+moduleId+"&actDefId="+actDefId+"&"+queryString;
		formUrl = java.net.URLEncoder.encode(formUrl);
		%>
		r_down.document.location="formFrame.jsp?url=<%=formUrl%>";
 <%}%> 
 
 <%if(hasFlowButt){%>
 	displayBut();
 <%}%>
 function displayBut()
{
	if(document.workflowform.cmplt_form)document.workflowform.cmplt_form.style.display = "none";
	if(document.workflowform.but_back)document.workflowform.but_back.style.display = "none";
	<%
	
	if(!isShowRecycleButton){%>
	//eForm.height="570";
	//r_down.height="570";
	<%}%>
}
</script>
</html>

