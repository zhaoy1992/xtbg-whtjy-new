<%-- 
描述：送后续环节
作者：shuqi.liu
版本：1.0
日期：2013-10-08
 --%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamConstant"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.WordArchiveService"%>
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.util.Constant"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>

<html>
<head>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String userId = accesscontroler.getUserID();
	//获取用户信息
	UserCacheBean userBean = UserCache.getUserCacheBean(userId);
	String user_id = userBean.getUser_id();
	String user_name = userBean.getUser_name();
	String user_real_name = userBean.getUser_realname();
	String msg_txt = StringUtil.deNull(request.getParameter("msg_txt"));
	msg_txt = java.net.URLDecoder.decode(msg_txt, "UTF-8");
	//如果环节短信配置为空
	if(StringUtil.isBlank(msg_txt)){
		 msg_txt = SysParamUitl.getSysParamValue(Constant.ARCHIVE_MSG_SEND);
	}
	//短信发送是否默认勾选
	String is_send_check = SysParamUitl.getSysParamValue(Constant.IS_SEND_CHECK);
	String isdxtx = request.getParameter("isdxtx");
	String isjsxx = request.getParameter("isjsxx");
	String isyj = request.getParameter("isyj");
	String isznxx = request.getParameter("isznxx");
	
	String busi_id = request.getParameter("busi_id");
	//市内用车/市外用车？
	String location = DaoUtil.sqlToField("select a.vehicle_location from TA_OA_WHTJY_YONGCHE a where a.t_id = '"+busi_id+"'");
	
	String ins_id = request.getParameter("ins_id");
	String nextAct = StringUtil.deNull(request.getParameter("nextAct"));
	String lastActId = "";
	if(!StringUtil.isBlank(nextAct) &&!StringUtil.isBlank(ins_id) && "banjie".equals(nextAct)){
		WordArchiveService service = new WordArchiveServiceImpl();
		lastActId = service.getLastActByIns_id(ins_id);
	}
    
	//判断是否有短信，及时，邮件，站内消息提示
	SysParamUitl noticeutil=new SysParamUitl();
	Map<String,String> msgmap=noticeutil.getCheckedSystemMsg();
	String is_pub_sms=msgmap.get(SysParamConstant.IS_PUB_SMS);
	String is_pub_msg=msgmap.get(SysParamConstant.IS_PUB_MSG);
	String is_pub_rtx=msgmap.get(SysParamConstant.IS_PUB_RTX);
	String is_pub_mail=msgmap.get(SysParamConstant.IS_PUB_MAIL);
	String audit = SysParamUitl.getSysParamValue("audit_show");
	String publish = SysParamUitl.getSysParamValue("publish_show");
%>
<title>送后续环节</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入其它 -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>

<script type='text/javascript' src='../../oa/process/flowprocessing/js/alertworkflow.js'></script>
<script type="text/javascript">
//【起草】环节点击【下一步】选择【部门负责人审批】、【科室负责人审批】时的环节执行人只展示可选当前登陆用户所在部门的人员
var treeParam = "0";
var location = "<%=location%>";
jQuery(function() {
	
	var pwindows = getParentWindow("windowIds");
	var pparms = pwindows.parms;//获取父页面的流程数据
	var action_defid = pwindows.jQuery("#action_defid").val();//当前环节
	if(pparms.flowParmJson.initType!=3 ){//如果是初始化环节，中间环节
		if(pparms.flowParmJson.isSignCount!="false" && pparms.flowParmJson.isSignCount!="1"){//如果是会签环节，并且不是最后一个人，那么隐藏选择人员，环节列表
			jQuery("#xzsp_workflowControl_selectOrAct").hide();
			jQuery("#xzsp_workflowControl_selectUser").hide();
			jQuery("#button1").hide();
		}else{
			initActUser(pparms);//初始化环节下拉框。
			//特检院OA 【公文发布】的【院领导签发】环节的【下一步】按钮的后续环节列表应当影藏【起草\中转】环节。
			deleteFawenAct(action_defid);
			//特检院 OA 【党委发文】 去掉选择下一个环节 按钮 中上个环节
			deleteDwFawenAct(action_defid);
			//特检院OA 【电子考勤】屏蔽环节中的 环节的【下一步】按钮 上个环节环节。
			deleteAttendanceAct(action_defid);
			//特检院OA【用车申请】根据用车地点控制流程
			deleteYongcheAct(action_defid);
			//特检院OA【车辆维修】分管院领导审核后默认“财务部办结存档”环节。
			chooseWeixiuAct(action_defid);
			
			//选择下 一步 隐藏环节
			if(typeof(pwindows.changeSelect)=="function"){
				pwindows.changeSelect(action_defid,jQuery("#xzsp_workflowControl_selectAct"));
			}
			jQuery("#button3").hide();
		}
	}else{//最后环节
		jQuery("#xzsp_workflowControl_selectOrAct").hide();
		jQuery("#xzsp_workflowControl_selectUser").hide();
		jQuery("#button3").hide();
		jQuery("#button1").text("办结");
	}
	//自动送办结环节
	<%if(!StringUtil.isBlank(nextAct)){
		if(StringUtil.isBlank(lastActId)){%>
			alert("改流程无法找到办结节点，请检查流程图！")
		<%}else{%>
			//如果返回了办结节点，那么拼装数据发起流程。
			jQuery("#xzsp_workflowControl_selectAct").val("<%=lastActId%>");
		    jQuery('#DYNAMICPERFORMER_ID').val('<%=user_id%>');
		    jQuery('#DYNAMICPERFORMER_REALNAME').val('<%=user_real_name%>');
		    jQuery('#DYNAMICPERFORMER').val('<%=user_name%>');
		    save();
		<%}
	}%>
	
});

