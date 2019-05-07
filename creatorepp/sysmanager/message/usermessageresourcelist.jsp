<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl
				,com.chinacreator.message.factory.MessageDaoFactory"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);

	String r_name = (String) request.getParameter("r_name");
	String r_desc = (String) request.getParameter("r_desc");
	String user_id = control.getUserID();

	if (r_name == null) {
		r_name = "";
	}
	if (r_desc == null) {
		r_desc = "";
	}
%>
<html>
	<head>
		<title>属性容器</title>

		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/sysmanager/css/tab.winclassic.css">
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/applymanager/common.js"
			type="text/javascript"></script>
		<script language="JavaScript" src="../../include/pager.js"
			type="text/javascript"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/sysmanager/scripts/common.js"
			type="text/javascript"></script>
		<script language="JavaScript">

		function setUserMessageResource() {
			var isSelect = false;
			for (var i=0; i<MessageResourceForm.elements.length; i++) {
				var e = MessageResourceForm.elements[i];
				if (e.name == 'checkBoxOne') {
					if (e.checked) {
			       		isSelect = true;
			       		break;
			       	}
		    	}
		    }

		    if (!isSelect) {
		    	alert("没有选择任何记录！");
		   		return false;
		    }

		    if (window.confirm("是否确定按照系统默认值设置？")) {
		    	var ids = "";
		    	var form = document.forms[0];
		    	var checkBoxElements = document.getElementsByName('checkBoxOne');
		    	for (var i = 0; i < checkBoxElements.length; i++) {
		    		if (checkBoxElements[i].checked) {
						ids += "'" + checkBoxElements[i].value + "',";
		    		}
		    	}
		    	if (ids!=null && ids.length>0) {
		    		ids = ids.substr(0, ids.length-1);
		    	}

				form.action = "setusermessageresource.jsp?ids=" + ids;
				form.target = "hiddenFrame";
				form.submit();

			}
		}

		var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
		function setBackColor(e){
			jsAccessControl.setBackColor(e);
		}

		function refresh() {
			window.parent.location.reload();
			getNavigatorContent().location.reload();
		 	return true;
		}

		function editUserMessageResource(r_id, r_state) {
			var retx=window.showModalDialog("<%=request.getContextPath()%>/sysmanager/message/editusermessageresource.jsp?r_id="+r_id + "&r_state="+r_state,window);
			if(retx=='refresh'){
				window.location.reload();
			}
		}
		
		function resetsel(){
			document.MessageResourceForm.r_name.value="";
			document.MessageResourceForm.r_desc.value="";
		}

