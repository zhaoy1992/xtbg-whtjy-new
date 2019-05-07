<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../../include/global1.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.ResManager,com.chinacreator.resource.ResourceManager"%>

<%
		AccessControl control = AccessControl.getInstance();
		control.checkAccess(request,response);
		//String userId = (String)session.getAttribute("currUserId");
		String resTypeId=request.getParameter("resTypeId");
		System.out.println("resTypeId === " + resTypeId);
		
		ResourceManager resManager = new ResourceManager();
		List Operationslist = resManager.getOperations(resTypeId);
		if(Operationslist == null)
			Operationslist = new ArrayList();
		request.setAttribute("Operationslist",Operationslist);

		
		
		
%>

		<script language="javascript">
		
		var operselect = parent.document.getElementById("opId");
		var options_ = operselect.options;
		var length = options_.length;
		try
		{
			
			for(var i = 0; i < length - 1; i ++)
			{
				operselect.removeChild(options_(1));
				

			}

		}
		catch(e)
		{
			alert(e);
		}
	     

		
			<pg:list requestKey="Operationslist" needClear="false">
			    var option = new Option();
				option.value = '<pg:cell colName="id"/>';
			    option.text = '<pg:cell colName="name"/>';
				operselect.add(option);
			</pg:list>

		</script>
		