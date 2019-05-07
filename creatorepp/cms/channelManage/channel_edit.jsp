<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="java.util.*"%>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.container.Template"%>
<%@ page import="com.chinacreator.cms.sitemanager.*"%>
<%@ page import="com.chinacreator.cms.templatemanager.*"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.chinacreator.cms.channelmanager.*"%>
<%@ page import="com.chinacreator.cms.documentmanager.*"%>
<%@ page import="com.chinacreator.cms.flowmanager.*"%>
<%@ page import="com.chinacreator.util.*"%>
<%@ page import="com.chinacreator.cms.util.*"%>
<%@ page import="com.chinacreator.cms.customform.*"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(pageContext);

	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	String siteName = request.getParameter("siteName");
	String siteId   = request.getParameter("siteId");
	CustomFormManager cfm = new CustomFormManagerImpl();
	if(siteId==null || siteId.trim().length()==0){
%>
		<script language="javascript" type="text/javascript">
			alert("վ��idΪ��,�޷��������κ�վ���Ƶ��.");
			self.location.href = "about:blank";
		</script>
<%
		return;
	}
	String channelId = request.getParameter("channelId");
	String channelName = request.getParameter("channelName");
	if (channelId == null || channelId.trim().length() == 0) {
	%>
		<script language="javascript" type="text/javascript">
			alert("Ƶ��idΪ��,�޷��༭Ƶ��.");
			self.location.href = "about:blank";
		</script>
	<%
		return;
	}
	ChannelManager cm = new ChannelManagerImpl();
	Channel chnl = cm.getChannelInfo(channelId);
	if (chnl == null) {
	%>
		<script language="javascript" type="text/javascript">
			alert("û���ҵ���Ƶ��,�޷��༭Ƶ��.");
			self.location.href = "about:blank";
		</script>
	<%
		return;
	}
	
	String  pubFileName = "";
	if(chnl.getPubFileName()!=null )
		pubFileName = chnl.getPubFileName();
	int pageflag = 0;
	pageflag = chnl.getPageflag();
	String indexpagepath = chnl.getIndexpagepath();
	DocumentManager dm = new DocumentManagerImpl();
	String chnlName = "";
	if(pageflag == 2) {   // ���ĵ�����ʱ��indexpagepath������ĵ�id
		Document tempdoc = dm.getDoc(indexpagepath);
		if(tempdoc != null)
		{
			chnlName = cm.getChannelInfo(tempdoc.getChanel_id()+"").getName() + "/" + tempdoc.getSubtitle();
		}
	}
	if(pageflag == 3 && indexpagepath!=null){
		chnlName = CMSUtil.getChannelCacheManager(indexpagepath.split(":")[0]).getChannel(indexpagepath.split(":")[1]).getDisplayName();
	}
	
	String parentChannelId = "";//��Ƶ��id
	long pId = chnl.getParentChannelId();
	if(pId > 0)
		parentChannelId = String.valueOf(pId);

	String workflowIsFromParent = String.valueOf(chnl.workflowIsFromParent());

	String outlineTemplateName="��ǰû��ѡ��ģ��";
	String detailTemplateName ="��ǰû��ѡ��ģ��";
	String otId = "";
	String dtId = "";
	try
	{
	    TemplateManager tpltMng = new TemplateManagerImpl();
		otId = String.valueOf(chnl.getOutlineTemplateId());
		if(tpltMng.getTemplateInfo(otId)!=null)
			outlineTemplateName = tpltMng.getTemplateInfo(otId).getName();
		dtId = String.valueOf(chnl.getDetailTemplateId());
		if(tpltMng.getTemplateInfo(dtId)!=null)	
			detailTemplateName = tpltMng.getTemplateInfo(dtId).getName();
	}catch(Exception e)
	{
		System.out.println("xx"+siteId);
		e.printStackTrace();
	}
    //add by ge.tao
    //�ж�Ƶ�����Ƿ����ĵ�
    boolean hasOldDocument = dm.channelHasDoc(channelId);
    
    
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script src="../inc/js/func.js"></script>
<tab:tabConfig/>
<title>�༭Ƶ��</title>
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<style type="text/css">
	.topDIV {
		background-image: url(../images/toolbar_common_func_site.jpg);
		height: 82px;
		padding-top: 7px;
		padding-left: 55px;
	}

	body {
		margin-left: 0px;
		margin-top: 0px;
		margin-right: 0px;
		margin-bottom: 0px;
	}
</style>
<script language="javascript">
function changeWorkFlowType(type){
	if(type == 1){
		document.all.channalForm.workFlow.disabled = true;
	}else{
		document.all.channalForm.workFlow.disabled = false;
	}
}
//Ĭ�����뽹��
function setFocus(){
	//document.all.channalForm.channelName.focus();
	var workflowIsFromParent = "<%=workflowIsFromParent%>";
	if(workflowIsFromParent=="0")
	{
		document.all.channalForm.workFlow.disabled = false;
	}
	if(workflowIsFromParent=="1")
	{
		document.all.channalForm.workFlow.disabled = true;
		document.all.workFlowFrom[1].checked = true;
	}
}

