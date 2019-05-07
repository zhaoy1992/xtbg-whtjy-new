<%@ page language="java" pageEncoding="GBK"%>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%//AccessControl accesscontroler = AccessControl.getInstance();
//accesscontroler.checkAccess(request, response);%>
<HTML>
<HEAD>
<TITLE>表单参数设置</TITLE>
<script src="../js/csjsrequest.js"></script>
<script language="javascript">
	var topdjsn= Request.QueryString("djsn");
	var topdjid= Request.QueryString("djid");//	
	var oid = Request.QueryString("oid"); //
	var workflowid = Request.QueryString("workflowid");//
//window.moveTo(0,0);
//window.resizeTo(screen.availWidth,screen.availHeight);
	if(Request.QueryString("ebuse").toString() == "yes"){
		document.title ="";
	}
</script>
</HEAD>

<frameset rows=0,60%,40% frameborder=1 border=0>
	<frame id="menu" src="menutoolbar1.htm" scrolling=no border=0 frameborder=1  resize>
<!-- <frame id="topic" name="rightmain" src="layout.htm"  scrolling=auto border=0  frameborder=1  bordercolor=LightGrey marginwidth=1 noresize>
-->
 	
	<frameset id=main1 cols=0,100%  resize frameborder="0" framespacing="2">
		<frame id="objlist" src="objlist.htm" scrolling=no  resize style="border-right: 1px #00a3e4 solid">
		<frameset id=main2 rows="*,0"  border=0 resize style="border-left: 1px #00a3e4 solid">
			<frame id="topic" name="rightmain" src="layout1.htm"  scrolling=auto border=0 frameborder=0 bordercolor=LightGrey marginwidth=1 resize>
			<frame id="selhtml" src="selhtml.htm" scrolling=no border=0 frameborder=0  resize >
		</frameset>
	</frameset>

	<frameset id=showResult cols=50%,50% frameborder=1 border=0>
		<frame id="controlResult" src="../dj/1787.htm" scrolling=auto border=0 frameborder=0  resize>
		<frame id="perattrResult" src="../dj/1783.jsp" scrolling=auto border=0 frameborder=0  resize>
	</frameset>
    
</frameset>

</HTML>

