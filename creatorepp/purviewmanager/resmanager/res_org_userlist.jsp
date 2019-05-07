
<%@page import="com.chinacreator.sysmgrcore.manager.db.OrgAdministratorImpl"%><%
	/**
	  * 直属用户列表
	  */
%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.OperManager,com.chinacreator.resource.ResourceManager"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.sysmgrcore.manager.RoleManager"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@page import="com.chinacreator.sysmgrcore.entity.RoleresopKey"%>
<%@page import="java.util.Map"%>
<%
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response);
	OrgAdministratorImpl orgAdministratorImpl = new OrgAdministratorImpl();
	String curOrgId = accessControl.getChargeOrgId(); 
	String orgId=request.getParameter("orgId");
	
	//所选机构是否是当前用户所属机构
	boolean isCurOrg = curOrgId.equals(orgId);

	String resId2 = request.getParameter("resId2");//RES_ID
	String resTypeId2 = request.getParameter("resTypeId2");//RESTYPE_ID
	String resTypeName = request.getParameter("resTypeName");
	String title = request.getParameter("title");//??~~~
	String resName2 = request.getParameter("resName2");//RES_NAME
	
	//是否批量授予
	String isBatch = request.getParameter("isBatch");
	
	ResourceManager resManager = new ResourceManager();
	RoleManager roleManager = SecurityDatabase.getRoleManager();
	List list = resManager.getOperations(resTypeId2);
	request.setAttribute("list",list);
	
	OperManager operManager = SecurityDatabase.getOperManager();
