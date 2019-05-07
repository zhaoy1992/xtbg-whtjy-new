<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../sysmanager/base/scripts/panes.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@page import="java.util.*,com.chinacreator.sysmgrcore.manager.SecurityDatabase,
com.chinacreator.sysmgrcore.manager.UserManager,com.chinacreator.sysmgrcore.manager.RoleManager" %>
<%@page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    String succeed = (String)request.getAttribute("succeed");
    String isok =(String)request.getAttribute("isok"); 
    String name =(String)request.getAttribute("name");
    String pass =(String)request.getAttribute("pass");
    String deleteuser =(String)request.getAttribute("deleteuser");
    String password =(String)request.getAttribute("password");
%>
<html>
	<head>
		<title>��������</title>
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/windows.css">
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../../sysmanager/css/tab.winclassic.css">

<script language="JavaScript" src="common.js" type="text/javascript"></script>
<script language="JavaScript" src="../../sysmanager/include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">	
var succeed ="<%=succeed%>";
var pass ="<%=pass%>";
var deleteuser ="<%=deleteuser%>";
if(succeed=="ok"){
	alert("�޸Ļ�Ա��Ϣ�ɹ���");
}
if(pass=="ok"){
	alert("�����ѻָ�Ϊ��ʼ���룡");
}
if(deleteuser=="ok"){
	alert("ɾ���շ��û��ɹ���");
}
var isok = "<%=isok%>";
var name ="<%=name%>";
var password ="<%=password%>";
if ( isok == "ok"){
	alert("�����շ��û��ɹ����û��ʺţ�"+name+"  ���룺"+password);
}
//�޸Ļ�Ա
function getMember(memberId,userType){
	userList.action="../member/memberManager.do?method=getMember&flag=2&memberId="+memberId+"&userType="+userType;
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
//ɾ����Ա
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
				userList.action="../member/memberManager.do?method=deleteMember&flag=2";
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
//��ͨ��Ա
function onMember(dealType) {
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
    		outMsg = "��ȷ��Ҫ��ͨʹ����ѡ��Ա��";
        	if (confirm(outMsg)){
				userList.action="../member/memberManager.do?method=dredgeMember";
				userList.submit();
	 			return true;
			}
		} 
    }else{
    	alert("��ѡ����Ҫ��ͨ�Ļ�Ա��");
    	return false;
    }
	return false;
}

//ͣ�û�Ա
function offMember(dealType) {
    var isSelect = false;
  
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
    		outMsg = "��ȷ��Ҫͣ����ѡ��Ա��";
        	if (confirm(outMsg)){
				userList.action="../member/memberManager.do?method=offMember";
				userList.submit();
	 			return true;
			}
		} 
    }else{
    	alert("��ѡ����Ҫͣ�õĻ�Ա��");
    	return false;
    }
	return false;
}

//��Ա�ȼ��趨
function rankMember(dealType) {
    var isSelect = false;
  
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
    		outMsg = "��ȷ��Ҫ�趨��ѡ��Ա�Ľ�ɫ��";
        	if (confirm(outMsg)){
				userList.action="../member/memberManager.do?method=rankMember";
				userList.submit();
	 			return true;
			}
		} 
    }else{
    	alert("��ѡ����Ҫ�趨��ɫ�Ļ�Ա��");
    	return false;
    }
	return false;
}

//������Ա
function newMember()
{
	document.location.href="../member/memberManager.do?method=newMember&flag=2";	
}
//��Ա��ѯ
function queryUser()
{	
	
	if(userList.nologin.value.search(/[^0-9]/g) !=-1){
		alert("ֻ���������֣�");
		userList.nologin.focus();
		return false;
	}
	userList.action="../sitemember/charge_memberList.jsp"
	userList.submit();	
}


</SCRIPT>		
			<body>
				<form name="userList" method="post" >
					<TABLE cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
						<tr valign='top'>
           					<td height='30'valign='middle' ><img src='../../sysmanager/images/edit.gif' width="16" height="16" border=0 align='absmiddle'>&nbsp;<strong>�շ��û��б�</strong></td>
         				</tr>
         			
         				
         				<tr >
           				    <td height='30'valign='middle' align="left" >
           				     
           						<%
           							UserManager userManager = SecurityDatabase.getUserManager();
           							RoleManager roleManager = SecurityDatabase.getRoleManager();
           							List listtype = userManager.getmemberTypeList("3");
           							List listIsvalid = userManager.getmemberTypeList("19");
           							List listrole = roleManager.getRoleList("select * from td_sm_Role r where r.role_Type='member' and r.role_Id<>'15' order by r.role_Name");
           							request.setAttribute("mtllist",listtype);
									request.setAttribute("isllist",listIsvalid);
									request.setAttribute("listrole",listrole);           							
           						%>
           						
           						
							
								
								��Ա���
								<select name="rank" style="width:100px" >
								<option value="">
										--��ѡ��ȼ�--
								</option>
       							<option value="A">
									A���Ա
								</option>
								<option value="B">
									B���Ա
								</option>
								<option value="C">
									C���Ա
								</option>
								<option value="D">
									D���Ա
								</option>
								<option value="E">
									E���Ա
								</option>
								<option value="F">
									F���Ա
								</option>
							</select>
