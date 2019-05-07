<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
/*
 * <p>Title: SPI服务监控树</p>
 * <p>Description: SPI服务监控树</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-9-8
 * @author biaoping.yin
 * @version 1.0
 */
 String rootpath = request.getContextPath();
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		
		<link rel="stylesheet" type="text/css" href="<%=rootpath%>/sysmanager/css/treeview.css">
		<link rel="stylesheet" type="text/css" href="<%=rootpath%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="<%=rootpath%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="<%=rootpath%>/sysmanager/css/tab.winclassic.css">
		
	<script src="<%=rootpath %>/include/queryTreenode.js"></script>
	</head>

<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
<div align="center">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="table">
		<tr>
		<td align="left">
		<input name="blurryValue" type="text" onpropertychange="onBlurryQueryChange('queryBtn','nextBtn')" onkeydown="enterKeydowngo('blurryValue','queryBtn','nextBtn')"/>
		</td>
	</tr>
	<tr>
	<td align="right">
		<input type="button" name="queryBtn" value="查询" onclick="blurryQuary('blurryValue','queryBtn','nextBtn')"  class="input">
		<input style="display:none" name="nextBtn" type="button" value="查找下一个" onclick="nextNodes('queryBtn','nextBtn')" class="input">
		</td>
	</tr>
	</table>
</div>
<table height="100%"  width="100%" background="../images/left_center_bg.jpg"><tr ><td  width="100%" height="100%" valign=top>
<div id="contentborder" style="width=100%;height:89%;overflow:auto">
    <table>
        <tr><td align="left"> 
         <tree:tree tree="spitree"
    	           node="spitree.node"
    	           imageFolder="/monitor/tree_images/"
    	           collapse="true"
    			   includeRootNode="true"
    			   href="#"
    			   target="configfileDetail" 
    			   mode="static"> 
    			   <tree:treedata treetype="com.chinacreator.spi.monitor.SPITree"
    	                   scope="request"
    	                   rootid="0"  
    	                   rootName="SPI管理"
    	                   expandLevel="1"
    	                   showRootHref="false"
    	                   needObserver="false"
    	                   enablecontextmenu="false"
    	                   />
    	          
    	</tree:tree>
         </td></tr>
    </table>
</div>
	</td></tr></table>
	

</body>
</html>