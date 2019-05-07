<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ page import="com.chinacreator.jawe.ZipUtil"%>
<html>
<head>
<title>请选择要插入的子流程</title>
<script src="../../eformsys/fceform/js/fcpub.js"></script>
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/treeview.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">
<script>
	function openXpdl(mgrName,pid)
	{
		return false;
	}
	
	function toUrl(ecid,type)
	{
		return false;
	}
	
	//选择子流程
	function doSelect()
	{
		var chks = document.getElementsByName("process");
		var tmp="";
		for(i=0;i<chks.length;i++)
		{
			if(chks[i].checked) tmp+=chks[i].value+",";
		}
		var reg = /#/g;
		var ec_id ="<%=request.getParameter("ec_id")%>";
		var expkgids=tmp.replace(reg,"~");
		if(expkgids!=null&&expkgids.length>0)
		{
			return expkgids;
		}
		else
		{
			alert("请选择要插入的外部包！");
			return false;
		}
	}
	//新建并联流程
	function newXPDL()
	{	
		var expkgids = doSelect();
		if(expkgids==false)
		{
			return false;
		}
		var wpf_name="<%=request.getParameter("xpdl_name")%>";
		if(wpf_name==null||wpf_name=="")
		{
			alert("您没有输入并联流程名称！");
			return false;
		}
		//add by minghua.guo 090617
		var remark = "<%=request.getParameter("remark")%>";
		if(remark==null)remark = "";
		
		//需要压缩jar包，并将名称给客户端
		var zipName=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/jawe/jawe_unite/down.jsp?expkgids="+expkgids);
		
		var _url = "<%=request.getContextPath()%>/jawe/xpdl_open.jsp?ec_id=0&op=new&mgrName="+wpf_name+"&expkgids="+expkgids+"&zipName="+zipName+"&remark="+remark;//090617 modify by minghua.guo remark
		//alert(_url);
		//是否保存流程数据
		var isSaveActData="<%=request.getParameter("isSaveActData")%>";
		if(isSaveActData!="null")
		{
			_url+="&isSaveActData="+isSaveActData;
		}
		parent.window.dialogArguments.document.getElementById("myFrame").src=_url;
		parent.window.dialogArguments.document.getElementById("divProcessing").style.display="block";
		window.close();
	}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" scroll="auto">
<form name="applyform">
<br/>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table" >
  <tr>
	<h>请选择要插入的子流程:</h>
  </tr>
</table>
		<table >
        <tr><td>
         <tree:tree tree="jawe_jawe_unite_navigator_content_tree"
    	           node="process_tree.node"
    	           imageFolder="../../sysmanager/images/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   target="base_properties_toolbar"
    			   mode="static-dynamic"
    			   > 
    			   
    			   <tree:param name="publishState"></tree:param>
    			    
    			   <tree:checkbox name="process" recursive="false"
					uprecursive="true" />
					    			    
    			   <tree:treedata treetype="com.chinacreator.epp.processmanage.menu.ProcessTree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="流程业务类别"
    	                   expandLevel="1"
    	                   showRootHref="true"
    	                   needObserver="false"
    	                   enablecontextmenu="true"
    	                   />
    	</tree:tree>
         </td></tr>
         <tr></tr>
         <tr></tr>
         <tr>
         	<td><input type="button" value="确定" onclick="newXPDL()"/></td>
         </tr>
         </table>
    </form>
    
    <script type="text/javascript">
		document.title="请选择要插入的子流程";
	</script>
</body>
</html>
