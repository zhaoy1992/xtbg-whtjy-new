<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@page import="com.chinacreator.security.AccessControl,
			com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl,
			java.util.*,
			com.chinacreator.resource.ResourceManager,
			com.chinacreator.config.ConfigManager"%>
<%@page import="com.chinacreator.config.model.ResourceInfo"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.api.UserCheckOrgFactory"%>
<%
	 AccessControl accesscontroler = AccessControl.getInstance();
	 accesscontroler.checkManagerAccess(request,response);
	 //��ǰϵͳ
	 String curSystem = accesscontroler.getCurrentSystem();
	 
	 String checks = request.getParameter("checks");
	 String[] id = checks.split(",");
     UserManager userManager = SecurityDatabase.getUserManager();
     OrgManagerImpl orgImpl = new OrgManagerImpl();	
     String idStr = "";
     String usern = "";
     String userna = "";
     for(int i = 0;i < id.length; i++)
     {
     	idStr += id[i]+",";
     	
     	User user = userManager.getUserById(id[i]);
     	usern= user.getUserRealname();
     	userna += usern + ",";
     }
	 if(idStr.length() > 1)
     idStr = idStr.substring(0,idStr.length()-1);
     if(userna.length() > 1)
     userna = userna.substring(0,userna.length()-1); 
     
     ResourceManager resManager = new ResourceManager();
	
	 List list = resManager.getResourceInfos();
	
	 //�ӿ��أ����������������Ա֮����û����в˵���Ȩ����ǰ�û��ֲ��ǳ�������Ա����ȥ���˵����ע�⣬�ǳ�������Ա���ظ������ǆ��£�
	 boolean state = ConfigManager.getInstance().getConfigBooleanValue("enablecolumngrant", true) && !accesscontroler.getUserID().equals("1");
	
	 if(list == null)
		list = new ArrayList();
	 request.setAttribute("resTypeList",list);
     
     
     //���ѡ����û���ϵͳ����Ա���򵯳���ʾ���û�����ѡ��
     String orgId = request.getParameter("orgId");
     //��ǰ�û���������ID
     String curUserOrgId = accesscontroler.getChargeOrgId();
     
     
     boolean tag = false;
     String adminUsers = "�����û����ܽ�����Դ����:\\n";
     String userNames = "";
     int orgManagerCount = 0;
     int noOrgManagerCount = 0;
     for(int j=0;j<id.length; j++){
		User adminUser = userManager.getUserById(id[j]);
		if("".equals(userNames)){
			userNames = adminUser.getUserRealname(); 
		}else{
			userNames += "," + adminUser.getUserRealname(); 
		}
		if(accesscontroler.isAdminByUserid(id[j])){//�г�������Ա��ɫ		    
			tag = true;						
			adminUsers += adminUser.getUserName() + " �ǳ�������Ա\\n";
		}
		
		//û�й���Ա��ɫ, ���Ǹ��Լ���Ȩ
		if(accesscontroler.getUserID().equals(id[j])){
			tag = true;
			adminUsers += adminUser.getUserName() + " ���ܸ��Լ������ɫ\\n";
		}
		
		 //�ǲ��Ź���Ա, Ҳ��������Ȩ
		 // �����Ź���Ա����Ȩ������  baowen.liu 2008-3-21
	      boolean managerOrgs = orgImpl.isCurOrgManager(orgId, id[j]);
	      if(managerOrgs){
	      	orgManagerCount++;
	      }else{
	      	noOrgManagerCount++;
	      }
	      if(managerOrgs && curUserOrgId.equals(orgId) && !accesscontroler.isAdmin()){
	         tag = true;
		     adminUsers += adminUser.getUserName() + " �뵱ǰ�û���ͬ�ȼ����Ź���Ա\\n";
	      }
     }
     
     if(tag)
     {
     	%>
     	<SCRIPT LANGUAGE="JavaScript">
		alert("<%=adminUsers%>"); 
		window.close();
		</script>
		<%
     }else if(orgManagerCount > 0 && noOrgManagerCount > 0){
     %>
     	<SCRIPT LANGUAGE="JavaScript">
		alert("���Ź���Ա����ͨ�û�����һ������Ȩ�����裡"); 
		window.close();
		</script>
     <%
     }else
     {
      //���α�����û�  ��ʢ 2011-3-10
	StringBuffer secondUserName = new StringBuffer();
	boolean isSecondUser = UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUserByOrgIDToMess(checks,orgId,secondUserName);
    if(isSecondUser){
	%>
		<script type="text/javascript">
			alert("������û��ڸû����²��ܱ�����Ȩ�ޣ�<%=secondUserName%>");
			window.close();
		</script>
	<%
    }
%>
<html>
<head>
<title>����Ȩ��������û���<%=userNames %>��</title>
<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<script type="text/javascript" src="../../include/tabs.js"></script>
<link type="text/css" rel="stylesheet" href="../../include/tabstyle.jsp" />
</head> 
<%@ include file="/epp/css/cssControl.jsp"%><body  bgcolor="#F7F8FC" >
	<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">

		<tr>
			<td colspan="2">
				<tab:tabContainer id="userbatch_resFrame" selectedTabPaneId="purview-orgunit">
				<pg:list requestKey="resTypeList" needClear="false">
				
	      			<pg:equal colName="auto" value="true">
	      			<%
	      			ResourceInfo resourceInfo = (ResourceInfo)dataSet.getOrigineObject();
	      			boolean isAppend = resourceInfo.containSystem(curSystem);
	      			if(isAppend){
	      			boolean isOrgManager = false;
	      			if(orgManagerCount > 0){
	      				isOrgManager = true;
	      			}
	      			String idTab = "purview-" + dataSet.getString("id");
	      			String iframeid = "iframe-" + dataSet.getString("id");
	      			String name = dataSet.getString("name");
	      			boolean stateOrgColumn = (idTab.trim().equals("purview-orgunit") || idTab.trim().equals("purview-column"));
	      			StringBuffer link = new StringBuffer()
	      				.append(dataSet.getString("resource")).append("?currRoleId=").append(idStr)
		      			.append("&orgId=").append(orgId)
		      			.append("&role_type=user")
		      			.append("&isBatch=true");
	      			//String link = dataSet.getString("resource")+"?userId="+idStr+"&orgId="+orgId+"&isOrgManager="+isOrgManager;
	      			if(!accesscontroler.getUserID().equals("1")){
	      				if(!isOrgManager && stateOrgColumn){
	      			%>
<!-- ------------------------------------------------------------------------------------------------------------------------------------------>
					<tab:tabPane id="<%=idTab%>" tabTitle="<%=name%>" lazeload="true">
						<tab:iframe id="<%=iframeid%>" src="<%=link.toString()%>" frameborder="0" scrolling="no" width="98%" height="600">
						</tab:iframe>
					</tab:tabPane>
<!-------------------------------------------------------------------------------------------------------------------------------->
						<%}else if(isOrgManager){%>
					<tab:tabPane id="<%=idTab%>" tabTitle="<%=name%>" lazeload="true">
						<tab:iframe id="<%=iframeid%>" src="<%=link.toString()%>" frameborder="0" scrolling="no" width="98%" height="600">
						</tab:iframe>
					</tab:tabPane>
					<%}} }%>
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

	<%
	}
	%>