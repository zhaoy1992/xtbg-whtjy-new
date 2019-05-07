<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page
	import="com.chinacreator.xtbg.countOlinePerson.service.SessionListener"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.util.StringUtil"%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<%@page import="com.chinacreator.xtbg.util.DaoImplClassUtil"%>
<%@page
	import=" com.chinacreator.xtbg.announcement.dao.AnnouncementReceiveDao"%>
<%@page
	import=" com.chinacreator.xtbg.announcement.entity.AnnouncementBean"%>
<%@page
	import=" com.chinacreator.xtbg.conference.dao.ConferenceNoticeDao"%>
<%@page import=" com.chinacreator.xtbg.conference.entity.ConferenceBean"%>
<%@page import=" com.chinacreator.xtbg.pubopinionedit.dao.PoeManagerDao"%>
<%@page
	import=" com.chinacreator.xtbg.pubopinionedit.entity.PoeBaseInfoBean"%>
<%@page
	import=" com.chinacreator.xtbg.briefseditor.entity.BriefsEditorBean"%>
<%@page import=" com.chinacreator.xtbg.briefseditor.dao.BriefsBrowseDao"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pubopinionedit.entity.PoeInfoType"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.home.entity.ToDoWorkSearchBean"%>
<%@page import="com.chinacreator.xtbg.home.entity.ToDoWorkListBean"%>
<%@page import="com.chinacreator.xtbg.zjjsw.entity.RecevieAndSend"%>
<%@page import="com.chinacreator.xtbg.inforeported.entity.InfoReportBaseInfoBean"%>
<%@page import="com.chinacreator.xtbg.util.DaoUtil"%>
<%@page
	import="com.chinacreator.xtbg.workflow.entity.WorkFlowShowListBean"%>

<%@page import="com.chinacreator.xtbg.home.dao.HomeBusinessDao"%><html>
<head>
<%
String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getInstance();

accesscontroler.checkAccess(request, response);
String userid = accesscontroler.getUserID();//获得当前登录用户id
String username = accesscontroler.getUserAccount();
String username1 = accesscontroler.getUserName();//获得当前登录用户name
String orgid=accesscontroler.getChargeOrgId();//获得当前机构id
String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
String orgName=accesscontroler.getChargeOrgName();//获得当前机构name

int  j, c, z, m, a, b, s,d;

//获得根据按发布时间排序的当前前五条数据（通知公告）list
List<AnnouncementBean> announcementinfos = new ArrayList<AnnouncementBean>();
AnnouncementReceiveDao annoucementdao = (AnnouncementReceiveDao) DaoImplClassUtil
		.getDaoImplClass("announcementReceiveDaoImpl");
announcementinfos = annoucementdao.getAnnouncementInfo(userid,orgid);//获得通知公告信息list
if (announcementinfos.size() > 0) {//获得数据的大小，判断所要加的空列
	j = 5- announcementinfos.size();
} else {
	j = 0;
}
//获得根据按发布时间排序的当前前五条数据（收文）list
List<WorkFlowShowListBean> workFlowShow = new ArrayList<WorkFlowShowListBean>();

workFlowShow = annoucementdao.getWorkFlowShow(userid);
if (workFlowShow.size() > 0) {//获得数据的大小，判断所要加的空列
	a = 5- workFlowShow.size();
} else {
	a = 0;
}
//获得根据按发布时间排序的当前前五条数据（发文）list
List<WorkFlowShowListBean> workFlowShowfw = new ArrayList<WorkFlowShowListBean>();

workFlowShowfw = annoucementdao.getWorkFlowShow_fw(userid);
if (workFlowShowfw.size() > 0) {//获得数据的大小，判断所要加的空列
	b = 5- workFlowShowfw.size();
} else {
	b = 0;
}

