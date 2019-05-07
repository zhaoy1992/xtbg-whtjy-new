
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevAccountServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevAccountInfoService"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevIssuedPlanService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevIssuedPlanServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevIssuedDetailsService"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevIssuedDetailsServiceImpl"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	//存计划表
	Map<String,String> bean = new HashMap<String,String>();
	//存待检设备清单
	List<Map<String,String>> list = new ArrayList<Map<String,String>>();
	
	//insert/update
	String actionName = request.getParameter("actionName");
	
	//界面入口 myPlay 表示是我的下达检查计划界面
	String type = StringUtil.deNull(request.getParameter("type"));
	//主键ID
	String plan_id = request.getParameter("plan_id");
	
	//类型业务
	DevIssuedPlanService service = new DevIssuedPlanServiceImpl();
	//核验设备处理
	DevIssuedDetailsService detailService = new DevIssuedDetailsServiceImpl();
	//检查类型
	String strChecktype ="";
	//完成状态
	String strComplflag ="";
	
	if("insert".equals(actionName)){
		//创建单位
		bean.put("unit_id",userBean.getUnit_id());
		bean.put("unit_name",userBean.getUnit_name());
		//创建用户信息
		bean.put("creater_userid",accesscontroler.getUserID());
		bean.put("creater_username",accesscontroler.getUserName());
		bean.put("plan_id",DaoUtil.getUUID());
	}else {
		bean = service.getDevIssuedPlanBean(plan_id);
		list = detailService.getByPlanid(plan_id);
		strChecktype = bean.get("checktype");
		strComplflag = bean.get("complflag");
	}
	
	String checktype = "devchecktype";//检查类型
    String checktypeHtml = DictDropDownList.buildSelect4DictType(checktype,"checktype" ,  StringUtil.deNull(strChecktype), "" , false, "" ,"" ,"class='validate[required] select_240' style='width: 190px;height:24px;'","" );
	String complflag = "devcomplflag";//完成状态
	String complHtml = DictDropDownList.buildSelect4DictType(complflag,"complflag" ,  StringUtil.deNull(strComplflag), "" , false, "" ,"" ,"class='validate[required] select_240' style='width: 190px;height:24px;'","" );
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>下达核检计划管理</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
var actionName ="<%=actionName%>";
var type = "<%=type%>";//界面入口

	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#internal_no").focus();
		jQuery("#complflag").attr("disabled","disabled");
		

		<%if(list.size()>0){%>
			var idsArrTemp = new Array();
		<%
			for(int i=0;i<list.size();i++){
				Map<String,String> map = list.get(i);%>
				
				var myinfo = new Array()
				myinfo[0] = "<%=map.get("sb_id")%>";
				myinfo[1] = "<%=map.get("internal_no")%>";
				myinfo[2] = "<%=map.get("name")%>";
				myinfo[3] = "<%=map.get("it")%>";
				myinfo[4] = "<%=map.get("manufacturer")%>";
				myinfo[5] = "<%=map.get("bar_code")%>";
				myinfo[6] = "<%=map.get("body_no")%>";
				myinfo[7] = "<%=map.get("last_date")%>";
				idsArrTemp.push(myinfo);
		<%}%>
				setDevInfo(idsArrTemp);
		<%}%>
		//我的下达检查界面
		if("myPlay"==type){
			//选择设备按钮
			jQuery("#sel").hide();
			jQuery("#addButton").hide();
			jQuery("#deleteButton").hide();
			jQuery(".but_x").hide();
			jQuery("#compltime").attr("disabled","disabled");
			jQuery("#checktype").attr("disabled","disabled");
			
			var complflagtext = jQuery("#complflag").find("option:selected").text();
			if(complflagtext!="已分配"){
				jQuery("#distribution").show();
			}
			if(complflagtext!="已完成"){
				jQuery("#complete").show();
			} else{
				//已完成
				jQuery("#remark").attr("readonly","readonly");
				jQuery("#distribution").hide();
			}
		}
	});

/*
函数:  Ok
说明:  提交添加与修改来文单位
参数:   无
返回值: 无
*/
function save(a){
	jQuery("#complflag").find("option").each(function(){
		if(this.expandName==a){
			this.selected='selected';
		}
	});
	if(a == 3){
		jQuery("#is_wancheng").val("1");
	}
	//保存
	Ok();
}
/*
函数:  Ok
说明:  提交添加与修改来文单位
参数:   无
返回值: 无
*/
function Ok() {
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (isFlag){
		//jQuery("#form1").attr("target","devissuedplaninfoJSPhiddenFrame");
		jQuery("#complflag").removeAttr("disabled");
		jQuery("#form1").submit();
	}
}

function closed(){
	removeWindows('',true);
}

/*
函数:  openDevAppInfo
说明:  选择仪器设备物品
返回值: 无
*/
function openDevAppInfo(){
	//设备维修申请  选择设备 "完好"
	var path ="<%=path%>/ccapp/xtbg/tjy/account/jsp/changeaccountlist.jsp?windowsId=windowIds1&gdzc_classify=2&type=type";
	openAlertWindows('windowIds1',path,'设备信息',900,450,'25%','25%');
}