%>
<html>
<head>    
 <title>用户列表</title>
 <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/sysmanager/css/windows.css">
 <script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/jobmanager/common.js" type="text/javascript"></script>		
 <script src="<%=request.getContextPath()%>/cms/inc/js/func.js"></script>
 <script language="JavaScript" src="<%=request.getContextPath()%>/sysmanager/include/pager.js" type="text/javascript"></script>
 <SCRIPT language="javascript">
	
	
	
	var http_request = false;
	//初始化，指定处理的函数，发送请求的函数
	function send_request(url){
		http_request = false;
		//开始初始化XMLHttpRequest对象
		if(window.XMLHttpRequest){//Mozilla
			http_request = new XMLHttpRequest();
			if(http_request.overrideMimeType){//设置MIME类别
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
			alert("不能创建XMLHttpRequest对象");
			return false;
		}
		http_request.onreadystatechange = processRequest;
		http_request.open("GET",url,true);
		http_request.send(null);
	}

	function processRequest(){
		if(http_request.readyState == 4){                  
			if(http_request.status == 200){
				//alert(http_request.responseText);
			}
			else{
				alert("对不起，服务器错误");
			}
		}
	}
	
	function saveRoleresop(obj){
		var roleIdAndOpId = obj.value;
		alert(roleIdAndOpId);
		var arr = roleIdAndOpId.split(":");
		var roleId = arr[0];
		var opid = arr[1]; 
		if(obj.checked){
			send_request("saveRoleresop.jsp?check=1&types=user&opid="+opid+"&resId=<%=resId2%>&roleId="+roleId+"&restypeId=<%=resTypeId2%>&resName=<%=resName2%>");
			alert("选中");
		}else{
			alert("取消");
			send_request("saveRoleresop.jsp?check=0&types=user&opid="+opid+"&resId=<%=resId2%>&roleId="+roleId+"&restypeId=<%=resTypeId2%>&resName=<%=resName2%>");
		}
	}
	
	//批量保存
	function saveRoleresops(){
		var obj = document.getElementsByName("opId");
		//alert(obj.length);
		var checks = "";
		var un_checks = "";
		for(var count = 0; count < obj.length; count++){
			if(!obj[count].disabled){
				if(obj[count].checked){
					if(checks==""){
						checks = obj[count].value;
					}else{
						checks += "^#^" + obj[count].value;
					}
				}else{
					if(un_checks==""){
						un_checks = obj[count].value;
					}else{
						un_checks += "^#^" + obj[count].value;
					}
				}
			}
		}
		//alert("checks = " + checks);
		//alert("un_checks = " + un_checks);
		document.all("checks").value = checks;
		document.all("un_checks").value = un_checks;
		document.userForm.target = "saveHidden";
		document.userForm.action = "saveRoleresop.jsp?types=user&resId=<%=resId2%>&restypeId=<%=resTypeId2%>&isBatch=<%=isBatch%>";
		//alert(document.userForm.action);
		document.userForm.submit();
	}
</SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="<%=request.getContextPath()%>/cms/inc/css/cms.css" rel="stylesheet" type="text/css">

<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin" scroll="auto">

<div id="contentborder" align="center">
    <form name = "userForm" method="post" action="">	
    <input type="hidden" name="checks" value="">
    <input type="hidden" name="un_checks" value="">
    <input type="hidden" name="resName2" value="<%=resName2 %>">
    
	<input type="hidden" name="delcmsuser" value="delcmsuser" /><!--用于标识CMS中的用户管理-->
	<table width="100%" border="1" align=center cellpadding="3" cellspacing="0" bordercolor="#B7CBE4"  class="Datalisttable" >
		<tr style="align:left">
			<td height='40' align="left" colspan=5>
			<%
			if(request.getParameter("resName")!=null)
			{
			%>
			<div align="left">&nbsp;<b>
			<%=request.getParameter("resName")==null?"":request.getParameter("resName")%></b>&nbsp;>>&nbsp;
			<b>用户列表</b>
			</div>
			<%}%>
			<hr size="1">
			<div align="left">&nbsp;
			 <!--| 
			<a href="#" onclick="createorg()"><u>添加用户</u></a>--></div>
			</td>
		</tr>
		<pg:listdata dataInfo="com.chinacreator.sysmgrcore.web.tag.OrgSubUserList" keyName="OrgSubUserList"/>
		<!--分页显示开始,分页标签初始化-->
		<pg:pager maxPageItems="10"
				  scope="request"  
				  data="OrgSubUserList" 
				  isList="false">
			      <tr class="cms_report_tr">
			      <!--设置分页表头-->
			 		<!--td class="headercolor" width="6">
						<input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','checkBoxOne')" width="10">
					</td-->	      
			      	<td class="headercolor" height='30'>登录名</td>	<input class="text" type="hidden" name="selectId">
			      	<!-- 
			      	<td class="headercolor" height='30'>用户名</td>
			      	<td class="headercolor" height='30'>性别</td>
			      	 -->
					<td class="headercolor" height='30'>权限授予</td>
			      	
			      </tr>
			      <pg:param name="orgId"/>
				  <pg:param name="resName"/>
				  <pg:param name="resId2"/>
				  <pg:param name="resTypeId2"/>
				  <pg:param name="resTypeName"/>
				  <pg:param name="title"/>
				  <pg:param name="isBatch"/>
				  <pg:param name="types"/>
				  
			     		      
				  <!--检测当前页面是否有记录-->
		       	  <pg:notify>
			      <tr height="18px" >
			      	<td class="detailcontent" colspan=100 align='center'>暂时没有用户</td>
			      </tr>
			      </pg:notify>			      
			      			    
			      <!--list标签循环输出每条记录-->			      
			      <pg:list>	
			      <% 
			      	String userId = dataSet.getString("userId");
			      	boolean isOrgManager = false;
			      	if(isCurOrg){
			      		isOrgManager = orgAdministratorImpl.isOrgManager(userId);
			      	}
			      	String userName = dataSet.getString("userName");
			      	//是否拥有超级管理员角色
			      	boolean isAdminRole = accessControl.isAdmin(userName);
			      	Map hasOper = operManager.getResOperMapOfRole(userId,resId2,resTypeId2,"user");
			      	Map opMap = accessControl.getSourceUserRes_Role(orgId,userId,"",resId2,resTypeId2);
			      	//System.out.println("opMap = " + opMap.size());
			      %>
			      		<tr <%if(isOrgManager){out.print("disabled");} %> class="cms_data_tr" onMouseOver="this.className='mousestyle1'" onMouseOut="this.className= 'mousestyle2'"  >	      				
					
			 				<td class="tablecells" align="center"><pg:cell colName="userName" defaultValue=""/>(<pg:cell colName="userRealname" defaultValue=""/>)</td>
						
					  		 <!-- OP_ID:id;ROLE_ID:userId -->
					  		 <td>
					  		 <pg:list requestKey="list" >
					  		 	<%
					  		 	String opid = dataSet.getString("id");
					  		 	
				  		 		String inputname = "unopId";
				  		 		String output = ""; 
				  		 		//System.out.println("userId = "+ userId+":"+userName + "   :	opid = " + opid);
					  		 	try
					  		 	{
					  		 		
					  		 		if(isAdminRole){
					  		 
					  		 			output = " title='该用户拥有超级管理员角色,自动拥有该操作'  checked disabled " ;
					  		 	 
					  		 		}
					  		 		else
					  		 		{
					  		 		//判断该资源是否受保护：true表示不受保护；false表示受保护的
						        	boolean isUnProtected = accessControl.isUnprotected(resId2,opid,resTypeId2);
						        	//判断是否是超级管理员拥有：true表示只有超级管理员才有权；false根据具体授权来决定
									boolean isExclude = accessControl.isExcluded(resId2,opid,resTypeId2);
									//只能是超级管理员拥有的权限
									if(isExclude){
										output = " disabled=\"true\" title=\"只有超级管理员才有权\" ";
									}else if(isUnProtected){//不受保护的资源
										output = " disabled=\"true\" title=\"未受保护的资源\" checked ";
									}else{
					  		 			inputname = "opId";
					  		 			//System.out.println("else~~~~~~~~~~~~~~~~~~~~~~~");
						  		 		boolean flag = false;
					  		 		
					  		 				
				  		 				if(hasOper.size() > 0 && hasOper.containsKey(opid)){
				  		 					output = " checked ";
				  		 					flag = true;
				  		 				}
					  		 			
						  		 			
					  		 			if(opMap != null && opMap.size() > 0){
					  		 				
						  		 			String titles = (String)opMap.get(opid);
						  		 			if(titles== null || titles.equals(""))
						  		 			{
						  		 				
						  		 			}
						  		 			else
						  		 			{
						  		 				if(!flag)
						  		 				{
						  		 					output = " checked disabled ";
						  		 				}
						  		 				
						  		 				output += "title='"+titles+"'";
						  		 			}
					  		 			}
					  		 			
					  		 		}
					  		 		if(!accessControl.checkPermission(resId2,opid,resTypeId2))
						        	{
      									output += " disabled=\"true\" " ;
      								}
      								}
					  		 	}
					  		 	catch(Exception e)
					  		 	{
					  		 		e.printStackTrace();
					  		 	}
					  		 	%>
					  		 	<input name="<%=inputname %>" value='<%=userId %>#*#<pg:cell colName="id" />' type="checkbox" <%=output%>/>
					  		 	
					  		 	<pg:cell colName="name" />
					  		 </pg:list>
					  		 </td>
							
					  	</tr>			      		
			      </pg:list>
			   <tr height="18px" >
			      	<td class="Data_List_Table_Bottom" colspan=5 align='center'>
					每页显示10条&nbsp;&nbsp;共&nbsp;<pg:rowcount/>&nbsp;条记录&nbsp;<pg:index/>
					<input type="hidden" name="queryString" value="<pg:querystring/>">
					</td>
			      	
			      </tr> 
			     <tr>
			     <td colspan=5 align="right">
			     <% 
			     	if(orgId != null && !"".equals(orgId)){
			     %>
			     <input name="submit1" type="button" value="保存" onclick="saveRoleresops()" class="input"/>
			     <% 
			     	}
			     %>
			     <input name="submit3" type="button" value="关闭" onclick="window.close()" class="input"/>
			     </td>
			     </tr>  			   	      
		</pg:pager>
		
	</table>	
	<iframe name="saveHidden" width="0" height="0"></iframe>
</form>	
</div>
</body>

</html>