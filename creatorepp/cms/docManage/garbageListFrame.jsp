<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ page import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.documentmanager.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
	request.setAttribute("userId",userId);
	
	com.chinacreator.cms.CMSManager cmsManager  = new com.chinacreator.cms.CMSManager();
 	cmsManager.init(request,session,response,accesscontroler);
 	String currentSiteid = cmsManager.getSiteID();
 	request.setAttribute("currentSiteid",currentSiteid);
	
	String preStatus = request.getParameter("preStatus");
	String channelId = request.getParameter("channelId");
	String flowId = request.getParameter("flowId");
	String title = request.getParameter("title");
	String flag = request.getParameter("flag");
	String garbager = request.getParameter("garbager");
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
		<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
		<title>�鵵�ĵ��б�</title>
		<script src="../inc/js/func.js"></script>
		<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
		<script language="javascript">
		function del(){
			//��ѡ�е��ĵ�idƴ���ַ���
			var all = document.getElementsByName("ID");
			var docidStr="";
			for(var i=0;i<all.length;i++){
				if(all[i].checked == true){
					var tempValue = all[i].value.split(":");
					docidStr = docidStr + tempValue[2] + ";";
				}
			}
			if(haveSelect('ID')){
			    if(confirm('��ȷ��Ҫɾ����ѡ���ĵ���')){
				garbageForm.action="document_del_submit.jsp?siteId=<%=currentSiteid%>&docidStr=" + docidStr;
		        garbageForm.target="garbageFrame";
				garbageForm.submit();
				}else
				{
				return false;
				}
			}else{
		    	alert("��ѡ��Ҫ��ɾ�����ĵ���");
		    	return false;
		   	}
		}
		function recover(){
			//��ѡ�е��ĵ�idƴ���ַ���
			var all = document.getElementsByName("ID");
			var docidStr="";
			for(var i=0;i<all.length;i++){
				if(all[i].checked == true){
					var tempValue = all[i].value;
					docidStr = docidStr + tempValue + ";";
				}
			}
			if(haveSelect('ID')){
				//garbageForm.action="garbageRecoverHandle.jsp?docidStr="+docidStr;
				//garbageForm.target="garbageFrame";
				//garbageForm.submit();
				//return true;
				var urls = "docManage/garbageRecoverHandle.jsp?docidStr="+docidStr;
				window.urlstr = urls;
				showModalDialog("../doing_iframe.html",window,"dialogWidth:"+(screen.availWidth-10)+"px;dialogHeight:"+(screen.availHeight-20)+"px;help:no;scroll:auto;status:no");
			}else{
		    	alert("������Ҫѡ��һƪ�ĵ���");
		    	return false;
		   	}
		}
		</script>
		<style type="text/css">
		body {
			background-color: #ffffff;
		}
		.STYLE1 {color: #0000FF}
		.STYLE2 {color: #000099}
		.style3 {
			font-size: 14px;
			font-weight: bold;
			color: #3300FF;
		}
	</style>
	</head>

	<body topmargin="1" rightmargin="1" scroll=no leftmargin="1">
		<form name="garbageForm" action="" method="post">
			<table width="100%" border="1"  cellpadding="3" cellspacing="0" bordercolor="#B7CBE4" class="Datalisttable">
				<tr>
					<td height='25' colspan="9" background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7"><div class="DocumentOperT">�ĵ�������</div>
						<a style="cursor:hand" onClick="recover()" ><div class="DocumentOper"><img class="operStyle" src="../images/trash_small.gif">�ָ�</div></a> 
						<%if(accesscontroler.checkPermission(currentSiteid,AccessControl.DELETE_PERMISSION,AccessControl.SITEDOC_RESOURCE)){%>
						<a style="cursor:hand" onClick="del()"><div class="DocumentOper"><img class="operStyle"
							 src="../images/del.gif">ɾ��</div></a>	
						<%}%>				
					</td>
				</tr>
				<pg:listdata dataInfo="GarbageDocList" keyName="GarbageDocList" />
				<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
				<pg:pager maxPageItems="10" scope="request" data="GarbageDocList" isList="false">
					<tr class="cms_report_tr">
						<!--���÷�ҳ��ͷ-->
						<td width="5%" height='30' align=center style="width:3%">
							<input class="checkbox" type="checkBox" hideFocus=true name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">					  </td>
						<td width="8%" height='30'>�ĵ�����</td>
						<td width="30%" height='30'>�ĵ�����</td>
						<td width="8%" height='30'>����Ƶ��</td>
						<td width="5%" height='30'>ǰ״̬</td>
						<td width="8%" height='30'>������</td>
						<td width="10%" height='30'>����</td>
						<td width="8%" height='30'>������</td>
						<td width="18%" height='30'>��������</td>
					</tr>
				
					<pg:param name="preStatus" />
					<pg:param name="channelId" />
					<pg:param name="flag" />
					<pg:param name="title" />
					<pg:param name="flowId" />
					<pg:param name="garbager" />
					
					<!--��⵱ǰҳ���Ƿ��м�¼-->
					<pg:notify>
						<tr  class="labeltable_middle_tr_01">
							<td colspan=100 align='center' height="18px">
								��ʱû�л����ĵ�
							</td>
						</tr>
					</pg:notify>

					<!--list��ǩѭ�����ÿ����¼-->
					<pg:list>
						<tr class="cms_data_tr" id="<pg:cell colName="document_id" defaultValue=""/>" onMouseOver="high(this)" onMouseOut="unhigh(this)">
							<td class="tablecells" height='25'>
								<input class="checkbox" hideFocus onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" value="<pg:cell colName="siteid" defaultValue=""/>:<pg:cell colName="chanel_id" defaultValue=""/>:<pg:cell colName="document_id" defaultValue=""/>">							</td>

							<td class="tablecells" height='25'>
								<pg:equal colName="doctype" value="0">
									<div align="center">
										<img title="HTML�ĵ�" src="../images/doc_html.gif" width="20" height="20">
									</div>
								</pg:equal>
								<pg:equal colName="doctype" value="1">
									<div align="center">
										<img title="�ⲿ���������ĵ�" src="../images/doc_link.gif" width="20" height="20">
									</div>
								</pg:equal>
								<pg:equal colName="doctype" value="2">
									<div align="center">
										<img title="�����ļ�����" src="../images/doc_downloadfile.gif" width="15" height="16">
									</div>
								</pg:equal>
								<pg:equal colName="doctype" value="3">
									<div align="center">
										<img title="�ۺ��ļ�����" src="../images/doc_aggr.gif" width="15" height="16">
									</div>
								</pg:equal>
							</td>
							
							<td  class="tablecells" height="25" style="cursor:hand" 
									
									onClick="viewDoc(<pg:cell colName="document_id" defaultValue=""/>
							,garbageForm,'garbageFrame')" >
								<pg:cell colName="subtitle" defaultValue="" />
							</td>
							<td class="tablecells" nowrap="nowrap">
								<pg:cell colName="channelName" defaultValue="" />
							</td>
							<td class="tablecells" nowrap="nowrap">
								<pg:cell colName="statusname" defaultValue="" />
							</td>
							<td class="tablecells" nowrap="nowrap">
								<pg:cell colName="username" defaultValue="" />
							</td>
							<td class="tablecells" nowrap="nowrap">
								<pg:cell colName="flowName" defaultValue="" />
							</td>
							<td class="tablecells" nowrap="nowrap">
								<pg:cell colName="recyclePerfomer" defaultValue="" />
							</td>
							<td class="tablecells" nowrap="nowrap">
								<pg:cell colName="recycleTime" dateformat="yyyy/MM/dd HH:mm:ss" defaultValue="" />
							</td>
						</tr>
					</pg:list>
					<tr class="labeltable_middle_tr_01">
						<td colspan=10><div class="Data_List_Table_Bottom">
							��
							<pg:rowcount />
							����¼
							<pg:index /></div></td>
					</tr>
					<input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">
					<tr></tr>
				</pg:pager>
		  </table>
		</form>
		<div heigth="0" width="0" style="display:none">
		  	<iframe name="garbageFrame"><iframe/>
		</div>
	</body>
</html>


