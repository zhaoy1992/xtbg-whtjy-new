<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.*"%>
<%@page import="com.chinacreator.security.*"%>
<%	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String curUserid = accesscontroler.getUserID();
	request.setAttribute("curUserid",curUserid);
	
	String flag = request.getParameter("flag");
	String docTitle = request.getParameter("docTitle");
	String submitter = request.getParameter("submitter");
	String docChannel = request.getParameter("docChannel");
	String subTime =  request.getParameter("subTime");
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
		function conDeliverDoc(channelId,docid,taskid){
			//flagΪ1��ʾ�¸��ĵ��ĳ���,Ϊ2��ʾ�����ĵ��ĳ���
			openWin("<%=rootpath%>/cms/docManage/doc_AuditorList.jsp?flag=2&channelId=" + channelId + "&docid=" + docid + "&taskid=" + taskid);
		}
		function subQuery(){
			toAuditDocListForm.action="<%=rootpath%>/cms/docManage/workAgain.jsp";
			toAuditDocListForm.submit();
		}
		//function seeAdvice(channelId,docid,taskid){
		//	openWin("<%=rootpath%>/cms/docManage/see_audit_advice.jsp?channelId=" + channelId + "&docid=" + docid + "&taskid=" + taskid,250,220);
		//}	
		//�����ĵ�����
		function garbage(docId){
			if(window.confirm("��ȷ��Ҫ������")){
				//��ѡ�е��ĵ�idƴ���ַ���
				docidStr = ":" + docId + ";";
				toAuditDocListForm.action="docGarbageHandle.jsp?docidStr="+docidStr;
				toAuditDocListForm.target="reboundDocOperFrame";
				toAuditDocListForm.submit();
			}
		}
		//��������
		function garbageDocs(){
			//��ѡ�е��ĵ�idƴ���ַ���
			var all = document.getElementsByName("ID");
			var docidStr="";
			for(var i=0;i<all.length;i++){
				if(all[i].checked == true){
					docidStr = docidStr + ":" + all[i].value + ";";
				}
			} 
			if(haveSelect('ID')){
				if(window.confirm("��ȷ��Ҫ������")){
					toAuditDocListForm.action="docGarbageHandle.jsp?docidStr="+docidStr;
					toAuditDocListForm.target="reboundDocOperFrame";
					toAuditDocListForm.submit();
				}
			}else{
			    alert("������Ҫѡ��һƪ�ĵ���");
			}
		}
		//ɾ��һƪ�ĵ�
		function del(docId,docSiteid){
		if(confirm('��ȷ��Ҫɾ�����Ϊ'+docId+'���ĵ���')){
			docidStr = docId + ";";
			docSiteid = docSiteid ;
			toAuditDocListForm.action="document_del_submit.jsp?docidStr=" + docidStr + "&siteId=" + docSiteid;
	  		toAuditDocListForm.target="reboundDocOperFrame";
			toAuditDocListForm.submit();
			}
		}
		function edit(docid,docTpye,docChannelName,docSiteid,docChannelid){
		if(confirm('��ȷ��Ҫ�༭���Ϊ'+docid+'���ĵ���')){
			if(docTpye==0){
				openWin("doc_gather_update.jsp?flag=rebound&siteid=" + docSiteid + "&channelName=" + docChannelName + "&channelId=" + docChannelid + "&docid=" + docid,screen.availWidth-20,screen.availHeight-50);
			}else if(docTpye==1){
				openWin("doc_gather_links_update.jsp?flag=rebound&siteid=" + docSiteid + "&channelName=" + docChannelName + "&channelId=" + docChannelid + "&docid=" + docid,screen.availWidth-20,screen.availHeight-50);
			}else if(docTpye==2){
				openWin("doc_gather_filedownload_update?flag=rebound&siteid=" + docSiteid + "&channelName=" + docChannelName + "&channelId=" + docChannelid + "&docid=" + docid,screen.availWidth-20,screen.availHeight-50);
			}else if(docTpye==3){
				openWin("doc_gather_aggr_update.jsp?flag=rebound&siteid=" + docSiteid + "&channelName=" + docChannelName + "&channelId=" + docChannelid + "&docid=" + docid,screen.availWidth-20,screen.availHeight-50);
			}
			}
		}
		function delDocs()
		{			
			//��ѡ�е��ĵ�idƴ���ַ���
			var all = document.getElementsByName("ID");
			var docidStr="";
			var siteidStr="";
			for(var i=0;i<all.length;i++){
				if(all[i].checked == true){
					var ss = all[i].value;
					var aa = ss.split('/');
					docidStr = docidStr + aa[0] + ";";
					siteidStr = siteidStr + aa[1] + ";";
				}
			}
			if(haveSelect('ID')){
			if(confirm('��ȷ��Ҫɾ����ѡ�ĵ���')){
				toAuditDocListForm.action="document_del_submit.jsp?docidStr=" + docidStr + "&siteId=" + siteidStr;
		        toAuditDocListForm.target="reboundDocOperFrame";
				toAuditDocListForm.submit();
				}else
				{
				return false;
				}
			}else{
		    	alert("��ѡ��Ҫ��ɾ�����ĵ���");
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
	<form name="toAuditDocListForm" action="" method="post">
		<table width="100%" border="1"  cellpadding="3" cellspacing="0" bordercolor="#B7CBE4" class="Datalisttable">
		 <tr style="display:none">
			<td height="25"  colspan=7  background="../images/data_list_tHeadbg.jpg" style="text-align:left; background:url(../images/data_list_tHeadbg.jpg) repeat-y center #B7BDD7">
				<div class="DocumentOperT">�ĵ�������</div><div class="DocumentOperbox">
				<a style="cursor:hand" onClick="garbageDocs()"><div class="DocumentOper">����</div></a> 
				<a style="cursor:hand" onClick="delDocs()"><div class="DocumentOper">ɾ��</div></a>		</div>	</td>
		  </tr>
		<pg:listdata dataInfo="ReboundDocList" keyName="ReboundDocList" />
				<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
		<pg:pager maxPageItems="10" scope="request" data="ReboundDocList" isList="false">
		<tr class="cms_report_tr">
			<!-- <td width="5%" height="30" align="center">
				<input  class="checkbox" type="checkBox" hideFocus=true name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')"></td>-->
			<td width="8%" height="30">�ĵ�����</td>
			<td width="40%" height="30">�ĵ�����</td>
			<td  width="14%" height="30">����վ��</td>
			<td  width="10%" height="30">����Ƶ��</td>
			<td width="8%" height="30">�����</td>
			<td  width="15%" height="30">�ύʱ��</td>
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
					��ʱû�з����ĵ�				</td>
			</tr>
		</pg:notify>
		<%
			ContextMenu contextmenu = new ContextMenuImpl();
		%>
		<!--list��ǩѭ�����ÿ����¼-->
		<pg:list>
		<%	
			int taskid = dataSet.getInt("taskid");
			int docid = dataSet.getInt("docid");
			int docChannelid = dataSet.getInt("docChannelid");
			int docTpye = dataSet.getInt("docTpye");
			String docChannelName = dataSet.getString("docChannelName");
			int docSiteid = dataSet.getInt("docSiteid");							
			int siteid = docSiteid;
			
			Menu menu = new Menu();
			menu.setIdentity("doc"+docid);
								
			Menu.ContextMenuItem menuitem1 = new Menu.ContextMenuItem();
			menuitem1.setName("�޸�");
			menuitem1.setLink("javascript:edit('" + docid +"','" + docTpye +"','" + docChannelName + "','" + docSiteid + "','" + docChannelid + "')");
			menuitem1.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_edit.gif");
			menu.addContextMenuItem(menuitem1);

			Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
			menuitem2.setName("����");
			menuitem2.setLink("javascript:conDeliverDoc('" + docChannelid + "','" + docid + "','" + taskid +"')");
			menuitem2.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_ss.gif");
			menu.addContextMenuItem(menuitem2);	
			
			if(accesscontroler.checkPermission(docChannelid+"",AccessControl.TRASH_PERMISSION,AccessControl.CHANNEL_RESOURCE)||
				accesscontroler.checkPermission(siteid+"",AccessControl.TRASH_PERMISSION,AccessControl.SITECHANNEL_RESOURCE)){
				Menu.ContextMenuItem menuitem3 = new Menu.ContextMenuItem();
				menuitem3.setName("����");
				menuitem3.setLink("javascript:garbage('" + docid + "')");
				menuitem3.setIcon(request.getContextPath() +"/sysmanager/images/actions.gif");
				menu.addContextMenuItem(menuitem3);	
			}					
			if(accesscontroler.checkPermission(docChannelid+"",AccessControl.DELETE_PERMISSION,AccessControl.CHANNEL_RESOURCE)||
			   accesscontroler.checkPermission(siteid+"",AccessControl.DELETE_PERMISSION,AccessControl.SITECHANNEL_RESOURCE)){
				Menu.ContextMenuItem menuitem4 = new Menu.ContextMenuItem();
				menuitem4.setName("ɾ��");
				menuitem4.setLink("javascript:del('" + docid + "','" + docSiteid + "')");
				menuitem4.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_del.gif");
				menu.addContextMenuItem(menuitem4);	
			}
			contextmenu.addContextMenu(menu);
		%>
		<tr class="cms_data_tr"   onMouseOver="high(this)" onMouseOut="unhigh(this)">
			<!-- <td class="tablecells"  height="25" align="center"> -->
<!--				<input hideFocus onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID" -->
<!--					value="<pg:cell colName="taskid" defaultValue=""/>-->
<!--						:<pg:cell colName="docid" defaultValue=""/>">-->
<!-- 				<input hideFocus onClick="checkOne('checkBoxAll','ID')" type="checkbox"  class="checkbox" name="ID" 
					value='<pg:cell colName="docid" defaultValue=""/>/<pg:cell colName="docSiteid" defaultValue=""/>'>-->			</td>
			<td class="tablecells" align=center height="30">
				<pg:equal colName="docTpye" value="0">
				<div align="center">
					<img title="HTML�ĵ�" src="../images/doc_html.gif" width="20" height="20">				</div>
				</pg:equal>
				<pg:equal colName="docTpye" value="1">
				<div align="center">
					<img title="�ⲿ���������ĵ�" src="../images/doc_link.gif" width="20" height="20">				</div>
				</pg:equal>
				<pg:equal colName="docTpye" value="2">
				<div align="center">
					<img title="�����ļ�����" src="../images/doc_downloadfile.gif" width="15" height="16">				</div>
				</pg:equal>
				<pg:equal colName="docTpye" value="3">
				<div align="center">
					<img title="�ۺ��ļ�����" src="../images/doc_aggr.gif" width="15" height="16">				</div>
				</pg:equal>			</td>
			<td id="doc<%=docid%>" class="tablecells" align="left" height="25" style="cursor:hand" 
					onMouseOver="high(this)" onMouseOut="unhigh(this)" 
					onClick="viewDoc(<pg:cell colName="docid" defaultValue=""/>,toAuditDocListForm,'reboundDocOperFrame')" >
				<pg:cell colName="docName" defaultValue="" />
			</td>
			
			<td class="tablecells" align="left" height="25">
				<pg:cell colName="docSiteName" defaultValue="" />			</td>
			<td class="tablecells" align="left" height="25">
				<pg:cell colName="docChannelName" defaultValue="" />			</td>
			<td class="tablecells" align="left" height="25">
				<pg:cell colName="submitUserName" defaultValue="" />			</td>
			<td class="tablecells" align="left" height="25">
				<pg:cell colName="submitTime" dateformat="yyyy/MM/dd HH:mm:ss" defaultValue="" />			</td>
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
		  <pg:index /></div></td>
		</tr>
	  <input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">
	  </pg:pager>
	</table>
  </form>
  <div heigth="0" width="0" style="display:none">
  	<iframe name="reboundDocOperFrame"><iframe/>
  </div>
</body>
</html>