<%
/*
 * <p>Title: ������ӳ���Ϣ</p>
 * <p>Description: ���ӳ�ʹ�����</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-9-8
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ page session="false" contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Enumeration,
				com.frameworkset.common.poolman.util.JDBCPoolMetaData"%>
<%@page import="com.chinacreator.remote.Utils"%>
<%@page import="org.jgroups.blocks.GroupRequest"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.jgroups.stack.IpAddress"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>	
<%@page import="org.jgroups.util.Rsp"%>			
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkAccess(request,response,false);
	String userAccount = accessControl.getUserAccount();
	
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>poolman���ӳ�ʹ�������������Ϣ</title>
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
		<tab:tabConfig/>	
		<script src="../../inc/js/func.js"></script>
		<script type="text/javascript" language="Javascript">
		function flushBotton(){
			document.location = document.location;
		}
		
		
		</script>
		</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onload="" scroll="no">
	<div style="width:100%;height:100%;overflow:auto">
	<div align="right"><input type="button" class="input" value="ˢ��ҳ��" onclick="flushBotton()"></div>
	<% 
		if(Utils.clusterstarted()){
			//System.out.println("�����Ǽ�Ⱥ��");
			//Map<ip:port,Map<dbname,Object[idleconnections,usedconnections,maxusedconnections,poolmetaData]>>
			Map poolMap = Utils.getDataSourceInfos();
			Vector appServers = Utils.getAppservers();
			if(poolMap == null){
				out.println("��ȡ��Ⱥ��ÿ̨�����������ݿ����ӳ�������Ϣ�쳣~~~��");
				return;
			}
			//Set serversinfo = poolMap.entrySet();
			//System.out.println("�����ķ��������� = " + serversinfo.size());
			//Iterator itServerInfo = serversinfo.iterator();
	%>
		<tab:tabContainer id="AllClusterMonitorinfo">
	<%
			int serversCount = 1;
			for(int appC = 0; appC < appServers.size(); appC++){
				IpAddress ipAddress = (IpAddress)appServers.get(appC);
				String ipPort = ipAddress.toString();
				Map objMap = (Map)(((Rsp)poolMap.get(ipAddress)).getValue());
			//}
			//while(itServerInfo.hasNext()){
			//	Map.Entry entry = (Map.Entry)itServerInfo.next();
			//	String ipPort = entry.getKey().toString();
			//	Rsp rsp = (Rsp)entry.getValue();
			
			//	Map objMap = (Map)rsp.getValue();
				if(objMap == null){
					out.println("�÷������˳�~~~��");
					continue;
				}
				Set poolmans = objMap.entrySet();
				Iterator itObjMap = poolmans.iterator();
				String container = ipPort+"Container";
				String titleServer = "server" + serversCount++ + "-----" + ipPort;
			
	%>
		<tab:tabPane id="<%=ipPort %>" tabTitle="<%=titleServer%>" >
		<tab:tabContainer id="<%=container %>">
	<% 
				while(itObjMap.hasNext()){
					Map.Entry entryPool = (Map.Entry)itObjMap.next();
					String poolname = entryPool.getKey().toString();
					if(poolname == null || "".equals(poolname)){
						continue;
					}
					Object[] object = (Object[])entryPool.getValue();
					JDBCPoolMetaData metadata = (JDBCPoolMetaData)object[3];
					String title = "���ݿ⣺"+poolname+" ���������";
	%>

			<tab:tabPane id="<%=poolname %>" tabTitle="<%=title%>" >	
				<form  name="LogForm"  method="post">
				<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr>
					<table>
					<tr><td colspan="3">���ݿ⣺<%=poolname %> ���������</td>
					</tr>
					<tr class="tr">
						
						<td width="16%" height="25" class="detailtitle" align="right">�������ӣ�</td>
						<td height="25">
						<%=object[0]%>
						</td>
						</tr>
						
						<tr class="tr">
						<td width="16%" height="25" class="detailtitle" align="right">����ʹ�����ӣ�</td>
						<td height="25" >
						<%=object[1]%>
						</td>
						</tr>
						
						<tr class="tr">
						<td width="16%" height="25" class="detailtitle" align="right">ʹ�����Ӹ߷�ֵ��</td>
						<td height="25" >
						<%=object[2]%>
						</td>
						</tr>
					</table>
					
					
						<tr>
						<table border="1">
						<caption>���ݿ⣺<%=poolname %>��������Ϣ</caption>
						<tr>
						<th>����������</th>
						<th>���Զ�Ӧֵ</th>
						<th>ȱʡֵ</th>
						<th>����</th>
						</tr>
						
						<tr>
						<td>driver</td>
						<td height="25"><%=metadata.getDriver() %></td>
						<td>��ȱʡֵ</td>
						<td>���ݿ�����</td>
						</tr>
						
						<tr>
						<td>url</td>
						<td height="25">
						<%if(userAccount.equals("admin")){ %><%=metadata.getURL() %><%}else{ %>
						******
						<%} %>
						</td>
						<td>��ȱʡֵ</td>
						<td>���ݿ����ӵ�ַ</td>
						</tr>
						
						<tr>
						<td>username</td>
						<td height="25">
						<%if(userAccount.equals("admin")){ %><%=metadata.getUserName() %>
						<%}else{ %>
						******
						<%} %></td>
						<td>��ȱʡֵ</td>
						<td>���ݿ��û���</td>
						</tr>
						
						<tr>
						<td>password</td>
						<td height="25"><%if(userAccount.equals("admin")){ %><%=metadata.getPassword() %><%}else{ %>
						******
						<%} %></td>
						<td>��ȱʡֵ</td>
						<td>���ݿ�����</td>
						</tr>
						
						
						<tr>
						<td>loadmetadata</td>
						<td height="25"><%=metadata.getLoadmetadata() %></td>
						<td>false</td>
						<td>�Ƿ�������ݿ�Դ����</td>
						</tr>
						
						<tr>
						<td>txIsolationLevel</td>
						<td height="25"><%=metadata.getTxIsolationLevel() %></td>
						<td>READ_COMMITTED</td>
						<td>������뼶��</td>
						</tr>
						
						<tr>
						<td>initialConnections</td>
						<td height="25"><%=metadata.getInitialConnections() %></td>
						<td>1</td>
						<td>��ʼ������,ȱʡΪ1</td>
						</tr>
						
						<tr>
						<td>minimumSize</td>
						<td height="25"><%=metadata.getMinimumSize() %></td>
						<td>0</td>
						<td>��С����������,ȱʡΪ0���������õĲ�ͬ�ɸ�ΪmaximumSize��һ�룬���maximumSizeΪ200��minimumSize��Ϊ100</td>
						</tr>
						
						<tr>
						<td>maximumSize</td>
						<td height="25"><%=metadata.getMaximumSize() %></td>
						<td>���������ֵ</td>
						<td>��������������,ȱʡֵΪ���������ֵ </td>
						</tr>
						
						<tr>
						<td>maximumSoft</td>
						<td height="25"><%=metadata.isMaximumSoft() %></td>
						<td>false</td>
						<td>����connection�ﵽmaximumSize�Ƿ������ٴ����µ�connection����true������ȱʡֵ ;false�������� </td>
						</tr>
						
						<tr>
						<td>removeAbandoned</td>
						<td height="25"><%=metadata.getRemoveAbandoned() %></td>
						<td>false</td>
						<td>�Ƿ��ⳬʱ���ӣ�����ʱ���ӣ�
    						true-��⣬�����⵽������ʱ�����ӣ�ϵͳ��ǿ�ƻ��գ��ͷţ�������;
    						false-����⣬Ĭ��ֵ
    					</td>
						</tr>
						
						<tr>
						<td>userTimeout</td>
						<td height="25"><%=metadata.getUserTimeout() %></td>
						<td>60 ��</td>
						<td>����ʹ�ó�ʱʱ�䣨����ʱʱ�䣩  ��λ����
    					</td>
						</tr>
						
						<tr>
						<td>logAbandoned</td>
						<td height="25"><%=metadata.isLogAbandoned() %></td>
						<td>true</td>
						<td>ϵͳǿ�ƻ�������ʱ���Ƿ������̨��־��������true-�����Ĭ��ֵ;false-�����
    					</td>
						</tr>
						
						<tr>
						<td>readOnly</td>
						<td height="25"><%=metadata.isReadOnly() %></td>
						<td>true</td>
						<td>���ݿ�Ự�Ƿ���readonly��ȱʡΪtrue
    					</td>
						</tr>
						
						<tr>
						<td>skimmerFrequency</td>
						<td height="25"><%=metadata.getSkimmerFrequency() %></td>
						<td>60 ��</td>
						<td>���տ������Ӳ������ʱ��,�루s��Ϊ��λ��ȱʡΪ60��</td>
						</tr>
						
						
						<tr>
						<td>connectionTimeout</td>
						<td height="25"><%=metadata.getConnectionTimeout() %></td>
						<td>1200 ��</td>
						<td>
						��λ����;
						�������ӻ���ʱ�䣬����ʱ�䳬��ָ����ֵʱ����������;ȱʡΪ1200��</td>
						</tr>
						
						<tr>
						<td>shrinkBy</td>
						<td height="25"><%=metadata.getShrinkBy() %></td>
						<td>5</td>
						<td>ÿ�λ��յ�������,���ս���ÿ�������յĿ�����������ȱʡֵ��5</td>
						</tr>
						
						<tr>
						<td>testWhileidle</td>
						<td height="25"><%=metadata.isTestWhileidle() %></td>
						<td>false</td>
						<td> ���������Ӵ���ʱ���Ƿ�Կ������ӽ�����Ч�Լ����ƿ��ء���
      						 true-��飬����鵽����Ч����ʱ��ֱ��������Ч���ӣ�
     						false-����飬ȱʡֵ</td>
						</tr>
						
						
						<tr>
						<td>keygenerate</td>
						<td height="25"><%=metadata.getKeygenerate() %></td>
						<td>auto</td>
						<td>�������ݿ��������ɻ���
        ȱʡ�Ĳ���ϵͳ�Դ����������ɻ��ƣ�
        �ⲽ������Ը���ϵͳ�������ɻ���
        ��ֵ����������
        auto:�Զ���һ�������������²��ø���ģʽ��
               ����˵���Ӧ�ò����������ݿ���Ӽ�¼������ͻ�����⣬Ч�ʸߣ���������������ж��Ӧ�ò�������ͬһ���ݿ�ʱ���������compositeģʽ;
        composite������Զ���ʵʱ�����ݿ��л�ȡ��������ֵ���ַ�ʽ���������������½�����ø���ģʽ��
                   ����˶��Ӧ��ͬʱ�������ݿ���Ӽ�¼ʱ������ͻ�����⣬Ч����Խϵͣ� ��������������ж��Ӧ�ò�������ͬһ���ݿ�ʱ���������compositeģʽ</td>
						</tr>
						
						<tr>
						<td>maxWait</td>
						<td height="25"><%=metadata.getMaxWait() %>&nbsp;��</td>
						<td>30 ��</td>
						<td>��ȡ���ӵȴ���ʱʱ��,��λ���룬ȱʡ�ȴ�ʱ��30�롣��Ӧ�ó�����������ʱ�����ӳ������е����Ӷ�����ʹ��״̬�������Ѿ��ﵽ���������ʱ��������ͻᴦ�ڵȴ�״̬������ȴ���ʱ�䳬��30�루maxWait���õ�ֵ��ʱ��ϵͳ���׳��������ӳ�ʱ�쳣��</td>
						</tr>
						
						<tr>
						<td>validationQuery</td>
						<td height="25"><%=metadata.getValidationQuery() %></td>
						<td>��ȱʡֵ</td>
						<td>У��sql��䡣Ӧ�ó�������ӳ���������ʱ�����ӳض����������ִ��У��sql��䣬���ִ�гɹ������ʶ����������Ч�ģ�ֱ�ӷ��ظ�Ӧ�ó��򣬷��򽫸�����ֱ�Ӵ����ӳ������٣��������µ����л�ȡ�µ�����
						��˷���ִ�У�ֱ�ӻ�ȡ����Ч������Ϊֹ
						</td>
						</tr>
						
						<tr>
						<td>poolingPreparedStatements</td>
						<td height="25"><%=metadata.isPoolPreparedStatements() %></td>
						<td>false</td>
						<td>Ԥ����statement�ػ����--true���ػ�;false�����ػ���Ĭ��ֵ
						</td>
						</tr>
						
						<tr>
						<td>maxOpenPreparedStatements</td>
						<td height="25"><%=metadata.getMaxOpenPreparedStatements() %></td>
						<td>-1</td>
						<td>ÿ��connection���򿪵�Ԥ����statements��,Ĭ��ֵΪ-1
						</td>
						</tr>
						</table>
						</tr>
						
						
						<tr>
						<td>
						*********************************************************************************
						</td>
						
						</tr>
						
			
			  </table>
			  </form>
			  </tab:tabPane>

	<% 
				}
	%>
		</tab:tabContainer>
		</tab:tabPane>

	<% 
			}
	%>
		</tab:tabContainer>
	<%
		}else{
		
	%>
	
	<tab:tabContainer id="singleMonitorinfo">
	<% 
		//List poollist = new ArrayList();
		DBUtil dbUtil = new DBUtil();
		Enumeration enum_ = dbUtil.getAllPoolnames();
		while(enum_.hasMoreElements()){
			String poolname = (String)enum_.nextElement();
			JDBCPoolMetaData metadata = DBUtil.getPool(poolname).getJDBCPoolMetadata();
		String title = "���ݿ⣺"+poolname+" ���������";
	%>
	
	<tab:tabPane id="<%=poolname %>" tabTitle="<%=title%>" >
	
	<form  name="LogForm"  method="post">
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr>
					<table>
					<tr><td colspan="3">���ݿ⣺<%=poolname %> ���������</td>
					</tr>
					<tr class="tr">
						
						<td width="16%" height="25" class="detailtitle" align="right">�������ӣ�</td>
						<td height="25">
						<%=DBUtil.getNumIdle(poolname)%>
						</td>
						</tr>
						
						<tr class="tr">
						<td width="16%" height="25" class="detailtitle" align="right">����ʹ�����ӣ�</td>
						<td height="25" >
						<%=DBUtil.getNumActive(poolname)%>
						</td>
						</tr>
						
						<tr class="tr">
						<td width="16%" height="25" class="detailtitle" align="right">ʹ�����Ӹ߷�ֵ��</td>
						<td height="25" >
						<%=DBUtil.getMaxNumActive(poolname)%>
						</td>
						</tr>
					</table>
					
					
						<tr>
						<table border="1">
						<caption>���ݿ⣺<%=poolname %>��������Ϣ</caption>
						<tr>
						<th>����������</th>
						<th>���Զ�Ӧֵ</th>
						<th>����</th>
						</tr>
						
						<tr>
						<td>driver</td>
						<td height="25"><%=metadata.getDriver() %></td>
						<td>���ݿ�����</td>
						</tr>
						
						<tr>
						<td>url</td>
						<td height="25">
						<%if(userAccount.equals("admin")){ %><%=metadata.getURL() %><%}else{ %>
						******
						<%} %>
						</td>
						<td>���ݿ����ӵ�ַ</td>
						</tr>
						
						<tr>
						<td>username</td>
						<td height="25">
						<%if(userAccount.equals("admin")){ %><%=metadata.getUserName() %>
						<%}else{ %>
						******
						<%} %></td>
						<td>���ݿ��û���</td>
						</tr>
						
						<tr>
						<td>password</td>
						<td height="25"><%if(userAccount.equals("admin")){ %><%=metadata.getPassword() %><%}else{ %>
						******
						<%} %></td>
						<td>���ݿ�����</td>
						</tr>
						
						
						<tr>
						<td>loadmetadata</td>
						<td height="25"><%=metadata.getLoadmetadata() %></td>
						<td>�Ƿ�������ݿ�Դ����</td>
						</tr>
						
						<tr>
						<td>txIsolationLevel</td>
						<td height="25"><%=metadata.getTxIsolationLevel() %></td>
						<td>������뼶��</td>
						</tr>
						
						<tr>
						<td>initialConnections</td>
						<td height="25"><%=metadata.getInitialConnections() %></td>
						<td>��ʼ������,ȱʡΪ1</td>
						</tr>
						
						<tr>
						<td>minimumSize</td>
						<td height="25"><%=metadata.getMinimumSize() %></td>
						<td>��С����������,ȱʡΪ0���������õĲ�ͬ�ɸ�ΪmaximumSize��һ�룬���maximumSizeΪ200��minimumSize��Ϊ100</td>
						</tr>
						
						<tr>
						<td>maximumSize</td>
						<td height="25"><%=metadata.getMaximumSize() %></td>
						<td>��������������,ȱʡֵΪ���������ֵ </td>
						</tr>
						
						<tr>
						<td>skimmerFrequency</td>
						<td height="25"><%=metadata.getSkimmerFrequency() %></td>
						<td>���տ������Ӳ������ʱ��,���루ms��Ϊ��λ��ȱʡΪ4200,000���룬Ҳ����4200��</td>
						</tr>
						
						<tr>
						<td>connectionTimeout</td>
						<td height="25"><%=metadata.getConnectionTimeout() %></td>
						<td>����������ʱ��,����Ϊ��λ��ȱʡΪ1200 ,000���룬��ϵͳ���̻��տ�������ʱ������������ʱ������ӽ�������</td>
						</tr>
						
						<tr>
						<td>shrinkBy</td>
						<td height="25"><%=metadata.getShrinkBy() %></td>
						<td>ÿ�λ��յ�������,���ս���ÿ�������յĿ�����������ȱʡֵ��5</td>
						</tr>
						
						<tr>
						<td>maxWait</td>
						<td height="25"><%=metadata.getMaxWait() %>&nbsp;΢��</td>
						<td>��ȡ���ӵȴ���ʱʱ��,��λ�����룬ȱʡ�ȴ�ʱ��Ϊ30000����Ҳ����30�롣��Ӧ�ó�����������ʱ�����ӳ������е����Ӷ�����ʹ��״̬�������Ѿ��ﵽ���������ʱ��������ͻᴦ�ڵȴ�״̬������ȴ���ʱ�䳬��30�루maxWait���õ�ֵ��ʱ��ϵͳ���׳��������ӳ�ʱ�쳣��</td>
						</tr>
						
						<tr>
						<td>validationQuery</td>
						<td height="25"><%=metadata.getValidationQuery() %></td>
						<td>У��sql��䡣Ӧ�ó�������ӳ���������ʱ�����ӳض����������ִ��У��sql��䣬���ִ�гɹ������ʶ����������Ч�ģ�ֱ�ӷ��ظ�Ӧ�ó��򣬷��򽫸�����ֱ�Ӵ����ӳ������٣��������µ����л�ȡ�µ�����
						��˷���ִ�У�ֱ�ӻ�ȡ����Ч������Ϊֹ
						</td>
						</tr>
						
						<tr>
						<td>poolingPreparedStatements</td>
						<td height="25"><%=metadata.isPoolPreparedStatements() %></td>
						<td>Ԥ����statement�ػ����--true���ػ�;false�����ػ���Ĭ��ֵ
						</td>
						</tr>
						
						<tr>
						<td>maxOpenPreparedStatements</td>
						<td height="25"><%=metadata.getMaxOpenPreparedStatements() %></td>
						<td>ÿ��connection���򿪵�Ԥ����statements��,Ĭ��ֵΪ-1
						</td>
						</tr>
						
						</table>
						</tr>
						
						
						<tr>
						<td>
						*********************************************************************************
						</td>
						
						</tr>
						
			
			  </table>
			  </form>
			  
			  </tab:tabPane>
			  <% 
				}	
			%>
	
	</tab:tabContainer>
	<% 
		}
	%>
	</div>
				</body>
</html>