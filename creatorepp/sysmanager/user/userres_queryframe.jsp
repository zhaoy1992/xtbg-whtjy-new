<%@ page contentType="text/html; charset=GBK" language="java" import="java.util.List"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.UserManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.User"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);

String userId = (String)request.getParameter("userId");
String typeName = (String)request.getParameter("typeName");
//ģ��-�������еĸ�����Ϣ�޸��������˸�ҳ��--���flagΪall˵���Ǹ�����Ϣ�޸�ģ�����ڵ��ø�ҳ��
String flag = request.getParameter("flag")==null?"":request.getParameter("flag");

//����userId��ѯ�û�����
UserManager userManager = SecurityDatabase.getUserManager();
User user = userManager.getUserById(userId);
String userName = user.getUserName();
StringBuffer isAdmin = new StringBuffer();
//�ж���ѡ����û��Ƿ��ǹ���Ա��Ϊ����Ա�Ļ���ֱ�ӵ����Ի�����ʾ�û�ӵ������Ȩ��
if(!"all".equals(flag)){
DBUtil dbUtil = new DBUtil();
StringBuffer hsql = new StringBuffer("select count(*) from td_sm_userrole t where t.role_id = '1' and t.user_id = '"+userId+"'");
dbUtil.executeSelect(hsql.toString());

//dbUtil.getInt(0,0)
if(dbUtil.getInt(0,0) > 0){
	isAdmin.append("alert('���û��ǹ���Ա��ӵ������Ȩ�ޣ�');window.close();");
}else{
	isAdmin.append("");
}
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
	<frame frameborder=0  noResize scrolling="no" marginWidth=0 name="forQuery" src="userres_query.jsp?userId=<%=userId%>&typeName=<%=typeName%>"></frame>		
	<frame frameborder=0  noResize scrolling="auto" marginWidth=0 name="forDocList" src="userres_querylist.jsp?userId=<%=userId%>&typeName=<%=typeName%>"></frame>
	</frameset>	
</HTML>