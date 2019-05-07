<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="java.util.*,
				 com.chinacreator.sysmgrcore.manager.SecurityDatabase,
				 com.chinacreator.sysmgrcore.manager.OrgManager,
				 com.chinacreator.sysmgrcore.entity.Organization" %>
<%
    //�ɼ������ϵά��--------------------------------------------
    AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);
	
	OrgManager orgManager = SecurityDatabase.getOrgManager();
	List list = new ArrayList();
	if(accesscontroler.isAdmin()){
		list = orgManager.getRecursionAllOrgList("");
	}else{
		list = orgManager.getUserAllManagerOrg(accesscontroler.getUserID());
	}
%>
<html>
    <title>��������</title>
    <head>
        <link href="../../inc/css/cms.css" rel="stylesheet" type="text/css">        
        <link rel="stylesheet" type="text/css" href="../../css/windows.css">
        <link rel="stylesheet" type="text/css" href="../../css/contentpage.css">
        <link rel="stylesheet" type="text/css" href="../../css/tab.winclassic.css">
        <script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
        <script language="JavaScript" src="../../user/common.js" type="text/javascript"></script>
        <script language="JavaScript" src="../../include/pager.js" type="text/javascript"></script>
    </head>
    <%@ include file="/epp/css/cssControl.jsp"%><body >
        <form name="form1">    
		    <table cellspacing="0" cellpadding="0" border="0" width=98%  class="thin">
		        <tr>
		           <td align="center">
		                 <font size=2><strong>����ѡ��:</strong></font>&nbsp;&nbsp;
		                 <select name="orgId" onchange="changeOrg()" >
		                 	<option value="">--��ѡ�����--</option>
		                 	<%
		                 	Organization organization = null;
		                 	for(int i = 0; i < list.size(); i++){
								organization = new Organization();
								organization = (Organization)list.get(i);
								String orgId = organization.getOrgId();
								//�����ǰ�û�����admin ���˵�ǰ�û����ڵĻ���(���ñ���ų��û����ڻ���)
								//if(orgId != null && orgId.equalsIgnoreCase(accesscontroler.getChargeOrgId()) && !accesscontroler.isAdmin()){
								//    continue;
								//}
								if (accesscontroler.checkPermission(orgId,
	                            	AccessControl.WRITE_PERMISSION, AccessControl.ORGUNIT_RESOURCE)){
		                 	%>
		                 	<option value="<%=orgId%>"><%=organization.getOrgnumber()%> <%=organization.getRemark5()==null?organization.getOrgName():organization.getRemark5()%></option>
		                 	<%}}%>
		                 </select>
		               <!--  <input type="text" style="width:60%" name="orgName"> -->
		               <!-- input type="button" value="ѡ��" class="input" onclick="selectOrg()" -->		               
		            </td>
		        </tr>
		    </table>
		</form>
	</body>
	<iframe name="hiddenFrame" width=0 length=0></iframe>
	<script>
	    function selectOrg(){
	        var orgId = document.all("orgId").value;
	        var path = "org_tree.jsp?orgId="+orgId;
	        var featrue = "dialogWidth=600px;dialogHeight=500px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;help=0;dialogLeft="+(screen.availWidth-600)/2+";dialogTop="+(screen.availHeight-500)/2;
	        win = window.showModalDialog(path,window,featrue);
	        if(win=="ok"){
	            if(window.parent.document.frames[2]){
 	                var old_path = window.parent.document.frames[2].location.href;
 	                var page_name = old_path.substring(0,old_path.indexOf("?"));
 	                var new_orgId = document.all("orgId").value;
 	                var dicttypeId = "";
 	                var dicttypeName = "";
 	                if(parent.document.frames[0]){
 	                    dicttypeId = parent.document.frames[0].document.all("selected_typeId").value;
 	                    dicttypeName = parent.document.frames[0].document.all("selected_typeName").value;
 	                }
 	                if(page_name!=""){
	 	                var new_path = page_name + "?did="+dicttypeId+"&orgId="+ new_orgId+"&typeName="+dicttypeName;
	 	                window.parent.document.frames[2].location.href = new_path;
 	                }
	            }
	        }
	    }
	    
	    function window.onhelp(){
	    
	        selectOrg();
		    return false;
	    }
	    
	    function changeOrg(){
	    	var orgId = document.all("orgId").value;
	    	if(window.parent.document.frames[2]){
				var old_path = window.parent.document.frames[2].location.href;
 	            var page_name = old_path.substring(0,old_path.indexOf("?"));
 	            var dicttypeId = "";
 	            var dicttypeName = "";
 	            if(parent.document.frames[0]){
 	               dicttypeId = parent.document.frames[0].document.all("selected_typeId").value;
 	               dicttypeName = parent.document.frames[0].document.all("selected_typeName").value;
 	            }
 	            if(page_name!=""){
	 	           var new_path = page_name + "?did="+dicttypeId+"&orgId="+ orgId+"&typeName="+dicttypeName;
	 	           window.parent.document.frames[2].location.href = new_path;
 	            }
 	         }
	    }
	</script>
</html>


