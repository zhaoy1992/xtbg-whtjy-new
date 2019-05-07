<%--
describe:查看会议通知
author:dailianchun
date: 2013-6-27
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String frompagehome = StringUtil.deNull(request
			.getParameter("frompagehome"));//来自首页要控制返回的页面
	String path = request.getContextPath();
	String m_receiver_user_id = StringUtil.deNull(request
			.getParameter("m_receiver_user_id"));//from wait read 2013-08-05
	String m_receiver_id = StringUtil.deNull(request
			.getParameter("m_receiver_id"));
	String m_notice_id = StringUtil.deNull(request
			.getParameter("m_notice_id"));
	String issaved = StringUtil.deNull(request.getParameter("issaved"));
	String m_check_flag = StringUtil.deNull(request
			.getParameter("m_check_flag"));//当前操作会议的状态
	String m_check_flag_name = StringUtil.deNull(request
			.getParameter("m_check_flag_name"));//当前操作会议的状态name
	String administrator_ids = StringUtil.deNull(request
			.getParameter("administrator_ids"));//会议室管理员ids
	String m_reg_user_id = StringUtil.deNull(request
			.getParameter("m_reg_user_id"));
	String m_reg_user_name = StringUtil.deNull(request
			.getParameter("m_reg_user_name"));
	String windowId = request.getParameter("windowId");//窗口id   
	String m_close_time = request.getParameter("m_close_time");
	String m_is_other = request.getParameter("m_is_other");//为1时不能回复
	//会议通知service
	MeetingHandleServiceIfc service = new MeetingHandleServiceImpl();
	Map<String, String> bean = null;
	//如果传入了id，则查询出会议纪要对象
	if (!StringUtil.nullOrBlank(m_notice_id)) {
		bean = service.getMeetingNoticeBean(m_notice_id);
		//将会议开始时间的秒截取掉
		String beginTime = StringUtil.deNull(bean.get("m_begin_time"));
		bean.put("m_begin_time",
				beginTime.substring(0, beginTime.length() - 3));
		String endTime = StringUtil.deNull(bean.get("m_end_time"));
		bean.put("m_end_time",
				endTime.substring(0, beginTime.length() - 3));
		//from wait read 2013-08-05 add begin ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		if (!StringUtil.nullOrBlank(m_receiver_user_id)) {
			Map<String, String> map = new HashMap<String, String>();
			map = (HashMap<String, String>) service
					.getMeetingNoticeInfo(m_notice_id,
							m_receiver_user_id);
			m_receiver_id = StringUtil.deNull(map.get("m_receiver_id"));
			m_check_flag = StringUtil.deNull(map.get("m_check_flag"));
			m_check_flag_name = StringUtil.deNull(map
					.get("m_check_flag_name"));
			administrator_ids = StringUtil.deNull(map
					.get("administrator_ids"));
			m_reg_user_id = StringUtil.deNull(map.get("m_reg_user_id"));
			m_reg_user_name = StringUtil.deNull(map
					.get("m_reg_user_name"));
			m_close_time = StringUtil.deNull(map.get("m_close_time"));
			m_is_other = StringUtil.deNull(map.get("m_is_other"));
		}
		//from wait read end ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

		service.updateReadInfo(m_receiver_id);
	} else {
		bean = new HashMap<String, String>();
	}

	String m_is_need_signup = StringUtil.deNull(request
			.getParameter("m_is_need_signup"));
	String timesupflag = StringUtil.deNull(request
			.getParameter("timesupflag"));
	String currentTime = DateUtil.getFormatTime(new Date());
%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript"src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<script  src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js"></script>
<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js"></script>

<script type="text/javascript">
var m_is_other   = "<%=m_is_other%>";
var frompagehome = "<%=frompagehome%>";
var id           = "<%=m_notice_id%>";
var windowId     = "<%=windowId%>";
var m_close_time = "<%=m_close_time%>";
//附件id
var m_attach_id  = "<%=bean.get("m_djbh")%>";

//系统根路径
var path         = "<%=path%>";
jQuery(function() {
  if (m_is_other == "1") {
    jQuery("#showDetail").hide();
    jQuery("#reply").hide();
  }
  //附件
  MyFancyupload.createUpload('_fileshow', '_filebut', path, path + '/servlet/pubFileUpload?buessid=' + m_attach_id, false, m_attach_id, '', '', '001');
  var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight"); //设高度适配滚动条
  jQuery("#maindiv").height(_documentBodyHeight - 100);
});
/*
函数:  openReply
说明:  报名回复操作
*/
function openReply() {
  var m_is_need_signup = "<%=m_is_need_signup%>";
  var timesupflag = "<%=timesupflag%>";
  if (timesupflag == "yes") { //是否需要报名 为否/0时
    alert("注意：会议已过期！");
    return;
  }
  if (m_is_need_signup == "0") { //是否需要报名 为否/0时
    alert("注意：该会议无需报名！");
    return;
  }
  //var currentTime = getLocalDate()+" "+getNowTime();  改为取服务器当前时间
  var currentTime = "<%=currentTime%>";
  if (!isSpace(m_close_time) && currentTime > m_close_time) {
    alert("报名不成功！会议报名截止时间已过！");
      return;
  }

  var url = getCurrentFilePath() + "meetingnoticereply.jsp?reply=1&m_notice_id=<%=m_notice_id%>";
  openAlertWindows('windowId', url, '报名回复操作', '950', '500', '5%', '5%');
}

