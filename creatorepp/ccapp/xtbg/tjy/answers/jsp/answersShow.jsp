<%--
描述：问答公布栏-问题起草查看
作者：邱炼
版本：1.0
日期：2015-02-03
UTF-8
参数列表
busiTypeCode
addList
busi_id
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.DbManager"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.entity.ActColStatusBean"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.process.processconfig.dao.FlowInfoDao"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.dao.FlowBusiDataSaveDao"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.UUID"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>

<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	//当前用户信息
	String user_id = accesscontroler.getUserID();
	String user_name = accesscontroler.getUserName();
	
	UserCacheBean userCacheBean = UserCache.getUserCacheBean(user_id);
	//当前用户机构
	String org_id = userCacheBean.getOrg_id();
	String orgName = userCacheBean.getOrg_name();
	
	//当前用户单位
	String unit_id = userCacheBean.getUnit_id();
	String unit_name = userCacheBean.getUnit_name();
	
	//录入时间
	String r_creater_time = DateUtil.getCurrentDateTime();
	//首页数据跳转windowId
	String widowsid = "";
	if(request.getParameter("windowId")!=null){
		widowsid = StringUtil.deNull(request.getParameter("windowId"));
	}else{
		widowsid = StringUtil.deNull(request.getParameter("widowsid"));
	}
	//主键ID
	String busi_id  = StringUtil.deNull(request.getParameter("busi_id"));
	
	//环节ID
	String action_defid = StringUtil.deNull(request.getParameter("action_defid"));
	
	//取从start传过来的值
	String operType = StringUtil.deNull(request.getParameter("operType"));
	
	//业务类型code
	String busiTypeCode = StringUtil.deNull(request.getParameter("busiTypeCode"));
	
	//新增启动第一次的时候  默认设置为第一个环节
	if(action_defid.equals("")){
		action_defid="ywbd_wp1_act1";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>问题起草</title>
	<oa:init>
	<link rel="stylesheet" href="ccapp/oa/archive/css.css" type="text/css" />
	<script type='text/javascript' src='<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js' charset="utf-8"></script>
	<script type="text/javascript" src='<%=path %>/oa/resources/plug/ifrom/js/ifrom-ui-newcommonuse.js' charset="utf-8"></script>	
	<script type='text/javascript' src='<%=path %>/ccapp/oa/resources/plug/jquery-media/jquery.media.js' charset="utf-8"></script>
</head>


<body>

<form id="form1" name="form1" action="" method="post">
<input type="hidden" id="busi_id"      name="busi_id"  value="<%=busi_id %>" /> 
<input type="hidden" id="opt_type"     name="opt_type" /> 
<input type="hidden" id="busiTypeCode" name="busiTypeCode"  value="<%=busiTypeCode%>"/>
<input type="hidden" id="action_defid" name="action_defid"  value="<%=action_defid%>"/>
<%-- <input value="com.chinacreator.xtbg.tjy.answers.dao.imp.AnswersFlowDaoImpl" id="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" name="<%=FlowBusiDataSaveDao.CUSTOM_CRUD_CLASSNAME_FLAG%>" type="hidden"/>业务 --%>

<div id="tabs1" style="width:99%">
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
				<div id="vcenter" style="float: left; width: 100%; overflow-x: hidden;" scrolling="yes">
					<div style="float: left; width: 90%;">
						<div class="content_02_box" style="width:100%;">
							<div class="content_02_box_title_bg" style="width: 100%;"><span>基本信息</span></div>
							<div class="content_02_box_div" style="width:100%;">
								<table border="0" cellspacing="0" cellpadding="0"
									class="content_02_box_div_table" style="width:100%;">
									<tr>
										<th width="191" class="content_02_box_div_table_th">
											<span class="color_red">*</span>问题类型：</th>
										<td class="content_02_box_div_table_td" colspan="3">
											<oa:input type="text" column="P_TYPES" table="TA_OA_ANSWERS_INFO" other="class='input_title_text validate[required,maxSize[250]]'" />
										</td>
									</tr>
									<tr>
										<th width="191" class="content_02_box_div_table_th">
											<span class="color_red">*</span>标题：</th>
										<td class="content_02_box_div_table_td" colspan="3">
											<oa:input type="text" column="TITLE" table="TA_OA_ANSWERS_INFO" other="class='input_title_text validate[required,maxSize[250]]'" />
										</td>
									</tr>
									<tr>
										<th class="content_02_box_div_table_th">提出人：</th>
										<td class="content_02_box_div_table_td" width="192px"><oa:input type="text" column="CREATER_USERNAME" table="TA_OA_ANSWERS_INFO" value="<%= user_name%>" other="class='input_title_text' readonly='readonly'"/>
											<oa:input type="hidden" column="CREATER_USERID" table="TA_OA_ANSWERS_INFO" value="<%= user_id%>" />
										</td>
										<th class="content_02_box_div_table_th">提出单位：</th>
										<td class="content_02_box_div_table_td" width="192px"><oa:input type="text" column="CREATOR_ORGNAME" table="TA_OA_ANSWERS_INFO" value="<%= orgName%>"  other="class='input_title_text' readonly='readonly'"/>
											<oa:input type="hidden" column="CREATER_ORGID" table="TA_OA_ANSWERS_INFO" value="<%= org_id%>" />
											<oa:input type="hidden" column="CREATER_UNIT" table="TA_OA_ANSWERS_INFO" value="<%= unit_name%>" />
											<oa:input type="hidden" column="CREATER_UNITID" table="TA_OA_ANSWERS_INFO" value="<%= unit_id%>" />
											
										</td>
									</tr>
								</table>
							</div>
						</div>
						<!--提问内容DIV-->
						<div class="content_02_box" style="width: 100%">
							<div class="content_02_box_title_bg"  style="width:100%"><span>提问内容</span></div>
							<div class="content_02_box_div"  style="width:100%">
								<oa:textarea
										column='ASK_CONTENT' table='TA_OA_ANSWERS_INFO' title=''
										style='border: 0;width:99%; height: 110px; padding-left: 10px;overflow: auto;font-size:16px;' />
							</div>
						</div>
						<!-- 提问内容DIV -->
						<!-- 答复内容DIV-->
						<div class="content_02_box" style="width: 100%">
							<div class="content_02_box_title_bg"  style="width:100%"><span>答复内容</span></div>
							<div class="content_02_box_div"  style="width:100%">
								<oa:textarea
										column='ANSWER_CONTENT' table='TA_OA_ANSWERS_INFO' title=''
										style='border: 0;width:99%; height: 110px; padding-left: 10px;overflow: auto;font-size:16px;' />	
							</div>
						</div>
						<!-- 答复内容DIV -->
					</div>
				</div>
				<%-- 主表单 end---%>
			</td>
			</tr>
		</table>
	</div>
</div>
</form>

<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</body>
<script type="text/javascript">
	var path = "<%=path %>";
	//主键ID
	var busi_id = "<%=busi_id%>";
	//路径
	var path = "<%=path%>";
	//环节ID
	 var action_defid ="<%=action_defid%>";
	 var operType="<%=operType%>";
	 //界面初始化的时候
	 jQuery(function() {
		//初始化启动流程方式
		initSartFlow();
		//已办数据对控件的限制
		initFinishData(operType);
		
	});
	 /*
		函数：initFinishData
		描述：已办数据
	*/
	 var  initFinishData =function(operType){
		if(operType=="yiban"){
			//设置标题只读
			jQuery("#TA_OA_ANSWERS_INFO__TITLE").attr("readonly","readonly");
			//设置填写意见
			jQuery("#TA_OA_ANSWERS_INFO__AUDIT_IDEA").attr("disabled",true);
			jQuery("input[value='填写意见']").attr("disabled",true);
			jQuery("input[value='查看流程']").hide();
			jQuery("input[value='查看历史']").hide();
		}	 
	 }
	 
	/*
	函数：doStartFlowInThisPage
	描述：从新的启动流程函数
	*/
	var doStartFlowInThisPage = function(){
			<%--检查数据--%>
			if(checkThisPageData()){
				doStartFlow();
			}else{
				resetSubmit();
			}
	};
	
	var checkThisPageData = function(){
		/* var flag = true;
		if(jQuery("#TA_OA_NOTICE_INFO__N_RECEIVER_USERID").val() == ""&&jQuery("#TA_OA_NOTICE_INFO__N_RECEIVER_ORGID").val() == ""){
			alert("接收部门和人员不能为空");
			flag = false;
			return flag;
		}
		return flag; */
	}
	
	/*
	函数：resetSubmit
	描述：表单不提交函数
	*/
	function resetSubmit(){
		jQuery("#form1").resetSubmit(false);
	}

	/*
	    函数：initSartFlow
	   描述：重写启动流程方法
	*/
	 var initSartFlow =function(){
		if(jQuery("#startflaw").attr("onclick")=="doStartFlow()"){//启动
			jQuery("#startflaw").attr("onclick","doStartFlowInThisPage()");
		}
	 }
	
	//点击完成
	var afterActionSuccessFn=function(){
		//跳转到首页中待办任务列表
		if("<%=widowsid%>"!=""){
			window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
			removeWindows('<%=widowsid%>',true,false);
		} else{
			//跳转
			window.location.href = path + "/ccapp/xtbg/tjy/answers/jsp/viewAnswerslist.jsp";
		}
		
	};
	//返回按钮
	function returnPage() {
		//跳转到首页
		if("<%=widowsid%>"!=""){
			window.top.window.frames["_document_body_mian_firstPagerAAAS"].document.location.reload();
			removeWindows('<%=widowsid%>',true,false);
		} else{
			var okF = function(){
				afterActionSuccessFn();
			}
			var p={
						headerText:'提示',
						okName:'确认',
						okFunction:okF,
						cancelName:'取消'
					};
			alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
			}
	}
	
</script>
</oa:init>
</html>