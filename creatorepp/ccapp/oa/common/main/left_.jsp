<%@page import="com.chinacreator.framework.Framework"%>
<%@page import="com.chinacreator.framework.MenuItem"%>
<%@page import="com.chinacreator.framework.Item"%>
<%@page import="com.chinacreator.framework.ItemQueue"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.framework.Module"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.framework.ModuleQueue"%>
<%@page import="com.chinacreator.framework.MenuHelper"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">

var tree = new $.tree();
var fristModule = null;
var aModule = null;
tree.treeID = "main_tree";
tree.showAreaID = "_left_menu";
tree.mainTree=['mian'];
tree.isSearch=false;
tree.showTreeHeader = false;
var item = null;


<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String userid = accesscontroler.getUserID();//获得当前登录用户id
String path = request.getContextPath();
boolean isAdmin = accesscontroler.isAdmin();//是否是超级管理
String fristItemAdminShowArray = "eppmanager,sysmanager,workflowHadder,directory,pzgl";
String secendItemadminShowArray = "datasourcemanager,work_class_manage,menuconfigure,purviewmanager_new,holidaymanager,logquery,bbkz,yysdgl,xnyyzc,jawemanage,purviewmanager,mlglmanager,mlglxcmanager,resourceConfig,orgResourceConfig";
String fristItemNotShowArray = "eppmanager";
String secendItemNotShowArray = "datasourcemanager,work_class_manage,menuconfigure,holidaymanager,logquery,jawemanage";
String subSysFristMenu= StringUtil.deNull(request.getParameter("subSysFristMenu"));//子系统要显示的菜单
String subSysName = StringUtil.deNull(request.getParameter("subSysName"));//子系统名称
String fristMenu = "eppmanager,sysmanager,meetingmanager,gwgl,workflowHadder,vote,tzgg,task,file,sysparam,pub_system_manage,dict,scheduleManage,guest,paper";//第一个子系统展示的菜单
boolean meunIsShow = false;//是否显示菜单
boolean isSubSys = true;//是否有子系统

int sum=0;
int itemSum=0;
String modulePath = "module::menu://sysmenu$root";
MenuHelper menuHelper = new MenuHelper(accesscontroler);
ModuleQueue moduleQueue = menuHelper.getSubModules(modulePath);
List<Module> moduleList = moduleQueue.getList();//一级菜单
String context = request.getContextPath();

List<Module> submoduleList =  null;
ModuleQueue submoduleQueue = null;

ItemQueue itemQueue3 = null;
List<Item> itemList3 = null;
for(Module fristModule : moduleList) {
	
	%>
	//一级菜单
	fristModule =  new $.menu();
	fristModule.menuID ='<%=fristModule.getId()%>';
	fristModule.text = '<%=fristModule.getName()%>';
	<%
	if (isAdmin) { 
		if(fristItemAdminShowArray.indexOf(fristModule.getId()) > -1) {
			meunIsShow = true;
		}
	} else {
		if(fristItemNotShowArray.indexOf(fristModule.getId()) > -1) {
		} else if(isSubSys) {
			if(subSysFristMenu.indexOf(fristModule.getId()) > -1) {
				meunIsShow = true;
			}
		} else {
			meunIsShow = true;
		}
	}
	if(meunIsShow) {
		meunIsShow = false;
		ItemQueue itemQueue2 = fristModule.getItems();
		List<Item> itemList2 = itemQueue2.getList();
		if(null != itemList2 && 1==itemList2.size()) {
	%>
	<%
		} else {
	%>
		 tree.menuList.push(fristModule);
	<%
		}
	}
	
	
	itemQueue3 = fristModule.getItems();
	itemList3 = itemQueue3.getList();
	for(Item item1 : itemList3){//二级菜单
		 MenuItem menu = Framework.getInstance().getMenu(item1.getPath());
		 String url = MenuHelper.getPerspectiveContentUrl(context, item1.getPath(),(Map)null);//item1.getWorkspaceContent();
		 %>
		 item = new $.menu();
		 item.menuID = '<%=fristModule.getId()%>';
		 item.text = '<%=item1.getName()%>';
		 item.url = '<%=url%>';
		 item.subSysName = '<%=subSysName%>';
		 item.subSysFristMenu = '<%=subSysFristMenu%>';
	 	<%
		if (isAdmin) { 
			if(secendItemadminShowArray.indexOf(item1.getId()) > -1) {
				meunIsShow = true;
			}
		} else {
				if(secendItemNotShowArray.indexOf(item1.getId()) > -1) {
				} else if( isSubSys){
					if(subSysFristMenu.indexOf(item1.getParent().getId()) > -1) {
						meunIsShow = true;
					}
				} else {
					meunIsShow = true;
				}
		}
	 	if(meunIsShow) {
	 		meunIsShow = false;
	 		if(null != itemList3 && 1==itemList3.size()){
	 	%>
	 			tree.menuList.push(item);
	 	<%	
	 		} else {
		%>
			 	fristModule.menuList.push(item);
		<%
	 		}
		}
	 }
}

%>
$(function(){
	try{
		var win = getIFrameWindow('_document_body_mian_firstPagerAAAS');
		if(null != win){
			$('#workCount').html(win.TOTAL); 
		}else{
			$('#workCount').html(0); 
		}
	}catch(error){}
	
});
</script>
<body>
		<div class="left_to_do_list">
			<a href="javascript:openWindows('main_todowork','待办任务','<%=path %>/ccapp/xtbg/tjy/waitDoWork/jsp/todoworktabs.jsp?index=0',false,false,false,true,true,'ccapp/oa/common/main/left_.jsp?subSysFristMenu=<%=fristMenu %>')">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
		</div>

		<div class="left_mail_list">
			<a href="javascript:openWindows('sub_main_personwork','通讯录','<%=path %>/ccapp/oa/personwork/jsp/personworkmantab.jsp',false,false,false,true,true,'ccapp/oa/common/main/left_.jsp?subSysFristMenu=<%=fristMenu %>')">通讯录</a>
		</div>
		<!------------------------------ left01   结束 ------------------------------------>
		<div class="left_background_img"></div>
		<!------------------------------ left02   结束 ------------------------------------>
		<div id="_left_menu" class="_left_menu_tree"></div>
		<div class="left_background_img"></div>
</body>
</html>