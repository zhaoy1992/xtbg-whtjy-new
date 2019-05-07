<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl,org.apache.commons.lang.StringUtils"%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(pageContext);
//String app_id = session.getAttribute("subsystem_id_nouse").toString();	
String showmode = StringUtils.defaultString(request.getParameter("showmode"));
%>
<script language="javascript">
function uf_ok(){
		var jobs = jobTreeFrame.document.getElementsByName("jobid");
		var jobIds = "";
		var jobNames = "";		
		for(var i=0;i<jobs.length;i++){
			if(jobs[i].checked){			
				var arr = new Array();
				arr = jobs[i].value.split(",");
				jobIds = jobIds + arr[0] + ",";
				jobNames = jobNames  + arr[1] + ",";	
			}
		}
		jobIds = jobIds.substring(0,jobIds.length-1);				
		jobNames = jobNames.substring(0,jobNames.length-1);		
		window.close();
		window.returnValue=jobIds+";"+jobNames;
}
</script>
<html>
	<head>
		<title>岗位选择</title>
	</head>
	<body class="contentbodymargin">
		<div align="center">
			<br />
				<iframe name="jobTreeFrame" height=85% width="100%"	src="jobTreeFrameSrc.jsp?showmode=<%=showmode %>" frameborder="0"></iframe>
			<br />
			<br />
    		<div align="center">
				<table width="25%" border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<div align="left">
					     		<input name="Submit" type="button" class="input" value="确定" onClick="uf_ok()">
							</div>
						</td>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td>
							<div align="left">
						  		<input name="cancel" type="button" class="input" value="取消" onClick="window.close()">
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>
<%-- 
<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(pageContext);
//String app_id = session.getAttribute("subsystem_id_nouse").toString();	
%>
<html>
<head>
<title>导航器内容</title>
<script language="javascript">
function uf_ok(){
		var jobs = document.getElementsByName("jobid");
		var jobIds = "";
		var jobNames = "";		
		for(var i=0;i<jobs.length;i++){
			if(jobs[i].checked){			
				var arr = new Array();
				arr = jobs[i].value.split(",");
				jobIds = jobIds + arr[0] + ",";
				jobNames = jobNames  + arr[1] + ",";	
			}
		}
		jobIds = jobIds.substring(0,jobIds.length-1);				
		jobNames = jobNames.substring(0,jobNames.length-1);		
		window.close();
		window.returnValue=jobIds+";"+jobNames;
}
</script>
<link rel="stylesheet" type="text/css" href="/sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="/sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="/sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="/sysmanager/css/tab.winclassic.css">
</head>

<body class="contentbodymargin" scroll="no">
<div id="contentborder" align="left">
<form name="navform">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >
  <tr>
    <td>
    	<div align="center">
    		岗位树
    	</div>
    </td>
  </tr>
</table>
		
		<table >
        <tr><td><!-- dynamic="false" -->
         <tree:tree tree="app_job_tree"
    	           node="app_job_tree.node"
    	           imageFolder="/sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"    	
    			   target="base_properties_toolbar"
    			   mode="static-dynamic"
    			   >
    			                            
    			  <tree:checkbox name="jobid"></tree:checkbox>
    			  
    			  <tree:treedata treetype="com.chinacreator.eform.systemManager.JobTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="岗位列表"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"    	             
    	                   />

    	</tree:tree>
         </td></tr>
    </table>
    </form>
    <div align="center">
			<table width="25%" border="0" align="right" cellpadding="0" cellspacing="0">
				<tr>
					<td><div align="left">
					     <input name="Submit" type="button" class="input" value="确定"
											onClick="uf_ok()">
						</div>
					</td>
					<td>
						<div align="left">
						  <input name="cancel" type="button" class="input" value="取消"
											onClick="window.close()">
						</div>
					</td>
				</tr>
			</table>
	</div>
</div>
</body>
</html>
--%>