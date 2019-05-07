<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.chinacreator.workflow.shark.procconfig.XMLManager"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.workflow.shark.procconfig.Panel"%>
<%@ page import="java.util.*,java.io.File"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<title>选择表单</title>

		<!-- dwr begin -->
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/engine.js'></script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/util.js'></script>
		<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/interface/processConfigManager.js'></script>
		<!-- dwr end -->

		<%
			String activity_form = "";
			if (request.getParameter("activity_form") != null
					&& !"".equals(request.getParameter("activity_form"))) {
				activity_form = request.getParameter("activity_form");
			}
		%>
		<%
			boolean isShowEform = false;
			boolean isShowPath = false;
		%>
		<%
			XMLManager xMLManager = new XMLManager();
			List list = xMLManager.getActivityForm();
			for (int i = 0; i < list.size(); i++) {
				Panel p = (Panel) list.get(i);
				if ("eForm".equals(p.getPanel_name())) {
					isShowEform = true;
				} else if ("otherForm".equals(p.getPanel_name())) {
					isShowPath = true;
				}
			}
		%>

		<script language="javascript">
		
			var eform_id = '<%=activity_form%>';
			
			String.prototype.getQueryString = function(name){
				var reg = new RegExp('(^|&|\\?)'+ name +'=([^&]*)(&|$)'), r;
				if ( r=this.match(reg) ){
					return unescape(r[2]);
				}
				return '';
			}
			//初使化
			function initData(){
				if(IsURL(eform_id)&&<%=isShowPath%>==true){
					 eformPath.value = eform_id;
					 selectRadio('url');
				}else if(<%=isShowPath%>==true){
					eformID.value = eform_id;
					getFromName(eform_id);
				}
				onclickRadio();
				if(<%=isShowEform%>==true&&<%=isShowPath%>==false){
					document.getElementById('eformRadioID').checked='checked';
				}else if(<%=isShowEform%>==false&&<%=isShowPath%>==true){
					document.getElementById('pathRadioID').checked='checked';
				}
				if(<%=isShowEform%>==false&&<%=isShowPath%>==false){
					alert('没数据显示!');
				}
			}
			//弹出选择eform页面
			function showEform(){
				eform_id = window.showModalDialog("../../eformsys/fceform/eformTree/eformTree.jsp","", "font-family:Verdana; font-size:12; status:no; unadorned:no; scroll:yes; resizable:yes;dialogWidth:600px; dialogHeight:500px");
				if(eform_id!=undefined&&eform_id!=''){
					eform_id = eform_id.getQueryString("djsn");
					getFromName(eform_id);
				}
			}
			
			//根据ID调用DRW获得表单名称
			function getFromName(e_id){
				if(e_id!=undefined&&e_id!=''){
					processConfigManager.getEformNameByID(e_id,EcallBack);
				}
			}
			
			//回调函数
			function EcallBack(eform_name){
				eformName.value = eform_name;
				eformID.value = eform_id;
			}
			
			//提交表单
			function submitForm(){
				var group = document.getElementsByName('isSelect');
				var selectValue = '';
				var eformValue = '';
				for(var i = 0; i< group.length; i++){
				   if(group[i].checked){
					   selectValue = group[i].value;
					}
				}
				if(selectValue=='url'){
					if(IsURL(eformPath.value)||eformPath.value==''){
						window.returnValue = eformPath.value;
						window.close();
					}else{
						alert('输入的URL有误，请按 /test.jsp?id=1234 这种格式输入!');
					}
				}else{
					window.returnValue = eformID.value;
					window.close();
				}
			}
			
			//判断传入的值是URL还是表单编号
			function selectRadio(radioValue){
				var group = document.getElementsByName('isSelect');
				for(var i = 0; i< group.length; i++){
				   if(group[i].value==radioValue){
					   group[i].checked = 'checked';
					}
				}
			}
			
			//判断URL格式是否正确 格式: /test.jsp?id=111
			function IsURL(urlString){
				regExp = '^/(\\S*)+\\.+(jsp|do|html|htm)(\\x3F\\S*)*';
		        if (urlString.match(regExp)){
		        	return true;
		        }else{
		        	return false;
		        }
			}
			
			//根据选择的 radio 禁用一些按钮
			function onclickRadio(){
				var group = document.getElementsByName('isSelect');
				var selectValue = '';
				for(var i = 0; i< group.length; i++){
				   if(group[i].checked){
					   selectValue = group[i].value;
					}
				}
				if(selectValue=='url'&&<%=isShowPath%>==true){
					eformPath.readOnly = false;
					selectForm.disabled = 'disabled';
				}else if(<%=isShowEform%>==true){
					selectForm.disabled = '';
					selectForm.focus();
					eformPath.readOnly = true;
				}
			}
			//点击DIV选择radio
			function onclickDiv(value){
				var group = document.getElementsByName('isSelect');
				var selectValue = '';
				for(var i = 0; i< group.length; i++){
					if( group[i].value==value){
					   group[i].checked = 'checked';
					}
				}
				onclickRadio();
			}			
		</script>

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body onload="initData();">
		<table align="center">
			<tr style="<%if(!isShowPath){%>display:none<%}%>">
				<td>
					<table>
						<tr>
							<td>
								<input id="pathRadioID" name="isSelect" type="radio" value="url" onclick="onclickRadio();" />
								<span onclick="onclickDiv('url');">绑定URL</span>
							</td>
						</tr>
						<tr>
							<td>
								<div style="font-size:12px; background-color:#CCCCCC; border: 1px solid #6699cc; height: 50px;">
									<table width="100%" border="0">
										<tr>
											<td>
												表单路径：<input name="eformPath" type="text" value="" style="width:275px" />
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr><td>&nbsp;</td>	</tr>

			<tr style="<%if(!isShowEform){%>display:none<%}%>">
				<td>
					<table>
						<tr>
							<td>
								<input id="eformRadioID" name="isSelect" type="radio" value="eform" checked="checked" onclick="onclickRadio();" />
								<span onclick="onclickDiv('eform');">绑定EForm表单</span>
							</td>
						</tr>
						<tr>
							<td>
								<div style="font-size:12px;  background-color:#CCCCCC; border: 1px solid #6699cc; height: 80px;">
									<table width="100%" border="0">
										<tr>
											<td>
												表单编号：
												<input name="eformID" type="text" value="" readonly="true" style="width:198px" />
												<input name="selectForm" type="button" value="选择表单" onclick="showEform();" />
											</td>
										</tr>
										<tr>
											<td>
												表单名称：
												<input name="eformName" type="text" value="" readonly="true" style="width:274px" />
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>

			<tr><td>&nbsp;</td>	</tr>

			<tr>
				<td align="center">
					<%if (isShowEform || isShowPath){%>
					<input name="button" type="button" value="确定" onclick="submitForm();" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="button" type="button" value="关闭" onclick="javascript:window.close();" />
					<%}%>
				</td>
			</tr>
		</table>
	</body>
</html>

