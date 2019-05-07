<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(pageContext);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>节点信息列表</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="../purviewmanager/css/windows.css" rel="stylesheet" type="text/css">
		<script language="javascript" type="text/javascript">
		//删除
		function deleteInfo(){
			var id = document.getElementsByName("checkBoxOne");
			var checkId = "";
			var outMsg;
			
			if(id.length){
				for(var i = 0; i < id.length; i ++){
					if(!id[i].checked){
						continue;
					}else{				
						checkId += "'" + id[i].value.split("-")[0] + "',";
						var idValue = id[i].value ;
					}
				}
				if(checkId == ""){
					alert("至少选择一条信息进行删除！");
					return;
				} else {
					outMsg = "你确定要删除吗？(删除后是不可以再恢复的)。";
			    	if (confirm(outMsg)){
			    		if (checkId.substr((checkId.length - 1),1) == ",") {
			    			checkId = checkId.substring(0, (checkId.length - 1));	//去掉字符串最后面的","
			    		}
			    	
			    		form1.action="mq-configure-delete.jsp?ID="+checkId;
			    		form1.submit();
					}
				}
			}
		}
		
		//
		function add() {
			form1.action="mq-configure-add.jsp";
			form1.submit();
		}
</script>
	</head>

	<%@ include file="/epp/css/cssControl.jsp"%><body >
		<form name="form1" method="post">
			<table width="100%" height="30" border="0" cellpadding="0"
				cellspacing="0" class="thin">
				<tr>
					<td align="center" valign="middle">
						节点信息列表
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="30" align="right">
						<label>
							<input type="button" name="sss"
								onClick="add();" value="新 增" class="input">
							&nbsp;&nbsp;
						</label>
						<label>
							<input type="button" name="deletemap"
								onClick="return deleteInfo();"
								value="删 除" class="input">
						</label>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</table>
			<pg:listdata
				dataInfo="com.chinacreator.kettle.mq.MqNodeList"
				keyName="MqNodeList" />
			<!--分页显示开始,分页标签初始化-->
			<pg:pager maxPageItems="15" scope="request" data="MqNodeList" isList="false">
				<table width="100%" border="0" cellpadding="1" cellspacing="0"
					 class="thin" bordercolor="#EEEEEE">
					<tr>
						<td align="center" valign="middle" class="headercolor">
							<div align="center">
								<P align="left">
									<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
								</P>
							</div>
						</td>
						<td align="center" valign="middle" class="headercolor">
							<div align="center">
								节点名称
							</div>
						</td>
						<td align="center" valign="middle" class="headercolor">
							<div align="center">
								服务器地址
							</div>
						</td>
						<td align="center" valign="middle" class="headercolor">
							<div align="center">
								目标队列
							</div>
						</td>
						<td align="center" valign="middle" class="headercolor">
							<div align="center">
								用户名
							</div>
						</td>
						<td align="center" valign="middle" class="headercolor">
							<div align="center">
								密码
							</div>
						</td>
						<td align="center" valign="middle" class="headercolor">
							<div align="center">
								备注
							</div>
						</td>
					</tr>
					<pg:notify>
						<tr height="33px" class="labeltable_middle_tr_01">
							<td colspan=9 align='center'>
								暂时没有信息
							</td>
						</tr>
					</pg:notify>
					<pg:list>
						<tr class="Ctable">
							<td width="5">
								<div align="center">
									<INPUT type="checkbox" name="checkBoxOne"
										onClick="checkOne('checkBoxAll','checkBoxOne')"
										value='<pg:cell colName="NODE_ID" defaultValue=""/>'>
								</div>
							</td>
							<td width="80">
								<div align="left">
									<a href="mq-configure-modify.jsp?ID=<pg:cell colName='NODE_ID' />"> <pg:cell colName="NODE_NAME"
											defaultValue="" maxlength="30" replace="..." /> </a>
								</div>
							</td>
							<td>
								<div align="center" id="SERVER">
									<pg:cell colName="SERVER" defaultValue="" maxlength="30"
										replace="..." />
								</div>
							</td>
							<td>
								<div align="center" id="TARGET">
									<pg:cell colName="TARGET" defaultValue="" maxlength="30"
										replace="..." />
								</div>
							</td>
							<td>
								<div align="center" id="USERNAME">
									<pg:cell colName="USERNAME" defaultValue="" maxlength="30"
										replace="..." />
								</div>
							</td>
							<td>
								<div align="center" id="PASSWORDS">
									<pg:cell colName="PASSWORDS" defaultValue="" maxlength="30"
										replace="..." />
								</div>
							</td>
							<td>
								<div align="center" id="REMARK">
									<pg:cell colName="REMARK" defaultValue="" maxlength="30"
										replace="..." />
								</div>
							</td>
						</tr>
					</pg:list>
				</table>
				<table align="center">
					<tr>
						<td align="center">
							&nbsp;&nbsp;每页 15 条&nbsp;&nbsp;共
							<font style="color: red; font-size: 12px"><pg:rowcount />
							</font>条
							<pg:index />
						</td>
					</tr>
				</table>
				<input id="queryString" name="queryString" value="<pg:querystring/>"
					type="hidden">
				</input>
			</pg:pager>
			</table>
		</form>
	</body>
</html>