//特检院OA 【公文发布】的【院领导签发】环节的【下一步】按钮的后续环节列表应当影藏【起草\中转】环节。
var deleteFawenAct = function(action_defid){
	if(!IsSpace(action_defid)&&action_defid=="STJYFaWen_wp1_act2"){// 部门核稿
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYFaWen_wp1_act3]").attr("selected","selected").change();
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYFaWen_wp1_act1]").remove();
	} else if(!IsSpace(action_defid)&&action_defid=="STJYFaWen_wp1_act3"){//分管院长审核
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYFaWen_wp1_act4]").attr("selected","selected").change();
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYFaWen_wp1_act2]").remove();
	} else if(!IsSpace(action_defid)&&action_defid=="STJYFaWen_wp1_act4"){//办公室核稿/中转
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYFaWen_wp1_act5]").attr("selected","selected").change();
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYFaWen_wp1_act3]").remove();
	} else if(!IsSpace(action_defid)&&action_defid=="STJYFaWen_wp1_act6"){//院领导签发
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYFaWen_wp1_act8]").attr("selected","selected").change();
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYFaWen_wp1_act4]").remove();
	}
}
//特检院 OA 【党委发文】 去掉选择下一个环节 按钮 中上个环节
var deleteDwFawenAct = function(action_defid){
	if(!IsSpace(action_defid)&&action_defid=="STJYDWFaWen_wp1_act2"){//部门核稿
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYDWFaWen_wp1_act3]").attr("selected","selected").change();
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYDWFaWen_wp1_act1]").remove();
	} else if(!IsSpace(action_defid)&&action_defid=="STJYDWFaWen_wp1_act3"){//党委书记审核
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYDWFaWen_wp1_act4]").attr("selected","selected").change();
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYDWFaWen_wp1_act2]").remove();
	} else if(!IsSpace(action_defid)&&action_defid=="STJYDWFaWen_wp1_act4"){//党委办公室核稿/中转
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYDWFaWen_wp1_act5]").attr("selected","selected").change();
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYDWFaWen_wp1_act3]").remove();
	} else if(!IsSpace(action_defid)&&action_defid=="STJYDWFaWen_wp1_act6"){//书记签发
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYDWFaWen_wp1_act7]").attr("selected","selected").change();
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=STJYDWFaWen_wp1_act4]").remove();
	}
} 

//特检院OA 屏蔽环节中的 环节的【下一步】按钮 上个环节环节。
var deleteAttendanceAct = function(action_defid){
	
	//-------易耗品申领登记 流程  -------
	if(!IsSpace(action_defid)&&action_defid=="yhply_wp1_act3"){
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=yhply_wp1_act2]").attr("selected","selected").change();
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=yhply_wp1_act1]").remove();
	}
}

