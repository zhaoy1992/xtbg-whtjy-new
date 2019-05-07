<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chinacreator.security.*"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.customform.*"%>
<%@ page import="com.frameworkset.common.tag.contextmenu.*"%>
<%@ include file="/sysmanager/include/global1.jsp"%>
<%@ include file="/sysmanager/base/scripts/panes.jsp"%>


<%	
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String curUserid = accesscontroler.getUserID();
	request.setAttribute("curUserid",curUserid);
	String flag = request.getParameter("flag");
	String subTitle = request.getParameter("title");
	String keyword = request.getParameter("keyword");
	String docAbstract = request.getParameter("docAbstract");
	String docType = request.getParameter("doctype");
	String docLevel = request.getParameter("docLevel");
	String creatTime = request.getParameter("creatTime");
	String channelIds = request.getParameter("channelIds");
	
	//ȡƵ�����趨���Զ����
	CustomFormManager cfm = new CustomFormManagerImpl();
%>
<html>
<head>
<title>
	���ĵ��б�
</title>
<link  href="../inc/css/cms.css" rel="stylesheet" type="text/css"></link>
<script language="javascript" src="../inc/js/func.js"></script>
<script language="javascript" src=src="../../sysmanager/include/pager.js" type="text/javascript"></script>
<script type="text/javascript">
/****************************************************************/

//operTypeΪ:�����ύ�������鵵����������(��Ե����ĵ�����)
function operateDoc(operType,docId,channelId,siteId,channelName){
    form1.action = "operate_doc.jsp?siteid="+siteId+"&channelName="+channelName+"&channelId="+channelId+"&operType="+operType+"&docId="+docId;
    form1.target="operIframe";
	form1.submit();
}

//����һƪ����
function garbageOneDoc(docId){
	if(window.confirm("��ȷ��Ҫ������")){
		form1.action="docGarbageHandle.jsp?docidStr=:" + docId + ";";
		form1.target="operIframe";
		form1.submit();
	}
}

//ɾ��һƪ�ĵ�
function delOneDoc(docId,siteId){
   if(confirm('��ȷ��Ҫɾ�����Ϊ'+docId+'���ĵ���'))
   {
	form1.action="document_del_submit.jsp?siteId=" + siteId + "&docidStr="+docId+";";
	form1.target="operIframe";
	form1.submit();
	}
}


