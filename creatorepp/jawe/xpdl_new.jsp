<%@ page contentType="text/html; charset=GBK" language="java"%>
<html>
<head>
	<title>������������</title>
	<link rel="stylesheet" type="text/css" href="../purviewmanager/css/windows.css">
	<link rel="stylesheet" type="text/css" href="../purviewmanager/css/treeview.css">	
	<script src="xpdl.js"></script>
	<script>	
		function val_input(input)
	  	{
	  		 //��֤������Ƿ�Ϊ�Ϸ��ַ�
	  		 if(input==null||input=="")
			{
				alert("��û�������������ƣ�");
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
	  			//���ͨ����֤�����ύ
	  			var ec_id = "<%=request.getParameter("ec_id")%>"
	  			newXPDL(ec_id,_name);
	  		}
	  		else
	  		{
	  			return false;
	  		}
	  	}
	  	
	  	function newXPDL(ec_id,wpf_name)
		{	
			var _isSaveActData=document.getElementById("isSaveActData");
			var remark = document.getElementById('remark').value;//add by minghua.guo 20090616
			var _url ="";
			//���Ҫ����ҵ������
			if(_isSaveActData.checked)
			{			
				_url = "xpdl_open.jsp?ec_id="+ec_id+"&op=new&mgrName="+wpf_name+"&isSaveActData=true&remark="+remark;//090616 modify by minghua.guo remark
			}
			else
			{
				_url = "xpdl_open.jsp?ec_id="+ec_id+"&op=new&mgrName="+wpf_name+"&remark="+remark;//090616 modify by minghua.guo remark
			}
			var ParentObj = parent.window.dialogArguments.document.getElementById("myFrame"); 
			ParentObj.src=_url;
			parent.window.dialogArguments.document.getElementById("divProcessing").style.display="block";
			window.close();
		}
	</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" onload="" scroll="no">
		<div>
			<form method="post" name="formClassForm">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="35%" height="25" class="detailtitle" align="center">��������*��</td>
						<td height="25">
							<input type="text" name="xpdl_name" maxlength="100" value=""/>
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
								<input name="button" type="button" class="input" value="ȷ��" onClick="befo_submit();">
						    </div>
						</td>
					</tr>
				  </table>
				  
			</form>
		</div>
	</body>
</html>