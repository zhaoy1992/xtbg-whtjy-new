<%--
描述：考勤【分院班子成员】请假表单
作者：夏天
版本：1.0
日期：2014-03-10
--%>
<%@page import="com.chinacreator.xtbg.core.directory.constant.DirectoryConstant"%>
<%@page import="com.chinacreator.xtbg.core.directory.entity.DirectoryBean"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.directory.dao.DirectoryDao"%>
<%@page import="antlr.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	//当前用户信息
	String user_id = accesscontroler.getUserID();
	String user_name = accesscontroler.getUserName();
	
	//当前用户机构
	String org_id = accesscontroler.getChargeOrgId();
	String orgName = accesscontroler.getChargeOrgName();
	
	//录入时间
	String r_creater_time = DateUtil.getCurrentDateTime();

	//主键ID
	String busi_id  = StringUtil.deNull(request.getParameter("busi_id"));
	
	//环节ID
	String action_defid = StringUtil.deNull(request.getParameter("action_defid"));
	
	//取从start传过来的值
	String operType = StringUtil.deNull(request.getParameter("operType"));
	
	//业务类型code
	String busiTypeCode = StringUtil.deNull(request.getParameter("busiTypeCode"));
	
	//正文ID
	String document_id = UUID.randomUUID().toString();
	
	// 选择设备按钮控制
	String buttonString = "fasle";
	//新增启动第一次的时候  默认设置为第一个环节
/* 	if(action_defid.equals("")){
		action_defid="bmfzyldqj_wp1_act5";
		buttonString = "true";
	} */
	
	//跳转windowId
	String windowsId = StringUtil.deNull(request.getParameter("windowsId"));
	DirectoryDao directoryDao = (DirectoryDao) LoadSpringContext
			.getApplicationContext().getBean("directoryDaoImpl");
	DirectoryBean directoryBean = directoryDao.getTypeBeanById(user_id,"view");
	
%>
<!-- 公共部分开始 -->
<title>设备借用归还界面</title>
	<oa:init>
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<script type='text/javascript' src='<%=path %>/ccapp/oa/resources/plug/jquery-media/jquery.media.js' charset="utf-8"></script>
	<script type='text/javascript' src='<%=path %>/ccapp/xtbg/tjy/attendancemanage/resources/attendancemanage.js' charset="utf-8"></script>
	<script type="text/javascript">
	//环节ID
	var action_defid="<%=action_defid%>";
	var path = "<%=path%>";
	  jQuery(function(){
		   //设置请假事由的焦点
		   jQuery("#TA_OA_ATTENDANCELEAVE__T_TITLE").focus();
    		//控制按钮 只有在新增的流程时才显示
	    	if('fasle' == '<%=buttonString%>'){      
	    		jQuery("#btn").hide();
	    	}
    		if(!jQuery("#TA_OA_ATTENDANCELEAVE__T_DEPART_NAME").val()){
    			jQuery("#TA_OA_ATTENDANCELEAVE__T_DEPART_NAME").val("<%=orgName%>")
    			jQuery("#TA_OA_ATTENDANCELEAVE__T_DEPART_ID").val("<%=org_id%>")
    		}
    		if(!jQuery("#TA_OA_ATTENDANCELEAVE__T_NAME").val()){
    			jQuery("#TA_OA_ATTENDANCELEAVE__T_NAME").val("<%=user_name%>")
    			jQuery("#TA_OA_ATTENDANCELEAVE__T_USER_ID").val("<%=user_id%>")
    		}
    		if(!jQuery("#TA_OA_ATTENDANCELEAVE__T_ZW").val()){
    			jQuery("#TA_OA_ATTENDANCELEAVE__T_ZW").val("<%=DirectoryConstant.parsePost(directoryBean.getPost(), true)%>")
    		}
 
	    });
	  /**
	  *计算请假时间
	  */
	  function mathLeaveDays(){
		  if(jQuery("#TA_OA_ATTENDANCELEAVE__T_STARTTIME").val() && jQuery("#TA_OA_ATTENDANCELEAVE__T_ENDTIME").val()){
			  var start_time = getFormatterDate(jQuery("#TA_OA_ATTENDANCELEAVE__T_STARTTIME").val());
			  var end_time = getFormatterDate(jQuery("#TA_OA_ATTENDANCELEAVE__T_ENDTIME").val());
			  var start_date= new Date(Date.parse(start_time.replace(/-/g,  "/")));  
			  var end_date= new Date(Date.parse(end_time.replace(/-/g,  "/")));  
			  var days = start_date.dateDiff("d",end_date);
			  var  type =jQuery("#TA_OA_ATTENDANCELEAVE__T_TYPE").val();
			  if(type=="年休假"){
				  var day = days+1;
				  queryHolidayTimes(day,start_time,end_time);  
			  } else {
				  jQuery("#TA_OA_ATTENDANCELEAVE__T_LEAVETIMES").val(days+1);
			  }
		  }
	  }
	
	</script>

