<%--
　　描述：会议通知 申请 基本作息 明细页面
　　作者：黄海
　　版本：1.0
　　日期：2013-6-22
--%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamConstant"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmConstants"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.meeting.util.MeetingConstants"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.MeetingHandleServiceIfc" %>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.MeetingHandleServiceImpl" %>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.impl.SysParamServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.service.SysParamServiceIfc"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String issaved = request.getParameter("issaved");
//保存模板需要的参数
String userId = accesscontroler.getUserID();
String userName = accesscontroler.getUserName();

UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);

String orgId="";//单位
String orgName="";//单位name
String F_ORG_ID = "";//部门 
String F_ORG_NAME = "";//部门name
String m_create_unit_id = "";
String m_create_unit_name = "";
String user_worktel = "";
String user_mobiletel1 = "";
String nocache="";
if(usercachebean!=null){
	orgId=usercachebean.getUnit_id();//单位
	orgName=usercachebean.getUnit_name();//单位name
	F_ORG_ID = usercachebean.getOrg_id();//部门 
	F_ORG_NAME = usercachebean.getOrg_name();//部门name
	m_create_unit_id = usercachebean.getUnit_id();
	m_create_unit_name = usercachebean.getUnit_name();
	user_worktel = usercachebean.getUser_worktel();
	user_mobiletel1 = usercachebean.getUser_mobiletel1();
}else{
	nocache="1";
}

Map<String, String> viewMap = new HashMap<String, String>();
SysParamServiceIfc SysParamServiceIfc=new SysParamServiceImpl();

String time = DateUtil.getCurrentDateTime();//创建时间

String m_notice_id = request.getParameter("m_notice_id");
String m_title = "";
String m_room_id = "";
String m_room_name = "";
String m_address = "";
String m_begin_time = "";
String m_end_time = "";
String m_is_need_signup = "";
String m_link_dept_id = "";
String m_link_dept_name = "";
String m_link_user_name = "";
String m_link_user_id = "";
String m_link_tel = "";
String m_type_id = "";
String m_type_name = "";
String m_master_user_id = "";
String m_master_user_name = "";
String m_attender_count = "";
String m_close_time = "";
String m_send_name = "";
String m_check_flag = "";
String m_check_flag_name = "";
String m_receiver_unit_ids = "";
String m_receiver_user_ids = "";

String m_receiver_unit_names = "";
String m_receiver_user_names = "";
String m_remark = "";
String m_contents = "";//正文
String m_djbh = "";
//msglog
String m_id = "";
String msg_contents = "";
String m_msg_type = "";
String m_msg_send_flag = "";
String m_msg_send_flag_name = "";

String m_receiver_other_unit_ids = "";//公共
String m_receiver_other_unit_names = "";
String m_receiver_other_user_ids = "";//个人
String m_receiver_other_user_names = "";
String userTd4Other = "";
String m_other_user_input = "";
String m_create_user_id = "";

MeetingHandleServiceIfc service = new MeetingHandleServiceImpl();
Map<String, String> map = new HashMap<String, String>(); 
Map<String, String> map4Msg = new HashMap<String, String>(); 
String checkpass = SysParamUitl.getSysParamValueIsVALID(MeetingConstants.MEETING_MSG);
String m_msg_contents="";
if(!StringUtil.nullOrBlank(checkpass)){
	m_msg_contents = SysParamUitl.getSysParamValue(checkpass);
	List<Map<String, String>> listmap = SysParamUitl.getSysParamValueDetail(checkpass);
	 if(!StringUtil.nullOrBlank(m_msg_contents) && listmap!=null && listmap.size()>0){
		for (Map<String, String> map1 : listmap){
			//System.out.println("map.get(\"p_value_name\")=="+map.get("p_value_name")+",map.get(\"p_value_code\")==="+map.get("p_value_code")+",kbmDocMap.get(map.get(\"p_value_code\"))=="+kbmDocMap.get(map.get("p_value_code")));
			if(map4Msg!=null && map4Msg.size()>0 && !StringUtil.nullOrBlank(map4Msg.get(map1.get("p_value_code")))){
				m_msg_contents = m_contents.replaceAll(map.get("p_value_name"),map4Msg.get(map1.get("p_value_code")));
			}
		}
	}	
}
if (!StringUtil.nullOrBlank(m_notice_id)){
	//会议基本信息
	map = (HashMap <String, String>)service.getMeetingNoticeBean(m_notice_id);
	m_title = StringUtil.deNull(map.get("m_title"));
	m_create_user_id = StringUtil.deNull(map.get("m_create_user_id"));
	m_room_id = StringUtil.deNull(map.get("m_room_id"));
	m_room_name = StringUtil.deNull(map.get("m_room_name"));
	m_address = StringUtil.deNull(map.get("m_address"));
	m_begin_time = StringUtil.deNull(map.get("m_begin_time"));
	m_end_time = StringUtil.deNull(map.get("m_end_time"));
	if(m_begin_time.length()>0){
		m_begin_time=m_begin_time.substring(0, m_begin_time.length()-3);
	}
	if(m_end_time.length()>0){
		m_end_time=m_end_time.substring(0, m_end_time.length()-3);
	}
	m_is_need_signup = StringUtil.deNull(map.get("m_is_need_signup"));
	m_link_dept_id = StringUtil.deNull(map.get("m_link_dept_id"));
	m_link_dept_name = StringUtil.deNull(map.get("m_link_dept_name"));
	m_link_user_name = StringUtil.deNull(map.get("m_link_user_name"));
	m_link_user_id = StringUtil.deNull(map.get("m_link_user_id"));
	m_link_tel = StringUtil.deNull(map.get("m_link_tel"));
	m_type_id = StringUtil.deNull(map.get("m_type_id"));
	m_type_name = StringUtil.deNull(map.get("m_type_name"));
	m_master_user_id = StringUtil.deNull(map.get("m_master_user_id"));
	m_master_user_name = StringUtil.deNull(map.get("m_master_user_name"));
	m_attender_count = StringUtil.deNull(map.get("m_attender_count"));
	m_close_time = StringUtil.deNull(map.get("m_close_time"));
	m_send_name = StringUtil.deNull(map.get("m_send_name"));
	m_check_flag = StringUtil.deNull(map.get("m_check_flag"));
	m_check_flag_name = StringUtil.deNull(map.get("m_check_flag_name"));
	m_receiver_unit_ids = StringUtil.deNull(map.get("m_receiver_unit_ids"));
	m_receiver_user_ids = StringUtil.deNull(map.get("m_receiver_user_ids"));
	m_receiver_user_names = StringUtil.deNull(map.get("m_receiver_user_names"));
	m_receiver_unit_names = StringUtil.deNull(map.get("m_receiver_unit_names"));
	m_receiver_other_user_ids = StringUtil.deNull(map.get("m_receiver_other_user_ids"));
	m_receiver_other_unit_ids = StringUtil.deNull(map.get("m_receiver_other_unit_ids"));
	m_receiver_other_user_names = StringUtil.deNull(map.get("m_receiver_other_user_names"));
	m_receiver_other_unit_names = StringUtil.deNull(map.get("m_receiver_other_unit_names"));
	userTd4Other = m_receiver_other_user_names;
	if (!StringUtil.nullOrBlank(userTd4Other) && !StringUtil.nullOrBlank(m_receiver_other_unit_names)){
		userTd4Other+=","+m_receiver_other_unit_names;
	}else if(!StringUtil.nullOrBlank(m_receiver_other_unit_names)){
		userTd4Other=m_receiver_other_unit_names;
	}
	m_remark = StringUtil.deNull(map.get("m_remark"));
	m_contents = StringUtil.encoding4jQuery(StringUtil.deNull(map.get("m_contents")));
	m_djbh = StringUtil.deNull(map.get("m_djbh"));
	
	m_other_user_input = StringUtil.deNull(map.get("m_other_user_input"));
	//会议消息发送log
	map4Msg = (HashMap <String, String>)service.getMeetingMsgLogMap(m_notice_id);
	m_id = StringUtil.deNull(map4Msg.get("m_id"));
	msg_contents = StringUtil.deNull(map4Msg.get("m_contents"));
	m_msg_type = StringUtil.deNull(map4Msg.get("m_msg_type"));
	m_msg_send_flag = StringUtil.deNull(map4Msg.get("m_msg_send_flag"));
	m_msg_send_flag_name = StringUtil.deNull(map4Msg.get("m_msg_send_flag_name"));
}else{
	m_link_dept_id = accesscontroler.getChargeOrgId();
	m_link_dept_name = accesscontroler.getChargeOrgName();
	m_link_user_name = accesscontroler.getUserName();
	m_link_user_id = accesscontroler.getUserID();
	
	viewMap=SysParamServiceIfc.getSysParamByPcode("linktel");
	if (viewMap.size()>0){
		String p_content = StringUtil.deNull(viewMap.get("p_content"));
		if("0".equalsIgnoreCase(p_content)){
			m_link_tel = user_worktel;
		}else if ("1".equalsIgnoreCase(p_content)){
			m_link_tel = user_mobiletel1;
		}
	}
}