/****************************************************************/
function adddoc(siteId,channelId,channelName){
	form1.action="doc_gather.jsp?siteid="+siteId+"&channelName="+channelName+"&channelId="+channelId;
	alert("�����ĵ���"+form1.action);
	//form1.submit();
}

	function garbage(){
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
				form1.action="docGarbageHandle.jsp?docidStr="+docidStr;
				form1.target="operIframe";
				form1.submit();
			}
		}else{
		    alert("������Ҫѡ��һƪ�ĵ���");
		}
	}
	function moveDoc(siteId,channelId){
		//��ѡ�е��ĵ�idƴ���ַ���
		var all = document.getElementsByName("ID");
		var docidStr="";
		for(var i=0;i<all.length;i++){
			if(all[i].checked == true){
				docidStr = docidStr + all[i].value + ":";
			}
		}
		if(haveSelect('ID')){
			//��ģ̬����ѡ��Ŀ��Ƶ��
			openWin("channel_select_frame.jsp?flag=1&siteid="+siteId+"&docidStr=" + docidStr + "&channelid="+channelId,400,500);
			return true;
		}else{
	    	alert("������Ҫѡ��һƪ�ĵ���");
	    	return false;
	   	}
  		return false;
	}
	function copyDoc(siteId,channelId){
		//��ģ̬����ѡ��Ŀ��Ƶ��
		//openWin(../channelManage/channel_doc_xz.jsp?siteid="+siteId+"&flag=2&channelid="+channelId,800,550);
		//��ѡ�е��ĵ�idƴ���ַ���
		var all = document.getElementsByName("ID");
		var docidStr="";
		for(var i=0;i<all.length;i++){
			if(all[i].checked == true){
				docidStr = docidStr + all[i].value + ":";
			}
		}
		if(haveSelect('ID')){
			//��ģ̬����ѡ��Ŀ��Ƶ��
			openWin("channel_select_frame.jsp?flag=2&siteid="+siteId+"&docidStr=" + docidStr + "&channelid="+channelId,400,500);
			return true;
		}else{
	    	alert("������Ҫѡ��һƪ�ĵ���");
	    	return false;
	   	}
  		return false;
	}
	function citeDoc(siteId,channelId){
		//��ģ̬����ѡ�������ĵ�
		//openWin("../channelManage/channel_doc_xz.jsp?siteid="+siteId+"&flag=3&channelid="+channelId,800,550);
		var all = document.getElementsByName("ID");
		var docidStr="";
		for(var i=0;i<all.length;i++){
			if(all[i].checked == true){
				docidStr = docidStr + all[i].value + ":";
			}
		}
		if(haveSelect('ID')){
			//��ģ̬����ѡ��Ŀ��Ƶ��
			openWin("channel_select_frame.jsp?flag=3&siteid="+siteId+"&docidStr=" + docidStr + "&channelid="+channelId,400,500);
			return true;
		}else{
	    	alert("������Ҫѡ��һƪ�ĵ���");
	    	return false;
	   	}
  		return false;
	}
	//ת��
	function transmitDoc(siteId,channelId,docId){ 
		//��ѡ�е��ĵ�idƴ���ַ���
		docidStr = docId + ":";
		//��ģ̬����ѡ��Ŀ��Ƶ��
		openWin("channel_select_frame.jsp?newDoc=true&siteid="+siteId+"&docidStr=" + docidStr + "&channelid="+channelId,400,500);
	}
	function citeDocManager(channelId){
		//��ģ̬���ڲ鿴�����ĵ�����������й���
		openWin("cited_doc_manager.jsp?channelid="+channelId,800,700);
	}
	//����汾
	function addDocVer()
	{
		//��ѡ�е��ĵ�idƴ���ַ���
		var all = document.getElementsByName("ID");
		var docidStr="";
		for(var i=0;i<all.length;i++){
			if(all[i].checked == true){
				docidStr = docidStr + all[i].value + ":";
			}
		}
		if(haveSelect('ID')){
			openWin("add_document_version.jsp?docidStr=" + docidStr,400,500);
			return true;
		}else{
	    	alert("��ѡ��Ҫ�󱣴�汾���ĵ���");
	    	return false;
	   	}
	}
	//��һƪ�ĵ�����汾
	function addDocVer1(docId){
		//��ѡ�е��ĵ�idƴ���ַ���
		var docidStr=docId + ":";
		openWin("add_document_version.jsp?docidStr=" + docidStr,400,500);
	}
	//�汾����
	function manageDocVer(docid)
	{
		//��ģ̬����ѡ��Ŀ��Ƶ��
		openWin("dilogparent.jsp?docid=" + docid,800,500);
	}
	//���������ĵ�
	function exportDoc(siteId,channelId,docId)
	{
		//��ѡ�е��ĵ�idƴ���ַ���
		var docidStr=docId + ",";
		form1.action="doc_export.jsp?siteid="+siteId+"&docids=" + docidStr;
	    form1.target="operIframe";
		form1.submit();
		//��ģ̬����ѡ��Ŀ��Ƶ��
		//window.open("doc_export.jsp?siteid="+siteId+"&docids=" + docidStr,"newwin","");
	}
	//�����ö�
	function addArrangeDoc(siteid,channelid,docid)
	{
		openWin("docArrange_add.jsp?siteid=" + siteid + "&channelid=" + channelid + "&docid=" + docid,555,240);
	}
	//�ĵ��ö�����
	function arrangeDocM(channelId)
	{
		openWin("docArrange_manage.jsp?chnlid="+channelId,800,500);
	}
	//��չ�ֶ�
	function extfieldmanage(channelId)
	{
		parent.document.location.href = "doc_extfieldofsiteorchl_list.jsp?type=2&id="+channelId;
	}
	//ɾ���ĵ�
	function delDoc()
	{
		//��ѡ�е��ĵ�idƴ���ַ���
		var all = document.getElementsByName("ID");
		var docidStr="";
		for(var i=0;i<all.length;i++){
			if(all[i].checked == true){
				docidStr = docidStr + all[i].value + ";";
			}
		}
		if(haveSelect('ID')){
			form1.action="document_del_submit.jsp?docidStr=" + docidStr;
	        form1.target="operIframe";
			form1.submit();
		}else{
	    	alert("��ѡ��Ҫ��ɾ�����ĵ���");
	    	return false;
	   	}
	}
	function auditAgreeDoc(docId,channelId){
		var idStr = ":" + docId + ":"+channelId;
		//����auditFlagΪ��������0��ͬ�⣬1��ͬ��
		openWin("audit_add_comment.jsp?idStr=" + idStr + "&auditFlag=1",300,300);
	}
	function auditUnagreeDoc(docId,channelId){
		var idStr = ":" + docId + ":"+channelId;
		var addComment = window.confirm("Ҫ������������");
		if(addComment==false){
			//����auditFlagΪ��������0��ͬ�⣬1��ͬ��
			form1.action = "auditDocHandle.jsp?idStr=" + idStr + "&auditFlag=0";
			form1.target = "operIframe";
			form1.submit();
		}
		else{
			openWin("audit_add_comment.jsp?idStr=" + idStr + "&auditFlag=0",300,300);
		}	
	}
	function publishDoc(docId){
		form1.action = "publishDocHandle.jsp?flag=3&docId="+docId;
		form1.target = "operIframe";
		form1.submit();
	}
	function publishPreview(docId){
		form1.action = "previewPubDocHandle.jsp?docId="+docId;
		form1.target = "operIframe";
		form1.submit();
	}
	function edit(editLink,docid,siteid,channelName,channelId){
			openWin(editLink + "?docid=" + docid + "&siteid=" + siteid + "&channelName=" + channelName + "&channelId=" + channelId, screen.availWidth-20,screen.availHeight-50);
	}
