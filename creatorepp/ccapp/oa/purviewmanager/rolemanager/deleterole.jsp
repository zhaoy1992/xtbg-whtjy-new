<%--
������ɾ����ɫ
���ߣ�����
�汾��1.0
ʱ�䣺2013-5-15
 --%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%			
	AccessControl accessControl = AccessControl.getInstance();
	accessControl.checkManagerAccess(request,response); //ҳ���¼����
	boolean tag = true;

	try{
		//ɾ������
		RoleTypeManager rtm = new RoleTypeManager();
		String id = request.getParameter("role_ids");			
		if ((id != null) && (id.length() > 0)) {
			String[] ids = id.split(";");
			
			RoleManager roleManager = SecurityDatabase.getRoleManager();
			//--��ɫ����д������־	
			String operSource=accessControl.getMachinedID();
	  		String openModle="��ɫ����";
			String operContent="ɾ����ɫ,��ɫid�� " + id; 						
			String description="";
			LogManager logManager = SecurityDatabase.getLogManager(); 
			logManager.log(accessControl.getUserAccount(),operContent,openModle,operSource,description);       
			//--��־����
				
			tag = roleManager.deleteRoles(ids);
		}
	}catch(Exception e){
		e.printStackTrace();
		tag = false;
	}
%>
<script type="text/javascript">
var mes = "";
var bool = true;
if(<%=tag%>){
	 mes = "ɾ���ɹ���";	
} else {
  	mes = "ɾ��ʧ�ܣ�";
	bool = false;
}

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