</head>
<body>
<form id="form1" name="form1" action="" method="post" >
	<input type="hidden" id="opt_type"     name="opt_type" /> 
	<input type="hidden" id="busi_id"  name="busi_id"  value="<%=busi_id %>" /> 
	<input type="hidden" id="busiTypeCode" name="busiTypeCode"  value="<%=busiTypeCode%>"/>
	<input type="hidden" id="action_defid" name="action_defid"  value="<%=action_defid%>"/>
	<oa:date dateFmt='yyyy-MM-dd HH:mm:ss'   column="T_CREATE_TIME" table="TA_OA_ATTENDANCELEAVE" other="class='Wdate' style='display:none'" defaultValue="sysDate"/>
	<input id="windowsId" name="windowsId" type="hidden" value="<%=windowsId%>"/>
	<%--<input value="com.chinacreator.xtbg.tjy.device.dao.Impl.DevborrowFlowDaoImpl" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" 
	name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" type="hidden"/>业务--%>

<div id="tabs1" style="width:90%">
	<div id="tabs-1">
		<table width="95%" border="0" cellspacing="1" cellpadding="0"
			style="margin-left: 15px; margin-right: 15px; display: inline;">
			<tr>
				<td><oa:flowcommonstart flowType="1" />
				</td>
			</tr>
			<tr>
			<td style="padding-bottom: 10px;">
	<%-- 主表单 begin---%>
	<div class="vcenter" style="float: left; overflow-x: hidden;" scrolling="yes">
			<div style="float: left; width: 996px;">
			<%--shang--%>
			<div class="content_02_box" style="width:996px;">
				<div class="content_02_box_title_bg" style="width: 98%;">
					<span>请假申请单</span>
				</div>
				<div class="content_02_box_div" style="width: 996px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 98%;">
						<tr><%--row1--%>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red" id="bt_id" >*</FONT>部门/科室：</th>
							<td class="content_02_box_div_table_td" >
								<oa:input type="hidden" column="T_DEPART_ID" table="TA_OA_ATTENDANCELEAVE"  />
								<oa:input
										type="text" column="T_DEPART_NAME" table="TA_OA_ATTENDANCELEAVE"
										other="class='input_title_text validate[required,maxSize[50]]' readonly='readonly'" />
							</td>
							<th class="content_02_box_div_table_th">职务：</th>
							<td class="content_02_box_div_table_td" >
								<oa:input
										type="text" column="T_ZW" table="TA_OA_ATTENDANCELEAVE"
										other="class='input_title_text validate[maxSize[50]]'"  />
							</td>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red" id="bt_id" >*</FONT>姓名：</th>
							<td class="content_02_box_div_table_td" >
								<oa:input type="hidden" column="T_USER_ID" table="TA_OA_ATTENDANCELEAVE"  />
								<oa:input
										type="text" column="T_NAME" table="TA_OA_ATTENDANCELEAVE"
										other="class='input_title_text validate[required,maxSize[50]]' readonly='readonly'"  />
							</td>
						</tr>
						<tr>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red" id="bt_id" >*</FONT>请假类别：</th>
							<td class="content_02_box_div_table_td" colspan="5">
								<oa:select column="T_TYPE" table="TA_OA_ATTENDANCELEAVE"
								optionsql="select ' ' as T_TYPE,'--请选择--' as typemc  from dual  union
								           select '年休假' as T_TYPE,'年休假' as typemc  from dual  union
										   select '婚假' as T_TYPE,'婚假' as typemc  from dual union
										   select '工伤假' as T_TYPE,'工伤假' as typemc  from dual union
										   select '产假' as T_TYPE,'产假' as typemc  from dual union
										   select '计划生育假' as T_TYPE,'计划生育假' as typemc  from dual union
										   select '病(伤)假' as T_TYPE,'病(伤)假' as typemc  from dual union
										   select '事假' as T_TYPE,'事假' as typemc  from dual union
										   select '公差假' as T_TYPE,'公差假' as typemc  from dual union
										   select '丧假' as T_TYPE,'丧假' as typemc  from dual union
										   select '学习培训假' as T_TYPE,'学习培训假' as typemc  from dual" style="width: 160px;"
										   initDefautValue="" defautValue="" other="class='validate[required]' onchange='mathLeaveDays()'"></oa:select>
							</td>
						</tr>
						<tr>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red" id="bt_id" >*</FONT>请假事由：</th>
							<td class="content_02_box_div_table_td" colspan="5">
								<oa:input
										type="text" column="T_TITLE" table="TA_OA_ATTENDANCELEAVE"
										other="class='input_title_text validate[required,maxSize[50]]'"  />
							</td>
						</tr>
						<tr>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red" id="bt_id" >*</FONT>请假时间：</th>
							<td class="content_02_box_div_table_td" colspan="5">
								自<oa:date dateFmt='yyyy-MM-dd'  style="float:none" column="T_STARTTIME" table="TA_OA_ATTENDANCELEAVE" 
									other="class='date_120 Wdate validate[required]' onfocusout=mathLeaveDays()" maxDate="#F{$dp.$D(\\'TA_OA_ATTENDANCELEAVE__T_ENDTIME\\')||\\'2099-12-12\\'}" />
								至<oa:date dateFmt='yyyy-MM-dd'  style="float:none" column="T_ENDTIME" table="TA_OA_ATTENDANCELEAVE" 
									other="class='date_120 Wdate validate[required]' onfocusout=mathLeaveDays()"  minDate="#F{$dp.$D(\\'TA_OA_ATTENDANCELEAVE__T_STARTTIME\\')||\\'1980-01-01\\'}"/>
								总共请假<oa:input
										type="text" column="T_LEAVETIMES" style="float:none;text-align:center;" table="TA_OA_ATTENDANCELEAVE"
										other="class='input_66 validate[required,maxSize[50]]' readonly='readonly'"  />
								天
							</td>
						</tr>
						<tr>
							<th class="content_02_box_div_table_th">人力资源部(综合办公室)审查意见：</th>
							<td class="content_02_box_div_table_td" colspan="5">
								<oa:view column="T_HUMANRESOURCE_IDEA" table="TA_OA_ATTENDANCELEAVE" 
								style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
							</td>
						</tr>	
						<tr>
							<th class="content_02_box_div_table_th">院长意见：</th>
							<td class="content_02_box_div_table_td" colspan="5">
								<oa:view column="T_PRESIDENT_IDEA" table="TA_OA_ATTENDANCELEAVE" 
								style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
							</td>
						</tr>	
						<tr>
							<th class="content_02_box_div_table_th">销假记录：</th>
							<td class="content_02_box_div_table_td" colspan="5">
								<oa:view column="T_REMOVELEAVE_LOG" table="TA_OA_ATTENDANCELEAVE" 
								style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
							</td>
						</tr>						
						
					</table>
				</div>
			</div>
	</div>