//特检院OA 如“用车地点”为“市内用车”，则用车申请流程不走“分管院领导审核”环节，在页面选择环节时，不应出现“分管院领导审核”环节的选项；只有“用车地点”为“市外用车”时，才必须走“分管院领导审核”环节；
var deleteYongcheAct = function(action_defid){
	if(!IsSpace(action_defid)&&action_defid=="whtjyYongChe_wp1_act4"){//后勤部负责人审核
		if(location == "市内用车"){
			jQuery("#xzsp_workflowControl_selectAct").find("option[value=whtjyYongChe_wp1_act6]").attr("selected","selected").change();
			jQuery("#xzsp_workflowControl_selectAct").find("option[value=whtjyYongChe_wp1_act5]").remove();
		}else{
			jQuery("#xzsp_workflowControl_selectAct").find("option[value=whtjyYongChe_wp1_act5]").attr("selected","selected").change();
			jQuery("#xzsp_workflowControl_selectAct").find("option[value=whtjyYongChe_wp1_act6]").remove();
		}
	}
}

var chooseWeixiuAct = function(action_defid){
	if(!IsSpace(action_defid)&&action_defid=="clwx_wp1_act4"){
		jQuery("#xzsp_workflowControl_selectAct").find("option[value=clwx_wp1_act7]").attr("selected","selected").change();
	}
}


//人员选择树
var chooseReportUnits = function(){
	var selectAction_defid = jQuery("#xzsp_workflowControl_selectAct").val();
	//部门负责人审批 和 科室负责人审批,销假登记
	if(!IsSpace(selectAction_defid)&&(selectAction_defid=="bmzyldqj_wp1_act2"
			||selectAction_defid=="bmzyldqj_wp1_act3"
			||selectAction_defid=="bmzyldqj_wp1_act4"
			||selectAction_defid=="bmzyldqj_wp1_act9")){
		treeParam="1";
	}  else {
		treeParam="0";
	}
	if(jQuery("#webofficDiv")){
		//jQuery("#webofficDiv").hide();
	}
	 var s = new jQuery.z_tree_leftRigth();
	  s.treeID='button_envelop_username';
	  s.isShowSeacher="aa";
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.titelText = "选择人员";
	  s.rightHeaderText="已添加机构和人员";
	  s.returnFunction=function(orgObj){
		  if(IsSpace(orgObj.ps) || null ==orgObj.ps ){
			  	  jQuery('#DYNAMICPERFORMER_ID').val('');
			  	  jQuery('#DYNAMICPERFORMER_REALNAME').val('');
			  	  jQuery('#DYNAMICPERFORMER').val('');
		  }else{
				  jQuery('#DYNAMICPERFORMER_ID').val(orgObj.ps.id);
				  jQuery('#DYNAMICPERFORMER_REALNAME').val(orgObj.ps.name);
				  jQuery('#DYNAMICPERFORMER').val(orgObj.ps.user_name);
		 }
	  }
	  s.treetypestr = jQuery('#TREE_NODETYPE').val(); //单选或复选
	  var type = "";
	  if(jQuery('#TREE_ROLE').val()=="configPeople"){//配置用户树
		  type = "AUSER"; 
	  }else{										//全选树
		  if(treeParam=="1"){
			  type= "APERSONOne";
		  } else {
			  type= "APERSON";  
		  }
	  }
	  s.treeList=[{
				  leftHeaderText:'按人员选择',
				  valueKey:'ps',
				  selectedIds:jQuery('#DYNAMICPERFORMER_ID').val(),
				  type: type,
				  user_ids:jQuery('#SELECT_USER_ID_LIST').val()
		}
<%-- 	  ,  特检院屏蔽  最近选择人员
		{
			  leftHeaderText:'按最近选择的人员选择',
			  isType:'person',
			  valueKey:'rudata',
			 // selectedIds:jQuery('#DYNAMICPERFORMER_ID').val(),
			  type: "AUSER",
			  ru_logn:jQuery('#xzsp_workflowControl_selectAct').val(),
			  user_ids:'<%=userId%>'
		} --%>
	  ];
	  s.init();
}

