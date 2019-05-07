<%@ page language="java" import="org.apache.commons.lang.StringUtils" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/extTag.tld" prefix="ext"%>
<%
        response.setHeader("Pragma","No-cache");
        response.setHeader("Cache-Control","no-cache");
        response.setDateHeader("Expires",0);
        AccessControl accessControl = AccessControl.getInstance();
		accessControl.checkAccess(request,response);       
		String userId = accessControl.getUserID();
		String appId=accessControl.getCurrentSystemID();
		
        String orgid = StringUtils.defaultString(request.getParameter("orgid"));
        String checkModel=StringUtils.defaultString(request.getParameter("checkModel"));
        String checkedModel="";
     	// rootId-根节点id, rootName-根节点名称, expandLevel-展开级数
     	String rootId = StringUtils.defaultString(request.getParameter("rootId"));
     	String rootName = StringUtils.defaultString(request.getParameter("rootName"));
     	String expandLevel = StringUtils.defaultString(request.getParameter("expandLevel"));
        if(checkModel.equals("single")){
           checkedModel="collapsible:true,titleCollapse:true,onlyLeafCheckable:true";
        }else{
           checkedModel="collapsible:true,titleCollapse:true";
        }
        boolean rootExpand = false;//是否展开根节点
        int level = 0;
        try{
        	level = Integer.parseInt(expandLevel);
        }catch(Exception e){
        	
        }
        if(level > 0){
        	rootExpand = true;
        }
        String s_gif = request.getContextPath()+"/eformsys/fceform/js/Ext/images/default/s.gif";
%>
<html>
	<head>
		<title>Ext tree</title>

		<meta http-equiv="description" content="tree">

		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/eformsys/fceform/js/Ext/css/ext-all.css" />
		<style type="text/css">
		#mycss{
			background: url(<%=request.getContextPath()%>/eformsys/fceform/js/Ext/images/default/dd/drop-add.gif) no-repeat left 6px;
		}
		</style>
	</head>
	<!-- ext begin -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/eformsys/fceform/js/Ext/ext-base.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/eformsys/fceform/js/Ext/ext-all.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/eformsys/systemManager/dwt/DWRTreeLoader.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/eformsys/systemManager/dwt/TreeCheckNodeUI.js"></script>
	<!-- ext end -->
	<!-- dwr begin -->
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/dwr/engine.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/dwr/util.js"></script>
	<script type="text/javascript"
		src="<%=request.getContextPath()%>/dwr/interface/FileManager.js"></script>
	<!-- dwr end -->
	
    <script type="text/javascript">
		    var currentUserId='<%=userId%>';
		    var currentAppId='<%=appId%>';
		    var expandLevel = '<%=expandLevel %>';
		    var rootId = '<%=rootId %>';
	</script>
	<body>
		<form name="delform" action="" target="hiddenFrame">
		<input type=hidden name="orgId">
		</form>
		<ext:menu id="menu">
			<ext:item text="编辑" id="rMenu1" disabled="false" iconCls='mycss'onClick="editNode(rightClickNode)"/>
		</ext:menu>
		<ext:tree 
		    id="tree"
			blankImg="<%=s_gif %>" 
			dwrCall="FileManager.getOrgUserById"
			el="tree-div"
			treeModel="readonly" 
			title="机构用户树" 
			titleAlign="center" 
			other="<%=checkedModel%>" >
			<ext:checkbox checkModel="<%=checkModel%>"/>
			<ext:root text="<%=rootName %>" id="<%=rootId %>" expanded="<%=rootExpand %>" icon=""/>
		</ext:tree>
		
	</body>
</html>