/**
 * 关闭弹出框
 */
function tomainjsp() {
  if (frompagehome == "1") {
    window.location = "../../notice/jsp/noticeandmeetingviewlist.jsp?welfrom=1";
  } else {
    window.location = "meetingviewmain.jsp";
  }
}
/**
 * 查看详情
 */
function showDetail() {
  var m_notice_id = "<%=m_notice_id%>";
  var issaved = "<%=issaved%>";
  var m_check_flag = "<%=m_check_flag%>"; //当前操作会议的状态
  var m_check_flag_name = "<%=m_check_flag_name%>"; //当前操作会议的状态name
  var administrator_ids = "<%=administrator_ids%>"; //会议室管理员ids
  var m_reg_user_id = "<%=m_reg_user_id%>";
  var m_reg_user_name = "<%=m_reg_user_name%>";

  var m_close_time = "<%=m_close_time%>"
  var m_is_need_signup = "<%=m_is_need_signup%>";
  var timesupflag = "<%=timesupflag%>";

  openWindows('showDetail_meetingnotice', '查看会议通知', "meetingnoticetab.jsp?frompagehome=" + frompagehome + "&issaved=doview&m_notice_id=" + m_notice_id + "&m_check_flag=" + m_check_flag + "&m_check_flag_name=" + m_check_flag_name + "&m_reg_user_id=" + m_reg_user_id + "&m_reg_user_name=" + m_reg_user_name + "&m_close_time=" + m_close_time + "&m_is_need_signup=" + m_is_need_signup + "&timesupflag=" + timesupflag, 'showDetail_meetingnotice', false, window);
}
/**
 * 模板短信生成
 */
function returnReplaceNoteContents(str) {
  var contents = str;
  var repTitle = "<%=bean.get("m_title ")%>";
  var repAddress = "<%=bean.get("m_address ")%>";
  var repTime = "<%=bean.get("m_begin_time ")%>至<%=bean.get("m_end_time ")%>";
  var strTitle = "【会议名称】";
  var strAddress = "【会议地点】";
  var strTime = "【会议时间】";
  contents = contents.replace(strTitle, repTitle);
  contents = contents.replace(strAddress, repAddress);
  contents = contents.replace(strTime, repTime);
  return (contents);
}
</script>
</head>
<body>

    <div class="content_02" style="overflow: hidden;" id="_top">
        <div class="content_02_top" style="margin-bottom: 10px;">
            <input id="showDetail" name="showDetail" value="查看详情" onclick="showDetail();" type="button" class="but_y_01"/>
            <input id="reply" name="reply" value="报名回复" onclick="openReply()" type="button" class="but_y_01" />
            <input name="" value="返回" onclick="tomainjsp()" type="button" class="but_y_01" />
        </div>
    </div>
    
    <!-- 表格-->
    <div id="maindiv" class="vcenter" style="overflow:auto;">
        
        <div id="myDiv" style="float: center; width: 100%">
            <table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table"  style="float: center; width: 100%">
                <tr>
                    <td colspan="2" height="50" valign="middle"  style="padding-top:5px;font-weight: bolder;font-size:28px; color:red;text-align:center;">
                        <%=bean.get("m_title")%>             
                    </td>
                </tr>
				<tr>
					<td align="left" width=70% style="text-align: left;padding-left:5px;"><font size=3>会议召开时间： <%=bean.get("m_begin_time") + " 至  " + bean.get("m_end_time")%></font></td>
					<td align="right"  width=30% style="text-align: right;padding-right:5px;"><font size=3>会议召开地点：<%=bean.get("m_address")%></font></td>
				</tr>
				<tr>
                   <td colspan="2" width="100%" style="height:3px;background:red">
                                                        
                   </td>
               </tr>               
               
               <tr>
                   <td colspan="2" style="padding:20px 20px 20px 20px;"><font size=3 family='FangSong_GB2312'>
                       <%=bean.get("m_contents")%></font>
                   </td>
               </tr> 
               <tr>
                   <td colspan="2" width="100%" style="height:3px;background:red">
                                                        
                   </td>
               </tr>   
                
                <tr>
                    <th width="10%" class="content_02_box_div_table_td" style="padding-left:10px;border:0px;" valign="top">
                    <!-- 上传按钮不需要显示，隐藏的话，控件会报错，故设置为非常小 -->
                    <a href="#" id="_filebut" style="width:1px;height:0px;"></a>
                                                        附件：</th>
                    <td width="90%" class="content_02_box_div_table_td" style="border:0px;text-align:left;">
                       
                       <div  id="_fileshow"></div>
                       &nbsp;
                    </td>
                </tr>
            </table>                
        </div>  
    </div>

</body>
</html>