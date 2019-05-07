<%
/*
 * <p>Title: 获取机构资源操作</p>
 * <p>Description: 获取机构资源操作</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-28
 * @author baowen.liu
 * @version 1.0
 *
 */
%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg" %>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.resource.ResourceManager"%>


<%
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
		
		String restypeId=request.getParameter("restypeId");
		ResourceManager resManager = new ResourceManager();
		List Operationslist = resManager.getOperations(restypeId);
		
		if(Operationslist == null)
		{
			Operationslist = new ArrayList();
		}
		
		request.setAttribute("Operationslist",Operationslist);
		
%>

<script language="javascript">
		var operselect = parent.document.getElementById("operategroup");
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
		