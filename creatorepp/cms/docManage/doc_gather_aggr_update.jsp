<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>
<%@page import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.templatemanager.*
,com.chinacreator.cms.container.Template,com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.security.AccessControl,java.util.List"%>
<%@page import="com.chinacreator.cms.channelmanager.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    String userid = accesscontroler.getUserID();
    
	String docid = request.getParameter("docid");
	String channelname = request.getParameter("channelName");
	String siteid = request.getParameter("siteid");
	String channelId = request.getParameter("channelId");
	DocumentManager dmi = new DocumentManagerImpl();
	
	ChannelManager cm = new ChannelManagerImpl();
	//��ǰʱ��
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date currentTime = new java.util.Date(); 
	String riqi = formatter.format(currentTime);

	//��ȡ��ѡƵ����ϸ��ģ��ID
	
	 //�ڷ����ĵ��༭ʱ����rebound�������ʱ����audit����������Ϊ��(�����ĵ���������id��)
   	String flag =  request.getParameter("flag");
   	int taskid = 0;
   	String taskidStr="";
   	if(flag!=null && flag.equals("rebound")){
   		taskid = dmi.hasTask(Integer.parseInt(userid),Integer.parseInt(docid),2);
   	}
   	else if(flag!=null && flag.equals("audit")){
   		taskid = dmi.hasTask(Integer.parseInt(userid),Integer.parseInt(docid),1);
   		taskidStr = request.getParameter("taskidStr");
   	}
	
	Document document = dmi.getDoc(docid);
	String status = String.valueOf(document.getStatus());
	SiteManager siteManager = new SiteManagerImpl();
	String sitename = siteManager.getSiteInfo(siteid).getName();
	
	//String docsource = String.valueOf(document.getDocsource_id());
	String docsource = document.getDocsource_name();
	
	
	String tid = String.valueOf(document.getDetailtemplate_id());
	String doc_level_id = String.valueOf(document.getDoc_level());
	
	
	//�ĵ���Դ��ʼ
   String idstr="";
   String srcnamestr="";
   String orasrcnamestr="";
   List dslist=null;
   DocumentSource ds=new DocumentSource();
   dslist=dmi.getDocSourceList();
   
   orasrcnamestr = docsource ;
   
   
   if(dslist.size()>0)
   {
   
    for(int i=0;i<dslist.size();i++)
    {
       ds=(DocumentSource)dslist.get(i);
        //if(docsource.equals(String.valueOf(ds.getDocsource_id())))
        //{
        //orasrcnamestr=ds.getSrcname();
        //}
        
        if(idstr!="")
        {
        	idstr=idstr+","+ds.getDocsource_id();
	        srcnamestr=srcnamestr+"&"+ds.getSrcname();
        }
        else
        {
        	idstr=String.valueOf(ds.getDocsource_id());
	        srcnamestr=ds.getSrcname();
        }
    }
    
   }

	//get�ĵ�������ĵ�����Ϣ
	String partId = "";
	String partName = "";
	String partTitle = "";
	String partChlName = "";//Ƶ������
	String[] doclists =  dmi.getAggrDocList2Str(docid);
	for(int i=0;i<doclists.length;i++)
	{
		String[] tem = doclists[i].split("��");
		partId += tem[0] + "��";
		partName += tem[1] + "��";
		partTitle += tem[2] + "��";
		partChlName += tem[3] + "��";
	}
