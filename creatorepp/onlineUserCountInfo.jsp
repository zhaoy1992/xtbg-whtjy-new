<%@page contentType="text/html;charset=GBK" session="false"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.remote.Utils"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.jgroups.util.Rsp"%>
<%@page import="java.util.Vector"%>
<%@page import="org.jgroups.stack.IpAddress"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>

<%


%>

<html>
<head><title>BS��CS�����û���ͳ��</title>
	<link rel="stylesheet" type="text/css" href="sysmanager/css/windows.css">
		<tab:tabConfig/>	
		<script src="../inc/js/func.js"></script>
		<script type="text/javascript" languge="Javascript">
	function flushButton(){
		document.location = document.location;
	}
	
	window.setInterval("flushButton()", 30000);
	</script>
</head>

<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onload="" scroll="no">

<div style="width:100%;height:100%;overflow:auto">
<form  name="LogForm"  method="post">
	<fieldset>
	<LEGEND align=left><strong>&nbsp;BS��������ͳ����Ϣ&nbsp;</strong></LEGEND>
	<table width="100%" height="" border="0" cellpadding="0" cellspacing="1" class="thin">
	<div align="right" ><input type="button" value="ˢ��ҳ��" class="input" onclick="flushButton()"></div>
	<tr>
	<th>��������</th>
	<th>�����û���</th>
	</tr>
	<% 
		Map onlineUserCount = Utils.getOnlineUserCount();
		
		Vector appServers = Utils.getAppservers();
		//Set countinfo = onlineUserCount.entrySet();
		//Iterator countIte = countinfo.iterator();
		int allUsercount = 0;
		int i = 1;
		for(int appCount = 0; appCount < appServers.size(); appCount++){
			IpAddress ipAddress = (IpAddress)appServers.get(appCount);
			String ipPort = ipAddress.toString();
			Rsp rsp = (Rsp)onlineUserCount.get(ipAddress);
		//}
		//while(countIte.hasNext()){
		//	Map.Entry entry = (Map.Entry)countIte.next();
		//	String ipPort = entry.getKey().toString();
		//	Rsp rsp = (Rsp)entry.getValue();
		
			int userCount = ((Integer)rsp.getValue()).intValue();
			allUsercount += userCount;
	%>
	<tr>
	<td><strong>server<%=i++ %>-----<%=ipPort %></strong></td>
	<td><%=userCount %></td>
	</tr>
	<% 
		}
	%>
	<tr>
	<td colspan="2"><strong>BS����������Ϊ��<%=allUsercount %></strong></td>
	</tr>
	</table>
	</fieldset>
	<br>
	<fieldset>
	<LEGEND align=left><strong>&nbsp;CS��������ͳ����Ϣ&nbsp;</strong></LEGEND>
	<table width="100%" height="" border="0" cellpadding="0" cellspacing="1" class="thin">
	<% 
		DBUtil db = new DBUtil();
		db.executeSelect("bspf","select count(*) from hnds.td_sm_user t where t.logon_ip is not null");
		int CScount = db.getInt(0,0);
	%>
	<div align="right" ><input type="button" value="ˢ��ҳ��" class="input" onclick="flushButton()"></div>
	<TR>
	<TD COLSPAN="2">
	<strong>CS����������Ϊ��<%=CScount %></strong>
	</TD>
	</TR>
	</table>
	</fieldset>
</form>
</div>
</body>


</html>