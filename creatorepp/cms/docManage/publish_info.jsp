<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.driver.publish.impl.PublishMonitor"%>
<%@page import="com.chinacreator.cms.driver.publish.impl.APPPublish"%>
<!--�ĵ����� -->
<%
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    String uuid = request.getParameter("uuid");
    response.setHeader("Cache-Control", "no-cache"); 
    response.setHeader("Pragma", "no-cache"); 
    response.setDateHeader("Expires", -1);  
    response.setDateHeader("max-age", 0);
    
    String msgs = "";
    PublishMonitor monitor = (PublishMonitor)session.getAttribute(uuid);
    //List allMsg = monitor.getAllMessages();
    //List failMsg = monitor.getAllFailedMessages();
    //List successMsg = monitor.getAllSuccessMessages();    
    
    List newestMsg = monitor.getNewestMessages();
    int size = newestMsg.size();
    for(int i=0;i<size;i++){
        msgs += (newestMsg.get(i).toString()+String.valueOf("\\r\\n"));
   } 
    String pageUrl = (String)session.getAttribute("pageUrl"+uuid);
    msgs = msgs.replaceAll("\"","\'");
    msgs = msgs.replaceAll("��","\'");
    msgs = msgs.replaceAll("��",", "); 
    msgs = msgs.replaceAll("��"," ("); 
    msgs = msgs.replaceAll("��",") "); 
    msgs = msgs.replaceAll("\"","' ");
%>
<!--�ĵ����� -->
<SCRIPT LANGUAGE="JavaScript">
<!--
     
     //var timer1 = window.setInterval("refresh()",500);
     var timer2 = window.setInterval("rollDown()",100);
     var msgs = "<%=msgs%>";
     //���������������� �� "
     msgs = msgs.replace("\"","\'");
     msgs = msgs.replace("��","\'");
     msgs = msgs.replace("��",", "); 
     msgs = msgs.replace("��"," ("); 
     msgs = msgs.replace("��",") "); 
     msgs = msgs.replace("\"","' ");  
     function clearTimer(){
         window.clearInterval(timer2);
     }
     function rollDown(){
         parent.document.all("publish_info").doScroll('down'); 
     }
     function refresh(){   
         if(msgs.length>0){
             if(parent.document.all("publish_info")){
                 parent.document.all("publish_info").innerText += msgs; 
             }               
         }
         //window.location.href="publish_info.jsp?uuid=<%=uuid%>";
     } 
     refresh();
     function stop(){
         if("<%=pageUrl%>" != "null" && "<%=pageUrl%>".length > 0){
             parent.document.all("waiting_marquee").style.display = "none";
             var isRecordValue = parent.window.dialogArguments.document.all("isRecordValue").value;             
             try{
                 if(isRecordValue=="true"){
                     var infomsg = "<a href='<%=pageUrl%>'>�����ĵ�:<%=pageUrl%></a>";
                     if("<%=pageUrl%>"=="mutipublish" ){
                         infomsg = "��������,����һ�鿴�����ĵ�"
                     }
                     parent.document.all("linkInfo").innerHTML = infomsg;
                     alert("��ϲ�������ɹ���"); 
                 }   
                 //window.clearInterval(timer1);
                 setTimeout("clearTimer()",1000);   
             }catch(err){
                 alert(err.description);
             }   
         }
     }
     stop();
     
     
//-->
</SCRIPT>