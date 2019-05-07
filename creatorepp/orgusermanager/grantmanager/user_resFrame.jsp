<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%>
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
 <%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%@page import="com.chinacreator.config.model.ResourceInfo"%>

<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.User" %>
<%@ page import="com.chinacreator.resource.ResourceManager
				,com.chinacreator.sysmgrcore.manager.SecurityDatabase
				,com.chinacreator.config.ConfigManager
				,com.chinacreator.security.AccessControl,
				java.util.List,
				java.util.ArrayList"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	String curSystem = accesscontroler.getCurrentSystem();
	
	//��Ȩ���� user��role
	String role_type = "user";
	
	//��ǰѡ����ȨID��������Ȩ������user��role������Ȩ���ͣ��ֱ�Ϊ�û�ID���ͽ�ɫID
	String currRoleId = request.getParameter("currRoleId");
	
	//�Ƿ�������Ȩ true:������false:����
	String isBatch = "false";
	
	//��ǰ��ѡ�û���������ID
	String orgId = request.getParameter("orgId");
	
	// Ȩ���Ƿ��������
	// ��ʢ 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
	
	//�Ƿ����Ա
	//�Ƿ��ǹ���Ա
	boolean isOrgManager = false;
	OrgAdministratorImpl orgAdministratorImpl = new OrgAdministratorImpl();
	if(isrolerelatedorg){							
		isOrgManager = orgAdministratorImpl.isOrgAdmin(currRoleId,orgId);
	}else{
		isOrgManager = orgAdministratorImpl.isOrgManager(currRoleId);
	}
	
	UserManager userManager = SecurityDatabase.getUserManager();
	User user = userManager.getUserById(currRoleId);
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
<title>�û���<%=userName%>��Ȩ������</title>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">

</head> 
<%@ include file="/epp/css/cssControl.jsp"%><body  bgcolor="#F7F8FC" >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">

		<tr>
			<td colspan="2">
				<tab:tabContainer id="user_resFrame" selectedTabPaneId="purview-orgunit">
				<pg:list requestKey="resTypeList" needClear="false">
				
	      			<pg:equal colName="auto" value="true">
	      			<%
	      			ResourceInfo resourceInfo = (ResourceInfo)dataSet.getOrigineObject();
	      			boolean isAppend = resourceInfo.containSystem(curSystem);
	      			String id = "purview-" + dataSet.getString("id");
	      			String iframeid = "iframe-" + dataSet.getString("id");
	      			String name = dataSet.getString("name");
	      			StringBuffer link = new StringBuffer()
	      				.append(dataSet.getString("resource")).append("?currRoleId=").append(currRoleId)
		      			.append("&orgId=").append(orgId)
		      			.append("&role_type=").append(role_type)
		      			.append("&isBatch=").append(isBatch);
	      			//System.out.println("link = " + link.toString());
	      			//boolean stateOrgColumn = (id.trim().equals("purview-orgunit") || id.trim().equals("purview-column"));
	      			boolean stateOrgColumn = (id.trim().equals("purview-group") || id.trim().equals("purview-role")
	      					 || id.trim().equals("purview-dict") || id.trim().equals("purview-job"));
	      			if(isAppend)
	      			{		 
	      				if(!(id.trim().equals("purview-column") && !accesscontroler.isAdmin()))
	      				{
	      					if(!isOrgManager && !stateOrgColumn)
	      					{
	      			%>
<!-- ------------------------------------------------------------------------------------------------------------------------------------------>
					<tab:tabPane id="<%=id%>" tabTitle="<%=name%>" lazeload="true">
						<tab:iframe id="<%=iframeid%>" src="<%=link.toString()%>" frameborder="0" scrolling="no" width="98%" height="600">
						</tab:iframe>
					</tab:tabPane>
<!-------------------------------------------------------------------------------------------------------------------------------->
						<%
							}else if(isOrgManager)
							{
						%>
							<tab:tabPane id="<%=id%>" tabTitle="<%=name%>" lazeload="true">
								<tab:iframe id="<%=iframeid%>" src="<%=link.toString()%>" frameborder="0" scrolling="no" width="98%" height="600">
								</tab:iframe>
							</tab:tabPane>
					<%		}
						}
					}
					
					%>
				  </pg:equal>					
	  			</pg:list>	
				</tab:tabContainer>			
			</td>
		</tr>
	</table>	
	
<div align="center"><input name="cols" type="button" value="�ر�ҳ��" onclick="window.close();" class="input"/></div>
  <iframe name="exeman" width="0" height="0" style="display:none"></iframe>
</body>
</html>

