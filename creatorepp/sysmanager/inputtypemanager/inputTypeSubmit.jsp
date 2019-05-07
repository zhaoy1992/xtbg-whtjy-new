<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.dictionary.input.InputTypeManager"%>
<%@ page import="com.chinacreator.dictionary.input.InputTypeManagerImpl"%>
<%@ page import="com.chinacreator.dictionary.input.InputType"%>
<%

		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
		String queryString = request.getParameter("querystring");
		String currentId=request.getParameter("inputTypeId");
		int flag =Integer.parseInt(request.getParameter("flag"));
		String typeName = request.getParameter("typeName");
		String typeDesc = request.getParameter("typeDesc");
		String typeScript = request.getParameter("typeScript");
		String sourcePath = request.getParameter("sourcePath");
		InputTypeManager inputTypeManager = new InputTypeManagerImpl();		
		InputType inputType=new InputType();
		boolean success=false;
		int deleteFlag = 0;
		//�Բ���״̬�����ж�	
		switch(flag)
		{
			//����
			case 1:
			inputType.setInputTypeDesc(typeDesc);
			inputType.setInputTypeName(typeName);
			inputType.setInputScript(typeScript);
			inputType.setDataSourcePath(sourcePath);	
			success=inputTypeManager.insertInputType(inputType);			
			break;
			//�޸�
			case 2:
			inputType.setInputTypeId(Integer.valueOf(currentId));
			inputType.setInputTypeDesc(typeDesc);
			inputType.setInputTypeName(typeName);
			inputType.setInputScript(typeScript);
			inputType.setDataSourcePath(sourcePath);	
			success=inputTypeManager.updateInputType(inputType);			
			break;
			//ɾ�� ������������ͱ�����, ������ɾ��
			case 3:
			String[] currentIds = currentId.split(",");
			deleteFlag=inputTypeManager.deleteInputType(currentIds);
			break;
		}
%>
<html>
<head>
<title></title>
<script language="javascript">
//�ж������Ƿ�ɹ�
if('<%=flag%>'=='1'){
	if(<%=success%>){
		alert("�������ͳɹ���");
		window.close();
		window.returnValue="ok";
	}else{
		alert("�������������ظ�,��������ʧ�ܣ�");
	}
}

//�ж��޸��Ƿ�ɹ�
if('<%=flag%>'=='2'){
	if(<%=success%>){
		alert("�޸����ͳɹ���");
		window.close();
		window.returnValue="ok";
	}else{
		alert("�������������ظ�,�޸�����ʧ�ܣ�");
	}
}

//�ж�ɾ������
if(!<%=success%> && '<%=flag%>'!='1' && '<%=flag%>'!='2')
{
	if('<%=flag%>'=='3')
	{
	    if(<%=deleteFlag%>==0){
	    	//ȫ��ɾ���ɹ�
			alert("ɾ�����ͳɹ���");
			window.parent.location.href = "inputTypeList.jsp?<%=queryString%>";
	    }else if(<%=deleteFlag%>==1){
	    	//����ɾ���ɹ�
	        alert("������������ɾ�����ɹ�,��Ϊ���������������ڱ�����");
	        window.parent.location.href = "inputTypeList.jsp?<%=queryString%>";
	    }else{
	    	//ȫ��ɾ�����ɹ�
	        alert("��������ɾ�����ɹ�,��Ϊ�����������ڱ�����");
	    }
	    
	}else{
		//��ɾ���������������
		alert("����ʧ��");
		window.close();
	}
}

</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
</body>
</html>