//启动流程
function save(){
	var pwindows = getParentWindow("windowIds");
	var pparms = pwindows.parms;//获取父页面的流程数据
	var dynamicperformer_realname = jQuery("#DYNAMICPERFORMER_REALNAME").val();
	if(dynamicperformer_realname=="" && pparms.flowParmJson.initType!=3){
		var isDynamicSelectUser = jQuery("#isDynamicSelectUser").val();
		if(isDynamicSelectUser == "true"){
			alert("请选择执行人！");
		}else{
			alert("请配置动态选择执行人，或者配置环节人员！");
		}
		
		return false;
	}
	//传递下一环节id
	if(typeof(getParentWindow("windowIds").getnextactionid)=="function"){
		var nextid= jQuery("#xzsp_workflowControl_selectAct").val();
		var hh= getParentWindow("windowIds").getnextactionid(nextid);
	}
	
	//===========特检院 追加完成流程活动 后的特殊处理 2015-02=09 start===============
	if(typeof(getParentWindow("windowIds").doCompleteActivity)=="function"){
		getParentWindow("windowIds").doCompleteActivity(jQuery("#xzsp_workflowControl_selectAct").val());
	}
	//===========特检院 追加完成流程活动 后的特殊处理 2015-02=09 end===============

	//debugger;
	//获取选择人员
	var DYNAMICPERFORMER_ID = jQuery('#DYNAMICPERFORMER_ID').val();
	var DYNAMICPERFORMER_REALNAME = jQuery('#DYNAMICPERFORMER_REALNAME').val();
	var DYNAMICPERFORMER = jQuery('#DYNAMICPERFORMER').val();
	//获取选择环节类型等信息
	var xzspWorkflowType = jQuery("#xzspWorkflowType").val();
    var isDynamicSelectAct = jQuery("#isDynamicSelectAct").val();
    var isDynamicSelectUser = jQuery("#isDynamicSelectUser").val();
    var isDynamicSelectAndAct = jQuery("#isDynamicSelectAndAct").val();
    var nextActList = jQuery("#nextActList").val();
    var xzsp_workflowControl_selectAct =  jQuery("#xzsp_workflowControl_selectAct").val();
    
	var ret = new Array();
    ret["xzspWorkflowType"] = xzspWorkflowType;
    ret["isDynamicSelectAct"] = isDynamicSelectAct;
    ret["isDynamicSelectUser"] = isDynamicSelectUser;
    ret["isDynamicSelectAndAct"] = isDynamicSelectAndAct;
    ret["nextActList"] = nextActList;
    ret["xzsp_workflowControl_selectAct"] = xzsp_workflowControl_selectAct;
    
    var isdxtx="0";
    var isyj="0";
    var isznxx="0";
    var isjsxx="0";
    var iscontent=false;
    var msg_txt=jQuery("#msg_txt").val();
    if(jQuery("#isdxtx").attr("checked")=='checked'){
    	isdxtx="1";
    	iscontent=true;
    }
    if(jQuery("#isyj").attr("checked")=='checked'){
    	isyj="1";
    	iscontent=true;
    }
    if(jQuery("#isznxx").attr("checked")=='checked'){
    	isznxx="1";
    	iscontent=true;
    }
    if(jQuery("#isjsxx").attr("checked")=='checked'){
    	isjsxx="1";
    	iscontent=true;
    }
    if(iscontent && IsSpace(jQuery("#msg_txt").val())){
    	alert("消息内容不能为空！");
    	return;
    }
	pwindows.msgConfigReset(isdxtx,isyj,isznxx,isjsxx,msg_txt);
	pwindows.setFlowInfo(DYNAMICPERFORMER_ID, DYNAMICPERFORMER_REALNAME, DYNAMICPERFORMER,ret);
	removeAlertWindows('windowIds',true);
	pwindows.removeAlertWindows('windowIds',true);
}


//会签
function huiqian(){
	var pwindows = getParentWindow("windowIds");
	var pparms = pwindows.parms;//获取父页面的流程数据
    
	var ret = new Array();
  	//会签环节不需要传环节跟执行人。
    ret["xzsp_workflowControl_selectAct"] = "";
	pwindows.setFlowInfo("", "", "",ret);

	removeAlertWindows('windowIds',true);
	pwindows.removeAlertWindows('windowIds',true);
}

//关闭
function closew(){
	getParentWindow("windowIds").resetSubmit();
	removeAlertWindows('windowIds',true);
}
</script>