//公文待办的list
List<RecevieAndSend> recevieAndSend = new ArrayList<RecevieAndSend>();
recevieAndSend =annoucementdao.getfindRASbean(userid);
if (recevieAndSend.size() > 0) {//获得数据的大小，判断所要加的空列
	d = 5- recevieAndSend.size();
} else {
	d = 0;
}
//获得根据按发布时间排序的当前前五条数据（信息报送）list
List<InfoReportBaseInfoBean> baseInfoList= new ArrayList<InfoReportBaseInfoBean>();
baseInfoList = annoucementdao.getfindBaseInfoBean(userid);
if (baseInfoList.size() > 0) {//获得数据的大小，判断所要加的空列
	s = 5- baseInfoList.size();
} else {
	s = 0;
}
//获得根据按发布时间排序的当前前五条数据（待处理会议）list
List<ConferenceBean> conferenceinfos = new ArrayList<ConferenceBean>();
ConferenceNoticeDao conferencedao = (ConferenceNoticeDao) DaoImplClassUtil
		.getDaoImplClass("conferenceNoticeDaoOracleImpl");
String sex = annoucementdao.getUserMessage(userid);
conferenceinfos = conferencedao.getConferenceInfo(userid,orgid,"0");//获得待处理会议信息list
if (conferenceinfos.size() > 0) {//获得数据的大小，判断所要加的空列
	m = 5- conferenceinfos.size();
} else {
	m = 0;
}

Date data = new Date();
//获得根据按发布时间排序的当前前五条数据（一般简报）list
List<BriefsEditorBean> briefsinfos = new ArrayList<BriefsEditorBean>();
BriefsBrowseDao briefsBrowsedao = (BriefsBrowseDao) DaoImplClassUtil
		.getDaoImplClass("briefsBrowseDaoImpl");
briefsinfos = briefsBrowsedao.getBriefsBrowseInfo(userid,orgid);//获得一般简报信息list
if (briefsinfos.size() > 0) {//获得数据的大小，判断所要加的空列
	c = 5- briefsinfos.size();
} else {
	c = 0;
}

//判断用户类型(政务信息)
AuthRole authRoles[] = accesscontroler.getAllRoleofUser(accesscontroler.getUserAccount());
String rolesNames = "";
StringBuffer buf = new StringBuffer();
for(int i=0;i<authRoles.length;i++){
	buf.append(authRoles[i].toString()+ ",");
}    
rolesNames = buf.toString();
if(rolesNames.length()>0){
rolesNames = rolesNames.substring(0,rolesNames.length()-1);
}
String type = "public";
String canViewType = "'"+PoeInfoType.NOT_BE_SENDAUDIT+"','"+PoeInfoType.HAS_BE_SENDAUDIT+"'";
String userType="录入者";
if(rolesNames.indexOf("舆情处理科长")!=-1){
	type = "kezhang";
	
}else if(rolesNames.indexOf("舆情处理领导")!=-1){
	type = "leader";

}
//获得根据按发布时间排序的当前前五条数据（政务信息）list
List<PoeBaseInfoBean> poeBaseinfos = new ArrayList<PoeBaseInfoBean>();
PoeManagerDao poeManagerdao = (PoeManagerDao) DaoImplClassUtil
		.getDaoImplClass("poeManagerDaoImpl");
String unit = poeManagerdao.findDanwei(orgid);
poeBaseinfos = poeManagerdao.getPoeManagerInfo(userid,orgid,type);//获得政务信息信息list
if (poeBaseinfos.size() > 0) {//获得数据的大小，判断所要加的空列
	z = 5- poeBaseinfos.size();
} else {
	z = 0;
}


/*获取待办列表统计数据start*/
HomeBusinessDao hbDao = (HomeBusinessDao) DaoImplClassUtil
					.getDaoImplClass("homeBusinessDaoImpl");
	int waiting4approvalTotal = 0;//待办处理统计
	int waiting4readTotal = 0;//待办阅读统计
	int waitingTotal= 0;//待办总计
	int mettingTotal =0;//会议通知
	int individualwork=0;//公文待办
	ToDoWorkListBean tdwlBean=new ToDoWorkListBean();
	ToDoWorkSearchBean toDoWorkSearchBean = new ToDoWorkSearchBean();
	toDoWorkSearchBean.setInputuser_id(userid);
	toDoWorkSearchBean.setListtype("waitingapproval");
	
	waiting4approvalTotal = hbDao.getToDoWorkListTotal(toDoWorkSearchBean,tdwlBean);
	toDoWorkSearchBean.setListtype("waitingread");

	waiting4readTotal = hbDao.getToDoWorkListTotal(toDoWorkSearchBean,tdwlBean);
	
	
	
	
	tdwlBean.setInfo_type("会议通知");
	toDoWorkSearchBean.setListtype("waitingapproval");
	mettingTotal = hbDao.getToDoWorkListTotal(toDoWorkSearchBean,tdwlBean);
	
	
	tdwlBean.setInfo_type("公文待办");
	toDoWorkSearchBean.setListtype("waitingapproval");
	individualwork =hbDao.getToDoWorkListTotal(toDoWorkSearchBean,tdwlBean);
	waitingTotal = waiting4approvalTotal + waiting4readTotal+mettingTotal+individualwork;
	
