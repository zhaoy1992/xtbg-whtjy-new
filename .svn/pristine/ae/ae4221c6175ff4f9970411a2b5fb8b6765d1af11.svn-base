<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<% 
String selectModuleIds = request.getParameter("selectModuleIds");
String weipairenid = request.getParameter("weipairenid");
if(selectModuleIds == null){
	selectModuleIds = "";
}
if(weipairenid == null){
	weipairenid = "";
}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB2312">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
		<meta http-equiv="expires" content="Mon, 23 Jan 1978 20:52:30 GMT">
		<title>◎请选择◎</title>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
	</head>
	<base target="_self">
	<%@ include file="/epp/css/cssControl.jsp"%><body scroll=no>
		<form action="" >
			<div  style="width:100%;height:420;overflow:auto">
			<table width="100%" border="1" cellpadding="2" cellspacing="0"
				bordercolorlight="#3B4D61" bordercolordark="#ffffff">
				<tr>
								<td width="" class="detailcontent">
									<tree:tree tree="select_app_module_tree"
										node="select_app_module_tree.node"
										imageFolder="/sysmanager/images/tree_images/" collapse="true"
										includeRootNode="true" mode="static">
										
										<tree:checkbox name="module_id" recursive="true"
											uprecursive="true" />

										<tree:param name="selectModuleIds"></tree:param>
										<tree:param name="weipairenid"></tree:param>
										<tree:treedata
											treetype="com.chinacreator.epp.delegate.DelegateModuleTree"
											scope="request" rootid="0" rootName="模块(事项)树" expandLevel="1"
											showRootHref="false" needObserver="false" />
									</tree:tree>
								</td>
							</tr>
			</table>
			</div>
			<table width="100%" border="0" cellpadding="2" cellspacing="0">
				<tr>
					<td align="center">
						<input name="Submit" type="button" class="black_menu" value="确定"
							onClick="sel()">
						<input name="Close" type="button" class="black_menu" value="关闭窗口"
							onClick="return window.close()">
					</td>
				</tr>
			</table>
		</form>
<script language="JavaScript">
function sel(){
	var ret = "";
	var names = "";
	var o = document.all.item("module_id");
    var i = 0;
    for (; o && o.length && i<o.length; i++)
   	{
		var checkValue = o[i].value.split(",");
		if(o[i].checked && checkValue.length==2){
			ret += checkValue[0] + ",";
			names += checkValue[1] + ",";
		}
	}
	if(i > 0){
		ret = ret.substring(0,ret.length-1);
		names = names.substring(0,names.length-1);
	}
	if(o && !o.length)
    {
	    if(o.checked)
	    ret = o.value.split(",")[0];
	    names = o.value.split(",")[1];
    }
    if(ret == null || ret==""){ 
    	alert("请选择用户!");
	}else{
		window.returnValue = ret+ "|" + names;
		window.close();
	}	
}

</script>
</body>
</base>
</html>