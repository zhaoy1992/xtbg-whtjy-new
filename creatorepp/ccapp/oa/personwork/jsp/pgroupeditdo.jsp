<%--  
����������
���ߣ�������
�汾��1.0
���ڣ�2013-06-13
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.PGroupServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.impl.PGroupServiceImpl"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>

<title>JGRID</title>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String paramjosn = request.getParameter("paramjosn");
	PGroupServiceIfc pg = new PGroupServiceImpl();
    //���·�����Ϣ
	boolean flag  = pg.pGroupUpdate(paramjosn);
%>
	<!-- ����jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-ui-tree.1.1.js"charset="utf-8"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
 if(<%=flag%>){
	mes = "�����ɹ�"; 
	bool = true;
}else{
	mes = "����ʧ��"	;
	bool = false;
}
 /**
   *��ȷ����Ļص�����
   */
 var ok=function(){
		//window.parent.location.reload();
		getParentWindow('windowId_1').location.reload();
 }
 //�ж��Ƿ�ִ��

if(window.top.removeAlertWindows('windowId_1',false,bool,mes,true)){
	if(bool){
		window.top.alert(mes,{headerText:'������',okName:'ȷ��',okFunction:ok})
	}
	else{
		window.top.alert(mes)
	}
}
 

</script>
</head>
<body>
</body> 
</html>