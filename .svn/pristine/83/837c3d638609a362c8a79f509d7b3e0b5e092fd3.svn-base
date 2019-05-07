<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
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
<html>
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
String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
String childsystem = request.getParameter("childsystem");//望城子系统分菜单显示
Map<String, String> map = new HashMap<String, String>();//用来存放显示的所有一级菜单的ID
if(childsystem != null && childsystem.equals("xtbg")){//协同办公子系统菜单
	map.put("wc_gwgl", "wc_gwgl");//公文管理
	map.put("wc_zskzx", "wc_zskzx");//知识库中心
	map.put("wc_train_gl", "wc_train_gl");//培训管理中心
	map.put("wc_dananguanli", "wc_dananguanli");//档案管理
	map.put("sysmanager", "sysmanager");//系统管理
	map.put("workflowManager", "workflowManager");//流程管理
	map.put("wc_dict_manager", "wc_dict_manager");//数据字典管理
	map.put("pzgl", "pzgl");//配置管理
	map.put("wc_monthCash", "wc_monthCash");//资金需求计划
	map.put("ymj_tzgg", "ymj_tzgg");//通知公告
	map.put("wc_yygl", "wc_yygl");//用印管理
	map.put("schedule", "schedule");//日程管理
	map.put("conference", "conference");//会议管理
	map.put("ymj_zcgl", "ymj_zcgl");//资产管理
	map.put("ymj_mails", "ymj_mails");//电子邮件
	map.put("sx_qsbg", "sx_qsbg");//请示报告
	map.put("wc_salarymanage", "wc_salarymanage");//工资管理
	map.put("suxian_mlgls", "suxian_mlgls");//人事档案管理
	map.put("wc_plan_manager", "wc_plan_manager");//部门周工作安排
	map.put("wc_systemParameterConfig", "wc_systemParameterConfig");//参数设置
} else if(childsystem != null && childsystem.equals("rcgz")){//日常工作子系统菜单
	
} else if(childsystem != null && childsystem.equals("ywzc")){//业务支撑子系统菜单
	map.put("wc_contractmanage", "wc_contractmanage");//项目管理
	map.put("wc_agreementmanage", "wc_agreementmanage");//合同管理
	map.put("wc_store_land", "wc_store_land");//储备土地情况
	map.put("wc_sell_land", "wc_sell_land");//土地出让计划
	map.put("wc_current_report", "wc_current_report");//通用报表
}
int sum=0;
int itemSum=0;
String modulePath = "module::menu://sysmenu$root";
MenuHelper menuHelper = new MenuHelper(accesscontroler);
ModuleQueue moduleQueue = menuHelper.getSubModules(modulePath);
List<Module> moduleList = moduleQueue.getList();//一级菜单
String context = request.getContextPath();

