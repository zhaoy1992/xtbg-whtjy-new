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
	String parent_resId = request.getParameter("parent_resId");
	String parent_resName = request.getParameter("parent_resName");
	
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
    		outMsg = "��ȷ��Ҫɾ����(�������Դ��һ��ɾ��)";
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
function getRes(resId,restypeId){
	
	getPropertiesContent().location.href="<%=rootpath%>/resmanager/resource.do?method=getResInfo&resId="+resId + "&parent_resId=<%=parent_resId%>&parent_resName=<%=parent_resName%>&restypeName=<%=restypeName%>&restypeId="+restypeId;		
	
}
function newRes(){
	
	window.location.href="<%=rootpath%>/sysmanager/resmanager/newsubres.jsp?restype=<%=restype%>&restypeName=<%=restypeName%>&parent_resId=<%=parent_resId%>&parent_resName=<%=parent_resName%>";	
}

function getResDetail(e,resId,resTypeId,resTypeName,title)
{
	if (jsAccessControl.setBackColor(e)){
		getPropertiesToolbar().location.href="resource_toolbar.jsp?resId2="+resId+"&resTypeId2="+resTypeId+"&restypeName="+resTypeName+"&title="+title;
	}
}


</SCRIPT>		
			<meta http-equiv="Content-Type" content="text/html; charset=GBK"><%@ include file="/epp/css/cssControl.jsp"%><body >
			
				<form name="ResSearchList" method="post" >
					 <table width=98% border="0" cellpadding="0" cellspacing="1" class="thin">
         				<tr valign='top'>
           					<td height='30'valign='middle' colspan="4"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>��Դ�б�</strong></td>
         				</tr>
         			
						<pg:listdata dataInfo="ResParentList" keyName="ResParentList" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager maxPageItems="17" scope="request" data="ResParentList" isList="false">
							<tr>
								<!--���÷�ҳ��ͷ-->
								<td class="headercolor" width="10">
									<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','checkBoxOne')" width="10">
								</td>
								<td class="headercolor">��Դ����</td>
								<td class="headercolor">��Դ����</td>
								<td class="headercolor">������Ϣ</td>
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
								<tr onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" onclick="getResDetail(this,'<pg:cell colName="resId" defaultValue=""/>','<pg:cell colName="restypeId" defaultValue=""/>','<pg:cell colName="restypeName" defaultValue="" />','<pg:cell colName="title" defaultValue="" />')" onDBLclick="getRes('<pg:cell colName='resId' defaultValue=''/>','<pg:cell colName='restypeId' defaultValue=''/>')" >
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
