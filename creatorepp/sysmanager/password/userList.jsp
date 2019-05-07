<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.cms.customform.*"%>
<%@ page import="com.chinacreator.config.model.AuthorTableInfo,
	com.chinacreator.security.AccessControl,
	com.chinacreator.security.authorization.AuthRole,
	com.chinacreator.sysmgrcore.authorization.AppAuthorizationTable,
	com.frameworkset.common.poolman.DBUtil,
	com.chinacreator.config.ConfigManager"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>

<%			
			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);
			String uId = accesscontroler.getUserID();
			ResourceManager resManager = new ResourceManager();
			String resId = resManager
					.getGlobalResourceid(AccessControl.ORGUNIT_RESOURCE);
			String curOrgId = request.getParameter("orgId");
			if (curOrgId == null)
				curOrgId = (String) request.getAttribute("orgId");
			String reFlush = "false";
			if (request.getAttribute("reFlush") != null) {
				reFlush = "true";
			}

			Integer currUserId = (Integer) session.getAttribute("currUserId");
			if (currUserId == null) {
				currUserId = Integer.valueOf("-1");
			}
			//String curOrgId = (String)session.getAttribute("orgId");
			String desc = (String) request.getParameter("pager.desc");
			String intervalType = (String) request.getParameter("intervalType");
			String taxmanager = (String) request.getParameter("taxmanager");
			String ischecked = "";
			if ((String) request.getAttribute("ischecked") == null) {
				ischecked = "";
			} else {
				ischecked = (String) request.getAttribute("ischecked");
			}

			String QueryuserName = null;
			String QueryuserRealname = null;
			if (request.getParameter("userName") == null) {
				QueryuserName = "";
			} else {
				QueryuserName = request.getParameter("userName");
			}
			if (request.getParameter("userRealname") == null) {
				QueryuserRealname = "";
			} else {
				QueryuserRealname = request.getParameter("userRealname");
			}
%>
<html>
<head>
<title>��������</title>
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">

<script language="JavaScript" src="common.js" type="text/javascript"></script>
<script language="JavaScript" src="../include/pager.js"
	type="text/javascript"></script>
<SCRIPT language="javascript">


var tempObj = null;
function changeRowColor(obj) {
   if(obj.flag == "true")
   {
   		obj.flag = "false";
   		obj.style.removeAttribute("backgroundColor");  
	    obj.style.color = 'black';
	    tempObj = null;
	    return ;
   }
   else
   {
   		obj.flag = "true";
   		obj.style.background='#191970';   //�ѵ㵽����һ�б�ϣ������ɫ; 
   		obj.style.color = 'white';
   }
   if(tempObj!=null && tempObj.flag == "true"){
        tempObj.flag = "false";
        tempObj.style.removeAttribute("backgroundColor");  
	    tempObj.style.color = 'black';
   }
   tempObj = obj;
}
function dbClickChoose(obj){
	window.returnValue = obj.id;
	window.close();
}
function returnUserName(){
	var obj = null;
	var rows = document.all.table1.rows;
	for(var i=0;rows!=null && i<rows.length;i++){
		if(rows[i].flag == "true"){
			obj = rows[i];
			break;
		}
	}
	if(obj!=null){
		window.returnValue = obj.id;
		window.close();
	}else{
		alert("��ѡ��һ���û�!");
	}
}
function queryUser()
{
	var intervalType = document.all("intervalType").value;
	userList.action="userList.jsp?orgId=<%=curOrgId%>&intervalType="+intervalType;
	userList.submit();	
}
</SCRIPT>
<%@ include file="/epp/css/cssControl.jsp"%><body >
<form name="userList" target="userList" method="post"><input
	type="hidden" name="orgId" value="<%=curOrgId%>" />
		<table cellspacing="1" id="table2" cellpadding="0" border="0"
	bordercolor="#EEEEEE" width="100%" class="thin"><tr>
			<td height='30' valign='middle' align="left">�û����ƣ�</td>
			<td><input type="text" name="userName" value="" size="15"></td>
			<td>�û�ʵ����</td><td><input type="text" name="userRealname" value="" size="15"></td>
			<td>˰��Ա��</td><td>
			 <select name="taxmanager" class="select">
				<option value="2" selected>--��ѡ��--</option>
				<option value="1">˰��Ա</option>
				<option value="0">��˰��Ա</option>
			</select></td>
			<td><select name="intervalType" id="intervalType" class="select" onchange="">
				<option value="0">���ݹ������ѯ</option>
				<option value="1">�ݹ������ѯ</option>
			</select>
			</td>
			<td><input name="search" type="button" class="input"
				value="��ѯ" onClick="queryUser()"></td>
		</tr></table><br>