/*获取待办列表统计数据end*/
//登录信息
SessionListener sessionListener=new SessionListener();
String logins= String.valueOf(SessionListener.getSessions().size());
String topLogins=sessionListener.queryPeakNum();
String info[]=sessionListener.queryPersonInfo(username).split(",");
%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript"
	src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript"src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>


<script type="text/javascript">
var style = window.top.getSystemStyle();
var p = ["/ccapp/xtbg/resources/"+style+"/css/style.css",
            "/ccapp/xtbg/home/"+style+"/image/style.css"];
window.top.loadCss(p,window);
$(function(){
	timeWelcome();
	setInterval("timeWelcome()",300000);
	window.top.$("#workCount").html(<%=waiting4approvalTotal+waiting4readTotal+mettingTotal+individualwork %>);
})
//欢迎标语，上午，中午，下午好，晚上好
function timeWelcome(){
	var welcome="";
	var today=new Date();
	var hours= today.getHours();
	//alert(hours)
	if(hours>=5&&hours<8){
		welcome="早上好";
	}else if(hours>=8&&hours<12){
		welcome="上午好";
	}else if(hours>=12&&hours<13){
		welcome="中午好";
	}else if(hours>=13&&hours<19){
		welcome="下午好";
	}else if(hours>=19&&hours<=24){
		welcome="晚上好";
	}else if(hours<5){
		welcome="晚上好";
	}
	$("#welcomeTime").html(welcome);
}
var f = function(){
		location.reload();
}
//打开查看在线人数列表窗口
function loginsView(){
	//openAlertWindows('windowId','../../home/jsp/loginViewList.jsp','查看详情','60%','50%','20%','20%',f);
	openAlertWindows('windowId','../../home/jsp/loginViewMain.jsp','查看详情','335px','75%','10%','40%',f);
}

</script>
<style type="text/css">
/*more*/
.morea {
	float: right;
	margin-right: 5px;
	font: normal 12px/ 28px "宋体";
	color: #FFF4CA;
	cursor: pointer;
}
.list_list_bt{
    
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    -webkit-text-overflow:ellipsis;
    -moz-binding: url('../../resources/plug/jquery.jqGrid-4.3.1/css/ellipsis-xbl.xml#ellipsis');
}
.morea:hover {
	color: #FFF4CA;
	cursor: pointer;
}
</style>
<title>Insert title here</title>
</head>
<body>
<!----------------- 主要内容 ------------------>
<div class="content"><!------------  欢迎 --------------->
<div class="hy_box">
<div class="content_hy">
<ul>
	<li><span class="red_b" id="welcomeTime"></span><span
		class="red_b">，
		<%if(("430800").equals(StringUtil.deNull(userArea))) {%>
			<%}else{ %>
				<%=unit%> 
			<%} %>
		
		<%=username1 %> <% if(sex.equals("M")) {%>
	先生！ <%}else {%> 女士！ <%} %>
	</span></li>
	<li>您有 <span class="red_b" id="waitingTotal"><%=waitingTotal%></span> 条待办事务需要处理：</li>

	<li><span class="red_b" id="waiting4approvalTotal"><%=waiting4approvalTotal %></span>条<span
		class="blue_unl"><a href="javascript:void(0);"
		onclick="openWindows('sub_main_todowork','待办任务','../../home/jsp/todoworktabs.jsp?index=1&todoworktabstype=flag1','',false,window,true,true)">等待审批</a></span>
	&nbsp;<span class="red_b" id="waiting4readTotal"><%=waiting4readTotal %></span>条<span
		class="blue_unl"><a href="javascript:void(0);"
		onclick="openWindows('sub_main_todowork','待办任务','../../home/jsp/todoworktabs.jsp?index=2&todoworktabstype=flag1','',false,window,true,true)">等待阅读</a></span>
	&nbsp;<span class="red_b" id="mettingTotal"><%=mettingTotal%></span>条<span
		class="blue_unl"><a href="javascript:void(0);"
		onclick="openWindows('sub_main_todowork','待办任务','../../home/jsp/todoworktabs.jsp?index=3&todoworktabstype=flag1','',false,window,true,true)">会议通知</a></span>
	&nbsp;<span class="red_b" id="individualwork"><%=individualwork%></span>条<span
		class="blue_unl"><a href="javascript:void(0);"
		onclick="openWindows('sub_main_todowork','待办任务','../../home/jsp/todoworktabs.jsp?index=4&todoworktabstype=flag1&entrance=homepage','',false,window,true,true)">公文待办</a></span>
	<!-- &nbsp;<span class="red_b">4</span>条<span class="blue_unl"><a href="javascript:void(0);" onclick="openWindows('sub_main_todowork','待办事项','../../home/jsp/todoworktabs.jsp?index=4')">会议报名</a></span></li>
       		-->