</div>	
</td>
</tr>
</table>
</div>
</div>
	
</form>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
<script language="javascript" type="text/javascript">
     var LODOP; //声明为全局变量 
     /*
   	函数:  changeSelect
   	说明:  选择下一步 隐藏
   	参数:   无
   	返回值: 无
   	*/
   	function changeSelect(action_defid,selectAct){
	 	//-------分院班子成员  流程-------
		//1.分院综合办公室审核
		if(!IsSpace(action_defid)&&action_defid=="bzcyqj_wp1_act2"){
			selectAct.find("option[value=bzcyqj_wp1_act3]").attr("selected","selected").change();
			selectAct.find("option[value=bzcyqj_wp1_act1]").remove();
		} else if(!IsSpace(action_defid)&&action_defid=="bzcyqj_wp1_act3"){//分院院长审核
			selectAct.find("option[value=bzcyqj_wp1_act5]").attr("selected","selected").change();
			selectAct.find("option[value=bzcyqj_wp1_act2]").remove();
		} else if(!IsSpace(action_defid)&&action_defid=="bzcyqj_wp1_act4"){//分院院长审核
			selectAct.find("option[value=bzcyqj_wp1_act5]").attr("selected","selected").change();
			selectAct.find("option[value=bzcyqj_wp1_act1]").remove();
		} 
   	}
     
	function prn1_preview_conferceBase() {
		jQuery("#print_table").show();
		CreateOneFormPage();	
		LODOP.PREVIEW();	
		jQuery("#print_table").hide();
	};

	function CreateOneFormPage(){
		LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));  
		LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_表单一");

		LODOP.SET_PRINT_STYLE("Bold",1);
		LODOP.ADD_PRINT_TEXT(50,231,260,39,"");
		LODOP.ADD_PRINT_HTM(60,45,800,980,document.getElementById("print_conferenceBase").innerHTML);
	};	  
	
	//点击完成
	var afterActionSuccessFn=function(){
		getParentWindow('<%=windowsId%>').location.href = "<%=path%>/ccapp/xtbg/tjy/processing/mainhandlist.jsp";
		removeAlertWindows('<%=windowsId%>',true);
		
	};
	//返回按钮
	function returnPage() {
		window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
		removeAlertWindows('<%=windowsId%>',true);
		
	}
	
	
</script>
</body>
</oa:init>
</html>

