<%@  page  contentType="text/html;charset=GBK"  language="java"  buffer="none"  %>  
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib prefix="tab" uri="/WEB-INF/tabpane-taglib.tld"%>
<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
        
       

<%
  
	AccessControl control = AccessControl.getInstance();
	control.checkAccess(request, response);
    String ids_str = request.getParameter("ids_str");
    String selectedTabPaneId = request.getParameter("selectedTabPaneId");
    if(selectedTabPaneId!=null&&"user".equals(selectedTabPaneId)){    		
    	selectedTabPaneId = "addapply-tab2";
    }else{
    	selectedTabPaneId = "addapply-tab1";
    }
      
    String pathtab1 = "roleGrant.jsp?roleid="+ids_str;
	String pathtab2 = "userGrant.jsp?userid="+ids_str;

%>
<script type="text/javascript">
window.onload = function(){

	//window.clipboardData.setData('text',addapplytab2.document.body.innerHTML);
	var ret = window.dialogArguments;
	if(ret!="undefined" && ret!=null){
        var ret_arr = ret.split(";");
        var ids = ret_arr[0];
        var names = ret_arr[1];
        ids = ids.split(",");
        names = names.split(",");
        if(ret_arr[ret_arr.length-1]=="role"){
     
        	for(var i=0,len=ids.length;i<len;++i){
	        	try{
	        		addapplytab1.document.getElementById("checkbox_"+ids[i]).checked=true;
	        	}catch(e){
	        	}
        	}
        }
        if(ret_arr[ret_arr.length-1]=="user"){
         
        	for(var i=0,len=ids.length;i<len;++i){
	        	try{
	        		addapplytab2.document.getElementById("checkbox_use"+ids[i]).checked=true;
	        		addapplytab2.treeNodeCheckboxChange(addapplytab2.document.getElementById("checkbox_use"+ids[i]));
	        	}catch(e){
	        	}
        	}
        }
        
        
    }
};
</script>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
		<tab:tabConfig />
		<title>权限授予</title>
	</head>
	<%@ include file="/epp/css/cssControl.jsp"%><body bgcolor="#F7F8FC">
	
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			align="center">
			<tr>
				<td colspan="2">

					<tab:tabContainer id="addapply-tab" enablecookie="false"
						selectedTabPaneId="<%=selectedTabPaneId%>"    >

						<tab:tabPane id="addapply-tab1" tabTitle="角色权限授予" lazeload="true" >
							<tab:iframe id="addapplytab1" src="<%=pathtab1%>"
								frameborder="0" scrolling="no" width="98%" height="460">
							</tab:iframe>
						</tab:tabPane>
	
						<tab:tabPane id="addapply-tab2" tabTitle="用户权限授予" lazeload="true">
							<tab:iframe id="addapplytab2" src="<%=pathtab2%>"
								frameborder="0" scrolling="no" width="98%" height="460">
							</tab:iframe>
						</tab:tabPane>

					</tab:tabContainer>
				</td>
			</tr>
		</table>
	</body>
</html>


