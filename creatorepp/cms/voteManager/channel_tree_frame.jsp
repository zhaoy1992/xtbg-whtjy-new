
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ include file="/sysmanager/include/global1.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title></title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
  </head>
  <%
  response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
  %>
  <body>
  <table width="100%" height="100%" border="0" bgcolor="#F3F4F9" cellspacing="0"><tr height="90%"><td>
    <iframe width="100%" height="100%" frameborder="0" cellspacing="0"  name="handleMoveFrame" src="../channelManage/channel_of_site_tree.jsp?siteid=<%=request.getParameter("siteid")%>"> </iframe>
    </td></tr>
    <tr><td align="center">
    	<input type="button" value="ȷ��" class="cms_button" onClick="ok()">
		<input type="button" value="ȡ��" class="cms_button" onClick="shutdown()">
    </td></tr>
  </body>
 
<script language="javascript">

  			function ok(){
  				var allChannelInfos = document.handleMoveFrame.document.getElementsByName("channelInfo");
  				if(allChannelInfos == null){
  					alert("��ʱû��Ƶ���ɹ�ѡ��");
  					return;
  				}
  				var oneChannelInfo;
  				for(var i=0;i<allChannelInfos.length;i++){
  					if(allChannelInfos[i].checked == true){
  						oneChannelInfo = allChannelInfos[i].value; 
  						break;
  					}
  				}
  				if(oneChannelInfo == null){
  					alert("��ѡ�����ǰƵ���������һ��Ƶ����");
  					return;
  				}
  				window.returnValue = oneChannelInfo;
  				window.close();
  			}
            function shutdown(){
                window.returnValue = "";
                window.close();
            }
            /*�ر�ʱ�����BUG*/
            window.onbeforeunload=function setvalue(){
                var retrunvalue = "";
                if(window.returnValue != "") retrunvalue = window.returnValue;
                if(window.returnValue == undefined) retrunvalue = "";
                window.returnValue = retrunvalue;
            }
  			
</script>
</html>
