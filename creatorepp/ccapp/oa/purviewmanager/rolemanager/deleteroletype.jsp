<%--
������ɾ����ɫ����
���ߣ�����
�汾��1.0
ʱ�䣺2013-5-15
 --%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
String notice = "";
	try{
		AccessControl accessControl = AccessControl.getInstance();
		accessControl.checkManagerAccess(request, response); //ҳ���¼����
		
		//ɾ������
		RoleTypeManager rtm = new RoleTypeManager();
		String type_ids = StringUtil.deNull(request.getParameter("type_ids"));
		if ((type_ids != null) && (type_ids.length() > 0)) {
			StringTokenizer stValues = new StringTokenizer(type_ids, ";");
			while (stValues.hasMoreElements()) {
				String nextId = (String) stValues.nextElement();
				String name = rtm.getRoleType(nextId).getTypeName();
				if (rtm.hasRoles(nextId)) {//�Ѿ��н�ɫ������ܱ�ɾ��
					notice = notice + "��ɫ���͡�" + name + "�����ڽ�ɫ�����ܱ�ɾ����\\n";
				} else {
					boolean delTag = rtm.delRoleType(nextId);
					if (!delTag) {
						notice = notice + "��ɫ���͡�" + name + "��ɾ��ʧ�ܡ�\\n";
					} else {
						notice = notice + "��ɫ���͡�" + name + "��ɾ���ɹ���\\n";
					}
				}
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<script type="text/javascript">
var mes = "<%=notice %>";
var bool = true;

var ok=function(){
	window.parent.location.reload();
}

if(window.top.removeAlertWindows('<%=StringUtil.deNull(request.getParameter("windowsId"))%>',false,bool,mes,true)){
	if(bool){
		window.top.alert(mes,{headerText:'������',okName:'ȷ��',okFunction:ok});
	}else{
		window.top.alert(mes);
	}
}
</script>
