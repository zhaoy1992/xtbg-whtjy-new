<%
/*
 * <p>Title: ������ɫ</p>
 * <p>Description: ������ɫ</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-18
 * @author liangbing.tao
 * @version 1.0
 */
%>

<%     
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0); 
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group" %>
<%@ page import="com.chinacreator.security.AccessControl,
				com.chinacreator.sysmgrcore.entity.Role"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);

	String curUserId = accesscontroler.getUserID(); 
    
    //����ID���л�ȡ
    String groupId=request.getParameter("groupId");
    
    //ʵ�����ӿڽ������ɫ�Ļ�ȡ
	GroupManager groupManager=SecurityDatabase.getGroupManager();

	List containRoleList=groupManager.getGroupRolesByGroupId(groupId);
	Group group=groupManager.getGroupByID(groupId);
	String groupName=group.getGroupName();	
	RoleManager roleManager=SecurityDatabase.getRoleManager();
	List roleList=new ArrayList();
	String sql = "";
	if("1".equals(accesscontroler.getUserID()))
	{
		sql = "select * from td_sm_role r where r.role_Id <> '2' and r.role_Id <> '3' and r.role_ID <> '4' order by r.role_Name";
	}
	else
	{
		sql = "select * from td_sm_role r where r.role_Id <> '1' and r.role_Id <> '2' and r.role_Id <> '3'and r.role_Id <> '4' order by r.role_Name";
	}
	roleList=roleManager.getRoleList(sql);
	List allRole = null;
	
	// ��ɫ�б��Ȩ��
	for (int i = 0; roleList != null && i < roleList.size(); i++) {
		Role role = (Role) roleList.get(i);
		if (String.valueOf(role.getOwner_id()).equals(curUserId)) {
			if (allRole == null){
				allRole = new ArrayList();
			}
			if (AccessControl.isAdministratorRole(role.getRoleName())) {
				allRole.add(role);
			}else{
				if (!role.getRoleName().equals(
						AccessControl.getEveryonegrantedRoleName())) {
					allRole.add(role);
				}
			}
		}
	}
	
	//�����صĽ�ɫ���ϴ洢��ҳ�滺�湩�б���ǩ��ȡ����Դʹ��
	request.setAttribute("existRole",containRoleList);//�������ɫ
	if(accesscontroler.isAdmin()){
		request.setAttribute("allRole",roleList);//���н�ɫ
	}else{
		request.setAttribute("allRole",allRole);//���н�ɫ
	}
