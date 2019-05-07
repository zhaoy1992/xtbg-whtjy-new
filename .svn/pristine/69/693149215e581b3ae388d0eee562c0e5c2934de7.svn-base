<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.resource.ResourceManager,
                 com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl,
                 com.chinacreator.sysmgrcore.manager.OrgManager,
                 com.chinacreator.sysmgrcore.manager.SecurityDatabase,
                 com.chinacreator.sysmgrcore.entity.Organization,
                 org.apache.commons.lang.StringUtils,
                 java.util.List"%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkAccess(request,response);
String userid = accessControl.getUserID();
String userorgid = StringUtils.defaultString(request.getParameter("userorgid"));
//OrgManager orgManager = SecurityDatabase.getOrgManager();
//List list = orgManager.getOrgListOfUser(userid);				
//if(list!=null && list.size()>0){
//	Organization org = (Organization)list.get(0);
//	userorgid = org.getOrgId();	
//}
String column_ids = request.getParameter("column_ids");
//System.out.println("jsp column_ids:"+column_ids);
//System.out.println("jsp userorgid:"+userorgid);
String has_public = StringUtils.defaultString(request.getParameter("has_public"));
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>栏目树</title>
<script language="javascript">

function uf_ok(){
	var orgs = document.getElementsByName("orgid");
	var orgIds = "";
	var orgNames_public = "";
	var orgNames_other = "";
	var public_orgid = "";
	var has_public = "0";
	for(var i=0;i<orgs.length;i++){
		if(orgs[i].checked){			
			var arr = new Array();
			arr = orgs[i].value.split(",");
			
			if(arr[0].length >= 11 && arr[0].substring(0,11)=="szzb_public"){
				if(orgNames_public==""){
					orgNames_public = "公共栏目:";
				}
				orgNames_public = orgNames_public + arr[1] + ",";				
				
				if(arr[0].length==11){
					public_orgid = public_orgid + "0,";
				}else{
					public_orgid = public_orgid +  arr[0].substring(11,arr[0].length) +",";
				}
			}else{
				orgNames_other = orgNames_other + arr[1] + ",";
			}

			orgIds = orgIds + arr[0] + ",";	
		}
	}
	
	orgIds = orgIds.substring(0,orgIds.length-1);
	if(orgNames_public!=""){
		orgNames_public = orgNames_public.substring(0,orgNames_public.length-1);		
	}
	orgNames_other = orgNames_other.substring(0,orgNames_other.length-1);			
	
	if(public_orgid!=""){   //代表没有选择公共栏目，以其他机构为准。 如果选择了公共栏目，则只返回公共栏目。
		public_orgid = public_orgid.substring(0,public_orgid.length-1);
		orgIds = public_orgid;
		has_public = "1";
	}
	
	window.close();
	if(orgNames_public!=""){
		window.returnValue=orgIds+"|" + orgNames_public + "|" + has_public;
	}else{
		window.returnValue=orgIds+"|" + orgNames_other + "|" + has_public;
	}
}

function openWin(url,swidth,sheight)
{
	var w = showModalDialog(url,window,"dialogWidth:"+swidth+"px;dialogHeight:"+sheight+"px;help:no;scroll:auto;status:no");
	
	return w;
}

//离散用户处理
function openModalDialogWin(url,swidth,sheight)
{
	var w = showModalDialog(url,window,"dialogWidth:"+swidth+";dialogHeight:"+sheight+";help:no;scroll:auto;status:no");
	parent.location.href = parent.location.href ;
	return w;
}
</script>
<script type="text/javascript" language="javascript">
//设置树结点的样式
function setTreeNodeClass(){
	var allTd = document.getElementsByTagName("td");
	for(var i = 0;i < allTd.length;i++){	    
		allTd[i].className = "tdclass_act";
	}
}
</script>
<style type="text/css">
<!--
.tdclass_act{
font-size:14px;
}
-->
</style>
	<link href="/sysmanager/css/windows.css" rel="stylesheet" type="text/css">
	<link href="/sysmanager/css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="/sysmanager/css/contentpage.css" rel="stylesheet" type="text/css">
	<link href="/sysmanager/css/windows.css" rel="stylesheet"
		type="text/css">
	<link href="/sysmanager/css/tab.winclassic.css" rel="stylesheet"
		type="text/css">
	<link href="/sysmanager/css/contentpage.css" rel="stylesheet"
		type="text/css">
</head>
<body class="contentbodymargin">
<div align="center" style="width:100%;height:90%;overflow:auto;">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >
  <tr height=30>
  <td align="center">
  	栏目选择
  </td>  
  </tr>
</table>
    <table >
        <tr><td align="left">
         <tree:tree tree="szzb_un_column_tree"
    	           node="szzb_un_column_tree.node"
    	           imageFolder="/purviewmanager/images/tree_images/"
    	           collapse="false"
    			   includeRootNode="true"       			         			  
    			   mode="static-dynamic"
    			   >     			    
    			   <tree:param name="column_ids" value="<%=column_ids%>"></tree:param>
    			   <tree:param name="userorgid" value="<%=userorgid%>"></tree:param>    
    			   <tree:param name="has_public" value="<%=has_public%>"></tree:param>
    			   <tree:checkbox name="orgid" recursive="false" uprecursive="false"></tree:checkbox>
    			   <tree:treedata treetype="com.chinacreator.eform.systemManager.ColumnTree1"
    	                   scope="request"                  
    	                   rootid="0"  
    	                   rootName="栏目树"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"     	                       	                   
    	                   />					
    	</tree:tree>
         </td></tr>
    </table>
    </div>
    <br/>
    <div align="center" boder=1>
			<table width="25%" border="0" align="center" cellpadding="0" cellspacing="0">
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
</body>
<script language="JavaScript">
if(document.getElementsByName("orgid")){
   var orgusers = document.getElementsByName("orgid");
   for(var i=0; i<orgusers.length; i++){
       if(orgusers[i].disabled == true){
           orgusers[i].style.display = "none";
       }
   }
}
setTreeNodeClass();
</script>
</html>