<!--           						<select name="rank" style="width:100px" >-->
<!--           							<option value="">-->
<!--										--��ѡ��ȼ�---->
<!--									</option>-->
<!--									<pg:list requestKey="listrole">-->
<!--										<option value="<pg:cell colName="roleId"/>">-->
<!--										<pg:cell colName="roleName"/> -->
<!--										</option>-->
<!--									</pg:list>	-->
<!--								</select>-->
								
								��Ա״̬��
           						<select name="state" style="width:100px" >
           							<option value="">
										--��ѡ��״̬--
									</option>
									<pg:list requestKey="isllist">
										<option value="<pg:cell colName="dictdataValue"/>">
										<pg:cell colName="dictdataName"/> 
										</option>
									</pg:list>	
								</select>
									
           						����/�����û���
           						<select name="Isvalid" style="width:100px" >
           							<option value="">
										--��ѡ��״̬--
									</option>
									<option value="1">
										�����û�
									</option>
									<option value="0">
										�����û�
									</option>
								</select>	
							
							</td>				
           					
           				</tr>
         				<tr >
           				   			
           					 <td height='30'valign='middle' align="left">
           					    �û��ʺţ�  <input type="text" name="membername" style="width:100px" >
           					    �û�������  <input type="text" name="realname" style="width:100px" >
           					    δ��½���� ��  <input type="text" name="nologin" style="width:100px" >
							    ��  ϵ ��  ַ��  <input type="text" name="address" style="width:100px" >
							             					
           					</td>
         				<TR>
         					<td  colspan="2" height='30'valign='middle' align="right" width="40%">
         						<input name="search" type="button" class="input" value="��ѯ" onClick="queryUser()">
           						<input name="newuser" type="button" class="input" value="�����û�" onClick="newMember()">
           						<input type="submit" value="ɾ���û�" class="input" onclick="javascript:dealRecord(1); return false;">
           						<input name="onuser" type="button" class="input" value="��ͨ�û�" onclick="javascript:onMember(1); return false;">
           						<input name="offuser" type="button" class="input" value="ͣ���û�" onclick="javascript:offMember(1); return false;">
           						<input name="rank" type="button" class="input" value="��ɫ����" onclick="javascript:rankMember(1); return false;">
           					</td>
           				</TR>
					</TABLE>
					<table cellspacing="1" cellpadding="0" border="0" bordercolor="#EEEEEE" width=100% class="thin">
         			
         				<pg:listdata dataInfo="ChargeMemberList" keyName="ChargeMemberList" />
						<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
						<pg:pager maxPageItems="13" scope="request" data="ChargeMemberList" isList="false">
							<tr>
								<!--���÷�ҳ��ͷ-->
								<td class="headercolor" width="5%">
								<P align="left">
								<INPUT type="checkbox" name="checkBoxAll" onclick="checkAll('checkBoxAll','checkBoxOne')" value="on">
								</P>
								</td>
								<td class="headercolor"  width="10%">�ʺ�</td>
								<td class="headercolor"  width="10%">����</td>
								<td class="headercolor"  width="10%">�û�����</td>
								<td class="headercolor"  width="15%">��ϵ��ַ</td>
								<td class="headercolor"  width="10%">��ʼʱ��</td>
								<td class="headercolor"  width="10%">����ʱ��</td>								
								<td class="headercolor"  width="10%">�û����</td>
								<td class="headercolor"  width="10%">��Ա״̬</td>								
								<td class="headercolor"  width="10%">����½ʱ��</td>
							</tr>
							<pg:param name="realname" />
							<pg:param name="Isvalid" />
							<pg:param name="memberType" />
							<pg:param name="membername" />
							<pg:param name="address" />
							<pg:param name="nologin" />
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
							onDBLclick="getMember('<pg:cell colName='userId' defaultValue=''/>','<pg:cell colName='userType' defaultValue=''/>')"  >
									<td class="tablecells" nowrap="true">
										<P align="left">
											<INPUT type="checkbox" name="checkBoxOne" onclick="checkOne('checkBoxAll','checkBoxOne')" value='<pg:cell colName="userId" defaultValue=""/>' >
										</P>
									</td>
									<td class="tablecells" nowrap="nowrap" >
										<pg:cell colName="userName" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap" >
										<pg:cell colName="userPassword" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap" >
										<pg:cell colName="userRealname" defaultValue="" />
									
									</td>
									<td class="tablecells" nowrap="nowrap" >
										<pg:cell colName="userAddress" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="dredgeTime" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="past_Time" defaultValue="" />
									</td>
									<td class="tablecells" nowrap="nowrap" >
										
										<pg:equal colName="serviceType" value="A">A���Ա</pg:equal>
										<pg:equal colName="serviceType" value="B">B���Ա</pg:equal>
										<pg:equal colName="serviceType" value="C">C���Ա</pg:equal>
										<pg:equal colName="serviceType" value="D">D���Ա</pg:equal>
										<pg:equal colName="serviceType" value="E">E���Ա</pg:equal>
										<pg:equal colName="serviceType" value="F">F���Ա</pg:equal>
									</td>
									<td class="tablecells" nowrap="nowrap">
									
										<pg:equal colName="remark1" value="1">������</pg:equal>
										<pg:equal colName="remark1" value="2">�ѿ�ͨ</pg:equal>
										<pg:equal colName="remark1" value="0">ͣ��</pg:equal>
									</td>
									<td class="tablecells" nowrap="nowrap">
										<pg:cell colName="lastlogindate" defaultValue="" dateformat="yyyy-MM-dd" />
									</td>
							</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=10 align='center'>
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
