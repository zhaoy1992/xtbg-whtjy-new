<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	String reFlush = "false";
	if (request.getAttribute("reFlush") != null) {
		reFlush = "true";
	}
//	String currUserId = (String)session.getAttribute("currUserId");
//	String desc = (String)request.getParameter("pager.desc");
//	String curOrgId = (String)request.getParameter("orgId");
	String restype=(String)request.getParameter("restypeId");
	String restypeName=request.getParameter("restypeName");

%>
<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">

<script language="JavaScript" src="common.js" type="text/javascript"></script>
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">
var jsAccessControl = new JSAccessControl("#ff0000","#ffffff","#eeeeee");
function dealRecord(dealType) {
    var isSelect = false;
    var outMsg;

    for (var i=0;i<ResSearchList.elements.length;i++) {
		var e = ResSearchList.elements[i];

		if (e.name == 'checkBoxOne'){
			if (e.checked){
	       		isSelect=true;
	       		break;
		    }
		}
    }
    if (isSelect){
    	if (dealType==1){
    		outMsg = "��ȷ��Ҫɾ����(ɾ�����ǲ������ٻָ���)��";
        	if (confirm(outMsg)){
				ResSearchList.action="<%=rootpath%>/resmanager/resource.do?method=deleteres";
				ResSearchList.submit();
	 			return true;
			}
		}
    }else{
    	alert("����Ҫѡ��һ����¼��");
    	return false;
    }
	return false;
}
function getRes(resId){
	ResSearchList.action="<%=rootpath%>/resmanager/resource.do?method=getResInfo&resId="+resId;getPropertiesContent().location.href="<%=rootpath%>/resmanager/resource.do?method=getResInfo&resId="+resId;
	ResSearchList.submit();
}
function newRes(){
	//window.location.href="<%=rootpath%>/resmanager/resource.do?method=newresource&resId=<%=restype%>&restypeName=<%=restypeName%>";

	window.location.href="<%=rootpath%>/sysmanager/resmanager/newres.jsp?restype=<%=restype%>&restypeName=<%=restypeName%>";
}

function getResDetail(e,resId,resTypeId,resTypeName,title)
{
	if (jsAccessControl.setBackColor(e)){
		getPropertiesToolbar().location.href="properties_toolbar.jsp?resId2="+resId+"&resTypeId2="+resTypeId+"&resTypeName="+resTypeName+"&title="+title;
	}
}


</SCRIPT>
			<%@ include file="/epp/css/cssControl.jsp"%><body >

				<form name="ResSearchList" method="post" >
					 <table cellspacing="0" cellpadding="0" border="1" bordercolor="#EEEEEE" width=98% >
         				<tr valign='top'>
           					<td height='30'valign='middle' colspan="4"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>��Դ�б�</strong></td>
         				</tr>
         			<!--<tr >
           					<td height='30'valign='middle'></td>
           					<td height='30'valign='middle' align="center">��Դ���ͣ�<input type="text" name="restypeId" ></td>
           					<td height='30'valign='middle' align="center">��Դ���ƣ�<input type="text" name="title" ></td>
           					<td height='30'valign='middle' align="center">
           						<input name="search" type="button" class="input" value="��ѯ" onClick="queryUser()">
           						<input name="newuser" type="button" class="input" value="����" onClick="newRes()">
           					</td>
         				</tr>-->
						<pg:listdata dataInfo="ResTypeList" keyName="ResTypeList" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager maxPageItems="17" scope="request" data="ResSearchList" isList="false">
							<tr>
								<!--���÷�ҳ��ͷ-->
								<th class="headercolor" width="10">
									<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','checkBoxOne')" width="10">
								</th>
								<th class="headercolor">��Դ����</th>
								<th class="headercolor">��Դ����</th>

							</tr>
							<pg:param name="restypeId" />
							<pg:param name="title" />
							<pg:param name="path" />

							<!--��⵱ǰҳ���Ƿ��м�¼-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=100 align='center'>
										��ʱû����Դ��
									</td>
								</tr>
							</pg:notify>

							<!--list��ǩѭ�����ÿ����¼-->
							<pg:list>
								<tr onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" onclick="getResDetail(this,'<pg:cell colName="resId" defaultValue=""/>','<pg:cell colName="restypeId" defaultValue=""/>','<pg:cell colName="restypeName" defaultValue="" />','<pg:cell colName="title" defaultValue="" />')" onDBLclick="getRes('<pg:cell colName='resId' defaultValue=''/>')" >
									<td class="tablecells" nowrap="nowrap">
										<input type="checkBox" name="checkBoxOne" onClick="checkOne('checkBoxAll','checkBoxOne')" value="<pg:cell colName="resId" defaultValue=""/>" width="10">
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="restypeName" defaultValue="" />
									</td>


									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="title" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="path" defaultValue="" />
									</td>
								</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=4 align='center'>
									<pg:index /><input type="submit" value="ɾ��" class="input" onclick="javascript:dealRecord(1); return false;">
									<input name="newuser" type="button" class="input" value="����" onClick="newRes()">

								</td>
								</tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>

					</table>
				</form>
		<%@include file="../sysMsg.jsp" %>
</body>
<center>
</html>
