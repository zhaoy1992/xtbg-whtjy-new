<%
/**
  *	�޸���չ�ֶ�
  * Action
  */
%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.customform.*"%>
<%@page import="java.util.ArrayList"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	
	CustomFormManager cm = new CustomFormManagerImpl();

	DocExtField docExtField = new DocExtField();

	docExtField.setFieldId(Integer.parseInt(request.getParameter("id")));
	docExtField.setFieldName(request.getParameter("fieldName"));
	docExtField.setFieldLable(request.getParameter("fieldLable"));
	docExtField.setFieldDesc(request.getParameter("fieldDesc"));
	docExtField.setFieldType(request.getParameter("fieldType"));
	if("1".equals(request.getParameter("fieldType")))
		docExtField.setMaxlen(Integer.parseInt(request.getParameter("maxlen")));
	docExtField.setType("2");//��ʱֻ����Ƶ������Ϊû�п��Ǽ̳У�����վ��ľ�ûʵ�ʵ�����
	docExtField.setInputType(Integer.parseInt(request.getParameter("scopeType")));
	//����ȡֵ��Χ��Ϣ
	if(!"".equals(request.getParameter("minscope")))
		docExtField.setMinvalue(Integer.parseInt(request.getParameter("minscope")));
	if(!"".equals(request.getParameter("maxscope")))
		docExtField.setMaxvalue(Integer.parseInt(request.getParameter("maxscope")));
		
	if(!"".equals(request.getParameter("list"))){
		String s = request.getParameter("list");
		String[] items = s.split(";");
		ArrayList list = new ArrayList();
		for(int i=0;i<items.length;i++)
			list.add(items[i].split(",")[0]+";"+items[i].split(",")[1]);
		docExtField.setEno(list);
	}


	boolean b = cm.updateDocExtField(docExtField);

	if(b){
		if("null".equals(request.getParameter("id")))
		{
		%>
		<SCRIPT LANGUAGE="JavaScript"> 
			//window.dialogArguments.document.location.reload();
			alert("������չ�ֶγɹ���");
			var str = window.dialogArguments.location.href;
			var strArray = str.slice(0,str.indexOf("?"));
			window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
			window.close();
		</script>
		<%
		}else{
		%>
		<SCRIPT LANGUAGE="JavaScript"> 
			alert("�޸���չ�ֶγɹ���");
			var str = window.dialogArguments.location.href;
			var strArray = str.slice(0,str.indexOf("?"));
			window.dialogArguments.location.href = strArray+"?"+window.dialogArguments.document.all.queryString.value;
			window.close();
		</script>
	<%}
		}else{%>
		
		<SCRIPT LANGUAGE="JavaScript"> 
			alert("�޸���չ�ֶ�ʧ�ܣ�");
		</script>
	<%
		}
	%>			