</script>
<style type="text/css">
body {
	background-color: #ffffff;
scrollbar-face-color: #C9D1E4; 
scrollbar-shadow-color: #6B74B7; 
scrollbar-highlight-color: white; 
scrollbar-3dlight-color: #E100E1; 
scrollbar-darkshadow-color:#E100E1; 
scrollbar-arrow-color:#003492; 
scrollbar-base-color: #E100E1; 
scrollbar-track-color: #E9EDF3; 
}
</style>
</head>
<body topmargin="2" rightmargin="0" leftmargin="1" righttmargin="1">
<form name="form1" action="" method="post" >
<table width="100%" border="0" align="left" cellpadding="3" cellspacing="0" bordercolor="#B7CBE4" class="Datalisttable" id="docListTable">
<pg:listdata dataInfo="NewDocList" keyName="NewDocList" />
<pg:pager maxPageItems="10" scope="request" data="NewDocList" isList="false">
	<tr class="cms_report_tr">
<!--		<td height='30' align=center style="width:5%">-->
<!--			<input  class="checkbox" type="checkBox" hideFocus=true name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">		</td>-->
		<td width="8%">
			�ĵ�����		</td>
		<td width="8%" height='30'>
			�Ƿ��ö�		</td>
		<td width="36%">
			�ĵ�����		</td>
		<td width="5%">
			����Ƶ��		</td>
		<td width="20%">
			����վ��		</td>		
		<td width="33%">
			��������		</td>
	</tr>
	<pg:param name="flag" />
	<pg:param name="subTitle" />	
	<pg:param name="keyword" />
	<pg:param name="docAbstract" />
	<pg:param name="docType" />
	<pg:param name="docLevel" />
	<pg:param name="creatTime" />
	<pg:param name="channelIds" />	
	<pg:notify>
		<tr class="labeltable_middle_tr_01">
			<td colspan=100 align='center'  height="18px">
				��ʱû�������ĵ�
			</td>
		</tr>
	</pg:notify>
	<%
			ContextMenu contextmenu = new ContextMenuImpl();
	%>
	<pg:list>
	<%	
			int docid = dataSet.getInt("document_id");
			int chanel_id = dataSet.getInt("chanel_id");
			
			String addpath = cfm.getCustomFormFilename(chanel_id+"","2","1");
			String updatepath = cfm.getCustomFormFilename(chanel_id+"","2","2");
			if("doc_gather.jsp".equals(addpath)||"".equals(addpath))
				addpath = "/cms/docManage/doc_gather.jsp";
			else
				addpath = addpath;
			if("doc_gather_update.jsp".equals(updatepath)||"".equals(updatepath))
				updatepath = "/cms/docManage/doc_gather_update.jsp";
			else
				updatepath = updatepath;
			
			int doctype = dataSet.getInt("doctype");
			String channelName = dataSet.getString("channelName");
			int siteid = dataSet.getInt("siteid");
			
			String editLink = "doc_gather_update.jsp";
			switch(doctype){
				case 0 :
						break;
				case 1:
						editLink = "doc_gather_links_update.jsp?";
						break;
				case 2:
						editLink = "doc_gather_filedownload_update.jsp";
						break;
				case 3:
						editLink = "doc_gather_aggr_update.jsp";
						break;
			}
			DocumentManager dm = new DocumentManagerImpl();
			Map docOpers = dm.getDocOpers(docid,accesscontroler); 							
			boolean isArrangeDoc = dm.ArrangeDocExist(String.valueOf(docid));//�Ƿ����ö�
			
			Menu menu = new Menu();
			menu.setIdentity("opdoc_"+docid);
		
			//Menu.ContextMenuItem menuitem1 = new Menu.ContextMenuItem();
			//menuitem1.setName("�༭");
			//menuitem1.setLink("javascript:edit('" + editLink + "','" + docid + "','" + siteid + "','" + channelName + "','" + chanel_id + "')");
			//menuitem1.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_edit.gif");
			//menu.addContextMenuItem(menuitem1);
			
			//if(doctype == 0 || doctype == 1){
				//Menu.ContextMenuItem menuitem6 = new Menu.ContextMenuItem();
				//menuitem6.setName("Ԥ��");
				//menuitem6.setLink("javascript:viewDoc('" + docid + "',form1,'operIframe')");
				//menuitem6.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_fbyl.gif");
				//menu.addContextMenuItem(menuitem6);
			//}
			
			if(docOpers.get("deliver")!=null){
				Menu.ContextMenuItem menuitem2 = new Menu.ContextMenuItem();
				menuitem2.setName("����");
				menuitem2.setLink("javascript:operateDoc('����','" + docid + "','" + chanel_id + "','" + siteid + "','" + channelName + "')");
				menuitem2.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_ss.gif");
				menu.addContextMenuItem(menuitem2);
			}
			if(docOpers.get("subpublish")!=null && doctype==0){
				Menu.ContextMenuItem menuitem6 = new Menu.ContextMenuItem();
				menuitem6.setName("�ύ����");
				menuitem6.setLink("javascript:operateDoc('�ύ����','" + docid + "','" + chanel_id + "','" + siteid + "','" + channelName + "')");
				menuitem6.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_tjfb.gif");
				menu.addContextMenuItem(menuitem6);
			}
			if(accesscontroler.checkPermission(chanel_id+"",AccessControl.ADD_DOCVER_PERMISSION,AccessControl.CHANNELDOC_RESOURCE)||
				accesscontroler.checkPermission(siteid+"",AccessControl.ADD_DOCVER_PERMISSION,AccessControl.SITEDOC_RESOURCE)){
				Menu.ContextMenuItem menuitem8 = new Menu.ContextMenuItem();
				menuitem8.setName("����汾");
				menuitem8.setLink("javascript:addDocVer1('" + docid + "')");
				menuitem8.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/plan.gif");
				menu.addContextMenuItem(menuitem8);
			}
			if(docOpers.get("manageDocVer")!=null){
				Menu.ContextMenuItem menuitem3 = new Menu.ContextMenuItem();
				menuitem3.setName("�汾����");
				menuitem3.setLink("javascript:manageDocVer('" + docid + "')");
				menuitem3.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_bbgl.gif");
				menu.addContextMenuItem(menuitem3);
			}
			if(docOpers.get("addArrangeDoc")!=null&&!isArrangeDoc){
				Menu.ContextMenuItem menuitem7 = new Menu.ContextMenuItem();
				menuitem7.setName("�����ö�");
				menuitem7.setLink("javascript:addArrangeDoc(" + siteid + "," + chanel_id + "," + docid + ")");
				menuitem7.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_szzd.gif");
				menu.addContextMenuItem(menuitem7);
			}
			if(accesscontroler.checkPermission(chanel_id+"",AccessControl.TRANSMIT_PERMISSION,AccessControl.CHANNELDOC_RESOURCE)||
				accesscontroler.checkPermission(siteid+"",AccessControl.TRANSMIT_PERMISSION,AccessControl.SITEDOC_RESOURCE)){
				Menu.ContextMenuItem menuitem9 = new Menu.ContextMenuItem();
				menuitem9.setName("ת��");
				menuitem9.setLink("javascript:transmitDoc('" + siteid + "','" + chanel_id + "','" + docid + "')");
				menuitem9.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_tjfb.gif");
				menu.addContextMenuItem(menuitem9);
			}
			if(accesscontroler.checkPermission(chanel_id+"",AccessControl.EXPORTDOC_PERMISSION,AccessControl.CHANNELDOC_RESOURCE)||
				accesscontroler.checkPermission(siteid+"",AccessControl.EXPORTDOC_PERMISSION,AccessControl.SITEDOC_RESOURCE)){
				Menu.ContextMenuItem menuitem9 = new Menu.ContextMenuItem();
				menuitem9.setName("����");
				menuitem9.setLink("javascript:exportDoc('" + siteid + "','" + chanel_id + "','" + docid + "')");
				menuitem9.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/tpl_reimport.gif");
				menu.addContextMenuItem(menuitem9);
			}
			if(accesscontroler.checkPermission(chanel_id+"",AccessControl.TRASH_PERMISSION,AccessControl.CHANNEL_RESOURCE)||
				accesscontroler.checkPermission(siteid+"",AccessControl.TRASH_PERMISSION,AccessControl.SITECHANNEL_RESOURCE)){
				Menu.ContextMenuItem menuitem4 = new Menu.ContextMenuItem();
				menuitem4.setName("����");
				menuitem4.setLink("javascript:garbageOneDoc('" + docid + "')");
				menuitem4.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/trash_small.gif");
				menu.addContextMenuItem(menuitem4);
			}
			
			if(accesscontroler.checkPermission(chanel_id+"",AccessControl.DELETE_PERMISSION,AccessControl.CHANNEL_RESOURCE)||
				accesscontroler.checkPermission(siteid+"",AccessControl.DELETE_PERMISSION,AccessControl.SITECHANNEL_RESOURCE)){
				Menu.ContextMenuItem menuitem5 = new Menu.ContextMenuItem();
				menuitem5.setName("ɾ��");
				menuitem5.setLink("javascript:delOneDoc('" + docid + "','" + siteid + "')");
				menuitem5.setIcon(request.getContextPath() +"/sysmanager/images/rightMemu/doc_del.gif");
				menu.addContextMenuItem(menuitem5);	
			}					
	
			contextmenu.addContextMenu(menu);
	%>
		<input name="docid" value="<pg:cell colName="document_id" defaultValue=""/>" type="hidden">
		<tr class="cms_data_tr" id="<pg:cell colName="document_id" defaultValue=""/>" onMouseOver="high(this)" onMouseOut="unhigh(this)">
