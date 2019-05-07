<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
String id = request.getParameter("ID");
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>节点信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="../purviewmanager/css/windows.css" rel="stylesheet" type="text/css">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script language="javascript" type="text/javascript">
		function getvalue() {
			var NODE_NAME = document.frm.NODE_NAME.value.replace(/ /g,"");
			var SERVER = document.frm.SERVER.value.replace(/ /g,"");
			var TARGET = document.frm.TARGET.value.replace(/ /g,"");
			
			if (NODE_NAME == "" || NODE_NAME == null) {
				alert("请输入节点名称！");
				document.frm.NODE_NAME.focus();
				return false;
			}
			if (SERVER == "" || TARGET == null) {
				alert("请输入服务器地址！");
				document.frm.TARGET.focus();
				return false;
			}
			if (TARGET == "" || TARGET == null) {
				alert("请输入目标队列！");
				document.frm.TARGET.focus();
				return false;
			}
			frm.action="mq-configure-modify-do.jsp";
			frm.submit();
		}
	</script>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body >
		<form name="frm" action="">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="thin">
				<tr>
					<td align="center" valign="middle" height="50">
						节点详细信息
					</td>
				</tr>
			</table>
			<input type="hidden" name="NODEID" value="<%=id%>" />
			<pg:listdata
				dataInfo="com.kettle.mq.MqNodeList"
				keyName="MqNodeList" />
			<!--分页显示开始,分页标签初始化-->
			<pg:pager maxPageItems="1" scope="request" data="MqNodeList"
				isList="true">
				<!--list标签循环输出每条记录-->
				<pg:list>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="thin">
						<tr>
							<td width="15%" valign="middle" align="right" height="25">
								节点名称:
							</td>
							<td>
								<input type="text" name="NODE_NAME" value="<pg:cell colName="NODE_NAME" defaultValue="" />" size="100">
							</td>
						</tr>
						<tr>
							<td valign="middle" align="right" height="25">
								服务器地址:
							</td>
							<td>
								<input type="text" name="SERVER" value="<pg:cell colName="SERVER" defaultValue="" />" size="100">
							</td>
						</tr>
						<tr>
							<td valign="middle" align="right" height="25">
								目标队列:
							</td>
							<td>
								<input type="text" name="TARGET" value="<pg:cell colName="TARGET" defaultValue="" />" size="100">
							</td>
						</tr>
						<tr>
							<td valign="middle" align="right" height="25">
								用户名:
							</td>
							<td>
								<input type="text" name="USERNAME" value="<pg:cell colName="USERNAME" defaultValue="" />" size="100">
							</td>
						</tr>
						<tr>
							<td valign="middle" align="right" height="25">
								用户密码:
							</td>
							<td>
								<input type="password" name="PASSWORDS" value="<pg:cell colName="PASSWORDS" defaultValue="" />" size="100">
							</td>
						</tr>
						<tr>
							<td valign="middle" align="right" height="25">
								备 注:
							</td>
							<td>
								<input type="text" name="REMARK" value="<pg:cell colName="REMARK" defaultValue="备注未填" />" size="100">
							</td>
						</tr>
					</table>
				</pg:list>
			</pg:pager>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="middle" height="30" align="right" width="45%">
						<input name="save" type="button" onClick="getvalue()"
							class="input" value="保存" >
					</td>
					<td>
						&nbsp;
					</td>
					<td valign="middle" height="30" align="left" width="45%">
						<input name="Cancel" type="button" id="Cancel"
							onClick="history.back();" value="取 消" class="input">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
