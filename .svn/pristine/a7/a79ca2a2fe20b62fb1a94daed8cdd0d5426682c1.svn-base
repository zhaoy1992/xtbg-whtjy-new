<%--
　　描述：会议通知申请tab明细页面
	本页面为公共的、tab-iframe组合的总页面，会被新增申请、修改申请、审核申请、查看申请、总查询等不同列表或详情页面调用。
	根据来源不同，传递的issaved参数值也会有异同，同时根据页面传递过来的会议状态‘m_check_flag’属性值，以此两点确定按钮权限，如下：
	        来源                                                                                按钮                                                                   说明    
--------------------------------------------------------------------------------------------------------------------------
	新增申请(add)                 [返回]、[暂存]、[送审]、[发布]、[存为模板]    当所选会议室有管理员权限()的可以直接[发布]         
	修改申请(doall)               都可能显示。       
	审核申请(docheck)             [返回]、[通过]、[不通过]    
	审核申请(dochecked)           [返回] 
	查看申请(doview)              [返回]、[报名回复]
	总查询 (doquery)              [返回]
	
	本页面 先加载完成 会议基本信息页面调用 tab-frame1 后，再加载tab-frame2、tab-frame3、再判断显示按钮组
	
　　作者：黄海
　　版本：1.0
　　日期：2013-6-19
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.impl.SysParamServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="java.util.*"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
    String frompagehome = StringUtil.deNull(request.getParameter("frompagehome"));//来自首页要控制返回的页面
	String m_notice_id = StringUtil.deNull(request.getParameter("m_notice_id"));//主键
	String issaved=StringUtil.deNull(request.getParameter("issaved"));//来源
	String m_check_flag=StringUtil.deNull(request.getParameter("m_check_flag"));//当前操作会议的状态
	String m_check_flag_name=StringUtil.deNull(request.getParameter("m_check_flag_name"));//当前操作会议的状态name
	String administrator_ids=StringUtil.deNull(request.getParameter("administrator_ids"));//会议室管理员ids
	String m_reg_user_id=StringUtil.deNull(request.getParameter("m_reg_user_id"));
	String m_reg_user_name=StringUtil.deNull(request.getParameter("m_reg_user_name"));
	String currUserId = accesscontroler.getUserID();
	Map<String, String> viewMap = new HashMap<String, String>();
	Map<String, String> viewMap4signup = new HashMap<String, String>();
	SysParamServiceIfc SysParamServiceIfc=new SysParamServiceImpl();
	viewMap=SysParamServiceIfc.getSysParamByPcode("topicconfig");//得到 会议议题全局配置
	boolean hidetopicdiv = false;
	if (viewMap.size()>0 && "0".equalsIgnoreCase(StringUtil.deNull(viewMap.get("p_content")))){
		hidetopicdiv = true;
	}
	
	viewMap4signup=SysParamServiceIfc.getSysParamByPcode("isneedsignup");//得到 是否需要报名
	boolean isneedsignup = false;
	if (viewMap4signup.size()>0 && "1".equalsIgnoreCase(StringUtil.deNull(viewMap4signup.get("p_content")))){
		isneedsignup = true;
	}
	
	String m_close_time = StringUtil.deNull(request.getParameter("m_close_time"));
    String m_is_need_signup = StringUtil.deNull(request.getParameter("m_is_need_signup"));
    String timesupflag = StringUtil.deNull(request.getParameter("timesupflag"));
    
    String currentTime = DateUtil.getFormatTime(new Date());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/js/meetingnoticedetail.js"></script>
<!-- 公共部分引用结束 -->		
<script type="text/javascript">
var firstopen=1;//
var frompagehome = "<%=frompagehome%>";
jQuery(function() {
	//setButtonDisplay();
	jQuery("#tabs").tabs({
		select : function(event, ui) {
		}
	});
	$("#titleids").css('display','block');
    adaptationWH('_top','frame1',40);
	adaptationWH('_top','frame2',40);
	adaptationWH('_top','frame3',40);
});
/*
	函数:  initFrame
	说明:  加载其他 tab-frame2、 tab-frame3，由会议基本信息页面调用 tab-frame1
*/
var isFirst="yes";//全局变量的目的是只让tab-frame2、 tab-frame3加载一次，避免出现刷新 tab-frame1后再次刷新的情况
function initFrame(){
	if (isFirst=="yes"){
		$("#frame2").attr("src", "meetingnoticecontent.jsp");
		$("#frame3").attr("src", "meetingtopic.jsp?m_notice_id=<%=m_notice_id%>");
	}
	isFirst = "no";
}

