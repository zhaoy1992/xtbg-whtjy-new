<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>请输入模板名称</title>
   
	<link rel="stylesheet" type="text/css" href="../../../purviewmanager/css/windows.css">
	<script type="text/javascript">
	function LTrim(str) { 
		var i; 
		for(i=0;i<str.length;i++) { 
			if(str.charAt(i)!=" ")
				break;
		} 
		str=str.substring(i,str.length); 
		return str; 
	} 
	
	function RTrim(str){ 
		var i; 
		for(i=str.length-1;i>=0;i--) { 
			if(str.charAt(i)!=" ")
				break; 
		} 
		str=str.substring(0,i+1); 
		return str; 
	}
	 
	function Trim(str){ 
		return LTrim(RTrim(str)); 
	}
	 
	function val_input(input)
	{
	  		 //验证输入不能为空
	  		 if(Trim(input)=="")
			 {
				alert("请输入模板名称！");
				return false;
			 }
		     return true;		     
	}
	
	function save(){
		var name = document.getElementById("templateName").value;
		if(val_input(name)){
			window.returnValue=name;
			window.close();
		}
	}
	</script>
  </head>
  
 <body class="contentbodymargin" onload="" scroll="no">
  		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
  			<tr class="tr"><td class="td">模板名称：</td><td class="td"><input type="text" id="templateName" size="30"></input></td></tr>
  			<tr><td colspan="2" align="center"><input type="button" name="save" value="保存" onclick="save()"/></td></tr>
  		</table>
 </body>
</html>
