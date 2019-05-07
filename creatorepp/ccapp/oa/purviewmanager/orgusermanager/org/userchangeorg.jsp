<%
/*
 * <p>Title: 用户调出操作界面</p>
 * <p>Description: 用户调出操作界面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-20
 * @author liangbing.tao
 * @version 1.0
 */
 %>
 <%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.OrgManager" %>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@page import="com.chinacreator.security.AccessControl,
				com.chinacreator.config.ConfigManager,
				 com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl,
				 java.util.List"%>

<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	UserManager userManager = SecurityDatabase.getUserManager();
	String CuuserId = control.getUserID();
	String ids = request.getParameter("checkBoxOne");
	String orgId = request.getParameter("orgId");
	String subid = request.getParameter("subid");
	OrgManager orgManager = SecurityDatabase.getOrgManager();
	Organization org = orgManager.getOrgById(orgId);
	String orgName = org.getOrgName();
	String[] userid = ids.split(",");
	String script = "";
	String script2 = "";
	String userReturnInfo = "";
	for(int i = 0; i < userid.length; i++){
		List list = PurviewManagerImpl.getBussinessCheck().userMoveCheck(control,userid[i]);
			
	    String userOrgInfoMsg = PurviewManagerImpl.buildMessage(list);
		if(!"".equals(userOrgInfoMsg)){
		    //如果返回值！= "" ， 累加提示信息
		    User user = userManager.getUserById(userid[i]);
			if(userReturnInfo.equals("")){
				userReturnInfo = user.getUserRealname()+"("+user.getUserName()+"):"+userOrgInfoMsg;
			}else{
				userReturnInfo += "\\n" + user.getUserRealname()+"("+user.getUserName()+"):" + userOrgInfoMsg;
			}
		}
	}
	if(!"".equals(userReturnInfo)){
%>
	<script language="Javascript">
		var msg = "以下用户不能调出："
	    msg += "\n<%=userReturnInfo%>";
		alert(msg);
		window.close();
		window.returnValue = "ok";
	</script>
<% 
	}else{
%>
<html>
<head>
<title>从机构【<%=orgName%>】将用户调出到机构</title>
<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../css/windows.css">
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入其它 -->
<script src="../../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script language="javascript">
var subid='<%=subid%>';
function addorg(){
	var orgValues="";
	var state = false;
	var orgold = "<%=orgId%>";
	if(document.all.orgIdName){
		if(document.all.orgIdName.length){
		  	for(var i = 0; i < document.all.orgIdName.length; i++){
		  		if(document.all.orgIdName[i].checked){
		  			var orgValue = document.all.orgIdName[i].value;
		  			var orgValueId = orgValue.split(";");
		  			if(orgold==orgValueId[0]){
		  				alert("用户已经存在机构"+orgValueId[1]+"下，不需再调入！");
		  				return;
		  			}
		  			if(state){
		  				orgValues += "," + orgValueId[0];
		  			}else{
		  				orgValues = "" + orgValueId[0];
		  				state = true;
		  			}
		  		}
		  	}
	  	}else{
	  		if(document.all.orgIdName.checked){
	  			orgValues = document.all.orgIdName.value.substring(0,document.all.orgIdName.value.lastIndexOf(";"));
	  		}
	  	}
  	}
  	<%if(!ConfigManager.getInstance().getConfigBooleanValue("sys.user.enablemutiorg", true)){%>
	  	if(orgValues!=""){
	  		document.OrgJobForm.target="getOrg";
		  	document.OrgJobForm.action="folddisperse.jsp?userIds=<%=ids%>&orgIds="+orgValues+"&orgId=<%=orgId%>&flag=0";
		  	document.OrgJobForm.submit();
	  	}else{
	  		alert("请选择要调入的机构！");
			return;
	  	}
  	<%}else{%>
	  	if(orgValues!=""){
	  		if(confirm("是否保留该机构下的用户！")){
		  		document.OrgJobForm.target="getOrg";
			  	document.OrgJobForm.action="folddisperse.jsp?userIds=<%=ids%>&orgIds="+orgValues+"&orgId=<%=orgId%>&flag=1";
			  	document.OrgJobForm.submit();
		  	}else{
		  		document.OrgJobForm.target="getOrg";
			  	document.OrgJobForm.action="folddisperse.jsp?userIds=<%=ids%>&orgIds="+orgValues+"&orgId=<%=orgId%>&flag=0";
			  	document.OrgJobForm.submit();		  	
		  	}
	  	}else{
	  		alert("请选择要调入的机构！");
			return;
	  	}
  	<%}%>
}
function colseWin(){
	closeAlertWindows(subid,false,true);
}
</script>
</head> 
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" onload="checkFold()">
<div id="contentborder">
<center>
<form id="OrgJobForm" name="OrgJobForm" action="" method="post" >
<table width="80%" border="0" cellpadding="0" cellspacing="1">
<input type="hidden" name="userIds" value="<%=ids%>" />
  <tr class="tabletop">
    <td width="40%" align="center"></td>    
  </tr>
  <tr >
     <td >
     
    <tree:tree tree="org_tree_userorgmanager"
    	           node="org_tree.node"
    	           imageFolder="../../../../../purviewmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="false"
				   href=""
    			   target=""
    			   mode="static-dynamic"
    			   >   
    			   <tree:param name="checkBoxOne"/>
    			   <tree:param name="orgId"/>
                   <%if(!ConfigManager.getInstance().getConfigBooleanValue("sys.user.enablemutiorg", true)){%>
                   <tree:radio name="orgIdName" />   
                   <%}else{%>  
				   <tree:checkbox name="orgIdName" />
				   <%}%>
    			   <tree:treedata treetype="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.menu.UserCheckOutOrgTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="机构树"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   refreshNode="false"
    	                   />

    	</tree:tree>
	</td>			 
				  
  </tr>
  <tr>
  <td align="center" >
  <input name="add" type="button" class="input" value="确定" onclick="addorg()">
  <input name="ced" type="button" class="input" value="关闭" onclick="colseWin()">
  </td>
  </tr>
<iframe name="getOrg" width="0" height="0" ></iframe>  
</table>
</form>
</center>
</div>
<IFRAME name="delDisperse" height="0" width="0"></IFRAME>
</body>
<script>
function checkFold()
{
<%if(!script.equals(""))
  {
%>
	<%=script%>
<%}
 else if(!script2.equals(""))
 {
%>
	<%=script2%>
<%
 }
%>
}
</script>
</html>
<%
	}
%>
