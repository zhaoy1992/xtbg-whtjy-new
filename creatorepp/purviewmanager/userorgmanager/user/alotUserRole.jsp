<%
/*
 * <p>Title: 角色授权处理页面 </p>
 * <p>Description: 批量角色授权处理页面</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-21
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>

<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.OrgManagerImpl"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Role"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page
	import="com.chinacreator.sysmgrcore.purviewmanager.usercheckorg.api.UserCheckOrgFactory"%>
<html>
<head>    
    <title>属性容器</title>
<%	
	AccessControl accessControl = AccessControl.getInstance();
    accessControl.checkManagerAccess(request,response);
    
	String checks = request.getParameter("checks");
	String[] id = checks.split(",");
	
	RoleManager roleManager = SecurityDatabase.getRoleManager();
	String sql = "";
	if("1".equals(accessControl.getUserID())){
		sql = "select * from td_sm_role where role_id not in('2','3','4') order by role_name";
	}else{
		sql = "select * from td_sm_role where role_id not in('1','2','3','4') order by role_name";
	}
    List list = roleManager.getRoleList(sql);
	List allRole = null;
	// 角色列表加权限
	for (int i = 0; list != null && i < list.size(); i++) {
		Role role = (Role) list.get(i);
		if (accessControl.checkPermission(role.getRoleId(),
				"roleset",
				AccessControl.ROLE_RESOURCE)) {
			if (allRole == null)
				allRole = new ArrayList();
			allRole.add(role);
		}
	}
    request.setAttribute("allRole", allRole);

    UserManager userManager = SecurityDatabase.getUserManager();
	OrgManagerImpl orgImpl = new OrgManagerImpl();
	
     String idStr = "";
     String usern = "";
     String userna = "";
     for(int i = 0;i < id.length; i++)
     {
     	idStr += id[i]+",";
     	User user = userManager.getUserById(id[i]);
     	usern= user.getUserRealname();
     	//System.out.println(usern);
     	userna += usern + ",";
     }
     if(idStr.length() > 1)
     idStr = idStr.substring(0,idStr.length()-1);
     if(userna.length() > 1)
     userna = userna.substring(0,userna.length()-1);
     
     //管理员角色与自己不能授予角色
     String orgId = request.getParameter("orgId");
     //当前用户所属机构ID
     String curUserOrgId = accessControl.getChargeOrgId();
     DBUtil db = new DBUtil();
     //是否可以授角色的 标示
     boolean tag = false;
     
     boolean tagSelf = false;
     String adminUsers = "以下用户不能进行角色授予:\\n";
     
     for(int j=0;j<id.length; j++)
     {
     	//本身是不是有管理员角色
     	//String sqlUser ="select count(*) from td_sm_userrole where user_id ="+ id[j] +" and role_id='1'";
		//db.executeSelect(sqlUser);
		User adminUser = userManager.getUserById(id[j]);
		if(accessControl.isAdminByUserid(id[j])){//有管理员角色		    
			tag = true;						
			adminUsers += adminUser.getUserName() + " 是超级管理员\\n";
		}
		
		//没有管理员角色, 但是给自己授权
		if(accessControl.getUserID().equals(id[j])){
			tag = true;
			adminUsers += adminUser.getUserName() + " 不能给自己授予角色\\n";
		}
		
		 //是部门管理员, 也不允许授权
	     // 允许部门管理员批量设置角色  baowen.liu 2008-3-21
	      List managerOrgs = orgImpl.getUserManageOrgs(id[j]);
	      if(managerOrgs.size()>0 && curUserOrgId.equals(orgId) && !accessControl.isAdmin()){
	         tag = true;
		     adminUsers += adminUser.getUserName() + " 与当前用户是同等级部门管理员\\n";
	     }

     }
     if(tag){
%>
     	<SCRIPT LANGUAGE="JavaScript">
     	var promptStr = "<%=String.valueOf(adminUsers)%>";
		alert(promptStr); 
		window.close();
		</SCRIPT>
<%
     }
%>
<%
	//屏蔽被借调用户  彭盛 2011-3-10
	StringBuffer secondUserName = new StringBuffer();
	boolean isSecondUser = UserCheckOrgFactory.getIUserCheckOrgInstance().isSecondUserByOrgIDToMess(checks,orgId,secondUserName);
%>
 
<SCRIPT LANGUAGE="JavaScript">
	var id = "<%=idStr%>";   
	function addRole()
	{	
	   var n=document.all("roleId").options.length-1;
	   var ch = false; 	
	   var size = 0;
	   for(var i=0;i<document.all("allist").options.length;i++)
	   {
		   var op=document.all("allist").options[i];
		   if(op.selected)
		   {
		   		addone(op.text,op.value,n);
		   		size ++ ;
		   }
		   ch = true;
	   }
	  if(!ch )
	  {
	  	   alert("没有选择要添加的角色");
	  	   return;
	  }
	  	
	  if(size != 0)
	  {
	   	changebox();  
	  }
	  else
	  {
	  	alert("请选择要添加的角色！");
	  }
	}
	
function addone(name,value,n){
   for(var i=n;i>=0;i--){
		if(value==document.all("roleId").options[i].value){
		  return;
		}
	}
   var op=new Option(name,value);
   document.all("roleId").add(op);
}
function deleteall(){
	var length=document.all("roleId").options.length;
	var i = 0;
	if(length == 0)
	{
		alert("没有要删除的角色。");
		return false;
	}
	var roleDelId=new Array(length);
	for (var m=length-1;m>=0;m--)
	{
	      roleDelId[i++]=document.all("roleId").options[m].value;
          document.all("roleId").options[m]=null;
    } 
    send_request('delUserRoleAlot.jsp?roleDelId='+roleDelId+'&&id='+id+'&&orgId=<%=orgId%>'); 
}
      
function addall(){
		var n=document.all("roleId").options.length-1;
		var p=document.all("allist").options.length-1;
		if(p <= 0)
		{
			
		}	  
	     for(var i=0;i<document.all("allist").options.length;i++){
	     var op=document.all("allist").options[i];
	     addone(op.text,op.value,n);  
	     
	   }
	    changebox();  
}
function deleterole(){
	var leng=document.all("roleId").options.length;
	var i = 0;
	var size = 0;
	var roleDelId=new Array();
	for (var m=leng-1;m>=0;m--){
	    if(document.all("roleId").options[m].selected)
	    {
	    roleDelId[i++]=document.all("roleId").options[m].value;
        document.all("roleId").options[m]=null;
        size ++;
        }
 	}
 	if(size > 0){
	 	send_request('delUserRoleAlot.jsp?roleDelId='+roleDelId+'&id='+id+'&&orgId=<%=orgId%>');
	 }else{
		alert("请选择要删除的角色名称！");
	 }
}


function changebox(){				 
	var len=document.all("roleId").options.length;			  	 	
    var roleId=new Array(len);
    for (var i=0;i<len;i++){	      
        roleId[i]=document.all("roleId").options[i].value;
    }    		
	send_request('saveUserRoleAlot.jsp?roleId='+roleId+'&&id='+id+'&&orgId=<%=orgId%>');
}

function send_request(url){
	http_request = false;
	if(window.XMLHttpRequest){//Mozilla
			http_request = new XMLHttpRequest();
			if(http_request.overrideMimeType){//??MIME??
				http_request.overrideMimeType("text/xml");						
				}
			}
			else if(window.ActiveXObject){//IE
				try{
					http_request = new ActiveXObject("Msxml2.XMLHTTP");
				}catch(e){
				try{
					http_request = new ActiveXObject("Microsoft.XMLHTTP");							
				}catch(e){
				}
				}
			}
			if(!http_request){
				return false;
			}
			http_request.onreadystatechange = processRequest;
			http_request.open("GET",url,true);
			http_request.send(null);
			}
			
function processRequest(){
	if(http_request.readyState == 4){				
		if(http_request.status == 200){		
			var strflag = http_request.responseText;
			if(strflag.indexOf("true") != -1){
				alert("操作成功！");
			}
			else{
				alert("操作失败！");
			}
		}
		else{
			alert("对不起,服务器出错!");
		}
		document.all("button1").disabled = false;
		document.all("button2").disabled = false;
		document.all("button3").disabled = false;
		document.all("button4").disabled = false;
		document.all("button32").disabled = false;
		divProcessing.style.display="none";
		
	}else{
		document.all("button1").disabled = true;
		document.all("button2").disabled = true;
		document.all("button3").disabled = true;
		document.all("button4").disabled = true;
		document.all("button32").disabled = true;
		divProcessing.style.display="";
		
	}
}
function init(){
	if("<%=isSecondUser%>"=="true"){
		alert("被借调用户在该机构下不能被授予角色：<%=secondUserName%>");
		window.close();
	}
}
</SCRIPT>
  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../css/treeview.css">
</head>
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no" onload="init();">
	<div id="contentborder">
	<center>
		<form name="AlotUserRoleForm" action="" method="post" >
			<table width="80%" border="0" cellpadding="0" cellspacing="1">
				<tr class="tabletop">
				    <td colspan align="center">&nbsp;</td>
				</tr>
				<tr class="tabletop">
				    <td width="40%" align="center">&nbsp;</td>
				    <td width="20%" align="center">&nbsp;</td>
				    <td width="40%" align="center">&nbsp;</td>
				  </tr>
				  <tr class="tabletop">
				    <td width="40%" align="center">可选角色</td>
				    <td width="20%" align="center">&nbsp;</td>
				    <td width="40%" align="center">给：<%=userna%>授予角色</td>
				  </tr>
				  
				  <tr >
				     <td  align="right" >
				     <select name="allist"  multiple style="width:100%" onDBLclick="addRole()" size="15">
				     
								  <pg:list requestKey="allRole">
									<option value="<pg:cell colName="roleId"/>"><pg:cell colName="roleName"/></option>
								  </pg:list>			
					</select>
					</td>				  
						  	
				    <td align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
				      <tr>
				        <td align="center"><input name="button1" type="button" class="input" value="&gt;" onclick="addRole()">              
				        </td>
				      </tr>
				      <tr>
				        <td align="center">&nbsp;</td>
				      </tr>
				      <tr>
				        <td align="center"><input name="button2" type="button" class="input" value="&gt;&gt;" onclick="addall()">
				        </td>
				      </tr>
				      <tr>
				        <td align="center">&nbsp;</td>
				      </tr>
				      <tr>
				        <td align="center"><input name="button3" type="button" class="input" value="&lt;&lt;" onclick="deleteall()">
				        </td>
				      </tr>
				      <tr>
				        <td align="center">&nbsp;</td>
				      </tr>
				      <tr>
				        <td align="center"><input name="button4" type="button" class="input" value="&lt;" onclick="deleterole()">
				        </td>
				      </tr>
				      <tr>
				        <td align="center">&nbsp;</td>
				      </tr>
				    </table></td>
				    <td >
				     <select name="roleId"  multiple style="width:100%" onDBLclick="deleterole()" size="15">
					 </select>
					 	 						
					</td>				 
					<tr>
				        <td align="center">&nbsp;</td>
				      </tr>
				      		  
				  <tr>		
				     <td colspan="3">
						<div align="center">
							<input name="button32" type="button" class="input" value="返回" onclick="window.close(); window.returnValue='ok';">
						</div>
					</td>							
				  </tr>
			 </table>
		</form>
	</center>
	</div>
	<br/>
	<div id=divProcessing style="width:200px;height:30px;position:absolute;left:300px;top:350px;display:none">
		<table border=0 cellpadding=0 cellspacing=1 bgcolor="#000000" width="100%" height="100%">
			<tr>
				<td bgcolor=#3A6EA5>
					<marquee align="middle" behavior="alternate" scrollamount="5">
						<font color=#FFFFFF>...处理中...请等待...</font>
					</marquee>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
