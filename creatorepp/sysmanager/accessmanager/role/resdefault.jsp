<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.resource.ResourceManager
				,com.chinacreator.config.ConfigManager
				,com.chinacreator.config.model.ResourceInfo
				,com.chinacreator.security.AccessControl"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	ResourceManager resManager = new ResourceManager();
	List list = resManager.getResourceInfos();

	if(list == null)
		list = new ArrayList();

	
	//�ӿ��أ����������������Ա֮����û����в˵���Ȩ����ǰ�û��ֲ��ǳ�������Ա����ȥ���˵����ע�⣬�ǳ�������Ա���ظ������ǆ��£�
	boolean state = ConfigManager.getInstance().getConfigBooleanValue("enablecolumngrant", true) && !accesscontroler.getUserID().equals("1");
	
	
	request.setAttribute("resTypeList",list);
	session.setAttribute("role_type","role");
	session.setAttribute("roleTabId", "3");
%>
<html>
<head>    
  <title>��������</title>
  <script language="javascript" src="../../scripts/changeView1.js" type="text/javascript"></script>
  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../css/treeview.css"> 
  
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no" >
<div id="contentborder">

<table class="table" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">

  <tr class="tr">
    <td width="25%" class="td">
    <select  class="select" name="select" onChange="changeView('select')">
      <option selected>--��ѡ����Դ--</option>	
      <pg:list requestKey="resTypeList" needClear="false">
	      <pg:equal colName="auto" value="true">
		      <pg:equal colName="id" value="column">
		      	<%if(!state){%>
		      	<option value="<pg:cell colName="id"/>" link="<pg:cell colName="resource"/>">	
		      		<pg:cell colName="name"/>
				</option>
				<%}%>
		      </pg:equal>
		      <pg:notequal colName="id" value="column">	
		      	<option value="<pg:cell colName="id"/>" link="<pg:cell colName="resource"/>">
		      		<pg:cell colName="name"/>
				</option>
		      </pg:notequal>
		  </pg:equal>				
	  </pg:list>
    </select>
	</td>
  </tr>
    
  <tr height="100%" width="100%">
  	<td height="100%" width="100%">
  		<iframe id="resource_bridge" frameborder="0" name="resource_bridge" src="" height="100%" width="100%""/>
  	</td>
  </tr>
  
</table>

</div>
</body>
</html>