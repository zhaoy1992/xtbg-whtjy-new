<%
/*
 * <p>Title:�û�Ȩ�޲�ѯ���ҳ��</p>
 * <p>Description: �û�Ȩ�޲�ѯ���ҳ��</p>
 * <p>Copyright: Copyright (c) 2008</p>
 * <p>Company: chinacreator</p>
 * @Date 2008-3-26
 * @author liangbing.tao
 * @version 1.0
 */
%>


<%@ page contentType="text/html; charset=GBK" language="java"%>

<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>

<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request,response);

	String userId = (String)request.getParameter("userId");
	String typeName = (String)request.getParameter("typeName");
	String orgId = (String)request.getParameter("orgId");

	//����userId��ѯ�û�����
	UserManager userManager = SecurityDatabase.getUserManager();
	User user = userManager.getUserById(userId);
	String userName = user.getUserName();
	
	//�ж���ѡ����û��Ƿ��ǹ���Ա��Ϊ����Ա�Ļ���ֱ�ӵ����Ի�����ʾ�û�ӵ������Ȩ��
	DBUtil dbUtil = new DBUtil();
	StringBuffer hsql = new StringBuffer("select count(*) from td_sm_userrole t where t.role_id = '1' and t.user_id = "+userId+"");
	dbUtil.executeSelect(hsql.toString());
	StringBuffer isAdmin = new StringBuffer();
	//dbUtil.getInt(0,0)
	if(dbUtil.getInt(0,0) > 0)
	{
		isAdmin.append("alert('���û��ǹ���Ա��ӵ������Ȩ�ޣ�');window.close();");
	}
	else
	{
		isAdmin.append("");
	}


%>
<HTML>
 <HEAD>
   <title>�û�[<%=userName%>]��ԴȨ�޲�ѯ</title>
   <script language="javascript">
		<%=isAdmin.toString()%>
   </script>
 </HEAD>
  <frameset rows="38,*" border=0>
	<frame frameborder=0  noResize scrolling="no" marginWidth=0 name="forQuery" src="userres_query.jsp?userId=<%=userId%>&&typeName=<%=typeName%>&&orgId=<%=orgId %>"></frame>		
	<frame frameborder=0  noResize scrolling="auto" marginWidth=0 name="forDocList" src="userres_querylist.jsp?userId=<%=userId%>&&typeName=<%=typeName%>&&orgId=<%=orgId %>"></frame>
	</frameset>	
</HTML>