</head>
<body>
<button id="button1" class="but_y_01" onclick="save()">确定</button>
<button id="button3" class="but_y_01" onclick="huiqian()">会签</button>
<button id="button2" class="but_y_01" onclick="closew()">关闭</button>
<form id="form1" action="" method="post">
<div id="vcenter" style="float: left; width: 100%;"  >
	<div style="float: left; width: 775px;">
		<div class="content_02_box">
			<div class="content_02_box_div">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					id="content_02_box_div_table_02">
					<tr id="xzsp_workflowControl_selectOrAct">
						<th class="content_02_box_div_table_th">环节名称：</th>
			            <td class="content_02_box_div_table_td" style="width: 290px" colspan="7">
							<select id="xzsp_workflowControl_selectAct" onChange="changeSelectAct()" class="cms_select" style="width:160px;"></select>					 
						</td>
					</tr>
					<tr id="xzsp_workflowControl_selectUser">
						<th class="content_02_box_div_table_th">选择执行人：</th>
			            <td class="content_02_box_div_table_td" style="width: 290px"  colspan="7">
						<input class="validate[required] input_160"  id="DYNAMICPERFORMER_REALNAME" name="DYNAMICPERFORMER_REALNAME" value="" readOnly  onclick="chooseReportUnits()" />
						<input type="hidden" id="DYNAMICPERFORMER" name="DYNAMICPERFORMER" />
						<input type="hidden" id="DYNAMICPERFORMER_ID" name="DYNAMICPERFORMER_ID" />
						</td>
					</tr>
					<%if("1".equals(is_pub_sms) || "1".equals(is_pub_msg)/*  || "1".equals(is_pub_mail) */){ %>
							<tr>
								<th class="content_02_box_div_table_th"  style="width:200px;">提醒方式：</th>
								<td class="content_02_box_div_table_td" colspan="3">
								<%if("1".equals(is_pub_sms)){ %>
									<input type="checkbox" id="isdxtx" name="isdxtx" style="margin-left: -4px" value="1" <%="1".equals(is_send_check)?"checked":"" %> />&nbsp;短信									
									&nbsp;<%} %>
									<%if("1".equals(is_pub_mail)){ %>
									<!-- <input type="checkbox" id="isyj" name="isyj" value="1" <%="1".equals(isyj)?"checked":"" %> />&nbsp;邮件&nbsp; -->
									<%} if("1".equals(is_pub_rtx)){%>
									<%-- <input type="checkbox" id="isjsxx" name="isjsxx" value="1" <%="1".equals(isjsxx)?"checked":"" %>/>&nbsp;即时信息&nbsp; --%>
									<%} if("1".equals(is_pub_msg)){%>
									<input type="checkbox" id="isznxx" name="isznxx" value="1" <%="1".equals(is_send_check)?"checked":"" %> />&nbsp;站内信息&nbsp;
									<%} %>
								</td>
								
							</tr>
						<%-- <th class="content_02_box_div_table_th">是否发送短信：</th>
			            <td  class="content_02_box_div_table_td" style="text-align: left;">
			                <input type="checkbox" id="isdxtx" name="isdxtx" value="1" <%="1".equals(isdxtx)?"checked":"" %> />
			            </td>
			            <th class="content_02_box_div_table_th">是否发送邮件：</th>
			            <td  class="content_02_box_div_table_td" style="text-align: center;">
			                <input type="checkbox" id="isyj" name="isyj" value="1" <%="1".equals(isyj)?"checked":"" %> />
			            </td>
			            <th class="content_02_box_div_table_th">是否发送站内消息：</th>
			            <td  class="content_02_box_div_table_td" style="text-align: left;">
			                <input type="checkbox" id="isznxx" name="isznxx" value="1" <%="1".equals(isznxx)?"checked":"" %> />
			            </td>
			            <th class="content_02_box_div_table_th">是否发送即时消息：</th>
			            <td  class="content_02_box_div_table_td" style="text-align: center;">
			                <input type="checkbox" id="isjsxx" name="isjsxx" value="1" <%="1".equals(isjsxx)?"checked":"" %> />
			            </td> --%>
					<tr>
						<th  class="content_02_box_div_table_02_th">消息内容：</th>
			            <td colSpan="7" class="content_02_box_div_table_td">
			                <textarea class="textarea_575" id="msg_txt" name="msg_txt" style="width:99%;height: 40px; margin:2px 0 2px; "><%=msg_txt %></textarea> 
			            </td>
					</tr>
				<%}%>
				</table>
			</div>
		</div>
	</div>
</div>
<input id="busi_id" name="busi_id" type="hidden" value =""/>
<input id="SELECT_USER_ID_LIST" name="SELECT_USER_ID_LIST" type="hidden" value =""/>
<input id="TREE_ROLE" name="TREE_ROLE" type="hidden" value =""/>
<input id="TREE_NODETYPE" name="TREE_NODETYPE" type="hidden" value =""/>

<input id="xzspWorkflowType" name="xzspWorkflowType" type="hidden" />
<input id="isDynamicSelectAct" name="isDynamicSelectAct" type="hidden" />
<input id="isDynamicSelectAndAct" name="isDynamicSelectAndAct" type="hidden" />
<input id="isDynamicSelectUser" name="isDynamicSelectUser" type="hidden" />
<input id="nextActList" name="nextActList" type="hidden" />
</form>
</body>
</html>