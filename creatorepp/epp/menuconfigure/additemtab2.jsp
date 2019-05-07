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
				var r = document.itemform.moduletype;
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
					itemform.action="additemtab1.jsp";
					document.location.assign("additemtab1.jsp");					
				}//跳往下一页面	
				else if(isPath=="nextadditem"){
					itemform.action="additemtab3.jsp";
					document.location.assign("additemtab3.jsp");
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
				<input type="hidden" name="configtype" value="<%=configtype%>"/>
				<input type="hidden" name="currentSystemID" value="<%=currentSystemID%>"/>
				<input type="hidden" name="moduleId" value="<%=moduleId%>"/>
				<input type="hidden" name="isEdit" value="<%=isEdit%>"/>
				<input type="hidden" name="isFill" value="true"/>
				<input type="hidden" name="itemdisicon" value="<%=itemdisicon%>" />
				<input type="hidden" name="itemenicon" value="<%=itemenicon%>" />
				<br/>
				<fieldset style="width: 95%;">
						<LEGEND align=center>
							<FONT size="2"> 模型属性</FONT>
						</LEGEND>	
						<br/>		
				<table width="90%" height="25" border="0" cellpadding="0"
					cellspacing="1" class="thin">
					<tr class="tr">
						<td width="20%" height="35" class="detailtitle" align="center">
							<img
								src="<%=request.getContextPath()%>/epp/menuconfigure/images/model-1.bmp"
								width="300" height="130" />							
							模型一:
							<input type="radio" name="moduletype" id="moduletype" value="1"
								checked="checked" />
						</td>
						<td width="20%" height="35" class="detailtitle" align="center">

							<img
								src="<%=request.getContextPath()%>/epp/menuconfigure/images/model-2.bmp"
								width="300" height="130" />							
							模型二:
							<input type="radio" name="moduletype" id="moduletype" value="2" />
						</td>
					</tr>
					<tr class="tr">
						<td width="20%" height="35" class="detailtitle" align="center">
							<img
								src="<%=request.getContextPath()%>/epp/menuconfigure/images/model-3.bmp"
								width="300" height="130" />							
							模型三:
							<input type="radio" name="moduletype" id="moduletype" value="3" />
						</td>
						<td width="20%" height="35" class="detailtitle" align="center">
							<img
								src="<%=request.getContextPath()%>/epp/menuconfigure/images/model-4.bmp"
								width="300" height="130" />							
							模型四:
							<input type="radio" name="moduletype" id="moduletype" value="4" />
							<br />
						</td>
					</tr>
				</table><br/>
				</fieldset>
				
				<table width="85%" border="0" align="center" cellpadding="0"
					cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="right">
								<br />
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
		var r = document.itemform.moduletype;
			for(var i = 0; i < r.length; i++){
   						if(r[i].value == "<%=moduletype%>"){
    							r[i].checked = true;
    							break;
   							}
						}
	</script>
	<iframe name="item" width="0" height="0" style="display: none;"></iframe>
</html>
