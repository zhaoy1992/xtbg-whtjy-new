<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../include/global1.jsp"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.ResManager,com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Restype" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String orgId = request.getParameter("orgId");
	String old_ids = orgId;
	
		
%>
<html>
<head>    
  <title>������</title>
  <script language="JavaScript" src="changeView.js" type="text/javascript"></script>
  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../css/treeview.css"> 
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div id="contentborder">


<table class="table" width="80%" border="0" cellpadding="0" cellspacing="1">
  
  <tr>
  	  <td align="center"><input type="button" value="ȷ��" class="input"  onclick="saveit()"></td>
  </tr>
  <tr class="tr" >
     <td  class="td">
     
    <tree:tree tree="role_org_tree"
    	           node="role_org_tree.node"
    	           imageFolder="../../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href=""
    			   target="_self" 
    			   dynamic="false" 
    			   >                         
                   <tree:param name="resTypeId"/>
				   <tree:radio   name="ids"/>
    			   <tree:treedata treetype="com.chinacreator.dictionary.AccreditOrgTree"
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
</body>
<script>
     function saveit(){
         var arr = document.getElementsByName("ids");
         var old_ids = "<%=old_ids%>";
         var selected_value = "";
         for(var i=0;i<arr.length;i++){
             if(arr[i].checked){
                 selected_value = arr[i].value;
                 break;
             }
         }
         var id_name = selected_value.split(":");
         if(id_name.length>1){
             window.dialogArguments.form1.orgId.value = id_name[0];
             if(selected_value==old_ids){//��ѡ���ID,����ԭ����ID,��ˢ��������ֵ�����ҳ��
                 window.returnValue = "noRefresh";
             }else{//��ѡ���ID,����ԭ����ID,ˢ��������ֵ�����ҳ��
                 window.returnValue="ok";
             }
         }
         window.close();    
     }
     window.onload = function autoRun(){
         var ids = "<%=old_ids%>";
         var arr = document.getElementsByName("ids");
         for(var i=0;i<arr.length;i++){             
             if(arr[i].value == ids){
                 arr[i].checked=true;
                 break;
             }
         }
     }
     
</script>
</html>
