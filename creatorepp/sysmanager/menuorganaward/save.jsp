<%@ include file="../include/global1.jsp"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.chinacreator.security.AccessControl" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.RoleManagerImpl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.db.ResManagerImpl" %>
<%@ include file="../base/scripts/panes.jsp"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userId = accesscontroler.getUserID();
		String idString = request.getParameter("treeids");//��ԴID
		List resIds = null;
		if(idString!=null && !idString.equals("")){
			String[] res = idString.trim().split(":");
			resIds = new ArrayList();
			for(int i=0;i<res.length;i++){
				String[] temps = res[i].split(";");
				resIds.add(temps);
			}
		}
			String restypeid = request.getParameter("restypeid");//��Դ����ID
			String roletype = request.getParameter("roletype");//�û�/��ɫ
			String roleidsstr = request.getParameter("roleids");//�û�/��ɫID
			String[] roleids = null;
			if(roleidsstr!=null && !roleidsstr.equals("")){
				roleids = roleidsstr.trim().split(":");
			}
			String opidsstr = request.getParameter("opids");
			String[] opids = null;
			if(opidsstr!=null && !opidsstr.equals("")){
				//if(opidsstr.equals("readorgname"))
					//opids = new String[]{opidsstr,"read","write"};
				//else
					opids = new String[]{opidsstr};
			}
			
			
			//System.out.println("resIds: "+idString);
			//System.out.println("restypeid: "+restypeid);
			//System.out.println("roletype: "+roletype);
			//System.out.println("roleids: "+roleidsstr);
			//System.out.println("opids: "+opidsstr);
			boolean flag = new RoleManagerImpl().saveResGrant(opids,resIds,roleids,restypeid,roletype,userId);
			if(flag){
%>
				<SCRIPT language="javascript">
					alert("����ɹ�!")
				</SCRIPT>
<%
			}else{
%>
				<SCRIPT language="javascript">
					alert("����ʧ��!")
				</SCRIPT>
<%
			}
%>
<html>
	<SCRIPT language="javascript">
		function subForm(){
			if("orgunit"=="<%=restypeid%>"){
				form1.action="orgChooseTree.jsp";
				form1.target="orgChooseTree";
			}else{
				form1.action="menuTree.jsp";
				form1.target="menuTree";
			}
			form1.submit();
		}
	</SCRIPT>
	<%@ include file="/epp/css/cssControl.jsp"%><body  onload="subForm()">
		<form action="" target="" method="post" name="form1">
			<input type="hidden" id="idString" name="idString" value="<%=roleidsstr%>">
			<input type="hidden" id="type" name="type" value="<%=roletype%>">
		</form>
	</body>
</html>
