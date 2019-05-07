<%@ page contentType="text/html; charset=GBK" language="java"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ include file="../../sysmanager/include/global1.jsp"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="java.util.List"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.RoleType"%>
<%@ page import="com.chinacreator.security.AccessControl,com.chinacreator.sysmgrcore.manager.*,
com.chinacreator.sysmgrcore.entity.Role,com.chinacreator.sysmgrcore.manager.SecurityDatabase,
com.frameworkset.common.poolman.DBUtil"%>
<%			
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", -1);
			response.setDateHeader("max-age", 0);

			AccessControl accesscontroler = AccessControl.getInstance();
			accesscontroler.checkAccess(request, response);
			String roleId = request.getParameter("roleId");
			String flag = request.getParameter("flag");	
								
			//���޸Ľ�ɫʱ�������ɫidΪ1��2��3��4ʱ��ֹ�޸�
			//2008-4-18  baowen.liu
			String isDisabled="";
			if(flag.equals("1")){
				if(roleId.equals("1") || roleId.equals("2") || roleId.equals("3") || roleId.equals("4"))
					{
					  	isDisabled="disabled='true'";
					}
			  }
			
			//System.out.println("..........."+roleId);
			Role role = null;
			String rolename ="";
			String roledesc ="";
			String roletypeid="";
			if(roleId!=null){
				RoleManager roleManager = SecurityDatabase.getRoleManager();
				role = new Role();
				role = roleManager.getRoleById(roleId);
				rolename = role.getRoleName();
				roledesc = role.getRoleDesc();
			    roletypeid = role.getRoleType();
				
			}
	String roleTypeid = String.valueOf(session.getAttribute("roleTypeid"));
	session.removeAttribute("roleTypeid");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<link href="../inc/css/cms.css" rel="stylesheet" type="text/css">
	<script src="../inc/js/func.js"></script>
	<style type="text/css">

