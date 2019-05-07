<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.manager.SecurityDatabase,
com.chinacreator.sysmgrcore.manager.UserManager" %>
<%
	String f = (String)request.getAttribute("iss");
	if(f == null){
		f = "1";
	}
%>
<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">

<script language="JavaScript" src="common.js" type="text/javascript"></script>
<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">	
getNavigatorContent().location.href ="../membermanager/navigator_content.jsp?anchor=0&expand=0&request_scope=session"; 
//�޸Ļ�Ա
function getRole(roleId){
	userList.action="../memberManager/roleManager.do?method=getRole&roleId="+roleId;
	userList.submit();
}

//��ѡ��ȫ��ѡ��
function checkAll(totalCheck,checkName){	
	   var selectAll = document.getElementsByName(totalCheck);
	   var o = document.getElementsByName(checkName);
	   if(selectAll[0].checked==true){
		   for (var i=0; i<o.length; i++){
	      	  if(!o[i].disabled){
	      	  	o[i].checked=true;
	      	  }
		   }
	   }else{
		   for (var i=0; i<o.length; i++){
	   	  	  o[i].checked=false;
	   	   }
	   }
}
//����ѡ�и�ѡ��
	function checkOne(totalCheck,checkName){
	   var selectAll = document.getElementsByName(totalCheck);
	   var o = document.getElementsByName(checkName);
		var cbs = true;
		for (var i=0;i<o.length;i++){
			if(!o[i].disabled){
				if (o[i].checked==false){
					cbs=false;
				}
			}
		}
		if(cbs){
			selectAll[0].checked=true;
		}else{
			selectAll[0].checked=false;
		}
	}		
//ɾ����Ա��ɫ
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
				userList.action="../memberManager/roleManager.do?method=deleteRole";
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




//������ɫ
function newRole()
{
	document.location.href="../memberManager/roleManager.do?method=newRole";	
}
//��Ա��ɫ��ѯ
function queryRole()
{	
	
	userList.action="../membermanager/memberTypeList.jsp"
	userList.submit();	
}


</SCRIPT>		
			<body>
				<form name="userList" method="post" >
					<TABLE cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
						<tr valign='top'>
           					<td height='30'valign='middle' colspan="2"><img src='../images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>��Ա��ɫ�����б�</strong></td>
         				</tr>
         			
         				
         				<tr >
           				    <td height='30'valign='middle' align="left">
           				         ��Ա��ɫ���ƣ�<input type="text" name="rolename" style="width:100px" >
           					
           					<input name="search" type="button" class="input" value="��ѯ" onClick="queryRole()">
           					</td>
         				</tr>
         				<TR>
         					<td   height='30'valign='middle' align="right" width="40%">
           						<input name="newuser" type="button" class="input" value="������ɫ" onClick="newRole()">
           						<input type="submit" value="ɾ����ɫ" class="input" onclick="javascript:dealRecord(1); return false;">
           					</td>
           					
         				</TR>
					</TABLE>
					<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
         			
         				<pg:listdata dataInfo="MemberRoleList" keyName="MemberRoleList" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager maxPageItems="13" scope="request" data="MemberRoleList" isList="false">
							<tr>
								<!--���÷�ҳ��ͷ-->
								<td class="headercolor" width="5%">
								<P align="left">
								<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
								</P>
								</td>
								<td class="headercolor"  width="15%">��Ա��ɫ����</td>
								<td class="headercolor"  width="13%">��Ա��ɫ����</td>
							</tr>
							<pg:param name="rolename" />
						
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
							<tr onmouseover="this.className='mouseover'" onmouseout="this.className= 'mouseout'"
							onDBLclick="getRole('<pg:cell colName='roleId' defaultValue=''/>')" >
									<td class="tablecells" nowrap="true">
										<P align="left">
											<INPUT type="checkbox" name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="roleId" defaultValue=""/>' >
										</P>
									</td>
									<td class="tablecells" nowrap="nowrap" >
										<pg:cell colName="roleName" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap" >
										<pg:cell colName="roleDesc" defaultValue="" />
									</td>
									
							</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=8 align='center'>
									��
									<pg:rowcount />
									����¼
									<pg:index />
								</td>
								
						    </tr>
						
						</pg:pager>

				  </table>
				</form>
				

</body>
<center>
</html>