<!--			<td class="tablecells" align=center height='30' width="5%">-->
<!--				<input hideFocus class="checkbox" type="checkbox" name="ID" value="<pg:cell colName="document_id" defaultValue=""/>">-->
<!--			</td>-->
			<td class="tablecells" height='30' width="5%">
				<pg:equal colName="doctype" value="0">
					<img title="HTML�ĵ�" src="../images/doc_html.gif" width="20" height="20">				</pg:equal>
				<pg:equal colName="doctype" value="1">
					<img title="�ⲿ���������ĵ�" src="../images/doc_link.gif" width="20" height="20">
				</pg:equal>
				<pg:equal colName="doctype" value="2">
					<img title="�����ļ�����" src="../images/doc_downloadfile.gif" width="15" height="16">
				</pg:equal>
				<pg:equal colName="doctype" value="3">
					<img title="�ۺ��ļ�����" src="../images/doc_aggr.gif" width="15" height="16">
				</pg:equal>
			</td>
<!--			<td id="doc<%=docid%>" class="tablecells" align="left" height="25" style="cursor:hand"  -->
<!--					onClick="viewDoc(<pg:cell colName="document_id" defaultValue=""/>,form1,'operIframe')" >-->
<!--				<pg:cell colName="subtitle" defaultValue="" />-->
<!--			</td>-->
			<td>
				<%if(isArrangeDoc){%><span class="red_star">�ö�</span><%}%>
			</td>
			<pg:equal colName="doctype" value="0">
			<td id="opdoc_<%=docid%>" class="tablecells" style="cursor:hand" 

									onclick="openWin('<%=rootpath%><%=updatepath%>?docid=<pg:cell colName="document_id" defaultValue=""/>&siteid=<%=siteid%>&channelName=<%=channelName%>&channelId=<%=chanel_id%>',screen.availWidth-20,screen.availHeight-50)">
				<pg:cell colName="subtitle" defaultValue="" />
			</pg:equal>
			<pg:equal colName="doctype" value="1">
			<td id="opdoc_<%=docid%>" class="tablecells" style="cursor:hand" 
					
					onclick=" openWin('<%=rootpath%>/cms/docManage/doc_gather_links_update.jsp?siteid=<%=siteid%>&channelName=<%=channelName%>&channelId=<%=chanel_id%>&docid=<pg:cell colName="document_id" defaultValue=""/>',screen.availWidth-20,screen.availHeight-50)">
				<pg:cell colName="subtitle" defaultValue="" />
			</pg:equal>
			<pg:equal colName="doctype" value="2">
			<td id="opdoc_<%=docid%>" class="tablecells" style="cursor:hand" 
					
					onclick="openWin('<%=rootpath%>/cms/docManage/doc_gather_filedownload_update.jsp?docid=<pg:cell colName="document_id" defaultValue=""/>&siteid=<%=siteid%>&channelName=<%=channelName%>&channelId=<%=chanel_id%>',screen.availWidth-20,screen.availHeight-50)">
				<pg:cell colName="subtitle" defaultValue="" />
			</pg:equal>
			<pg:equal colName="doctype" value="3">
			<td id="opdoc_<%=docid%>" class="tablecells" style="cursor:hand" 
					
					onclick="openWin('<%=rootpath%>/cms/docManage/doc_gather_aggr_update.jsp?docid=<pg:cell colName="document_id" defaultValue=""/>&siteid=<%=siteid%>&channelName=<%=channelName%>&channelId=<%=chanel_id%>',screen.availWidth-20,screen.availHeight-50)">
				<pg:cell colName="subtitle" defaultValue="" />
			</pg:equal>
			</td>

			<td class="tablecells" width="10%">
				<pg:cell colName="channelName" defaultValue="" />
			</td>
			<td class="tablecells" width="8%">
				<pg:cell colName="siteName" defaultValue="" />
			</td>
			<td class="tablecells" width="10%">
				<pg:cell colName="createTime" dateformat="yyyy/MM/dd HH:mm:ss" defaultValue="" />
			</td>
			
		</tr>	
	</pg:list>
	<%
			request.setAttribute("opdoc",contextmenu);
	%>
	<pg:contextmenu context="opdoc" enablecontextmenu="true" scope="request"/>
	<tr>
		<td colspan=10><div class="Data_List_Table_Bottom">��
			  <pg:rowcount />����¼<pg:index /></div></td>
	</tr>
	<input id="queryString" name="queryString" value="<pg:querystring/>" type="hidden">
</pg:pager>
</table>
</form>
<iframe height="0" width="0" name="operIframe"></iframe>
</body>
</html>