List<Module> submoduleList =  null;
ModuleQueue submoduleQueue = null;
for(Module fristModule : moduleList) {
	if(fristModule.getId() != null && fristModule.getId().equals(map.get(fristModule.getId()))){//过滤不显示的一级菜单
		%>
		//一级菜单
		fristModule =  new $.menu();
		fristModule.menuID ='<%=fristModule.getId()%>';
		fristModule.text = '<%=fristModule.getName()%>';
		tree.menuList.push(fristModule);
		<%
		submoduleQueue = fristModule.getSubModules();
		submoduleList = submoduleQueue.getList();
		for(Module aModule : submoduleList) {
			ItemQueue itemQueue1 = aModule.getItems();
			List<Item> itemList1 = itemQueue1.getList();
			if(null != itemList1 && 1==itemList1.size()){
				//二级目录
				%>
				 item = new $.menu();
				 item.menuID = '<%=aModule.getId()%>s';
				 item.text = '<%=itemList1.get(0).getName()%>';
				 item.url = '<%=itemList1.get(0).getWorkspaceContent()%>';
				 fristModule.menuList.push(item);
				<%
			}else{
			%>
			//二级目录
			aModule =  new $.menu();
			aModule.menuID ='<%=aModule.getId()%>';
			aModule.text = '<%=aModule.getName()%>';
			fristModule.menuList.push(aModule);
			<%
			
			 for(Item item1 : itemList1){//三级菜单
				 %>
				 item = new $.menu();
				 item.menuID = '<%=aModule.getId()%>s';
				 item.text = '<%=item1.getName()%>';
				 item.url = '<%=item1.getWorkspaceContent()%>';
				 aModule.menuList.push(item);
				 <%
			 }
			}
		}
		ItemQueue itemQueue3 = fristModule.getItems();
		List<Item> itemList3 = itemQueue3.getList();
		for(Item item1 : itemList3){//二级菜单
			 MenuItem menu = Framework.getInstance().getMenu(item1.getPath());
			 String url = MenuHelper.getPerspectiveContentUrl(context, item1.getPath(),(Map)null);
			 %>
			 item = new $.menu();
			 item.menuID = '<%=fristModule.getId()%>';
			 item.text = '<%=item1.getName()%>';
			 item.url = '<%=url%>';
			 fristModule.menuList.push(item);
			 <%
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
			<%if("431003".equals(userArea)) {%>
			<a href="javascript:openWindows('main_todowork','待办事项','../../../suxian/waitDoWork/jsp/suxian_todoworktabs.jsp?index=2&waittotal=0&todoworktabstype=flag&entrance=homepage',false,false,false,true,true)">待办事项<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("421000".equals(userArea)){ %>
			<a href="javascript:openWindows('main_todowork','待办任务','../../../yimingju/waitDoWork/jsp/ymj_todoworktabs.jsp?index=2&waittotal=0&todoworktabstype=flag&entrance=homepage',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("430800".equals(userArea)){ %>
			<a href="javascript:openWindows('main_todowork','待办任务','../../../zhangjiajie/waitDoWork/jsp/zhangjiajie_todoworktabs.jsp?index=2&waittotal=0&todoworktabstype=flag&entrance=homepage',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("421001".equals(userArea)){ %>
			<a href="javascript:openWindows('main_todowork','待办任务','../../../hengyang/waitDoWork/jsp/hengyang_todoworktabs.jsp?index=1&waittotal=0&todoworktabstype=flag&entrance=homepage',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("421003".equals(userArea)){ %>
			<a href="javascript:openWindows('main_todowork','待办任务','../../../maocuhui/waitDoWork/jsp/mch_todoworktabs.jsp?index=0',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("421004".equals(userArea)){ %>
			<a href="javascript:openWindows('main_todowork','待办任务','../../../huaihua/waitDoWork/jsp/huaihua_todoworktabs.jsp?index=0',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("421005".equals(userArea)){ %>
			<a href="javascript:openWindows('main_todowork','待办任务','../../../huaihua/waitDoWork/jsp/huaihua_todoworktabs.jsp?index=0',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("431000".equals(userArea)){ %>
			<a href="javascript:openWindows('main_todowork','待办任务','../../../chenzhou/waitDoWork/jsp/chenzhou_todoworktabs.jsp?index=0',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("410000".equals(userArea)){ %>
			<a href="javascript:openWindows('main_todowork','待办任务','../../../huaihua/waitDoWork/jsp/huaihua_todoworktabs.jsp?index=0',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("410001".equals(userArea)){%>
			<a href="javascript:openWindows('main_todowork','待办任务','../../../jiaoyuksy/waitDoWork/jsp/todoworktabs.jsp?index=0',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("410002".equals(userArea)){%>					
			<a href="javascript:openWindows('main_todowork','待办任务','../../../huaihua/waitDoWork/jsp/huaihua_todoworktabs.jsp?index=0',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%} %>
		</div>


		<div class="left_mail_list">
			<a href="javascript:openWindows('sub_main_personwork','通讯录','../../personwork/jsp/addressbooktabs.jsp',false,false,false,true,true)">通讯录</a>
		</div>
		<!------------------------------ left01   结束 ------------------------------------>
		<div class="left_background_img"></div>
		<!------------------------------ left02   结束 ------------------------------------>
		<div id="_left_menu" class="_left_menu_tree"></div>
		<div class="left_background_img"></div>
</body>
</html>