<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%
AccessControl control = AccessControl.getInstance();
control.checkAccess(request,response);
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'user_defined_configure.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

    <link href="<%=path%>/purviewmanager/css/windows.css" rel="stylesheet"
			type="text/css">
	<script src="<%=path %>/include/validateForm.js"></script>
    <script type="text/javascript" language="Javascript">
    	var indexCount = 0;
		function config(obj,state){
			var objParam = document.getElementById("paramconfig");
			var htmlStr = '<table width="100%" height="30" border="0" cellpadding="0"'
				+ 'class="thin" bordercolor="#EEEEEE">';
			if(state){
				indexCount++;
			}else{
				if(obj==0){
					alert("���ٱ���һ�����ã�");
					return false;
				}
				indexCount--;
			}
			for(var i = 0; i <= indexCount; i++){
				var portalIdValue = "";
				var portalNameValue = "";
				var subsystemidValue = "";
				var appModuleSrcValue = "";
				var httpcontextValue = "";
				//select
				var instanceableValue = "1";
				var subsystemidstateValue = "1";
				var appModuleSrcstateValue = "1";
				var httpcontextstateValue = "1";
				if(i <= obj){
					var portalId = "portalId"+i;
					var portalName = "portalName"+i
					var subsystemid = "subsystemid"+i;
					var appModuleSrc = "appModuleSrc"+i;
					var httpcontext = "httpcontext"+i;
					portalIdValue = document.all.item(portalId).value;
					portalNameValue = document.all.item(portalName).value;
					subsystemidValue = document.all.item(subsystemid).value;
					appModuleSrcValue = document.all.item(appModuleSrc).value;
					httpcontextValue = document.all.item(httpcontext).value;
					
					//select
					var instanceable = "instanceable" + i;
					var subsystemidstate = "subsystemidstate" + i;
					var appModuleSrcstate = "appModuleSrcstate" + i;
					var httpcontextstate = "httpcontextstate" + i;
					instanceableValue = document.all.item(instanceable).value;
					subsystemidstateValue = document.all.item(subsystemidstate).value;
					appModuleSrcstateValue = document.all.item(appModuleSrcstate).value;
					httpcontextstateValue = document.all.item(httpcontextstate).value;
				}
				htmlStr += '<tr><td>portletΨһ��ʶ</td><td><input name="portalId' + 
				    i + '" value="' +
					(i+1) + '" type="text" /></td>' + 
					'<td>portlet���ƣ�</td><td><input name="portalName' + 
				    i + '" value="' + 
					portalNameValue + '" type="text" validator="string" cnname="portlet����"/><font color="red">*</font></td>' + 
					'</tr><tr>' +
					'<td>�Ƿ��ʵ������</td><td><select name="instanceable' +  
					i + '">';
				if(instanceableValue==1){
					htmlStr += '<option value="1" selected>��ʵ��</option><option value="0" >��ʵ��</option>'; 
				}else{
					htmlStr += '<option value="1">��ʵ��</option><option value="0" selected>��ʵ��</option>';
				}
			    htmlStr += '</select></td><td>��ϵͳid��</td><td>' + 
					'<input name="subsystemid' + 
				    i + '" value="' + 
					subsystemidValue + '" type="text" /><select name="subsystemidstate' + 
            		i + '">';
            	if(subsystemidstateValue==1){
            		htmlStr += '<option value="1" selected>ֻ��</option><option value="0">���޸�</option>';
            	}else{
            		htmlStr += '<option value="1">ֻ��</option><option value="0" selected>���޸�</option>';
            	}
            	
				htmlStr += '</select></td></tr><tr>' + 
					'<td >Դsrc��</td><td colspan="3"><input size="80" name="appModuleSrc' + 
				    i + '" value="' + 
					appModuleSrcValue + '" type="text" validator="string" cnname="Դsrc"/>' +
					'<select name="appModuleSrcstate' + i + '">';
				if(appModuleSrcstateValue==1){
            		htmlStr += '<option value="1" selected>ֻ��</option><option value="0">���޸�</option>';
            	}else{
            		htmlStr += '<option value="1">ֻ��</option><option value="0" selected>���޸�</option>';
            	}
				htmlStr += '</select>' +  
					'<font color="red">*</font></td></tr><tr>' + 
					'<td>Httpcontext��</td><td colspan="3"><input size="80" name="httpcontext' + 
				    i + '" value="' + 
					httpcontextValue + '" type="text"/><select name="httpcontextstate' + i + 
					'">';
				if(httpcontextstateValue==1){
            		htmlStr += '<option value="1" selected>ֻ��</option><option value="0">���޸�</option>';
            	}else{
            		htmlStr += '<option value="1">ֻ��</option><option value="0" selected>���޸�</option>';
            	}
				htmlStr += '</select></td></tr>' + 
					'<tr><td colspan="4"><br/></td></tr>';
					
					
				
			}
			htmlStr += '<tr><td colspan="4" align="right">' +
				'<input name="opadd" value="����" type="button" class="input" onclick="config(' +
				indexCount + ',true)"/>' +
				'<input name="opdel" value="����" type="button" class="input" onclick="config(' + 
				indexCount + ',false)"/>' + 
				'<input name="subForm" value="������portlet iframe war��" type="button" class="input" onclick="subconfig()"/>' +
				'</td><tr>' + 
				'</table>';
			objParam.innerHTML = htmlStr;
		}
		
		function subconfig(){
			var s = document.all.portletIframeName.value;
			if(/[^\x00-\xff]/g.test(s)){
		    	//���к���
		    	alert(document.all.portletIframeName.cnname + ",������д�����ַ���");
		    	document.all.portletIframeName.focus();
		    	return;
		    }
			if(validateForm(form1)){
				document.form1.action="user_defined_configure_do.jsp?indexCount="+indexCount;
				document.form1.target="hiddenFrame";
				document.form1.submit();
			}
		}
    </script>
  </head>
  
  <%@ include file="/epp/css/cssControl.jsp"%><body class="contentbodymargin">
    <form action="" method="post" target="hiddenFrame" name="form1">
      <table width="100%" border="0" height="30" cellpadding="1" cellspacing="0"
					class="thin" bordercolor="#EEEEEE">
			<tr>
				<td align="center" valign="middle" colspan="2">�Զ����û�����</td>
			</tr>
			<tr>
				<td width="120" align="right">portlet war�����ƣ�</td>
				<td><input name="portletIframeName" type="text" value="" size="50"  validator="stringLegal" cnname="portlet war������"/><font color="red">*</font></td>
			</tr>
			<tr>
				<td colspan="2"><br/></td>
			</tr>
      </table>
      <div id="paramconfig">
      	<table width="100%" height="30" border="0" cellpadding="0"
				cellspacing="0" class="thin">
            <tr>
            	<td>portletΨһ��ʶ</td><td><input name="portalId0"  value="1" readonly type="text" /></td>
            	<td>portlet���ƣ�</td><td><input name="portalName0" value="" type="text" 
            		 validator="string" cnname="portlet����"/><font color="red">*</font></td>
            </tr>
            <tr>
            <td>�Ƿ��ʵ������</td><td><select name="instanceable0">
            	<option value="1">��ʵ��</option>
            	<option value="0">��ʵ��</option>
            </select></td>
            <td>��ϵͳid��</td><td><input name="subsystemid0" value="" type="text" />
            <select name="subsystemidstate0">
            	<option value="1">ֻ��</option>
            	<option value="0">���޸�</option>
            </select>
            </td>
            </tr>
            <tr>
            	<td >Դsrc��</td><td colspan="3"><input size="80" name="appModuleSrc0"  value=""   type="text"
            		validator="string" cnname="Դsrc"/>
            		<select name="appModuleSrcstate0">
		            	<option value="1">ֻ��</option>
		            	<option value="0">���޸�</option>
		            </select><font color="red">*</font></td>
			</tr>
			<tr>
            	<td>Httpcontext��</td><td colspan="3">
            		<input size="80" name="httpcontext0" value="" type="text"/>
            		<select name="httpcontextstate0">
		            	<option value="1">ֻ��</option>
		            	<option value="0">���޸�</option>
		            </select></td>
			</tr>
			<tr>
            	<td colspan="4"><br/></td>
			</tr>		
			
			<tr>
            	<td colspan="4" align="right">
            		<input name="opadd" value="����" type="button" class="input" onclick="config(0,true)"/>
            		<input name="opdel" value="����" type="button" class="input" onclick="config(0,false)"/>
            		<input name="subForm" value="������portlet iframe war��" type="button" class="input" onclick="subconfig()"/>
            	</td>
			</tr>
          </table>
       </div>
    </form>
    
    <iframe name="hiddenFrame" width="0" height="0"></iframe>
  </body>
</html>