</ul>
</div>
<!------------  天气 --------------->
<div class="content_tq">
<ul>

	<%if(("430800").equals(StringUtil.deNull(userArea))) {%>
	<li><iframe
		src="http://m.weather.com.cn/m/pn6/weather.htm?id=101251101T "
		width="140" height="20" marginwidth="0" marginheight="0" hspace="0"
		vspace="0" frameborder="0" scrolling="no"></iframe></li>
	<% }else if("421000".equals(userArea)){ %>
	
	<%} %>
	<li>此次是您第<span class="color_red"><%=info[1] %></span>
		<%if(("430800").equals(StringUtil.deNull(userArea))){ %>
		次登录张家界党政机关办公平台
		<% }else if("421000".equals(userArea)) {%>
		次登录湖南省水库移民开发管理局协同办公系统
		<%}else if("421001".equals(userArea)) { %>
		次登录衡阳市协同及移动办公政务云平台
		<%} %>
	</li>
	<li>您上次登录平台的时间是：<span class="color_red"><%=info[0] %></span></li>
	<li><a onclick="loginsView()">当前在线人数：<span class="color_red" id="logins"><%=logins%></span>
	最高在线人数：<span class="color_red" id="topLogins"><%=topLogins%></span></a></li>
</ul>
</div>
</div>
<!--  判断首页上四个框 显示的内容  如果为张家界则左上显示为收文处理 --> <%if(("430800").equals(StringUtil.deNull(userArea)) || ("421001").equals(StringUtil.deNull(userArea))) {%>
<!-----------  张家界显示的收文列表  -------------->
<div class="list_left_box" style="width: 45%">
<table border="0" cellpadding="0" cellspacing="0"
	class="list_left_table">
	<tr>
		<td>
		<div class="list_tit"><span class="list_tit_w">收文处理</span>
		<div class="list_tit_img"></div>
		<div class="more"><a
			onclick="openWindows('workflowMainTab','收文处理','../../workflow/jsp/mainwork.jsp?flag=homepage','_firstPagerAAAS',false,window,false,true)">更多>></a></div>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" align="right" cellpadding="0"
			cellspacing="2" class="list_list_table">
			<%for(WorkFlowShowListBean bean : workFlowShow){ //循环获得的通知公告list,显示通知公告相关信息%>
			<tr>
				<td>
				<div class="list_list">
				<div class="list_list_bt" style="width: 280px"><a
					onclick="openWindows('sub_main_announcement','工作列表','../../resources/plug/workflow/jsp/commonflowapprove.jsp?ins_id=<%=bean.getIns_id() %>&busi_id=<%=bean.getBusi_id() %>&actInsId=<%=bean.getActInsId() %>&cc_form_instanceid=<%=bean.getCc_form_instanceid() %>&def_id=<%=bean.getDef_id() %>&procId=<%=bean.getProcId() %>&action_defid=<%=bean.getAction_defid() %>&subid=sub_main_announcement','_firstPagerAAAS',false,window,false,true)"
					title="<%=bean.getIns_name()%>"><span ><%=bean.getIns_name() %></span></a></div>
				<div class="list_list_date"><%=bean.getAccept_time() %></div>

				<%	} %>
				</div>
				</td>
			</tr>
			<%if(workFlowShow.size() == 0){//判断当前展示的信息是否够5条，不够加空列补上
         for(int i = 0 ; i < 5 ; i++){ %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%}} %>
			<%
        if (a>0) {
      %>
			<%
       for (int x = 0; x<a; x++) {
      %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%
    	}
        }
        %>

		</table>
		</td>
	</tr>
</table>
</div>
<% }else{ %> <!-----------  列表1  -------------->
<div class="list_left_box" style="width: 45%">

<table border="0" cellpadding="0" cellspacing="0"
	class="list_left_table">
	<tr>
		<td>
		<div class="list_tit"><span class="list_tit_w">通知公告</span>
		<div class="list_tit_img"></div>
		<div class="more"><a class="morea" onclick="openWindows('ggjs','通知公告','../../announcement/jsp/announcementreceivelist.jsp','_firstPagerAAAS',false,window,false,true)">更多>></a></div>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" align="right" cellpadding="0"
			cellspacing="2" class="list_list_table">
			<%for(AnnouncementBean bean : announcementinfos){ //循环获得的通知公告list,显示通知公告相关信息%>
			<tr>
				<td >
				<div class="list_list" >
				<div class="list_list_bt" style="width: 280px">
						<a  onclick="openWindows('sub_main_announcement','通知公告','../../announcement/jsp/announcementreceive.jsp?dosel=sel&ggbh=<%=bean.getGgbh()%>&urls=jsy&subid=sub_main_announcement','_firstPagerAAAS',false,window,false,true)">
						<%if("未查看".equals(bean.getCkzt())){ %>
						<span  title="<%=bean.getGgbt()%>" class="homePage"><%=bean.getGgbt()%></span>
						<%}else{ %>
						<span  title="<%=bean.getGgbt()%>"><%=bean.getGgbt()%></span>
						<%} %>
						</a>
				</div>
					<%if("未查看".equals(bean.getCkzt())){ %>
						<div class="list_list_date homePage"><%=bean.getFbsj() %></div>
					<%}else{ %>
						<div class="list_list_date"><%=bean.getFbsj() %></div>
					<%} %>

				<%	} %>
				</div>
				</td>
			</tr>
			<%if(announcementinfos.size() == 0){//判断当前展示的信息是否够5条，不够加空列补上
         for(int i = 0 ; i < 5 ; i++){ %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%}} %>
			<%
        if (j>0) {
      %>
			<%
       for (int x = 0; x<j; x++) {
      %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%
    	}
        }
        %>

		</table>
		</td>
	</tr>

</table>
</div>
<%} %> <!--  判断首页上四个框 显示的内容  如果为张家界则左上显示为收文处理 --> <%if(("430800").equals(StringUtil.deNull(userArea)) || ("421001").equals(StringUtil.deNull(userArea))) {%>
<!-----------  张家界显示的收文列表  -------------->
<div class="list_left_box" style="width: 45%">
<table border="0" cellpadding="0" cellspacing="0"
	class="list_left_table">
	<tr>
		<td>
		<div class="list_tit"><span class="list_tit_w">发文处理</span>
		<div class="list_tit_img"></div>
		<div class="more"><a
			onclick="openWindows('workflowMainTab','发文处理','../../workflow/jsp/mainwork.jsp?flag=homepage1','_firstPagerAAAS',false,window,false,true)">更多>></a></div>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" align="right" cellpadding="0"
			cellspacing="2" class="list_list_table">
			<%for(WorkFlowShowListBean bean : workFlowShowfw){ //循环获得的通知公告list,显示通知公告相关信息%>
			<tr>
				<td>
				<div class="list_list">
				<div class="list_list_bt" style="width: 280px"><a
					onclick="openWindows('sub_main_announcement','工作列表','../../resources/plug/workflow/jsp/commonflowapprove.jsp?ins_id=<%=bean.getIns_id() %>&busi_id=<%=bean.getBusi_id() %>&actInsId=<%=bean.getActInsId() %>&cc_form_instanceid=<%=bean.getCc_form_instanceid() %>&def_id=<%=bean.getDef_id() %>&procId=<%=bean.getProcId() %>&action_defid=<%=bean.getAction_defid() %>&subid=sub_main_announcement','_firstPagerAAAS',false,window,false,true)"
					title="<%=bean.getIns_name()%>"><span class="list_list_bt"><%=bean.getIns_name() %></span></a></div>
				<div class="list_list_date"><%=bean.getAccept_time() %></div>

				<%	} %>
				</div>
				</td>
			</tr>
			<%if(workFlowShowfw.size() == 0){//判断当前展示的信息是否够5条，不够加空列补上
         for(int i = 0 ; i < 5 ; i++){ %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%}} %>
			<%
        if (b>0) {
      %>
			<%
       for (int x = 0; x<b; x++) {
      %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%
    	}
        }
        %>

		</table>
		</td>
	</tr>

</table>
</div>

<% }else{ %> <!-----------  列表2  -------------->
<div class="list_left_box" style="width: 45%">

<table border="0" cellpadding="0" cellspacing="0"
	class="list_right_table">
	<tr>
		<td>
		<div class="list_tit"><span class="list_tit_w">会议通知</span>
		<div class="list_tit_img"></div>
		<div class="more"><a class="morea"
			onclick="openWindows('my_receive_notice','待处理会议','../../conference/jsp/myreceivenotice_tab1.jsp','_firstPagerAAAS',false,window,false,true)">更多>></a></div>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="2" cellpadding="0"
			class="list_list_table">
			<% String state ="0"; //未回复
			   for(ConferenceBean bean : conferenceinfos){ //循环获得的待处理会议list,显示待处理会议相关信息
				  if("已过期".equals(bean.getNotice_state())){
						state ="1";
					}else if("已回复".equals(bean.getNotice_state())){
						state ="2";
					}else{
						state ="0";
					}
					%>
			<tr>
				<td>
				<div class="list_list">
				<div class="list_list_bt" style="width: 280px">
				<a title="<%=bean.getCon_title()%>"
					onclick="openWindows('sub_main_conference','待处理会议','../../conference/jsp/showconferencedetail2.jsp?showState=<%=state%>&conSn=<%=bean.getSn()%>&operType=3&tableType=Sendtab1&widowsid=sub_main_conference','_firstPagerAAAS',false,window,true,true)">
					  <%if("未回复".equals(bean.getNotice_state())){ %>
					  <span title="<%=bean.getCon_title()%>" class="homePage"><%=bean.getCon_title()%></span>
					<%}else{ %>
					<span title="<%=bean.getCon_title()%>" ><%=bean.getCon_title()%></span>
                    <%} %>
        		</a>
        		</div>
        		 <%if("未回复".equals(bean.getNotice_state())){ %>
				<div  class="list_list_date homePage"><%=bean.getBegin_date() %></div>
				<%}else{ %>
				<div  class="list_list_date"><%=bean.getBegin_date() %></div>
				 <%} %>
				<%	} %>
				</div>
				</td>
			</tr>
			<%if(conferenceinfos.size() == 0){//判断当前展示的信息是否够5条，不够加空列补上
         for(int i = 0 ; i < 5 ; i++){ %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%}} %>
			<%
        if (m>0) {
      %>
			<%
       for (int x = 0; x<m; x++) {
      %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%
    	}
        }
        %>

		</table>
		</td>
	</tr>
</table>
</div>
<%} %> <%if(("430800").equals(StringUtil.deNull(userArea)) || ("421001").equals(StringUtil.deNull(userArea))) {%>
<div class="list_left_box" style="width: 45%">

<table border="0" cellpadding="0" cellspacing="0"
	class="list_left_table">
	<tr>
		<td>
		<div class="list_tit"><span class="list_tit_w">会议通知</span>
		<div class="list_tit_img"></div>
		<div class="more"><a class="morea"
			onclick="openWindows('my_receive_notice','待处理会议','../../conference/jsp/myreceivenotice_tab1.jsp','_firstPagerAAAS',false,window,false,true)">更多>></a></div>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="2" cellpadding="0"
			class="list_list_table">
			<%
			String state ="0"; //未回复
				  for(ConferenceBean bean : conferenceinfos){ //循环获得的待处理会议list,显示待处理会议相关信息
					  if("已过期".equals(bean.getNotice_state())){
							state ="1";
						}else if("已回复".equals(bean.getNotice_state())){
							state ="2";
						}else{
							state ="0";
						}
  			%>
			<tr>
				<td>
				<div class="list_list">
				<div class="list_list_bt" style="width: 280px"><a
					title="<%=bean.getCon_title()%>"
					onclick="openWindows('sub_main_conference','待处理会议','../../conference/jsp/showconferencedetail2.jsp?showState=<%=state%>&conSn=<%=bean.getSn()%>&operType=3&tableType=Sendtab1&widowsid=sub_main_conference','_firstPagerAAAS',false,window,true,true)">
					 <%if("未回复".equals(bean.getNotice_state())){ %>
					 <span title="<%=bean.getCon_title()%>" style="color:red"><%=bean.getCon_title()%></span>
					<%}else{ %>
					<span title="<%=bean.getCon_title()%>"><%=bean.getCon_title()%></span>
                    <%} %>
                    </a></div>
				<div class="list_list_date"><%=bean.getBegin_date() %></div>

				<%	} %>
				</div>
				</td>
			</tr>
			<%if(conferenceinfos.size() == 0){//判断当前展示的信息是否够5条，不够加空列补上
         for(int i = 0 ; i < 5 ; i++){ %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%}} %>
			<%
        if (m>0) {
      %>
			<%
       for (int x = 0; x<m; x++) {
      %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%
    	}
        }
        %>

		</table>
		</td>
	</tr>


</table>
</div>
<% }else{ %> <!-----------  列表3  -------------->
<div class="list_left_box" style="width: 45%">

<table border="0" cellpadding="0" cellspacing="0"
	class="list_left_table">
	<tr>
		<td>
		<div class="list_tit"><span class="list_tit_w">政务信息</span>
		<div class="list_tit_img"></div>
		<div class="more">
		<a class="morea" onclick="openWindows('poecaibian','政务信息','../../pubopinionedit/jsp/poeshowlist.jsp','',false,window,true,true)">更多>></a></div>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" align="right" cellpadding="0"
			cellspacing="2" class="list_list_table">

			<%for(PoeBaseInfoBean bean : poeBaseinfos){ //寰幆鑾峰緱鐨勬斂鍔′俊鎭痩ist,鏄剧ず鏀垮姟淇℃伅鐩稿叧淇℃伅%>
				<tr>
					<td>
					<div class="list_list">
					<div class="list_list_bt" style="width: 280px">
						<a title="<%=bean.getPeriodical_title()%>"
							onclick="openWindows('sub_main_pubopinionedit','政务信息','../../pubopinionedit/jsp/poeleaderpishi.jsp?edit_id=<%=bean.getEdit_id()%>&state=<%=bean.getSubmittedinfo_typecode()%>&operwindowid=sub_main_pubopinionedit','_firstPagerAAAS',false,window,true,true)">
							<%if(("5").equals(bean.getSubmittedinfo_typecode())){ %>
							<span title="<%=bean.getPeriodical_title()%>" class="homePage"><%=bean.getPeriodical_title()%></span>
							<%}else{ %>
							<span title="<%=bean.getPeriodical_title()%>"><%=bean.getPeriodical_title()%></span>
		                    <%} %>
						</a>
					</div>
						<%if(("5").equals(bean.getSubmittedinfo_typecode())){ %>
							<div  class="list_list_date homePage" ><%=bean.getSetup_time() %></div>
						<%}else{ %>
							<div class="list_list_date"><%=bean.getSetup_time() %></div>
						<%} %>
			<%	} %>
					</div>
					</td>
				</tr>
		<%if(poeBaseinfos.size() == 0){//鍒ゆ柇褰撳墠灞曠ず鐨勪俊鎭槸鍚﹀5鏉★紝涓嶅鍔犵┖鍒楄ˉ涓�
         for(int i = 0 ; i < 5 ; i++){ %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%}} %>
			<%
        if (z>0) {
      %>
			<%
       for (int x = 0; x<z; x++) {
      %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%
    	}
        }
        %>
		</table>
		</td>
	</tr>
</table>

</div>





<%	} %> 
<%if(("430800").equals(StringUtil.deNull(userArea)) || ("421001").equals(StringUtil.deNull(userArea))) {%> <!-----------  列表4  -------------->
<div class="list_left_box" style="width: 45%">
<table border="0" cellpadding="0" cellspacing="0"
	class="list_left_table">
	<tr>
		<td>
		<div class="list_tit"><span class="list_tit_w">信息报送</span>
		<div class="list_tit_img"></div>
		<div class="more"><a class="morea"
			onclick="openWindows('infobrowsinglist','信息浏览','../../inforeported/jsp/infobrowsinglist.jsp','',false,window,true,true)">更多>></a></div>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="2" cellpadding="0"
			class="list_list_table">
			<%for(InfoReportBaseInfoBean bean : baseInfoList){ //循环获得的一般简报list,显示一般简报相关信息%>
			<tr>
				<td>
				<div class="list_list">
				<div class="list_list_bt" style="width: 280px">
				<a  title="<%=bean.getSubmittedinfo_title()%>"
					onclick="openWindows('sub_inforeportdetailview','信息预览','../../inforeported/jsp/inforeportdetailview.jsp?submittedinfoId=<%=bean.getSubmittedinfo_id()%>&state=<%=bean.getSubmittedinfo_typecode()%>&operwindowid=sub_inforeportdetailview','_firstPagerAAAS',false,window,true,true)"><span
					title="<%=bean.getSubmittedinfo_title() %>"><%=bean.getSubmittedinfo_title()%></span></a></div>

				<div class="list_list_date"><%=bean.getInput_date() %></div>
				<%	} %>
				</div>
				</td>
			</tr>
			<%if(baseInfoList.size() == 0){//判断当前展示的信息是否够5条，不够加空列补上
         	for(int i = 0 ; i < 5 ; i++){ %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%}} %>
			<%
        if (s > 0) {
      %>
			<%
       for (int x = 0; x<s; x++) {
      %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%
    	}
        }
        %>
		</table>
		</td>
	</tr>
</table>
</div>
<% }else{ %> <!-----------  列表4  -------------->
<div class="list_left_box" style="width: 45%">

<table border="0" cellpadding="0" cellspacing="0"
	class="list_right_table">
	<tr>
		<td>
		<div class="list_tit"><span class="list_tit_w">单位简报</span>
		<div class="list_tit_img"></div>
		<div class="more"><a class="morea"
			onclick="openWindows('jbll','单位简报','../../briefs/jsp/briefsbrowselist.jsp','',false,window,true,true)">更多>></a></div>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="2" cellpadding="0"
			class="list_list_table">
			<%for(BriefsEditorBean bean : briefsinfos){ //循环获得的一般简报list,显示一般简报相关信息%>
			<tr>
				<td>
				<div class="list_list">
					<div class="list_list_bt" style="width: 280px">
							<a title="<%=bean.getPresentation_title()%>"
							onclick="openWindows('sub_main_briefs','单位简报','../../briefs/jsp/briefsbrowsedrew.jsp?briefs_id=<%=bean.getBriefs_id()%>&userid=<%=userid%>&state=<%=bean.getSubmittedinfo_typecode()%>&subid=sub_main_briefs','_firstPagerAAAS',false,window,true,true)">
							<%if("3".equals(bean.getSubmittedinfo_typecode())||"4".equals(bean.getSubmittedinfo_typecode())){ %>
								<span title="<%=bean.getPresentation_title()%>" class="homePage"><%=bean.getPresentation_title()%></span>
		                    <%}else{ %>
		                    	 <span title="<%=bean.getPresentation_title()%>" ><%=bean.getPresentation_title()%></span>
		                    <%} %>
		                     </a>
	                </div>
	                <%if("3".equals(bean.getSubmittedinfo_typecode())||"4".equals(bean.getSubmittedinfo_typecode())){ %>
						<div class="list_list_date homePage"><%=bean.getCreate_time() %></div>
					<%}else{ %>
					  <div class="list_list_date"><%=bean.getCreate_time() %></div>
					 <%} %>
			<%	} %>
				</div>
				</td>
			</tr>
	<%if(briefsinfos.size() == 0){//判断当前展示的信息是否够5条，不够加空列补上
         for(int i = 0 ; i < 5 ; i++){ %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%}} %>
			<%
        if (c>0) {
      %>
			<%
       for (int x = 0; x<c; x++) {
      %>
			<tr class="list_list">
				<td>&nbsp;</td>
			</tr>
			<%
    	}
        }
        %>
		</table>
		</td>
	</tr>
</table>
</div>
<%	} %> <!----------------- 主要内容 结束 ------------------>
	 
<!----------------- 主要内容 结束 ------------------>
</div>

</body>
</html>