/*
	函数:  setButtonDisplay
	说明:  根据业务显示/隐藏按钮
*/
var mainurl = "meetingnoticemain.jsp";
function setButtonDisplay(){
	var issaved = '<%=issaved %>';
	var m_check_flag = '<%=m_check_flag %>';
	var m_notice_id ='<%=m_notice_id%>';
	if(issaved=="add" || isSpace(m_notice_id)){//新增
		mainurl = "meetingnoticemain.jsp";
		jQuery("#PENDING").show();      //送审
		jQuery("#PUBLISHED").show();      //发布 
		jQuery("#DRAFT").show();     //暂存
		jQuery("#savetmp").show();     //存为模板
		hideshowButton();
	}else if(issaved=="doall"){	//申请修改
		mainurl = "meetingnoticemain.jsp";
		jQuery("#PUBLISHED").hide();      //发布 
		jQuery("#savetmp").show();     //存为模板
		hideshowButton();
		if(m_check_flag=='<%=MeetingConstants.STATUS_PUBLISHED%>' || m_check_flag=='<%=MeetingConstants.STATUS_REPUBLISHED%>' ){//已发布，才可以查看以下信息
			

			//new add 2013-08-29 报名情况按钮的控制，不要报名时不用显示
			if ('<%=m_is_need_signup%>'!='1'){
				jQuery("#attender").hide();
			}else{
				jQuery("#attender").show();    //报名人数
			}
			jQuery("#read").show();        //阅读人数
			jQuery("#addsend").show();     //补发
			jQuery("#resend").show();      //会议重发
			jQuery("#REPUBLISHED").hide();
			jQuery("#cancel").show();      //撤销
			jQuery("#PUBLISHED").hide();      //已发布或重发后，发布按钮hide 
			jQuery("#PENDING").hide();
		}
		if(m_check_flag=='<%=MeetingConstants.STATUS_CHECKPASS%>'){//审核通过后
			jQuery("#PUBLISHED").show();      //发布
		}
		if(m_check_flag=='<%=MeetingConstants.STATUS_PENDING%>'){//待审时可追回
			jQuery("#UNDONE").show();      //追回
			jQuery("#PUBLISHED").hide();      //发布 == 隐藏
			jQuery("#PENDING").hide();        //送审也不能再点
		}
		if( m_check_flag=='<%=MeetingConstants.STATUS_UNDONE%>' || m_check_flag=='<%=MeetingConstants.STATUS_DRAFT%>' || m_check_flag=='<%=MeetingConstants.STATUS_UNCHECKPASS%>'){//审核不通过，送审按钮放开
			//jQuery("#PENDING").show();      //送审
			jQuery("#DRAFT").show();
		}
		
	}else if(issaved=="docheck"){//来自审核 只显示通过和不通过
		jQuery("#checkpass").show();      
		jQuery("#uncheckpass").show();
		mainurl="meetingcheckmain.jsp";
	}else if(issaved=="dochecked"){//来自 已审通知
		mainurl="meetingcheckmain.jsp";
		if(m_check_flag=='<%=MeetingConstants.STATUS_PUBLISHED%>' 
				|| m_check_flag=='<%=MeetingConstants.STATUS_CHECKPASS%>'
				|| m_check_flag=='<%=MeetingConstants.STATUS_REPUBLISHED%>' ){//已发布，才可以查看以下信息 //审核通过后 可以发布
			jQuery("#PUBLISHED").show();  
			jQuery("#PUBLISHED").prop("value", "调整");	
		}
	}else if(issaved=="doquery"){//来自总查询
		mainurl="meetingnoticelist4generalview.jsp";
	}else if(issaved=="doview"){//来自查看，只显示回复报名
		mainurl="meetingviewmain.jsp";
		if(frompagehome=="1"){
			mainurl="../../notice/jsp/noticeviewlist.jsp?welfrom=1";		

		}
		if(m_check_flag=='<%=MeetingConstants.STATUS_REPUBLISHED%>' || m_check_flag=='<%=MeetingConstants.STATUS_PUBLISHED%>'){//已发布，才可回复
			jQuery("#reply").show();	
		}
	}
	jQuery("#rt").show();
}

