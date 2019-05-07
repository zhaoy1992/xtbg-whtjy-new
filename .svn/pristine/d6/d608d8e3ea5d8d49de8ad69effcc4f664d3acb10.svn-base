<%@ page contentType="text/html; charset=GBK"%>
<%@include file="item.jsp" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link rel="stylesheet" type="text/css"
			href="../../purviewmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="../../purviewmanager/css/treeview.css">
		<tab:tabConfig />
		<base target="_self">
		<title>新增模块</title>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>

		<script language="javascript">			
			
			//得到选项值
			function getradiovalue(){
				var r = document.itemform.configtype;
					for(var i = 0; i < r.length; i++){
   						if(r[i].checked){
    						return r[i].value;
   							}
						}
			}
			
			
			//判断用户按键
			var isPath = "";
			function evaluate(value){
				isPath = value;
			}
			
			//表单提交时跳转
			function sub(){
				//跳往上一页面
				if(isPath=="backadditem"){
					itemform.action="additemtab2.jsp";
					document.location.assign("additemtab2.jsp");					
				}//跳往下一页面	
				else if(isPath=="nextadditem"){
					itemform.action="additemtab4.jsp";
					document.location.assign("additemtab4.jsp");
				}
			}
			
					
		</script>

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" onload="" scroll="no">
		<div id="contentborder" align="center">
			<form method="post" name="itemform" onsubmit="sub()">
				<input type="hidden" name="id" value="<%=id%>"/>
				<input type="hidden" name="name" value="<%=name%>"/>
				<input type="hidden" name="navigatortoolbar" value="<%=navigatortoolbar%>"/>
				<input type="hidden" name="navigatorcontent" value="<%=navigatorcontent%>"/>
				<input type="hidden" name="workspacetoolbar" value="<%=workspacetoolbar%>"/>
				<input type="hidden" name="workspacecontent" value="<%=workspacecontent%>"/>
				<input type="hidden" name="isUsed" value="<%=isUsed%>"/>
				<input type="hidden" name="moduletype" value="<%=moduletype%>"/>				
				<input type="hidden" name="currentSystemID" value="<%=currentSystemID%>"/>
				<input type="hidden" name="moduleId" value="<%=moduleId%>"/>
				<input type="hidden" name="isEdit" value="<%=isEdit%>"/>
				<input type="hidden" name="isFill" value="true"/>	
				<input type="hidden" name="itemdisicon" value="<%=itemdisicon%>" />
				<input type="hidden" name="itemenicon" value="<%=itemenicon%>" />
				<br/>
				<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2"> 配置来源</FONT>
						</LEGEND>	
						<br/>						
						<br/>
						<input type="radio" name="configtype" value="1" checked="checked"/>表单
						<br/>
						<input type="radio" name="configtype" value="2"/>流程
						<br/>
						<input type="radio" name="configtype" value="3"/>文件							
						<br/>
						<input type="radio" name="configtype" value="4"/>报表							
						<br/>
						<br/>
						<br/>
				</fieldset>
				<table width="85%" border="0" align="center" cellpadding="0"
					cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="right">
								<br/>
								<input name="update" type="submit" onclick="evaluate('backadditem')"
									class="input" value="上一步">
								<input name="update" type="submit" onclick="evaluate('nextadditem')"
									class="input" value="下一步">
								<input name="calc" type="reset" class="input" value="重置">
								<input name="calc" type="button" class="input" value="返回"
									onClick="window.close();window.returnValue=true;">
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
	<script type="text/javascript">
		var r = document.itemform.configtype;
			for(var i = 0; i < r.length; i++){
   						if(r[i].value == <%=configtype%>){
    							r[i].checked = true;
    							break;
   							}
						}
	</script>
	<iframe name="item" width="0" height="0" style="display: none;"></iframe>
</html>
