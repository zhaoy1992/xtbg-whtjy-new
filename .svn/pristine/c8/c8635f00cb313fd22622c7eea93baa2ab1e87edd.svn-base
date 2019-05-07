<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
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
			//得到更新方式
			function getIssueType(){
				var issueType = document.getElementsByName("sel");
				for(var i=0;i<issueType.length;i++){
					if(issueType[i].checked){
						return issueType[i].value;
					}
				}
				return 0;
			}	
			
			
			//页面跳转
			function jumpPage(obj){
				
				//提交后页面变灰
				popSignFlow(1);
				
				if(getIssueType()==0){
					alert("请选择更新方式！");
					return;
				}else if(getIssueType()=="record"){
				//	document.location.assign("");
				}else if(getIssueType()=="appdown"){
					document.location.assign("expmenulist.jsp");
				}else{
					document.location.assign("moduleselect.jsp");
				}
			}
		</script>

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">		
			<div id="contentborder" align="center">
				<br />
				<br />				
				<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2">更新选择</FONT>
						</LEGEND>
				<br />
				<table width="85%">
					<tr>
						<td align="center" height="35">
							<input type="radio" name="sel" value="apply" checked="checked" />
							手动配置
						</td>
					</tr>
					<!-- 
					<tr>
						<td align="center" height="35">
							<input type="radio" name="sel" value="record"  />
							记录选择
						</td>
					</tr>
					 -->
					<tr>
						<td align="center" height="35">
							<input type="radio" name="sel" value="appdown"  />
							更新下载
						</td>
					</tr>					
				</table>
				</fieldset>					
					<div align="center">
					<table width="15%" border="0" align="right" cellpadding="0" cellspacing="0">
						<tr>
							<td>
								<div align="left">									
									<input name="Submit" type="button" class="input" value="下一步" onClick="jumpPage('next')">									
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>		
	</body>
</html>
