<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.spi.api.WorkflowManager"%>
<%@ page import="org.frameworkset.spi.BaseSPIManager"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);

	WorkflowManager workflowManager = (WorkflowManager) BaseSPIManager
			.getProvider("workflowManager");
	
	String action = request.getParameter("action");
	String actInsId1 = request.getParameter("actInsId1");
	String limitStr = request.getParameter("limitStr");
	String actInsId2 = request.getParameter("actInsId2");
	String userName1 = request.getParameter("userName1");
	String ret = "";
	if("applyDeferAct".equals(action)){
		try{
			boolean ret1 = workflowManager.applyDeferAct(actInsId1, limitStr);
			ret = ret1 + "";
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	if("getActDesignator".equals(action)){
		try{
			String ret1 = workflowManager.getActDesignator(actInsId2, userName1);
			ret = ret1 + "";
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>
<html>
	<head>
		<title>流程接口使用Demo2</title>

		<%@ include file="/epp/css/cssControl.jsp"%>
	</head>
	<script type="text/javascript">
	function handle(obj){
		document.getElementById("action").value = obj.name;
		workflow_form.submit();
	}
	</script>
	<body>
		<form name="workflow_form" action="workflowManagerApiDemo1.jsp"
			mdthod="post">
			<table cellspacing="0" cellpadding="0" border="0"
				bordercolor="#EEEEEE" width=100% class="thin" readonly>
				<input type="hidden" name="action" value="">
				<tr>
					<td align="center">
						<b>流程接口使用Demo2</b>
					</td>
				</tr>
				<tr>
					<td>
						流程接口类及其实现类实例化方法：
						<br />
						接口：com.chinacreator.spi.api.WorkflowManager
						<br />
						实例化：WorkflowManager impl =
						(WorkflowManager)org.frameworkset.spi.BaseSPIManager.getProvider("workflowManager");
						<br />
						其实现类在workflowmanager-provider.xml中配置。
						<br />
					</td>
				</tr>
				<tr>
					<td  title="用于在活动已经实例化，用户执行该活动任务项时动态的加入新的执行人。仅适用于单实例活动">
						<b>createSingleAssignments</b><font color="red">(</font>用户名：<input type="text" name="userName" value=""/>,活动实例id：<input type="text" name="actInsId" value=""/>,新的执行人：<input type="text" name="newExcutors" value=""/><font color="red">)</font>
						<input class="input" type="button" value="提交" name="createSingleAssignments" onClick="handle(this)"/>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('csa').style.display=='none'){document.getElementById('csa').style.display=''}else{document.getElementById('csa').style.display='none'}"><br/>
						<div id="csa"  style="display:none;color:#8080FF">
							java.lang.String createSingleAssignments(<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
                            &nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actInsId,<br/>
                            &nbsp;&nbsp;&nbsp;&nbsp;java.lang.String newExcutors<br/>
                            )<br/>
                                                                           用于在活动已经实例化，用户执行该活动任务项时动态的加入新的执行人。仅适用于单实例活动 <br/>
							参数：<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;userName - 用户名<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;actInsId - 活动实例id<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;newExcutors - 动态添加的执行人用户名（多个逗号隔开） <br/>
							返回：
							"true" 成功，"false" 失败<br/>
						</div>
					</td>
				</tr>
				<tr>
					<td title="删除所有的老版本流程包">
						<b>deleteAllOldVersionPackage</b><font color="red">(</font>是否强制删除：<select name="isTerminateFlowInstance1" value="false"><options><option value="true">是</option><option value="false">否</option></options></select><font color="red">)</font>
						<input class="input" type="button" value="提交" name="deleteAllOldVersionPackage" onClick="handle(this)"/>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('daovp').style.display=='none'){document.getElementById('daovp').style.display=''}else{document.getElementById('daovp').style.display='none'}"><br/>
						<div id="daovp" style="display:none;color:#8080FF">
							boolean deleteAllOldVersionPackage(<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;boolean isTerminateFlowInstance<br/>
							)<br/>
							删除所有的老版本流程包 <br/>
							参数：<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;isTerminateFlowInstance - 是否强制删除，为true的话将会强制删除那些不容许删除的包 <br/>
							返回：
							true/false<br/>
						</div>
					</td>
				</tr>
				<tr>
					<td title="删除所有的流程包">
						<b>deleteAllPackage</b><font color="red">(</font>是否强制删除：<select name="isTerminateFlowInstance2" value="false"><options><option value="true">是</option><option value="false">否</option></options></select><font color="red">)</font>
						<input class="input" type="button" value="提交" name="deleteAllPackage" onClick="handle(this)"/>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('dap').style.display=='none'){document.getElementById('dap').style.display=''}else{document.getElementById('dap').style.display='none'}"><br/>
						<div id="dap" style="display:none;color:#8080FF">
							boolean deleteAllPackage(<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;boolean isTerminateFlowInstance<br/>
							)<br/>
							描述：删除所有的流程包 <br/>
							参数：<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;isTerminateFlowInstance - 是否强制删除，为true的话将会强制删除那些不容许删除的包 <br/>
							返回：true/false<br/>			
						</div>
					</td>
				</tr>
				<tr>
					<td title="根据应用id删除所有的流程包">
						<b>deleteAllPackageByAppId</b><font color="red">(</font>应用ID：<input type="text" name="appId" value="">,是否强制删除：<select name="isTerminateFlowInstance3" value="false"><options><option value="true">是</option><option value="false">否</option></options></select><font color="red">)</font>
						<input class="input" type="button" value="提交" name="deleteAllPackageByAppId" onClick="handle(this)"/>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('dapbai').style.display=='none'){document.getElementById('dapbai').style.display=''}else{document.getElementById('dapbai').style.display='none'}"><br/>
						<div id="dapbai" style="display:none;color:#8080FF">
							boolean deleteAllPackageByAppId(<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String appId,<br/>
                            &nbsp;&nbsp;&nbsp;&nbsp;boolean isTerminateFlowInstance<br/>
                            )<br/>
                                                                          描述： 根据应用id删除所有的流程包<br/>
							参数：<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;appId - 应用id<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;isTerminateFlowInstance - 是否强制删除，为true的话将会强制删除那些不容许删除的包 <br/>
							返回：
							true/false<br/>
						</div>
					</td>
				</tr>
				<tr>
					<td title="根据流程包id删除所有的流程包">
						<b>deleteAllPackageByPkgId</b><font color="red">(</font>包ID：<input type="text" name="pkgId" value="">,是否强制删除：<select name="isTerminateFlowInstance4" value="false"><options><option value="true">是</option><option value="false">否</option></options></select><font color="red">)</font>
						<input class="input" type="button" value="提交" name="deleteAllPackageByPkgId" onClick="handle(this)"/>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('dapbpi').style.display=='none'){document.getElementById('dapbpi').style.display=''}else{document.getElementById('dapbpi').style.display='none'}"><br/>
						<div id="dapbpi" style="display:none;color:#8080FF">
							boolean deleteAllPackageByPkgId(<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String pkgId,<br/>
                            &nbsp;&nbsp;&nbsp;&nbsp;boolean isTerminateFlowInstance)<br/>
                                                                           描述：根据流程包id删除包 <br/>
							参数：<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;pkgId - 流程包id<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;isTerminateFlowInstance - 是否强制删除，为true的话将会强制删除那些不容许删除的包 <br/>
							返回：
							true/false<br/>
						</div>
					</td>
				</tr>
				<tr>
					<td title="活动申请延期">
						<b>applyDeferAct</b><font color="red">(</font>活动实例id：<input type="text" name="actInsId1" value="<%=actInsId1 %>">,延期期限：<input type="text" name="limitStr" value=""><font color="red">)</font>
						<input class="input" type="button" value="提交" name="applyDeferAct" onClick="handle(this)"/>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('ada').style.display=='none'){document.getElementById('ada').style.display=''}else{document.getElementById('ada').style.display='none'}"><br/>
						<div id="ada" style="display:none;color:#8080FF">
							boolean applyDeferAct(<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actInsId,<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String limitStr)<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;throws java.lang.Exception
							&nbsp;&nbsp;&nbsp;&nbsp;申请活动延期 <br/>
							参数：<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;actInsId - 活动实例id<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;limitStr - 延期期限(D/d,H/h)，如1D代表一天，h为小时 <br/>
							返回：
							&nbsp;&nbsp;&nbsp;&nbsp;boolean true/false 成功/失败 <br/>
							抛出： 
							&nbsp;&nbsp;&nbsp;&nbsp;java.lang.Exception<br/>

						</div>
					</td>
				</tr>
				<tr>
					<td title="获取任务委托人">
						<b>getActDesignator</b><font color="red">(</font>活动实例id：<input type="text" name="actInsId2" value="<%=actInsId2 %>">,当前用户名(兼职借调带机构id)：<input type="text" name="userName1" value=""><font color="red">)</font>
						<input class="input" type="button" value="提交" name="getActDesignator" onClick="handle(this)"/>
						<input class="input" type="button" value="展开" onClick="if(document.getElementById('gad').style.display=='none'){document.getElementById('gad').style.display=''}else{document.getElementById('gad').style.display='none'}"><br/>
						<div id="gad" style="display:none;color:#8080FF">
							String getActDesignator(<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;String actInsId, <br/>
							&nbsp;&nbsp;&nbsp;&nbsp;String userName) <br/>
							&nbsp;&nbsp;&nbsp;&nbsp;通过当前活动实例id和处理用户获取改任务的委托人 <br/>
							参数：<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;actInsId - 活动实例id<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;userName - 当前用户名(兼职借调[用户名+$+机构id]) <br/>
							返回：
							&nbsp;&nbsp;&nbsp;&nbsp;String 委托用户名(兼职借调[用户名+$+机构id])，返回null表示无委托人 <br/>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
<script type="text/javascript">
<!--
var ret = "<%=ret %>";
if(ret != ""){
	alert(ret);
}
//-->
</script>
