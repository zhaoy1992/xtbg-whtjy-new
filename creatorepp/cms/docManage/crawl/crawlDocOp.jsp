<%@ page contentType="text/html; charset=GBK"%>

<%@ taglib uri="/WEB-INF/dictionary.tld" prefix="dict"%>

<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.cms.documentmanager.crawl.EDocumentManager"%>
<%@ page import="com.chinacreator.cms.documentmanager.crawl.EDocumentManagerImpl"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String action = request.getParameter("action");
	String docIds = request.getParameter("docIds");
	
	
	boolean flag = false ;
	
	try
	{
		if(action != null && !action.equals("") && docIds != null)
		{
			String[] aDocIds = docIds.split(",") ;
	
			if(aDocIds.length > 0)
			{
				EDocumentManager manager = new EDocumentManagerImpl();
		
				if("send".equals(action))
				{
					manager.importDoc(aDocIds) ;	
					flag = true ;
				}else if("delete".equals(action))
				{
					manager.deleteDocs(aDocIds) ;
					flag = true ;
				}
			}
		}
	}
	catch(Exception e)
	{
		e.printStackTrace() ;
		flag = false ;
	}	
%>

<<script type="text/javascript">
<!--
	if("<%=flag%>" == "true")
	{
		alert("操作成功!");
		
		parent.location.href = parent.location.href ;
	}else
	{
		alert("操作失败!");
	}
//-->
</script>
