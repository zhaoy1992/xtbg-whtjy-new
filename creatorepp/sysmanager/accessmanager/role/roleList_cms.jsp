<%
	/**
	 * ѡ���ɫ
	 * add by xinwang.jiao 2007.4.23
	 */
%>
<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%//http://localhost:8081/creatorcms/sysmanager/accessmanager/role/roleList_cms.jsp
	
	
%>
<html>
	<head>
		<title>ѡ���ɫ</title>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
<script src="<%=request.getContextPath()%>/cms/inc/js/func.js"></script>		
<script language="JavaScript" src="common.js" type="text/javascript"></script>
<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">	
function queryUser()
{	
	userList.action="roleList_cms.jsp"
	userList.submit();	
}
function chooseRole()
{
	//��ѡ�е��ĵ�idƴ���ַ���
	var all = document.getElementsByName("ID");
	var roleid = "";
	var rolename = "";
	for(var i=0;i<all.length;i++){
		if(all[i].checked == true){
			roleid = roleid + all[i].value + ",";
			rolename = rolename + document.getElementsByName(all[i].value)[0].innerText + ",";
		}
	}
	if(haveSelect('ID')){
		window.opener.document.all.item("rolename").value = rolename;
		window.opener.document.all.item("roleids").value = roleid;
		window.close();
	}else{
		alert("��ѡ���ɫ��");
	}
}
</SCRIPT>		
			<%@ include file="/epp/css/cssControl.jsp"%><body >
				<form name="userList" method="post" >
					<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=98% class="thin">
         				<tr valign='top'>
           					<td height='30'valign='middle' colspan="5"><img src='../../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>��ɫ�б�</strong></td>
         				</tr>
         				<!--<tr >
           					
           					<td colspan="2" height='30' valign='middle' align="left">��ɫ���ƣ�<input type="text" name="roleName" ></td>
           					
           					<td height='30' valign='middle' align="center">
           						<input name="search" type="button" class="input" value="��ѯ" onClick="queryUser()">           						
           				
           					</td>
         				</tr>-->
						<pg:listdata dataInfo="RoleSearchList" keyName="RoleSearchList" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager maxPageItems="12" scope="request" data="RoleSearchList" isList="false">
							<tr>
								<!--���÷�ҳ��ͷ-->
								<td height='30' align=center style="width:5%">
								<input class="checkbox" type="checkBox" hidefocus=true name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">
								</td>
								<td height='30' class="headercolor">��ɫ����</td>
								<td height='30' class="headercolor">��ɫ����</td>
								
								
							</tr>
							<pg:param name="roleId" />
							<pg:param name="roleName" />
							

							<!--��⵱ǰҳ���Ƿ��м�¼-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=100 align='center'>
										��ʱû�н�ɫ
									</td>
								</tr>
							</pg:notify>

							<!--list��ǩѭ�����ÿ����¼-->
							<pg:list>
								
								<tr >
									<td class="tablecells" align=center height='30'>
									  <input class="checkbox" hideFocus onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" value="<pg:cell colName="roleId" defaultValue=""/>">							
									</td>
									<td id="<pg:cell colName="roleId" defaultValue=""/>" height='25' class="tablecells" nowrap="nowrap">
										<pg:cell colName="roleName" defaultValue="" />
									</td>
									<td height='25' class="tablecells" nowrap="nowrap">
										<pg:cell colName="roleDesc" defaultValue="" />
									</td>									
									
								</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=4 align='center'>
									
									<pg:index />
									<input name="search" type="button" class="input" value="ȷ��" onClick="chooseRole()">
									<input name="search" type="button" class="input" value="����" onClick="window.close();">
								</td>
								
							</tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>

				  </table>
				</form>
		</body>
		<center>
</html>
