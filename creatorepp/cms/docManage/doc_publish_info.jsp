<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.driver.publish.impl.PublishMonitor"%>
<%@page import="com.chinacreator.cms.driver.publish.impl.APPPublish"%>
<%
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    String uuid = request.getParameter("uuid");
    String refresh = request.getParameter("refresh");
    refresh = refresh==null?"":refresh;
    //��������Ҫ����
    //flag ��������
    //docid �ĵ�ID
    String flag = request.getParameter("flag");
    flag = flag==null?"":flag;
    String docId = request.getParameter("docId");
    docId = docId==null?"":docId;
    
    response.setHeader("Cache-Control", "no-cache"); 
    response.setHeader("Pragma", "no-cache"); 
    response.setDateHeader("Expires", -1);  
    response.setDateHeader("max-age", 0);    
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="../inc/js/func.js"></script>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�����ĵ�</title>
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
.STYLE8 {color: #0000FF}
.STYLE1 {color: blue}
-->
</style>
</head>

<body background="../images/grayline_bg.jpg">
<form name="form1" action="" method="post">
<table width="98%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" align="center">
    <tr>
        <td width="4%" height="20" align="right">
            <img src="../images/ico_point.gif" width="25" height="25">
        </td>
        <td height="20" class="cms_title_blue">
                �ĵ�����
        </td>
    </tr>
</table>
<table width="98%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" align="center">
    <tr>
        <td width="100" height="24" align="right" nowrap>�Ƿ��¼��־:</td>
        <td height="24">
            <input hideFocus type="checkbox" id="isRecordMsg1" name="isRecordMsg1" value="false" onclick="document.all.isRecordMsg2.checked=false"  checked/>����¼
            <input hideFocus type="checkbox" id="isRecordMsg2" name="isRecordMsg2" value="true" onclick="document.all.isRecordMsg1.checked=false"/>��¼
            <span id="infoMsg" style="display:none;">
                <INPUT name="button" id="showinfo" type="button" class="cms_button" onClick="showMsg()" >
                <INPUT  type="button" class="cms_button" value="ˢ����Ϣ" onClick="updateMsg()" >
            </span>
        </td>
    </tr> 
</table>
<br>
</form>
<div  style="text-align:center;">
    <INPUT name="button" id="publishButton" type="button" class="cms_button" onClick="subform()"  value="����">
    &nbsp;&nbsp;&nbsp;
    <INPUT name="button" id="closeButton" type="button" class="cms_button" onClick="window.close()"  value="�ر�">
        
</div>
<div id="waiting_marquee" style="position:absolute;width:40%;height:20px;z-index:1;background-color:#F0f0f0;layer-background-color:#F0f0f0;left:22%;top:80%;display:none;"  class="font">   
    <marquee direction="left" width="250" behavior="alternate"><span class=STYLE1>���ڷ����У����Եȡ���</span></marquee>
</div>


<iframe name="info" src="" width="0" height="0"  style="display:none" ></iframe>
<iframe name="publishFrame" src="" width="2" height="2"  ></iframe>
    <div id="waiting" style="text-align:center;display:none">    
        <span>
            <textarea name="publish_info" style="width:400" rows="8"></textarea>
        </span>        
    </div>
    <div id="linkInfo" style="text-align:center">
    </div>
    <div id="sp_button" style="text-align:center">
    </div>
</body>

<script language="javascript">
    window.onunload = function setReturnStr(){        
        if("<%=refresh%>"!="false"){
            //alert("refresh parent window")
            var url = window.dialogArguments.document.all("url").value;
            //ˢ�¸�ҳ��
            window.dialogArguments.document.location.href = url;
        }else{
            //alert("close parent window");            
            window.returnValue = "close";
        }
        //���session
        var path = "../cleanSession.jsp?uuid=<%=uuid%>";
        window.dialogArguments.document.all("cleanSession").src = path;
    }
    function subform(){
        if(document.getElementById("publishButton"))
            document.getElementById("publishButton").disabled="disabled";
        if(document.getElementById("isRecordMsg1"))
            document.getElementById("isRecordMsg1").disabled="disabled";
        if(document.getElementById("isRecordMsg2"))
            document.getElementById("isRecordMsg2").disabled="disabled";
        
        var isRecordValue = "";
        if(document.all("isRecordMsg1").checked) 
            isRecordValue = document.all("isRecordMsg1").value;
        if(document.all("isRecordMsg2").checked)
            isRecordValue = document.all("isRecordMsg2").value;
            
        window.dialogArguments.document.all("isRecordValue").value = isRecordValue;
        //�ύ������
        window.dialogArguments.document.form1.submit();        
        if(isRecordValue == "true"){
            updateMsg();
        }
        
        var isRecordValue = "";
        if(document.all("isRecordMsg1").checked) 
            isRecordValue = document.all("isRecordMsg1").value;
        if(document.all("isRecordMsg2").checked)
            isRecordValue = document.all("isRecordMsg2").value;
        
        if(isRecordValue=="true"){    
            document.all.infoMsg.style.display = "";
            document.all("showinfo").value = "�鿴��־"
        }else{
            document.all.waiting_marquee.style.display = "";
        }
        document.all.waiting_marquee.style.display = "";
    }
    //��listҳ��ص�, ��ʾ���¼�¼�ķ�����־����
    function updateMsg(){
        document.all("publish_info").doScroll('down');
        document.all("info").src="publish_info.jsp?uuid=<%=uuid%>";
    }
    //��listҳ��ص�, ��ʾ�����ɹ�����ʾ
    //url Ϊ�յ�ʱ�� ֱ��alert(msg)
    //url ��Ϊ�յ�ʱ�� confirm()ѡ��msg
    function alertMsg(msg,url){
        if(url != ""){
	        con = window.confirm(msg);
	        if(con){
	            window.open(url);
	        } 
        }else{
            alert(msg);
        }
    }
    function showMsg(){
        if(document.all("showinfo").value == "�鿴��־") 
            document.all("showinfo").value = "������־";
        else document.all("showinfo").value = "�鿴��־";
        
        if(document.getElementById("waiting")){
            if(document.getElementById("waiting").style.display==""){
                document.getElementById("waiting").style.display="none";
            }else{
                document.getElementById("waiting").style.display="";
            }
        }
    }
    
    
</script>
</html>

