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
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
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
String path = request.getContextPath();
String userid = accesscontroler.getUserID();//获得当前登录用户id
String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
//update by shixing.he 望城项目分子系统菜单展示 begin
String childsystem = StringUtil.deNull(request.getParameter("childsystem"));//望城子系统分菜单显示
String subSysFristMenu= StringUtil.deNull(request.getParameter("subSysFristMenu"));//子系统要显示的菜单
String subSysName = StringUtil.deNull(request.getParameter("subSysName"));//子系统名称
Map<String, String> map = new HashMap<String, String>();//用来存放显示的所有一级菜单的ID
if(userArea.equals("421005")){//望城专用
	if(subSysName.equals("ywzc")){//业务支撑子系统菜单
		map.put("wc_contractmanage", "wc_contractmanage");//项目管理
		map.put("wc_agreementmanage", "wc_agreementmanage");//合同管理
		map.put("wc_ProjectChangesVisaManage", "wc_ProjectChangesVisaManage");//合同管理
		map.put("wc_store_land", "wc_store_land");//储备土地情况
		map.put("wc_sell_land", "wc_sell_land");//土地出让计划
		map.put("wc_current_report", "wc_current_report");//通用报表
	} else if(subSysName.equals("kjff")){//科技防腐
		map.put("wc_zcyjyfxd", "wc_zcyjyfxd");//政策依据与风险点
		map.put("wc_ssjd", "wc_ssjd");//实时监督
		map.put("cmpnrgl","cmpnrgl");//触摸屏内容管理
	} else if(subSysName.equals("spjk")){//视频监控
		map.put("wc_jkdgl", "wc_jkdgl");//监控点管理
		map.put("wc_dlxcjk", "wc_dlxcjk");//道路现场监控
		map.put("wc_ddjk", "wc_ddjk");//单点监控
		map.put("wc_spckrz", "wc_spckrz");//视频查看日志
	} else if(subSysName.equals("gzgl")){//工资管理
		map.put("wc_salary_report", "wc_salary_report");//新工资管理
		map.put("wc_salary_gzlm", "wc_salary_gzlm");//工资栏目管理
		map.put("wc_salary_parameter", "wc_salary_parameter");//工资参数定义
		map.put("wc_salary_grsds", "wc_salary_grsds");//个人所得税
		map.put("wc_wcyjgl", "wc_wcyjgl");//五险一金管理
		map.put("wc_gzbzgl", "wc_gzbzgl");//工资编制管理
		map.put("wc_gzshgl", "wc_gzshgl");//工资审核管理
		map.put("wc_grgzcx", "wc_grgzcx");//个人工资查询
	} else {//协同办公子系统菜单
		map.put("wc_wdgw", "wc_wdgw");//我的工作
		map.put("wc_gwgl", "wc_gwgl");//公文管理
		map.put("wc_zskzx", "wc_zskzx");//知识库中心
		map.put("wc_jtglzd", "wc_jtglzd");//知识库中心
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
		map.put("hh_smsSend", "hh_smsSend");//短信发送
		map.put("vote", "vote");//网上投票
		map.put("wc_yjx", "wc_yjx");//意见箱
	}
} else if(userArea.equals("421006")){//财政厅专用
	if(subSysName.equals("_grbg")){//个人办公子系统
		
	} else if(subSysName.equals("_xxcl")){//信息处理
		map.put("czt_zwxx", "czt_zwxx");//政务信息
		map.put("czt_xxkw", "czt_xxkw");//信息刊物
		map.put("czt_djql", "czt_djql");//党建勤廉
		map.put("czt_cns", "czt_cns");//承诺书
		map.put("czt_dwgk", "czt_dwgk");//党务公开
		map.put("xxgk_xxgk", "xxgk_xxgk");//信息公开
		map.put("hh_smsSend", "hh_smsSend");//短信发送
	} else if(subSysName.equals("_zhgl")){//综合管理
		map.put("meetingmanager", "meetingmanager");//会议管理
		map.put("czt_clgl", "czt_clgl");//车辆管理
		map.put("czt_bgwp", "czt_bgwp");//资产管理
		map.put("czt_tsgl", "czt_tsgl");//图书管理
		map.put("data", "data");//政策法规管理
		map.put("czt_zbwcf", "czt_zbwcf");//指标文拆分
		map.put("kbm", "kbm");//知识库
		map.put("czt_spgl", "czt_spgl");//视频管理
	} else if(subSysName.equals("_xtgl")){//系统管理
		map.put("dict", "dict");//数据字典
		map.put("czt_nrwh","czt_nrwh");//内容维护
		map.put("eppmanager","eppmanager");//平台管理
		map.put("workflowHadder", "workflowHadder");//流程管理
		map.put("pzgl", "pzgl");//配置管理
		map.put("sysparam", "sysparam");//系统参数设置
		map.put("purviewmanager_new", "purviewmanager_new");//权限管理
		map.put("data_resources", "data_resources");//数据权限
		map.put("unit_resources", "unit_resources");//单位接收人
		map.put("holidaymanager", "holidaymanager");//节假日管理
	} else if(subSysName.equals("_dagl")){//档案管理
		map.put("beforearchivelistManage", "beforearchivelistManage");//公文待归档管理
		map.put("filedoc", "filedoc");//文件管理
		map.put("filefilesmanage", "filefilesmanage");//档案管理
		map.put("filequeryManage", "filequeryManage");//档案查询
		map.put("filecollect", "filecollect");//我的收藏
		map.put("fileBorrowManage", "fileBorrowManage");//档案借阅
		map.put("fileDestroyManage", "fileDestroyManage");//档案保管
		map.put("file", "file");//基础数据管理
	} else {//首页
		map.put("tzgg", "tzgg");//通知公告
		map.put("czt_rcap", "czt_rcap");//日程安排
		map.put("gwgl", "gwgl");//公文管理
		map.put("persondata", "persondata");//个人文件柜
		map.put("czt_dbt", "czt_dbt");//督办台
		map.put("czt_gjzx", "czt_gjzx");//干教中心
		map.put("grgzzjyjh", "grgzzjyjh");//个人工作总结与计划
		map.put("zhywdwgl", "zhywdwgl");//综合业务单位管理
		
	}
}
//update by shixing.he 望城项目分子系统菜单展示 end
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
	//望城专用
	if(userArea.equals("421005") || userArea.equals("421006")){
		if(fristModule.getId() != null && fristModule.getId().equals(map.get(fristModule.getId()))){//过滤不显示的一级菜单
	%>
			//一级菜单
			fristModule =  new $.menu();
			fristModule.menuID ='<%=fristModule.getId()%>';
			fristModule.text = '<%=fristModule.getName()%>';
			fristModule.subSysName = '<%=subSysName%>';
			<%
			if("421005".equals(userArea) || userArea.equals("421006")){
			%>
				fristModule.url = '<%=fristModule.getDescription()%>';
			<%
			}
			%>
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
					 item.subSysName = '<%=subSysName%>';
					 fristModule.menuList.push(item);
					<%
				}else if(itemList1.size() == 0){//二级菜单用module
				%>
					secondModule =  new $.menu();
					secondModule.menuID ='<%=aModule.getId()%>';
					secondModule.text = '<%=aModule.getName()%>';
					secondModule.subSysName = '<%=subSysName%>';
					secondModule.url = '<%=aModule.getDescription()%>';
					fristModule.menuList.push(secondModule);
				<%
				}else{
				%>
				//二级目录
				aModule =  new $.menu();
				aModule.menuID ='<%=aModule.getId()%>';
				aModule.text = '<%=aModule.getName()%>';
				aModule.subSysName = '<%=subSysName%>';
				fristModule.menuList.push(aModule);
				<%
				
				 for(Item item1 : itemList1){//三级菜单
					 %>
					 item = new $.menu();
					 item.menuID = '<%=aModule.getId()%>s';
					 item.text = '<%=item1.getName()%>';
					 item.url = '<%=item1.getWorkspaceContent()%>';
					 item.subSysName = '<%=subSysName%>';
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
				 item.subSysName = '<%=subSysName%>';
				 fristModule.menuList.push(item);
				 <%
			}
		}
	 } else {
	 %>
	 	//一级菜单
		fristModule =  new $.menu();
		fristModule.menuID ='<%=fristModule.getId()%>';
		fristModule.text = '<%=fristModule.getName()%>';
		<%
		if("421005".equals(userArea) || userArea.equals("421006") || "410004".equals(userArea)|| "410003".equals(userArea)){
		%>
			fristModule.url = '<%=fristModule.getDescription()%>';
		<%
		}
		%>
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
			<a href="javascript:openWindows('main_todowork','待办任务','../../../wangcheng/waitDoWork/jsp/wangcheng_todoworktabs.jsp?index=0',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("431000".equals(userArea)){ %>
			<a href="javascript:openWindows('main_todowork','待办任务','../../../chenzhou/waitDoWork/jsp/chenzhou_todoworktabs.jsp?index=0',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("410000".equals(userArea)){ %>
			<a href="javascript:openWindows('main_todowork','待办任务','../../../changshashi/waitDoWork/jsp/cs_todoworktabs.jsp?index=0',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("410001".equals(userArea)){%>
			<a href="javascript:openWindows('main_todowork','待办任务','../../../jiaoyuksy/waitDoWork/jsp/todoworktabs.jsp?index=0',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("410002".equals(userArea)){%>					
			<a href="javascript:openWindows('main_todowork','待办任务','../../../huaihua/waitDoWork/jsp/huaihua_todoworktabs.jsp?index=0',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("421006".equals(userArea)){%>
			<!-- <a href="javascript:openWindows('main_todowork','待办任务','',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>-->
			<a href="javascript:openWindows('main_todowork','未处理任务','<%=path %>/ccapp/oa/todolist/todomain.jsp?index=0',false,false,false,true,true,'')">未处理任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%}else if("410003".equals(userArea)){%>
			<a href="javascript:openWindows('main_todowork','待办任务','../../../fagaiwei/waitDoWork/jsp/fgw_todoworktabs.jsp?index=0',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%} else if("410004".equals(userArea)){%>
			<a href="javascript:openWindows('main_todowork','待办任务','../../../shuiwuju/waitDoWork/jsp/swj_todoworktabs.jsp?index=0',false,false,false,true,true)">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%} else if("421007".equals(userArea)){%>
			<a href="javascript:openWindows('main_todowork','待办任务','<%=path %>/ccapp/oa/todolist/todomain.jsp?index=0',false,false,false,true,true,'')">待办任务<span class="color_red">(<span id="workCount">0</span>)</span></a>
			<%} %>
		</div>


		<div class="left_mail_list">
			<%
			if("421005".equals(userArea) || "421006".equals(userArea)|| "410004".equals(userArea)|| "410000".equals(userArea)){//望城
			 %>
				<a href="javascript:openWindows('sub_main_personwork','通讯录','../../../../oa/personwork/jsp/personworkmantab.jsp',false,false,false,true,true)">通讯录</a>
			<%
			} else { %>
				<a href="javascript:openWindows('sub_main_personwork','通讯录','../../personwork/jsp/addressbooktabs.jsp',false,false,false,true,true)">通讯录</a>
			<%} %>
		</div>
		<!------------------------------ left01   结束 ------------------------------------>
		<div class="left_background_img"></div>
		<!------------------------------ left02   结束 ------------------------------------>
		<div id="_left_menu" class="_left_menu_tree"></div>
		<div class="left_background_img"></div>

</body>
</html>