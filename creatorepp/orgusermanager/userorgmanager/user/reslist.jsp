<%
/**
 * 
 * <p>Title: �û��Զ�����Դ</p>
 *
 * <p>Description: �û��Զ�����Դ�����������</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkManagerAccess(request,response);
	String reFlush = "false";
	if (request.getAttribute("reFlush") != null) {
		reFlush = "true";
	}
	String restype = (String)request.getParameter("restypeId");
	String restypeName = request.getParameter("restypeName");
	String parent_resId = request.getParameter("parent_resId");
%>
<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
				

<script language="JavaScript" src="../../scripts/common.js" type="text/javascript"></script>
<script language="JavaScript" src="../../../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">	
var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");

//ģ̬����
function openWin(url,swidth,sheight){
	var w = showModalDialog(url,window,"dialogWidth:"+swidth+"px;dialogHeight:"+sheight+"px;help:no;scroll:auto;status:no");
	return w;
}

</SCRIPT>		
			<meta http-equiv="Content-Type" content="text/html; charset=GBK"><%@ include file="/epp/css/cssControl.jsp"%><body >
			
				<form name="ResSearchList" method="post" >
				<input type="hidden" name="resTypeName" value="<%=restypeName%>"/>
				<input type="hidden" name="restypeId" value="<%=restype%>"/>
					 <table width=100% border="0" cellpadding="0" cellspacing="1" class="thin">
         				<tr valign='top'>
           					<td height='30'valign='middle' colspan="4"><img src='../../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>��Դ�б�</strong></td>
         				</tr>
         			<pg:listdata dataInfo="ResSearchList" keyName="ResSearchList" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager maxPageItems="15" scope="request" data="ResSearchList" isList="false">
							<tr>
								<!--���÷�ҳ��ͷ-->
								<td width="25%" class="headercolor">��Դ����</td>
								<td width="25%" class="headercolor">��Դ����</td>
								<td width="35%" class="headercolor">������Ϣ</td>
								<td width="15%" class="headercolor">Ȩ������</td>
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
								<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'"
								>
									<input type="hidden" name="checkBoxOne" onClick="checkOne('checkBoxAll','checkBoxOne')" value="<pg:cell colName="resId" defaultValue=""/>" width="10">
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="restypeName" defaultValue="" />
									</td>
									
									
									<td class="tablecells" nowrap="nowrap">
									<input type="hidden" name="title" value="<pg:cell colName="title" defaultValue="" />"/>
										<pg:cell colName="title" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="path" defaultValue="��ʱΪ��" />
									</td>
									<td class="tablecells" nowrap="nowrap" onclick="openWin('operList_res.jsp?resId2=<pg:cell colName="title" defaultValue="" />&resTypeId2=<%=restype%>&resTypeName=<pg:cell colName="title" defaultValue="" />&title=<pg:cell colName="title" defaultValue="" />&username=<%=restype%>',600,500)">
										<img src="../../images/new_doc.gif"/>
									</td>
								</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=4 align='center'>
									��<pg:rowcount/>����¼ <pg:index />					
								</td>
						</tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>

				  </table>
				</form>
		
</body>
<center>
</html>
