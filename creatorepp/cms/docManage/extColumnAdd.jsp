<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.*"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.*"%>

<%	
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);	
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
	<title>������չ�ֶ�</title>
	<script src="../inc/js/func.js"></script>
	<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
	<style type="text/css">
		.STYLE1 {color: blue}
	</style>
</head>
<body scroll=no leftmargin=0> 
	<div id="divProcessing" style="position:absolute;width:40%;height:20px;z-index:1;
			background-color:#F0f0f0;layer-background-color:#F0f0f0;left:22%;top:80%;display:none;"  class="font">   
	    <marquee direction="left" width="250" behavior="alternate"><span class=STYLE1>���ڱ����У����Եȡ���</span></marquee>
    </div>
	<form action="" method="post" name="addCommentForm">
	<input type="hidden" name="operate_type"/>
	<fieldset>
	   <LEGEND align=left>������չ�ֶ�</LEGEND>
		<table width="98%" border="0" cellpadding="3" cellspacing="0"  class="Templateedittable">
		  <tr>		  
		    <td align="right" width="30%" height="20" nowrap>
				�ֶ�����
			</td>
			<td align="left" height="20">
				<input type="text" name="column_name" value="ext_" onblur="checkForm(this)" onafterpaste="checkForm(this)">
				<span style="color:red;">*������ �� ext_ ��ͷ</span>
			</td>
		  </tr>		 
		  <tr>
		    <td align="right" height="20" nowrap>
				�ֶ�����
			</td>
			<td align="left" height="20">
				<select name="column_type" id="column_type" style="width:153px" onchange="prompt(this)">
					<option value="varchar2">varchar2</option>
					<option value="char">char</option>
					<option value="number">number</option>				
					<option value="date">date</option>
					<option value="long">long</option>
				</select>
				<span style="color:red;">*������</span>
			</td>
		  </tr>
		  <tr>
		    <td align="right" height="20" nowrap>
				�ֶγ���
			</td>
			<td align="left" height="20">
				<input  type="text" name="column_length" onkeyup="checkForm(this)"  onafterpaste="checkForm(this)">
				<span id="star" style="color:red;">*������ ��󳤶�Ϊ4000</span>
			</td>
		  </tr>
		  <tr>
		    <td align="right" height="20" nowrap>
				��ע
			</td>
			<td align="left" height="20" rows=5>
				<textarea rows=5 name="column_comment" style="width:100%"></textarea>
			</td>
		  </tr>
		  <tr>
		      <td align="center" colspan="2" height="20">
			  		<input name="save" type="button" value="��   ��" class="cms_button" onClick="saveit()" />
					<input name="close" type="button" value="��   ��" class="cms_button" onClick="closeit()" />
			  </td>
		  </tr>
		  <tr>
		  </tr>
		</table>
	</fieldset>
	</form>
	<div height=0 width=0 style="display:none">
		<iframe name="addColumnIframe"></iframe>
	</div>
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
	function saveit(){	
		if(document.all("column_name").value.length<=0){
		    alert("����д������!");
		    return false;
		}
		
		if((document.all("column_type").value=="varchar2" ||document.all("column_type").value=="char")){
			if(document.all("column_length").value.length<=0){
				alert("����д������!");
			    return false;
			}
			
			if(document.all("column_length").value<=0){
				alert("�ֶγ��ȱ����Ǵ���0!");
				return false ;
			}
		}
		if(!confirm("��ȷ��Ҫ�ύ��?")) return false;
		document.all("divProcessing").style.display="";
		document.all("operate_type").value="add";
	    document.forms[0].action="extColumnOprate_do.jsp"
		document.frames[0].src="extColumnOprate_do.jsp";
        document.forms[0].target="addColumnIframe";
		document.forms[0].submit();
	}
	function closeit(){
		if(confirm("��ȷ��Ҫ������?")){
	        window.close();
		}
	}
	function prompt(e){
		document.all("column_length").value="";
	    if(e.value=="varchar2" ){
	    	document.all("column_length").readOnly=false;
		    document.all("star").innerText="*������ ��󳤶�Ϊ4000";
		}else if(e.value=="char"){
			document.all("column_length").readOnly=false;
            document.all("star").innerText="*������ ��󳤶�Ϊ2000";
		}else if(e.value=="number"){
			document.all("column_length").readOnly=false;
            document.all("star").innerText="*������ ��󳤶�Ϊ38";
		}else {
		    if(e.value=="long") {
		        document.all("column_length").value="4000"
		        document.all("star").innerText="һ������ֻ�ܰ���һ��long��";
		    }else{		    
                document.all("star").innerText="";
		    }
		    document.all("column_length").readOnly=true;
		}
	}
	function checkForm(e){
	    if(e.name=="column_length"){
			if(e.value=="") return;
            var format = /^\d*$/;
			if(!format.test(e.value)){
			    alert("ֻ��������");
				e.value="";
				e.focus();
			}
			if((document.all("column_type").value=="varchar2" && e.value>4000)||(document.all("column_type").value=="char" && e.value>2000)
			||(document.all("column_type").value=="long" && e.value>4000)  || (document.all("column_type").value=="number" && e.value>38)  ) {
			    alert("��������");
				e.value="";
				e.focus();
			}
		}else if(e.name=="column_name"){
			if(e.value=="") return;
            var format = /^ext_[A-Za-z0-9]*$/
			if(!format.test(e.value)){
			    alert("������ʽ����,�� ext_ ��ͷ!");
				e.value="ext_";
				e.focus();
			}
			if(e.value.length>30){
			    alert("�����ֶ�������󳤶�!");
				e.value="";
				e.focus();
			}

		}
	}
//-->
</SCRIPT>
</html>