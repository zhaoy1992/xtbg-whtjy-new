<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<html>
<head>
	<title>������������</title>
	<link rel="stylesheet" type="text/css" href="../../purviewmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="../../purviewmanager/css/treeview.css">	
	<script src="<%=request.getContextPath() %>/eformsys/fceform/js/fcpub.js"></script>
	<script>
	
  		window.name = "myname";  
  
		function val_input(input)
	  	{
	  		 //��֤������Ƿ�Ϊ�Ϸ��ַ�
	  		 if(input==null||input=="")
			{
				alert("��û�����벢���������ƣ�");
				return false;
			}
		     var patten=/^[a-zA-Z0-9]+$/;
		  	 if(patten.test(input))
		  	 {
		  		 return true;
		  	 }else
		  	 {
		  	 	 alert("ֻ��������ĸ�����֣�");
		   	     return false;
		     }
	  	}
	  	//��֤Ӧ�����Ƿ���ͬ��������
	  	function val_process_name(_name)
	  	{
			var retX=SendHttp("http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/servlet/ProcessTools?op=valPName&pid="+_name);
			if(retX=="false")
			{
				alert("�������Ѿ����ڣ���ʹ����������������");
				return false;
			}
			return true;	  	
	  	}
	  	
	  	function befo_submit()
	  	{
	  		var _name=document.getElementById('xpdl_name').value;
	  		if(val_input(_name)&&val_process_name(_name))
	  		{
	  			document.forms[0].submit();
	  		}
	  	}
	</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" onload="" scroll="no">
		<div>
			<form method="post" name="formClassForm" target="myname" action="<%=request.getContextPath() %>/jawe/jawe_unite/navigator_content.jsp?publishState=1">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">��������*��</td>
						<td height="25">
							<input type=text name="xpdl_name" maxlength="100" value=""/>
						</td>
					</tr>
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">����������</td>
						<td height="25">
							<textarea rows="3" cols="40" name="remark"></textarea>
						</td>
					</tr>
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">�Ƿ񱣴����̻���ݣ�</td>
						<td height="25">
							<input type="checkbox" name="isSaveActData"/>����
						</td>
					</tr>					
				</table>
				
            	<hr width="100%">	
            			
				<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="center">								
								<input name="button" type="button" class="input" value="����" onClick="befo_submit();">
						    </div>
						</td>
					</tr>
				  </table>
				  
			</form>
		</div>
	</body>
</html>