/*
	会议室select
*/
String sql = "select t.m_room_id,t.m_room_name,nvl(t.m_address, '') || '|' || nvl(t.m_is_need_check, '1') || '|' || nvl(t.m_is_use_flag, '1') || '|' ||nvl(t.administrator_ids,',') m_address from OA_MEETING_ROOM t where  t.m_unit_id = '"+m_create_unit_id+"'";
if(StringUtil.nullOrBlank(m_notice_id)){
	sql+=" and m_is_use_flag='1' ";
}
//  docheck 审核时 只显示本人管理的会议室
if("docheck".equalsIgnoreCase(StringUtil.deNull(issaved))){
	sql+=" and ','||t.administrator_ids||',' like '%,"+userId+",%' ";
}

String roomselectHtml =DictDropDownList.buildSelect4Expand(sql,"m_room_id", StringUtil.deNull(m_room_id), "", true, "","width:140px","");
/*
	会议类型select
*/
String sql2 = "select t.m_type_id,t.m_type_name,t.m_unit_id from OA_MEETING_TYPE t where t.m_is_use_flag=1 and t.m_unit_id = '"+m_create_unit_id+"'";
String mtypeselectHtml =DictDropDownList.buildSelect4Expand(sql2,"m_type_id", StringUtil.deNull(m_type_id), "", true, "","width:140px","");

//判断是否有短信，及时，邮件，站内消息提示
SysParamUitl noticeutil=new SysParamUitl();
Map<String,String> msgmap=noticeutil.getCheckedSystemMsg();
String is_pub_sms=msgmap.get(SysParamConstant.IS_PUB_SMS);
String is_pub_msg=msgmap.get(SysParamConstant.IS_PUB_MSG);
String is_pub_rtx=msgmap.get(SysParamConstant.IS_PUB_RTX);
String is_pub_mail=msgmap.get(SysParamConstant.IS_PUB_MAIL);


%>
<title>会议通知申请页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<!-- 引入提示 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>

<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
	
<!-- 引入上传控件 -->
<link rel="stylesheet" href="../../resources/plug/fancyupload/fancyupload.css" type="text/css" />
<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>

<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript" src="../resources/js/meetingnoticedetail.js"></script>

<!-- 公共部分引用结束 -->
<script type="text/javascript">
var orgId = "<%=orgId%>";
var nocache = "<%=nocache%>";
var m_msg_contents = "<%=m_msg_contents%>";
jQuery(function() {
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");//设高度适配滚动条
	if(window.parent.jQuery("#frompagehome").val()=="1"){//来源不同iframe嵌套层次不同，高度做不同的控制 如下是来自首页的等待阅读
		jQuery("#maindiv").height(_documentBodyHeight-140);
	}else{
		jQuery("#maindiv").height(_documentBodyHeight-100);
	}
	if(nocache!="1"){
		window.parent.setButtonDisplay();//new edit 按钮提前显示	
	}else{
		jQuery("#chose_notice_button").hide();
	}
	setTimeout(function(){window.parent.initFrame();},500);//延时0.1秒加载tab2和tab3
	jQuery(document).keydown(function(){
        if(event.keyCode == 13){ 
        }
        

    });

    //为下拉框加上change事件  初始化表单值  begin --------------------------------------------------
    jQuery("#m_room_id").change(function(){
    	//判断会议否可用
    	isMeetingRoomUsed();
    });
    //jQuery("#m_title").val('<%=m_title%>');    
    jQuery("#m_room_id").val('<%=m_room_id%>');
    jQuery("#m_room_name").text('<%=m_room_name%>');
    //jQuery("#m_address").val('<%=m_address%>');
    jQuery("#m_begin_time").val('<%=m_begin_time%>');
    jQuery("#m_end_time").val('<%=m_end_time%>');
    //jQuery("#m_is_need_signup").val('<%=m_is_need_signup%>');
    jQuery("#m_link_dept_id").val('<%=m_link_dept_id%>');
    jQuery("#m_link_dept_name").val('<%=m_link_dept_name%>');
    jQuery("#m_link_user_name").val('<%=m_link_user_name%>');
    jQuery("#m_link_user_id").val('<%=m_link_user_id%>');
    jQuery("#m_link_tel").val('<%=m_link_tel%>');
    jQuery("#m_type_id").val('<%=m_type_id%>');
    jQuery("#m_type_name").text('<%=m_type_name%>');
    jQuery("#m_master_user_id").val('<%=m_master_user_id%>');
    jQuery("#m_master_user_name").val('<%=m_master_user_name%>');
    jQuery("#m_attender_count").val('<%=m_attender_count%>');
    //if (!isSpace('<%=m_is_need_signup%>')){ 
    //	jQuery('input[name="m_is_need_signup"]').get('<%=m_is_need_signup%>').checked = true;
    //}
    jQuery("#m_close_time").val('<%=m_close_time%>');
    jQuery("#m_send_name").val('<%=m_send_name%>');
    jQuery("#m_receiver_unit_ids").val('<%=m_receiver_unit_ids%>');
    jQuery("#m_receiver_user_ids").val('<%=m_receiver_user_ids%>');
    jQuery("#m_receiver_unit_names").val('<%=m_receiver_unit_names%>');
    jQuery("#m_receiver_user_names").val('<%=m_receiver_user_names%>');
    
    jQuery("#m_receiver_other_unit_ids").val('<%=m_receiver_other_unit_ids%>');
    jQuery("#m_receiver_other_user_ids").val('<%=m_receiver_other_user_ids%>');
    jQuery("#m_receiver_other_unit_names").val('<%=m_receiver_other_unit_names%>');
    jQuery("#m_receiver_other_user_names").val('<%=m_receiver_other_user_names%>');
    jQuery("#userTd4Other").val('<%=userTd4Other%>');
    
    //jQuery("#m_remark").val('<%=m_remark%>');
    jQuery("#m_djbh").val('<%=m_djbh%>');
    
    //jQuery("#m_other_user_input").val('<%=m_other_user_input%>');
    
    var dep = new Object();
	var ps = new Object();
	dep.id=jQuery("#m_receiver_unit_ids").val();
	dep.name=jQuery("#m_receiver_unit_names").val();
	ps.name=jQuery("#m_receiver_user_names").val();
	ps.id=jQuery("#m_receiver_user_ids").val();
	createrDeptAndPosn(dep,"deptTd",'m_receiver_unit_ids','m_receiver_unit_names');
	createrDeptAndPosn(ps,"userTd", 'm_receiver_user_ids','m_receiver_user_names',false,false,false,true);
	
	jQuery("#m_id").val('<%=m_id%>');
	var msgtype = '<%=m_msg_type%>';
	if(msgtype=="msg,note"){
		jQuery("#m_msg_type1").attr("checked",true);
		jQuery("#m_msg_type2").attr("checked",true);
	}else if(msgtype=="msg"){
		jQuery("#m_msg_type1").attr("checked",true);
	}else if(msgtype=="note"){
		jQuery("#m_msg_type2").attr("checked",true);
	}
	jQuery("#m_msg_send_flag").val('<%=m_msg_send_flag%>');
	jQuery("#m_msg_send_flag_name").val('<%=m_msg_send_flag_name%>');
	
	jQuery("#strSum").val(strSum);//议题统计
	//为下拉框加上change事件  初始化表单值  begin --------------------------------------------------
	
	
	if("doquery"=="<%=issaved%>"){//从会议通知查询打开时，直接打开隐藏内容截止时间等
		displays();
	}
	
	if(! window.parent.canOperate()){//如果没有操作权限，表单控件全部置为不可用
		disabledAll();
	}
	
	if(!canEdit()){//不能编辑时，设置 表单控件不编辑 
		jQuery("#m_room_id").prop("disabled", true);
        jQuery("#m_begin_time").prop("disabled", true);
        jQuery("#m_end_time").prop("disabled", true);
        jQuery("#m_address").prop("disabled", true);
	}else{
		jQuery("#m_room_id").prop("disabled", false);
        jQuery("#m_begin_time").prop("disabled", false);
        jQuery("#m_end_time").prop("disabled", false);
        jQuery("#m_address").prop("disabled", false);
	}
	
	/*根据全局系统参数配置，显示控件
	if(window.parent.jQuery("#isneedsignup").val()=="true"){
		jQuery("span[id='isneedsignup']").each(function(i, obj) {
			jQuery(this).show();
		});
		jQuery("#m_is_need_signup0").show();
		jQuery("#m_is_need_signup1").show();
		jQuery("#m_close_time").show();
	}*/
	
	if("1"=="<%=StringUtil.deNull(map.get("is_sms")) %>"){
		jQuery("#is_sms").attr("checked","checked");
	}
	if("1"=="<%=StringUtil.deNull(map.get("is_msg")) %>"){
		jQuery("#is_msg").attr("checked","checked");
	}
	if("1"=="<%=StringUtil.deNull(map.get("is_rtx")) %>"){
		jQuery("#is_rtx").attr("checked","checked");
	}
	if("1"=="<%=StringUtil.deNull(map.get("is_mail")) %>"){
		jQuery("#is_mail").attr("checked","checked");
	}
    //发改委个性修改
    setValue4m_msg_contents($("#is_sms"));
    setValue4m_msg_contents($("#is_msg"));
    displaymore();
});

