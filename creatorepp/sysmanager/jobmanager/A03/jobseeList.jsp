<%@ include file="../../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%
	
	
%>
<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
		<link rel="stylesheet" type="text/css" href="../sysmanager/css/windows.css">
  		<link rel="stylesheet" type="text/css" href="../sysmanager/css/contentpage.css">
  		<link rel="stylesheet" type="text/css" href="../sysmanager/css/tab.winclassic.css">
		
<script language="JavaScript" src="common.js" type="text/javascript"></script>
<script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">	



function dealRecord(dealType) {
    var isSelect = false;
    var outMsg;
	    
    for (var i=0;i<userList.elements.length;i++) {
		var e = userList.elements[i];
			
		if (e.name == 'checkBoxOne'){
			if (e.checked){
	       		isSelect=true;
	       		break;
		    }
		}
    }
    if (isSelect){
    	if (dealType==1){
    		outMsg = "��ȷ��Ҫɾ����(ɾ�����ǲ������ٻָ���)��";
        	if (confirm(outMsg)){
				userList.action="../user/userManager.do?method=deleteUser&disuser=1";
				userList.submit();
	 			return true;
			}
		} 
    }else{
    	alert("����Ҫѡ��һ����¼��");
    	return false;
    }
	return false;
}
	

function actionOnmouseover(e){	
	e.style.backgroundColor = "#8080FF";
}

function actionOnmouseup(e){
	e.style.backgroundColor = "#BEC0C2";
}


function queryUser()
{	
	//if(document.userList.userName.value.length < 1 && document.userList.userRealname.value.length < 1){
	//	alert("�û����ƺ��û�ʵ����������һ��!!!");
	//	return;
	//}
	userList.action="../../jobmanager/A03/jobseeList.jsp"
	userList.submit();	
}


</SCRIPT>		
			<%@ include file="/epp/css/cssControl.jsp"%><body >
				<form name="userList" method="post" >
					<table cellspacing="0" cellpadding="0" border="1" bordercolor="#EEEEEE" width=98% >
         				<tr valign='top'>
           					<td height='30'valign='middle' colspan="5">&nbsp;<strong>�û���ְ����б�</strong></td>
         				</tr>
         				<tr >
           					
           					<td height='30'valign='middle' align="center">�û�������<input type="text" name="userName" ></td>
           					<td height='30'valign='middle' align="center">���ڻ�����<input type="text" name="orgname" ></td>
           					<td height='30'valign='middle' align="center" colspan="2">������λ��<input type="text" name="jobname" >
           				    </td>
           					<td height='30'valign='middle' align="center" colspan="2">
           						<input name="search" type="button" class="input" value="��ѯ" onClick="queryUser()">
           					</td>
           				</tr>
						<pg:listdata dataInfo="JobSeeList" keyName="JobSeeList" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager maxPageItems="15" scope="request" data="JobSeeList" isList="false">
							<tr>
								<!--���÷�ҳ��ͷ-->
								
								<th class="headercolor" height='30'>�û�����</th>
								<th class="headercolor">������λ</th>
								<th class="headercolor">���ڻ���</th>
								<th class="headercolor">�ϸ�ʱ��</th>								
								<th class="headercolor">��λ״̬</th>
							</tr>
							<pg:param name="orgname" />
							<pg:param name="userName" />
							<pg:param name="jobname" />

							<!--��⵱ǰҳ���Ƿ��м�¼-->
							<pg:notify>
								<tr height="18px" class="labeltable_middle_tr_01">
									<td colspan=100 align='center'>
										��ʱû���û�
									</td>
								</tr>
							</pg:notify>

							<!--list��ǩѭ�����ÿ����¼-->
							<pg:list>								
								<tr onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'" onclick="" >
									
									<td class="tablecells" nowrap="nowrap" height='20'>
										<pg:cell colName="userRealname" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="jobName" defaultValue="" />
									</td>									
									<td class="tablecells" nowrap="nowrap" >
										<pg:cell colName="orgName" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="jobStartTime" defaultValue="δ֪" dateformat="yyyy-MM-dd HH:mm:ss"/>
									</td>
									
									<td class="tablecells" nowrap="nowrap">
										
										<pg:equal colName="fettle" value="1">�ڸ�</pg:equal>
					  					<pg:equal colName="fettle" value="0">δ֪</pg:equal>																										    					    							    				    		
					  					<pg:equal colName="fettle" value=" ">δ֪</pg:equal>
									</td>	
								</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=4 align='center'>
									<pg:index />
								</td>						
							</tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>

					</table>
				</form>
<%@ include file="../../sysMsg.jsp"%>
			</body>
			<center>
</html>
