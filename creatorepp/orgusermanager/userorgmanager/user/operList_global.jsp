<%
/**
 * 
 * <p>Title: ȫ�ֲ��������</p>
 *
 * <p>Description: ������Դ��ȫ�ֲ������ҳ��</p>
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
<%@ page import="com.chinacreator.sysmgrcore.entity.*,com.chinacreator.sysmgrcore.entity.Roleresop"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkManagerAccess(request,response);
    //�õ�session�е������û���Դ���û����ڻ���ID�ͱ�������Դ���û�ID
    String userId = (String)request.getParameter("currRoleId");
    String orgId = (String)request.getParameter("currOrgId");
	
	String resTypeId = request.getParameter("resTypeId");
	
	String resId = request.getParameter("resId");
	
	String resName = request.getParameter("resName");
	
	String roleId = (String)request.getParameter("currRoleId");
	String role_type = (String)request.getParameter("role_type");
	
	ResourceManager resManager = new ResourceManager();
	List list = new ArrayList();
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
				resName = "CS�˵�����";
			}
			else
			{
				resName = "δ֪";
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
  <title>��������</title>
  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
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
		if(opid=="addorg") return;//���ѡ��������һ���ӻ�����ֱ�ӷ���
		setCheck(currCheck,priority);
	}
	
	
	//��ɫ��Ȩ
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
		   
			if(confirm("ȷ���ύ��")){
				Form1.action="permission_handle.jsp?global=yes";
				Form1.submit();
			}
				
	}
</SCRIPT>
  <link rel="stylesheet" type="text/css" href="../../css/windows.css">
<%@ include file="/epp/css/cssControl.jsp"%><body  class="contentbodymargin">
<div id="contentborder">
	<fieldset>
	   <LEGEND align=left><strong><FONT size=2>����</FONT></strong></LEGEND>
	    <table align=left><tr><td>����ȫ����Դ������</td><td align="center" ></td></tr></table>
        </fieldset>
<center>

<form name="Form1" target="group"  method="post" >
<table width="100%" height="22" border="0" cellpadding="0" cellspacing="1" class="thin">
        
      <tr class="tr">
        <td class="td" width="25" height="22" ><input type="checkBox" name="checkBoxAll" onClick="checkAll('checkBoxAll','alloper')" width="10"></td>
        <td class="td" width="100" height="22" align="center" ><strong>���������</strong></td>
        <td height="22" class="td" align="center" ><%if(role_type.equals("user")){%><strong>��Դ��Դ</strong><%}%></td>
        <td class="td" width="100" height="22" align="center" ><strong>����������</strong></td>
      </tr>
      <pg:list requestKey="operList" needClear="false">
      <tr class="tr">
        <td width="25" class="td" height="22">
        <input name="alloper" type="checkbox"
        <%
        	String opId = dataSet.getString(Integer.parseInt(rowid),"id");
	        if(!accesscontroler.checkPermission(resId,opId,resTypeId)){
	        	out.print(" disabled=\"true\"");
	        }
		    String returnStr = "";
	        if(role_type.equals("user")){
	       		returnStr = accesscontroler.getUserRes_jobRoleandRoleandSelf(orgId,userId,resName,resTypeId,resId,opId);
	        }
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
        <td height="22"><pg:cell colName="description"/></td>
        <input name="priority" value="<pg:cell colName="priority" defaultValue=""/>" type="hidden">        
      </tr>
       </pg:list>
      <tr>
        <td></td>
        <td></td>
        <td colspan="2">
        <input type="submit" value="ȷ��" class="input" onclick="javascript:okRecord(1); return false;" 
        <%
        if(accesscontroler.getUserID().equals(roleId))
        out.print(" disabled=\"true\"");
        %>
        >
        <input type="submit" value="�ر�ҳ��" class="input" onclick="window.close();" />
        <input name="sx" value="ˢ��" class="input" type="button" onclick="parent.window.location.href = parent.window.location.href;" />
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