/*
函数:  canEdit
说明:  查询是否可编辑 主要用判断影响冲突的控件是否可用
               不可编辑：待审且不是会议室审核人时，发布后、审核通过、重新发布；
               允许编辑：新增、暂存、追回、审核不通过、撤销
*/
function canEdit() {
    var flag = true;
    var currCheckFlag = '<%=m_check_flag%>';
    if ((currCheckFlag == '<%=MeetingConstants.STATUS_PENDING%>' && 'docheck' != '<%=issaved%>') 
    		|| currCheckFlag == '<%=MeetingConstants.STATUS_PUBLISHED%>' 
    		|| currCheckFlag == '<%=MeetingConstants.STATUS_CHECKPASS%>' 
    		|| currCheckFlag == '<%=MeetingConstants.STATUS_REPUBLISHED%>') {
        flag = false;
    }
	if ('dochecked' == '<%=issaved%>' && (currCheckFlag == '<%=MeetingConstants.STATUS_REPUBLISHED%>' || currCheckFlag == '<%=MeetingConstants.STATUS_PUBLISHED%>')){
		flag = true;	
    }
    return flag;
}

/*
函数:  isMeetingRoomUsed
说明:  替换地点value
*/
function isMeetingRoomUsed() {
	var str = jQuery("#m_room_id").find("option:selected").attr("expandName");
	str = str.substr(str.indexOf("|")+1);
	str = str.substr(str.indexOf("|")+1);
	var m_is_use_flag = str.substr(0,1);
	if(m_is_use_flag==0){
		jQuery("#m_room_id").val('');
		jQuery("#m_address").val('');
		window.parent.hideshowButton();
		alert("错误：该会议室不可用，请重新选择！");
		return;
	}else{
		replaceValue2Address();
    	window.parent.hideshowButton();
	}
}

/*
	函数:  replaceValue2Address
	说明:  替换地点value
*/
function replaceValue2Address() {
	var str = jQuery("#m_room_id").find("option:selected").attr("expandName");
	var expandName = str.substr(0,str.indexOf("|"));
	jQuery("#m_address").val(expandName);
}
/*
	函数:  getM_is_need_check
	说明:  是否需要会议室管理员审核
*/
function getM_is_need_check() {
	var str = jQuery("#m_room_id").find("option:selected").attr("expandName");
	var m_is_need_check = str.substr(str.indexOf("|")+1);
	m_is_need_check = m_is_need_check.substr(0,1);
	return m_is_need_check;
}
/*
	函数:  getAdministrator_ids
	说明:  获取会议室管理员ids
*/
function getAdministrator_ids(){
	var str = jQuery("#m_room_id").find("option:selected").attr("expandName");
	var administrator_ids = str.substr(str.lastIndexOf("|")+1);
	return administrator_ids;
}

