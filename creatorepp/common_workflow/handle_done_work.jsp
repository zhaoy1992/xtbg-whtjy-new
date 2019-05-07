<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl
,java.util.List,com.frameworkset.util.StringUtil
,com.chinacreator.workflow.shark.SharkEngine
,com.chinacreator.workflow.shark.ActivityBackward
,org.enhydra.shark.api.client.wfmodel.WfActivity
,org.enhydra.shark.SharkUtilities
,org.enhydra.shark.xpdl.elements.Activity
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
			.getLogger("handle_done_work");
%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String actInsId = request.getParameter("actInsId");
	String procInsId = request.getParameter("procInsId");
	
	//��̬��ת
	String url = "";
	String listFolder = StringUtil.replaceNull(request.getParameter("url"));
	if(listFolder.length() > 0) {
		url = "/"+listFolder+"/";
	}else{
		url = "/common_workflow/";
	}
	url += "done_work_list.jsp";
	String backUrl = "../"+url;
	String busiId = request.getParameter("busiId");
	String isError = (String) request.getAttribute("isError");
	String message = (String) request.getAttribute("message");
	String moduleId = (String) request.getParameter("moduleId");//add by luming��tang
	//��ȡģ������Դ������Ƿ�ƽ̨���õ�ģ������Դ����Ҫ�滻�˴�
	//String moduleDBName = EgpManager.getMenuDBNameByMenuID(accesscontroler.getCurrentSystemID(),moduleId);
	
    if(isError == null)
	{
		isError = "";
	}
    SharkTransaction t=null;
    DBConnection dbConn = null;    
	SharkEngine shark = SharkEngine.getInstance(); 	
	ActivityBackward activityBackward = new ActivityBackward();	
	String isShowUser = "true";
	String userName = accesscontroler.getUserAccount();
	String procDefId="";
	String mgrName="";
	String mgrNameEncode="";
	String procDefName="";
	String actDefId="";
	String actDefName="";
	//����Ķ���id
	String formDefId = "";
	boolean isShowRecycleButton = true;
    boolean hasFlowButt = false;   
    boolean isEformPage = true;//�Ƿ�Ϊeformҳ�� add by luming.tang at 2009-6-23
    if(procInsId == null || procInsId.length() < 1){
    	isShowRecycleButton = false;  
    }else{	    
    	try{
    		t=SharkUtil.createTransaction();
    		shark.loginWorkflowServer(t,userName,"");
    		dbConn = SharkUtil.getDBConnection(t);
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
    		//�������Χ�����л�ȡ����õı�,���û����Ӷ�����ȡ add by luming.tang at 2009-6-23
			ProcessConfigManager procConfigManager = new ProcessConfigManager();
			formDefId = procConfigManager.getActivityFormByInsId(procInsId, actInsId);
			if(formDefId==null || "".equals(formDefId)){
				formDefId = shark.getFormDefIdFromActIns(t, actInsId);
			}
			// �жϱ��Ƿ�����������ؼ�
			//EformManager eformImpl = ComponentFactory.getEformManagerInstance();
			//hasFlowButt = eformImpl.hasWorkFlowButton(formDefId);
			//add by luming.tang at 2009-6-23
			isEformPage=(!FormUtils.isURL(formDefId));
			if(isEformPage){
				EformManager eformImpl = ComponentFactory.getEformManagerInstance();
				hasFlowButt = eformImpl.hasWorkFlowButton(formDefId);
			}else{//�������jspҳ��
				hasFlowButt =  false;
			}
			
    		 //�жϸýڵ��Ƿ������ջ�
    		List list = activityBackward.validateRedo(t,procInsId,actInsId);
            if(list == null|| list.size() == 0){
              //  System.out.println();
            	isShowRecycleButton = false;
            }
           
            SharkUtil.commitTransaction(t);
    	}catch(Exception e)
    	{
    		System.out.println("handle_done_work.jsp:�������ӿ��쳣��");
    		try {
				// �ع�����
				SharkUtil.rollbackTransaction(t,dbConn);
			} catch (Exception ex) {
				logger.error("exception in rollbackTransaction:", ex);				
			}
    	}finally {
    		//add by minghua.guo 2010-7-30 �ر�����
    		if(dbConn != null){
    			dbConn.release();
    		}
    		shark.logoutWorkflowServer(t);// �˳�������
    		try {
				// �ͷ�����
				SharkUtil.releaseTransaction(t);
			} catch (Exception e) {
				logger.error("exception in releaseTransaction:",e);				
			}
    	}
    }
    
  //div  iframe�߶�
	String div1Height = "500";
	String div2Height = "0";
	String iframeHeight = "470";
	String tableStyle = "thin";
	//����������������ؼ�
	if(hasFlowButt){
		div1Height = "545";
		div2Height = "0";
		iframeHeight = "518";
		tableStyle = "";
	}

	//add by minghua.guo[2011-04-14] ��ȡ�û��������õ�¼�û�����id������������
	String user_name = (String) request.getParameter("userName");
	//��ǰ���������û��������id
	String login_orgid = "";
	if(SharkEngineManager.getInstance().isSys_user_enablemutiorg()){//�ж��Ƿ�������ְ���
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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css"/>
<script language="JavaScript" 
		src="<%=request.getContextPath()%>/eformsys/fceform/js/openDjUrl.js"
		type="text/javascript">
</script>
<script src="<%=request.getContextPath()%>/eformsys/fceform/js/fcpub.js"></script>
 
<script language="JavaScript">
<%if(isError.equals("true")){%>
	alert("<%=message%>");
<%}%>
function recycle()
{
	displayBut();
	document.workflowform.action="<%=request.getContextPath()%>/common_workflow/commonworkflow.jsp?method=recycleAct";
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
<%@ include file="/epp/css/cssControl.jsp"%><body onload="setIframeReadonly()" class="contentbodymargin" >
<DIV valign=top style="width:100%;height:<%=div2Height%>;overflow:auto">
<form name="workflowform" action="handle_form.jsp" method="post">
<input type="hidden" name="busiId" value="<%=busiId %>">
<input type="hidden" name="actInsId" value="<%=actInsId%>">
<input type="hidden" name="curUserName" value="<%=userName%>">
<input type="hidden" name="formDefId" value="<%=formDefId%>">
<input type="hidden" name="url" value="<%=url%>">
  <table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="<%=tableStyle%>">
	<tr>
	  <td align="right">
        <%if(isShowRecycleButton) {%>
		<input class="input" type="button" name="cmplt_form" value="��������" onClick="recycle()">
        <%} %>
        <input class="input" type="button" name="but_back" value="����" onClick="back()">
	  </td>
	</tr>	
  </table>
</form>
</DIV>
<div style="width:100%;height:<%=div1Height%>;overflow:auto">
<form name="eform" action="" method="post">
 <table width="100%" cellpadding="0" cellspacing="0" border="1" style="padding:2 " bordercolorlight="#3B4D61" bordercolordark="#ffffff">
 <tr>
   <td  valign="top">
   	 <iframe name="r_down" height=<%=iframeHeight%>px width="100%" src="" readonly  frameborder="0" ></iframe>
   </td>
 </tr>
</table>
</form>
</div>
</body>
<script language="JavaScript">
//���ô������
//fcpubdata.login_orgid="<%=login_orgid %>";
<%
//���ô������
request.getSession().setAttribute(busiId, login_orgid);
//�ı�ϵͳĬ������Դ
//if(moduleDBName!=null && !"".equals(moduleDBName)){
//	session.setAttribute("menuDatasource",moduleDBName);
//}else{
//	session.setAttribute("menuDatasource",EgpManager.getAppDBName());
//}
//add by minghua.guo 20-04-11 ��actDefId���Զ������
String queryString = request.getQueryString();
// �������˵�ҳ��򿪻��ظ�
if(queryString.indexOf("&cc_form_instanceid=undefined")>-1)
{
	queryString = queryString.replace("&cc_form_instanceid=undefined"," ");
}
if(isEformPage){%> 
 r_down.document.location=kcpubdata.openDjUrl+"<%=formDefId%>&cc_form_instanceid=<%=busiId%>"
 + "&workflowId=<%=procDefId%>&oid=<%=actDefId%>&procInsId=<%=procInsId%>&actInsId=<%=actInsId%>"
 + "&mgrName=<%=mgrNameEncode%>&procDefName=<%=procDefName%>&actDefName=<%=actDefName%>&moduleId=<%=moduleId%>&operType=readonly&actDefId=<%=actDefId%>&<%=queryString %>";
 <%}else{//�������eform��
 	String formUrl = request.getContextPath()+formDefId+((formDefId.indexOf("?")==-1)?"?":"&")
 				+"cc_form_instanceid="+busiId+"&workflowId="+procDefId
 				+"&oid="+actDefId+"&procInsId="+procInsId+"&operType=readonly"
 				+"&procDefName="+procDefName+"&actDefId="+actDefId
 				+"&actInsId="+actInsId+"&mgrName="+mgrNameEncode
 				+"&actDefName="+actDefName+"&moduleId="+moduleId+"&operType=readonly&actDefId="+actDefId+"&"+queryString;
		formUrl = java.net.URLEncoder.encode(formUrl);
		%>
		r_down.document.location="formFrame.jsp?url=<%=formUrl%>";
 <%}%> 
function setIframeReadonly(){
//var o = r_down.document.frames[1].document;
//	for(i = 0; i < o.all.length; i++){
//		if(o.all(i).tagName=="INPUT"){
//			//alert("readonly"+i+"="+o.all(i).onmovestart);
//			o.all(i).disabled = "true";
//		}
//		if(o.all(i).tagName=="BUTTON"){
//			o.all(i).style.display = "none";
//			//o.all(i).disabled = "true";
//		}
//		if(o.all(i).tagName=="TEXTAREA"){
//			o.all(i).disabled = "true";
//		}
//	}
}

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

