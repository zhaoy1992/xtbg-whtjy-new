<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    String isUserRes = request.getParameter("isUserRes");//���Ʋ�ѯ��������,Ϊisʱ,��ѯ�û�Ϊ��ǰ�û�
    if(isUserRes == null)
    {
    	isUserRes ="no";
    }
    String typeName = request.getParameter("typeName");
%>
<HTML>
 <HEAD>
   <title>Ȩ����Դ��ѯ</title>
 
 </HEAD>
 	<frameset rows="18%,*" border=0>
	<frame frameborder=0  noResize scrolling="no" marginWidth=0 name="forQuery" src="<%=request.getContextPath()%>/sysmanager/resmanager/res_query.jsp?isUserRes=<%=isUserRes%>&typeName=<%=typeName %>"></frame>
	<frame frameborder=0  noResize scrolling="auto" marginWidth=0 name="forDocList" src="<%=request.getContextPath()%>/sysmanager/user/userres_querylist.jsp?isUserRes=<%=isUserRes%>&typeName=<%=typeName %>"></frame>
	</frameset>	
</HTML>