<%
/**
 * 
 * <p>Title: �û���Դ����ҳ��</p>
 *
 * <p>Description: �û�Ȩ������tabҳ��</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%@ page import="com.chinacreator.resource.ResourceManager
				,com.chinacreator.sysmgrcore.manager.SecurityDatabase
				,com.chinacreator.sysmgrcore.manager.UserManager,com.chinacreator.sysmgrcore.entity.User
				,com.chinacreator.config.ConfigManager
				,com.chinacreator.security.AccessControl,
				java.util.List,
				java.util.ArrayList"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String userId = request.getParameter("userId");
	String orgId = request.getParameter("orgId");
	
	
	UserManager userManager = SecurityDatabase.getUserManager();
	User user = userManager.getUserById(userId);
	String userName = user.getUserRealname();
	
	ResourceManager resManager = new ResourceManager();
	
	List list = resManager.getResourceInfos();
	
	//�ӿ��أ����������������Ա֮����û����в˵���Ȩ����ǰ�û��ֲ��ǳ�������Ա����ȥ���˵����ע�⣬�ǳ�������Ա���ظ������ǆ��£�
	boolean state = ConfigManager.getInstance().getConfigBooleanValue("enablecolumngrant", true) && !accesscontroler.getUserID().equals("1");
	
	if(list == null)
		list = new ArrayList();
	request.setAttribute("resTypeList",list);
	
%>

<html>
<head>
<tab:tabConfig/>
<title>�û���<%=userName%>����Դ��������</title>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">

</head> 
<%@ include file="/epp/css/cssControl.jsp"%><body  bgcolor="#F7F8FC" >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">

		<tr>
			<td colspan="2">
				<tab:tabContainer id="user_resFrame" selectedTabPaneId="user-manage">
				<pg:list requestKey="resTypeList" needClear="false">
				
	      			<pg:equal colName="auto" value="true">
	      			<%
	      			String id = "purview-" + dataSet.getString("id");
	      			String iframeid = "iframe-" + dataSet.getString("id");
	      			String name = dataSet.getString("name");
	      			String link = dataSet.getString("resource")+"?userId="+userId+"&orgId="+orgId;
	      			%>
<!-- ------------------------------------------------------------------------------------------------------------------------------------------>
					<tab:tabPane id="<%=id%>" tabTitle="<%=name%>" lazeload="true">
						<tab:iframe id="<%=iframeid%>" src="<%=link%>" frameborder="0" scrolling="no" width="98%" height="600">
						</tab:iframe>
					</tab:tabPane>
			
					
					
<!-------------------------------------------------------------------------------------------------------------------------------->
				  </pg:equal>					
	  			</pg:list>	
				</tab:tabContainer>			
			</td>
		</tr>
	</table>	
  <iframe name="exeman" width="0" height="0" style="display:none"></iframe>
</body>
</html>

