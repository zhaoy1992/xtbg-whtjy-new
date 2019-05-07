<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List,java.util.Date,java.text.SimpleDateFormat,java.util.StringTokenizer"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.sitemanager.*,com.chinacreator.cms.templatemanager.*,com.chinacreator.cms.container.Template,com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.cms.channelmanager.*"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.frameworkset.common.poolman.DBUtil"%>
<%response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", -1);
			response.setDateHeader("max-age", 0);

			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);
			String userid = accesscontroler.getUserID();
			//��ǰʱ��
			java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(
					"yyyy-MM-dd HH:mm:ss");
			java.util.Date currentTime = new java.util.Date();
			String riqi = formatter.format(currentTime);

			String channelname = request.getParameter("channelName");
			String siteid = request.getParameter("siteid");
			String channelId = request.getParameter("channelId");

			SiteManager siteManager = new SiteManagerImpl();
			String sitename = siteManager.getSiteInfo(siteid).getName();

			String idstr = "";
			String srcnamestr = "";
			List dslist = null;
			DocumentManager dmi = new DocumentManagerImpl();
			DocumentSource ds = new DocumentSource();
			dslist = dmi.getDocSourceList();
			if (dslist.size() > 0) {

				for (int i = 0; i < dslist.size(); i++) {
					ds = (DocumentSource) dslist.get(i);
					if (idstr != "") {
						idstr = idstr + "," + ds.getDocsource_id();
						srcnamestr = srcnamestr + "&" + ds.getSrcname();
					} else {
						idstr = String.valueOf(ds.getDocsource_id());
						srcnamestr = ds.getSrcname();
					}
				}

			}
			
			String orgName = "" ;
		    if(accesscontroler.getChargeOrg() != null)
		    {
		    	orgName = accesscontroler.getChargeOrg().getRemark5();
		    }
			
			//��ȡ��һ���ĵ�����Ϣ�磺�ĵ���Դ 
		   String docSourceName = orgName;
		   String docSourceId = "";
   
		   try{
			   DBUtil db = new DBUtil();
			   //String sql = "select a.DOCSOURCE_ID,a.SRCNAME from TD_CMS_DOCSOURCE a , TD_CMS_DOCUMENT b where a.DOCSOURCE_ID = b.DOCSOURCE_ID and rownum =1 order by b.Document_Id desc" ;
			   String sql = "select a.DOCSOURCE_ID,a.SRCNAME from TD_CMS_DOCSOURCE a where a.srcname='"+orgName+"'";
			   db.executeSelect(sql) ;
			   if(db.size()>0){
			   		docSourceId = db.getString(0,0);
			   		docSourceName = db.getString(0,1); 
			   }
			}catch(Exception e){}
			
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<link href="<%=request.getContextPath()%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">
	<script src="<%=request.getContextPath()%>/cms/inc/js/func.js"></script>
	<script src="<%=request.getContextPath()%>/cms/inc/js/killerror.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/public/datetime/calender.js" language="javascript"></script>
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
	.STYLE1 {color: red}
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
	//վ�㴰���������У��
	function saveform(closeFlag){
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
		
		
		var subtitle = myform.subtitle.value ;
		if(subtitle.length < 1 || subtitle.replace(/\s/g,"") == "")
		{
			alert("��������ʾ����!");
			document.all.auditorDiv.innerHTML="";
			document.all.publisherDiv.innerHTML="";
			myform.subtitle.focus();
			return false;
		}
		if(subtitle.length > 300)
		{
			alert("�ĵ���ʾ����ĳ��Ȳ��ܴ���300");
			return false ;
		}
		
		
		if(myform.content.value==""){
			alert("����������URL!");
			document.all.auditorDiv.innerHTML="";
			document.all.publisherDiv.innerHTML="";
			myform.content.focus();
			return false;
		}
		if(inputsource==null||inputsource=="")
		{
			alert('��ѡ�������д�ĵ���Դ');
		  	document.all.auditorDiv.innerHTML="";
			document.all.publisherDiv.innerHTML="";
		  	document.all.inputdocsource.focus();
		  	return false;
		}
		//if(!isURL(document.all("content").value)){
		//    alert('����д��ȷ��URL!');
		//    document.all.content.focus();
		 //   return false;
		//}
				
		else{
			//�ж��Ƿ��¼ӵ��ĵ���Դ��������

		    if(document.all.docsource_id.value.length<1)
		    {
				document.all.isnewdocsource.value="1";
			}
			
			myform.method="post";
			myform.target = "addlinks";
			
			
			myform.action="<%=request.getContextPath()%>/cms/docManage/add_document.jsp?flag=" + closeFlag;
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

	//ѡ��ͼƬ���ŵĸ���ͼƬ
	var fileFlag;
	function chooseImage(){
		fileFlag = "pic";
		openWin("<%=request.getContextPath()%>/cms/channelManage/chooseImageFrameset.jsp?fileFlag=picOrFlash",700,580);
	}
	function setImage(uri){
		if(fileFlag == "pic")
			document.all("picpath").value  = uri;
		if(fileFlag == "media")
			document.all("mediapath").value  = uri;
		if(fileFlag == "newpic")
			document.all("newpicpath").value  = uri;
	}
	//ѡ���ý���ļ�
	function choosemedia()
	{
		fileFlag = "media";
		openWin("<%=request.getContextPath()%>/cms/channelManage/chooseImageFrameset.jsp?fileFlag=media",520,580);
	}
	//ѡ��newͼ���ļ�
	function choosenewpic()
	{
		fileFlag = "newpic";
		openWin("<%=request.getContextPath()%>/cms/channelManage/chooseImageFrameset.jsp?fileFlag=pic",620,580);
	}

	//������ڵ�һ��text
	function init(){
		myform.title.focus();
		myform.content.value = "http://";
	}
	
	function isnum()
	{
	  var k = window.event.keyCode;
	  if (k < 48 || k > 57){
	     alert("������Ĳ������֣�")
	     window.event.keyCode = 0 ;}
	}
	function changSelect(o)
	{
	   document.all.inputdocsource.value=document.all.docsource_id.options(document.all.docsource_id.selectedIndex).text;
	   document.all.inputdocsource.focus();
	   document.all.inputdocsource.select();
	}
	function publishPreview(){
	    if(!isURL(document.all("content").value)){
		    alert('����д��ȷ��URL!');
		    document.all.content.focus();
		    return false;
		}
		try{
			window.open(document.forms[0].content.value);
		}catch(e)
		{
			alert("��������ȷ������URL");
		}
	}
	function subpublish(){
	    if(!isURL(document.all("content").value)){
		    alert('����д��ȷ��URL!');
		    document.all.content.focus();
		    return false;
		}
		showModalDialog("doc_PublisherList.jsp?flag=4&channelId=<%=channelId%>",window,"dialogWidth:400px;dialogHeight:500px;help:no;scroll:auto;status:no");
	}
	function publish(){
	    if(!isURL(document.all("content").value)){
		    alert('����д��ȷ��URL!');
		    document.all.content.focus();
		    return false;
		}
		document.all.divProcessing.style.display="";
		saveform(12);
	}
	function deliver(){
	    if(!isURL(document.all("content").value)){
		    alert('����д��ȷ��URL!');
		    document.all.content.focus();
		    return false;
		}
		showModalDialog("doc_AuditorList.jsp?flag=4&channelId=<%=channelId%>",window,"dialogWidth:400px;dialogHeight:500px;help:no;scroll:auto;status:no");
	}
	//���URL�ĺϷ���
	function isURL(url){
	    var urlPattern = /^(?:(?:ftp|https?):\/\/)?(?:[a-z0-9](?:[-a-z0-9]*[a-z0-9])?\.)+(?:com|edu|biz|org|gov|int|info|mil|net|name|museum|coop|aero|[a-z][a-z])\b(?:\d+)?(?:\/[^;"'&lt;&gt;()\[\]{}\s\x7f-\xff]*(?:[.,?]+[^;"'&lt;&gt;()\[\]{}\s\x7f-\xff]+)*)?/;   
        return   urlPattern.test(url.toLowerCase());   
    } 
    
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
	<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
	<base target="_self">
	<body bottommargin="0" bgcolor="#F3F4F9" onkeydown="if(event.keyCode==116){reload.click()}" rightmargin="0" leftmargin="0" topmargin="0" onLoad="init()">
		<script language="javascript">
	document.write("<a id='reload' href='" + document.location.href + "' style='display:none'>reload...</a>");
</script>
		<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
		<!--��������� -->
		<div id="divProcessing" style="position:absolute;width:40%;height:20px;z-index:1;
			background-color:#F0f0f0;layer-background-color:#F0f0f0;left:22%;top:80%;display:none;" class="font">
			<marquee direction="left" width="250" behavior="alternate">
				<span class=STYLE1>���ڷ����У����Եȡ���</span>
			</marquee>
		</div>

		<form target="addlinks" name="myform">
			<div id="auditorDiv" name="auditorDiv" style="display:none;"></div>
			<div id="publisherDiv" name="publisherDiv" style="display:none;"></div>
			<input name="doctype" value="1" type=hidden>
			<input name="userid" value="<%=userid%>" type=hidden>
			<input name="channelId" value="<%=channelId%>" type=hidden>
			<input name="siteid" value="<%=siteid%>" type=hidden>
			<input name="channelName" value="<%=channelname%>" type=hidden>
			<input name="isnewdocsource" value="0" type="hidden">
			<input type="hidden" id="docsource_id" name="docsource_id" value="<%=docSourceId%>">
			<input type="hidden" id="ischecksource">
			<!--�Ƿ��¸�Դ-->
			<input type="hidden" name="parentDetailTpl" value="1" />
			<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr>
					<td height="47" valign="top" background="<%=request.getContextPath()%>/cms/images/top_tile_short.jpg">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="200">
									<img src="<%=request.getContextPath()%>/cms/images/logo.jpg">
								</td>
								<td>
									���ݲɼ� [
									<%=sitename%>
									վ�� :
									<%=channelname%>
									Ƶ��]
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td height="18">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr background="<%=request.getContextPath()%>/cms/images/Gather_Content_topbg.gif">
								<td width="4%" height="35" align="right">
									<img src="<%=request.getContextPath()%>/cms/images/ico_point.gif" width="25" height="25">
								</td>
								<td colspan="4" class="cms_title_blue">
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td width="100" height="35" class="cms_title_blue">
												�ĵ���Ϣ��д
											</td>
											<td>
												<div style="text-align:left">
													( <span class="red_star">*</span> Ϊ������ <span class="red_star"> <img src="<%=request.getContextPath()%>/cms/images/tan.gif" width="11" height="11"> </span> )
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="26">
									<label>
										&nbsp;
									</label>
								</td>
								<td colspan="4">
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<strong>�ĵ�����</strong>:
											</td>
											<td width="3%">
												<div align="center">
													<img src="<%=request.getContextPath()%>/cms/images/doc_html.gif" width="20" height="20">
												</div>
											</td>
											<td>
												<a href="<%=request.getContextPath()%>/cms/docManage/doc_gather.jsp?siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>">��ͨ�ĵ�</a>
											</td>
											<td width="3%">
												<div align="center">
													<img src="<%=request.getContextPath()%>/cms/images/doc_link.gif" width="20" height="20">
												</div>
											</td>
											<td>
												<a href="<%=request.getContextPath()%>/cms/docManage/doc_gather_links.jsp?siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>"> <font color="#FF6600">�ⲿ����</font></a>
											</td>
											<td width="3%">
												<div align="center">
													<img src="<%=request.getContextPath()%>/cms/images/doc_aggr.gif" width="20" height="20">
												</div>
											</td>
											<td>
												<a href="<%=request.getContextPath()%>/cms/docManage/doc_gather_aggr.jsp?siteid=<%=siteid%>&channelName=<%=channelname%>&channelId=<%=channelId%>">�ۺ��ĵ�</a>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td height="26">
									&nbsp;
								</td>
								<td width="8%" height="23" align="right">
									<strong>���ӱ���:</strong>
								</td>
								<td width="43%" height="23" colspan="2">
									<span class="cms_title_blue"> <label>
											<input name="title" type="text" class="cms_text" size="60" onpropertychange="subtitle.value=this.value" />
										</label> </span> <span class="STYLE7"> <label>
											<span class="red_star">*</span>
										</label> </span>
								</td>
								<td>
									<span><strong>������ɫ:</strong></span> <span> <input name="titlecolor" onClick="openWin('<%=request.getContextPath()%>/cms/inc/js/selcolor.htm?',271, 311);" readonly type="text" class="cms_text" value="#000000" size="8" maxlength="50"> </span>
								</td>
							</tr>
							<tr>
								<td height="26">
									&nbsp;
								</td>
								<td height="23" align="right">
									<strong>��ʾ����:</strong>
								</td>
								<td height="23" colspan="2">
									<input name="subtitle" type="text" class="cms_text" size="60">
									<span class="STYLE7"> <span class="red_star">*</span> </span>
								</td>
								<td>

									<!-- 
													<label><strong>�ĵ���Դ:</strong></label>
							                    	<span class="black">
							                    		<span class="STYLE7">
							                    			<span class="red_star">
							                    				<span class="cms_title_blue">
							                    				<input type="text" style="width:100px;height:21px;font-size:10pt;" id="inputdocsource" name="inputdocsource"><span style="width:18px;border:0px solid red;">
							                    				<select name="docsource_id" style="margin-left:-100px;width:118px;" onChange="changSelect(this)" id="docsource_id" >
							                     						<%
												                         // List dslist=null;
																	      //DocumentManager dmi=new DocumentManagerImpl();
																	      //DocumentSource ds=new DocumentSource();
																		  //dslist=dmi.getDocSourceList();
																		  //request.setAttribute("dslist",dslist);
																		%>
													  					<pg:list requestKey="dslist">
													  	  					<option value="<pg:cell colName="docsource_id"/>"><pg:cell colName="srcname"/>
													  	  					</option>
													  					</pg:list>
							                    					</select>
							                    					</span>
							                    				</span>
							                    			</span></span></span>
							                    	-->

									<label>
										<strong>�ĵ���Դ:</strong>
									</label>
									<span class="cms_title_blue"> 
										<input type="text" style="width:120px;height:21px;font-size:10pt;" id="inputdocsource" name="inputdocsource" onmouseover="initdiv1()"
												 onpropertychange="changdiv()" onmouseout="divhidden()" value="<%=docSourceName%>">
										<div id="id1" STYLE="position:absolute;display:none;z-index:100;background: #fff; overflow-y:scroll; width:100px; height:300px" 
													onmouseover="divShow()" onmouseout="divhidden()"></div>
									    <span class="red_star">*</span> 
									</span>

								</td>
							</tr>
							<tr>
								<td height="26">
									&nbsp;
								</td>
								<td height="23" align="right">
									<strong>��&nbsp;&nbsp;&nbsp;&nbsp;��:</strong>
								</td>
								<td height="23" colspan="2">
									<span class="cms_title_blue"> <input name="author" type="text" class="cms_text" size="22"> </span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>&nbsp;�� ��:</strong> <span class="cms_title_blue"> <select name="doc_level" class="cms_select">
											<%List doclevellist = null;
			DocumentManager impl = new DocumentManagerImpl();
			doclevellist = impl.getDocLevelList();
			request.setAttribute("doclevellist", doclevellist);

			%>
											<pg:list requestKey="doclevellist">
												<option value="<pg:cell colName="id"/>">
													<pg:cell colName="name" />
											</pg:list>
										</select> &nbsp; </span>
								</td>
								<td>
									<strong>���ʱ��:</strong><span class="black"> <span class="cms_title_blue"> <input name="docwtime" type="text" class="cms_text" value="<%=riqi%>" size="22" onpropertychange="ordertime.value=this.value" ��validator="datetime" cnname="���ʱ��">&nbsp; <input
												type="button" class="Channel_5wordsBtn" value="ʱ��" onClick="showdatetime(document.all('docwtime'))"> </span> </span>

								</td>
							</tr>
							<tr>
								<td height="26">
									&nbsp;
								</td>
								<td height="23" align="right">
									<strong>����ͼƬ:</strong>
								</td>
								<td height="23" colspan="2">
									<input type="text" name="picpath" value="" class="cms_text" readonly size="30" />
									<input type="button" name="addpic" class="Channel_5wordsBtn" onClick="chooseImage()" value="ѡ��ͼƬ" /> <input type="button" name="clearpicpath" class="Channel_5wordsBtn" value="���" onclick="document.myform.picpath.value=''"/>
								</td>
								<td height="23">
									<strong>����ʱ��:</strong> <span class="black"> <span class="cms_title_blue"> <input name="ordertime" type="text" class="cms_text" value="<%=riqi%>" size="22"> </span> </span>
									<input type="button" class="Channel_5wordsBtn" value="ʱ��" onClick="showdatetime(document.all('ordertime'))">
								</td>
							</tr>
							<tr>
								<td height="26">
									&nbsp;
								</td>
								<td colspan="4">
									<strong>�Ƿ���Ϊnew:</strong>&nbsp;&nbsp;
									<input type="checkbox" hideFocus name="isnew" value="1" class="cms_text" />
									&nbsp;&nbsp;
									<input type="text" name="newpicpath" value="" class="cms_text" readonly size="30" />
									<input type="button" class="Channel_5wordsBtn" name="default" onClick="document.all('newpicpath').value='image/new.gif'" value="ʹ��Ĭ��ֵ" />
									<input type="button" class="Channel_7wordsBtn" name="addnewpic" onClick="choosenewpic()" value="ѡ��newͼ��" />
								</td>
							</tr>
							<tr>
								<td height="26">
									&nbsp;
								</td>
								<td height="23" align="right">
									<strong>���� URL:</strong>
								</td>
								<td height="23" colspan="2">
									<input name="content" type="text" class="cms_text" size="60">
									<span class="red_star">*</span>
								</td>
								<td>
									<strong>��Ŀ��:</strong> <span class="cms_title_blue"> <select name="linktarget" class="cms_select">
											<option value="_blank">
												_blank
											</option>
											<option value="_self">
												_self
											</option>
											<option value="_top">
												_top
											</option>
											<option value="_parent">
												_parent
											</option>
										</select> </span>
								</td>
							</tr>
							<tr>
								<td height="26">
									&nbsp;
								</td>
								<td align="right">
									<strong>ժҪ����:</strong>
								</td>
								<td>
									<textarea name="docabstract" cols="60" rows="5" class="cms_textarea"></textarea>
								</td>
							</tr>
							<tr>
								<td height="26">
									&nbsp;
								</td>
								<td align="right">
									<strong>�� �� ��:</strong>
								</td>
								<td colspan="3">
									<textarea name="keywords" cols="60" rows="5" class="cms_textarea"></textarea>
									(<span class="red_star">����ؼ���֮���ö��š�,���ָ�</span>)
								</td>
							</tr>
						</table>
					</td>
				</tr>

				<tr>
					<td width="766" height="33" align="center" valign="middle">
						<input name="button" type="button" class="cms_button" value="����" onClick="saveform(5);">
						&nbsp;
						<input type="button" value="����Ԥ��" class="cms_button" onClick="publishPreview()">
						<%if (impl.canTransition(Integer.parseInt(channelId), 1, 2) != -1) {%>
						&nbsp;
						<input type="button" value="����" class="cms_button" onClick="deliver();">
						<%}
			if (impl.canTransition(Integer.parseInt(channelId), 1, 11) != -1) {%>
						&nbsp;
						<input type="button" value="�ύ����" class="cms_button" onClick="subpublish();">
						<%}
			if (impl.canTransition(Integer.parseInt(channelId), 1, 5) != -1) {%>
						&nbsp;
						<input type="button" value="��������" class="cms_button" onClick="publish();">
						<%}%>
						&nbsp;
						<input type="button" value="����" class="cms_button" onClick="back()">
					</td>
				</tr>
				<!--��Դ�ڱ����վ���и�վ��-->
			</table>
			<script type="text/javascript">
  document.all.inputdocsource.value=document.all.docsource_id.options(document.all.docsource_id.selectedIndex).text;
  </script>
		</form>
		<div style="display:none">
			<iframe name="addlinks" width="0" height="0"></iframe>
		</div>
	</body>
</html>