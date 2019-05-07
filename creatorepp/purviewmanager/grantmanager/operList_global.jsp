<%
/**
 * 
 * <p>Title: 全局操作项界面</p>
 *
 * <p>Description: 所有资源的全局操作项公用页面</p>
 *
 * <p>Copyright: Copyright (c) 2007</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2006-9-15
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.OperManager,com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.config.ConfigManager"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
    
    //是否是批量授予权限 true：批量授予权限；false：单个授予权限
    String isBatch = request.getParameter("isBatch");
    //得到需要授予权限的用户ID或角色ID
    String currRoleId = (String)request.getParameter("currRoleId");
    
    //得到的授权类型  user或role
    String role_type = (String)request.getParameter("role_type");
    
    //如果授权类型为"user"的
    String orgId = (String)request.getParameter("currOrgId");
	
	//资源类型 role,organization,column....
	String resTypeId = request.getParameter("resTypeId");
	
	//资源ID
	String resId = request.getParameter("resId");
	//资源名称或描述
	String resName = request.getParameter("resName");
	
	
	//所选授权用户是否是部门管理员
	boolean isOrgManager = false;
	if(request.getParameter("isOrgManager") == null || "true".equals(request.getParameter("isOrgManager"))){
		isOrgManager = true;
	}
	
	// 权限是否关联机构
	// 彭盛 2011-3-15 
	boolean isrolerelatedorg = ConfigManager.getInstance().getConfigBooleanValue("isrolerelatedorg", false);
	
	ResourceManager resManager = new ResourceManager();
	List managerList = new ArrayList();
	List commonList = new ArrayList();
	List hasOper = new ArrayList();	
	if(resTypeId != null)
	{
		resId = resManager.getGlobalResourceid(resTypeId);
		if(resManager.getResourceInfoByType(resTypeId) != null)
		{
			resName = resManager.getResourceInfoByType(resTypeId).getName();
		}
		else
		{
			if(resTypeId.equals("cs_column"))
			{
				resName = "CS菜单管理";
			}
			else
			{
				resName = "未知";
			}
		}
		
		OperManager operManager = SecurityDatabase.getOperManager();
		managerList = resManager.getManagerGlobalOperations(resTypeId);
		commonList = resManager.getCommonGlobalOperations(resTypeId);
		if(isrolerelatedorg){
			hasOper = operManager.getOperResRoleList(role_type,currRoleId,resId,resTypeId,orgId);
		}else{
			hasOper = operManager.getOperResRoleList(role_type,currRoleId,resId,resTypeId);
		}
	}	
	request.setAttribute("operList",managerList);
	request.setAttribute("commonOperList",commonList);
%>

<html>
<head>    
  <title>属性容器</title>
  <link rel="stylesheet" type="text/css" href="../css/windows.css">
<SCRIPT LANGUAGE="JavaScript">
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

function setCheck(currCheck,priority)
{
   	var o = document.getElementsByName("alloper");
	var prioritylist = document.getElementsByName("priority"); 
	if (currCheck.checked==true && priority.length >1 && (priority.match(/[0-9]/))){
		for (var i=0;i<prioritylist.length;i++){
			var v = prioritylist[i].value;

			if (v.length >1 && (v.match(/[0-9]/)) && priority.substring(0,1) > v.substring(0,1)&& priority.substring(1,2) == v.substring(1,2) )
			{
				o[i].checked=true;
				changebox(o[i].value,1);
				//o[i].disabled=true;
			}
		}  
	
		for (var i=0;i<prioritylist.length;i++){
			var v = prioritylist[i].value;
			if (v.length >1 && (v.match(/[0-9]/)) && priority.substring(1,2) != v.substring(1,2) )
			{
				o[i].checked=false;
				changebox(o[i].value,0);
				//o[i].disabled=false
			}
		}  
	}	
		if (currCheck.checked==false  && priority.length >1 && (priority.match(/[0-9]/))){
			for (var i=0;i<prioritylist.length;i++){
				var v = prioritylist[i].value;
				if ( v.length >1 && (v.match(/[0-9]/)) && priority.substring(0,1) > v.substring(0,1) )
				{
					if ( o[i].checked==true ){
						//currCheck.checked==true;
						//o[i].disabled=false;
					}
				}
			}  
	
		}		
	}
	
	function changebox(opid,flag){
	}
	
	function changebox1(currCheck,priority,opid){
		if(opid=="addorg") return;//如果选择的是添加一级子机构就直接返回
		setCheck(currCheck,priority);
	}
	
	
	//角色授权
	function okRecord(dealType) {
		
		    var isSelect = false;
		    var outMsg;
			 
		    for (var i=0;i<Form1.elements.length;i++) {
				var e = Form1.elements[i];
					
				if (e.name == 'alloper'){
					if (e.checked){
			       		isSelect=true;
			       		break;
				    }
				 }
				
		    }
		   
			if(confirm("确认提交吗？")){
				Form1.action="permission_handle.jsp?global=yes";
				Form1.submit();
			}
				
	}
</SCRIPT>
  <link rel="stylesheet" type="text/css" href="../css/windows.css">
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
<div id="contentborder">
	<fieldset>
	   <LEGEND align=left><strong><FONT size=2>帮助</FONT></strong></LEGEND>
	    <table align=left><tr><td>
	    	授予全局资源操作项
	    	<%if("orgunit".equals(resTypeId)){ %>：管理员能授予【管理员权限】和【普通用户权限】；
	    	普通用户只能授予【普通用户权限】，普通用户如果从他的所属机构或授予的角色间接继承了【管理员权限】中的操作权限，不会起作用。【管理员权限】中的操作只对部门管理员有效
	    	<%} %>
	    </td><td align="center" ></td></tr></table>
        </fieldset>
<center>

<form name="Form1" target="group"  method="post" >
<%if(isOrgManager || role_type.equals("role") ||  role_type.equals("organization")){ %>
<fieldset>
<LEGEND align=left><strong><FONT size=2>管理员权限</FONT></strong></LEGEND>
<table width="100%" height="22" border="0" cellpadding="0" cellspacing="1" class="thin">
        
      <tr class="tr">
        <td class="td" width="25" height="22" ><input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','alloper')" width="10"></td>
        <td class="td" width="150" height="22" align="center" ><strong>授予操作项</strong></td>
        <%if(isBatch.equals("false") && role_type.equals("user")){%>
        	<td height="22" class="td" align="center" width="298" ><strong>资源来源</strong></td>
        <%}%>
        <td class="td" height="22" align="center" ><strong>操作项描述</strong></td>
      </tr>
      <pg:list requestKey="operList" needClear="false">
      <tr class="tr">
        <td width="25" class="td" height="22">
        <input name="alloper" type="checkbox"
        <%
	      String opId = dataSet.getString(Integer.parseInt(rowid),"id");
	      
	      //是否是管理员特有的操作项，false表示所有用户都能设置该操作项
	      boolean isManager = dataSet.getBoolean("manager");
	      
	      String returnStrResouce = "";
	      //判断该资源是否受保护：true表示不受保护；false表示受保护的
       	  boolean isUnProtected = accesscontroler.isUnprotected(resId,opId,resTypeId);
       	  //判断是否是超级管理员拥有：true表示只有超级管理员才有权；false根据具体授权来决定
		  boolean isExclude = accesscontroler.isExcluded(resId,opId,resTypeId);
		  //只能是超级管理员拥有的权限
		  if(isExclude){
			  out.print(" disabled=\"true\" title=\"只有超级管理员才有权\" ");
		  }else if(isUnProtected){//不受保护的资源
			  out.print(" disabled=\"true\" title=\"未受保护的资源\" checked ");
		  }else{
		      if(!accesscontroler.checkPermission(resId,opId,resTypeId)){
		      	out.print(" disabled=\"true\"");
		      }
			  String returnStr = "";
			  
			  
		      if(isBatch.equals("false") && role_type.equals("user")){
		       	returnStr = accesscontroler.getUserRes_jobRoleandRoleandSelf(orgId,currRoleId,resName,resTypeId,resId,opId);
		      }
	          for(int i = 0; i < hasOper.size(); i ++){
				RoleresopKey op = (RoleresopKey)hasOper.get(i);
	        	if(op.getRoleId().equals(currRoleId) && op.getOpId().equals(opId)){
	        		out.println(" checked ");
	        		break;
	        	}	
	          }
	            
	            if(isBatch.equals("false") && role_type.equals("user")){
	                returnStrResouce = accesscontroler.getSourceUserRes_jobRoleandRoleandSelf(orgId,currRoleId,resName,resTypeId,resId,opId);
	                if(returnStr.equals("1")){
	                    out.println(" disabled=\"true\" checked ");
	                }
	            }
          }
        %>
        value="<pg:cell colName="id"/>" onclick="changebox1(this,'<pg:cell colName="priority" defaultValue=""/>','<pg:cell colName="id"/>')"  >
        </td>
        <td width="80" height="22" class="td" width="150"><pg:cell colName="name"/></td>
        <%if(isBatch.equals("false") && role_type.equals("user")){%>
        	<td height="22"  width="298"><%=returnStrResouce%></td>
        <%}%>
        <td height="22"><pg:cell colName="description"/></td>
        <input name="priority" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">        
      </tr>
       </pg:list>
       
      
    </table>
    </fieldset>
<%} %>
<%if("orgunit".equals(resTypeId)){ %>
    <fieldset>
    <LEGEND align=left><strong><FONT size=2>普通用户权限</FONT></strong></LEGEND>
    <table width="100%" height="22" border="0" cellpadding="0" cellspacing="1" class="thin">
    <tr class="tr">
        <td class="td" width="25" height="22" ></td>
        <td class="td" width="150" height="22" align="center" ><strong>授予操作项</strong></td>
        <%if(isBatch.equals("false") && role_type.equals("user")){%>
        	<td height="22" class="td" align="center"  width="298"><strong>资源来源</strong></td>
        <%}%>
        <td class="td" height="22" align="center" ><strong>操作项描述</strong></td>
      </tr>
      <pg:list requestKey="commonOperList" needClear="false">
      <tr class="tr">
        <td width="25" class="td" height="22">
        <input name="alloper" type="checkbox"
        <%
	      String opId = dataSet.getString(Integer.parseInt(rowid),"id");
	      
	      //是否是管理员特有的操作项，false表示所有用户都能设置该操作项
	      boolean isManager = dataSet.getBoolean("manager");
	      
	      String returnStrResouce = "";
	      //判断该资源是否受保护：true表示不受保护；false表示受保护的
       	  boolean isUnProtected = accesscontroler.isUnprotected(resId,opId,resTypeId);
       	  //判断是否是超级管理员拥有：true表示只有超级管理员才有权；false根据具体授权来决定
		  boolean isExclude = accesscontroler.isExcluded(resId,opId,resTypeId);
		  //只能是超级管理员拥有的权限
		  if(isExclude){
			  out.print(" disabled=\"true\" title=\"只有超级管理员才有权\" ");
		  }else if(isUnProtected){//不受保护的资源
			  out.print(" disabled=\"true\" title=\"未受保护的资源\" checked ");
		  }else{
			  String returnStr = "";
			  
			  
		      if(isBatch.equals("false") && role_type.equals("user")){
		       	returnStr = accesscontroler.getUserRes_jobRoleandRoleandSelf(orgId,currRoleId,resName,resTypeId,resId,opId);
		      }
	          for(int i = 0; i < hasOper.size(); i ++){
				RoleresopKey op = (RoleresopKey)hasOper.get(i);
	        	if(op.getRoleId().equals(currRoleId) && op.getOpId().equals(opId)){
	        		out.println(" checked ");
	        		break;
	        	}	
	          }
	            
	            if(isBatch.equals("false") && role_type.equals("user")){
	                returnStrResouce = accesscontroler.getSourceUserRes_jobRoleandRoleandSelf(orgId,currRoleId,resName,resTypeId,resId,opId);
	                if(returnStr.equals("1")){
	                    out.println(" disabled=\"true\" checked ");
	                }
	            }
          }
        %>
        value="<pg:cell colName="id"/>" onclick="changebox1(this,'<pg:cell colName="priority" defaultValue=""/>','<pg:cell colName="id"/>')"  >
        </td>
        <td height="22" class="td" width="150"><pg:cell colName="name"/></td>
        <%if(isBatch.equals("false") && role_type.equals("user")){%>
        	<td height="22" width="298"><%=returnStrResouce%></td>
        <%}%>
        <td height="22"><pg:cell colName="description"/></td>
        <input name="priority" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">        
      </tr>
      </pg:list>
    </table>
   
    </fieldset>
 <%} %>
    <table>
	    <tr>
	        <td></td>
	        <td></td>
	        <td colspan="2">
	        <input type="submit" value="确定" class="input" onclick="javascript:okRecord(1); return false;" 
	        <%
	        if(!accesscontroler.isAdmin() && accesscontroler.getUserID().equals(currRoleId))
	        out.print(" disabled=\"true\"");
	        %>
	        >
	        <%if(isBatch.equals("false")){ %>
	        	<input name="sx" value="刷新" class="input" type="button" onclick="window.location.href = window.location.href;" />
	        <%} %>
	        </td>
	      </tr>
    </table>
    <table width="35%" border="0" align="right" cellpadding="0" cellspacing="0" >
        <tr>
          <td><div align="center">
            
          </div></td>
          <td><div align="center">
           
          </div></td>
        </tr>
    </table>
    <input name="resName" value="<%=resName%>" type="hidden">
  	<input name="resTypeId" value="<%=resTypeId%>" type="hidden">
  	<input name="resid" value="<%=resId%>" type="hidden">
  	<input name="roleid" value="<%=currRoleId%>" type="hidden">
  	<input name="role_type" value="<%=role_type%>" type="hidden">
  	<input name="isBatch" value="<%=isBatch%>" type="hidden">
  	<input name="orgId" value="<%=orgId%>" type="hidden">
</form>

<IFRAME name="group" width="0" height="0"></IFRAME>

</center>
</div>
</body>
</html>