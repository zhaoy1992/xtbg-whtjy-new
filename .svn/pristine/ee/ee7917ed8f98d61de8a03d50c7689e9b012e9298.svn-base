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
					alert("至少保留一个配置！");
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
				htmlStr += '<tr><td>portlet唯一标识</td><td><input name="portalId' + 
				    i + '" value="' +
					(i+1) + '" type="text" /></td>' + 
					'<td>portlet名称：</td><td><input name="portalName' + 
				    i + '" value="' + 
					portalNameValue + '" type="text" validator="string" cnname="portlet名称"/><font color="red">*</font></td>' + 
					'</tr><tr>' +
					'<td>是否多实例化：</td><td><select name="instanceable' +  
					i + '">';
				if(instanceableValue==1){
					htmlStr += '<option value="1" selected>多实例</option><option value="0" >单实例</option>'; 
				}else{
					htmlStr += '<option value="1">多实例</option><option value="0" selected>单实例</option>';
				}
			    htmlStr += '</select></td><td>子系统id：</td><td>' + 
					'<input name="subsystemid' + 
				    i + '" value="' + 
					subsystemidValue + '" type="text" /><select name="subsystemidstate' + 
            		i + '">';
            	if(subsystemidstateValue==1){
            		htmlStr += '<option value="1" selected>只读</option><option value="0">可修改</option>';
            	}else{
            		htmlStr += '<option value="1">只读</option><option value="0" selected>可修改</option>';
            	}
            	
				htmlStr += '</select></td></tr><tr>' + 
					'<td >源src：</td><td colspan="3"><input size="80" name="appModuleSrc' + 
				    i + '" value="' + 
					appModuleSrcValue + '" type="text" validator="string" cnname="源src"/>' +
					'<select name="appModuleSrcstate' + i + '">';
				if(appModuleSrcstateValue==1){
            		htmlStr += '<option value="1" selected>只读</option><option value="0">可修改</option>';
            	}else{
            		htmlStr += '<option value="1">只读</option><option value="0" selected>可修改</option>';
            	}
				htmlStr += '</select>' +  
					'<font color="red">*</font></td></tr><tr>' + 
					'<td>Httpcontext：</td><td colspan="3"><input size="80" name="httpcontext' + 
				    i + '" value="' + 
					httpcontextValue + '" type="text"/><select name="httpcontextstate' + i + 
					'">';
				if(httpcontextstateValue==1){
            		htmlStr += '<option value="1" selected>只读</option><option value="0">可修改</option>';
            	}else{
            		htmlStr += '<option value="1">只读</option><option value="0" selected>可修改</option>';
            	}
				htmlStr += '</select></td></tr>' + 
					'<tr><td colspan="4"><br/></td></tr>';
					
					
				
			}
			htmlStr += '<tr><td colspan="4" align="right">' +
				'<input name="opadd" value="增加" type="button" class="input" onclick="config(' +
				indexCount + ',true)"/>' +
				'<input name="opdel" value="减少" type="button" class="input" onclick="config(' + 
				indexCount + ',false)"/>' + 
				'<input name="subForm" value="发布成portlet iframe war包" type="button" class="input" onclick="subconfig()"/>' +
				'</td><tr>' + 
				'</table>';
			objParam.innerHTML = htmlStr;
		}
		
		function subconfig(){
			var s = document.all.portletIframeName.value;
			if(/[^\x00-\xff]/g.test(s)){
		    	//含有汉字
		    	alert(document.all.portletIframeName.cnname + ",不能填写中文字符！");
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
				<td align="center" valign="middle" colspan="2">自定义用户配置</td>
			</tr>
			<tr>
				<td width="120" align="right">portlet war包名称：</td>
				<td><input name="portletIframeName" type="text" value="" size="50"  validator="stringLegal" cnname="portlet war包名称"/><font color="red">*</font></td>
			</tr>
			<tr>
				<td colspan="2"><br/></td>
			</tr>
      </table>
      <div id="paramconfig">
      	<table width="100%" height="30" border="0" cellpadding="0"
				cellspacing="0" class="thin">
            <tr>
            	<td>portlet唯一标识</td><td><input name="portalId0"  value="1" readonly type="text" /></td>
            	<td>portlet名称：</td><td><input name="portalName0" value="" type="text" 
            		 validator="string" cnname="portlet名称"/><font color="red">*</font></td>
            </tr>
            <tr>
            <td>是否多实例化：</td><td><select name="instanceable0">
            	<option value="1">多实例</option>
            	<option value="0">单实例</option>
            </select></td>
            <td>子系统id：</td><td><input name="subsystemid0" value="" type="text" />
            <select name="subsystemidstate0">
            	<option value="1">只读</option>
            	<option value="0">可修改</option>
            </select>
            </td>
            </tr>
            <tr>
            	<td >源src：</td><td colspan="3"><input size="80" name="appModuleSrc0"  value=""   type="text"
            		validator="string" cnname="源src"/>
            		<select name="appModuleSrcstate0">
		            	<option value="1">只读</option>
		            	<option value="0">可修改</option>
		            </select><font color="red">*</font></td>
			</tr>
			<tr>
            	<td>Httpcontext：</td><td colspan="3">
            		<input size="80" name="httpcontext0" value="" type="text"/>
            		<select name="httpcontextstate0">
		            	<option value="1">只读</option>
		            	<option value="0">可修改</option>
		            </select></td>
			</tr>
			<tr>
            	<td colspan="4"><br/></td>
			</tr>		
			
			<tr>
            	<td colspan="4" align="right">
            		<input name="opadd" value="增加" type="button" class="input" onclick="config(0,true)"/>
            		<input name="opdel" value="减少" type="button" class="input" onclick="config(0,false)"/>
            		<input name="subForm" value="发布成portlet iframe war包" type="button" class="input" onclick="subconfig()"/>
            	</td>
			</tr>
          </table>
       </div>
    </form>
    
    <iframe name="hiddenFrame" width="0" height="0"></iframe>
  </body>
</html>
