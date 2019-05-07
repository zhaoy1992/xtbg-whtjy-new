<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<% 
	//��־ID
	String logId = request.getParameter("logId");
	
	String operTable = request.getParameter("operTable")==null?"":request.getParameter("operTable");
	String detailContent = request.getParameter("detailContent")==null?"":request.getParameter("detailContent");
%>
<html>
	<head>
		<title>��־��ϸ��ѯ</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<base target="_self"/>
	<script type="text/javascript">
		function resetwindow()
		{
			document.detailForm.action = window.location.href;	
			document.detailForm.target = "";
			
			document.detailForm.submit();
			
		}
		
		function queryDetail(){
			document.detailForm.target = "hiddenIframe";
			document.detailForm.action = "logDetailList.jsp";
			resetwindow();
		}
		
		function resetValue(){
			document.all.operTable.value = "";
			document.all.detailContent.value = "";
		}
	</script>
	</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >

<form name="detailForm" method="post" />
<table class="thin"  width="100%" border="0" cellpadding="0" cellspacing="1" >
<caption>��־��ϸ��ѯ</caption>
<br/>
<tr>
<td align="center" width="15%">��־�����ı�</td>
<td align="center"><input name="operTable" type="text" value="<%=operTable %>" style="width:100%"/></td>
</tr>
<tr>
<td align="center" width="15%">������¼���ݣ�</td>
<td align="center"><input name="detailContent" type="text" value="<%=detailContent %>" style="width:100%"/></td>
</tr>
<tr>
<td></td>
<td align="right">
	<input type="button" value="��ѯ" onclick="queryDetail()" class="input"/>
	<input type="button" value="����" onclick="resetValue()" class="input"/> 
	<input type="button" value="�ر�ҳ��" onclick="window.close();" class="input"/> 
</td>
</tr>
</table>
<table class="thin" width="100%" border="0" cellpadding="0" cellspacing="1" >
	<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.LogDetailSearchList" keyName="LogDetailSearchList" />
		<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="12" scope="request" data="LogDetailSearchList" isList="false">
		<tr class="labeltable_middle_td">
			<td height='20' class="headercolor">��־�����ı�</td>
			<td height='20' class="headercolor">�����������IDֵ</td>
			<td height='20' class="headercolor">������¼����</td>
			<td height='20' class="headercolor">��������</td>
		</tr>
		<pg:param name="operTable"/>
		<pg:param name="detailContent"/>
		<pg:param name="logId"/>
		
		<!--��⵱ǰҳ���Ƿ��м�¼-->
		<pg:notify>
			<tr height='25' class="labeltable_middle_tr_01">
				<td colspan="100" align='center'>
					û����־��ϸ��¼
				</td>
			</tr>
		</pg:notify>
		<pg:list>
			<tr onMouseOver="this.className='mouseover'" onMouseOut="this.className= 'mouseout'">
				<td  height='20' align="left" class="tablecells"><pg:cell colName="operTable" defaultValue="" /></td>
				<td  height='20' align="left" class="tablecells"><pg:cell colName="operKeyID" defaultValue="" /></td>
				<td  height='20' align="left" class="tablecells"><pg:cell colName="detailContent" defaultValue="" /></td>
				<td  height='20' align="left" class="tablecells">
				<pg:equal colName="operType" value="0">�޲���</pg:equal>
				<pg:equal colName="operType" value="1">����</pg:equal>
				<pg:equal colName="operType" value="2">ɾ��</pg:equal>
				<pg:equal colName="operType" value="3">�޸�</pg:equal>
				<pg:equal colName="operType" value="4">����</pg:equal>	
				</td>
			</tr>
		</pg:list>
		<tr height="30" class="labeltable_middle_tr_01">
			<td colspan=100 align='center'>
			  ÿҳ12��&nbsp;&nbsp;��<pg:rowcount/>����¼&nbsp;&nbsp;<pg:index />
			<input type="hidden" name="querystring" value="<pg:querystring/>"></td>
		</tr>
	</pg:pager>
</table>
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>