/*
函数:  setDevInfo
说明:  选择仪器设备物品
参数:   sbid:设备ID,sbname:设备名称      sbcode：设备编号         设备状态：sbstat 设备型号:type
		make_users:制造厂商   technical_parameters:设备参数信息
返回值: 无
*/
function setDevInfo(idsArrTemp){
	for(var i=0;i<idsArrTemp.length;i++){
		var arraymode = idsArrTemp[i];
		Add_Row4NewDay1(arraymode);
	}
	var firstTr = jQuery("[name=dayrow]").first();
	var t_sb_id = jQuery(firstTr).find("input[name=t_sb_id]").val();
	if(t_sb_id==""){
		jQuery(firstTr).remove();
	}
}
//添加物品
function Add_Row4NewDay1(model){
	if(model){
		var flag = false;
		jQuery("[name=t_sb_id]").each(function(){
			if(!flag&&this.value == model[0]){
				flag = true;
			}
		})
		if(flag){
			return;
		}
	}
	var t_sb_id = "";//设备ID
	var internal_no = "";//内部编号
	var name = "";//设备名称
	var it = "";//规格型号
	var manufacturer = "";//生产厂家
	var bar_code = "";//条形码
	var body_no = "";//机身号
	var this_calibration_time = "";//上次检定日期
	
	if(!IsSpace(model)){
		t_sb_id = model[0];
		internal_no = model[1];//内部编号
		name = model[2];//设备名称
		it = model[3];
		manufacturer = model[4];
		bar_code = model[5];
		body_no = model[6];
		this_calibration_time = model[7];
	}
	
	var firstTr = jQuery("[name=dayrow]").last().clone();
	
	jQuery(firstTr).find("input[name=t_sb_id]").val(t_sb_id);
	jQuery(firstTr).find("input[name=internal_no]").val(internal_no);
	jQuery(firstTr).find("input[name=name]").val(name);
	jQuery(firstTr).find("input[name=it]").val(it);
	jQuery(firstTr).find("input[name=manufacturer]").val(manufacturer);
	jQuery(firstTr).find("input[name=bar_code]").val(bar_code);
	jQuery(firstTr).find("input[name=body_no]").val(body_no);
	jQuery(firstTr).find("input[name=this_calibration_time]").val(this_calibration_time);
	
	var dayTable = jQuery("#dayTable");
	
	firstTr.appendTo(dayTable);
	
	jQuery(firstTr).find(".date_187").each(function(i,e){
		setDataTimeClickShowOrHide($(this).attr("id"),window);
	})
}

//删除物品
function deleteDay(tag,goodsId){
	var intable=jQuery(tag).parents("table");
	var tr=jQuery(tag).parents("tr").first();
	var trsize= jQuery(intable).find("tr[name=dayrow]").size();
	if(trsize==1){
		Add_Row4NewDay1();
		jQuery(tr).remove();
	}else{
		jQuery(tr).remove();
	}
}

/**
 * 选取人员
 */
var chooseReportUnits = function(){
	var s = new jQuery.z_tree();
	  s.treeID='mian';
	  s.treetypestr="radio";
	  s.ischekc="false";
	  s.isShowSeacher=true;
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.type="APERSON";
	  s.selectedIds=jQuery('#checkuser_id').val();
	  s.returnFunction=function(orgObj){
		  jQuery('#checkuser_id').val(orgObj.id);
		  jQuery('#checkuser_name').val(orgObj.name);
	  }
  	 s.init();
	  
}	
	
