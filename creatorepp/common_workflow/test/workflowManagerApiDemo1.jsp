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
		<title>���̽ӿ�ʹ��Demo2</title>

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
						<b>���̽ӿ�ʹ��Demo2</b>
					</td>
				</tr>
				<tr>
					<td>
						���̽ӿ��༰��ʵ����ʵ����������
						<br />
						�ӿڣ�com.chinacreator.spi.api.WorkflowManager
						<br />
						ʵ������WorkflowManager impl =
						(WorkflowManager)org.frameworkset.spi.BaseSPIManager.getProvider("workflowManager");
						<br />
						��ʵ������workflowmanager-provider.xml�����á�
						<br />
					</td>
				</tr>
				<tr>
					<td  title="�����ڻ�Ѿ�ʵ�������û�ִ�иû������ʱ��̬�ļ����µ�ִ���ˡ��������ڵ�ʵ���">
						<b>createSingleAssignments</b><font color="red">(</font>�û�����<input type="text" name="userName" value=""/>,�ʵ��id��<input type="text" name="actInsId" value=""/>,�µ�ִ���ˣ�<input type="text" name="newExcutors" value=""/><font color="red">)</font>
						<input class="input" type="button" value="�ύ" name="createSingleAssignments" onClick="handle(this)"/>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('csa').style.display=='none'){document.getElementById('csa').style.display=''}else{document.getElementById('csa').style.display='none'}"><br/>
						<div id="csa"  style="display:none;color:#8080FF">
							java.lang.String createSingleAssignments(<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String userName,<br/>
                            &nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actInsId,<br/>
                            &nbsp;&nbsp;&nbsp;&nbsp;java.lang.String newExcutors<br/>
                            )<br/>
                                                                           �����ڻ�Ѿ�ʵ�������û�ִ�иû������ʱ��̬�ļ����µ�ִ���ˡ��������ڵ�ʵ��� <br/>
							������<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;userName - �û���<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;actInsId - �ʵ��id<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;newExcutors - ��̬��ӵ�ִ�����û�����������Ÿ����� <br/>
							���أ�
							"true" �ɹ���"false" ʧ��<br/>
						</div>
					</td>
				</tr>
				<tr>
					<td title="ɾ�����е��ϰ汾���̰�">
						<b>deleteAllOldVersionPackage</b><font color="red">(</font>�Ƿ�ǿ��ɾ����<select name="isTerminateFlowInstance1" value="false"><options><option value="true">��</option><option value="false">��</option></options></select><font color="red">)</font>
						<input class="input" type="button" value="�ύ" name="deleteAllOldVersionPackage" onClick="handle(this)"/>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('daovp').style.display=='none'){document.getElementById('daovp').style.display=''}else{document.getElementById('daovp').style.display='none'}"><br/>
						<div id="daovp" style="display:none;color:#8080FF">
							boolean deleteAllOldVersionPackage(<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;boolean isTerminateFlowInstance<br/>
							)<br/>
							ɾ�����е��ϰ汾���̰� <br/>
							������<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;isTerminateFlowInstance - �Ƿ�ǿ��ɾ����Ϊtrue�Ļ�����ǿ��ɾ����Щ������ɾ���İ� <br/>
							���أ�
							true/false<br/>
						</div>
					</td>
				</tr>
				<tr>
					<td title="ɾ�����е����̰�">
						<b>deleteAllPackage</b><font color="red">(</font>�Ƿ�ǿ��ɾ����<select name="isTerminateFlowInstance2" value="false"><options><option value="true">��</option><option value="false">��</option></options></select><font color="red">)</font>
						<input class="input" type="button" value="�ύ" name="deleteAllPackage" onClick="handle(this)"/>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('dap').style.display=='none'){document.getElementById('dap').style.display=''}else{document.getElementById('dap').style.display='none'}"><br/>
						<div id="dap" style="display:none;color:#8080FF">
							boolean deleteAllPackage(<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;boolean isTerminateFlowInstance<br/>
							)<br/>
							������ɾ�����е����̰� <br/>
							������<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;isTerminateFlowInstance - �Ƿ�ǿ��ɾ����Ϊtrue�Ļ�����ǿ��ɾ����Щ������ɾ���İ� <br/>
							���أ�true/false<br/>			
						</div>
					</td>
				</tr>
				<tr>
					<td title="����Ӧ��idɾ�����е����̰�">
						<b>deleteAllPackageByAppId</b><font color="red">(</font>Ӧ��ID��<input type="text" name="appId" value="">,�Ƿ�ǿ��ɾ����<select name="isTerminateFlowInstance3" value="false"><options><option value="true">��</option><option value="false">��</option></options></select><font color="red">)</font>
						<input class="input" type="button" value="�ύ" name="deleteAllPackageByAppId" onClick="handle(this)"/>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('dapbai').style.display=='none'){document.getElementById('dapbai').style.display=''}else{document.getElementById('dapbai').style.display='none'}"><br/>
						<div id="dapbai" style="display:none;color:#8080FF">
							boolean deleteAllPackageByAppId(<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String appId,<br/>
                            &nbsp;&nbsp;&nbsp;&nbsp;boolean isTerminateFlowInstance<br/>
                            )<br/>
                                                                          ������ ����Ӧ��idɾ�����е����̰�<br/>
							������<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;appId - Ӧ��id<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;isTerminateFlowInstance - �Ƿ�ǿ��ɾ����Ϊtrue�Ļ�����ǿ��ɾ����Щ������ɾ���İ� <br/>
							���أ�
							true/false<br/>
						</div>
					</td>
				</tr>
				<tr>
					<td title="�������̰�idɾ�����е����̰�">
						<b>deleteAllPackageByPkgId</b><font color="red">(</font>��ID��<input type="text" name="pkgId" value="">,�Ƿ�ǿ��ɾ����<select name="isTerminateFlowInstance4" value="false"><options><option value="true">��</option><option value="false">��</option></options></select><font color="red">)</font>
						<input class="input" type="button" value="�ύ" name="deleteAllPackageByPkgId" onClick="handle(this)"/>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('dapbpi').style.display=='none'){document.getElementById('dapbpi').style.display=''}else{document.getElementById('dapbpi').style.display='none'}"><br/>
						<div id="dapbpi" style="display:none;color:#8080FF">
							boolean deleteAllPackageByPkgId(<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String pkgId,<br/>
                            &nbsp;&nbsp;&nbsp;&nbsp;boolean isTerminateFlowInstance)<br/>
                                                                           �������������̰�idɾ���� <br/>
							������<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;pkgId - ���̰�id<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;isTerminateFlowInstance - �Ƿ�ǿ��ɾ����Ϊtrue�Ļ�����ǿ��ɾ����Щ������ɾ���İ� <br/>
							���أ�
							true/false<br/>
						</div>
					</td>
				</tr>
				<tr>
					<td title="���������">
						<b>applyDeferAct</b><font color="red">(</font>�ʵ��id��<input type="text" name="actInsId1" value="<%=actInsId1 %>">,�������ޣ�<input type="text" name="limitStr" value=""><font color="red">)</font>
						<input class="input" type="button" value="�ύ" name="applyDeferAct" onClick="handle(this)"/>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('ada').style.display=='none'){document.getElementById('ada').style.display=''}else{document.getElementById('ada').style.display='none'}"><br/>
						<div id="ada" style="display:none;color:#8080FF">
							boolean applyDeferAct(<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String actInsId,<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;java.lang.String limitStr)<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;throws java.lang.Exception
							&nbsp;&nbsp;&nbsp;&nbsp;�������� <br/>
							������<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;actInsId - �ʵ��id<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;limitStr - ��������(D/d,H/h)����1D����һ�죬hΪСʱ <br/>
							���أ�
							&nbsp;&nbsp;&nbsp;&nbsp;boolean true/false �ɹ�/ʧ�� <br/>
							�׳��� 
							&nbsp;&nbsp;&nbsp;&nbsp;java.lang.Exception<br/>

						</div>
					</td>
				</tr>
				<tr>
					<td title="��ȡ����ί����">
						<b>getActDesignator</b><font color="red">(</font>�ʵ��id��<input type="text" name="actInsId2" value="<%=actInsId2 %>">,��ǰ�û���(��ְ���������id)��<input type="text" name="userName1" value=""><font color="red">)</font>
						<input class="input" type="button" value="�ύ" name="getActDesignator" onClick="handle(this)"/>
						<input class="input" type="button" value="չ��" onClick="if(document.getElementById('gad').style.display=='none'){document.getElementById('gad').style.display=''}else{document.getElementById('gad').style.display='none'}"><br/>
						<div id="gad" style="display:none;color:#8080FF">
							String getActDesignator(<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;String actInsId, <br/>
							&nbsp;&nbsp;&nbsp;&nbsp;String userName) <br/>
							&nbsp;&nbsp;&nbsp;&nbsp;ͨ����ǰ�ʵ��id�ʹ����û���ȡ�������ί���� <br/>
							������<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;actInsId - �ʵ��id<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;userName - ��ǰ�û���(��ְ���[�û���+$+����id]) <br/>
							���أ�
							&nbsp;&nbsp;&nbsp;&nbsp;String ί���û���(��ְ���[�û���+$+����id])������null��ʾ��ί���� <br/>
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
