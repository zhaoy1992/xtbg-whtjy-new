<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl,
               org.apache.commons.lang.StringUtils"%>
<%AccessControl accesscontroler = AccessControl.getInstance();
  accesscontroler.checkAccess(request, response);  
  String appId = StringUtils.defaultString(accesscontroler.getCurrentSystemID());
  String appPath = "../"; //Ĭ����ƽ̨�������ʽ·����
  if(!appId.equals("module") || !appId.equals("")){
      appPath = "app_"+accesscontroler.getCurrentSystemID();    
  } 
%>
<% 
	String djsn_local = (String)request.getParameter("djsn");
%>
<HTML >
<HEAD>
<TITLE>�������</TITLE>
 <script src="../js/csjsrequest.js"></script>

 <script src="../js/fcpub.js"></script>
 <script src="../js/design.js"></script>
 <script src="../js/fctoolbar.js"></script>
 <script src="../../fceformext/js/usertb.js"></script>

<script language="javascript">
    var stylePath = "../../../ccapp/<%=appPath%>/";
	var topdjsn= Request.QueryString("djsn");
	var topdjid= Request.QueryString("djid");//���djid
    var cssfolder= Request.QueryString("cssfolder");//��������ʽ�ļ���
	
	var isTemplate = Request.QueryString("isTemplate").toString(); //��ʾ�Ƿ��Ǵ�ģ���½���		
	if(isTemplate == null || isTemplate == "undefined"){
		isTemplate = "";
	}
	
//window.moveTo(0,0);
//window.resizeTo(screen.availWidth,screen.availHeight);
	if(Request.QueryString("ebuse").toString() == "yes"){
		document.title ="��������������";
	}
	
  	function releaseFormLock()
	{
	   var status = "";
	   var result = "";
	   var djsn = '<%= djsn_local%>';
	   //���رձ��޸�ҳ��ʱ����Ϊ����״̬����������
	   status = SqlToField("select dj_modified from tb_form where djid = '" + djsn + "'");
	   if(status == '1')
	   {
	       var s1=InsertSql("Update tb_form set dj_modified='0',dj_editor=null,dj_edittime=null where djid='" + djsn + "'");
	   }
	   
	   if(window.opener!=null&&(typeof window.opener.location) == 'object')    //���ȹر��˸�����������Ϊ'unknown',������ˢ�²�����ִ��
	   {  
	   		//opener.location.reload();
	   		var sUrl = opener.location.href;
	   		opener.location.replace(sUrl);
	   		//window.opener.location.href=window.opener.location.href;
	   		//window.location.reload();
	   }
	  
	}
</script>
</HEAD>
<frameset rows=55,89%,0 frameborder=1 border=0 onbeforeunload="releaseFormLock()">��
	<frame id="menu" src="menutoolbar.htm" scrolling=no border=0 frameborder=1  resize >
<!-- <frame id="topic" name="rightmain" src="layout.htm"  scrolling=auto border=0  frameborder=1  bordercolor=LightGrey marginwidth=1 noresize>
-->
	<frameset id=main1 cols=0,100%  resize frameborder="0" framespacing="2" onbeforeunload="releaseFormLock()">
		<frame id="objlist" src="objlist.htm" scrolling=no  resize style="border-right: 1px #00a3e4 solid">
		<frameset id=main2 rows="*,27"  border=0 resize style="border-left: 1px #00a3e4 solid">
			<frame id="topic" name="rightmain" src="layout.htm"  scrolling=auto border=0 frameborder=0 bordercolor=LightGrey marginwidth=1 resize>
			<frame id="selhtml" src="selhtml.htm" scrolling=no border=0 frameborder=0  resize >
		</frameset>
	</frameset>
</frameset>
