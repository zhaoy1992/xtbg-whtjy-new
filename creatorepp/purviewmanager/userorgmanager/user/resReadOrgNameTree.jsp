<%
/**
 * 
 * <p>Title: �����ɷ���˰�����Ȩ��</p>
 *
 * <p>Description: �����ɷ���˰�����Ȩ������ҳ��</p>
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
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.ResManager,com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Restype,
				com.chinacreator.security.AccessControl" %>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	String resTypeId = request.getParameter("resTypeId");
	String currRoleId = request.getParameter("currRoleId");
	String role_type = request.getParameter("role_type");
	String currOrgId = request.getParameter("currOrgId");
	
%>
<html>
<head>    
  <title>��������</title>
  <script language="JavaScript" src="changeView.js" type="text/javascript"></script>
  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../css/treeview.css"> 
<script language="Javascript">
function saveReadorgname(){
	var url = "saveTreeRoleresop_handle.jsp?resTypeId=<%=resTypeId%>&currRoleId=<%=currRoleId%>&role_type=<%=role_type%>&opId=readorgname&currOrgId=<%=currOrgId%>";
	document.Form1.target = "saveres";
	document.Form1.action = url;
	document.Form1.submit();
}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin"  scroll="no">
<form name="Form1"  method="post" >
<DIV align="center">
<tr>
<td>
<input name="saveButton" value="����" type="button" onclick="saveReadorgname()" class="input" />
<input name="col" value="�ر�ҳ��" type="button" onclick="parent.window.close();" class="input" />
</td>
</tr>
</DIV>

<div id="contentborder" style="width:100%;height:530;overflow:auto">
<table class="table" width="80%" border="0" cellpadding="0" cellspacing="1">
  <tr class="tr" >
     <td  class="td">
    <tree:tree tree="role_org_tree"
    	           node="role_org_tree.node"
    	           imageFolder="../../../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href=""
    			   target="" 
    			   mode="static-dynamic"
    			   >                         
                   <tree:param name="resTypeId"/>
                   <tree:param name="currRoleId"/>
                   <tree:param name="role_type"/>
                   <tree:param name="currOrgId"/>
                   
				   <tree:checkbox recursive="true" name="checkboxValue"/>
				   
    			   <tree:treedata treetype="com.chinacreator.sysmgrcore.purviewmanager.menu.SetReadorgnameTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="������"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   refreshNode="true"  
    	                     	                   
    	                   />
    	</tree:tree>
	</td>				  
  </tr>  
</table>
</div>
<iframe name="saveres" width="0" height="0"></iframe>
</form>
</body>
</html>