%>
<%!/**
   * ���HTML�������ַ�ת��
   * @param value String
   * @return String
   */
  String filterStr(String value) {
    if (value == null) {
      return (null);
    }
    char content[] = new char[value.length()];
    value.getChars(0, value.length(), content, 0);
    StringBuffer result = new StringBuffer(content.length + 50);
    for (int i = 0; i < content.length; i++) {
      switch (content[i]) {
        case '<':
          result.append("&lt;");
          break;
        case '>':
          result.append("&gt;");
          break;
        case '&':
          result.append("&amp;");
          break;
        case '"':
          result.append("&quot;");
          break;
        case '\'':
          result.append("&#39;");
          break;
        case '\\':
          result.append("\\\\");
          break;
        default:
          result.append(content[i]);
      }
    }
	return (result.toString());
  }
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<link href="<%=request.getContextPath()%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="<%=request.getContextPath()%>/cms/inc/js/func.js"></script>
<script src="<%=request.getContextPath()%>/cms/inc/js/killerror.js"></script>
<style type="text/css">
<!--
	.STYLE7 {color:#003398; font-size: 12px;}
	#Layer1 {
		position:absolute;
		left:0px;
		top:0px;
		width:113px;
		height:127px;
		z-index:1;
	}
	.STYLE9 {color: #FF6600}

-->
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>CMS �ĵ�����</title>
</head>
<script language="javascript">
	//�������ڶ���
	var win = null;
	//�رն�������
	function closewin()
	{
		win.close();
	}
	//ѡ��newͼ���ļ�
	function setImage(uri){
		document.all("newpicpath").value  = uri;
	}
	//ѡ��newͼ���ļ�
	function choosenewpic()
	{
		openWin("<%=request.getContextPath()%>/cms/channelManage/chooseImageFrameset.jsp?fileFlag=pic",620,580);
	}
	//վ�㴰���������У��
	function saveform(closeFlag){
	if(!confirm('��ȷ��Ҫ�޸��ĵ���?'))
	{
	return;
	}
	var inputsource=document.all.inputdocsource.value;
	
		var title = myform.title.value ;
		if(title.length < 1 || title.replace(/\s/g,"") == "")
		{
			alert("�������ĵ�����!");
			document.all.auditorDiv.innerHTML="";
			document.all.publisherDiv.innerHTML="";
			myform.title.focus();
			return false;
		}
		
		if(title.length > 400)
		{
			alert("�ĵ�����ĳ��Ȳ��ܴ���400");
			return false ;
		}
		
		if(inputsource==null||inputsource=="")
		{
			alert('��ѡ�������д�ĵ���Դ');
		  	document.all.inputdocsource.focus();
		  	return false;
		}
		else{
			//�ж��Ƿ��¼ӵ��ĵ���Դ��������
			//if(inputsource!=document.all.docsource_id.options(document.all.docsource_id.selectedIndex).text)
			//document.all.isnewdocsource.value="1";
			
			if(document.all.docsource_id.value.length<1)
		    {
				document.all.isnewdocsource.value="1";
			}
			
			//myform.subtitle.value = myform.title.value;
			//ȡ����ĵ��б�
			var arr = docxz.document.getElementsByName("docid");
			var arr2 = docxz.document.getElementsByName("aggrtitle");
			for(var i=0;i<arr.length;i++)
			{
				myform.doclist.value += arr[i].value +"��";
				myform.titles.value += arr2[i].value +"��";
			}
			if(document.all.selecttpl[1].checked)
				myform.parentDetailTpl.value = "1";
			else
				myform.parentDetailTpl.value = "0";
			
			myform.subtitle.value = myform.title.value;	
			
			myform.method="post";
			myform.target = "updateaggr";
			myform.action="<%=request.getContextPath()%>/cms/docManage/update_document.jsp?closeFlag=" + closeFlag;
			win = window.open("<%=request.getContextPath()%>/cms/doing.html","doinghtml","height="+(screen.availHeight-200)+",width="+(screen.availWidth-300)+",top=100,left=150,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,status=no");
			myform.submit();
			var buttons = document.getElementsByTagName("input");
			for(var i=0;i<buttons.length;i++)
			{
				buttons[i].disabled = true;
			}
		}
	}	
	//����
	function back() {
		window.close();
	}
	//������ڵ�һ��text
	function init(){
		myform.title.focus();
	}
	//�����ͣ���ı������ֵ����
	function focusend() 
	{ 
		var e = event.srcElement; 
		var r =e.createTextRange(); 
		r.moveStart("character",e.value.length); 
		r.collapse(true); 
		r.select(); 
	}
	//��ʼ������ĵ�table�������
	function initRelatedDoc()
	{
		var part_id = "<%=partId%>";
		var part_name = "<%=filterStr(partName)%>";
		var part_title = "<%=filterStr(partTitle)%>";
		var part_chlName = "<%=partChlName%>";
		
		if(part_id!=""&&part_name!="")
		{
			var ids = new Array();
			var names = new Array();
			var titles = new Array();
			var chlNames = new Array();
			ids = part_id.split("��");
			names = part_name.split("��");
			titles = part_title.split("��");
			chlNames = part_chlName.split("��");
			var tableatt = docxz.document.all("chndoclist");
			for(var i=0;i<ids.length-1;i++)
			{
				var row1 = tableatt.insertRow(i+1);
				var td1 = docxz.document.createElement("td");
				var td2 = docxz.document.createElement("td");
				var td3 = docxz.document.createElement("td");
				var td4 = docxz.document.createElement("td");
				var td5 = docxz.document.createElement("td");

				td1.innerHTML="<input type='checkBox' name='id' value="+(i+1)+" hideFocus=true onclick='checkOne(id)'/>";		 
				var docid = "<input type='hidden' name='docid' value='"+ids[i]+"' />";
				//var channelId = "<input type='hidden' name='channelId' value='"+obj[1]+"' />";
				td2.innerHTML = docid + names[i];
				td3.innerHTML = chlNames[i];
				td4.innerHTML = "<input type='text' name=aggrtitle value="+titles[i]+" />";
				var up = "<a href='#' onclick='upRow(this)'><u>����</u></a>&nbsp;";
				var down = "<a href='#' onclick='downRow(this)'><u>����</u></a>";
				td5.innerHTML = up + down;
				row1.appendChild(td1);
				row1.appendChild(td2);
				row1.appendChild(td3);
				row1.appendChild(td4);
				row1.appendChild(td5);
			}
		}
	}
	//��ʼ�����table
	function document.onreadystatechange()
	{
		if (document.readyState!="complete") 
			return;
		initRelatedDoc();
	}
	function publishPreview(){
		myform.method="post";
		myform.action="<%=request.getContextPath()%>/cms/docManage/previewPubDocHandle.jsp?docId=<%=docid%>";
		myform.submit();
	}
	function seeAdvice(channelId,docid,taskid){
		openWin("<%=rootpath%>/cms/docManage/see_audit_advice.jsp?channelId=<%=channelId%>&docid=<%=docid%>&taskid=<%=taskid%>" ,400,550);
	}
	function delive(){
		saveform("0");
		//flagΪ1��ʾ�¸��ĵ��ĳ���,Ϊ2��ʾ�����ĵ��ĳ���
		openWin("<%=rootpath%>/cms/docManage/doc_AuditorList.jsp?flag=2&channelId=<%=channelId%>&docid=<%=docid%>&taskid=<%=taskid%>");
		var str = window.dialogArguments.location.href;
		var end = str.indexOf("?");
		var strArray;
		if(end != -1)
			strArray= str.slice(0,end);
		else
			strArray = str;
		window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
		window.close();
	}
	function agree(){
		var re;
		//����auditFlagΪ��������0��ͬ�⣬1��ͬ��
		re = openWin("<%=rootpath%>/cms/docManage/audit_add_comment.jsp?idStr=<%=taskidStr%>&auditFlag=1",400,550);
		if(re == "cf"){ 
			var str = window.dialogArguments.location.href;
			var end = str.indexOf("?");
				var strArray;
				if(end != -1)
					strArray= str.slice(0,end);
				else
					strArray = str;
			window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
			window.close();
		}
	}
	function disagree(){
		var re;
		var addComment = window.confirm("Ҫ������������");
		if(addComment==false){
			re = "cf";
			myform.method="post";
			//����auditFlagΪ��������0��ͬ�⣬1��ͬ��
			myform.action = "<%=rootpath%>/cms/docManage/auditDocHandle.jsp?idStr=<%=taskidStr%>&auditFlag=0";
			myform.submit();
		}
		else{
			re = openWin("<%=rootpath%>/cms/docManage/audit_add_comment.jsp?idStr=<%=taskidStr%>&auditFlag=0",400,550);
		}
		if(re == "cf"){
			var str = window.dialogArguments.location.href;
			var end = str.indexOf("?");
				var strArray;
				if(end != -1)
					strArray= str.slice(0,end);
				else
					strArray = str;
			window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
			window.close();	
		}
	}
	function changSelect(o)
	{
	   document.all.inputdocsource.value=document.all.docsource_id.options(document.all.docsource_id.selectedIndex).text;
	   document.all.inputdocsource.focus();
	   document.all.inputdocsource.select();
	}
	//��Ӧrodio�¼�
	function changtpl(type)
	{
		if(type==0)
			document.all.detailtemplate_id.disabled = false;
		else
			document.all.detailtemplate_id.disabled = true;
	}
	//Ԥ��ģ��
	function preview()
	{
		var tplId = document.all.detailtemplate_id.value;
		window.open("<%=request.getContextPath()%>/cms/templateManage/template_previewbyid.jsp?tplId=" + tplId + "&siteId=<%=siteid%>");
	}	
	
	
	//�����ĵ���Դ
	var myarray=new Array();
	var myarrayid=new Array();
	var srcnameadd='<%=srcnamestr%>';
	var srcnameidadd='<%=idstr%>'
	myarray=srcnameadd.split('&');
	myarrayid=srcnameidadd.split(',');
	function selectvalue(selectstr,selectid)
	{
		
	  document.getElementById("inputdocsource").value=selectstr;
	  document.all.isnewdocsource.value="0";
	  document.all.ischecksource.value='1';
	  document.all.docsource_id.value=selectid;
	  
	  divhidden();
	  
	}
	function divShow() { 
	var tt=document.getElementById("inputdocsource");
	var  ttop    =  tt.offsetTop;          //TT�ؼ��Ķ�λ���  
	var  thei    =  tt.clientHeight;    //TT�ؼ�����ĸ�  
	var  tleft  =  tt.offsetLeft;        //TT�ؼ��Ķ�λ��� 
	 var d=document.getElementById("id1");
	while  (tt  =  tt.offsetParent){ttop+=tt.offsetTop;  tleft+=tt.offsetLeft;}
	 d.style.display="block";
	 d.style.pixelLeft=tleft+1;
	 d.style.pixelTop=ttop+thei+4;
	 
	} 
	function divhidden()
{

var mydiv1=document.getElementById("id1");
mydiv1.style.display="none";

}
var initsearch='true';
function initdiv1()
{
if(initsearch=='true'){
var mydiv1=document.getElementById("id1");
var str='<table width=120 border=0 cellpadding=1 cellspacing=1 bgcolor=#006699>';
var sr='';
 for(var i=0;i<myarray.length;i++)
{
 sr=sr+' <tr style="cursor:hand" onClick=\"selectvalue(\''+myarray[i]+'\',\''+myarrayid[i]+'\')\"><td bgcolor=#FFFFFF height=22>&nbsp;'+myarray[i]+'</td></tr>';
}
str=str+sr+'</table>';
mydiv1.innerHTML=str;
mydiv1.style.height=(myarray.length)*24+"px";
divShow();

}
else
{
initdiv();
}
}
function initdiv()
{
//���Ի�div
var t=document.getElementById("inputdocsource").value;
if(t.length<1){
var mydiv1=document.getElementById("id1");
mydiv1.style.height="300px";
var str='<table width=120 border=0 cellpadding=1 cellspacing=1 bgcolor=#006699>';
var sr='';
 for(var i=0;i<myarray.length;i++)
{
 sr=sr+' <tr style="cursor:hand" onClick=\"selectvalue(\''+myarray[i]+'\',\''+myarrayid[i]+'\')\"><td bgcolor=#FFFFFF height=22>&nbsp;'+myarray[i]+'</td></tr>';
}
str=str+sr+'</table>';
mydiv1.innerHTML=str;
divShow();
}
else
{
  changdiv();
}
}
function divHide(d) { 
var d=document.getElementById("id1");
if(d.style.display=='block')
 d.style.display="none";
} 
function changdiv()
{
initsearch='false';
if(document.all.ischecksource.value!='1'){
document.all.ischecksource.value='0';
document.all.docsource_id.value="";
}
var t=document.getElementById("inputdocsource").value;
if(t.length<1)
{
   initdiv();
}
else
{
//�����
   divShow();
   var patternstr=t;
   var mydiv=document.getElementById("id1");
   var sr='';
   var divstr='';
   var count=0;
   var count_1 = 0;
   for(var i=0;i<myarray.length;i++)
   {
   if(myarray[i].match(patternstr)!=null)
   {
	 sr=sr+' <tr style="cursor:hand"  onClick=\"selectvalue(\''+myarray[i]+'\',\''+myarrayid[i]+'\')\"><td bgcolor=#FFFFFF height=22>&nbsp;'+myarray[i]+'</td></tr>';
	 count=1;
	 count_1++;
   }
   }
   if(count==1)
   {
     divstr='<table width=120 border=0 cellpadding=1 cellspacing=1 bgcolor=#006699>'+sr+'</table>'; 
   }
   else
   {
    divstr='<table width=120 border=0 cellpadding=1 cellspacing=1 bgcolor=#006699><tr><td bgcolor=#FFFFFF height=22>&nbsp;û�и�Դ</td></tr></table> ';
   }
   mydiv.style.height=count_1*24+"px";
   mydiv.innerHTML=divstr;
}
}  
</script>
<script type="text/javascript" src="<%=request.getContextPath()%>/public/datetime/calender.js" language="javascript"></script>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<base target="_self">
<body  bottommargin="0"   bgcolor="#F3F4F9"  onkeydown="if(event.keyCode==116){reload.click()}" rightmargin="0" leftmargin="0" topmargin="0" onload="init()">
<script language="javascript">
	document.write("<a id='reload' href='" + document.location.href + "' style='display:none'>reload...</a>");
</script>
<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
<form target="updatelinks" action="update_document.jsp" method="post"  name="myform">
	<input name="doctype" value="3" type=hidden><!--�ۺ��ĵ�-->
   	<input name="docid" value="<%=docid%>" type=hidden>
	<input name="siteid" value="<%=siteid%>" type=hidden>
  	<input name="channelName" value="<%=channelname%>" type=hidden>
  	<input name="channelId" value="<%=channelId%>" type=hidden>
	<input type="hidden" name="titlecolor" value="<%=document.getTitlecolor()%>" /><!--������ɫ-->
	<input name="subtitle" type="hidden" value="<%=document.getSubtitle()%>"/><!--��ʾ����-->
	<input name="author" value="����" type="hidden"/><!--����-->
	<input name="isnewdocsource" value="0" type="hidden"><!--�Ƿ��¸�Դ-->
	<!--input name="detailtemplate_id" type="hidden"/><!--����ģ��-->
	<input name="content" type="hidden"/><!--content-->
	<!--  <input type="hidden" name="parentDetailTpl" value="1"/>-->
	<input type="hidden" id="ischecksource">
	<input type="hidden" id="docsource_id" name="docsource_id" value="<%=docsource%>">
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
			            		<tr>
					            	<td height="47" colspan="3" valign="top" background="<%=request.getContextPath()%>/cms/images/top_tile_short.jpg">
					            		<table width="100%" border="0" cellpadding="0" cellspacing="0">
					            			<tr>
					                  			<td width="200"><img src="<%=request.getContextPath()%>/cms/images/logo.jpg" width="200" height="50" /></td>
					                		    <td>���ݱ༭ [<%=sitename%> վ��  :  <%=channelname%> Ƶ��]</td>
					            			    <td width="53"><img src="<%=request.getContextPath()%>/cms/images/Gather_top_LeftDot.jpg" width="174" height="50" /></td>
					            			</tr>
					              		</table>				            	  </td>
					            </tr>
			            		<tr>
					            	<td height="18" colspan="3">
					            		<table width="100%" border="0" cellpadding="0" cellspacing="0">
					                		<tr background="<%=request.getContextPath()%>/cms/images/Gather_Content_topbg.gif">
					                  			<td width="4%" height="35" align="right" background="<%=request.getContextPath()%>/cms/images/Gather_Content_topbg.gif"><img src="<%=request.getContextPath()%>/cms/images/ico_point.gif" width="25" height="25"></td>
					                  			<td class="cms_title_blue">
					                  				<table width="100%" border="0" cellpadding="0" cellspacing="0" background="<%=request.getContextPath()%>/cms/images/Gather_Content_topbg.gif">
					                      				<tr>
					                        				<td width="100" height="35" class="cms_title_blue">�ĵ���Ϣ��д</td>
					                        				<td><div style="text-align:right">(<span class="red_star">*</span> 
						                        				Ϊ������
						                        				<img src="<%=request.getContextPath()%>/cms/images/tan.gif" width="11" height="11">)</div></td>
					                      				</tr>
				                    			  </table>				                    		  </td>
				                		  </tr>
							                <tr>
							                	<td height="26">&nbsp;</td>
							                  	<td>
							                  		<table border="0" cellpadding="0" cellspacing="0">
									                    <tr>
									                    	<td align="right"><strong>�ĵ�����:</strong></td>
									                      	<td>
										                      	<div align="center">
								                      		<img src="<%=request.getContextPath()%>/cms/images/doc_aggr.gif" width="20" height="20">										                      	</div>									                      	</td>
									                      	<td>�ۺ��ĵ�</td>
								                      </tr>
						                  		  </table>							                    </td>
							                </tr>
							                <tr>
							                	<td height="26">&nbsp;</td>
							                  	<td height="23"><strong>���ӱ���:
							                  		<span class="cms_title_blue">
								                    	<label>						                    		</label>
							                  		</span></strong><span class="cms_title_blue"><label>
							                  		<input name="title" type="text" class="cms_text" size="60" value="<%=document.getTitle()%>" onfocus="focusend()">
								                    	</label>
							                  		</span>
						                  		  <span class="STYLE7">
							                  			<label>
							                  				<span class="red_star">*</span>							                  			</label>
						                  		  </span>
							                  		&nbsp;&nbsp;
							                  		
							                  		<!-- 
														<span>
						                  					<span class="black">
						                  						<span class="STYLE7">
						                  							<span class="red_star">
						                  								<span class="cms_title_blue">
						                  								<input type="text" style="width:100px;height:21px;font-size:10pt;" id="inputdocsource" name="inputdocsource"><span style="width:18px;border:0px solid red;">
						                  								<select name="docsource_id"  style="margin-left:-100px;width:118px;" onChange="changSelect(this)" id="docsource_id">
						                										<%
														                        //  List dslist=null;
																			      //DocumentManagerImpl dmimpl=new DocumentManagerImpl();
																			      //dslist=dmimpl.getDocSourceList();
																				  //request.setAttribute("dslist",dslist);
																				%>
												  								<pg:list requestKey="dslist">
																					<option value="<pg:cell colName="docsource_id"/>"  
																						<pg:equal colName="docsource_id" value="<%=docsource%>">selected</pg:equal>>
																					 	<pg:cell colName="srcname" defaultValue="" />
																				 	</option>
																				</pg:list>
						                    								</select>
						                    								</span>
						                  								</span>						                  							</span>						                  						</span>						                  					</span>						                  				</span>
						                  			</span>											 
						                  			-->
						                  			
						                  			<label>
														<strong>�ĵ���Դ:</strong>
													</label>
													<span class="cms_title_blue"> 
														<input type="text" style="width:120px;height:21px;font-size:10pt;" id="inputdocsource" name="inputdocsource" onMouseOver="initdiv1()"
																 onpropertychange="changdiv()" onMouseOut="divhidden()" value="<%=orasrcnamestr%>">
														<div id="id1" STYLE="position:absolute;display:none;z-index:100;background: #fff; overflow-y:scroll; width:100px; height:300px" 
																	onmouseover="divShow()" onMouseOut="divhidden()"></div>
													    <span class="red_star">*</span> 
													</span>	
													
						                  		</td>
							                </tr>
							               
					                		<tr>
							                	<td height="26">&nbsp;</td>
							                  	<td height="23" colspan="2">
							                  		<label>
											  			<strong>���ʱ��:</strong>										  			<span class="black">
											  				<span class="cms_title_blue">
																<input name="docwtime" type="text" dateformat="yyyy-MM-dd HH:mm:ss" size="23" onpropertychange="ordertime.value=this.value"
																			class="cms_text" value="<%=riqi%>" size="22">
																<input type="button" class="Channel_5wordsBtn" value="ʱ��" onclick="showdatetime(document.all('docwtime'))">
															</span>
														</span>													</label>
													&nbsp;&nbsp;&nbsp;&nbsp;
													����:
													<span class="cms_title_blue">
														<select name="doc_level" class="cms_select">
															<%
															  List doclevellist = null;
															  DocumentManager impl = new DocumentManagerImpl();
															  doclevellist = impl.getDocLevelList();
															  request.setAttribute("doclevellist",doclevellist);
															%>
															<pg:list requestKey="doclevellist">
																<option value="<pg:cell colName="id"/>"<pg:equal colName="id" value="<%=doc_level_id%>">selected</pg:equal>>
																<pg:cell colName="name"/> 
															</pg:list>
														</select>
&nbsp;												  </span>
											  		</td>
							                </tr>
							                <tr>
							                	<td height="26">&nbsp;</td>
												<td height="23" colspan="2">
													<strong>����ʱ��:</strong>
							                  		<span class="black">
														<span class="cms_title_blue">
														<%
														    String ordertime = "";
														    if(document.getOrdertime() != null) {
														        ordertime = formatter.format(document.getOrdertime());
														    }else if(document.getDocwtime() != null){
														        ordertime = formatter.format(document.getDocwtime());
														    }
														%>
															<input name="ordertime" type="text" class="cms_text" value="<%=ordertime%>" size="23">
														</span>
													</span>
													<input type="button" class="Channel_5wordsBtn" value="ʱ��" onClick="showdatetime(document.all('ordertime'))">
		                   				   		</td>
							                </tr>
							                <tr height="23">
							                <td>&nbsp;</td>
							                <td colspan="3"><strong>����ģ��:</strong>
							                <span class="cms_title_blue">
																			<input type="radio" name="selecttpl" value="0" checked="true" onClick="changtpl(0)">
																			<select name="detailtemplate_id" class="cms_select" style="width:130px">
																				<%
																				  List list=null;
																				  TemplateManager tmi=new TemplateManagerImpl();
																				  Template template=new Template();
																				  list=tmi.getTemplateInfoListofSite(Integer.parseInt(siteid), 2);
																				  request.setAttribute("tpllist",list);
																				%>
																				<pg:list requestKey="tpllist">
																					<option value="<pg:cell colName="templateId"/>"<pg:equal colName="templateId" value="<%=tid%>">selected</pg:equal>>
																					<pg:cell colName="name"/> 
																				</pg:list>
																			</select>
																			
																		</span>		
							               
							                
							                <input type="radio" name="selecttpl" value="1" onClick="changtpl(1)">
																		<input type="hidden" name="parentDetailTpl"/>
																		<%
																		ChannelManager chnl = new ChannelManagerImpl();
																		Template tp = chnl.getDetailTemplateOfChannel(channelId);
																		String tname = (tp==null?"��û������":tp.getName());
																		%>
																		�̳�����Ƶ����ϸ��ģ��(<span class="red_star"><%=tname%></span>)	  <a href="#" onClick="preview()" ><u>Ԥ��</u></a>	
							                </td>
							                </tr>
											<tr>
												<td height="26">&nbsp;</td>
												<td colspan="3">
													<strong>�Ƿ���Ϊnew:</strong>&nbsp;&nbsp;
													<input type="checkbox" hideFocus name="isnew" value="1" <%if(document.getIsNew()==1)out.print("checked");%> class="cms_text"/>&nbsp;&nbsp;
													<input type="text" name="newpicpath" value="<%=document.getNewPicPath()%>" class="cms_text" readonly size="30"/>
													<input type="button" class="Channel_5wordsBtn" name="default" onClick="document.all('newpicpath').value='image/new.gif'" value="ʹ��Ĭ��ֵ"/>
													<input type="button" class="Channel_7wordsBtn" name="addnewpic" onClick="choosenewpic()" value="ѡ��newͼ��"/>
												</td>
											</tr>
							                <tr>
							                	<td height="26">&nbsp;												</td>
											  <td><strong>ժҪ����:</strong>												  <textarea name="docabstract" cols="70" rows="5" class="cms_textarea"><%=document.getDocabstract()%></textarea></td>
							                </tr>
											<tr>
							                	<td height="26">&nbsp;												</td>
											  <td><strong>�� �� ��:</strong>
											  <textarea name="keywords" cols="70" rows="5" class="cms_textarea"><%=document.getKeywords()%></textarea></td>
							                </tr>
					                		<tr>
												<td height="26">&nbsp;</td>
												<td height="23" colspan="2">
													<!--<img align=absMiddle border=0 height=12 src="../images/text-correlated.gif" width=14 >
													<a id=tab2 href="#" onclick=tabClick(2) ><u>[����ĵ�]</u></a>-->												</td>
									        </tr>
				              		  </table>					              	</td>
					            </tr>
			            		
								<tr>
									<td  width="95%" height="22" colspan="3"  align="center" valign="top">
										<div>

											<input type="hidden" name="doclist">
											<input type="hidden" name="titles">
											<br/><iframe id="docxz" src="<%=request.getContextPath()%>/cms/channelManage/chn_doc_xzlist.jsp?flag=11&siteid=<%=siteid%>" frameborder="0" scrolling="auto" width="95%" height="300">
											</iframe>
										</div>									</td>
								</tr>
								<tr>
									<td  height="23">
										<div align="center">
											<%if(flag!=null && flag.equals("rebound")){%>
						                  		<input name="button" type="button" onclick="seeAdvice();" class="cms_button"  value="�鿴���">&nbsp;<input name="button" type="button" onclick="delive();" class="cms_button"  value="����">
						                  	<%}else if(flag!=null && flag.equals("audit")){%>
						                  		&nbsp;<input name="button" type="button" onclick="agree();" class="cms_button"  value="ͨ��">
						                  		<input name="button" type="button" onclick="disagree();" class="cms_button"  value="�˻�">
						                  	<%}else{%>
						                    	&nbsp;<input name="button" type="button" onclick="saveform(1);" class="cms_button"  value="����">
												<%
											}%>
											&nbsp;<input type="button" value="����" class="cms_button" onclick="back()">
										</div>									</td>
								</tr>
								<tr><td colspan="4">&nbsp;</td></tr>
								<tr><td colspan="4">&nbsp;</td></tr>
			            		<!--��Դ�ڱ����վ���и�վ��-->
  </table> 
   <script type="text/javascript">
  document.all.inputdocsource.value=document.all.docsource_id.options(document.all.docsource_id.selectedIndex).text;
  </script>  
</form>
<div style="display:none">
	<iframe name="updateaggr" width="0" height="0"></iframe>
</div>
</body>
</html>