/*
	函数:  changeTabName
	说明:  根据业务修改议题的数量，调用来自于会议基本信息页面 tab-frame1
*/
function changeTabName(str){
	jQuery("#topictitle").text("（"+str+"）");
}
/*
	函数:  hideshowButton
	说明:  根据业务显示/隐藏按钮，调用来自于会议基本信息页面 tab-frame1
*/
function hideshowButton(){
	var issaved = '<%=issaved%>';
	var cur_m_check_flag = '<%=m_check_flag%>';
	var administrator_ids = ","+frame1.window.getAdministrator_ids()+",";
	var currUserId  = ',<%=currUserId%>,';//当前用户
	var m_room_id       = frame1.window.getM_room_id();//当前所选会议室
	var M_is_need_check = frame1.window.getM_is_need_check();//当前所选会议室是否要审核   为零不要审核
	
	if (issaved=="add" || cur_m_check_flag!='<%=MeetingConstants.STATUS_CHECKPASS%>'){
		if(issaved=="docheck"){
			if( ! ( M_is_need_check==0 || administrator_ids.indexOf(currUserId)>-1 || isSpace(m_room_id))  ){
				jQuery("#checkpass").hide();
				jQuery("#uncheckpass").hide();
			}else{
				jQuery("#checkpass").show();
				jQuery("#uncheckpass").show();
			}
		}else if(issaved=="dochecked"){
			if( ! ( M_is_need_check==0 || administrator_ids.indexOf(currUserId)>-1 || isSpace(m_room_id))  ){
				jQuery("#PUBLISHED").hide();
			}else{
				jQuery("#PUBLISHED").show();
			}
		}else{
			if(cur_m_check_flag=='<%=MeetingConstants.STATUS_PUBLISHED%>' || cur_m_check_flag=='<%=MeetingConstants.STATUS_REPUBLISHED%>'){
				if( ! ( M_is_need_check==0 || administrator_ids.indexOf(currUserId)>-1 || isSpace(m_room_id))  ){
					jQuery("#REPUBLISHED").hide();  
					jQuery("#resend").show();
				}else{
					if(firstopen>1){//第一次加载时不显示
						jQuery("#REPUBLISHED").show();
						jQuery("#resend").hide();
					}
				}
			}else{
				if( ! ( M_is_need_check==0 || administrator_ids.indexOf(currUserId)>-1 || isSpace(m_room_id))  ){
					jQuery("#PUBLISHED").hide();      //所选会议室不能直接发布 
					jQuery("#PENDING").show();
				}else{
					jQuery("#PUBLISHED").show();
					jQuery("#PENDING").hide();
				}
			}
		}
	}
}
/*
函数:  docheck4unpass
说明:  审核操作---不通过
*/
function docheck4unpass(m_check_flag){
	var meetingnoticejson = "{'m_notice_id':'"+jQuery("#m_notice_id").val()+"'"+
							",'m_check_user_id':'<%=accesscontroler.getUserID()%>'"+
							",'m_check_user_name':'<%=accesscontroler.getUserName()%>'}";  	
	var data = {
			dotype:"unpass",
			m_check_flag : m_check_flag,
			meetingnoticejson : meetingnoticejson
	}	
	var okF = function() {
		url = "meetingcheckdo.jsp";
		$.ajax({
			url : url,
			type : 'POST',
			dataType : 'json',
			data : data,
			async : true,
			success : function(flag) {
				if (flag) {
					alert("操作成功！");
					tomainjsp();
				} else {
					alert("操作失败！");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("error:" + textStatus);
				tomainjsp();
			}
		});
	};
	var p = {
		headerText : '提示',
		okName : '确认',
		okFunction : okF,
		cancelName : '取消'
	};
	alert("确定要审核吗？", p);		
}


/*
	函数:  docheck
	说明:  审核操作
*/
function docheck(){
	m_check_flag = "<%=MeetingConstants.STATUS_PUBLISHED%>";	
	var meetingnoticejson = "{'m_notice_id':'"+jQuery("#m_notice_id").val()+"'"+
							",'m_begin_time':'"+frame1.window.jQuery("#m_begin_time").val()+"'"+
							",'m_end_time':'"+frame1.window.jQuery("#m_end_time").val()+"'"+
							",'m_room_id':'"+frame1.window.jQuery("#m_room_id").val()+"'"+
							",'m_room_name':'"+frame1.window.jQuery("#m_room_id option[value='']~option:selected").text()+"'"+
							",'m_check_user_id':'<%=accesscontroler.getUserID()%>'"+
							",'m_check_user_name':'<%=accesscontroler.getUserName()%>'}";  	
	if (frame1.window.isCheckMsgsendType()){
		//审核不处理，可以不考虑
		var meetingmsglogjson = "{"+frame1.window.getMeetingmsglogJson('<%=MeetingConstants.MSG_PUBLISHED_SEND %>','发布')+"}";//消息
	 }else{
		var meetingmsglogjson = "";
	}						
							
	var data = {
			dotype:"pass",
			m_check_flag : m_check_flag,
			meetingnoticejson : meetingnoticejson,
			meetingmsglogjson : meetingmsglogjson
	}	
	var okF = function() {
		url = "meetingcheckdo.jsp";
		$.ajax({
			url : url,
			type : 'POST',
			dataType : 'json',
			data : data,
			async : true,
			success : function(flag) {
				if (flag) {
					alert("操作成功！");
					tomainjsp();
				} else {
					alert("操作失败！");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("error:" + textStatus);
				tomainjsp();
			}
		});
	};
	var p = {
		headerText : '提示',
		okName : '确认',
		okFunction : okF,
		cancelName : '取消'
	};
	alert("确定要审核吗？", p);		
}
/*
函数:  recoverMeeting
说明:  会议追回,通知状态改为暂存，送审情况表修改
*/
function recoverMeeting(m_notice_id){
	var m_check_flag = '<%=m_check_flag%>'
	if(m_check_flag=='<%=MeetingConstants.STATUS_PENDING%>'){//只是在送审情况下才可执行追回操作
		var okF = function() {
			url = "meetingrecoverdo.jsp";
			$.ajax({
				url : url,
				type : 'POST',
				dataType : 'json',
				data : {m_notice_id:m_notice_id},
				async : true,
				success : function(flag) {
					if (flag) {
						alert("操作成功！");
						tomainjsp();
					} else {
						alert("操作失败！");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("error:" + textStatus);
					tomainjsp();
				}
			});
		};
		var p = {
			headerText : '提示',
			okName : '确认',
			okFunction : okF,
			cancelName : '取消'
		};
		alert("确定要追回吗？", p);	
	}else{
		alert("注意：目前会议不允许追回！");
		return;
	}
		
}

/*
	函数:  toFrame
	说明:  强制定位到要校验的tab页面
	参数:  m_check_flag，m_msg_send_flag均 为按钮请求更新的状态
*/
function toFrame(i){
	var currIndex = jQuery("#tabs").tabs('option', 'selected'); 
	if (currIndex!=i){
		jQuery("#tabs").tabs( 'select' , i);	
	}
}

/*
	函数:  saveTab
	说明:  数据各类保存
	参数:  m_check_flag，m_msg_send_flag均 为按钮请求更新的状态
*/
function saveTab(m_check_flag,m_check_flag_name,m_msg_send_flag,m_msg_send_flag_name) {
	var cur_m_check_flag = '<%=m_check_flag%>';
	var currIndex = jQuery("#tabs").tabs('option', 'selected'); 
	if(!(frame1.window.checkData())){//校验不通过时return，页面显示必填项
		return;
	}else{
		//1）基本信息
	    var meetingnoticedetailjson = frame1.window.getJson(m_check_flag,m_check_flag_name);
	    if (frame1.window.isCheckMsgsendType()){
	    	 var jsonObj = frame1.window.getMeetingmsglogJsonNew(m_msg_send_flag,m_msg_send_flag_name);
	    	 var meetingmsglogjson = JSON.stringify(jsonObj);//消息
	    }else{
	    	 var meetingmsglogjson = "";
	    }
	    //2）正文
	    var meetingnoticecontentjson = frame2.window.getJson();
	    //组装  =  1）基本信息 +  2）正文
		var meetingnoticejson = "{"+meetingnoticedetailjson+"}"; //new add 2013-08-15
		//3）议题
		if(!(frame3.window.checkData())){//校验不通过时return，页面显示必填项
			return;
		}
		if (!isSpace(frame3.window.getJson())){
			var meetingtopicjsonlist = "["+frame3.window.getJson()+"]"; 
		}else{
			var meetingtopicjsonlist = ""; 
		}
		
		//重新发布，参数【是否需要重新报名】单独记录
		var m_is_need_resignup = "";
		if(m_check_flag=='<%=MeetingConstants.STATUS_REPUBLISHED%>'){
			m_is_need_resignup = frame1.window.jQuery("input[id='m_is_need_resignup']:checked").val();
		}
		
		var okF = function() {
			var params = {
				m_is_need_resignup : m_is_need_resignup,//new add 2013-08-25
				meetingnoticejson : meetingnoticejson,
				meetingtopicjsonlist  : descape(escape(meetingtopicjsonlist)),
				meetingmsglogjson  : meetingmsglogjson,
				m_check_flag : m_check_flag,
				meetingnoticebean:meetingnoticecontentjson,//new add 2013-08-15
				m_msg_send_flag : m_msg_send_flag
			};
			url = "meetingnoticedo.jsp";
			$.ajax({
				url : url,
				type : 'POST',
				dataType : 'json',
				data : params,
				async : true,
				success : function(flag) {
					if (flag) {
						alert("操作成功！");
						tomainjsp();
					} else {
						alert("操作失败！(可能原因：会议室被占用)");
					}
					
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("error:" + textStatus);
					//tomainjsp();
				}
			});
		};
		var p = {
			headerText : '提示',
			okName : '确认',
			okFunction : okF,
			cancelName : '取消'
		};
		if(m_check_flag_name=="已发布"){m_check_flag_name="发布"}
		toFrame(0);
		alert("确定"+m_check_flag_name+"吗？", p);
	}	
}
/**
 * 存为模板
 */
function saveTmp(){	
	//保存模板信息
	frame1.window.saveTmpAjax();
}

/***********全部跳转页面或弹出页面方法   begin *************************************************************
/*
	函数:  tomainjsp
	说明:  返回到主页面
*/
function tomainjsp() {
	window.location = mainurl;
}
/*
	函数:  returnmainjsp
	说明:  返回到主页面
*/
function returnmainjsp(){
    var okF = function(){
    	removeAlertWindows('',true);
    	setTimeout(function(){
    		tomainjsp();
		},10);
    }
    var p={
        headerText:'提示', 
        okName:'确认',
        okFunction:okF,
        cancelName:'取消'
    };
    alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
}
/*
	函数:  openReply
	说明:  报名回复操作
*/
function openReply(){
	var m_close_time = "<%=m_close_time%>"
	var m_is_need_signup = "<%=m_is_need_signup%>";
	var timesupflag = "<%=timesupflag%>";
	if(timesupflag=="yes"){//是否需要报名 为否/0时
		alert("注意：会议已过期！");
		return;
	}
	if(m_is_need_signup=="0"){//是否需要报名 为否/0时
		alert("注意：该会议无需报名！");
		return;
	}
	/*var currentTime = getLocalDate()+" "+getNowTime();  改为取服务器当前时间  */
	var currentTime = "<%=currentTime%>";
	if(!isSpace(m_close_time) && currentTime>m_close_time){
		alert("报名不成功！会议报名截止时间已过！");
		return;
	}	
	var url = getCurrentFilePath()+"meetingnoticereply.jsp?m_notice_id=<%=m_notice_id%>";
	openAlertWindows('windowId',url,'报名回复操作','1020','450','5%');
}
/*
	函数:  openAddsend
	说明:  打开补发页面
*/
function openAddsend(){
	frame1.window.disabledAll();
	var url = getCurrentFilePath()+"meetingnoticeaddsend.jsp?m_notice_id=<%=m_notice_id%>";
	openAlertWindows('windowId',url,'会议通知补发','810','560','5%');
}
/*
函数:  editmeeing
说明:  解除控制让人员编辑后重新发布
*/
function editmeeing(e){
	firstopen=2;//按钮可以根据判断显示
	//隐藏自己,显示重发按钮；
	jQuery("#resend").hide();
	jQuery("#REPUBLISHED").show();
	//jQuery("#addsend").hide();
	
	//打开时间和会议室的disabeld控制
	frame1.window.jQuery("#m_room_id").prop("disabled", false);
	frame1.window.jQuery("#m_begin_time").prop("disabled", false);
	frame1.window.jQuery("#m_end_time").prop("disabled", false);
	frame1.window.undisabledAll();//js中
	frame2.window.doIsFileEnble();
	frame3.window.undisabledAll();//js中
	frame3.window.showMeetingTopicButton()//显示会议议题的+ - 按钮
	frame1.window.jQuery("#title_m_is_need_resignup-th").show();
	frame1.window.jQuery("#title_m_is_need_resignup-td").show();
	
	//打开会议正文、会议议题编辑权限
	
	
	alert("会议目前允许重新发布");
}
/*
	函数:  openAddsend
	说明:  打开重发页面
*/
function openResend(){
	var url = getCurrentFilePath()+"meetingnoticeresend.jsp";
	openAlertWindows('windowId',url,'会议通知重发','810','300','5%');
}
/*
	函数:  openCancel
	说明:  打开撤销页面
*/
function openCancel(){
	var url = getCurrentFilePath()+"meetingnoticecancel.jsp?m_notice_id=<%=m_notice_id%>";
	openAlertWindows('windowId',url,'会议通知撤销','810','300','20%');
}
/*
	函数:  openAttender
	说明:  打开会议报名情况页面
*/
function openAttender(){
	var m_notice_id = jQuery("#m_notice_id").val();
	var url = getCurrentFilePath()+"meetingreceivermain.jsp?m_notice_id="+m_notice_id;
	openAlertWindows('windowId',url,'会议报名情况','950','600','5%','5%');
}
/*
	函数:  openRead
	说明:  打开会议通知阅读情况页面
*/
function openRead(){
	var m_notice_id = jQuery("#m_notice_id").val();
	var url = getCurrentFilePath()+"meetingreadmain.jsp?m_notice_id="+m_notice_id;
	openAlertWindows('windowId',url,'会议通知阅读情况','950','600','5%','5%');
}
/***********全部跳转页面或弹出页面方法   end *************************************************************


/*
	函数:  getContents
	说明:  得到会议基本信息的正文信息   ，调用来自于会议正文页面tab-frame2 
*/
function getContents(){
	return frame1.window.getContents();
}
/*
函数:  getM_djbh
说明:  得到会议基本信息的正文附件id ，调用来自于会议正文页面tab-frame2 
*/
function getM_djbh(){
	return frame1.window.getM_djbh();
}
/*
函数:  getIssaved
说明:  得到操作类型
*/
function getIssaved(){
	return delSpace(jQuery("#issaved").val());
}

/*
函数:  canOperate
说明:  得到操作类型
*/
function canOperate(){
	var m_check_flag = '<%=m_check_flag %>';
	//只有是add可以编辑 ，其余是doall,dochecked,docheck,doview,doquery等都 不能编辑
	//审核时只能改会议室和时间
	var operateFlag = false;
	var str = getIssaved();
	if (str=="add"){
		operateFlag = true;
	}else if(str=="docheck"){
		operateFlag = true;
	}else if(str=="doquery"){
		operateFlag = false;	
	}else if (str=="doall" && (m_check_flag=="3" || m_check_flag=="1" || m_check_flag=="6")){//来自申请页面时，只有是暂存、撤销、通过
		operateFlag = true;
	}
	return operateFlag;
}

</script>
<title>会议通知</title>
</head>
<body >
	<table style="WIDTH: 100%;">
		<tr>
			<td>
				<div>
					<div id="tabs">
						<div  class="content_02" style="overflow:hidden;" id="_top">
				        <!-- 操作 
				        	A.基本表、B.会议状态日志表、C.会议议题表、D.会议通知发送消息msg日志表、E.用户接收表，F.单位接收 表
				        	发布：                     更新A会议状态字段、新增B、新增E、新增F、给D的人发消息或短信
				        	送审：                     新增A、新增B、新增C、新增D
				        	追回：即撤销， 更新A、新增B、删除E、删除F
				        	暂存：                新增A、新增B、新增C、新增D（除了送审状态不同） 
				        	保存：                     更新A、新增B、更新C
				        	补发：                     更新A补发字段、新增D（补发）、新增E、新增F、
				        -->
				            <div class="content_02_top" style="margin-bottom:10px;" >
				                <input name="PUBLISHED"   id="PUBLISHED"   value="发布"  onclick="saveTab('<%=MeetingConstants.STATUS_PUBLISHED %>','已发布','<%=MeetingConstants.MSG_PUBLISHED_SEND %>','发布');"  type="button" class="but_y_01" style="display: none"/>
				                <input name="PENDING" id="PENDING"         value="送审"  onclick="saveTab('<%=MeetingConstants.STATUS_PENDING %>'  ,'送审' ,'<%=MeetingConstants.MSG_DRAFT_SEND %>','草稿');" type="button" class="but_y_01" style="display: none" />
				                <input name="DRAFT"   id="DRAFT"       value="暂存"    onclick="saveTab('<%=MeetingConstants.STATUS_DRAFT %>'  ,'暂存' ,'<%=MeetingConstants.MSG_DRAFT_SEND %>','草稿');"  type="button" class="but_y_01" style="display: none" />
				                <input name="savetmp" id="savetmp" value="存为模板" onclick="saveTmp()" type="button" class="but_y_01" style="display: none" />
				                <input name="UNDONE"   id="UNDONE"           value="追回"     onclick="recoverMeeting('<%=m_notice_id %>');"   style="display: none" type="button" class="but_y_01" style="display: none" />
				                <input name="attender"   id="attender"       value="报名情况"   onclick="openAttender()"   style="display: none" type="button" class="but_y_01" style="display: none" />
				                <input name="read"   id="read"       value="阅读情况"   onclick="openRead()"   style="display: none" type="button" class="but_y_01" style="display: none" />
				                <input name="addsend"   id="addsend"       value="补发"   onclick="openAddsend()"   style="display: none" type="button" class="but_y_01" style="display: none" />
				                <input name="resend"   id="resend"       value="修改会议"   onclick="editmeeing(this)"   style="display: none" type="button" class="but_y_01" style="display: none" />
            				    <input name="REPUBLISHED"   id="REPUBLISHED"   value="重新发布"  onclick="saveTab('<%=MeetingConstants.STATUS_REPUBLISHED %>','重新发布','<%=MeetingConstants.MSG_PUBLISHED_SEND %>','重布');"  type="button" class="but_y_01" style="display: none"/>
				                <input name="cancel"   id="cancel"       value="撤销"   onclick="openCancel()"   style="display: none" type="button" class="but_y_01" style="display: none" />
				                <input id="checkpass" name="checkpass" value="通过"    onclick="docheck()"  type="button" class="but_y_01" style="display: none"/>
				                <input id="uncheckpass" name="uncheckpass" value="不通过" onclick="docheck4unpass('<%=MeetingConstants.STATUS_UNCHECKPASS %>')" type="button" class="but_y_01" style="display: none"/>
				                <input id="reply" name="reply" value="报名回复" onclick="openReply()" type="button" class="but_y_01" style="display: none"/>
				                <input id="rt" name="返回" value="返回" onclick="returnmainjsp()" type="button" class="but_y_01"  />
				            </div>  
				        </div>
				        
						<div id="titleids" style="display:none;" id="_top">
							<ul>
								<li><a href="#tabs-1">基本信息</a></li>
								<li><a href="#tabs-2">会议正文</a></li>
								<li <%if(hidetopicdiv) {%>style="display: none"<%}%>><a href="#tabs-3" >会议议题<span class="color_red"  id="topictitle"></span></a></li>
							</ul>
						</div>
						<div id="tabs-1">
							<iframe src="meetingnoticedetail.jsp?issaved=<%=issaved%>&m_notice_id=<%=m_notice_id %>" id="frame1" frameborder="0"
								width="100%"></iframe>
						</div>
						<div id="tabs-2">
							<iframe src="" id="frame2" frameborder="0"
								width="100%"></iframe>
						</div>
						<div id="tabs-3" <%if(hidetopicdiv) {%>style="display: none"<%}%>>
							<iframe src="" id="frame3" frameborder="0"
								width="100%"></iframe>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
	<input type="hidden" id="issaved" value="<%=issaved %>" />
	<input type="hidden" name="m_notice_id" id="m_notice_id" value="<%=m_notice_id %>" />
	<input type="hidden" id="hidetopicdiv" value="<%=hidetopicdiv %>" />
	<input type="hidden" id="isneedsignup" value="<%=isneedsignup %>" />
	<input type="hidden" id="frompagehome" value="<%=frompagehome %>" />
</body>
</html>