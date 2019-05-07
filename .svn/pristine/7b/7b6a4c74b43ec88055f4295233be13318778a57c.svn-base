<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/treetag.tld" prefix="tree"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@include file="expmenuconfigvo.jsp" %>
<html>
	<head>
		<title>属性容器</title>

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js" type="text/javascript"></script>

		<!-- 提交后页面变灰 -->
		<script language="javascript" type="text/javascript" src="../pageGrey.js">
		</script>		
		
		<script language="JavaScript" type="text/javascript">
			//得到选择
			function getWorkclassCheck(){
				var workclass = "";	
				var obj = document.getElementsByName("mybox");
				for (var i=0;i<obj.length;i++) {								
					if (obj[i].checked){
			       		workclass += obj[i].value + ",";			       					       		
				   } 
				}				
				return workclass;
			}
			
			//页面跳转
			function jumpPage(obj){
				if(obj=="back"){					
					document.myform.action="moduleselect.jsp";					
				}else if(obj=="next"){					
					document.myform.workclass.value=getWorkclassCheck();					
					document.myform.action="filelist.jsp";
				}
				//提交后页面变灰
				popSignFlow(1);
				
				document.myform.submit();
			}
		</script>

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
		<form name="myform" method="post">
			<input type="hidden" name="isFill" value="true">
				<input type="hidden" name="moduleID" value="<%=moduleID%>">
				<input type="hidden" name="workclass" value="<%=workclass%>">
				<input type="hidden" name="sel_eform_id" value="<%=sel_eform_id%>">
				<input type="hidden" name="sel_jawe_id" value="<%=sel_jawe_id%>">
				<input type="hidden" name="sel_report_id" value="<%=sel_report_id%>">
				<input type="hidden" name="sel_filepath" value="<%=sel_filepath%>">
				<input type="hidden" name="default_businessclass_id" value="<%=default_businessclass_id%>">
				<input type="hidden" name="default_eform_id" value="<%=default_eform_id%>">
				<input type="hidden" name="default_jawe_id" value="<%=default_jawe_id%>">				
				<input type="hidden" name="default_report_id" value="<%=default_report_id%>">
				<input type="hidden" name="default_filepath" value="<%=default_filepath%>">
				<input type="hidden" name="init_sel_eform_id" value="<%=init_sel_eform_id%>">
				<input type="hidden" name="init_sel_jawe_id" value="<%=init_sel_jawe_id%>">
				<input type="hidden" name="init_sel_report_id" value="<%=init_sel_report_id%>">
				<input type="hidden" name="init_sel_filepath" value="<%=init_sel_filepath%>">			
			<div id="contentborder" align="center">
				<br />
				<br />
				<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">业务类别选择</FONT>
						</LEGEND>
				<br />
				<table width="85%">
					<tr>
						<td width="200">
						</td>
						<td align="left" height="35">
							<tree:tree tree="workclassselect_tree" 
										node="workclassselect_tree.node" 
										imageFolder="/sysmanager/images/tree_images/" 
										collapse="true" 
										includeRootNode="true" 
										dynamic="false" 
										mode="static">
							<tree:checkbox name="mybox" recursive="true" uprecursive="true"/>
							<tree:treedata treetype="com.chinacreator.eppissue.menuissue.expmenu.menu.BusinessclassSelectTree" 
										scope="request" 
										rootid="0" 
										rootName="业务类别" 
										expandLevel="1" 
										showRootHref="false" 
										needObserver="false" checkboxValue="0"/>
							</tree:tree>

						</td>						
					</tr>					
				</table>
				</fieldset>					
					<div align="center">
					<table width="25%" border="0" align="right" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<div align="left">									
									<!-- <input name="Submit" type="button" class="input" value="上一步" onclick="jumpPage('back');"> -->
									<input name="Submit" type="button" class="input" value="下一步" onClick="jumpPage('next');">
									<input name="Submit" type="button" class="input" value="返回" onClick="window.close();">
								</div>
							</td>
						</tr>
					</table>
			</div>
		</form>
	</body>
</html>