/*
	函数:  checkData
	说明:  校验表单数据
*/
function checkData(){
	//tab页切换到frame1
	window.parent.toFrame(0);	
	displays();
	//自动校验
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (!isFlag){
		return isFlag;	
	}
	/*
	//人工校验
	if(jQuery('input:radio[name="m_is_need_signup"]:checked').val()=="undefined"){
		alert("注意：请选择‘是否需要报名’");
		return false;
	}
	if(jQuery('input:radio[name="m_is_need_signup"]:checked').val()=="1" && isSpace(jQuery('#m_close_time').val()) ){
		alert("注意：请选择‘报名截止时间’");
		return false;
	}*/
	if(isSpace(jQuery('#m_close_time').val()) ){
		alert("注意：请选择‘报名截止时间’");
		return false;
	}
	if(isSpace(jQuery("#m_receiver_unit_ids").val()) && isSpace(jQuery("#m_receiver_user_ids").val()) ){
		alert("注意：请选择与会单位或与会人员！");
		return false;
	}
	return true;
}
/*
函数:  isCheckMsgsendType
说明:  是否选择了提醒方法 
*/
function isCheckMsgsendType(){
	var flag = true;
	var str = "";
	ischecked();
    jQuery("input[name='m_msg_type']:checked").each(function(){         
        str+=jQuery(this).val();
    }); 
	if(str==""){//没选
		flag = false;		
	}
	return flag;
}
function getJsonOld(m_check_flag,m_check_flag_name){
	ischecked();
	var roomname = (isSpace(jQuery("#m_room_id").val())) ? "" : jQuery("#m_room_id").find("option:selected").text();	
	var basejsons =  "'m_type_id':'"+jQuery("#m_type_id").val()+"'"+   
					",'m_type_name':'"+jQuery("#m_type_id option[value='']~option:selected").text()+"'"+   
					",'m_room_id':'"+jQuery("#m_room_id").val()+"'"+   
					",'m_room_name':'"+roomname+"'"+   
					",'m_title':'"+jQuery("#m_title").val()+"'"+     
					",'m_begin_time':'"+jQuery("#m_begin_time").val()+"'"+   
					",'m_end_time':'"+jQuery("#m_end_time").val()+"'"+    
					",'m_address':'"+jQuery("#m_address").val()+"'"+   
					",'m_link_user_id':'"+jQuery("#m_link_user_id").val()+"'"+   
					",'m_link_user_name':'"+jQuery("#m_link_user_name").val()+"'"+   
					",'m_link_dept_id':'"+jQuery("#m_link_dept_id").val()+"'"+   
					",'m_link_dept_name':'"+jQuery("#m_link_dept_name").val()+"'"+   
					",'m_link_tel':'"+jQuery("#m_link_tel").val()+"'"+    
					",'m_master_user_id':'"+jQuery("#m_master_user_id").val()+"'"+   
					",'m_master_user_name':'"+jQuery("#m_master_user_name").val()+"'"+   
					",'m_attender_count':'"+jQuery("#m_attender_count").val()+"'"+   
					",'m_close_time':'"+jQuery("#m_close_time").val()+"'"+   
					",'m_send_name':'"+jQuery("#m_send_name").val()+"'"+   
					",'m_create_dept_id':'<%=F_ORG_ID%>'"+   
					",'m_create_dept_name':'<%=F_ORG_NAME%>'"+   
					",'m_create_unit_id':'<%=m_create_unit_id%>'"+   
					",'m_create_unit_name':'<%=m_create_unit_name%>'"+ 
					",'m_check_flag':'"+m_check_flag+"'"+   
					",'m_check_flag_name':'"+m_check_flag_name+"'"+  
					",'m_receiver_user_ids':'" + jQuery("#m_receiver_user_ids").val()+"'" + 
					",'m_receiver_unit_ids':'" + jQuery("#m_receiver_unit_ids").val()+"'" + 
					",'m_receiver_unit_names':'" + jQuery("#m_receiver_unit_names").val()+"'" + 
					",'m_receiver_user_names':'" + jQuery("#m_receiver_user_names").val()+"'" + 
					",'m_receiver_other_user_ids':'" + jQuery("#m_receiver_other_user_ids").val()+"'" + 
					",'m_receiver_other_unit_ids':'" + jQuery("#m_receiver_other_unit_ids").val()+"'" + 
					",'m_receiver_other_unit_names':'" + jQuery("#m_receiver_other_unit_names").val()+"'" + 
					",'m_receiver_other_user_names':'" + jQuery("#m_receiver_other_user_names").val()+"'" + 
					",'m_notice_id':'"+jQuery("#m_notice_id").val()+"'"+
					",'is_sms':'"+jQuery("#is_sms").val()+"'"+
					",'is_msg':'"+jQuery("#is_msg").val()+"'"+
					",'is_rtx':'"+jQuery("#is_rtx").val()+"'"+
					",'is_mail':'"+jQuery("#is_mail").val()+"'"+
					",'m_other_user_input':'"+jQuery("#m_other_user_input").val()+"'"+
					",'m_remark':'" + jQuery("#m_remark").val()+"'";
					
		if(isSpace(jQuery("#m_notice_id").val())){//新增时
			basejsons+= ",'m_create_user_id':'<%=accesscontroler.getUserID()%>'"+   
						 ",'m_create_user_name':'<%=accesscontroler.getUserName()%>'";
		}			
		//未包括审核人信息 m_check_user_id,m_check_user_name,m_check_time
		if (isDRAFTorPENDING(m_check_flag)){//新增记录时补发和重发字段都为0
			basejsons+= ",'m_is_addsend':'0','m_is_resend':'0' ";
		}else if (m_check_flag=='<%=MeetingConstants.MSG_ADD_SEND%>'){
			basejsons+= ",'m_is_addsend':'1' ";
			basejsons+= ",'m_current_user_id':'<%=accesscontroler.getUserID()%>'"+   
						",'m_current_user_name':'<%=accesscontroler.getUserName()%>'";

		}else if (m_check_flag=='<%=MeetingConstants.MSG_RE_SEND%>'){
			basejsons+= ",'m_is_resend':'1' ";
			basejsons+= ",'m_current_user_id':'<%=accesscontroler.getUserID()%>'"+   
						",'m_current_user_name':'<%=accesscontroler.getUserName()%>'";

		}else if (m_check_flag=='<%=MeetingConstants.STATUS_PUBLISHED%>'){
			basejsons+= ",'m_current_user_id':'<%=accesscontroler.getUserID()%>'"+   
						",'m_current_user_name':'<%=accesscontroler.getUserName()%>'";
		}
		<%-- edit by 2013-08-25	
		if(!(m_check_flag=='<%=MeetingConstants.STATUS_REPUBLISHED%>')){重发的报名控制在重发页面确定===注意这里是不等于
					
		basejsons+=",'m_is_need_signup':'"+ jQuery('input:radio[name="m_is_need_signup"]:checked').val()+"'";   
		/* //} */--%>
		basejsons+= ",'m_update_user_id':'<%=accesscontroler.getUserID()%>','m_update_user_name':'<%=accesscontroler.getUserName()%>'";  
	return basejsons;
}
/*
	函数:  getJson
	说明:  得到对应实体类的json格式字符串
*/
function getJson(m_check_flag,m_check_flag_name){
	ischecked();
	var roomname = (isSpace(jQuery("#m_room_id").val())) ? "" : jQuery("#m_room_id").find("option:selected").text();	
	var jsonObj = {
		m_type_id:jQuery("#m_type_id").val(),
		m_type_name:jQuery("#m_type_id option[value='']~option:selected").text(),
		m_room_id:jQuery("#m_room_id").val(),	
		m_room_name:roomname,
		m_title:jQuery("#m_title").val(),	
		m_begin_time:jQuery("#m_begin_time").val(),
		m_end_time:jQuery("#m_end_time").val(),	
		m_address:jQuery("#m_address").val(),
		m_link_user_id:jQuery("#m_link_user_id").val(),	
		m_link_user_name:jQuery("#m_link_user_name").val(),
		m_link_dept_id:jQuery("#m_link_dept_id").val(),
		m_link_dept_name:jQuery("#m_link_dept_name").val(),
		m_link_tel:jQuery("#m_link_tel").val(),	
		m_master_user_id:jQuery("#m_master_user_id").val(),
		m_master_user_name:jQuery("#m_master_user_name").val(),
		m_attender_count:   jQuery("#m_attender_count").val(),
		m_close_time:   jQuery("#m_close_time").val(),
		m_send_name:   jQuery("#m_send_name").val(),
		m_create_dept_id:   "<%=F_ORG_ID%>",
		m_create_dept_name:   "<%=F_ORG_NAME%>",
		m_create_unit_id:  "<%=m_create_unit_id%>",
		m_create_unit_name:   "<%=m_create_unit_name%>",
		m_check_flag:   m_check_flag,
		m_check_flag_name:  m_check_flag_name,
		m_receiver_user_ids:   jQuery("#m_receiver_user_ids").val(),
		m_receiver_unit_ids:   jQuery("#m_receiver_unit_ids").val(),
		m_receiver_unit_names:   jQuery("#m_receiver_unit_names").val(),
		m_receiver_user_names:   jQuery("#m_receiver_user_names").val(),
		m_receiver_other_user_ids:   jQuery("#m_receiver_other_user_ids").val(),
		m_receiver_other_unit_ids:   jQuery("#m_receiver_other_unit_ids").val(),
		m_receiver_other_unit_names:   jQuery("#m_receiver_other_unit_names").val(),
		m_receiver_other_user_names:   jQuery("#m_receiver_other_user_names").val(),
		m_notice_id:   jQuery("#m_notice_id").val(),
		is_sms:   jQuery("#is_sms").val(),
		is_msg:   jQuery("#is_msg").val(),
		is_rtx:   jQuery("#is_rtx").val(),
		is_mail:   jQuery("#is_mail").val(),
		m_other_user_input:   jQuery("#m_other_user_input").val(),
		m_remark:   jQuery("#m_remark").val()
	}
	if(isSpace(jQuery("#m_notice_id").val())){//新增时
		jsonObj.m_create_user_id="<%=accesscontroler.getUserID()%>";
		jsonObj.m_create_user_name="<%=accesscontroler.getUserName()%>";
	}
	//未包括审核人信息 m_check_user_id,m_check_user_name,m_check_time
	if (isDRAFTorPENDING(m_check_flag)){//新增记录时补发和重发字段都为0
		jsonObj.m_is_addsend=0;
		jsonObj.m_is_resend=0;
	}else if (m_check_flag=='<%=MeetingConstants.MSG_ADD_SEND%>'){
		jsonObj.m_is_addsend=1;
		jsonObj.m_current_user_id="<%=accesscontroler.getUserID()%>";
		jsonObj.m_current_user_name="<%=accesscontroler.getUserName()%>";
	}else if (m_check_flag=='<%=MeetingConstants.MSG_RE_SEND%>'){
		jsonObj.m_is_resend=1;
		jsonObj.m_current_user_id="<%=accesscontroler.getUserID()%>";
		jsonObj.m_current_user_name="<%=accesscontroler.getUserName()%>";
	}else if (m_check_flag=='<%=MeetingConstants.STATUS_PUBLISHED%>'){
		jsonObj.m_current_user_id="<%=accesscontroler.getUserID()%>";
		jsonObj.m_current_user_name="<%=accesscontroler.getUserName()%>";
	}
	//jsonObj.m_is_need_signup = jQuery('input:radio[name="m_is_need_signup"]:checked').val();
	jsonObj.m_update_user_id = "<%=accesscontroler.getUserID()%>";
	jsonObj.m_update_user_name = "<%=accesscontroler.getUserName()%>";
	
	var tmpstr = JSON.stringify(jsonObj);
	return tmpstr.substring(1,tmpstr.length-1);
}


/*
函数:  isDRAFTorPENDING
说明:  只有是暂存或送审 才返回true
*/
function isDRAFTorPENDING(m_check_flag) {
    var flag = false;
    if ((m_check_flag == "<%=MeetingConstants.STATUS_DRAFT%>") || (m_check_flag == "<%=MeetingConstants.STATUS_PENDING%>")) {
        flag = true;
    }
    return flag;
}


/*
	函数:  getContents
	说明:  得到会议附件编号
*/
function getM_djbh(){
	return jQuery("#m_djbh").val();
}
/*
	函数:  getContents
	说明:  得到会议基本信息的正文信息
*/
function getContents(){
	return jQuery("#m_contents_value").val();
	return m_contents_value;
}
/*
	函数:  getM_check_flag
	说明:  得到会议基本信息的正文信息
*/
function  getM_check_flag(){
	return jQuery("#m_check_flag").val();
}
/*
	函数:  getM_check_flag_name
	说明:  得到会议基本信息的正文信息
*/
function  getM_check_flag_name(){
	return jQuery("#m_check_flag_name").val();
}


/*
	函数:  getM_link_user_id
	说明:  得到会议基本信息的正文信息
*/
function  getM_link_user_id(){
	return jQuery("#m_link_user_id").val();
}

/*
	函数:  getM_room_id
	说明:  得到会议基本信息的正文信息
*/
function  getM_room_id(){
	return jQuery("#m_room_id").val();
}


/*
	函数:  getM_receiver_unit_ids
	说明:  得到与会单位
*/
function  getM_receiver_unit_ids(){
	return jQuery("#m_receiver_unit_ids").val();
}


/*
	函数:  getM_receiver_user_ids
	说明:  得到与会人员
*/
function  getM_receiver_user_ids(){
	return jQuery("#m_receiver_user_ids").val();
}


/*
函数:  checkMeetingRoomOccupancy
说明:  验证会议室是否被点用
*/
function checkMeetingRoomOccupancy(name) {
	var m_begin_time;
	var m_end_time;
	var m_room_id;
	var m_ro_id;
	var params = {
			m_begin_time : jQuery("#m_begin_time").val(),
			m_end_time : jQuery("#m_end_time").val(),
			m_room_id : jQuery("#m_room_id").val(),
			m_notice_id : jQuery("#m_notice_id").val(),
			m_ro_id : jQuery("#m_ro_id").val()
	};
	url = "checkroomoccupancydo.jsp";
	jQuery.ajax({
		url : url,
		type : 'POST',
		dataType : 'json',
		data : params,
		async : true,
		success : function(flagStr) {
		  if(flagStr) {
		  } else {
			  alert('会议室被占用');
			  jQuery("#m_begin_time").val('');
			  jQuery("#m_end_time").val('');
		  } 
		  
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("error:" + textStatus);
		}
	});
}
function changeM_close_time(obj){
	if(window.parent.jQuery("#isneedsignup").val()=="yes"){
		//jQuery("#m_close_time").val(jQuery("#m_begin_time").val())	
	}
}
/*
	函数:  adddeptandusernew
	说明:  弹出公告接收人和接收部门树，并处理议题页面
	参数:   无
	返回值: 无
*/
function adddeptandusernew() {
	var user_ids = jQuery("#m_receiver_user_ids").val();
	var unit_ids = jQuery("#m_receiver_unit_ids").val();
	if(!isSpace(user_ids+unit_ids) && window.parent.jQuery("#hidetopicdiv").val()=="false"){ //有会议议题时才提示。 hidetopicdiv==false代表未隐藏，true代表隐藏了 
		if(confirm("注意：修改与会单位或人员将需要重新选择议题的与会单位和人员！")){
			adddeptanduser('clean');
		}else{
			return;
		}
	}else{
		adddeptanduser('');
	}
}

/*
	函数:  returnReplaceNoteContents
	说明:  用替代后短信内容设置页面上短信内容的文本域
	参数:  替代后短信内容
*/
function replaceNoteContents(str){
	jQuery("#msg_contents").val(returnReplaceNoteContents(str));
}
/*
	函数:  returnReplaceNoteContents
	说明:  用模板生成短信内容
	参数:  模板内容
	返回值: 替代后的模板内容
*/
function returnReplaceNoteContents(str){
	var contents = str;
	var repTitle = delSpace(jQuery("#m_title").val());
	var repAddress = delSpace(jQuery("#m_address").val());
	var repTime = delSpace(jQuery("#m_begin_time").val())+"至"+delSpace(jQuery("#m_end_time").val());
	var strTitle = "【会议名称】";
	var strAddress = "【会议地点】";
	var strTime = "【会议时间】";
	contents = contents.replace(strTitle,repTitle);
	contents = contents.replace(strAddress,repAddress);
	contents = contents.replace(strTime,repTime);
	return (contents);	
}

/**********获取模板************/
  /*
         函数:  updateMeetingType
         说明:  修改
         参数:  无
         返回值: 无
     */
    var updateMeetingType = function() {
        openAlertWindows('showMeetingTemplate'
                ,getCurrentFilePath()+'meetingtemplatelist4noticechoose.jsp?windowId=showMeetingTemplate&orgId=<%=m_link_dept_id%>','会议模板列表',800,450,'10%','10%');
    }
    /**
     *模板列表页面调用的方法(由于数据列很多，列表加载出所有数据列效率太低，得到id以后再去查数据)
     *
     */
    var backTemplate = function(id){
        jQuery.ajax({ 
            type: "post", 
            url: "meetingtemplatedo.jsp", 
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data : {
                action : "query",
                id : id //要删除的id列表      
            },
            dataType: "json", 
            success: function (data) {    
                //执行成功,赋值
                if(data&&data.flag&&"true"==data.flag){
                    setAllValu(data.msg);  
                }
            }, 
            error: function (XMLHttpRequest, textStatus, errorThrown) { 
                alert("系统异常，请稍后再试！");
            }
         });
    }

  /**
   *选择模板以后的赋值操作
   */
   var setAllValu = function(tmp){
       jQuery("#m_title").val(deNull(tmp.m_title));
       //jQuery("#m_begin_time").val(deNull(tmp.m_begin_time)); hai.huang edit by 2013-08-22 调用模板时不设置时间 避免冲突
       //jQuery("#m_end_time").val(deNull(tmp.m_end_time));
       jQuery("#m_address").val(deNull(tmp.m_address));
       jQuery("#m_link_user_id").val(deNull(tmp.m_link_user_id));
       jQuery("#m_link_user_name").val(deNull(tmp.m_link_user_name));
       jQuery("#m_link_dept_id").val(deNull(tmp.m_link_dept_id));
       jQuery("#m_link_dept_name").val(deNull(tmp.m_link_dept_name));
       jQuery("#m_link_tel").val(deNull(tmp.m_link_tel));
       jQuery("#m_master_user_id").val(deNull(tmp.m_master_user_id));
       jQuery("#m_master_user_name").val(deNull(tmp.m_master_user_name));
       jQuery("#m_attender_count").val(deNull(tmp.m_attender_count));
       //jQuery("#m_close_time").val(deNull(tmp.m_close_time));
       jQuery("#m_contents").val(deNull(tmp.m_contents));
       jQuery("#m_receiver_unit_ids").val(deNull(tmp.m_receiver_unit_ids));
       jQuery("#m_receiver_user_ids").val(deNull(tmp.m_receiver_user_ids));
       //jQuery("#m_receiver_other_user_names").val(deNull(tmp.m_receiver_other_user_names));
       jQuery("#m_receiver_unit_names").val(deNull(tmp.m_receiver_unit_names));
       jQuery("#m_receiver_user_names").val(deNull(tmp.m_receiver_user_names));
       jQuery("#msg_contents").val(deNull(tmp.m_msg_contents));
       

       //设置会议类型类型选中
       jQuery("#m_type_id option").removeAttr("selected");//移除所有select框的选中
       jQuery("#m_type_id option[value="+deNull(tmp.m_type_id)+"]")
          .attr("selected","selected");
       //设置会议室选中
       jQuery("#m_room_id option").removeAttr("selected");
       jQuery("#m_room_id option[value="+deNull(tmp.m_room_id)+"]")
          .attr("selected","selected");
   	   replaceValue2Address();
   	   window.parent.hideshowButton();   
       
       
       //会议发送名义
       jQuery("#m_send_name option").removeAttr("selected");
       jQuery("#m_send_name option[value="+deNull(tmp.m_send_name)+"]")
          .attr("selected","selected");       

       /*是否需要 报名
        //默认是需要报名的，故默认值为1
        if(window.parent.jQuery("#isneedsignup").val()=="yes"){
        
	        var m_is_need_signup_value = ("" == deNull(tmp.m_is_need_signup)
	                                     ?"1":deNull(tmp.m_is_need_signup));
	
	        jQuery('input[name=m_is_need_signup][value="'+m_is_need_signup_value+'"]')
	          .removeAttr("checked").attr("checked","checked");
        }*/
       //短信发送方式多选框
       var msgType = deNull(tmp.m_msg_type).split(",");
       //由于提交的值是将两个多选框拼接成已“,”分割，故需截取字符串后再赋值
       for(var i=0;i<msgType.length;i++){
          jQuery(":checkbox[name*=m_msg_type][value="+msgType[i]+"]").removeAttr("checked").attr("checked","checked");
       }
       
       //单位列表
       jQuery("#deptTd").html("");
       createrDeptAndPosn({
           id:jQuery("#m_receiver_unit_ids").val(),
           name:jQuery("#m_receiver_unit_names").val()
       },"deptTd",'m_receiver_unit_ids','m_receiver_unit_names');      
       //人员列表
       jQuery("#userTd").val("");
       createrDeptAndPosn({ 
           id:jQuery("#m_receiver_user_ids").val(),
           name:jQuery("#m_receiver_user_names").val()},
           "userTd", 'm_receiver_user_ids','m_receiver_user_names',false,false,false,true);

   }

  
   /* 
   函数:  setValue4m_msg_contents
   说明:  事件响应方法设置短信模板
   */
   function setValue4m_msg_contents(id){
	var m_msg_contents=changemsg();
   	if(id=="model_id"){
   		jQuery("#msg_contents").val(m_msg_contents);
   	}else{
   		 if(jQuery("#"+id).attr("checked")=="checked"  ){
   			if(isSpace(jQuery("#msg_contents").val())){
   			jQuery("#msg_contents").val(m_msg_contents);//短信模板
 		}
   	}
   }
   }
  /**
   *处理空值
   */
   var deNull = function(value){
      if(!IsSpace(value)){
         return value;
      }else{
         return "";
      }
   }

   /**
    *获得所有需要提交的参数
    */
   function getAllValues(){
      var params = new Object();
      params["m_title"] = jQuery("#m_title").val();
      params["m_begin_time"] = jQuery("#m_begin_time").val();
      params["m_end_time"] = jQuery("#m_end_time").val();
      params["m_address"] = jQuery("#m_address").val();
      params["m_link_user_id"] = jQuery("#m_link_user_id").val();
      params["m_link_user_name"] = jQuery("#m_link_user_name").val();
      params["m_link_dept_id"] = jQuery("#m_link_dept_id").val();
      params["m_link_dept_name"] = jQuery("#m_link_dept_name").val();
      params["m_link_tel"] = jQuery("#m_link_tel").val();
      params["m_master_user_id"] = jQuery("#m_master_user_id").val();
      params["m_master_user_name"] = jQuery("#m_master_user_name").val();
      params["m_attender_count"] = jQuery("#m_attender_count").val();
      params["m_close_time"] = jQuery("#m_close_time").val();
      params["m_send_name"] = jQuery("#m_send_name").val();
      //params["m_contents"] = jQuery("#m_contents").val();
      params["m_receiver_unit_ids"] = jQuery("#m_receiver_unit_ids").val();
      params["m_receiver_user_ids"] = jQuery("#m_receiver_user_ids").val();
      //params["m_receiver_other_user_names"] = jQuery("#m_receiver_other_user_names").val();
      params["m_receiver_unit_names"] = jQuery("#m_receiver_unit_names").val();
      params["m_receiver_user_names"] = jQuery("#m_receiver_user_names").val();

      params["m_tmp_create_time"] = "<%=time %>";
      params["m_tmp_creator_id"] = "<%=userId %>";
      params["m_tmp_creator_name"] = "<%=userName%>";
      params["msg_contents"] = jQuery("#msg_contents").val();
      params["m_tmp_unit_id"] = "<%=orgId%>";
      params["m_tmp_unit_name"] = "<%=orgName%>";
      params["m_tmp_org_id"]=("<%=F_ORG_ID%>");
      params["m_tmp_org_name"]=("<%=F_ORG_NAME%>");
      
      params["m_type_id"] = jQuery("#m_type_id").val();
      //如果选中第一个option则不要
      params["m_type_name"] = jQuery("#m_type_id option[value='']~option:selected").text();
      params["m_room_id"] = jQuery("#m_room_id").val();
      params["m_room_name"] = jQuery("#m_room_id option[value='']~option:selected").text();
      params["m_send_name"] = jQuery("#m_send_name").val();
      //是否需要报名
      //params["m_is_need_signup"] = jQuery("input[name='m_is_need_signup']:checked").val();
      //短信发送方式
      var msgType = new Array();
      jQuery("input[name='m_msg_type']:checked").each(function(){         
          msgType.push(jQuery(this).val());
      });       
      params["m_msg_type"] = msgType.join(","); 
      return params;
   }

   /**
    *保存模板
    */
   function saveTmpAjax(){
       if(!checkData()){
         return;
       }
       //获得所有参数
       var param = getAllValues();
       param["action"] = "add";
       //ajax方式提交数据
       jQuery.ajax({
           type: "post", 
           url: "meetingtemplatedo.jsp", 
           contentType: "application/x-www-form-urlencoded; charset=utf-8",
           data : param,
           dataType: "json",
           success: function (data) {
               if(data&&data.msg){
                 alert(data.msg);
               }
           }, 
           error: function (XMLHttpRequest, textStatus, errorThrown) { 
               alert("出现异常，请稍后再试！");
           }
        });      
   }
   
   function onchangemsg(id){
	   if(jQuery("#is_sms").attr("checked")=="checked" || jQuery("#is_rtx").attr("checked")=="checked" || jQuery("#is_msg").attr("checked")=="checked" || jQuery("#is_mail").attr("checked")=="checked" ){
			var contents= changemsg();
			jQuery("#msg_contents").val(contents);
		}
	  }
   function changemsg(){
	   	var title=jQuery("#m_title").val();
		var address=jQuery("#m_address").val();
		var begin=jQuery("#m_begin_time").val();
		var end=jQuery("#m_end_time").val();
		var contents=jQuery("#m_msg_contents").val();
		if(!IsSpace(title)){
			contents=contents.replaceAll("【会议名称】","【"+title+"】");
		}
		if(!IsSpace(address)){
			contents=contents.replaceAll("【会议地点】","【"+address+"】");
		}
		if(!IsSpace(begin)){
			contents=contents.replaceAll("【开始时间】","【"+begin+"】");
		}
		if(!IsSpace(end)){
			contents=contents.replaceAll("【结束时间】","【"+end+"】");
			
		}
		return contents;
   }
   //如果在基础信息中的与会人员为空,则取与会人员列表中的人数填入
   function addyhr(){
	   var n= jQuery("#userTd").val().split(";");
	   var yhr=0;
	   for(var i=0;i<n.length-1;i++){
		   temp=n[i].split(",");
		   yhr=yhr*1+temp.length*1;
	   }
	   var m_attender_count= jQuery("#m_attender_count").val();
	   if(m_attender_count.length==0 && yhr.length!=0){
		   jQuery("#m_attender_count").val(yhr);
	   }
   }
</script>
</head>
<body>
<form action="" id="form1" name="form1" method="post" >
<textarea style="display: none" name="m_msg_contents" id="m_msg_contents"  > <%=m_msg_contents %></textarea>
<div id="maindiv" class="vcenter" style="height:500px; overflow:auto;">
	<div style="float: left; width: 990px;">
		<div class="content_02_box" style="width: 990px;">
			<div class="content_02_box_title_bg" style="width: 98%;">
				<span>会议基本信息</span>
				<div class="content_02_box_add show_content" style="cursor: hand;">
					<!-- <span onclick="displaymore()">显示全部</span> 
				    <em id="imgdiv" onclick="displaymore()" class="up_d">&nbsp;</em> -->
				</div>
			</div>
			<div class="content_02_box_div" style="width: 98%;">
				<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width: 100%;">
					<tr>
						<th class="content_02_box_div_table_th" style="width:150px">
							<span class="color_red">*</span>会议标题：
						</th>
						<td class="content_02_box_div_table_td" colspan="5" id ="p_title_test_id">
							<input value="<%=m_title %>"  type="text" class="validate[required,maxSize[100]] input_cx_title_240 m_title" style="width:753px;height:24px;" name="m_title" id="m_title"  onblur="onchangemsg(this.id)"/>
						    <input name="chose_notice_button" id="chose_notice_button"
                                   type="button"  class="but_x" style="display:block;" onclick="updateMeetingType();"/>
						    
						</td>
					</tr>
					<tr>
						<th  class="content_02_box_div_table_th" style="width:150px">
							会议室：
						</th>
						<td class="content_02_box_div_table_td"><%=roomselectHtml %></td>
						<th width="200px" class="content_02_box_div_table_th">
							<span class="color_red">*</span>会议地点：
						</th>
						<td class="content_02_box_div_table_td"  colspan="3" id ="p_title_test_id">
							<input value="<%=m_address %>" type="text" class="validate[required,maxSize[80]] input_cx_title_240 m_title" style="width:465px;" value="" name="m_address" id="m_address"  onblur="onchangemsg(this.id)"/>	
						</td>
					</tr>
					<tr>	
						<th class="content_02_box_div_table_th"   style="width:150px"><span class="color_red">*</span>会议开始时间：</th>
						<td class="content_02_box_div_table_td" id ="p_title_test_id">
							<input class="validate[required] date_120 Wdate m_title"
									type="text" id="m_begin_time" name="m_begin_time" onblur="onchangemsg(this.id)"
									onfocus="WdatePicker({onpicked:function(){checkMeetingRoomOccupancy(this);changeM_close_time(this);},maxDate:'#F{$dp.$D(\'m_end_time\')}',dateFmt:'yyyy-MM-dd HH:mm'})" />
						</td>
						<th class="content_02_box_div_table_th"  style="width:150px"><span class="color_red">*</span>会议结束时间：</th>
						<td class="content_02_box_div_table_td" id ="p_title_test_id">
							<input class="validate[required] date_120 Wdate m_title"
									type="text" id="m_end_time" name="m_end_time" onblur="onchangemsg(this.id)"
									onfocus="WdatePicker({onpicked:function(){checkMeetingRoomOccupancy(this)},minDate:'#F{$dp.$D(\'m_begin_time\')}',dateFmt:'yyyy-MM-dd HH:mm'})" />
									
						</td>
						<th class="content_02_box_div_table_th"  style="width:150px"></th>
						<td class="content_02_box_div_table_td" style="width:150px">&nbsp;
						</td>
					</tr> 
					<tr  id="more" style="display: none">
						<th class="content_02_box_div_table_th"><span class="color_red">*</span>联系部门：</th>
						<td class="content_02_box_div_table_td" >
							<input type="text"   name="m_link_dept_name" id="m_link_dept_name"   class="validate[required,maxSize[50]] input_cx_title_120" style="width:133px"/>
							<input type="hidden" name="m_link_dept_id" id="m_link_dept_id" readonly />
						</td>
						<th class="content_02_box_div_table_th"><span class="color_red">*</span>联系人：</th>
						<td class="content_02_box_div_table_td" >
							<input type="hidden" name="m_link_user_id" id="m_link_user_id" class="validate[required]" />
						    <input type="text" id="m_link_user_name" name="m_link_user_name" class="validate[required] xz_89_border"  
						    onclick="chooseActUsers('m_link_user_id','m_link_user_name','m_link_dept_name','radio')" />
						   <!--  <input name="chose_notice_button" id="chose_notice_button"
                                   type="button"  class="but_x" style="display:block;" onclick="chooseActUsers('m_link_user_id','m_link_user_name','m_link_dept_name','radio')"/>	
 -->						</td>
						<th class="content_02_box_div_table_th">联系电话：</th>
						<td class="content_02_box_div_table_td" >
							<input type="text"   name="m_link_tel" id="m_link_tel" value="" class="validate[custom[onlyNumberSp],maxSize[50]] input_cx_title_120" />
						</td>
					</tr>
					<tr id="more" style="display: none">
						<th class="content_02_box_div_table_th">会议类型：</th>
						<td class="content_02_box_div_table_td" ><%=mtypeselectHtml %></td>
						<th class="content_02_box_div_table_th">主持人：</th>
						<td class="content_02_box_div_table_td" >
							<input type="hidden" name="m_master_user_id" id="m_master_user_id" value=""  />
						    <input type="text" id="m_master_user_name" name="m_master_user_name" class="xz_89_border" 
						    	value="" onclick="chooseActUsers('m_master_user_id','m_master_user_name','','radio')" />
						</td>
						<th class="content_02_box_div_table_th">与会人数：</th>
						<td class="content_02_box_div_table_td" >
							<input type="text"   name="m_attender_count" id="m_attender_count" value="" class="validate[custom[onlyNumberSp],maxSize[50]] input_cx_title_120" />
						</td>
					</tr>
					<tr id="more" style="display: none">
						<th class="content_02_box_div_table_th">发送名义：</th>
						<td class="content_02_box_div_table_td" >
							<select name ="m_send_name" id= "m_send_name" size ="1"  class ="select_100_box_type" style="width:180px">
                                <option value ="" >---请选择---</option>
                                <option value ="0" >单位名义发送</option>
                                <option value ="1" >个人名义发送</option>
                            </select>
						</td>
						<!--
						<th class="content_02_box_div_table_th"><span id="isneedsignup" style="display: none">是否需要报名：</span></th>
						<td class="content_02_box_div_table_td" >
							<input type="radio" value="0" name="m_is_need_signup" id="m_is_need_signup0" checked="checked" style="display: none" />
							<span id="isneedsignup" style="display: none">否 &nbsp;&nbsp;</span>
							<input type="radio" value="1" name="m_is_need_signup" id="m_is_need_signup1" style="display: none"/>
							<span id="isneedsignup" style="display: none">是</span>
						</td>  -->
						<th class="content_02_box_div_table_th"><span id="isneedsignup" >报名截止时间：</span></th>
						<td class="content_02_box_div_table_td" >
							<input class="date_120 Wdate"
									type="text" id="m_close_time" name="m_close_time"
									onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'m_begin_time\')}',dateFmt:'yyyy-MM-dd HH:mm'})" />
						</td>
						
					</tr>
					<tr  id="more" style="display: none">
						<th class="content_02_box_div_table_th" >备注：</th>
						<td class="content_02_box_div_table_td" colspan="5">
							<textarea value="<%=m_remark %>" id="m_remark" name="m_remark" class="validate[maxSize[500]] textarea_575" cols="110" rows="2" ></textarea>
						</td>
					</tr> 
				</table>
			</div>
			<!-- 与会单位与人员 begin -->
			<div class="content_02_box_title_bg" style="width: 98%;">
				<span>与会单位与人员</span>
				<div class="content_02_box_add show_content" style="cursor: hand">
					<!-- <input type="button" value="选择" class="but_six" onclick="adddeptandusernew()" /> -->
				</div>
			</div>
			<div class="content_02_box_div" style="width: 98%;">
				<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width: 100%;">
					<tr>
						<th class="content_02_box_div_table_th" style="width:200px;">与会单位列表：
							<input type="hidden" id="m_receiver_unit_ids" name="m_receiver_unit_ids" value="" />
							<input type="hidden" id="m_receiver_unit_names" name="m_receiver_unit_names" value="" />
						</th>
						<td class="content_02_box_div_table_td" id="deptTd" colspan="5" >
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th" style="width:200px;">与会人员列表：
						</th>
						<td class="content_02_box_div_table_td" colspan="5">
							<input type="hidden" id="m_receiver_user_ids" name="m_receiver_user_ids" value="" />
							<input type="hidden" id="m_receiver_user_names" name="m_receiver_user_names" value="" />
							<textarea id="userTd" name= "userTd"  onclick='adddeptandusernew()'  class="validate[maxSize[5000]] textarea_575" cols="80" rows="2" readonly="readonly"></textarea>
						</td>
					</tr>
				</table>
			</div>
			
			<!-- 选择其他单位与会人员 -------begin----------------------------------------------------------------- -->
			<div class="content_02_box_title_bg" style="width: 98%;">
				<span>其他单位与会人员</span>
				<div class="content_02_box_add show_content" style="cursor: hand">
					<!-- <input type="button" value="选择" class="but_six" onclick="adddeptanduser4Other()" /> -->
				</div>
			</div>
			<div class="content_02_box_div" style="width: 98%;">
				<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width: 100%;">
					<tr>
						<th class="content_02_box_div_table_th" style="width:200px;" rowspan=2>其他单位与会人员列表：</th>
						<td class="content_02_box_div_table_td" colspan="5">填写格式为:[姓名:手机号码];
							<input type="hidden" id="m_receiver_other_unit_ids"   name="m_receiver_other_unit_ids" value="" />
							<input type="hidden" id="m_receiver_other_unit_names" name="m_receiver_other_unit_names" value="" />
							<input type="hidden" id="m_receiver_other_user_ids"   name="m_receiver_other_user_ids"   value="" />
							<input type="hidden" id="m_receiver_other_user_names" name="m_receiver_other_user_names" value="" ></input>
							<!-- <textarea id="userTd4Other" name= "userTd4Other"  class="validate[maxSize[5000]] textarea_575" cols="80" rows="2" readonly="readonly"  onclick="adddeptanduser4Other()"></textarea> -->
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_td" colspan="5"><!-- 手工输入 -->
							<textarea <%=m_other_user_input %> id="m_other_user_input" name="m_other_user_input"  class="validate[maxSize[500]] textarea_575" cols="80" rows="2" ></textarea>
						</td>
					</tr>
				</table>
			</div>
			<!-- end--------------------------------------------------------------------------------------------------------- -->
					
			<!-- 与会单位与人员 end -->
			<!-- 消息提醒begin -->
			<%if("1".equals(is_pub_sms) || "1".equals(is_pub_rtx) || "1".equals(is_pub_msg) || "1".equals(is_pub_mail)){ %>
			<div class="content_02_box_title_bg" style="width: 98%;">
				<span>消息提醒</span>
			</div>
			<input type="hidden" id="m_id" name="m_id" value="" />
			<input type="hidden" id="" name="" value="" />
			<div class="content_02_box_div" style="width: 98%;">
				<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width: 100%;">
					<tr>
						<th class="content_02_box_div_table_th"  style="width:200px;">提醒方式：</th>
						<td class="content_02_box_div_table_td" colspan="3">
							<%if("1".equals(is_pub_sms)){ %>
							<input name="m_msg_type" id="is_sms" type="checkbox"  checked="checked" value="" onclick="setValue4m_msg_contents(this.id);" />&nbsp;短信
							&nbsp;<%} %>
							<%if("1".equals(is_pub_mail)){ %>
							<input name="m_msg_type" id="is_mail" type="checkbox" onclick="setValue4m_msg_contents(this.id);"  value="" />&nbsp;邮件&nbsp;
							<%} if("1".equals(is_pub_rtx)){%>
							<input name="m_msg_type" id="is_rtx" type="checkbox"  onclick="setValue4m_msg_contents(this.id);" value="" />&nbsp;即时信息&nbsp;
							<%} if("1".equals(is_pub_msg)){%>
							<input name="m_msg_type" id="is_msg" type="checkbox"  checked="checked" onclick="setValue4m_msg_contents(this.id);" value="" />&nbsp站内信息&nbsp;
							<%} %>
							<span style="float:right;display:block;width: 100px" id="model_id" onclick="setValue4m_msg_contents(this.id);">使用默认模版</span>
							<input type="hidden" id="is_sms"   name="is_sms" value="" />
							<input type="hidden" id="is_mail"   name="is_mail" value="" />
							<input type="hidden" id="is_rtx"   name="is_rtx" value="" />
							<input type="hidden" id="is_msg"   name="is_msg" value="" />
							
						</td>
						<th class="content_02_box_div_table_th" style="display: none" id="title_m_is_need_resignup-th" ><span id="title_m_is_need_resignup">是否需要重新报名：</span></th>
						<td class="content_02_box_div_table_td" style="display: none" id="title_m_is_need_resignup-td">
							<input type="radio" value="0" id="m_is_need_resignup"  name="m_is_need_resignup" checked="checked" />
							否 &nbsp;&nbsp;
							<input type="radio" value="1" id="m_is_need_resignup"  name="m_is_need_resignup"  />
							是
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th" >提醒内容：</th>
						<td class="content_02_box_div_table_td" colspan="5">
							<textarea id="msg_contents" name="msg_contents" class="validate[maxSize[300]] textarea_575" cols="110" rows="2" ><%=msg_contents%></textarea>
						</td>
					</tr>
				</table>
				<table border="0" cellspacing="0" cellpadding="0"><tr><td height=50></td></tr></table>
			</div>
			<%} %>
			<!-- 消息提醒end -->
		</div>
	</div>
	<input type="hidden" name="m_notice_id" id="m_notice_id" value="<%=m_notice_id %>" />
	<input type="hidden" name="m_contents_value" id="m_contents_value" value="<%=m_contents %>" />
	<input type="hidden" name="m_djbh" id="m_djbh" value="<%=m_djbh %>" />
	<input type="hidden" name="m_check_flag" id="m_check_flag" value="<%=m_check_flag %>" />
	<input type="hidden" name="m_check_flag_name" id="m_check_flag_name" value="<%=m_check_flag_name %>" />
	<input type="hidden" name="strSum" id="strSum" value="" />
	<input type="hidden" id="createuser" value="<%=m_create_user_id %>" />
</div>
</form>
</body>
</html>