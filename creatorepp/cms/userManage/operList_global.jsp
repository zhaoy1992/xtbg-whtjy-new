<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.OperManager,com.chinacreator.resource.ResourceManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.entity.Roleresop"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.security.AccessControl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    //得到session中的授予用户资源的用户所在机构ID和被授予资源的用户ID
    String rootpath = request.getContextPath();
    String userId = (String)request.getSession().getAttribute("currRoleId");
    String orgId = (String)request.getSession().getAttribute("currOrgId");
	 //判断操作是否成功
	String isok =  (String)request.getAttribute("isOk");
	
	String resTypeId = request.getParameter("resTypeId");
	
	String resId = request.getParameter("resId");
	
	String resName = request.getParameter("resName");
	
	String roleId = (String)session.getAttribute("currRoleId");
	//System.out.println("roleId = = " + roleId);
	String role_type = (String)session.getAttribute("role_type");
	
	ResourceManager resManager = new ResourceManager();
	if(resTypeId == null){
		resTypeId = (String)request.getAttribute("resTypeId");
	}
	List list = new ArrayList();
	List hasOper = new ArrayList();	
	if(resTypeId != null)
	{
		//System.out.println("resTypeId = " + resTypeId);
		resId = resManager.getGlobalResourceid(resTypeId);
		//System.out.println("resId = " + resId);
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
		list = resManager.getGlobalOperations(resTypeId);
		hasOper = operManager.getOperResRoleList(role_type,roleId,resId,resTypeId);
	}	
	request.setAttribute("operList",list);
%>

<html>
<head>    
  <title>属性容器</title>
  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
<SCRIPT LANGUAGE="JavaScript"> 
	
	var ok = <%=isok%>;
	if(ok!=null){
		alert("授予操作项成功！");
	} 

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
  <link rel="stylesheet" type="text/css" href="<%=rootpath%>/sysmanager/css/windows.css">
<body class="contentbodymargin">
<div id="contentborder">
	<fieldset>
	   <LEGEND align=left><strong><FONT size=2>帮助</FONT></strong></LEGEND>
	    <table align=left><tr><td>授予全局资源操作项</td></tr></table>
        </fieldset>
<center>

<form name="Form1" target="group"  method="post" >
<table width="100%" height="22" border="0" cellpadding="0" cellspacing="1" class="thin">
        
      <tr class="tr">
        <td class="td" width="25" height="22" ><input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','alloper')" width="10"></td>
        <td class="td" width="100" height="22" align="center" ><strong>授予操作项</strong></td>
        <td height="22" class="td" align="center" ><%if("user".equals(role_type)){%><strong>资源来源</strong><%}%></td>
      </tr>
      <pg:list requestKey="operList" needClear="false">
      <tr class="tr"
      <%
      String opId = dataSet.getString(Integer.parseInt(rowid),"id");
      if(!accesscontroler.checkPermission(resId,opId,resTypeId))
      out.print(" disabled=\"true\"");
	  String returnStr = "";
      if("user".equals(role_type)){
       returnStr = accesscontroler.getUserRes_jobRoleandRoleandSelf(orgId,userId,resName,resTypeId,resId,opId);
       }
      String c = "";
      if(returnStr.equals("1")){
      	c = "1";
      }
      %>
      >
        <td width="25" class="td" height="22">
        <input name="alloper" type="checkbox"
        <%
        	for(int i = 0; i < hasOper.size(); i ++)
        	{
        		RoleresopKey op = (RoleresopKey)hasOper.get(i);
        		if(op.getRoleId().equals(roleId) && op.getOpId().equals(opId))
        		{
        			out.println("checked");
        			break;
        		}	
        	}
        	
            String returnStrResouce = "";
            if("user".equals(role_type)){
                returnStrResouce = accesscontroler.getSourceUserRes_jobRoleandRoleandSelf(orgId,userId,resName,resTypeId,resId,opId);
                if(returnStr.equals("1")){
                    out.println(" disabled=\"true\" checked ");
                }
            }
        %>
        value="<pg:cell colName="id"/>" onclick="changebox1(this,'<pg:cell colName="priority" defaultValue=""/>','<pg:cell colName="id"/>')"  >
        <!-- onclick="changebox1(this,'<pg:cell colName="priority" defaultValue=""/>','<pg:cell colName="id"/>')" -->
        </td>
        <td width="80" height="22" class="td"><pg:cell colName="name"/></td>
        <td height="22"><%=returnStrResouce%></td>
        <input name="priority" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">        
      </tr>
       </pg:list>
      <tr>
        <td></td>
        <td></td>
        <td>
        <input type="submit" value="确定" class="input" onclick="javascript:okRecord(1); return false;" 
        <%
        if(accesscontroler.getUserID().equals(roleId))
        out.print(" disabled=\"true\"");
        %>
        >
        <!-- <input type="button" name="closed" value="关闭" class="input" onclick="javascript:parent.window.close();window.returnValue='ok';" /> -->
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
  	<input name="roleid" value="<%=roleId%>" type="hidden">
  	<input name="role_type" value="<%=role_type%>" type="hidden">
</form>

<IFRAME name="group" width="0" height="0"></IFRAME>

</center>
</div>
</body>
</html>