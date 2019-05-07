<%
/**
 * 
 * <p>Title: 用户自定义资源树</p>
 *
 * <p>Description: 用户自定义资源树--链接reslist.jsp</p>
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
				com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	String resTypeId = request.getParameter("resTypeId");
		
%>
<html>
<head>    
  <title>属性容器</title>
  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../css/treeview.css"> 
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">


<table class="table" width="80%" border="0" cellpadding="0" cellspacing="1">
  
  
  <tr class="tr" >
     <td  class="td">
     
    <tree:tree tree="ResourceTypeTree"
    	           node="ResourceTypeTree.node"
    	           imageFolder="../../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="reslist.jsp"
    			   target="operList" 
    			   dynamic="false" 
    			   >                         
                   <tree:param name="resTypeId"/>
				   
    			   <tree:treedata treetype="com.chinacreator.menu.ResourceTypeTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="用户自定义资源"
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
</body>
</html>