</script>
		<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" scroll="no">
		<div id="contentborder" align="center">
			<form name="MessageResourceForm" id="MessageResourceForm" action="usermessageresourcelist.jsp" method="post">
				<table width="100%" border="0" cellpadding="1" cellspacing="1"
					class="thin">
					<tr>
						<td class="detailtitle" width="10%" align=right>
							消息资源名称：
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="r_name" value="<%=r_name %>" style="width:70%">
						</td>
					</tr>
					<tr>
						<td class="detailtitle" width="10%" align=right>
							消息资源描述：
						</td>
						<td class="detailcontent" width="90%">
							<input type="text" name="r_desc" value="<%=r_desc %>" style="width:70%">
						</td>
					</tr>
					<tr>
						<td width="16%">
						</td>
						<td class="detailcontent" width="30%" align="right">
							<input name="Submit4" type="submit" class="input" value="查询">
							<input name="Submit22" type="button" class="input" value="清空" onclick="resetsel();">
						</td>
					</tr>
				</table>
				<hr width="100%">

				<table width="100%" border="0" cellpadding="0" cellspacing="1"
					class="thin">

					<tr>
						<td height='30' class="detailtitle" align=center colspan=10>
							<b>消息资源列表</b>
						</td>
					</tr>
					<pg:listdata
						dataInfo="com.chinacreator.epp.message.menu.UserMessageResourceList"
						keyName="UserMessageResourceList" />
					<!--分页显示开始,分页标签初始化-->
					<pg:pager maxPageItems="10" scope="request"
						data="UserMessageResourceList" isList="false">
						<tr class="labeltable_middle_td">
							<!--设置分页表头-->
							<td class="headercolor" width="6%">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll"
										onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
								</P>
							</td>
							<td height='20' class="headercolor">
								消息资源名称
							</td>
							<td height='20' class="headercolor">
								消息资源描述
							</td>
							<%
									String [][] dictNoStr =MessageDaoFactory.getMessageDict().getDictNo();
									for(String[] no : dictNoStr){
									
								%>
								<td height='20' class="headercolor"><%=no[1] %>
								<% 
								}
								%>
							
							<!-- 
							<td height='20' class="headercolor">
								短信
							</td>
							<td height='20' class="headercolor">
								邮件
							</td>
							<td height='20' class="headercolor">
								RTX
							</td>
							
							 -->
							 <td height='20' class="headercolor">
								状态
							</td>
						</tr>

						<pg:param name="r_name" />
						<pg:param name="r_desc" />

						<!--检测当前页面是否有记录-->
						<pg:notify>
							<tr height='25' class="labeltable_middle_tr_01">
								<td colspan=100 align='center'>
									暂时没有消息资源
								</td>
							</tr>
						</pg:notify>

						<!--list标签循环输出每条记录-->
						<pg:list>
							<tr class="labeltable_middle_tr_01"
								onMouseOver="this.className='mousestyle1'"
								onMouseOut="this.className= 'mousestyle2'"
								onclick="setBackColor(this)"
								onDBLclick="editUserMessageResource('<pg:cell colName="r_id" defaultValue=""/>'
								,'<pg:cell colName="r_state" defaultValue=""/>')"
								id="<pg:cell colName="r_id" defaultValue=""/>">
								<td class="tablecells" nowrap="true">
									<P align="left">
										<INPUT type="checkbox" name="checkBoxOne"
											onclick="checkOne('checkBoxAll','checkBoxOne')"
											value='<pg:cell colName="r_id" defaultValue=""/>'>
									</P>
								</td>
								<td height='20' align=left class="tablecells">
									<pg:cell colName="r_name" defaultValue="" />
								</td>
								<td height='20' align=left class="tablecells">
									<pg:cell colName="r_desc" defaultValue="" />
								</td>
								
									<%
								   String [][] dictNoArr = MessageDaoFactory.getMessageDict().getDictNo();
								   String strSMS= dataSet.getString("r_sms");
								   for(int i = 0 ; i< dictNoArr.length;i++){
								   		if(strSMS.indexOf(dictNoArr[i][0])!=-1){
								 %>
								  	 <td height='20' align=left class="tablecells">开</td>
								 <% 
								 		}else{
								 %>
								 	<td height='20' align=left class="tablecells">关</td>
								 <% 
								 		}
								   }
								 %>
								 <%
								 String r_state= dataSet.getString("r_state");
								 if("1".equals(r_state)){
								 System.out.println(r_state);
								 %>
								 <td height='20' align=left class="tablecells">用户自定义</td>
								 <%
								 }else{
								 %>
								  <td height='20' align=left class="tablecells">系统默认值</td>
								<%
								}
								 %>
								
								<!--  
								<td height='20' align=left class="tablecells">
									<pg:equal colName="r_sms" expressionValue="1">开</pg:equal>
									<pg:equal colName="r_sms" expressionValue="0">关</pg:equal>
								</td>
								<td height='20' align=left class="tablecells">
									<pg:equal colName="r_sys" expressionValue="1">开</pg:equal>
									<pg:equal colName="r_sys" expressionValue="0">关</pg:equal>
								</td>
								<td height='20' align=left class="tablecells">
									<pg:equal colName="r_rtx" expressionValue="1">开</pg:equal>
									<pg:equal colName="r_rtx" expressionValue="0">关</pg:equal>
								</td>
								<td height='20' align=left class="tablecells"> 
									<pg:equal colName="r_state" expressionValue="1">用户自定义</pg:equal>
									<pg:equal colName="r_state" expressionValue="0">系统默认值</pg:equal>
								</td>-->
						</pg:list>
						<tr height="30" class="labeltable_middle_tr_01">
							<td colspan=100 align='right'>
								共
								<pg:rowcount />
								条记录
								<pg:index />

								<input type="button" value="按系统默认值" class="input"
									onclick="setUserMessageResource()" />
							</td>
						</tr>
					</pg:pager>

				</table>

				<div align="center">
				</div>
			</form>
		</div>

	</body>
	<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>
