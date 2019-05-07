<%--
描述:生成一些公共的js方法如:getSysElement
作者:minghua.guo
版本:1.0
CopyRight:湖南科创
日期:2011-06-24
 --%>
<%@page contentType="text/html;charset=GBK"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.sysmgrcore.entity.Organization"%>
<%@page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@page import="com.chinacreator.sysmgrcore.manager.OrgManager"%>
<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);

String userAccount = accesscontroler.getUserAccount();
String userName = accesscontroler.getUserName();
String userid = accesscontroler.getUserID();
String userorgid = "";
String userorgname = "";
try {
	OrgManager orgManager = SecurityDatabase.getOrgManager();
	List list = orgManager.getOrgListOfUser(userid);				
	if(list!=null && list.size()>0){
		Organization org = (Organization)list.get(0);
		userorgid = org.getOrgId();
		userorgname = org.getOrgName();
	}
} catch (Exception e) {
	e.printStackTrace();
}
%>
<script language="javascript">
var SysElement = {
	userAccount : '<%=userAccount %>',
	userName : '<%=userName %>',
	userid : '<%=userid %>',
	userorgid : '<%=userorgid %>',
	userorgname : '<%=userorgname %>'
};
function getSysElement(type){
	return SysElement[type];
}
</script>