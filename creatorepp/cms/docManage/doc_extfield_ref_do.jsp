<%
/**
  *	��������չ�ֶ���ѡ��һЩ��Ϊ�Լ�����չ�ֶΣ���һ�����ù�ϵ
  * Action
  * type 1��վ������� 2��Ƶ��������
  */
%>
<%@page contentType="text/html;charset=GBK" language="java"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.customform.*"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	
	CustomFormManager cm = new CustomFormManagerImpl();

	String type = request.getParameter("type");//վ��orƵ��
	String id = request.getParameter("id");//վ��id or Ƶ��id
	String[] ids = (request.getParameter("ids")).split(",");//��ѡ��չ�ֶ�id

	boolean b = false;
	b = cm.addDocExtFields(ids,type,id);

	if(b){%>
		<SCRIPT LANGUAGE="JavaScript"> 
			alert("ѡ����չ�ֶγɹ���");
			var str = window.dialogArguments.dialogArguments.location.href;
			var strArray = str.slice(0,str.indexOf("?"));
			window.dialogArguments.dialogArguments.location.href = strArray+"?"+window.dialogArguments.dialogArguments.document.all.queryString.value;
			window.dialogArguments.close();
		</script>
	
	<%}else{%>
		
		<SCRIPT LANGUAGE="JavaScript"> 
			alert("ѡ����չ�ֶ�ʧ�ܣ�");
		</script>
	<%
		}
	%>			