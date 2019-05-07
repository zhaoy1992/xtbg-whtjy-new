<%
/**
 * 
 * <p>Title: �ֵ���ҳ��</p>
 *
 * <p>Description: �ֵ䶨����ҳ��</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
    String currRoleId = request.getParameter("currRoleId");
	String currOrgId = request.getParameter("currOrgId");
	String role_type = request.getParameter("role_type");
	String isBatch = request.getParameter("isBatch");
    String url = "operList_dict_ajax.jsp?resTypeId=dict&currRoleId="+currRoleId+"&currOrgId="+currOrgId+"&role_type="+role_type+"&isBatch="+isBatch;
%>
<html>
<head>
<title>�ֵ����</title>

<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">

</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">
    <table >
    	
    	
        <tr><td>
         <tree:tree tree="dict_tree"
    	           node="dict_tree.node"
    	           imageFolder="../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"    			   
    			   href="<%=url%>"    			   
    			   target="operList"
    			   dynamic="false"
    			   >                                            
					<tree:param name="resTypeId"/>
					<tree:param name="currRoleId"/>
					<tree:param name="role_type"/>
					<tree:param name="isBatch"/>
					<tree:param name="currOrgId"/>

    			   <tree:treedata treetype="com.chinacreator.dictionary.UserGrantResDictTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="�ֵ�����"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   refreshNode="false"
    	                   />

    	</tree:tree>
         </td></tr>
    </table>
</div>
</body>
</html>
