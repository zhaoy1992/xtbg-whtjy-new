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
		<title>�ڵ���Ϣ�б�</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link href="../purviewmanager/css/windows.css" rel="stylesheet" type="text/css">
		<script language="javascript" type="text/javascript">
		//ɾ��
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
					alert("����ѡ��һ����Ϣ����ɾ����");
					return;
				} else {
					outMsg = "��ȷ��Ҫɾ����(ɾ�����ǲ������ٻָ���)��";
			    	if (confirm(outMsg)){
			    		if (checkId.substr((checkId.length - 1),1) == ",") {
			    			checkId = checkId.substring(0, (checkId.length - 1));	//ȥ���ַ���������","
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
						�ڵ���Ϣ�б�
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="30" align="right">
						<label>
							<input type="button" name="sss"
								onClick="add();" value="�� ��" class="input">
							&nbsp;&nbsp;
						</label>
						<label>
							<input type="button" name="deletemap"
								onClick="return deleteInfo();"
								value="ɾ ��" class="input">
						</label>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</table>
			<pg:listdata
				dataInfo="com.chinacreator.kettle.mq.MqNodeList"
				keyName="MqNodeList" />
			<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
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
								�ڵ�����
							</div>
						</td>
						<td align="center" valign="middle" class="headercolor">
							<div align="center">
								��������ַ
							</div>
						</td>
						<td align="center" valign="middle" class="headercolor">
							<div align="center">
								Ŀ�����
							</div>
						</td>
						<td align="center" valign="middle" class="headercolor">
							<div align="center">
								�û���
							</div>
						</td>
						<td align="center" valign="middle" class="headercolor">
							<div align="center">
								����
							</div>
						</td>
						<td align="center" valign="middle" class="headercolor">
							<div align="center">
								��ע
							</div>
						</td>
					</tr>
					<pg:notify>
						<tr height="33px" class="labeltable_middle_tr_01">
							<td colspan=9 align='center'>
								��ʱû����Ϣ
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
							&nbsp;&nbsp;ÿҳ 15 ��&nbsp;&nbsp;��
							<font style="color: red; font-size: 12px"><pg:rowcount />
							</font>��
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
