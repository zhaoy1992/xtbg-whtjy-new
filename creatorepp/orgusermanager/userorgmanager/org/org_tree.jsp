<%
/**
 * <p>Title: 机构树</p>
 * <p>Description: 机构树</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-17
 * @author da.wei
 * @version 1.0
 **/
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
AccessControl accessControl = AccessControl.getInstance();
accessControl.checkManagerAccess(request,response);

String path = request.getContextPath();   
     
// 判断是否平台
boolean isEgp = accessControl.getCurrentSystemID().equals("module")?true:false; 
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>机构树</title>
<script language="javascript">
//机构查询
//2008-4-2 baowen.liu
var featrue = "dialogWidth=600px;dialogHeight=500px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;help=0;dialogLeft="+(screen.availWidth-600)/2+";dialogTop="+(screen.availHeight-500)/2;
var win;

function searchorg()
{
	winuser = window.showModalDialog("organsearch.jsp?jobId=2",
										 window,"dialogWidth:"+(850)+"px;dialogHeight:"+(520)+"px;help:no;scroll:auto;status:no");
}

//新增一级机构
function neworg()
{
	winuser = window.showModalDialog("new_org.jsp",
										 window,"dialogWidth:"+(600)+"px;dialogHeight:"+(400)+"px;help:no;scroll:auto;status:no");
	if(winuser)
	{
		parent.location = parent.location;
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
//机构排序
function sortOrg(orgId,orgName)
{
	openWin("sortOrg.jsp?orgId=" + orgId + "&orgName=" + orgName,500,500);
	window.location.href=window.location.href;
}

//子机构排序
function sortSonOrg(orgId,orgName)
{
	openWin("sortOrg.jsp?orgId=" + orgId + "&orgName=" + orgName,500,500);
	parent.location.reload();
}

//管理员设置
function changeOrgAdmin(orgId)
{
	openWin("orgAdmin.jsp?orgId=" + orgId,600,500);
	parent.location.reload();
}

//机构基本信息查看
function checkOrgInfo(orgId,parentId)
{
	openWin("orgInfo.jsp?orgId=" + orgId + "&parentId=" + parentId,600,400);
}

//机构基本信息修改
function modifyOrgInfo(orgId,parentId)
{
	openWin("modifyorg.jsp?orgId=" + orgId + "&parentId=" + parentId,600,400);
	parent.location.reload();
}

//删除机构
function deleteOrg(orgId,orgName)
{
	if(confirm("确定删除机构“"+orgName+"”（Id："+orgId+"）？"))
	{
		document.forms[0].action = "deleteorg_do.jsp?orgId=" + orgId;
		document.forms[0].target = "hiddenFrame";
		//win = window.showModelessDialog("<%=path%>/purviewmanager/common/doing.jsp","",featrue);
		document.forms[0].submit();
		
	}
}

//机构转移
//修改传入的参数,加入OrgName
//2008-3-20  baowen.liu
function transferOrg(orgId,orgName)
{   
	//window.open("orgtran.jsp?orgId=" + orgId + "&orgName=" + orgName);
	openWin("orgtran.jsp?orgId=" + orgId + "&orgName=" + orgName,400,500);
	parent.location.reload();
}

//新增子机构
//修改传入的参数,加入OrgName
//2008-3-20  baowen.liu
function addOrgSon(orgId,orgName)
{
	openWin("new_sonorg.jsp?orgId=" + orgId + "&orgName=" + orgName,600,400);
	parent.location.reload();
}

//机构岗位设置
//新增子机构
//修改传入的参数,加入OrgName
//2008-3-20  baowen.liu
function changeOrgJob(orgId,orgName)
{
	openWin("userjoborg.jsp?orgId=" + orgId + "&orgName=" + orgName,1000,600);
}

//reclaim user's resource under organization
//ge.tao
function reclaimOrgUserRes(orgId){
    openWin("../../reclaimManager/reclaimOrgUserRes.jsp?orgId=" + orgId,500,400);
}

function rightRole(orgId){
	openWin("changeRole_ajax.jsp?orgId=" + orgId ,800,600);
}

function orgResQuery(orgId){
	var sty = "dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0";
	window.showModalDialog("orgres_queryframe.jsp?orgId=" + orgId,window,sty);
	//openWin("orgres_queryframe.jsp?orgId=" + orgId ,750,500);
}

function grantOrgRes(orgId){
	var url = "../../grantmanager/org_resFrame.jsp?currRoleId=" + orgId;
	window.showModalDialog(url,window,"dialogWidth:"+screen.availWidth+";dialogHeight:"+screen.availHeight+";help:no;scroll:auto;status:no");
}

//机构缓冲刷新
function refreshorgcache(){
	document.forms[0].action = "refreshcache_handle.jsp?flag=1";
	document.forms[0].target = "hiddenFrame";
	document.forms[0].submit();
}

//机构缓冲刷新
function refreshorgmanagercache(){
	document.forms[0].action = "refreshcache_handle.jsp?flag=2";
	document.forms[0].target = "hiddenFrame";
	document.forms[0].submit();
}

//权限缓冲刷新
function refreshcache(){
	document.forms[0].action = "refreshcache_handle.jsp?flag=3";
	document.forms[0].target = "hiddenFrame";
	document.forms[0].submit();
}
function orguser_tb(){
	openWin("<%=request.getContextPath()%>/orgusermanager/orgusersyn/orgusersynmain.jsp" ,screen.availWidth-120,screen.availHeight-100);
}
</script>
<link rel="stylesheet" type="text/css" href="../../css/windows.css">
<link rel="stylesheet" type="text/css" href="../../css/treeview.css">
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="auto">
<form name="orgtreeform" action="" method="post"  >
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >
  <tr height=30>

  <td align="center">
  	<a href="#" onclick="searchorg()">机构查询</a>
  </td>
  
  	<%
	//判断是否是系统管理员(即是否是admin)
	//2008-4-7 baowen.liu
	if("1".equals(accessControl.getUserID()) && isEgp)
	{
  	%>
    <td align="center"><a href="#" onclick="neworg()">新增机构</a></td>
    </tr><tr>
    <td align="center" colspan="2"><a href="#" onclick="orguser_tb()">机构用户同步</a></td>
   	<%
   	}
   	%>  
  </tr>
</table>
    <table >
        <tr><td align="left">
         <tree:tree tree="org_tree_userorgmanager"
    	           node="org_tree.node"
    	           imageFolder="../../images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="../user/userquery_content_tab.jsp" 
    			   target="org_userlist" 
    			   mode="static-dynamic"
    			   >     			    
    			   <tree:treedata treetype="com.chinacreator.sysmgrcore.purviewmanager.OrgUserManagerOrgTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="机构树"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   enablecontextmenu="true" 
    	                   />					
    	</tree:tree>
         </td></tr>
    </table>
</form>

</body>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>
