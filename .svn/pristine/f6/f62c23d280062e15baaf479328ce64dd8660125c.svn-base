<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.spi.impl.local.WorkflowManagerImpl"%>
<% 
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userName = accesscontroler.getUserAccount();						//当前操作用户名
	//当前流程信息
	String moduleId = request.getParameter("moduleId"); 					//模块id
	String actInsId = request.getParameter("actInsId"); 					//活动实例id
	String mgrName = request.getParameter("mgrName");   					//流程名
	String cc_form_instanceid = request.getParameter("cc_form_instanceid"); //业务id
	String procDefId = request.getParameter("procDefId"); 					//流程定义id
	String actDefName = request.getParameter("actDefName"); 				//活动名称
	String procInsId = request.getParameter("procInsId"); 					//流程实id例
	
	//被调用流程信息
	String bdyModuleId = request.getParameter("bdyModuleId"); 				//被调用模块id
	String bdyMgrName = request.getParameter("bdyMgrName"); 				//被调用流程名(最新版本)
	bdyModuleId = "beijiao";
	bdyMgrName = "beijiao#3#beijiao_wp1";
	
	String flag = request.getParameter("flag");
		java.util.Map map = new java.util.HashMap();						//控制参数
	if(flag != null && "complete".equals(flag)){
		WorkflowManagerImpl impl = new WorkflowManagerImpl();
		impl.suspendProcess(userName,actInsId);								//挂起活动
		String newCc_form_instanceid = cc_form_instanceid;					//被调用业务id
		map.put("START_ACTINS",actInsId);									//调用活动实例(是通过那个活动调用的)
		map.put("DYNAMICPERFORMER","pengsheng");							//动态执行人
		map.put("NEXT_ACT","");									//手动指定下一步活动
		impl.startWorkflowWrapper(userName,bdyMgrName,map,newCc_form_instanceid,bdyModuleId);
		
		//以下启动另一个实例
		java.util.Map map1 = new java.util.HashMap();
		map1.put("START_ACTINS",actInsId);
		map1.put("DYNAMICPERFORMER","limao");
		impl.startWorkflowWrapper(userName,bdyMgrName,map1,newCc_form_instanceid,bdyModuleId);
	}
%>
<%=map.get("START_ACTINS")%>
