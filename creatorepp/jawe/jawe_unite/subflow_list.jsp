<%@page contentType="text/html;charset=GBK"%>
<%@page import="java.util.*" %>
<%@page import="com.chinacreator.epp.processmanage.dbmanager.ProcessManage,com.chinacreator.workflow.bean.ProcessDefinitionBean"%>
<%@page import="com.chinacreator.workflow.shark.SharkEngine"%>
<%@page import="com.chinacreator.workflow.bean.ProcessDefinitionBean"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
	SharkEngine se = SharkEngine.getInstance();
	se.loginWorkflowServer(control.getUserAccount(),"");
	String pname=request.getParameter("pname");
	pname=pname.replaceAll("~","#");
	System.out.println(pname);
	List list = se.getExternalPackages(pname);
	se.logoutWorkflowServer();
%>

<html>
	<head>
		<title>引用的流程列表</title>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
	   <link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
	  <link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
	  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
	  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
	  <link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">
	
		<script type="text/javascript">
				function openXpdl(ec_id,mgrName)
				{
					var tmp = escape(mgrName);
					window.showModalDialog("xpdl_open.jsp?ec_id="+ec_id+"&op=modify&mgrName="+tmp);
				}
		</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body>
		<script type="text/javascript">
			//alert("<%=list.size()%>");
		</script>
		
		<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">
					
					<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td height='20' class="headercolor">
								引用的流程
							</td>
							<td height='20' class="headercolor">
								子流程名称
							</td>
							<input class="text" type="hidden" name="selectId"/>
							<input name="delSingle" type="hidden" validator="string"
									maxlength="100" value="false"/>
						</tr>
						<!-- 循环体 -->
						<%
							for(int i=0;i<list.size();i++){
						%>
						<tr class="labeltable_middle_tr_01"
								onMouseOver="this.className='mousestyle1'"
								onMouseOut="this.className= 'mousestyle2'"
								>
								<td height='20' align="left" class="tablecells" onclick="">
									<%=i+1 %>
								</td>
								<td height='20' align="left" class="tablecells" onclick="">
									<%=list.get(i).toString() %>
								</td>
						</tr>
						<%} %>
					
		</table>
	</body>
</html>