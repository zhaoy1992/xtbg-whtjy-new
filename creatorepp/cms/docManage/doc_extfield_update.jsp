<%
/**
  *	������չ�ֶ���Ϣ
  */
%>
<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@page import="com.chinacreator.cms.documentmanager.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.cms.customform.*"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>

<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);
	
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
	
	String id = request.getParameter("fieldid");
	
	CustomFormManager impl = new CustomFormManagerImpl();
	DocExtField field= impl.getExtFieldBy(id);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
<script src="../inc/js/func.js"></script>
<tab:tabConfig/>
<script language="javascript" src="../inc/js/selectTime.js"></script>
<style type="text/css">
<!--
.STYLE7 {color:#003398; font-size: 12px;}
#Layer1 {
	position:absolute;
	left:0px;
	top:0px;
	width:113px;
	height:127px;
	z-index:1;
}
.STYLE8 {color: #0000FF}

-->
</style>
<SCRIPT LANGUAGE="JavaScript">
	//
	function subform()
	{
		if(extfieldForm.fieldName.value=="")
		{
			alert("����д�ֶ����ƣ�");
			//extfieldForm.fieldName.focus();
			return false;
		}
		if(extfieldForm.fieldLable.value=="")
		{
			alert("����д�ֶ�label��");
			//extfieldForm.fieldLable.focus();
			return false;
		}
		if((extfieldForm.fieldType.value==1||extfieldForm.fieldType.value==3)&&extfieldForm.maxlen.value=="")
		{
			alert("����д�ֶ���󳤶ȣ�");
			//extfieldForm.maxlen.focus();
			return false;
		}
		else
		{
			if(extfieldForm.maxlen.value.search(/\D/g)!=-1)
			{
				alert("�ֶ���󳤶�ֻ��������!");
				//extfieldForm.maxlen.focus();
				return false;
			}
			if(extfieldForm.maxlen.value>1000)
			{
				alert("�ֶ���󳤶Ȳ��ܳ���1000!");
				//extfieldForm.maxlen.focus();
				return false;
			}
		}
		if(extfieldForm.scopeType[0].checked){
			document.all["list"].value = "";
			extfieldForm.minscope.value = "";
			extfieldForm.maxscope.value="";
		}
		if(extfieldForm.scopeType[1].checked)
		{
			document.all["list"].value = "";
			extfieldForm.minscope.value = "";
			extfieldForm.maxscope.value="";
			var   obj   =   document.all["scopevaluelist"];
			if (obj.options.length ==0){
				alert("����дö�����ͣ�");
				return;
			}
			for (var i=0;i<obj.options.length;i++)
				document.all["list"].value += obj.options[i].value+","+obj.options[i].text+";"
			
		}
		if(extfieldForm.scopeType[2].checked)
		{
			document.all["list"].value = "";
			if(extfieldForm.minscope.value==""||extfieldForm.maxscope.value=="")
			{
				alert("����д�������ͣ�");
				//extfieldForm.minscope.focus();
				return false;
			}
			else if(extfieldForm.minscope.value >extfieldForm.maxscope.value){
				alert("��Сֵ����С�����ֵ��");
				//extfieldForm.minscope.focus();
				return false;
			}
			else if(extfieldForm.minscope.value!=""&&extfieldForm.maxscope.value!="")
			{
				if(extfieldForm.minscope.value.search(/\D/g)!=-1||extfieldForm.maxscope.value.search(/\D/g)!=-1)
				{
					alert("��������ֻ��������!");
					//extfieldForm.minscope.focus();
					return false;
				}
			}
		}

		extfieldForm.submit();
	}
	//Fieldtype�ı���Ӧ
	function selectFieldtype()
	{
		if(extfieldForm.fieldType.value==0)
		{
			extfieldForm.maxlen.readOnly = true;
			extfieldForm.maxlen.value = "";
		}
		if(extfieldForm.fieldType.value==1)
		{
			extfieldForm.maxlen.readOnly = false;
			extfieldForm.maxlen.value = "1000";
		}
		if(extfieldForm.fieldType.value==2)
		{
			extfieldForm.maxlen.readOnly = true;
			extfieldForm.maxlen.value = "";
		}
		if(extfieldForm.fieldType.value==3)
		{
			extfieldForm.maxlen.readOnly = false;
			extfieldForm.maxlen.value = "1000";
		}
		if(extfieldForm.fieldType.value==4)
		{
			extfieldForm.maxlen.readOnly = true;
			extfieldForm.maxlen.value = "";
		}
	}
	//�ֶ�ȡֵ��Χ
	function setscope(param)
	{
		if(param==0)
		{
			document.all("scope").style.display = "none";
			document.all("scope1").style.display = "none";
			document.all("minscope").value = "";
			document.all("maxscope").value = "";
			var length = document.all("scopevaluelist").options.length;
			for (var i=0;i<length;i++){
				document.all("scopevaluelist").options.remove(0);
			}
		}
		if(param==1)
		{
			document.all("scope").style.display = "";
			document.all("scope1").style.display = "none";
			document.all("minscope").value = "";
			document.all("maxscope").value = "";
		}
		if(param==2)
		{
			document.all("scope").style.display = "none";
			document.all("scope1").style.display = "";
			var length = document.all("scopevaluelist").options.length;
			for (var i=0;i<length;i++){
				document.all("scopevaluelist").options.remove(0);
			}
		}
	}
	
	function addList()
	{
		var   obj   =   document.all["scopevaluelist"];
		var   desc = document.all["list_desc"].value;
		var   vlv = document.all["list_value"].value;
		if (desc=="" || vlv==""){
			alert("������ֵ��������");
			return;
		}
  		var   oOption=new   Option(desc,vlv);   
  		obj.add(oOption);   
	}
	
	function deleteList()
	{
		var   obj   =   document.all["scopevaluelist"];
		obj.remove(obj.selectedIndex);
	}
</SCRIPT>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�޸���չ�ֶ�</title>
</head>

<body background="../images/grayline_bg.jpg">
<form action="doc_extfield_update_do.jsp" method="post"  name="extfieldForm" target="extfieldexeman" id="extfieldForm">
	<input type="hidden" name="id" value="<%=id%>"/>
	<input type="hidden" name="list" value="<%=id%>"/>
	
	
	<table width="98%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" align="center">
		<tr >
			<td width="4%" height="20" align="right">
				<img src="../images/ico_point.gif" width="25" height="25">
			</td>
			<td height="20" class="cms_title_blue">
				��չ�ֶλ�����Ϣ
			</td>
		</tr>
		<tr>
			<td colspan="2" style="height:9px; background-color:#3266B1"></td>
		</tr>
		<tr>
			<td colspan="2">
			<tab:tabContainer id="foo-extfield-add" selectedTabPaneId="foo-extfield">
				<tab:tabPane id="foo-extfield" tabTitle="������Ϣ">
				<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#f0f0f0">
					<tr>
						<td width="100" height="24" align="right" nowrap>�ֶ�����:</td>
						<td height="24">
							<input type="text" id="fieldName" name="fieldName" class="cms_text" style="width:180px"  maxlength="20" value="<%=field.getFieldName()%>" readonly="true"/>
							<span style="color: #FF0000">*</span>
						</td>
					</tr>
					<tr>
						<td width="100" height="24" align="right" nowrap>�ֶ�label:</td>
						<td height="24">
							<input type="text" id="fieldLable" name="fieldLable" class="cms_text" style="width:180px"  maxlength="20" value="<%=field.getFieldLable()%>"/>
							<span style="color: #FF0000">*</span>
						</td>
					</tr>
					<tr>
						<td width="100" height="24" align="right" nowrap>�ֶ�����:</td>
						<td height="24">
							<select name="fieldType" id="fieldType" onchange="selectFieldtype()" style="width:180px" value="<%=field.getFieldType()%>">
								<option value="0">number</option>
								<option value="1" <%=(field.getFieldType().equals("1")?"selected":"")%>>varchar</option>
								<option value="2" <%=(field.getFieldType().equals("2")?"selected":"")%>>datetime</option>
								<option value="3" <%=(field.getFieldType().equals("3")?"selected":"")%>>clob</option>
								<option value="4" <%=(field.getFieldType().equals("4")?"selected":"")%>>file</option>
								
								<option value="5" <%=(field.getFieldType().equals("5")?"selected":"")%>>select</option>
								<option value="6" <%=(field.getFieldType().equals("6")?"selected":"")%>>radiobox</option>
								<option value="7" <%=(field.getFieldType().equals("7")?"selected":"")%>>checkbox</option>
								
							</select>
							<span style="color: #FF0000">*</span>
						</td>
					</tr>
					<tr>
						<td width="100" height="24" align="right" nowrap>�ֶ���󳤶�:</td>
						<td height="24">
							<input name="maxlen" type="text" class="cms_text" id="maxlen" style="width:180px" value="<%=field.getMaxlen() == 0 ? "" : field.getMaxlen()%>"  maxlength="20" readonly="true"/>
						 </td>
					</tr>
					
					<tr>
						<td width="100" height="24" align="right" nowrap>�ֶ�����:</td>
						<td height="24">
							<textarea name="fieldDesc" cols="28" rows="5" class="cms_textarea"><%=field.getFieldDesc()%></textarea>	
						</td>
					</tr>
				</table>
				</tab:tabPane>
				<tab:tabPane id="bar-extfield" tabTitle="ȡֵ��Χ">
				<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#f0f0f0">
					<tr>
						<td height="24" align="left" nowrap>
							ȡֵ��Χ����:</td>
						<td height="24">
							<input type="radio" id="scopeType" name="scopeType" value="0" onclick="if(confirm('�Ƿ�ȷ��������ҳ�����ݣ�'))setscope(0);" <%=(field.getInputType()==0?"checked":"")%>/>��
							<input type="radio" id="scopeType" name="scopeType" value="1" onclick="if(confirm('�Ƿ�ȷ��������ҳ�����ݣ�'))setscope(1);" <%=(field.getInputType()==1?"checked":"")%>/>ö������
							<input type="radio" id="scopeType" name="scopeType" value="2" onclick="if(confirm('�Ƿ�ȷ��������ҳ�����ݣ�'))setscope(2);" <%=(field.getInputType()==2?"checked":"")%>/>��������   
							
						 </td>
					</tr>
					<tr id="scope" style="display:none">
						<td height="24" align="left" nowrap>
							ֵ��<INPUT type="text" id="list_value" style="width:100px"/><p>
							������<INPUT type="text" id="list_desc" style="width:100px"/><p>
							<INPUT type="button" value=">>" onclick="addList();" class="cms_button"/>
						</td>
						<td height="24">
							<select name="scopevaluelist" size=5 style="width:100px">
							</select>
							<INPUT type="button" value="�Ƴ�" onclick="deleteList();" class="cms_button"/>
						</td>
					</tr>
					<tr id="scope1" style="display:none">
						<td  height="24" align="left" nowrap>ȡֵ��Χ:</td>
						<td height="24">
							��Сֵ:<input type="text" name="minscope" value="<%=String.valueOf(field.getMinvalue())%>" class="cms_text" style="width:100px"/>
							<span style="color: #FF0000">*</span><br>
							���ֵ:<input type="text" name="maxscope" value="<%=String.valueOf(field.getMaxvalue())%>" class="cms_text" style="width:100px"/>
							<span style="color: #FF0000">*</span>
						</td>
					</tr>
				</table>
				</tab:tabPane>
				</tab:tabContainer>
			</td>
		</tr>
	</table>
	<br>
	<div style="text-align:center">
		<INPUT name="button" type="button" class="cms_button" onClick="subform()"  value="����">
		&nbsp;&nbsp;&nbsp;
		<INPUT name="button" type="button" class="cms_button" onClick="window.close()"  value="�ر�">
	</div>
</form>
<iframe name="extfieldexeman" width="0" height="0" style="display:none"></iframe>
<SCRIPT LANGUAGE="JavaScript">
	<%="setscope("+String.valueOf(field.getInputType())+")"%>
	var   lst   =   document.all["scopevaluelist"];
	<% 
		if (field.getInputType()==1){
			for (int i=0;field.getEno().size()>0 && i<field.getEno().size();i++){%>
				var   oOption=new   Option('<%=((String)field.getEno().get(i)).split(";")[1]%>','<%=((String)field.getEno().get(i)).split(";")[0]%>');   
  				lst.add(oOption); 
			<%}
		}
	%>
</script>
</body>
</html>