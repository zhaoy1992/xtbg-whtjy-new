<%@ page language="java" contentType="text/html;charset=GBK"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@page import="com.chinacreator.security.AccessControl,com.frameworkset.common.poolman.DBUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    String rootpath = request.getContextPath();
    
    String curUserId = accesscontroler.getUserID();
%>
<html >
      

<head>
<link rel="stylesheet" type="text/css" href="../css/windows.css">
<script language="JavaScript" src="<%=request.getContextPath()%>/public/datetime/calender_date.js" ></script>
<script language="JavaScript">
	
	function queryUser(isHis)
	{	
		//��ѯ
		if(LogHisForm.startDate.value>LogHisForm.endDate.value)
		{
			alert("��ʼʱ�䲻�ܴ��ڽ���ʱ�䣡");
			return;
		}
		else{
		    //document.all.logGrid.src="logList.jsp?curUserId=<%=curUserId%>"
		    //+"&operUser="+document.all.operUser.value
		    //+"&oper="+document.all.oper.value
		    //+"&type="+document.all.type.value
		    //+"&startDate="+document.all.startDate.value
		    //+"&endDate="+document.all.endDate.value
		    //+"&logModuel="+document.all.logModuel.value
		    //+"&isHis="+isHis;
			//LogForm.action="logList_tab.jsp";
            //LogForm.action="logList_tab.jsp";
			//LogForm.submit();	
			var isRecursion = "0";
		    if(document.LogHisForm.isRecursion.checked){
		    	isRecursion = "1";
		    }
			document.LogHisForm.target="logGridhis";
			document.LogHisForm.action="logList.jsp?isHis=y&isRecursion="+isRecursion;
			document.LogHisForm.submit();
		}
	}
    
    function resetForm(){
        document.all("operUser").value = "";
        document.all("oper").value = "";
        document.all("startDate").value = "";
        document.all("endDate").value = "";
    }
    
    function selectOrg(){
		var url = "../../sysmanager/dictmanager/orgSelectTree.jsp";
		var returnVal = window.showModalDialog(url,window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;help:no;scroll:auto;status:no;maximize=yes;minimize=0");
		if(typeof(returnVal) != "undefined" && returnVal != "" && returnVal.split("^")[0] != ""){
			document.all.opRemark5.value = returnVal.split("^")[0].split(" ")[1];
			document.all.opOrgid.value = returnVal.split("^")[0].split(" ")[0];
		}
	}
	
	function queryState(obj){
		window.showModalDialog("statLogmodule.jsp?isHis="+obj,window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;");
	}
</script>
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body >
<form name="LogHisForm"  method="post">
				<table width="100%" border="0"  align="center" cellpadding="0" cellspacing="1" class="thin">
					<tr valign='top'>
           					<td height='30'valign='middle' colspan="4"><img src='<%=rootpath%>/sysmanager/images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;
           					<strong>��־�б�</strong></td>
           					<td align="right"><input type="button" value="��־ģ��ͳ�Ʋ�ѯ" class="input" onclick="queryState('n')"/></td>
         			</tr>
					<tr>
						<td class="detailtitle" width="8%" align="center">
							�������ʺ�
						</td>
						<td class="detailcontent" width="20%">
							<input type="text" name="operUser" value="" style="width:100%">
						</td>
						
					  	<td class="detailtitle" width="14%"  align="center">
							��������:
						</td>
						<td class="detailcontent" width="35%">
							<input type="text" name="opRemark5" value="" style="width:100%" readonly="true" onclick="selectOrg()">
						<input type="hidden" name="opOrgid" value="" style="width:100%">
						</td>
						<td>
							<input type="checkbox" name="isRecursion" title="���ҽ���ѡ����������������Ч">�ݹ��ѯ�ӻ���
					  </td>
					</tr>
					
					<tr>
						<td class="detailtitle" width="16%" align="center">
							��־����
						</td>
						<td class="detailcontent" width="16%">
							<input type="text" name="oper" value="" style="width:100%">
						</td>
						<td>������ֹʱ�䣺
							
						</td>
						<td colspan="2">
							<input type="text" name="startDate" onclick="showdate(document.all('startDate'))" readonly="true" value="" validator="stringNull" cnname="��ʼʱ��" maxlength="40">
						     ��
						     <input type="text" name="endDate" onclick="showdate(document.all('endDate'))" readonly="true" value="" validator="stringNull" cnname="��ֹʱ��" maxlength="40">
						
						</td>
					</tr>
					<tr>
					<td class="detailtitle"  align="center">��־ģ��</td>
					<td>
					<select name="logModuel" class="cms_select" style="width:120" onChange="">
								<option value="">����ģ��</option>
							<!-- <pg:listdata dataInfo="LogModuleList" keyName="LogModuleList" />-->
							<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
							<!--<pg:pager maxPageItems="15" scope="request" data="LogModuleList" isList="false">
							<pg:list>
							
								<option value="<pg:cell colName="LOGMODULE" defaultValue="" />"><pg:cell colName="LOGMODULE" defaultValue="" /></option>												
							
							</pg:list>
							</pg:pager> �����б�Ӧ���ñ�ǩ��ҳ?weida-->
							<%
							try {
								DBUtil dbUtil = new DBUtil();
								String hsql ="select * from TD_SM_LOGMODULE order by logmodule";
								dbUtil.executeSelect(hsql);
								for(int i = 0; i < dbUtil.size(); i ++)
								{
									%>
									<option value="<%=dbUtil.getString(i,"LOGMODULE")%>"><%=dbUtil.getString(i,"LOGMODULE")%></option>
									<%
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
							%>
							</select>
						
					</td>
					
					<td class="detailtitle"  align="center">��־��Դ:</td>
					<td><input type="text" name="logVisitorial" value="" style="width:100%"></td>
					
					<td align="center">
								<input name="search" type="button" class="input" value="��ѯ" onClick="queryUser('y')">
								<input name="Submit22" type="reset" class="input" value="����" onClick="resetForm()">
					</td>
					</tr>
					</table>
					<table width="100%" border="0"  align="center" cellpadding="0" cellspacing="0" class="thin">
					<tr>
					<td>
				  <iframe src="logList.jsp?isHis=y" name="logGridhis"  width="100%" height="430px" frameborder=0 style="display:inline"></iframe>				
					</td>
					</tr>
			  </table>
	          <div align="center"></div>
			</form>
			
			</body>
</html>