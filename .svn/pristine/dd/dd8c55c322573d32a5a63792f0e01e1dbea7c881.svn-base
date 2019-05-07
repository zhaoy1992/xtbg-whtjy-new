<%--
描述：考勤 请假表单
作者：夏天
版本：1.0
日期：2014-03-10
--%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileUtil"%>
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
	if(!StringUtil.isBlank(busi_id)){
		user_id = DaoUtil.sqlToField("select t.t_user_id from ta_oa_attendanceleave t where t.t_id ='"+busi_id+"' ");
	}
	//当前用户  【分院非主要负责人】
	boolean  fyfzyfzr = FileUtil.isRolesUser(user_id,"分院非主要负责人");
	//当前用户  【省院非主要负责人】
	boolean  syfzyfzr = FileUtil.isRolesUser(user_id,"省院非主要负责人");
	//当前用户  【分院处级以下领导】
	boolean  fycjyxld = FileUtil.isRolesUser(user_id,"分院处级以下领导");
	//当前用户  【全院处级以上领导】
	boolean  qycjysld = FileUtil.isRolesUser(user_id,"全院处级以上领导");
	
	
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
	//职务 “兼”字说明是兼职人员，所以将“兼”字和以后的所有字符删除不做展示，只显示主要职位。
	String post = DirectoryConstant.parsePost(directoryBean.getPost(), true);
	if(post.indexOf("兼")>-1){
		post = post.substring(0,post.indexOf("兼"));
	}
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
	//分院非主要负责人
	var  fyfzyfzr ="<%=fyfzyfzr%>";
	//省院非主要负责人
	var  syfzyfzr ="<%=syfzyfzr%>";
	//分院处级以下领导
	var  fycjyxld ="<%=fycjyxld%>";
	//全院处级以上领导
	var  qycjysld ="<%=qycjysld%>";
	var path = "<%=path%>";
	var busi_id = "<%=busi_id%>";
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
    			jQuery("#TA_OA_ATTENDANCELEAVE__T_ZW").val("<%=post%>")
    		}
    		
    		//根据角色来隐藏意见
    		//分院非主要负责人
    		if(fyfzyfzr=="true"){
    			jQuery("#departmanager_idea").show();
    			jQuery("#president_idea").hide();
    		}
    		//分院处级以下领导
    		if(fycjyxld=="true"){
    			jQuery("#departmanager_idea").hide();
    			jQuery("#president_idea").hide();
    		}
    		//全院处级以上领导
    		if(qycjysld=="true"){
    			jQuery("#departmanager_idea").hide();
    			jQuery("#president_idea").show();
    		}
    		//分院非主要负责人 和分院处级以下领导 隐藏 【院长意见】
    		if(fyfzyfzr=="true"&&fycjyxld=="true"){
    			jQuery("#departmanager_idea").show();
    			jQuery("#president_idea").hide();
    		}
    		//分院处级以下领导 和全院处级以上领导 隐藏 【部门/科室负责人意见】
    		if(fycjyxld=="true"&&qycjysld=="true"){
    			jQuery("#departmanager_idea").hide();
    			jQuery("#president_idea").show();
    		}
    		selLeadType(2);
    		
	    });
	  /**
	  *计算请假时间
	  */
	  function mathLeaveDays(){
		  if(jQuery("#TA_OA_ATTENDANCELEAVE__T_STARTTIME").val()){
			if(jQuery("#TA_OA_ATTENDANCELEAVE__T_DATA_TYPE").val() == "1"){
				jQuery("#TA_OA_ATTENDANCELEAVE__T_LEAVETIMES").val("0.5");
				jQuery("#TA_OA_ATTENDANCELEAVE__T_ENDTIME").val(jQuery("#TA_OA_ATTENDANCELEAVE__T_STARTTIME").val());
				jQuery("#dis_TA_OA_ATTENDANCELEAVE__T_STARTTIME").val(jQuery("#TA_OA_ATTENDANCELEAVE__T_STARTTIME").val());
				
			}else{
				if(jQuery("#TA_OA_ATTENDANCELEAVE__T_ENDTIME").val()){
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
		  }
	  }
	  
	  //获得下环节id
	  function getnextactionid(nextid){
		  jQuery("#nextid").val(nextid);
	  }
	  
	  //请假时间类别
	  function selLeadType(){
		 if("1" == jQuery("#TA_OA_ATTENDANCELEAVE__T_DATA_TYPE").val()){
			 jQuery("#TA_OA_ATTENDANCELEAVE__T_LEAVETIMES").val("0.5");
			 jQuery("#TA_OA_ATTENDANCELEAVE__T_DATA_VALUE").show();
			 jQuery("#dis_TA_OA_ATTENDANCELEAVE__T_ENDTIME").hide(); 
			 jQuery("#sp_1").hide();
			 jQuery("#sp_2").hide();
		 }else{
			 jQuery("#TA_OA_ATTENDANCELEAVE__T_DATA_VALUE").hide();
			 jQuery("#dis_TA_OA_ATTENDANCELEAVE__T_ENDTIME").show();     
			 jQuery("sp_1").show();
			 jQuery("sp_2").show();
			 mathLeaveDays();
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
	<input value="com.chinacreator.xtbg.suxian.electroniccheck.dao.imploracle.LeaveSaveDaoImpl" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" 
	name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" type="hidden"/>
	<input id="nextid" name="nextid" type="hidden" />
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
										   initDefautValue="" defautValue="" other="class='validate[required]' onchange='mathLeaveDays()' "></oa:select>
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
							<th class="content_02_box_div_table_th">附件：</th>
							<td class="content_02_box_div_table_td" colspan="5">
								<oa:affixbut butName='请选择文件' column='T_FJ_ID' table='TA_OA_ATTENDANCELEAVE'  title ='' operType='111' />
							</td>
						</tr>
						<tr>
							<th class="content_02_box_div_table_th">附件列表：</th>
							<td class="content_02_box_div_table_td" colspan="5">
								<oa:affixshow  title ='' style='height:60px;background-color: white;' 
										ulstyle='overflow-y: auto;overflow-x:hidden;height:60px;margin:2px ;padding-left:7px;background:white;border:0px;max-height:60px;background:white;border:0;' />
							</td>
						</tr>
						<tr>
							<th class="content_02_box_div_table_th"><FONT style="COLOR: red" id="bt_id" >*</FONT>请假时间：</th>
							<td class="content_02_box_div_table_td" colspan="1">
								<oa:select column="T_DATA_TYPE" table="TA_OA_ATTENDANCELEAVE"
								optionsql="select '2' as T_DATA_TYPE,'一天假及以上' as typemc  from dual  union
										   select '1' as T_DATA_TYPE,'半天假' as typemc  from dual " style="width: 100px;"
										   initDefautValue="" defautValue="2" other="class='validate[required]' onchange='selLeadType()' "></oa:select>
							</td>
							<td class="content_02_box_div_table_td" colspan="4"  >
								<span id="sp_1">自</span><oa:date dateFmt='yyyy-MM-dd'  style="float:none" column="T_STARTTIME" table="TA_OA_ATTENDANCELEAVE" 
									other="class='date_120 Wdate validate[required]' onfocusout=mathLeaveDays()" maxDate="#F{$dp.$D(\\'TA_OA_ATTENDANCELEAVE__T_ENDTIME\\')||\\'2099-12-12\\'}" />
								<span id="sp_2">至</span><oa:date dateFmt='yyyy-MM-dd'  style="float:none" column="T_ENDTIME" table="TA_OA_ATTENDANCELEAVE" 
									other="class='date_120 Wdate validate[required]' onfocusout=mathLeaveDays()"  minDate="#F{$dp.$D(\\'TA_OA_ATTENDANCELEAVE__T_STARTTIME\\')||\\'1980-01-01\\'}"/>
								<oa:select column="T_DATA_VALUE" table="TA_OA_ATTENDANCELEAVE" 
									optionsql="select ' ' as T_DATA_VALUE,'--请选择--' as typemc  from dual  union
										   select '1' as T_DATA_VALUE,'上午' as typemc  from dual  union
										   select '2' as T_DATA_VALUE,'下午' as typemc  from dual" style="width: 100px;"
										   initDefautValue="" defautValue="" other="class='validate[required]'  "></oa:select>
								总共请假<oa:input
										type="text" column="T_LEAVETIMES"  style="float:none;text-align:center;" table="TA_OA_ATTENDANCELEAVE"
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
						<tr id="departmanager_idea">
							<th class="content_02_box_div_table_th">部门/科室负责人意见：</th>
							<td class="content_02_box_div_table_td" colspan="5">
								<oa:view column="T_DEPARTMANAGER_IDEA" table="TA_OA_ATTENDANCELEAVE" 
								style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
							</td>
						</tr>
						<tr>
							<th class="content_02_box_div_table_th">分管领导意见：</th>
							<td class="content_02_box_div_table_td" colspan="5">
								<oa:view column="T_FENGUAN_LEADER_IDEA" table="TA_OA_ATTENDANCELEAVE" 
								style="border: 1;width:99%;overflow: auto;" other="class='validate[maxSize[1000]] textarea_556'" />
							</td>
						</tr>	
						<tr id="president_idea">
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
   		//-------省院部门非主要领导  流程-------
   		//1.分院非主要负责人 下个环节  科室负责人审批
   		var arrA = [];
   		var arrB = {"option[value=bmzyldqj_wp1_act2]":"1"
	   				,"option[value=bmzyldqj_wp1_act3]":"1"
	   				,"option[value=bmzyldqj_wp1_act4]":"1"
	   				,"option[value=bmzyldqj_wp1_act8]":"1"};
   		if(!IsSpace(fyfzyfzr)&&fyfzyfzr=="true"){
   			arrA.push("option[value=bmzyldqj_wp1_act3]");
   		}
   		//2.省院非主要负责人 下个环节  部门负责人审批
   		if(!IsSpace(syfzyfzr)&&syfzyfzr=="true"){
   			arrA.push("option[value=bmzyldqj_wp1_act2]");
   		}
   		//3.分院处级以下领导 下个环节  综合办公室审核/中转
   		if(!IsSpace(fycjyxld)&&fycjyxld=="true"){
   			arrA.push("option[value=bmzyldqj_wp1_act4]");
   		}
   		//4.全院处级以上领导 下个环节 人力资源部初审
   		if(!IsSpace(qycjysld)&&qycjysld=="true"){
   			arrA.push("option[value=bmzyldqj_wp1_act8]");
   		}
   		//起草申请环节
   		if(IsSpace(action_defid)){
	   		for(var i = 0;i<arrA.length;i++){
	   			selectAct.find(arrA[i]).attr("selected","selected").change();
	   			arrB[arrA[i]]='';
	   		}
	   		for(var j in arrB){
	   			if(arrB[j]){
	   				selectAct.find(j).remove();
	   			}
	   		}
   		}
   		//部门负责人审批 
   		if(!IsSpace(action_defid)&&action_defid=="bmzyldqj_wp1_act2"){
 			selectAct.find("option[value=bmzyldqj_wp1_act8]").attr("selected","selected").change();
 			selectAct.find("option[value=bmzyldqj_wp1_act1]").remove();
 		}
   		//人力资源部初审
   		if(!IsSpace(action_defid)&&action_defid=="bmzyldqj_wp1_act8"){
 			selectAct.find("option[value=bmzyldqj_wp1_act5]").attr("selected","selected").change();
 			selectAct.find("option[value=bmzyldqj_wp1_act2]").remove();
 			selectAct.find("option[value=bmzyldqj_wp1_act1]").remove();
 		}
   		//人力资源部复审/中转
   		if(!IsSpace(action_defid)&&action_defid=="bmzyldqj_wp1_act5"){
 			selectAct.find("option[value=bmzyldqj_wp1_act6]").attr("selected","selected").change();
 			selectAct.find("option[value=bmzyldqj_wp1_act8]").remove();
 		}
   		//科室负责人审批
   		if(!IsSpace(action_defid)&&action_defid=="bmzyldqj_wp1_act3"){
 			selectAct.find("option[value=bmzyldqj_wp1_act4]").attr("selected","selected").change();
 			selectAct.find("option[value=bmzyldqj_wp1_act1]").remove();
 		}
   		//综合办公室审核/中转
   		if(!IsSpace(action_defid)&&action_defid=="bmzyldqj_wp1_act4"){
 			selectAct.find("option[value=bmzyldqj_wp1_act6]").attr("selected","selected").change();
 			selectAct.find("option[value=bmzyldqj_wp1_act3]").remove();
 			selectAct.find("option[value=bmzyldqj_wp1_act1]").remove();
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