</style>
	<head>

		<title>
		<%if(flag.equals("1")){%>
			CMS �޸Ľ�ɫ
		<%}else{%>
			CMS �½���ɫ
		<%}%>
		</title>
	</head>
	<script language="javascript">
		function trim(string){
		  var temp="";
		  string = ''+string;
		  splitstring = string.split(" ");
		  for(i=0;i<splitstring.length;i++){
		    temp += splitstring[i];
		  } 
		  return temp;
		}
		
		function storeRole()
		{	
			var roleName= document.forms[0].roleName.value;
				if (trim(roleName).length == 0 ){
		    	alert("��ɫ������Ϊ�գ�"); 
		    	return false;
		    } 
		    if (document.forms[0].roleDesc.value.length < 1 || document.forms[0].roleDesc.value.replace(/\s/g,"")=="") {			
					alert("��ɫ����������д");
					return;
				}	
			if (document.forms[0].roleName.value.length == "adminstrator") {			
					alert("ϵͳ����Ա�����޸ġ�лл����:)");
					return;
				}	
				
			if ((document.forms[0].roleType.value==""))
  	  			{
		  	  	    alert("��ѡ���ɫ���");		  	  	
		  	  	    return;
  	  	        }
  	  	        
  	  	        var rn = document.forms[0].roleName.value;
				var rd = document.forms[0].roleDesc.value;
				if(rn.search(/[\\\/\|:\*\?!<>"']/g)!=-1){
					alert("��ɫ���Ʋ�����\\/|:*?!<>\"'!�������ַ�");
					return;
				}	
				if(rd.search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("��ɫ����������\\/|:*?<>\"'!�������ַ�");
					return;
				}
				
				if(rn.length>100)
				{
					alert("��ɫ���ƹ���,������100�ַ�����!");
					return;
				}
				if(rd.length>100)
				{
					alert("��ɫ��������,������100�ַ�����!");
					return;
				}
  	  	        			
			roleform.action="../userManage/addRole_do.jsp";
			roleform.submit();	
		}
		
		function updateRole()
		{	
			var form = document.forms[0];
				if (form.roleName.value.length < 1 || form.roleName.value.replace(/\s/g,"")=="") 
				{			
					alert("��ɫ���Ʊ�����д");
					return;
				}
				if (form.roleDesc.value.length < 1 || form.roleDesc.value.replace(/\s/g,"")=="") 
				{			
					alert("��ɫ����������д");
					return;
				}				
				
				if (form.roleName.value.length == "adminstrator") 
				{			
					alert("ϵͳ����Ա�����޸ġ�лл����:)");
					return;
				}
				
				var rn = form.roleName.value;
				var rd = form.roleDesc.value;
				if(rn.search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("��ɫ���Ʋ�����\\/|:*?<>\"'!�������ַ�");
					return;
				}	
				if(rd.search(/[\\\/\|:\*\?<>"']/g)!=-1){
					alert("��ɫ����������\\/|:*?<>\"'!�������ַ�");
					return;
				}
				
				if(rn.length>100)
				{
					alert("��ɫ���ƹ���,������100�ַ�����!");
					return;
				}
				if(rd.length>100)
				{
					alert("��ɫ��������,������100�ַ�����!");
					return;
				}
				if ((form.roleType.value==""))
  	  			{
		  	  	    alert("��ѡ���ɫ���");		  	  	
		  	  	    return;
  	  	        }
				
			roleform.action="../userManage/updateRole_do.jsp";
			roleform.submit();	
		}
		
		function back()
		{	
			window.close();
		}
	</script>
	<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
	<base target="_self">
	<body bgcolor="#F7F8FC">
	<script language="javascript">
	
	</script>

		<!--����Ĵ��� ʹ�ð� F5��ˢ��modalҳ��-->
		<form target="addgather" name="roleform">
			<input name="doctype" value="0" type=hidden>
			<input name="userid" value="" type=hidden>
			
			<table width="100%" border="0" cellpadding="0" cellspacing="0" background="../images/Gather_Content_topbg.gif">
				<tr>
					<td width="100" height="35" class="cms_title_blue">
					<%if(flag.equals("1")){%>
					<input type="hidden" name="roleId" value="<%=roleId%>"/>
					CMS �޸Ľ�ɫ
					<%}else{%>
					CMS �½���ɫ
					<%}%>
					</td>
				</tr>
			</table>
					
			<table width="100%" border="0" cellpadding="3" cellspacing="0">
					</br>
					
					<tr class="tr">
						<td height="25" >
							<strong>��ɫ���ƣ�*</strong>
						</td>
						<td height="25" align="left">
							
							<input type="text" name="roleName" style="width:300"  class="cms_text" value="<%=rolename%>" <%if(flag.equals("1")){%> readonly=readonly <%}%> <%=isDisabled%>>
						</td>
					</tr>
					<tr class="tr">
						<td height="25">
                        	<strong>��ɫ���:*</strong>
                         </td>
                         <td height="25" align="left">
                         <%if(flag.equals("0")){%>
		                        <select name="roleType" class="cms_select" >
								<option value="">--��ѡ���ɫ���--</option>
								<%
								List typenamelist = null;
								RoleTypeManager rtm = new RoleTypeManager();
								typenamelist = rtm.getTypeNameList();
								request.setAttribute("typenamelist",typenamelist);
								%>
								<pg:list requestKey="typenamelist">
								<option value="<pg:cell colName="roleTypeID"/>"
								    <pg:equal colName="roleTypeID" value="<%=roleTypeid%>">
										selected
										</pg:equal>
								 >
								<pg:cell colName="typeName"/> 
								</pg:list>
								</select>	
						
						<%} else {%>	
						<select name="roleType" class="cms_select" <%=isDisabled%> >						
						<%
						List typenamelist = null;
						RoleTypeManager rtm = new RoleTypeManager();
						typenamelist = rtm.getTypeNameList();
						if(typenamelist != null)
						{
							for(int i=0;i<typenamelist.size();i++)
							{
								RoleType rt = (RoleType)typenamelist.get(i);
								if(roletypeid.equals(rt.getRoleTypeID()))
								{
						%>
									<option value="<%=rt.getRoleTypeID()%>" selected> <%=rt.getTypeName()%></option>
									<%
								}
								else
								{
									%>
									<option value="<%=rt.getRoleTypeID()%>"><%=rt.getTypeName()%></option>
									<%
								}
							}
						}
						}%>												
						</select>		
						
                         </td>					
					
					</tr>
					<tr class="tr">
						<td height="25" >
							<strong>������*</strong>
						</td>
						<td height="25"  align="left">
							<textarea name="roleDesc" style="width:300" cols="50" rows="4" defaultValue="" <%=isDisabled%> ><%=roledesc%></textarea>
						</td>
						
					</tr>
				</table>
				
				<table width="100%" border="0" cellpadding="3" cellspacing="0">

					<tr>
						<td>
							<div align="center">
								<%if(flag.equals("1")){ %>
																									   
									<input name="update" type="button" onClick="updateRole()" class="cms_button" value="�޸�" <%=isDisabled%> >
								
								 <%    
								   }else{%>
									<input name="save" type="button" onClick="storeRole()" class="cms_button" value="����">
								<%}%>
								
								
								<input name="delete1" type="button" onClick="back()" class="cms_button" value="�ر�">
							</div>
						</td>
					</tr>
				</table>

			
		</form>

		<iframe name="addgather" width="0" height="0">
		</iframe>

	</body>
</html>