%>
<html>
	<head>    
  		<title>��<%=groupName%>���û��������ɫ</title>
  		<link rel="stylesheet" type="text/css" href="../css/windows.css">
  		
  		<script language="JavaScript">
  		var allowSubmit=false; 
		//���ѡ�еĽ�ɫ
		function addRole()
		{	
   			var selectRoleIds="";
   			var selectedDrop=document.all("roleId");
   			var count=document.all("allist").options.length;
   			for(var i=0;i<count;i++)
   			{
   				//
   				var op=document.all("allist").options[i];
   				if(op.selected)
   				{
   					//	
					addone(op.text,op.value);
					//
					if(allowSubmit)selectRoleIds+=","+op.value;
				}
   			}
   			if(selectRoleIds.length>0)send_request(selectRoleIds,'add');
		}
		//������еĽ�ɫ
		function addall()
		{
    		var selectRoleIds="";
			var count=document.all("allist").options.length;	  
    		for(var i=0;i<count;i++)
    		{
     			var op=document.all("allist").options[i];
     			addone(op.text,op.value);  
     			if(allowSubmit)selectRoleIds+=","+op.value;
    		}
   			if(selectRoleIds.length>0)send_request(selectRoleIds,'add');
		}
		//���б���е�ѡ�����׷��
		function addone(name,value)
		{
   			allowSubmit=true;
   			for(var i=0;i<document.all("roleId").options.length;i++)
  			{
	 			if(value==document.all("roleId").options[i].value)
	 			{
	 				allowSubmit=false;
	 				break;
	 			}
  			}
   			if(allowSubmit)document.all("roleId").add(new Option(name,value));
		}
		//ɾ��ѡ�еĽ�ɫ
		function deleteRole()
		{	
    		var selectRoleIds="";
 			for(var m=document.all("roleId").options.length-1;m>=0;m--)
 			{
	    		if(document.all("roleId").options[m].selected)
	    		{
	    			selectRoleIds+=","+document.all("roleId").options[m].value;
	    			document.all("roleId").options.remove(m);
	    		}
			}
			if(selectRoleIds.length>0)send_request(selectRoleIds,'delete');
		}
			
		//ɾ�����еĽ�ɫ
		function deleteall()
		{
    		var selectRoleIds="";
    		var count=document.all("roleId").options.length;
			for (var m=0;m<count;m++)
			{
	    		selectRoleIds+=","+document.all("roleId").options[m].value;
			}
			if(selectRoleIds.length>0)
			{
				document.all("roleId").innerHTML="";
    			send_request(selectRoleIds,'delete');
   			}	
		}
		//�������ύ������֡���д���
		function send_request(selectRoleIds,flag)
		{
    		selectRoleIds=selectRoleIds.substring(1,selectRoleIds.length);
    		
    		document.all("button1").disabled = true;
    		document.all("button2").disabled = true;
    		document.all("button3").disabled = true;
    		document.all("button4").disabled = true;
    		document.all("back").disabled = true;
    		
			document.all.divProcessing.style.display = "block";
			document.RoleOrgForm.action = 'editgrouprole_ajax.jsp?roleId='+selectRoleIds+'&groupId='+document.all("groupId").value+'&flag='+flag;
			document.RoleOrgForm.target = "hiddenFrame";
			document.RoleOrgForm.submit();
		}
		</script>
	<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
	<div id="contentborder">
	<center>
	<form name="RoleOrgForm" action="" method="post" >
	<table width="80%" border="0" cellpadding="0" cellspacing="1">
	<tr class="tabletop">
    	<td width="40%" align="center">&nbsp;</td>
    	<td width="20%" align="center">&nbsp;</td>
    	<td width="40%" align="center">&nbsp;</td>
  	</tr>
  	<tr class="tabletop">
    	<td width="40%" align="center">��ѡ��ɫ</td>
    	<td width="20%" align="center">&nbsp;</td>
    	<td width="40%" align="center">�������ɫ</td>
  	</tr>
  	<tr class="tabletop">
   	 	<td width="40%" align="center">&nbsp;</td>
    	<td width="20%" align="center">&nbsp;</td>
    	<td width="40%" align="center">&nbsp;</td>
  	</tr>
  	<tr >
     	<td  align="right">
      	<select name="allist"  multiple style="width:80%" onDBLclick="addRole()" size="18">
				  <pg:list requestKey="allRole">
					<option value="<pg:cell colName="roleId"/>"><pg:cell colName="roleName"/></option>
				  </pg:list>			
		</select>
		</td>				  
		  	
    	<td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
     <tr>
        <td align="center"><input name="button1" type="button" class="input" value="&gt;" onclick="addRole()"></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button2" type="button" class="input" value="&gt;&gt;" onclick="addall()"></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button3" type="button" class="input" value="&lt;&lt;" onclick="deleteall()"></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
      <tr>
        <td align="center"><input name="button4" type="button" class="input" value="&lt;" onclick="deleteRole()"></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
      </tr>
    </table></td>
    <td >
    <select name="roleId"  multiple style="width:80%" onDBLclick="deleteRole()" size="18">
				  <pg:list requestKey="existRole">
					<option value="<pg:cell colName="roleId"/>"><pg:cell colName="roleName"/></option>
				  </pg:list>			
	 </select>			
					
	</td>				 
				  
  </tr>
  <tr class="tabletop">
    <td width="40%" align="center">&nbsp;</td>
    
  </tr>
  <tr>
  	<td colspan="3" align="center">
  
  		<input type="button" value="����" name="back" class="input" onclick="window.close()"/>
  	</td> 
  </tr>
</table>
<input type="hidden" name="groupId" value="<%=groupId%>"/>
</form>
</center>
</div>
<div id=divProcessing style="width:200px;height:30px;position:absolute;left:230px;top:450px;display:none">
	<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
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
<iframe name="hiddenFrame" width=0 height=0></iframe>
</html>