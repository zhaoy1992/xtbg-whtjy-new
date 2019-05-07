<%     
  response.setHeader("Cache-Control", "no-cache"); 
  response.setHeader("Pragma", "no-cache"); 
  response.setDateHeader("Expires", -1);  
  response.setDateHeader("max-age", 0); 
%>
<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<% 
	//�Ƿ�����ʷģ��ͳ�Ʋ�ѯ   y     n
	String isHis = request.getParameter("isHis");
	//System.out.println("isHis = " + isHis);
	
	//start query condition
	//String opRemark5 = request.getParameter("opRemark5");
	//if(opRemark5 == null){
	//	opRemark5 = "";
	//}
	//String opOrgid = request.getParameter("opOrgid");
	//if(opOrgid == null){
	//	opOrgid = "";
	//}
	
	//String startDate = request.getParameter("startDate");
	//if(startDate == null){
	//	startDate = "";
	//}
	//String endDate = request.getParameter("endDate");
	//if(endDate == null){
	//	endDate = "";
	//}
	
	//String logVisitorial = request.getParameter("logVisitorial");
	//if(logVisitorial == null){
	//	logVisitorial = "";
	//}
	
	//String isRecursion = request.getParameter("isRecursion");
	//if(isRecursion == null){
	//	isRecursion = "0";
	//}
	//end query condition
%>
<html>
<head>
<title>ģ����־��ͳ��</title>
	<link rel="stylesheet" type="text/css" href="../css/windows.css">
	<base target="_self"/>
	<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
	
	<script type="text/javascript" langugae="Javascript">
	
	function selectOrg(){
		var url = "../../sysmanager/dictmanager/orgSelectTree.jsp";
		var returnVal = window.showModalDialog(url,window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
		if((typeof(returnVal) != "undefined") && returnVal != "" && returnVal.split("^")[0] != ""){
			document.all.opRemark5.value = returnVal.split("^")[0].split(" ")[1];
			document.all.opOrgid.value = returnVal.split("^")[0].split(" ")[0];
		}
	}
	
	function queryModuleStat()
	{	
		//��ѯ
		if(statForm.startDate.value>statForm.endDate.value)
		{
			alert("��ʼʱ�䲻�ܴ��ڽ���ʱ�䣡");
			return;
		}
		else{
			var isRecursion = "0";
		    if(document.statForm.isRecursion.checked){
		    	isRecursion = "1";
		    }
		    var opOrgid = document.all.opOrgid.value;
		    var startDate = document.all.startDate.value;
		    var endDate = document.all.endDate.value;
		    var logVisitorial = escape(escape(document.all.logVisitorial.value));
		    
		    var tablesFrame = document.getElementsByName("statIframe");
		    //document.statForm.target = "hiddenIframe";
			//document.statForm.action = "statLogmodule.jsp?isHis=<%=isHis%>";
			//resetwindow();
			var roleIdValue = document.all("statIframe").value;
  			tablesFrame[0].src = "statLogmodule_iframe.jsp?isHis=<%=isHis %>&isRecursion="+isRecursion
  				+"&opOrgid="+opOrgid+"&startDate="+startDate+"&endDate="+endDate
  				+"&logVisitorial="+logVisitorial;
		}
	}
	function resetwindow()
	{
		document.statForm.action = window.location.href;	
		document.statForm.target = "";
		
		document.statForm.submit();
		
	}
	
	function resetValue(){
        document.statForm.startDate.value = "";
        document.statForm.endDate.value = "";
        document.statForm.opRemark5.value = "";
        document.statForm.opOrgid.value = "";
        document.statForm.logVisitorial.value = "";
        document.statForm.isRecursion.checked = false;
    }
	
	</script>
</head>

<%@ include file="/epp/css/cssControl.jsp"%><body >
<form name="statForm" method="post" >
<table class="thin"  width="100%" border="0" cellpadding="0" cellspacing="1" >
<caption>��־ģ��ͳ��</caption>
<tr>
	<td class="detailtitle" width="14%" align="center">��������:</td>
		<td width="35%">
			<input type="text" name="opRemark5" value="" style="width:100%" readonly="false" onclick="selectOrg()" >
			<input type="hidden" name="opOrgid" value="" style="width:100%">
		</td>
		<td>
			<input type="checkbox" name="isRecursion" title="���ҽ���ѡ����������������Ч">�ݹ��ѯ�ӻ���
	  </td>
</tr>
<tr>
	<td>������ֹʱ�䣺
							
			</td>
			<td colspan="2">
				<input type="text" name="startDate" onclick="showdate(document.all('startDate'))" readonly="true"  validator="stringNull" cnname="��ʼʱ��" maxlength="40">
			     ��
			     <input type="text" name="endDate" onclick="showdate(document.all('endDate'))" readonly="true"  validator="stringNull" cnname="��ֹʱ��" maxlength="40">
			
			</td>
</tr>
<tr>
<td class="detailtitle"  align="center">��־��Դ:</td>
					<td colspan="2"><input type="text" name="logVisitorial"  style="width:100%"></td>
</tr>
<tr>
<td></td>
<td align="right" colspan="2">
	<input type="button" value="��ѯ" onclick="queryModuleStat()" class="input"/>
	<input type="button" value="����" onclick="resetValue()" class="input"/> 
	<input type="button" value="�ر�ҳ��" onclick="window.close();" class="input"/> 
</td>
</tr>
</table>
<table class="thin"  width="100%" border="0" cellpadding="0" cellspacing="1"  height="100%">
<tr>
<td><iframe src="statLogmodule_iframe.jsp?isHis=<%=isHis %>" name="statIframe" width="100%" height="100%"></iframe></td>
</tr>
</table>
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>