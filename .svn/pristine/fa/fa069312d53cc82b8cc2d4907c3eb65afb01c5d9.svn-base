<%-- 
	描述：角色隶属机构的后台处理页面
	作者：黄艺平
	版本：1.0
	日期：2013-05-30
 --%>

<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.LogGetNameById"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.*"%>
<%@ page import="com.frameworkset.util.StringUtil"%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>


<%		
		AccessControl control = AccessControl.getInstance();
		control.checkManagerAccess(request,response);
	
		String roleId = request.getParameter("roleId");
		String orgId = request.getParameter("orgids");
		String tag = request.getParameter("tag");		
		
		//---------------START--角色管理写操作日志
		String operContent="";        
        String operSource=control.getMachinedID();
        String openModle="角色管理";
        String userName = control.getUserName();
        LogManager logManager = SecurityDatabase.getLogManager(); 	
		String roleName_log = LogGetNameById.getRoleNameByRoleId(roleId);
		operContent=userName+" 对角色  "+ roleName_log+"  对应的机构进行了操作"; 						
		logManager.log(control.getUserAccount() ,operContent,openModle,operSource,""); 
		
		String[] roleids = StringUtil.split(roleId,",");
		String orgids[] = StringUtil.split(orgId,",");
			         
	
		boolean flag = false;
		
		OrgManager orgManager = SecurityDatabase.getOrgManager();
		
		if(tag != null  && !tag.equals("")  && tag.equals("add"))
		{
			flag = orgManager.storeOrgRole(orgids,roleids);
		}
		
		if(tag != null && !tag.equals("") && tag.equals("delete"))
		{
			flag = orgManager.deleteOrgrole(orgids, roleids);
		}
	
%>

<script>
var bool = false;
    window.onload = function prompt()
    {    
		if(<%=flag%>) {
			bool = true;
		} else {
			bool = false;
		}
		
       	parent.divProcessing.style.display="none";
        parent.document.all("button1").disabled = false;
		parent.document.all("button2").disabled = false;
		parent.document.all("button3").disabled = false;
		parent.document.all("button4").disabled = false;
		parent.document.all("back").disabled = false;
		if(bool) {
			mes = "操作成功";
			alert(mes);
		} else {
			alert("操作失败");
		}
    }
</script>

<script>

</script>