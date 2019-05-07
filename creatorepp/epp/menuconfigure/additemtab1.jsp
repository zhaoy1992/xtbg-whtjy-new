<%@ page contentType="text/html; charset=GBK"%>
<%@include file="item.jsp" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<link rel="stylesheet" type="text/css"
			href="../../purviewmanager/css/windows.css">
		<link rel="stylesheet" type="text/css"
			href="../../purviewmanager/css/treeview.css">
		<tab:tabConfig />
		<base target="_self">
		<title>����ģ��</title>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/purviewmanager/scripts/func.js"
			type="text/javascript"></script>

		<script language="javascript">
					
			//��֤��������һҳ��			
			function nextadditem()
			{			
				var form = document.forms[0];
				var id=form.id.value;
				var name=form.name.value;				
			
				if (trim(id).length == 0 ){
			    	document.getElementById("id_message").innerHTML = "��¼��˵���ID��"; 
			    	return false;
			    }else{
			    	document.getElementById("id_message").innerHTML = "";
			    }
				
				 if(id.search(/[^\w]/) !=-1){	
			    	var blank = "";
			    	for(var i=0;i<52;i++)
			    		blank += "&nbsp;";    	
			    	document.getElementById("id_message").innerHTML = "�˵���IDֻ�������֡���ĸ"+"<br/>"+blank+ "���»�����ɣ�"; 			    	
			    	return false;
			    }else{
			    	document.getElementById("id_message").innerHTML = "";
			    }
			    
			    if (trim(name).length == 0 ){
			    	document.getElementById("name_message").innerHTML = "��¼��˵������ƣ�"; 
			    	return false;
			    }else{
			    	document.getElementById("name_message").innerHTML = "";
			    }
				
				 if(name.search(/[^\w\u4e00-\u9fa5]/) !=-1){	
			    	var blank = "";
			    	for(var i=0;i<52;i++)
			    		blank += "&nbsp;";    	
			    	document.getElementById("name_message").innerHTML = "�˵�������ֻ�������֡���ĸ��"+"<br/>"+blank+ "���ֻ��»�����ɣ�"; 			    	
			    	return false;
			    }else{
			    	document.getElementById("name_message").innerHTML = "";
			    }	
			  
			   document.location.assign("additemtab2.jsp");
			   
			}
			
			//ȥ���ַ����ո�
			function trim(string){
				var temp="";
				string = ''+string;
				splitstring = string.split(" ");
				for(i=0;i<splitstring.length;i++){
					temp += splitstring[i];
				} 
				return temp;
			}			
		</script>

	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin" onload="" scroll="no">
		<div id="contentborder" align="center">
			<form method="post" name="itemform" action="additemtab2.jsp" onsubmit="return nextadditem();">
				<input type="hidden" name="navigatortoolbar" value="<%=navigatortoolbar%>"/>
				<input type="hidden" name="navigatorcontent" value="<%=navigatorcontent%>"/>
				<input type="hidden" name="workspacetoolbar" value="<%=workspacetoolbar%>"/>
				<input type="hidden" name="workspacecontent" value="<%=workspacecontent%>"/>
				<input type="hidden" name="isUsed" value="<%=isUsed%>"/>
				<input type="hidden" name="moduletype" value="<%=moduletype%>"/>
				<input type="hidden" name="configtype" value="<%=configtype%>"/>
				<input type="hidden" name="currentSystemID" value="<%=currentSystemID%>"/>
				<input type="hidden" name="moduleId" value="<%=moduleId%>"/>
				<input type="hidden" name="isEdit" value="<%=isEdit%>"/>
				<input type="hidden" name="isFill" value="true"/>
				<input type="hidden" name="itemdisicon" value="<%=itemdisicon%>" />
				<input type="hidden" name="itemenicon" value="<%=itemenicon%>" />
				<br/>
				<br/>
				<fieldset style="width: 90%;">
						<LEGEND align=center>
							<FONT size="2"> ��������</FONT>
						</LEGEND>
				<br />
				<br />
				<table width="85%" height="35" border="0" cellpadding="0"
					cellspacing="1" class="thin">
					<tr class="tr">
						<td width="20%" height="35" class="detailtitle" align="right">
							<span style="color: #CC0000;">*</span>�˵���ID��
						</td>
						<td height="35">
							<%
								if(isEdit.equals("true")){
							%>
							<input type=text name="id" style="width=50%" maxlength="100"
								value="<%=id%>" readonly/>
							<%}else{ %>
							<input type=text name="id" style="width=50%" maxlength="100"
								value="<%=id%>" />
							<%}%>
							<span id="id_message" style="color: #CC0000;" />
						</td>
					</tr>

					<tr class="tr">
						<td width="20%" height="35" class="detailtitle" align="right">
							<span style="color: #CC0000;">*</span>�˵������ƣ�
						</td>
						<td height="35">
							<input type=text name="name" style="width=50%" maxlength="100"
								value="<%=name%>" />
							<span id="name_message" style="color: #CC0000;" />
						</td>
					</tr>
				</table>
				<br /><br />
				</fieldset>						
				<table width="85%" border="0" align="center" cellpadding="0"
					cellspacing="0" class="table">
					<tr class="tr">
						<td class="td">
							<div align="right">
								<br />
								<input name="update" type="submit"
									class="input" value="��һ��">
								<input name="calc" type="reset" class="input" value="����">
								<input name="calc" type="button" class="input" value="����"
									onClick="window.close();window.returnValue=true;">
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
	<iframe name="item" width="0" height="0" style="display: none;"></iframe>
</html>
