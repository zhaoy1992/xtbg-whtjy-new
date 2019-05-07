<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<% 
//add by minghua.guo 2010-9-29 加个展开级数的参数
String expandLevel = request.getParameter("expandLevel");
expandLevel = expandLevel == null ? "1" : ("".equals(expandLevel.trim()) ? "1" : expandLevel);
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
									<tree:tree tree="common_workflow_select_user_modal_tree"
										node="common_workflow_select_user_modal_tree.node"
										imageFolder="/sysmanager/images/tree_images/" collapse="true"
										includeRootNode="true" mode="static">
										
										<tree:checkbox name="orguser" recursive="true"
											uprecursive="true" />

										<tree:treedata
											treetype="com.chinacreator.commonworkflow.tree.WorkflowSelectUserTree"
											scope="request" rootid="0" rootName="平台机构用户树" expandLevel="<%=expandLevel %>"
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
	var userRealname = "";
	var o = document.all.item("orguser");
    var i = 0;
    for (; o && o.length && i<o.length; i++)
   	{
		var checkValue = o[i].value.split(",");
		if(o[i].checked && checkValue.length==2){
			ret += checkValue[0] + ",";
			userRealname += checkValue[1] + ",";
		}
	}
	if(i > 0){
		ret = ret.substring(0,ret.length-1);
		userRealname = userRealname.substring(0,userRealname.length-1);
	}
	if(o && !o.length)
    {
	    if(o.checked)
	    ret = o.value.split(",")[0];
	    userRealname = o.value.split(",")[1];
    }
    if(ret == null || ret==""){ 
    	alert("请选择用户!");
	}else{
		window.returnValue = ret+ "|" + userRealname;
		window.close();
	}	
}

</script>
</body>
</base>
</html>