<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/tabpane-taglib.tld" prefix="tab"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="com.chinacreator.security.AccessControl,
                 com.chinacreator.epp.businessClassManager.businessManager.FormClassManager,
                 com.chinacreator.epp.businessClassManager.vo.FormClass"%>
<%
	
	boolean isEdit = false;
	if(request.getParameter("action")!=null&&request.getParameter("action").equals("edit")){
	    isEdit = true;
	}else{
	    isEdit = false;  
	}
	
	FormClass formClass = new FormClass();
	String ec_id=request.getParameter("ec_id");  //�༭ʱ��Ϊ��ǰ����id
	String ec_upId = "";
	int ec_sn = 0;
	//String ec_upId = request.getParameter("ec_upid");  //�����id
	//String ec_upId = request.getParameter("ec_id");  //��������ʱ��Ϊ����id
	FormClassManager formClassManager = new FormClassManager();
	if(isEdit){
		formClass = formClassManager.getFormClassByClassId(ec_id);
	    ec_upId = formClass.getEc_upid().trim();
	}else{
		String appId = (String)request.getSession().getAttribute("subsystem_id");
		ec_sn = formClassManager.getMaxEc_SnByAppId(appId)+1;
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title><%if(isEdit){ %>
		              �޸�ҵ�����
		       <%}else{%>
		              ����ҵ�����
		       <%} %>
		</title>
			<link rel="stylesheet" type="text/css" href="../../purviewmanager/css/windows.css">
			<link rel="stylesheet" type="text/css" href="../../purviewmanager/css/treeview.css">
		<SCRIPT LANGUAGE="JavaScript"> 			
			var my_windowOpener = window.dialogArguments;  //�Ѹô�����Ϊģ̬���ڴ�ʱ���Ӹ����ڴ������Ĳ���window��
			function saveFormClass() {
				if(validateFormValue())
				{
					var form = document.forms[0];
					document.all.update.disabled=true;
					document.all.divProcessing.style.display = "block";
				  	form.action = "addFormClass_do.jsp";
					form.target = "hiddenFrame";
					if(<%=isEdit%>) form.action = "addFormClass_do.jsp?isEdit=true"
					form.submit();
				}
			}
			
			function checkLength(e)
			{
				var elength = e.value.length;
				var v = e.value;				
				if(elength>=100)
				{
					e.value = v.substring(0,100);
				}
			}
			
			function validateFormValue() {
				
				var form = document.forms[0];
				
				var class_name = form.form_class_name.value;
				
				var remark = form.form_class_remark.value;
				
				var ec_sn = form.ec_sn.value;
				
				if (class_name.length < 1 || class_name.replace(/\s/g,"")=="") {			
					alert("����д�������ƣ�");
					return false;
				}		
				if(class_name.search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("�������Ʋ�����\\/|:*?<>\"'!�������ַ�");
					return false;
				}	
				if (remark.length < 1 || remark.replace(/\s/g,"")=="") {			
					alert("����д����������");
					return false;
				}
				if(isSpace(ec_sn)){
					alert("�����Ų���Ϊ�գ�");
					return false;
				}
				if(ec_sn.search(/^-?\d+$/)!=0){
					alert("�����ű��������֣�");
					return false;
				}
				return true;
			}
			function isSpace(strMain){
			var strComp=strMain;
			try{
			if (strComp=="��" || strComp=="" || strComp==" " || strComp==null || strComp=="null" || strComp.length==0 || typeof strMain == "undefined" || strMain == "undefined" ) {
			return true;
			}
			else{
			return false;
			}
			}catch(e){return false; }
			}
			
</SCRIPT>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%>
	<body class="contentbodymargin" onload="" scroll="no">
		<div id="content_02" align="center">
			<form method="post" name="formClassForm" action="addFormClass_do.jsp">
				<table width="100%" height="25" border="0" cellpadding="0" cellspacing="1" class="thin">
					<tr class="tr">
						<td width="20%" height="25" class="detailtitle" align="right">��������<font color="red">*</font>��</td>
						<td height="25">
							<input type=text name="form_class_name" style="width=50%" maxlength="100" value="<%=isEdit?formClass.getEc_name():"" %>"/>
						</td>
					</tr>
					<tr class="tr">
						<td width="20%" height="25" class="detailtitle" align="right">������<font color="red">*</font>��</td>
						<td height="25">
							<input type=text name="ec_sn" style="width=50%" maxlength="5" value="<%=isEdit?formClass.getEc_sn():ec_sn%>"/>
						</td>
					</tr>						
			        <input type=hidden name="class_id" style="width=50%" maxlength="100" value="<%=ec_id%>"/>
					<input type=hidden name="up_class_id" style="width=50%" maxlength="100" value="<%=ec_upId%>"/>	
					<tr class="tr">
						<td height="25" width="20%" class="detailtitle" align="right">��������<font color="red">*</font>��</td>
						<td height="25">
							<textarea name="form_class_remark" rows="4" cols="40" rows="5" onkeyup="checkLength(this)"><%=isEdit?formClass.getRemark():"" %></textarea>
						</td>
					</tr>
			</table>
            <hr width="100%">				
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="table">
				<tr class="tr">
					<td class="td">
						<div align="center">								
							<input name="update" type="button" onClick="saveFormClass()" class="input" value="����">
							<input name="calc" type="reset" class="input" value="����">
							<input name="calc" type="button" class="input" value="����" onClick="window.close();window.returnValue=true;">
					    </div>
					</td>
				</tr>
			  </table>
			</form>
		</div>
		<div id=divProcessing style="width:200px;height:30px;position:absolute;left:100px;top:260px;display:none">
			<table border="0" cellpadding="0" cellspacing="1" bgcolor="#000000" width="100%" height="100%">
				<tr>
					<td bgcolor=#3A6EA5>
						<marquee align="middle" behavior="alternate" scrollamount="5">
							<font color=#FFFFFF>...������...��ȴ�...</font>
						</marquee>
					</td>
				</tr>
			</table>
		</div>
	</body>
	<iframe name="hiddenFrame" width="0" height="0"></iframe>
</html>