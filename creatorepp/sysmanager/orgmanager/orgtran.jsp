<%@ include file="../include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ include file="../base/scripts/panes.jsp"%>
<%@page import="com.frameworkset.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
AccessControl control = AccessControl.getInstance();
control.checkAccess(request,response);
String orgId = StringUtil.replaceNull(request.getParameter("orgId"));
//�жϲ����Ƿ�ɹ�
String isok =  (String)request.getAttribute("isOk");

//���´��빩�����ˢ��ʹ��
String action = StringUtil.replaceNull(request.getParameter("action"));
String updateorgId =  StringUtil.replaceNull(request.getParameter("updateorgId"));
String updateparentId =  StringUtil.replaceNull(request.getParameter("updateparentId"));
%>
<SCRIPT LANGUAGE="JavaScript"> 
var ok = <%=isok%>;
	if(ok=="1"){
		alert("���󣬲���ת�ƣ�");
	} 
	else if(ok=="2")
	{
		alert("ת�ƻ����ɹ���");
	}
var action="<%=action%>";
if(action!="")
getNavigatorContent().location.href ="<%=rootpath%>/sysmanager/orgmanager/navigator_content.jsp?anchor=0&collapse=0&request_scope=session&selectedNode=<%=updateorgId%>";
function okadd(){	
	if(selectNode==null){
		alert("��ѡ��ת�Ƶ��Ļ���"); return;
	}  
	Form1.action="../../purviewmanager/userorgmanager/org/orgtran_do.jsp?orgId=<%=orgId%>&parentId="+selectNode;
	Form1.submit();  
	//window.location.href="<%=rootpath%>/orgmanager/org.do?method=tranOrg&orgId=<%=orgId%>&parentId="+selectNode;    
                   
}
function updateAfter(){
 	getNavigatorContent().location.href ="<%=rootpath%>/sysmanager/orgmanager/navigator_content.jsp?anchor=0&expand=0&request_scope=session&selectedNode=<%=updateorgId%>"; 
 	
}
function back(){	
     
 	window.location.href="<%=rootpath%>/orgmanager/org.do?method=getOrgInfo&orgId=<%=orgId%>";    
                   
}

function flashSelf(orgId,seOrg){
	window.location.href = "<%=rootpath%>/sysmanager/orgmanager/orgtran.jsp?orgId="+seOrg;
	getNavigatorContent().location.href = "<%=rootpath%>/sysmanager/orgmanager/navigator_content.jsp?anchor=0&collapse=0&request_scope=session&selectedNode="+seOrg;
}

</SCRIPT>
<head>    
  <title>����ת��</title>


<link rel="stylesheet" type="text/css" href="../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">   
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onLoad="<%=action.equals("tran")?"updateAfter()":""%>" scroll="no">
<form name="Form1" target="abc" action="" method="post" >
<div id="contentborder" align="center">
    <table >
        <tr><td>
        ѡ��ת�Ƶ��Ļ���
         <tree:tree tree="org_tree_tran"
    	           node="org_tree_tran.node"
    	           imageFolder="/sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="aa.jsp"
    			   target="abc"
    			   mode="static"
    			   > 
    			                           
                   <tree:param name="parentId"/>
				   <tree:param name="orgId"/>
    			   <tree:treedata treetype="com.chinacreator.menu.CurrentorgAndLisanTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="��������"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   />

    	</tree:tree>
         </td></tr>
    </table>
    <br>
   <table><tr><td>
    <input name="add" type="button" class="input" value="ȷ��" onclick="okadd()" >
     <input name="Submit" type="button" class="input" value="����" onclick="back()">                  
     </td></tr></table>
</div>
</form>
<div style="display:none">
	<iframe src="" id="abc" name="abc" style="width:0;height:0">
</div>
</body>

