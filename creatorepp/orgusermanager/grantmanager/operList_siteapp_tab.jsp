
<%@ page language="java" contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.OperManager,
				com.chinacreator.resource.ResourceManager"%>
				
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.*,
				com.chinacreator.sysmgrcore.entity.Roleresop"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld" %>
<%
	response.setHeader("Cache-Control", "no-cache"); 
	response.setHeader("Pragma", "no-cache"); 
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);

	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    
   String orgId = request.getParameter("currOrgId");
   
	String isok =  (String)request.getAttribute("isOk");
	
	String resTypeId = request.getParameter("resTypeId");
	
	String resId = request.getParameter("resId");
	
	String resname = request.getParameter("title");
	
	String roleId = request.getParameter("currRoleId");
	
	String role_type = request.getParameter("role_type");
	
	String username = request.getParameter("username");
	
	//���õ�request
	session.setAttribute("resname",resname) ;
	

	boolean flag = false;

	
	OperManager operManager = SecurityDatabase.getOperManager();
	ResourceManager resManager = new ResourceManager();

	List list = resManager.getOperations(resTypeId);
	List hasOper = operManager.getOperResRoleList(role_type,roleId,resId,resTypeId);
	if(list == null){
		list = new ArrayList();
	}	
	request.setAttribute("operList",list);
	if(hasOper == null){
		hasOper = new ArrayList();
	}
%>

<html>
<head>    
<title>Ȩ������</title>
  <link rel="stylesheet" type="text/css" href="../css/windows.css">
  <link rel="stylesheet" type="text/css" href="../css/contentpage.css">
  <link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
  
<SCRIPT LANGUAGE="JavaScript"> 
	var ok = <%=isok%>;
	if(ok!=null){
		alert("���������ɹ���");
	}//alert(document.URL);
	
	//��ѡ��ȫ��ѡ��
	function checkAll(totalCheck,checkName){
	   var selectAll = document.getElementsByName(totalCheck);
	   var o = document.getElementsByName(checkName);
	   if(selectAll[0].checked==true){
		   for (var i=0; i<o.length; i++){
	      	  if(!o[i].parentElement.parentElement.disabled){
	      	  	o[i].checked=true;
	      	  }
		   }
	   }else{
		   for (var i=0; i<o.length; i++){
			   if(!o[i].parentElement.parentElement.disabled)
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
		setCheck(currCheck,priority);
	}
	//Ƶ����Ȩ
	function okRecord(dealType,id) {
		
		    var isSelect = false;
		    var outMsg;
			var tt;    
		    for (var i=0;i<Form1.elements.length;i++) {
				var e = Form1.elements[i];
					
				if (e.name == 'alloper'){
					if (e.checked){
			       		isSelect=true;
			       		break;
				    }
				 }
				  if (e.name == 'isRecursion'){
					if (e.checked){
			       		tt="1";
			       		
				    }else{
				    	tt ="0";
				    
				    }
				}
		    }
			Form1.action="<%=request.getContextPath()%>/accessmanager/securityManager.do?method=siteAppAuthorization&isRecursion="+tt+"&resTypeId="+id;
			Form1.submit();
				 		
	}
</SCRIPT>
</head>

<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
<div id="contentborder">
	
			<form target="channel" name="Form1" action="" method="post" >
			<table width="100%" height="22" border="0" cellpadding="0" cellspacing="1" class="thin">
				  	<input name="resTypeId" value="<%=resTypeId%>" type=hidden>
				  	<input name="resid" value="<%=resId%>" type=hidden>
				  	<input name="roleid" value="<%=roleId%>" type=hidden>
				  	<input name="role_type" value="<%=role_type%>" type=hidden>
					<input name="resname" value="<%=resname%>" type=hidden>
				  <tr>
			        <td height='30' colspan="5">
			         <LEGEND align=left><strong><FONT size=2><%if(username != null){out.print(username + " >> ");}%>���������</FONT></strong></LEGEND>
			        </td>
			      </tr>	
				  <tr>
			        <td>
			        <input type="checkBox" hideFocus=true name="checkBoxAll" onClick="checkAll('checkBoxAll','alloper')">
			        </td>
			        <td align="center" ><strong>���������</strong></td>
			        <td align="center" ><%if(role_type.equals("user")){%><strong>��Դ��Դ</strong><%}%></td>
			        <td align="center" ><strong>����������</strong></td>
			        <td>&nbsp;<input name="isRecursion" onclick="" type="checkbox" style="display:none"></td>
			      </tr>
			      <pg:list requestKey="operList" needClear="false">
			      <tr class="tr" 
			      <%
			      String opId = dataSet.getString(Integer.parseInt(rowid),"id");
			      if(!accesscontroler.checkPermission(resId,opId,resTypeId))
			      out.print(" disabled=\"true\"");
			      String returnStr = "";
			      if(role_type.equals("user")){
			       returnStr = accesscontroler.getUserRes_jobRoleandRoleandSelf(orgId,roleId,resname,resTypeId,resId,opId);
			       }
			      String c = "";
			      if(returnStr.equals("1"))
			      	c = "1";
			      %>
			      >
			        <td>
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
			            if(role_type.equals("user")){
			                returnStrResouce = accesscontroler.getSourceUserRes_jobRoleandRoleandSelf(orgId,roleId,resname,resTypeId,resId,opId);
			                if(returnStr.equals("1")){
			                    out.println(" disabled=\"true\" checked ");
			                }
			            }
			        %>
			        value="<pg:cell colName="id"/>" onclick="changebox1(this,'<pg:cell colName="priority" defaultValue=""/>','<pg:cell colName="id"/>')">
			        </td>
			        <td><pg:cell colName="name"/></td>
			        <td><%=returnStrResouce%></td>
			        <td><pg:cell colName="description"/></td>
			        <td>&nbsp;</td>
			        <input name="priority" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">        
			      </tr>
			       </pg:list>
			       
			       <tr>
			        <td></td>
			        <td></td>
			        <td></td>
			        <td></td>
			        <td>
			        <input type="submit" value="ȷ��" class="input" onclick="javascript:okRecord(1,'<%=resTypeId%>'); return false;" 
			        
			        >
			        </td>
			      </tr>
			    </table>
			</form>
			<div style="display:none">
			<IFRAME name="channel" width="0" height="0">
			</IFRAME>
			</div> 
	
</div>
</body>

</html>