</script>
<body style="overflow-x:auto;" class="vcenter">
	<form id="form1" action="devissuedplaninfodo.jsp" method="post"  >
		<input type="hidden" name="plan_id" id="plan_id" value="<%=StringUtil.deNull(bean.get("plan_id"))%>">
		<input type="hidden" name="creater_userid" id="creater_userid" value="<%=StringUtil.deNull(bean.get("creater_userid"))%>">
		<input type="hidden" name="creater_username" id="creater_username" value="<%=StringUtil.deNull(bean.get("creater_username"))%>">
		<input type="hidden" name="unit_id" id="unit_id" value="<%=StringUtil.deNull(bean.get("unit_id"))%>">
		<input type="hidden" name="unit_name" id="unit_name" value="<%=StringUtil.deNull(bean.get("unit_name"))%>">
		<input type='hidden' name='method' id='method' value="<%=actionName %>"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<input type="hidden" name="is_wancheng" id="is_wancheng" >
			<div class="content_02_box" style="width: 985px;" >
			<div class="content_02_box_title_bg" style="width: 98%">
				<span>待检设备列表</span>
				<div class="content_02_box_add">
					<a onclick="openDevAppInfo()" id="addButton"><img src="<%=path%>/ccapp/xtbg/resources/images/add.gif"/>添加设备</a>
				</div>
			</div>
			<div class="content_02_box_div" style="width: 985px;">
			<table id="dayTable" class="content_02_box_div_table_02" width="98%" cellspacing="0" cellpadding="0" border="0">
					 	<tr>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 50px"><span style="color: red">*</span>内部编号</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 50px"><span style="color: red">*</span>设备名称</span></td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 50px">型号规格</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 50px">生产厂家</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 50px">机身号</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 50px">条形码</td>
							<td class="content_02_box_div_table_th" style="text-align: center;width: 50px">上次检定日期</td>
							<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 40px">操作</td>
						</tr>
					    <tr id ="dayrow" name="dayrow">
							<td class="content_02_box_div_table_td"> 
								<input type="hidden" id="t_sb_id" name="t_sb_id" value="" />
								<input type="text" id="internal_no" name="internal_no" value="" class="validate[required,maxSize[100]] input_title_text" readonly="readonly"  style="text-align: center;" />
							</td>
							<td class="content_02_box_div_table_td"> 
								<input type="text" id="name" name="name" value="" class="validate[required,maxSize[100]] input_title_text" readonly="readonly" style="text-align: center;" />
							</td>
							<td class="content_02_box_div_table_td"> 
								<input type="text" id="it" name="it" value="" class="input_title_text" readonly="readonly" style="text-align: center;" />
							</td>
							<td class="content_02_box_div_table_td"> 
								<input type="text" id="manufacturer" name="manufacturer" value="" class="input_title_text" readonly="readonly" style="text-align: center;" />
							</td>
							<td class="content_02_box_div_table_td"> 
								<input type="text" id="body_no" name="body_no" value="" class="input_title_text" readonly="readonly" style="text-align: center;" />
							</td>
							<td class="content_02_box_div_table_td"> 
								<input type="text" id="bar_code" name="bar_code" value="" class="input_title_text" readonly="readonly" style="text-align: center;" />
							</td>
							<td class="content_02_box_div_table_td"> 
								<input type="text" id="this_calibration_time" name="this_calibration_time" value="" class="input_title_text" readonly="readonly" style="text-align: center;" />
							</td>
							<td class="content_02_box_div_table_td"> 
							 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;" >
								<a onClick="deleteDay(this,'')" id="deleteButton" name="deleteButton"> 
								<img src="<%=path%>/ccapp/xtbg/resources/images/del.gif" id="del"/>删除</a>
							 </div>
							</td>
						</tr>  
				</table>
				</div>
			</div>
			<div id="users-contain">
			<div class="content_02_box_title_bg" style="width: 98%">
			<span>基本信息</span>
			<div class="content_02_box_add">
			</div>
			</div>
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th" ><font color="red">*</font>内部编号：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="plan_internal_no" class="input_title_text" id="plan_internal_no" value="<%=StringUtil.deNull(bean.get("plan_internal_no")) %>"/>
						</td>
						<th class="content_02_box_div_table_th" ><font color="red">*</font>核验标题：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="plan_title" class="input_title_text" id="plan_title" value="<%=StringUtil.deNull(bean.get("plan_title")) %>"/>
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>核检负责人：</th>
						<td class="content_02_box_div_table_td">
							<input type="hidden" name="checkuser_id" id="checkuser_id" value="<%=StringUtil.deNull(bean.get("checkuser_id"))%>">
							<input type="text" name="checkuser_name" id="checkuser_name" value="<%=StringUtil.deNull(bean.get("checkuser_name"))%>"
						 class="validate[required,maxSize[100]] input_160" style="width:190px;height=23px"  readonly="readonly" >
							<input name="" type="button" value="" style="margin-left: 5px;" class="but_x" onclick="chooseReportUnits()"/></td>
						</td>
						<th class="content_02_box_div_table_th" ><font color="red">*</font>检验类型：</th>
						<td class="content_02_box_div_table_td">
							<%=checktypeHtml %>
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>计划完成时间：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="compltime" id="compltime" 
							 class="validate[required,maxSize[100]] date_120 Wdate" style="width:200px;height=30px" 
								value="<%=StringUtil.deNull(bean.get("compltime"))%>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})">
						</td>
						<td class="content_02_box_div_table_th" ><font color="red">*</font>完成状态：</td>
						<td class="content_02_box_div_table_td">
							<%=complHtml %>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" >备注：</td>
						<td class="content_02_box_div_table_td" colspan="3">
							<textarea style="width:98%;" rows="7" cols="7" name="remark" class="validate[maxSize[500]]"
							id="remark" ><%=StringUtil.deNull(bean.get("remark"))%></textarea>
						</td>
					</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="取消" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="保存" onclick="Ok()"/>
			<input class="but_y_01" type="button" style="display: none;" id="distribution"  value="已分配" onclick="save(2)"/>
			<input class="but_y_01" type="button" style="display: none;" id="complete"  value="已完成" onclick="save(3)"/>
		</div>
		
	</form>
	
	<iframe name="devissuedplaninfoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>