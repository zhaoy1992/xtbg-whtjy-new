<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.*"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.cms.customform.*"%>
<%	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String curUserid = accesscontroler.getUserID();
	request.setAttribute("curUserid",curUserid);
	String flag = request.getParameter("flag");
	String docTitle = request.getParameter("docTitle");
	String submitter = request.getParameter("submitter");
	String docChannel = request.getParameter("docChannel");
	String subTime =  request.getParameter("subTime");
	
	//ȡƵ�����趨���Զ����
	CustomFormManager cfm = new CustomFormManagerImpl();
%>
<html>
<head>
	<title>
		�����ĵ��б�
	</title>
	<link  href="../inc/css/cms.css" rel="stylesheet" type="text/css"></link>
	<script language="javascript" src="../inc/js/func.js"></script>
	<script language="javascript" src=src="../../sysmanager/include/pager.js" type="text/javascript"></script>
	<script language="javascript">
		//function agree(idStr){
			//����auditFlagΪ��������0��ͬ�⣬1��ͬ��
		//	openWin("<%=rootpath%>/cms/docManage/audit_add_comment.jsp?idStr=" + idStr + "&auditFlag=1",400,550);
		//}
		function disagree(idStr){
			//var addComment = window.confirm("Ҫ������������");
			//if(addComment==false){
				//����auditFlagΪ��������0��ͬ�⣬1��ͬ��
			//	toAuditDocListForm.action = "<%=rootpath%>/cms/docManage/auditDocHandle.jsp?idStr=" + idStr + "&auditFlag=0";
			//	toAuditDocListForm.target = "agreeFrame";
			//	toAuditDocListForm.submit();
			//}
			//else{
				openWin("<%=rootpath%>/cms/docManage/audit_add_comment.jsp?idStr=" + idStr + "&auditFlag=0",400,550);
			//}		
		}
		function audit(taskidStr,docTpye,docid,docChannelName,docSiteid,docChannelid,updatepath){
			if(docTpye==0){
				openWin(updatepath+"?flag=audit&siteid=" + docSiteid + "&channelName=" + docChannelName + "&channelId=" + docChannelid + "&docid=" + docid + "&taskidStr=" + taskidStr,screen.availWidth-20,screen.availHeight-50);
			}else if(docTpye==1){
				openWin("doc_gather_links_update.jsp?flag=audit&siteid=" + docSiteid + "&channelName=" + docChannelName + "&channelId=" + docChannelid + "&docid=" + docid + "&taskidStr=" + taskidStr,screen.availWidth-20,screen.availHeight-50);
			}else if(docTpye==2){
				openWin("doc_gather_filedownload_update?flag=audit&siteid=" + docSiteid + "&channelName=" + docChannelName + "&channelId=" + docChannelid + "&docid=" + docid + "&taskidStr=" + taskidStr,screen.availWidth-20,screen.availHeight-50);
			}else if(docTpye==3){
				openWin("doc_gather_aggr_update.jsp?flag=audit&siteid=" + docSiteid + "&channelName=" + docChannelName + "&channelId=" + docChannelid + "&docid=" + docid + "&taskidStr=" + taskidStr,screen.availWidth-20,screen.availHeight-50);
			}
		}
		function subQuery(){
			toAuditDocListForm.action="<%=rootpath%>/cms/docManage/docAudit.jsp";
			toAuditDocListForm.submit();
		}
		function garbage(){
			//��ѡ�е��ĵ�idƴ���ַ���
			var all = document.getElementsByName("ID");
			var docidStr="";
			for(var i=0;i<all.length;i++){
				if(all[i].checked == true){
					docidStr = docidStr + all[i].value + ";";
				}
			}
			if(haveSelect('ID')){
				toAuditDocListForm.action = "docGarbageHandle.jsp?docidStr="+docidStr;
				toAuditDocListForm.target = "agreeFrame";
				toAuditDocListForm.submit();
				return true;
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
	</style>
</head>
<body topmargin="2" rightmargin="0" scroll=no leftmargin="1" righttmargin="1">
	<form name="toAuditDocListForm" action="" method="post" >
		<table width="100%" border="1"  cellpadding="3" cellspacing="0" bordercolor="#B7CBE4"  class="Datalisttable">
<!--		 	<tr>-->
<!--				<td height='30' colspan="9" nowrap align="left" valign='middle' class="cms_title_blue">-->
<!--					�ĵ�������-->
<!--					<a style="cursor:hand" onclick="garbage()"><u><img -->
<!--							class="operStyle" src="../images/trash_small.gif">����</u></a> -->
<!--				</td>-->
<!--			</tr>-->
		<pg:listdata dataInfo="AuditDocList" keyName="AuditDocList" />
				<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="10" scope="request" data="AuditDocList" isList="false">
		<tr class="cms_report_tr">
<!--			<td height="30" align="center" width="3%">-->
<!--				<input type="checkBox" hideFocus=true name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">-->
<!--			</td>-->
			<td height="30" width="8%">�ĵ�����</td>
			<td height="30" width="40%">�ĵ�����</td>
			<td height="30" width="20%">����վ��</td>
			<td height="30"  width="8%">����Ƶ��</td>
			<td height="30" width="8%">������</td>
			<td height="30"  width="16%">�ύʱ��</td>
		</tr>
		
		<pg:param name="flag" />
		<pg:param name="docTitle" />
		<pg:param name="submitter" />
		<pg:param name="docChannel" />
		<pg:param name="subTime" />
			
		<!--��⵱ǰҳ���Ƿ��м�¼-->
		<pg:notify>
			<tr class="labeltable_middle_tr_01">
				<td colspan=100 align='center'  height="18px">
					��ʱû�д����ĵ�
				</td>
			</tr>
		</pg:notify>
		<!--list��ǩѭ�����ÿ����¼-->
		<%
			ContextMenu contextmenu = new ContextMenuImpl();
		%>
		<pg:list>
		<%	
			int taskid = dataSet.getInt("taskid");
			int docid = dataSet.getInt("docid");
			int docChannelid = dataSet.getInt("docChannelid");
			int docTpye = dataSet.getInt("docTpye");
			String docChannelName = dataSet.getString("docChannelName");
			int docSiteid = dataSet.getInt("docSiteid");							
			
			String updatepath = cfm.getCustomFormFilename(docChannelid+"","2","2");
			if("doc_gather_update.jsp".equals(updatepath)||"".equals(updatepath))
				updatepath = "/cms/docManage/doc_gather_update.jsp";
			else
				updatepath = updatepath;
			
			Menu menu = new Menu();
			menu.setIdentity("doc"+docid);
								
			Menu.ContextMenuItem menuitem1 = new Menu.ContextMenuItem();
			menuitem1.setName("���");
			menuitem1.setLink("javascript:audit('" + taskid + ":" + docid + ":" + docChannelid + "','" + docTpye +"','" + docid + "','" + docChannelName +"','" + docSiteid + "','" + docChannelid + "','"+updatepath+"')");
			menuitem1.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_sh.gif");
			menu.addContextMenuItem(menuitem1);

			Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
			menuitem2.setName("�˻�");
			menuitem2.setLink("javascript:disagree('" + taskid + ":" + docid + ":" + docChannelid + "')");
			menuitem2.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_back.gif");
			menu.addContextMenuItem(menuitem2);	

			Menu.ContextMenuItem menuitem3 = new Menu.ContextMenuItem();
			menuitem3.setName("Ԥ��");
			menuitem3.setLink("javascript:viewDoc('" + docid + "',toAuditDocListForm,'agreeFrame')");
			menuitem3.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_fbyl.gif");
			menu.addContextMenuItem(menuitem3);	

			contextmenu.addContextMenu(menu);
		%>
		<tr class="cms_data_tr"   onMouseOver="high(this)" onMouseOut="unhigh(this)" >
			<input name="docid" value="<pg:cell colName="docid" defaultValue=""/>" type=hidden>
<!--			<td class="tablecells"  height="25" align="center">-->
<!--				<input hideFocus onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" -->
<!--					value="<pg:cell colName="taskid" defaultValue=""/>-->
<!--						:<pg:cell colName="docid" defaultValue=""/>-->
<!--						:<pg:cell colName="docChannelid" defaultValue=""/>-->
<!--						:<pg:cell colName="docSiteid" defaultValue=""/>">-->
<!--			</td>-->
			<td class="tablecells" align=center height='30' width="5%">
				<pg:equal colName="docTpye" value="0">
				<div align="center">
					<img title="HTML�ĵ�" src="../images/doc_html.gif" width="20" height="20">
				</div>
				</pg:equal>
				<pg:equal colName="docTpye" value="1">
				<div align="center">
					<img title="�ⲿ���������ĵ�" src="../images/doc_link.gif" width="20" height="20">
				</div>
				</pg:equal>
				<pg:equal colName="docTpye" value="2">
				<div align="center">
					<img title="�����ļ�����" src="../images/doc_downloadfile.gif" width="15" height="16">
				</div>
				</pg:equal>
				<pg:equal colName="docTpye" value="3">
				<div align="center">
					<img title="�ۺ��ļ�����" src="../images/doc_aggr.gif" width="15" height="16">
				</div>
				</pg:equal>
			</td>
			<td id="doc<%=docid%>" class="tablecells" align="left" height="25" style="cursor:hand" 
					onClick="audit('<%=taskid%>:<%=docid%>:<%=docChannelid%>','<%=docTpye%>','<%=docid%>','<%=docChannelName%>','<%=docSiteid%>','<%=docChannelid%>','<%=updatepath%>')">
				<pg:cell colName="docName" defaultValue="" />
			</td>
			<td class="tablecells" align="left" height="25">
				<pg:cell colName="docSiteName" defaultValue="" />
			</td>
			<td class="tablecells" align="left" height="25">
				<pg:cell colName="docChannelName" defaultValue="" />
			</td>
			<td class="tablecells" align="left" height="25">
				<pg:cell colName="submitUserName" defaultValue="" />
			</td>
			<td class="tablecells" align="left" height="25">
				<pg:cell colName="submitTime" dateformat="yyyy/MM/dd HH:mm:ss" defaultValue="" />
			</td>
		</tr>
		</pg:list>
		<%
			request.setAttribute("opdoc",contextmenu);
		%>
		<pg:contextmenu context="opdoc" enablecontextmenu="true" scope="request"/>
		<tr class="labeltable_middle_tr_01">
			<td colspan=10><div class="Data_List_Table_Bottom">
				��
				<pg:rowcount />
				����¼
		  <pg:index />		 </div> </td>
		</tr>
	  <input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">
	  </pg:pager>
	</table>
  </form>
  <div heigth="0" width="0" style="display:none">
  	<iframe name="agreeFrame"><iframe/>
  </div>
</body>
</html>