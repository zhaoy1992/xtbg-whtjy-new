<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@page import="com.chinacreator.config.ConfigManager"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase,
				com.chinacreator.sysmgrcore.entity.User,
				com.chinacreator.sysmgrcore.manager.UserManager,
				com.chinacreator.sysmgrcore.purviewmanager.PurviewManager,
				com.chinacreator.sysmgrcore.purviewmanager.db.PurviewManagerImpl" %>

<%
	
	//Integer uid = (Integer) session.getAttribute("currUserId");//当前用户id
	//String uid = (String)request.getAttribute("userId");
	PurviewManager purviewManager = new PurviewManagerImpl();
	String uid = request.getParameter("userId");
	String userOrgId = request.getParameter("userOrgId");
	String curOrgId = request.getParameter("orgId");
	String orgId = request.getParameter("orgId");
	UserManager userManager = SecurityDatabase.getUserManager();
	User user = userManager.getUserById(uid);
	String userName = user.getUserRealname();	
	request.setAttribute("userId",uid);
%>
<html>
<head>    
 <title>属性容器</title>
<script language="JavaScript" src="../../../sysmanager/jobmanager/common.js" type="text/javascript"></script>		
<script language="JavaScript" src="../../../sysmanager/include/pager.js" type="text/javascript"></script>
<SCRIPT language="javascript">
	function checkAll(totalCheck,checkName){	//复选框全部选中
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
	//单个选中复选框
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
	function dealRecord(dealType) {
		var userSelf = "";//复制用户自身资源
		var userRole = "";//复制用户角色资源
		var userJob = "";//复制用户岗位资源
		if(document.all("userSelf").checked){
			userSelf = "self";
		}
		if(document.all("userRole").checked){
			userRole = "role";
		}
		if(document.all("userJob") && document.all("userJob").checked){
			userJob = "job";
		}
	    
	    //选中被复制的用户id
	    var checks = "";
	    var arr = new Array();
	    arr = document.getElementsByName("ID");
	    for(var i = 0; i < arr.length; i++){
	    	if(arr[i].checked){
	    		if(checks == ""){
	    			checks = arr[i].value;
	    		}else{
	    			checks += "," + arr[i].value;
	    		}
	    	}
	    }
	    if (checks != ""){
	    	if (dealType==1){
	    		outMsg = "你确定要复制( <%=userName%> )的权限给所选用户吗？";
	        	if (confirm(outMsg)){
	        		orgForm.action="selfPurviewCopyUser.jsp?userId=<%=uid%>&checks="+checks+"&userSelf="+
	        			userSelf+"&userRole="+userRole+"&flag=1&userJob="+userJob+"&curOrgId=<%=curOrgId%>&userOrgId=<%=userOrgId%>";
					orgForm.submit();
		 			return true;
			    }
			} 
	    }else{
	    	alert("至少要选择一条记录！");
	    	return false;
	   }
  		return false;
	}
	
	//复制用户自身权限或用户角色权限
	function userCopy(){
		
		if(document.all("userSelf").checked || document.all("userRole").checked || (document.all("userJob") && document.all("userJob").checked)){
			var checks = document.getElementsByName("ID");
			for(var i = 0; i < checks.length; i++){
				checks[i].disabled = false;
			}
		}else{
			var checks = document.getElementsByName("ID");
			for(var i = 0; i < checks.length; i++){
				checks[i].disabled = true;
				checks[i].checked = false;
			}
		}
	}
</SCRIPT>
<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/windows.css">
<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/contentpage.css">
<link rel="stylesheet" type="text/css" href="../../../sysmanager/css/tab.winclassic.css">
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="no">
	<fieldset>
	   <LEGEND align=left><strong><FONT size=2>提示</FONT></strong></LEGEND>
		
	    <table><tr><td>将复制当前用户的自身权限和所属角色给所选用户
	      </td>
	     </tr>
	    </table>
	  
     </fieldset>
<div id="contentborder" align="center">
	
    <form name = "orgForm" target="copy" method="post" action="">	
    <input type="hidden" name="jobId" value ="<%=request.getParameter("jobId")%>">
	<table width="100%"  cellpadding="1" cellspacing="1" class="thin">
	<tr><td height='40' class="detailtitle" align=center colspan=3><b>复制用户：<%=userName%>   的权限</b></td></tr>
		<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.UserResCopyList" keyName="UserResCopyList"/>
		<!--分页显示开始,分页标签初始化-->
		<pg:pager maxPageItems="12"
				  scope="request"  
				  data="UserResCopyList" 
				  isList="false">
				  <tr class="labeltable_middle_td">
				  <td colspan="3">
				  <input name="userSelf" type="checkbox" onclick="userCopy();" title="直接授予给用户的权限" />&nbsp;&nbsp;复制用户自身权限
				  &nbsp;&nbsp;&nbsp;
				  <input name="userRole" type="checkbox" onclick="userCopy();" title="直接授予给用户的角色权限" />&nbsp;&nbsp;复制用户角色权限
				  <% 
				  	if(ConfigManager.getInstance().getConfigBooleanValue("enablejobfunction",false)){	
				  %>
				  &nbsp;&nbsp;&nbsp;
				  <input name="userJob" type="checkbox" onclick="userCopy();"
				  <%if(!orgId.equals(curOrgId)){out.print(" disabled ");}%> 
				  	title="只能在相同的机构下授予岗位权限，不能跨机构授予岗位权限！" />
				  &nbsp;&nbsp;复制用户岗位权限
				  <% 
				  	}
				  %>
				  </td>
				  </tr>
			      <tr class="labeltable_middle_td">
			      <!--设置分页表头-->
			      <td class="headercolor">
				  	<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','ID')">
				  </td>
				  <td height='20' class="headercolor">用户帐号</td>
			   	  <td height='20' class="headercolor">用户实名</td>
				
				  			
			      </tr>
			      <pg:param name="orgId"/>
			      <pg:param name="userId"/>		      
				  <!--检测当前页面是否有记录-->
		       	  <pg:notify>
			      <tr height="18px" >
			      	<td class="detailcontent" colspan=100 align='center'>暂时没有用户</td>
			      </tr>
			      </pg:notify>			      
			      			    
			      <!--list标签循环输出每条记录-->			      
			      <pg:list>
			      <%
			      		String listUserId = dataSet.getString("userId");
			      		boolean state = purviewManager.isAdminOrOrgmanager(orgId,listUserId);
			      %>	
			      		<tr class="labeltable_middle_tr_01" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'">	      				
							
			      		    <td  align=center><input onClick="checkOne('checkBoxAll','ID')" type="checkbox" name="ID<%if(state){%>disabled<%}%>" value="<pg:cell colName="userId" defaultValue=""/>" disabled="true"></td>					
							<td  align=left>
							<pg:cell colName="userName" defaultValue=""/>
							</td>
							<td  align=left>
							<pg:cell colName="userRealname" defaultValue=""/>
							</td>
						</tr>			      		
			      </pg:list>
			   <tr height="18px" >
			      	<td class="detailcontent" colspan=2 align='center'><pg:index/><input type="hidden" name="queryString" value="<pg:querystring/>"></td>
			      	<td class="detailcontent" align='left'>
			      	
					  	
					 <input type="button" value="确定" class="input"
								onclick="javascript:dealRecord(1); return false;">
								
				</td>
			      </tr>   			   	      
		</pg:pager>
		
	</table>	
</form>	
</div>
<div style="display:none">
	<IFRAME name="copy" width="0" height="0"></IFRAME>
</div> 
</body>

</html>