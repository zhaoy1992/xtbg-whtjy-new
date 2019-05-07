<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ include file="../../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager" %>
<%@page import="com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.web.struts.form.*"%>
<%@ page import="com.chinacreator.security.*"%>
<%@page import="com.chinacreator.resource.ResourceManager" %>
<%@page import="com.chinacreator.config.ResourceInfoQueue" %>
<%@page import="com.chinacreator.config.model.ResourceInfo" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>


<tab:tabConfig />
<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
<script language="JavaScript" src="../common.js" type="text/javascript"></script>
<script language="javascript" src="../../../sysmanager/scripts/selectTime.js"></script>
<SCRIPT language="JavaScript" SRC="validateForm.js"></SCRIPT>
		
<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/tab.winclassic.css">
<style type="text/css">
	.notice_STYLE{color: #FF0000;display : none }
    .STYLE1 {color: #FF0000}
</style>
<%@ include file="/epp/css/cssControl.jsp"%>
<table class="thin" cellspacing="1" cellpadding="0" width="100%">

<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.UserSelfResList" keyName="UserSelfResList" />
<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
<pg:pager maxPageItems="13" id="UserSelfResList" scope="request" data="UserSelfResList" isList="false">
	<tr>
    <!--���÷�ҳ��ͷ-->
    	<td colspan=2 class="headercolor">��Դ��������</td>	
		<td class="headercolor">��Դ����</td>
		<td class="headercolor" height='30'>����ID</td>
									
	</tr>
	<pg:param name="userId" />
	<pg:param name="restype1" />
	<pg:param name="resname1" />
	<!--��⵱ǰҳ���Ƿ��м�¼-->
	<pg:notify>
		<tr height="18px" class="labeltable_middle_tr_01">
			<td colspan=100 align='center'>
				û���û�����Ȩ��
			</td>
		</tr>
	</pg:notify>
	<!--list��ǩѭ�����ÿ����¼-->
	<pg:list>								
		<tr onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" onclick="" >
			<td colspan=2 class="tablecells" nowrap="nowrap">
				<pg:cell colName="resTypeName" defaultValue="δ֪" />
			</td>
			<td class="tablecells" nowrap="nowrap">
				<pg:cell colName="resName" defaultValue="" />
			</td>	
			<td class="tablecells" nowrap="nowrap" height='20'>
				<pg:cell colName="opName" defaultValue="" />
			</td>
		</tr>
	</pg:list>
		<tr height="18px" class="labeltable_middle_tr_01">
			<td colspan=4 align='center'>
				<pg:index />
			</td>						
		</tr>
		<input name="queryString" value="<pg:querystring/>" type="hidden">
</pg:pager>

</table>