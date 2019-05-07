<%-- 
描述：用户组处理界面
作者：肖杰
版本：1.0
日期：2013-08-02
 --%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.purviewmanager.entity.GroupBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.RequestBeanUtils"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.GroupManager"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.Group"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<head>
<title>用户组处理界面</title>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path=request.getContextPath();
boolean flag = false;
boolean flag1=true;
String info="";
int  userId=Integer.parseInt(accesscontroler.getUserID());
String subid=StringUtil.deNull(request.getParameter("subid"));
String action = StringUtil.deNull(request.getParameter("action"));
String parentId = StringUtil.deNull(request.getParameter("parent_id"));	
String groupId = request.getParameter("group_id");	
String groupName = request.getParameter("group_name");
String oldGroupName = request.getParameter("oldgroup_name");
String groupDesc = request.getParameter("group_desc");
				
if(parentId == "" )
{
	parentId="0";
}

//对新增子组是否是一级组还是子组,进行不同的操作
String son =StringUtil.deNull(request.getParameter("son"));

GroupManager groupManager=SecurityDatabase.getGroupManager();
Group group=new Group();
if("add".equals(action)||"addson".equals(action)) {
	group.setOwner_id(userId);
	group.setParentId(Integer.parseInt(parentId));			
	group.setGroupName(groupName);
	group.setGroupDesc(groupDesc);
	info=groupManager.saveGroup(group,accesscontroler.getUserID());
	if("操作成功".equals(info)){
		flag=true;
	}
} else if("del".equals(action)) {
	group.setGroupId(Integer.parseInt(groupId));
	if(groupManager.deleteGroup(group))
	{
		flag=true;
	}
	
} else if("update".equals(action)){
	group.setGroupId(Integer.parseInt(groupId));
	group.setGroupName(groupName);
	group.setGroupDesc(groupDesc);	
	info=groupManager.updateGroup(group,oldGroupName);
	if("操作成功".equals(info)){
		flag=true;
	}
}


%>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript">
var mes = "";
var bool = true;
var action = "<%=action%>";
var subid="<%=subid%>";
if(<%=flag%>){
	bool = false;
	if(<%=flag1%>){
		mes = "操作成功"; 
		var submitAlertOK = function(){
			//window.parent.removeWindows('<%=subid %>',true);
			if(action == "del"){
				parent.parent.getGroupValue("grouptree.jsp");
			}else if(action=="update"){
				parent.getParentWindow('update').parent.getGroupValue("grouptree.jsp?group_id=<%=groupId%>");
				closeAlertWindows(subid,true,false);
			}else if(action == "add"){
				closeAlertWindows(subid,false,true);
			}else if(action=="addson"){
				parent.getParentWindow('addson').parent.getGroupValue("grouptree.jsp?group_id=<%=parentId%>");
				closeAlertWindows(subid,true,false);
			}
		}
		var p={
			headerText:'操作信息',
			okName:'确认',
			okFunction:submitAlertOK
		};  
		alert("操作成功！",p);
	}else{
		alert('该参数值编号在该参数编号下已经被引用，请换另外一个编号！');
	}
}else{
	mes = "操作失败"	;
	bool = false;
}
</script>
</head>
<body>
</body> 
</html>