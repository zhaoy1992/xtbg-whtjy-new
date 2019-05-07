<%@page contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.sysmgrcore.manager.*,
com.chinacreator.sysmgrcore.entity.Role,com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request,response);	
	String roleId = request.getParameter("roleId");

	RoleManager roleManager = SecurityDatabase.getRoleManager();
	Role role = roleManager.getRoleById(roleId);
	String rolename = role.getRoleName();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
	<script src="../inc/js/func.js"></script>

	<title>��ɫ�û��б�</title>

	<script language="javascript">
		 function checkAll2(totalCheck,checkName){	
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
	
	
	function selectuser(roleId)
	{	
		form2.action="../userManage/selectuser.jsp?roleId="+roleId;
		form2.submit();	
	}
	
	function deleteRoleuser(dealType) {
	    var isSelect = false;
	    var outMsg;
		    
	    for (var i=0;i<form2.elements.length;i++) {
			var e = form2.elements[i];
				
			if (e.name == 'ID'){
				if (e.checked){
		       		isSelect=true;
		       		
		       		break;
			    }
			}
	    }
	    if (isSelect){
	    	if (dealType==1){
	    		outMsg = "��ȷ��Ҫɾ��ѡ���û���(ɾ�����ǲ������ٻָ���)��";
	        	if (confirm(outMsg)){
					form2.action="../userManage/deleteRoleuser.jsp?roleId=<%=roleId%>";
					form2.submit();
		 			return true;
				}
			} 
	    }else{
	    	alert("����Ҫѡ��һ����¼��");
	    	return false;
	    }
			return false;
	}
	
	function back()
	{	
		form2.action="../userManage/main.jsp";
		form2.submit();	
	}
	
	function openWinSelf(url,swidth,sheight){
	
     var w = showModalDialog(url,window,"dialogWidth:"+swidth+"px;dialogHeight:"+sheight+"px;help:no;scroll:auto;status:no");
	 if(w=="ok"){
	 	window.location.href = window.location.href;
	 }
	}
	</script>
</head>
<body  bgcolor="#F7F8FC" >

	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
	    <tr height="10">
	       <td>
	       </td>
	    </tr>
		<tr >
			<td colspan="2" class="topDIV"  align="left" valign="top">
					<FONT color="#8080c0"><A href="../userManage/main.jsp" >�û�Ȩ�޹���</A>>>�鿴<%=rolename%> ���������û�</FONT>
					
				</td>
		</tr>
		<tr height="20">
	       <td>
	       </td>
	    </tr>
		<tr>
			<td colspan="2">
				
<!-------------------------------------------------------------------------------------------------------------------------------->
					
					  <FORM id="form2" name="form2" method="post" onSubmit="">
						 <table  width="100%" height="30" >
						      <tr>
						      
						         <td  align="right">
						            
	                             </td>
	                           </tr>
	                           <tr>
	                           		<td  height="10" align=right >
						  			    <a style="cursor:hand" onClick="openWinSelf('../userManage/org2user.jsp?roleId=<%=roleId%>',screen.availWidth-200,screen.availHeight-200)">
						  			    <div class="DocumentOper"><img src="../images/new_doc.gif" class="operStyle">����û�</div></a>
	
										<a style="cursor:hand" onClick="javascript:deleteRoleuser(1); return false;">
						  			    <div class="DocumentOper"><img src="../images/new_doc.gif" class="operStyle">ɾ��</div></a>
										<a style="cursor:hand" onClick="back()">
						  			    <div class="DocumentOper"><img src="../images/new_doc.gif" class="operStyle">����</div></a>
						 			</td>
	                           </tr>
						    </table>
					 
						   
						    
						 
					
						<hr width="100%">
						<table width="100%" border="0" cellpadding="3" cellspacing="0" class="Templateedittable">
						    <pg:listdata dataInfo="RoleSubUserList" keyName="RoleSubUserList" />
							<!--��ҳ��ʾ��ʼ,��ҳ��ǩ��ʼ��-->
							<pg:pager maxPageItems="10" scope="request" data="RoleSubUserList" isList="false">
							<tr>
								<td width="10%" height="24"   bgcolor="#EDEFF6">
									<input type="checkBox" name="checkBoxAll2" onClick="checkAll2('checkBoxAll2','ID')">ȫѡ
								</td>
								<td width="15%" height="24"   bgcolor="#EDEFF6">�û��ʺ�</td>
								<td width="25%" height="24"   bgcolor="#EDEFF6">��ʵ����</td>
								<td width="15%" height="24"   bgcolor="#EDEFF6">�����ʼ�</td>
								<td width="10%" height="24"   bgcolor="#EDEFF6">��ǰ״̬</td>
								<td width="10%" height="24"   bgcolor="#EDEFF6">ע��ʱ��</td>
							</tr>
							<pg:param name="userId" />
							<pg:param name="userName" />
							<pg:param name="roleId"/>
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
								
								<tr class="cms_data_tr" id="<pg:cell colName="userId" defaultValue=""/>" onMouseOver="high(this)" onMouseOut="unhigh(this)">
									<td height='25' class="tablecells" nowrap="nowrap">
										<input onClick="" type="checkbox" name="ID" value="<pg:cell colName="userId" defaultValue=""/>">
									</td>
									<td height='25' class="tablecells" nowrap="nowrap">
										<a style="cursor:hand" onclick="openWin('../userManage/userManager.do?method=getUser&userId=<pg:cell colName="userId" defaultValue=""/>',screen.availWidth-300,screen.availHeight-100)">
						  			    <pg:cell colName="userName" defaultValue="" />
						  			    </a>
									</td>
									<td height='25' class="tablecells" nowrap="nowrap">
										<pg:cell colName="userRealname" defaultValue="" />
									</td>
								
									<td height='25' class="tablecells" nowrap="nowrap">
										<pg:cell colName="userEmail" defaultValue="" />
									</td>									
									<td height='25' class="tablecells" nowrap="nowrap">
<!--										<pg:cell colName="userIsvalid" defaultValue="" />-->
										<pg:equal colName="userIsvalid" value="0">��ɾ��</pg:equal>
							         	<pg:equal colName="userIsvalid" value="1">������</pg:equal>
							         	<pg:equal colName="userIsvalid" value="2">�ѿ�ͨ</pg:equal>
							        	<pg:equal colName="userIsvalid" value="3">ͣ��</pg:equal>
									</td>
									<td height='25' class="tablecells" nowrap="nowrap">
										<pg:cell colName="user_Regdate" defaultValue="" />
									</td>
								</tr>
							</pg:list>
							<tr height="18px" class="labeltable_middle_tr_01">
								<td colspan=6 align='center'>
								��<pg:rowcount/>����¼	<pg:index />
								</td>
							</tr>
							<input name="queryString" value="<pg:querystring/>" type="hidden">
						</pg:pager>						
					  </table>	
					  </FORM>
							
			</td>
		</tr>
  </table>	

<iframe name="exeman" width="0" height="0" style="display:none"></iframe>
</body>
</html>
