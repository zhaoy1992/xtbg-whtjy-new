<%@ page language="java" contentType="text/html; charset=GBK"%>
<%
/**
 * 
 * <p>Title: ��Դ����ѯ����ѯ����ҳ��</p>
 *
 * <p>Description: ��Դ����ѯ����ѯ����ҳ��</p>
 *
 * <p>Copyright: Copyright (c) 2008</p>
 *
 * <p>Company: chinacreator</p>
 * @Date 2008-11-4
 * @author gao.tang
 * @version 1.0
 */
 %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
    AccessControl accesscontroler = AccessControl.getInstance();
    if(!accesscontroler.checkManagerAccess(request, response)){
    	return;
    }
    
    
%>
<HTML>
 <HEAD>
   <title>Ȩ����Դ��ѯ</title>
 
 </HEAD>
 	<frameset rows="18%,*" border=0>
	<frame frameborder=0  noResize scrolling="no" marginWidth=0 name="forQuery" src="res_query.jsp"></frame>
	<frame frameborder=0  noResize scrolling="auto" marginWidth=0 name="forDocList" src="res_querylist.jsp?type=user"></frame>
	</frameset>	
</HTML>