<table cellspacing="1" id="table1" cellpadding="0" border="0"
	bordercolor="#EEEEEE" width="100%" class="thin">
	<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.UserListSn"
		keyName="UserListSn" />
	<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
	<pg:pager maxPageItems="15" scope="request" data="UserListSn"
		isList="false">
		<tr>
			<!--���÷�ҳ��ͷ-->
			<td class="headercolor" width="10%">��¼��</td>
			<td class="headercolor" width="10%">�û�ʵ��</td>
			<td class="headercolor" width="15%">�Ƿ�˰��Ա</td>
			<td class="headercolor" width="10%">�û����</td>
			<td class="headercolor">��������</td>
			<td class="headercolor" width="20%">�����ַ</td>
		</tr>
		<pg:param name="orgId" />
		<pg:param name="userName" />
		<pg:param name="userRealname" />
		<pg:param name="intervalType" />
		<pg:param name="istaxmanager" />
		<!--��⵱ǰҳ���Ƿ��м�¼-->
		<pg:notify>
			<tr height="18px" class="labeltable_middle_tr_01">
				<td colspan=6 align='center'>��ʱû���û�</td>
			</tr>
		</pg:notify>
		<!--list��ǩѭ�����ÿ����¼-->
		<pg:list>
			<tr id="<pg:cell colName="userName" defaultValue="" />"
				onclick="changeRowColor(this);" ondblclick="dbClickChoose(this)" flag="false"
				onmouseover="this.className='mouseover'"
				onmouseout="this.className= 'mouseout'">
				<td class="tablecells" nowrap="nowrap"><pg:cell
					colName="userName" defaultValue="" /></td>
				<td class="tablecells" nowrap="nowrap"><pg:cell
					colName="userRealname" defaultValue="" /></td>
				<td><pg:equal colName="istaxmanager" value="1">˰��Ա</pg:equal> <pg:equal
					colName="istaxmanager" value="0">��˰��Ա</pg:equal> <pg:equal
					colName="istaxmanager" value="">��˰��Ա</pg:equal></td>
				<td class="tablecells" nowrap="nowrap"><dict:itemname
					type="userType" expression="{userType}" /></td>
				<td class="tablecells"><pg:cell colName="org_Name" defaultValue="" />
				</td>
				<td class="tablecells" nowrap="nowrap"><pg:notnull
					colName="userEmail">
					<pg:cell colName="userEmail" defaultValue=" " />
				</pg:notnull> <pg:null colName="userEmail">û������</pg:null> <pg:equal
					colName="userEmail" value="">û������</pg:equal></td>
			</tr>
		</pg:list>
			<!-- tr onmouseover="this.className='mouseover'"
				onmouseout="this.className= 'mouseout'">
				<td class="tablecells" nowrap="nowrap"><pg:cell
					colName="userRealname" defaultValue="" /></td>
				<td><pg:equal colName="istaxmanager" value="1">
					<font color="#0000FF">˰��Ա</font>
				</pg:equal> <pg:equal colName="istaxmanager" value="0">
					<font color="#0000FF">��˰��Ա</font>
				</pg:equal> <pg:equal colName="istaxmanager" value="">
					<font color="#0000FF">��˰��Ա</font>
				</pg:equal></td>
				<td class="tablecells" nowrap="nowrap"><font color="#0000FF"><dict:itemname
					type="userType" expression="{userType}" /></font></td>
				<td class="tablecells"><font color="#0000FF"><pg:cell
					colName="org_Name" defaultValue="" /></font></td>
				<td class="tablecells" nowrap="nowrap"><font color="#0000FF"> <pg:notnull
					colName="userEmail">
					<pg:cell colName="userEmail" defaultValue=" " />
				</pg:notnull> <pg:null colName="userEmail">û������</pg:null> <pg:equal
					colName="userEmail" value="">û������</pg:equal></font></td>
			</tr-->
		
		<input name="queryString" value="<pg:querystring/>" type="hidden">
		<tr height="18px" class="labeltable_middle_tr_01">
			<td colspan=6 align='center' nowrap>
				��<pg:rowcount/>����¼ <pg:index />
			</td>								 
		</tr>
	</pg:pager>
</table>
<table id="table3">
<tr><td align="right">
	<input type="button" name="but" value="ȷ��" class="input" onclick="returnUserName()">
</td></tr>
</table>
</form>
</body>
</html>
