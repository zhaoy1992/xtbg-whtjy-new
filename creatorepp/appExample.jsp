<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);	
%><font style="font-size:12px; line-height:150% ">&nbsp;&nbsp;&nbsp;&nbsp;��ӭ����
�����ǵ�һ��Ӧ�õ���ҳ��
Ӧ�õ������ǣ�<%=control.getCurrentSystemName().toString()%>��
Ӧ�õ�ID�ǣ�<%=control.getCurrentSystemID().toString()%>��</font>
<center>
<div style="margin-top:50px"><img src="sysmanager/images/main.jpg"></div>
</center>