function checkForm(){
   if(!confirm('��ȷ��Ҫ�޸�Ƶ����Ϣ��'))
   {
   return;
   }
	var channalForm = document.all.channalForm;

	var channelName = channalForm.channelName.value;
	if(channelName.search(/\S/g)==-1){
		alert("������Ƶ����������!");
		//channalForm.channelName.focus();
		return;
	}

	//�����ַ�\/|:*?<>"'
	if(channelName.search(/[\\\/\|:\*\?<>"']/g)!=-1){
		alert("Ƶ���������Ʋ�����\\/|:*?<>\"'!�������ַ�");
		//channalForm.channelName.focus();
		return;
	}

	var displayName = channalForm.displayName.value;
	if(displayName.search(/\S/g)==-1){
		alert("������Ƶ����ʾ����!");
		channalForm.displayName.focus();
		return;
	}

	if(displayName.search(/[\\\/\|:\*\?<>"']/g)!=-1){
		alert("Ƶ����ʾ���Ʋ�����\\/|:*?<>\"'!�������ַ�");
		//channalForm.displayName.focus();
		return;
	}

	var order = channalForm.order.value;
	if(order.search(/\D/g)!=-1){
		alert("˳��ֻ��������!");
		//channalForm.order.focus();
		return false;
	}
	var pubType = document.getElementsByName("pubType");
	if(pubType[0].checked==true){
		var pubFileName = channalForm.pubFileName.value;
		if(pubFileName.search(/\S/g)==-1){
			alert("��ģ�巢���������ļ�������Ϊ��!");
			//channalForm.pubFileName.focus();
			return false;
		}
		if(pubFileName.search(/^.*\.[html|htm]*$/g)==-1){
			alert("�ļ�����ʽ����!��������html��htm��׺��β���ļ�����");
			//channalForm.pubFileName.focus();
			return false;
		}
	}
	if(pubType[1].checked==true){
		var chnlIndexPage = channalForm.chnlIndexPage.value; 
		if(chnlIndexPage.search(/\S/g)==-1){
			alert("����ҳ�ļ��������ļ���ҳ����Ϊ��!");
			//channalForm.chnlIndexPage.focus();
			return false;
		}
		//if(chnlIndexPage.search(/^.*\.[html|htm|jsp]*$/g)==-1){
			//alert("��ҳ�ļ�����ʽ����!��������html��htm��jsp��׺��β���ļ�����");
			//channalForm.pubFileName.focus();
			//return false;
		//}
	}
	if(pubType[2].checked==true){
		var chnlIndexDoc = channalForm.chnlIndexDoc.value;
		var docId = channalForm.docId.value; 
		if(chnlIndexDoc.search(/\S/g)==-1 || docId.length==0){
			alert("���ĵ��������ĵ�������Ϊ��!");
			//channalForm.chnlIndexPage.focus();
			return false;
		}
	}
	if(pubType[3].checked==true){
		var chnlIndexChnl = channalForm.chnlIndexChnl.value;
		var chnlId = channalForm.chnlId.value; 
		if(chnlIndexChnl.search(/\S/g)==-1 || chnlId.length==0){
			alert("����Ƶ����ҳ��Ƶ��������Ϊ��!");
			//channalForm.chnlIndexPage.focus();
			return false;
		}
	}
	
	//����ͼƬ����Ϊ��
	//var outlinePicture = document.getElementsByName("outlinePicture");	
	//var myOutlinePicture = outlinePicture[0].value;
	//if(myOutlinePicture.length==0){
	//	alert("����ͼƬ����Ϊ��!");
	//	return false;
	//}
	document.all.channalForm.submit();
	//��ֹ�����ύ
	document.all("button")[0].disabled = true;
	document.all("button")[1].disabled = true;
}

function setChannelOutlineTemplateId()
{
 		var w = showModalDialog("channel_templateSet_frameset.jsp?siteId=<%=siteId%>&channelId=<%=channelId%>&channelName=<%=channelName%>&outlineTemplateName="+channalForm.otName.value+"&otId="+channalForm.outlineTemplateId.value+"&type=1&action=search&isSite=doc","setChannelOutlineTemplateId","dialogWidth:800px;dialogHeight:505px;help:no;scroll:yes;status:no");
		//alert(w[0]+"    "+w[1]);
		if(w!=undefined && w.length>0)
		{
			channalForm.outlineTemplateId.value = w[0];
			channalForm.otName.value = w[1];
		}
}

function setChannelDetailTemplateId()
{
 		var w = showModalDialog("channel_templateSet_frameset.jsp?siteId=<%=siteId%>&channelId=<%=channelId%>&channelName=<%=channelName%>&detailTemplateName="+channalForm.dtName.value+"&dtId="+channalForm.detailTemplateId.value+"&type=2&action=search&isSite=doc","setChannelOutlineTemplateId","dialogWidth:800px;dialogHeight:505px;help:no;scroll:yes;status:no");
		
		if(w!=undefined && w.length>0)
		{
			channalForm.detailTemplateId.value = w[0];
			channalForm.dtName.value = w[1];
		}

}
//ѡ���ļ�
function setCustomForm(type)
{
	//openWin("../docManage/select_custom_form.jsp",400,400);
	openWin("../docManage/formfile_choise_frames.jsp?type=" + type,600,480);
}
//ʹ��Ĭ��ֵ
function setDefault(type)
{
	if(type=="add")
		channalForm.add.value = "doc_gather.jsp";
	if(type=="update")
		channalForm.update.value = "doc_gather_update.jsp";
	if(type=="list")
		channalForm.list.value = "doc_list.jsp";
}

function shownavigatorMoreInfo(b){
	if(b){
		document.all.navigatorMoreInfo1.style.display="block";
		document.all.navigatorMoreInfo2.style.display="block";
		document.all.navigatorMoreInfo3.style.display="block";
		document.all.navigatorMoreInfo4.style.display="block";
		document.all.navigatorMoreInfo5.style.display="block";
	}else{
		document.all.navigatorMoreInfo1.style.display="none";
		document.all.navigatorMoreInfo2.style.display="none";
		document.all.navigatorMoreInfo3.style.display="none";
		document.all.navigatorMoreInfo4.style.display="none";
		document.all.navigatorMoreInfo5.style.display="none";
	}
}
var currFile;
function chooseImage(str){
	currFile = eval("document.all."+str);
	openWin("chooseImageFrameset.jsp?fileFlag=picOrFlash",700,580);
}

function setImage(uri){
	currFile.value  = uri;
}
function chooseChnlIndexPage(str){	
	currFile = eval("document.all."+str);
	openWin("chooseImageFrameset.jsp?fileFlag=1",520,580);
}
//ģ��Ԥ��
function templatePreview(obj){
	var tplId = obj.value;
	window.open("<%=request.getContextPath()%>/cms/templateManage/template_previewbyid.jsp?tplId=" + tplId + "&siteId=<%=siteId%>");
}
//ģ���ļ�Ԥ��
function pubPreviewFile(filename,uri,siteId) {
		var u = uri.replace("\\", "/").replace(/\s+/img,"");
		if(u.charAt(u.length - 1)!="/")
		{
			u = u+"/";
		}
		if(u=="/")
		{
			u = "";
		} 
		exeman.location.href = "../templateManage/template_pub_preview.jsp?uri="+(u+filename)+"&siteId="+siteId+"&action=preview";
	}
function changePupType(flag){
	if(flag==1){
		document.all.pubFileName.disabled="disabled";
		//document.all.outlineTemplateId.disabled="disabled";
		document.all.outlineTemplatePreview.disabled="disabled";
		document.all.outlineTemplateChoice.disabled="disabled";
		document.all.chnlIndexPage.disabled="";
		document.all.setChnlIndexPage.disabled="";
		document.all.chnlIndexDoc.disabled="disabled";
		document.all.setChnlIndexDoc.disabled="disabled";
		document.all.previewChnlIndexDoc.disabled="disabled";
		
		document.all.chnlIndexChnl.disabled="disabled";
		document.all.setChnlIndexChnl.disabled="disabled";
		document.all.previewChnlIndexChnl.disabled="disabled";
	}else if(flag==0){
		document.all.pubFileName.disabled="";
		//document.all.outlineTemplateId.disabled="";
		document.all.outlineTemplatePreview.disabled="";
		document.all.outlineTemplateChoice.disabled="";
		document.all.chnlIndexPage.disabled="disabled";
		document.all.setChnlIndexPage.disabled="disabled";
		document.all.chnlIndexDoc.disabled="disabled";
		document.all.setChnlIndexDoc.disabled="disabled";
		document.all.previewChnlIndexDoc.disabled="disabled";
		
		document.all.chnlIndexChnl.disabled="disabled";
		document.all.setChnlIndexChnl.disabled="disabled";
		document.all.previewChnlIndexChnl.disabled="disabled";
	}else if(flag==2){
		document.all.pubFileName.disabled="disabled";
		//document.all.outlineTemplateId.disabled="disabled";
		document.all.outlineTemplatePreview.disabled="disabled";
		document.all.outlineTemplateChoice.disabled="disabled";
		document.all.chnlIndexPage.disabled="disabled";
		document.all.setChnlIndexPage.disabled="disabled";
		document.all.chnlIndexDoc.disabled="";
		document.all.setChnlIndexDoc.disabled="";
		document.all.previewChnlIndexDoc.disabled="";
		
		document.all.chnlIndexChnl.disabled="disabled";
		document.all.setChnlIndexChnl.disabled="disabled";
		document.all.previewChnlIndexChnl.disabled="disabled";
	}else if(flag==3){
		document.all.pubFileName.disabled="disabled";
		//document.all.outlineTemplateId.disabled="disabled";
		document.all.outlineTemplatePreview.disabled="disabled";
		document.all.outlineTemplateChoice.disabled="";
		document.all.chnlIndexPage.disabled="disabled";
		document.all.setChnlIndexPage.disabled="disabled";
		document.all.chnlIndexDoc.disabled="disabled";
		document.all.setChnlIndexDoc.disabled="disabled";
		document.all.previewChnlIndexDoc.disabled="disabled";
		
		document.all.chnlIndexChnl.disabled="";
		document.all.setChnlIndexChnl.disabled="";
		document.all.previewChnlIndexChnl.disabled="";
	}
}
function chooseDoc(){
	var re = openWin("channel_doc_xz.jsp?siteid=<%=siteId%>&flag=5&channelid=<%=channelId%>",750,550);
	if(re!=undefined){
		var vl = re.split(":");
		document.all.docId.value=vl[0];
		document.all.chnlIndexDoc.value=vl[1] + "/" + vl[2];
	}
}
//�����ĵ�Ԥ��
function previewDoc(){
	var docId = document.all.docId.value;
	if(docId!=""){
		channalForm.action="../docManage/previewPubDocHandle.jsp?docId="+docId;
		channalForm.target="exeman";
		channalForm.submit();
	}else{
		alert("����ѡ���ĵ���");
	}
}	
//ѡ��Ƶ��
function chooseChnl(){
	var re = openWin("../docManage/multi_channel_select_frame.jsp?siteid=<%=siteId%>&type=single&taskType=chnlIndexPage&siteid=",400,500);	
	if(re != undefined){
		var chnlInfo = re.split(":");
		var chnlId = chnlInfo[1].substring(0,chnlInfo[1].indexOf(","));
		var chnlName = chnlInfo[0].substring(0,chnlInfo[0].indexOf(";"));
		var chnlSiteId = chnlInfo[2].substring(0,chnlInfo[2].indexOf(","));
		if(chnlId != <%=channelId%>){ 
			document.all.chnlId.value = chnlSiteId + ":" + chnlId;
			document.all.chnlIndexChnl.value = chnlName;
		}else{
			alert("�Բ��𣬲���ѡ��ǰƵ����");
		}
	}
}
//Ƶ��Ԥ��
function previewChnl(){
	var chnlId = document.all.chnlId.value;
	var url = "../siteManage/siteview_do.jsp?siteId=" + chnlId.split(":")[0] + "&channelId=" +  chnlId.split(":")[1];
	var w = openWin(url,480,320);
}
//��Ƶ����ģ�巢���仯ʱ
//����Ƶ�����ĵ���ģ��
function updateTemplete(e){
    if(<%=hasOldDocument%>==true){//Ƶ���������ĵ�
        if(confirm("�Ƿ����Ƶ����,�̳и�Ƶ��ģ��������ĵ���ģ��")){
            var tmpleteId = e.value;
            var chnlId = "<%=channelId%>";
            var siteId = document.all.siteId.value;
            var path = "updateTemplete.jsp?tmpleteId="+tmpleteId+"&chnlId="+chnlId;
            window.open(path,"exeman","top=1025;left=1025;width=1;height=1");
        }
    }
}
</script>
</head>
<body bgcolor="#F7F8FC" onLoad="setFocus()">
	<form action="channel_edit_do.jsp" method="post" name="channalForm" target="exeman" id="channalForm">
		<input type="hidden" name="odisplayName" value="<%=chnl.getDisplayName()==null?"":chnl.getDisplayName()%>"/>
		<input type="hidden" name="oorder" value="<%=chnl.getOrderNo()%>"/>
		<input name="siteId" type="hidden" id="siteId" value="<%=siteId%>">
		<input name="parentChannelId" type="hidden" id="parentChannelId" value="<%=chnl.getParentChannelId()%>">
		<table width="100%" border="0" cellpadding="3" cellspacing="0" align="center">
			<tr>
				<td colspan="2" class="topDIV" align="left" valign="top">&nbsp;<div class="siteCTitle">�޸�Ƶ��</div>
				</td>
			</tr>
			<tr>
				<td width="4%" height="20" align="right">
					<img src="../images/ico_point.gif" width="25" height="25">
				</td>
				<td height="20" class="cms_title_blue">
					Ƶ��������Ϣ
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<tab:tabContainer id="foo-channel-add" selectedTabPaneId="foo-channel">
						<tab:tabPane id="foo-channel" tabTitle="������Ϣ">
							<table width="100%" border="0" cellpadding="3" cellspacing="0" class="Templateedittable">
								<tr>
									<td width="130" height="24" align="right" nowrap>
										����վ��:							</td>
									<td height="24">
										<%=siteName%>							</td>
								</tr>
								<tr>
									<td width="130" height="24" align="right" nowrap><!--Ϊ��Ƶ����ʾ������ȥ����·�����ƣ���ԭ����displayName��channelName���жԵ� -->
										Ƶ����������:							</td>
									
									<td height="24">
										<input type="text" id="displayName" name="displayName" class="cms_text" style="width:300px" maxlength="20" value="<%=chnl.getDisplayName() == null ? "" : chnl.getDisplayName()%>" /><span style="color: #FF0000">*����������ǰ̨���ã��벻Ҫ�����޸�</span>
									</td>
								</tr>
								<tr>
									<td width="130" height="24" align="right" nowrap>
										��ʾ����:							</td>
									<td height="24">
										<input type="text" id="channelName" name="channelName" class="cms_text" style="width:300px" maxlength="20" value="<%=chnl.getName() == null ? "" : chnl.getName()%>" />
										<input name="channelId" type="hidden" id="channelId" value="<%=channelId%>"><span style="color: #FF0000">*</span>
									</td>
								</tr>
								<tr>
									<td width="130" height="24" align="right" nowrap>
										Ƶ��·��:</td>
									<td height="24">
										<input type="text" id="channelPath" name="channelPath" class="cms_text" style="width:300px" maxlength="20" value="<%=chnl.getChannelPath() == null ? "" : chnl.getChannelPath()%>" readonly/><span style="color: #FF0000">*</span>	
									</td>
								</tr>
								<tr>
									<td width="130" rowspan="2" align="right" nowrap>��������:</td>
									<td height="24">
									<%
										String wfName = "";
										String wfId = "";
										if(!"".equals(channelId)){
											ChannelManager chnlMng = new ChannelManagerImpl();
											List workflowInfo = chnlMng.getFlowInfo(channelId);
											if(workflowInfo!=null && workflowInfo.size()>=2){
												if(workflowInfo.get(0)!=null && workflowInfo.get(1)!=null){
													wfName = workflowInfo.get(1).toString();
													wfId = workflowInfo.get(0).toString();
												}
											}
										}
										%>
											<input type="radio" name="workFlowFrom" value="0" checked onClick="changeWorkFlowType(0)">
										<%
										FlowManager fm = new FlowManagerImpl();
										List list = fm.getFlowList();
										%>
										<select id="workFlow" name="workFlow" class="cms_select" style="width:130px">
											<%= JSPFunc.getOption(list,"".equals(wfId)?"1":wfId) %>
										</select>
									</td>
								</tr>
								<tr>
									<td height="24">
										<input type="radio" name="workFlowFrom" value="1" onClick="changeWorkFlowType(1)">
										�̳�<%="".equals(parentChannelId)?"��վ��":"��Ƶ��"%>����������(<span style="color: #FF0000"><%=wfName%></span>)
									</td>
								</tr>
								<tr>
								<td width="130" height="24" align="right" nowrap>
									ר�ⱨ��:
								</td>
								<td height="24">
									<input name="specialflag" id="specialflag" type="checkbox" <%if(chnl.getSpecialflag()==1){out.print("checked");}%> > ����Ϊר�ⱨ��
								</td>
							</tr>
								<tr>
									<td width="130" height="24" align="right" nowrap>
										Ƶ�����е�˳��:
									</td>
									<td height="24">
										<input name="order" id="order" type="text" size="8"	maxlength="10" value="<%=chnl.getOrderNo() %>" class="cms_text">
									</td>
								</tr>
						  </table>
						</tab:tabPane>
						<tab:tabPane id="bar-channel" tabTitle="�����������">
							<fieldset>
								<LEGEND align=left><input type="radio" id="pubType" name="pubType" value="0" onClick="changePupType(0)"  <%=pageflag ==0?"checked":""%>/>��ģ�巢��	</LEGEND>
								<table width="100%" border="0" cellpadding="3" cellspacing="0">
									<tr>
										<td width="123" height="24" align="right" nowrap>�����ļ���:</td>
										<td height="24">
											<input type="text" id="pubFileName" name="pubFileName" class="cms_text" style="width:300px" maxlength="20" value="<%=pubFileName%>" <%=pageflag ==0?"":"disabled"%> />
										</td>
									</tr> 
									<tr>
										<td width="123" height="24" align="right" nowrap> ����ģ��:</td>
										<td height="24">
											<input name="outlineTemplateId" id="outlineTemplateId" type="hidden" value="<%=otId%>" />
											<input name="otName" id="otName" type="text" style="width:130px" value="<%=outlineTemplateName%>"  class="cms_text" disabled />
											<input class="Channel_5wordsBtn" type="button" value="ѡ ��" id="outlineTemplateChoice" name="outlineTemplateChoice" onClick="setChannelOutlineTemplateId()" <%=pageflag ==0?"":"disabled"%>>
											<input class="Channel_5wordsBtn" type="button" value="Ԥ ��" id="outlineTemplatePreview" name="outlineTemplatePreview" onClick="templatePreview(outlineTemplateId)" <%=pageflag ==0?"":"disabled"%>>
										</td>
									</tr>
							</table>
							</fieldset>
							<fieldset>
								<LEGEND align=left><input type="radio" id="pubType" name="pubType" value="1" onClick="changePupType(1)" <%=chnl.getPageflag()==1?"checked":""%>/>�Զ�����ҳ</LEGEND>
								<table border="0" cellpadding="3" cellspacing="0">
									<tr>
										<td width="123" height="24" align="right" nowrap>����Ƶ����ҳ:	</td>
										<td height="24">
											<input name="chnlIndexPage" type="text" class="cms_text" id="chnlIndexPage" style="width:200px"  value="<%=pageflag == 1?indexpagepath:""%>" maxlength="111"  <%=pageflag == 1?"":"disabled"%>/> 
											<input class="Channel_5wordsBtn" name="setChnlIndexPage" id="setChnlIndexPage" type="button" onClick="chooseChnlIndexPage('chnlIndexPage')" value="ѡ ��" <%=pageflag == 1?"":"disabled"%>>
										</td>	
									</tr> 
								</table>
							</fieldset>
							<fieldset>
								<LEGEND align=left><input type="radio" id="pubType" name="pubType" value="2" onClick="changePupType(2)" <%=chnl.getPageflag()==2?"checked":""%>/>�����ĵ���ҳ</LEGEND>
								<table border="0" cellpadding="3" cellspacing="0">
									<tr>
										<td width="123" height="24" align="right" nowrap>�����ĵ�:	</td>
										<td height="24">
											<input type="text" id="chnlIndexDoc" name="chnlIndexDoc" class="cms_text" style="width:200px" maxlength="111" value="<%=pageflag == 2?chnlName:""%>"  <%=pageflag == 2?"":"disabled"%>/> 
											<input class="Channel_5wordsBtn" name="setChnlIndexDoc" id="setChnlIndexDoc" type="button" onClick="chooseDoc()" value="ѡ ��" <%=pageflag == 2?"":"disabled"%>>
											<input type="hidden" id="docId" name="docId" value="<%=pageflag == 2?indexpagepath:""%>">
											<input class="Channel_5wordsBtn" name="previewChnlIndexDoc" id="previewChnlIndexDoc" type="button" onClick="previewDoc()" value="Ԥ ��" <%=pageflag == 2?"":"disabled"%>>
										</td>	
									</tr> 
								</table>
							</fieldset>
							<fieldset>
								<LEGEND align=left><input type="radio" id="pubType" name="pubType" value="3" onClick="changePupType(3)" <%=chnl.getPageflag()==3?"checked":""%>/>����Ƶ����ҳ</LEGEND>
								<table border="0" cellpadding="3" cellspacing="0">
									<tr>
										<td width="123" height="24" align="right" nowrap>����Ƶ��:	</td>
										<td height="24">
											<input type="text" id="chnlIndexChnl" name="chnlIndexChnl" class="cms_text" style="width:200px" maxlength="111" value="<%=pageflag == 3?chnlName:""%>"  <%=pageflag == 3?"":"disabled"%>/> 
											<input class="Channel_5wordsBtn" name="setChnlIndexChnl" id="setChnlIndexChnl" type="button" onClick="chooseChnl()" value="ѡ ��" <%=pageflag == 3?"":"disabled"%>>
											<input type="hidden" id="chnlId" name="chnlId" value="<%=pageflag == 3?indexpagepath:""%>">
											<input class="Channel_5wordsBtn" name="previewChnlIndexChnl" id="previewChnlIndexChnl" type="button" onClick="previewChnl()" value="Ԥ ��" <%=pageflag == 3?"":"disabled"%>>
										</td>	
									</tr> 
								</table>
							</fieldset>
							<fieldset>
								<LEGEND align=left>�����������	</LEGEND>
								<table width="100%" border="0" cellpadding="3" cellspacing="0" class="Templateedittable">
									<tr>
										<td width="130" height="24" align="right" nowrap> ϸ��ģ��: </td>
										<td height="24">
                                        <!-- add by ge.tao 2007/07/08 -->
                                        	<input name="detailTemplateId" id="detailTemplateId" type="hidden" value="<%=dtId%>" />
											<input name="dtName" id="dtName" type="text" style="width:130px" value="<%=detailTemplateName%>"  class="cms_text" disabled />
											<input class="Channel_5wordsBtn" type="button" value="ѡ ��" id="detailTemplateChoice" name="detailTemplateChoice" onClick="setChannelDetailTemplateId()" <%=pageflag ==0?"":"disabled"%>>
											<input class="Channel_5wordsBtn" type="button" value="Ԥ ��" onClick="templatePreview(detailTemplateId)">
										</td>
									</tr>
<!--									<tr>-->
<!--										<td width="130" height="24" align="right" nowrap> ����ģ��: </td>-->
<!--										<td height="24">-->
<!--										<select name="commentTemplateId" id="commentTemplateId" style="width:130px">-->
										<%
											//int ctp = chnl.getCommentTemplateId();
											//if(ctp==0)
											//	out.println("<option value=\"\" selected>��δ����,��ѡ�� </option>");
											//List templateList3 = tpltMng.getTemplateInfoListofSite(Integer.parseInt(siteId), 3);
											//for (int i = 0; templateList3 != null && i < templateList3.size(); i++) {
											//	Template t = (Template) templateList3.get(i);
											//	out.println("<option value=\"" + t.getTemplateId() + "\" " +
											//		(dtp==t.getTemplateId()?"selected":"") +
											//		" templatePath=\"" + t.getTemplatePath() + "\"  templateFileName=\"" + t.getTemplateFileName() + "\" >" + t.getName() + "</option>");
											//}
										%>
<!--										</select>-->
<!--										<input class="Channel_5wordsBtn" type="button" value="Ԥ ��" onClick="templatePreview(detailTemplateId)">-->
<!--									</tr>-->
									<tr>
										<td width="130" height="24" align="right" nowrap>
											�ĵ�����ҳ��:							
										</td>
										<td height="24">
											<input type="text" id="commentPagePath" name="commentPagePath" class="cms_text" style="width:200px" value="<%=chnl.getCommentPagePath()==null?"":chnl.getCommentPagePath()%>" /> 
											<input class="Channel_5wordsBtn" name="setCommentPagePath" id="setCommentPagePath" type="button" onClick="chooseChnlIndexPage('commentPagePath')" value="ѡ ��">
										</td>	
									</tr>
									<tr>
										<td width="130" height="24" align="right" nowrap>
											Ƶ����ҳ����ģʽ:							</td>
										<td height="24">
											<%int tpIsdy = chnl.getOutlineIsDynamic(); %>
											<input type="radio" name="outlineIsDynamic" value="0" <%=0==tpIsdy?"checked":"" %>>��̬
											<input name="outlineIsDynamic" type="radio" value="1" <%=1==tpIsdy?"checked":"" %>>��̬						</td>
									</tr>
									<tr>
										<td width="130" height="24" align="right" nowrap>
											Ƶ����ҳ���ܱ���:							</td>
										<td height="24">
											<%int tpIspt = chnl.getOutlineIsProtect(); %>
											<input type="radio" name="outlineIsProtect" value="0" <%=0==tpIspt?"checked":"" %>>���ܱ���
											<input name="outlineIsProtect" type="radio" value="1" <%=1==tpIspt?"checked":"" %>>
											�ܱ���							</td>
									</tr>
									<tr>
										<td width="130" height="24" align="right" nowrap>
											Ƶ���ĵ�����ģʽ:							</td>
										<td height="24">
											<%int docIsdy = chnl.getDocIsDynamic(); %>
											<input type="radio" name="docIsDynamic" value="0" <%=0==docIsdy?"checked":"" %>>��̬
											<input name="docIsDynamic" type="radio" value="1" <%=1==docIsdy?"checked":"" %>>��̬
											<input name="docIsDynamic" type="radio" value="2" <%=2==docIsdy?"checked":"" %>>��������
											</td>
									</tr>
									<tr>
										<td width="130" height="24" align="right" nowrap>
											Ƶ���ĵ��Ƿ��ܱ���:							</td>
										<td height="24">
											<%int docIspt = chnl.getDocIsProtect(); %>
											<input type="radio" name="docIsProtect" value="0" <%=0==docIspt?"checked":"" %>>���ܱ���
											<input name="docIsProtect" type="radio" value="1" <%=1==docIspt?"checked":"" %>>�ܱ���							</td>
									</tr>
									<tr id="outlinePictureInfo">
										<td width="130" height="24" align="right" nowrap>����ͼƬ:</td>
										<td height="24">
											<input name="outlinePicture" type="text" id="outlinePicture" size="10" value="<%=(chnl.getOutlinepicture()==null?"":chnl.getOutlinepicture())%>" style="width:200px" class="cms_text" readOnly>
											<input type="button"  onClick="chooseImage('outlinePicture')"  value="ѡ ��" class="Channel_5wordsBtn" >
										</td>
									</tr>
							  </table>
							</fieldset>
						</tab:tabPane>
						<tab:tabPane id="bar-channel-customForm" tabTitle="�Զ����">
							<table width="100%" border="0" cellpadding="3" cellspacing="0" class="Templateedittable">
								<tr>
									<td height="24" align="right">�����Զ����:</td>
									<td height="24">
										�����ĵ���<input name="add" type="text" style="width:200px" class="cms_text"  value="<%=cfm.getCustomFormFilename(channelId,"2","1")%>">
										<input name="CustomForm" type="button"  onClick="setCustomForm('add')"   value="ѡ ��" class="Channel_5wordsBtn" >
										<input name="CustomForm" type="button"  onClick="setDefault('add')"  value="ʹ��Ĭ��ֵ"  class="Channel_7wordsBtn" >
										<br>
										�޸��ĵ���<input name="update" type="text" style="width:200px" class="cms_text"  value="<%=cfm.getCustomFormFilename(channelId,"2","2")%>">
										<input name="CustomForm" type="button"  onClick="setCustomForm('update')"   value="ѡ ��" class="Channel_5wordsBtn" >
										<input name="CustomForm" type="button"  onClick="setDefault('update')"  value="ʹ��Ĭ��ֵ"  class="Channel_7wordsBtn" >
										<br>
										�ĵ��б��<input name="list" type="text" style="width:200px" class="cms_text"  value="<%=cfm.getCustomFormFilename(channelId,"2","3")%>">
										<input name="CustomForm" type="button"  onClick="setCustomForm('list')"   value="ѡ ��" class="Channel_5wordsBtn" >
										<input name="CustomForm" type="button"  onClick="setDefault('list')"  value="ʹ��Ĭ��ֵ"  class="Channel_7wordsBtn" >
									</td>
								</tr>
						  </table>
						</tab:tabPane>
						<tab:tabPane id="bar-channel-navg" tabTitle="����Ƶ������">
							<table width="100%" border="0" cellpadding="3" cellspacing="0" class="Templateedittable">
								<%boolean isNav = chnl.isNavigator();%>
								<tr>
									<td width="130" height="24" align="right" nowrap>Ƶ���Ƿ���Ϊ����Ƶ��</td>
									<td height="24">
										<input type="radio" name="isnavigator" value="0" <%=isNav?"":"checked"%> onClick="shownavigatorMoreInfo(false)">
										����
										<input name="isnavigator" type="radio" value="1" <%=isNav?"checked":""%> onClick="shownavigatorMoreInfo(true)">
										��
									</td>
								</tr>
								<tr id="navigatorMoreInfo1" <%=isNav?"":"style='display:none'" %>>
									<td width="130" height="24" align="right" nowrap>Ƶ����������</td>
									<td height="24"><input name="navigatorlevel" type="text" id="navigatorlevel" size="10" value="<%=chnl.getNavigatorLevel()%>" class="cms_text"></td>
								</tr>
								<tr id="navigatorMoreInfo2" <%=isNav?"":"style='display:none'" %>>
									<td width="130" height="24" align="right" nowrap >������ʱ��ͼƬ</td>
									<td height="24">
									<input name="mouseInImage" type="text" id="mouseInImage" size="10" value="<%=(chnl.getMouseInImage()==null?"":chnl.getMouseInImage())%>" style="width:200px" class="cms_text" readonly>
									<input type="button"  onClick="chooseImage('mouseInImage')"   value="ѡ ��" class="Channel_5wordsBtn" >
									</td>
								
								</tr>
								<tr  id="navigatorMoreInfo3" <%=isNav?"":"style='display:none'" %>>
									<td width="130" height="24" align="right" nowrap>����뿪ʱ��ͼƬ</td>
									<td height="24">
									<input name="mouseOutImage" type="text" id="mouseOutImage" size="10" value="<%=(chnl.getMouseOutImage()==null?"":chnl.getMouseOutImage())%>" style="width:200px" class="cms_text" readonly>
									<input type="button"  onClick="chooseImage('mouseOutImage')"   value="ѡ ��" class="Channel_5wordsBtn" >
									</td>
								</tr>
								<tr  id="navigatorMoreInfo4" <%=isNav?"":"style='display:none'" %>>
									<td width="130" height="24" align="right" nowrap>�����ʱ��ͼƬ</td>
									<td height="24">
									<input name="mouseClickImage" type="text" id="mouseClickImage" size="10" value="<%=(chnl.getMouseClickImage()==null?"":chnl.getMouseClickImage())%>" style="width:200px" class="cms_text" readonly>
									<input type="button"  onClick="chooseImage('mouseClickImage')"   value="ѡ ��" class="Channel_5wordsBtn" >
									</td>
								</tr>
								<tr  id="navigatorMoreInfo5" <%=isNav?"":"style='display:none'" %>>
									<td width="130" height="24" align="right" nowrap>��굯��ʱ��ͼƬ</td>
									<td height="24">
									<input name="mouseUpImage" type="text" id="mouseUpImage" size="10" value="<%=(chnl.getMouseUpImage()==null?"":chnl.getMouseUpImage())%>" style="width:200px" class="cms_text" readonly>
									<input type="button"  onClick="chooseImage('mouseUpImage')"   value="ѡ ��" class="Channel_5wordsBtn" >	
									</td>
								</tr>
						  </table>
						</tab:tabPane>
					</tab:tabContainer>
				</td>
			</tr>
	  </table>
		<br>
		<div style="text-align:center">
			<INPUT name="button" type="button" class="cms_button" onClick="checkForm()" value="����">
			&nbsp;&nbsp;&nbsp;
			<INPUT name="button" type="button" class="cms_button" onClick="window.close()" value="�ر�">
			<br><br><br>
		</div>
	</form>
	<iframe name="exeman" width="0" height="0" style="display:none"></iframe>
</body>
</html>
