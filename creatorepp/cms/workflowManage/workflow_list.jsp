<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="../../WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<title>�����б�</title>
<script src="../inc/js/func.js"></script>
<script type="text/javascript" src="../../public/datetime/calender_date.js" language="javascript"></script>
<script language="javascript" >
function checkAll(totalCheck,checkName){//��ѡ��ȫ��ѡ��
	var selectAll = document.getElementsByName(totalCheck);
	var o = document.getElementsByName(checkName);
	if(selectAll[0].checked==true){
		for (var i=0; i<o.length; i++){
			if(!o[i].disabled){
				o[i].checked=true;
			}
		}
	}else{
		for (var i=0; i<o.length; i++){
			o[i].checked=false;
		}
	}
}

function checkOne(totalCheck,checkName,id){//����ѡ�и�ѡ��
	var selectAll = document.getElementsByName(totalCheck);
	var o = document.getElementsByName(checkName);
	var cbs = true;
	for (var i=0;i<o.length;i++){
		if(!o[i].disabled){
			if (o[i].checked==false){
				cbs=false;
			}
		}
	}
	if(cbs){
		selectAll[0].checked=true;
	}else{
		selectAll[0].checked=false;
	}
}

function newWorkflow(){
	openWin("workflow_add.jsp",400,320);
}

function updateWorkflow(){
	var docId = document.getElementsByName("checkBoxOne");
	if(docId.length){
		var count = 0 ;
		var index = -1;
		for(var i = 0; i < docId.length; i ++){
			if(!docId[i].checked){
				continue;
			}else{				
				count ++;
				index = i;
			}
		}
		if(count == 0){
			alert("��ѡ��һ����¼�����޸ģ�");
			return;
		}else if(count == 1){
			openWin("workflow_update.jsp?workflowId=" + docId[index].value,400,320);
		}else{
			alert("��ѡ������¼�����޸ģ�");
			return;
		}
	}
}

function updateNode(){
	var docId = document.getElementsByName("checkBoxOne");
	if(docId.length){
		var count = 0 ;
		var index = -1;
		for(var i = 0; i < docId.length; i ++){
			if(!docId[i].checked){
				continue;
			}else{				
				count ++;
				index = i;
			}
		}
		if(count == 0){
			alert("��ѡ��һ����¼�����޸ģ�");
			return;
		}else if(count == 1){
			openWin("workflow_nodeadd.jsp?workflowId=" + docId[index].value,600,480);
		}else{
			alert("��ѡ������¼�����޸ģ�");
			return;
		}
	}
}

function delWorkflow(){
	var isSelect = false;
	var outMsg;
	    
    for (var i=0;i<workflowform.elements.length;i++) {
		var e = workflowform.elements[i];
		if (e.name == 'checkBoxOne'){
			if (e.checked){
	       		isSelect=true;
	       		break;
		    }
		}
    }
    if (isSelect){
		outMsg = "��ȷ��Ҫɾ����(ɾ�����ǲ������ٻָ���)��";
    	if (confirm(outMsg)){
			workflowform.target = "delworkflowiframe"
    		workflowform.action = "workflow_del_do.jsp"
			workflowform.submit();
		}
		return true;
    }else{
    	alert("����ѡ��һ��¼����ɾ����");
	    return false;
    }
	return false;
}
</script>
<style type="text/css">
<!--
body {
	background-color: #ffffff;
}
.STYLE1 {color: #0000FF}
.STYLE2 {color: #000099}
-->
</style></head>

<body topmargin="3" rightmargin="0">
<form id="workflowform" name="workflowform" method="post" action="">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td style="background:url(../images/querybox_bg.gif) repeat-x top">
			<table width="100%" height="100%" border="0" cellpadding="0" align="center" cellspacing="0" class="query_box">
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp; ��ǰλ�ã����̹���&nbsp;>>&nbsp;�����б�</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="1" align="center" class="Datalisttable">
				<tr>
					<td height='25' colspan="9" background="<%=request.getContextPath()%>/cms/images/data_list_tHeadbg.jpg" style="text-align:left; background:url(<%=request.getContextPath()%>/cms/images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
						<a style="cursor:hand" onClick="newWorkflow()">
						<div class="DocumentOper">����</div></a>
						<a style="cursor:hand" onClick="updateWorkflow()">
						<div class="DocumentOper">�޸�����</div></a>
						<a style="cursor:hand" onClick="updateNode()">
						<div class="DocumentOper">�޸Ľڵ�</div></a>
						<a style="cursor:hand" onClick="delWorkflow()">
						<div class="DocumentOper">ɾ��</div></a>
					</td>
				</tr>
 				<pg:listdata dataInfo="WorkflowList" keyName="WorkflowList" />
				<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
				<pg:pager maxPageItems="10" scope="request" data="WorkflowList" isList="true">
				<tr class="cms_report_tr">
					<!--���÷�ҳ��ͷ-->
					<td width="5%" align="center" height='30'>
						<P align="left">
							<input type="checkbox" class="checkbox" hideFocus name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')">
						</P>
					</td>
					<td width="*" align="center">��������</td>
				</tr>
				<pg:param name="srcName" />
				<!--��⵱ǰҳ���Ƿ��м�¼-->
				<pg:notify>
				<tr height="18px" class="labeltable_middle_tr_01">
					<td colspan=100 align='center'>
						��ʱû������
					</td>
				</tr>
				</pg:notify>
				<!--list��ǩѭ�����ÿ����¼-->
				<pg:list>
				<tr>
					<td class="tablecells" nowrap="true" height='30'>
					<P align="left">
						<INPUT type="checkbox" class="checkbox" hideFocus name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne','<pg:cell colName="workflowId" defaultValue=""/>')" value='<pg:cell colName="workflowId" defaultValue=""/>' >
					</P>
					</td>
					<td class="tablecells" nowrap="nowrap" width="*" height='30'>
						<pg:cell colName="workflowName" defaultValue="" />
					</td>
				</tr>
				</pg:list>
				<tr class="labeltable_middle_tr_01">
					<td colspan=10 >
						<div class="Data_List_Table_Bottom">��<pg:rowcount />����¼
						<pg:index /></div>
					</td>
				</tr>
					<input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">
				</pg:pager>
			</table>
 		</td>
	</tr>
</table>
</form>
<iframe name="delworkflowiframe" width="0" height="0" style="display:none"></iframe>
</body>
</html>
