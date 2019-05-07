<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="archiveformerrorhandler.jsp"%>
<%@taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%@page import="com.chinacreator.security.AccessControl"%>											  
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>                                   
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>                        
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>                                            
<%@page import="java.util.Map"%>                                                                       
<%@page import="java.util.HashMap"%>                                                                   
<%@page import="com.chinacreator.xtbg.core.common.fancyuoload.service.impl.FiletransferServiceImpl"%>  
<%@page import="com.chinacreator.xtbg.core.archive.service.WordArchiveService"%>                       
<%@page import="com.chinacreator.xtbg.core.archive.service.impl.WordArchiveServiceImpl"%>              
<%@page import="com.chinacreator.xtbg.core.archive.entity.FlowMoveBean"%>                              
<%@page import="com.chinacreator.xtbg.core.archive.entity.OfficialDocumentRegisterHandleBean"%>        
<%@page import="com.chinacreator.xtbg.core.form.service.impl.FormserviceImpl"%>        

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String windowsId = request.getParameter("windowsId");
String drag_in_title = "";
String drag_in_attach = "";
String drag_in_webtext = "";
FlowMoveBean fmb = new FlowMoveBean(request);
//正文通过JS搞定
if(fmb.isFlowInFlow()){
String fmb_config = "1,1,1";
fmb_config = (StringUtil.nullOrBlank(fmb_config))?"1,1,1":fmb_config;
String[] fmb_config_arr = fmb_config.split(",");
if(fmb_config_arr[1].equals("1")){
 drag_in_title = request.getParameter("flowTitle");
}
if(fmb_config_arr[2].equals("1")){
 drag_in_attach = StringUtil.getUUID();
 WordArchiveService service = new WordArchiveServiceImpl();
 String mFilePath = request.getSession().getServletContext().getRealPath("")+FiletransferServiceImpl.upload_To_SeverPath;
 Map<String,String> argMap = new HashMap<String,String>();
 argMap.put("flowTitle", request.getParameter("flowTitle"));
 argMap.put("textIdYW", null);
 argMap.put("textIdMQ", null);
 argMap.put("textIdZBD", null);
 argMap.put("attachId", drag_in_attach);
 argMap.put("oldAttachId", request.getParameter("oldAttachId"));
 argMap.put("mFilePath", mFilePath);
 argMap.put("userId", accesscontroler.getUserID());
 Map<String,String> messMap = service.copyAttachForNewFlow(argMap); 
}
}
OfficialDocumentRegisterHandleBean ofr = new OfficialDocumentRegisterHandleBean(request,true);							
if(ofr.isGWDJ()){                                                                                               
	String gwdj = request.getParameter(OfficialDocumentRegisterHandleBean.OFF_DOC_REG_ID);                             
	String mFilePath = request.getSession().getServletContext().getRealPath("")+FiletransferServiceImpl.upload_To_SeverPath;
	String userId = accesscontroler.getUserID();                                                                            
	WordArchiveService service = new WordArchiveServiceImpl();                                                              
	Object mess[] = service.getOfficialDocumentRegisterMess(gwdj, null, mFilePath, userId);                                 
	if(mess!=null&&mess.length>0){                                                                                                      
		Map<String,String> map = (Map<String,String>)mess[0];                                                                 
		drag_in_title = StringUtil.deNull(map.get(FormserviceImpl.DRAG_IN_TITLE));                                            
		drag_in_attach = StringUtil.deNull(map.get(FormserviceImpl.DRAG_IN_ATTACH));                                          
	}                                                                                                                       
}                                                                                                                        
com.chinacreator.xtbg.core.form.entity.PageInitHandlerBean pihBean = new com.chinacreator.xtbg.core.form.entity.PageInitHandlerBean();
Map<String,String> pihBeanmap = pihBean.getPageDefaultData(request,response);
String user_id = pihBeanmap.get("user_id");
String user_name = pihBeanmap.get("user_name");
String org_id = pihBeanmap.get("org_id");
String org_name = pihBeanmap.get("org_name");
String unit_id = pihBeanmap.get("unit_id");
String unit_name = pihBeanmap.get("unit_name");
String time = pihBeanmap.get("time");
String date = pihBeanmap.get("date");
String user_worktel = pihBeanmap.get("user_worktel");
String user_mobiletel1 = pihBeanmap.get("user_mobiletel1");

String busi_id = request.getParameter("busi_id")!=null?request.getParameter("busi_id"):"";
//当前环节
String action_defid = request.getParameter("action_defid");
%>

<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
  <title>武汉特检院用车申请</title>
  <script>jQuery(function(){ //DOM Ready
	initGridster();
	getCarList();
	
	jQuery("#TA_OA_WHTJY_YONGCHE__ASSIGNED_VEHICLE").change(function(){
		var type = jQuery(this).children('option:selected').val();
		getCarDriver(type);
	});
});
//.do页面的回调函数，将验证框架里的isSubmit重置，用来防止提交失败后再提交失效。
function resetSubmit(){
	jQuery("#form1").resetSubmit(false);
}

function initGridster(){
	jQuery(".gridster ul").gridster({
			widget_margins: [0.5, 0.5],//元素间隔
			widget_base_dimensions: [30,30],//初始化宽度 
			avoid_overlapped_widgets: true,  //不可以重叠
			max_size_y: 35,				//最多可以添加行数
			max_size_x: 35,				//最多可以添加列数
			max_cols: 35
			//collision:{on_overlap_stop: function(collider_data){ }}
	  });
   jQuery(".gridster ul li").each(function(){//将LI设置为不可拖拽
	   jQuery(".gridster ul").gridster().data('gridster').disable(jQuery(this));
   });
   }
function initPageObj(){
	jQuery("#"+jQuery("#field_drag_in_title").val()).focus();
   }
var path = "<%=path %>";
function getCarList(){
	var car_id = "<%=busi_id %>";
	jQuery.ajax({
		url:path+"/ccapp/oa/archive/whtjycheliangguanlido.jsp",
		data:{"method":"getCarList","car_id":car_id,"tableName":"TA_OA_WHTJY_YONGCHE"},
		type:'post',dataType:'json',
		contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		success:function(data){
			if(data){//成功
				jQuery("#TA_OA_WHTJY_YONGCHE__ASSIGNED_VEHICLE").append(data.result);
			}
		}
	});
}  

function getCarDriver(car_id){
	jQuery.ajax({
		url:path+"/ccapp/oa/archive/whtjycheliangguanlido.jsp",
		data:{"method":"getCarInfo","car_id":car_id},
		type:'post',dataType:'json',
		contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		success:function(data){
			if(data){//成功
				jQuery("#TA_OA_WHTJY_YONGCHE__DIRVER").val(data.result);
			}
		}
	});
}

//点击完成
var afterActionSuccessFn=function(){
	getParentWindow('<%=windowsId%>').location.href = "<%=path%>/ccapp/xtbg/tjy/processing/mainhandlist.jsp";
	removeAlertWindows('<%=windowsId%>',true);
	
};


//用车地点选择
function selLocationType(){
	 if("市内用车" == jQuery("#TA_OA_WHTJY_YONGCHE__VEHICLE_LOCATION").val()){
			jQuery("#fgyld_view input:first-child").hide();
		}else{
			jQuery("#fgyld_view input:first-child").show();
	 }
}

</script>
	
	<style>
		body{
			font-family: Helvetica, arial, sans-serif;
			margin:10px auto;
			color: #fff;
			font-size: 12px;
			width:931px;
			text-align:center;
		}
		ul{	
			background:black;
			list-style:none;
			border: solid 1px black;
		}
		li{	
			border-collapse:collapse;
			color: black;
			margin:-0.5px;
			text-align: left;
			line-height: 100%;
			font: normal;
		}
	</style>

</head>
<body style="width:931px">
<form id="form1" name="form1" action="" method="post">
<input id="busi_id" name="busi_id" type="hidden"/>
<input id="opt_type" name="opt_type" type="hidden"/>
<input id="busiTypeCode" name="busiTypeCode" type="hidden"/>
<input id="action_defid" name="action_defid" type="hidden" value="<%=action_defid %>"/>
<input id="windowsId" name="windowsId" type="hidden" value="<%=windowsId %>"/>
<oa:input type='hidden' column='USER_ID' table='TA_OA_WHTJY_YONGCHE' value='<%=user_id%>' /><oa:input type='hidden' column='USER_NAME' table='TA_OA_WHTJY_YONGCHE' value='<%=user_name%>' /><oa:input type='hidden' column='CREATED' table='TA_OA_WHTJY_YONGCHE' value='<%=time%>' /><oa:input type='hidden' column='ORG_ID' table='TA_OA_WHTJY_YONGCHE' value='<%=org_id%>' />
<div id="tabs1" style="width:100%;border: 0px;">
		<table width="100%" border="0" cellspacing="1" cellpadding="0" style="display: inline;">
			<tr style="height:60px">
				<td style="display: inline;"><oa:flowcommonstart flowType="1" />
				</td>
			</tr>
		</table>
		<div id="titleids" style="display:none;">
			<ul>
				<li><a href="#tabs-1" onclick="changeIndex(1)">基本信息</a></li>
							</ul>
		</div>
		<div id="tabs-1">
			<article>
				<section>
				<div class="gridster">
					<ul>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; MARGIN-BOTTOM: -1px; BACKGROUND: white; HEIGHT: 62px"
									id=e6876489-26c3-4a70-a39f-e8a340cce883 class=gs_w data-col="1"
									data-row="1" data-sizex="30" data-sizey="2"><oa:span
										style='font-size: 35px; color: #000000; padding-left: 25%; line-height: 60px;'
										column='null' table='' value='湖北特种设备检验检测研究院' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=24135c92-6ef8-463f-bdbf-2b97ef3bcea5 class=gs_w data-col="1"
									data-row="3" data-sizex="30" data-sizey="1"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 45%; line-height: 30px;'
										column='null' table='' value='车 辆 申 请' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=c9b91d75-6490-4294-ab26-b85386289660 class=gs_w data-col="1"
									data-row="4" data-sizex="5" data-sizey="1"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='用车人' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=4502c97e-d90f-4e21-9a41-892ceb98bf9e class=gs_w data-col="6"
									data-row="4" data-sizex="10" data-sizey="1"><oa:input
										title='' type='text' column='PASSENGER_CAR'
										table='TA_OA_WHTJY_YONGCHE'
										style='width: 97%;border: 0px;line-height:26px; height:26px;'
										value='' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=70655bb6-ebb4-4149-9a72-e03a409ac504 class=gs_w
									data-col="16" data-row="4" data-sizex="5" data-sizey="1"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='申请时间' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=a2c87bf3-ffcb-4b99-8c67-c9c1abc12f7c class=gs_w
									data-col="21" data-row="4" data-sizex="10" data-sizey="1"><oa:input
										title='' type='text' column='APPLICATION_TIME'
										table='TA_OA_WHTJY_YONGCHE'
										style='width: 97%;border: 0px;line-height:26px; height:26px;'
										value='<%=time%>' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=ea79a72e-a357-40db-b720-200847e568dc class=gs_w data-col="1"
									data-row="5" data-sizex="5" data-sizey="2"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='计划用车开始时间' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=87cf3d09-48e7-428e-8644-54852f702877 class=gs_w data-col="6"
									data-row="5" data-sizex="10" data-sizey="2"><oa:date
										dateFmt='yyyy-MM-dd HH:mm:ss' column='CAR_START_TIME'
										table='TA_OA_WHTJY_YONGCHE' title=''
										style='height:22px;line-height: 22px;float:left;margin-top:3px; width: 165px;'
										other="class='Wdate'" />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=bf875860-04ab-439b-8415-8b83a6568d94 class=gs_w
									data-col="16" data-row="5" data-sizex="5" data-sizey="2"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='计划用车结束时间' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=50692cad-b0ed-4d9a-b478-f9fc30dd446f class=gs_w
									data-col="21" data-row="5" data-sizex="10" data-sizey="2"><oa:date
										dateFmt='yyyy-MM-dd HH:mm:ss' column='CAR_END_TIME'
										table='TA_OA_WHTJY_YONGCHE' title=''
										style='height:22px;line-height: 22px;float:left;margin-top:3px; width: 165px;'
										other="class='Wdate'" />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=976264be-b0e0-4c8a-b3df-fd391dbd840f class=gs_w data-col="1"
									data-row="7" data-sizex="5" data-sizey="4"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='用车事由' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=102a808b-5cdb-47d8-aa80-95ef661a3d2d class=gs_w data-col="6"
									data-row="7" data-sizex="25" data-sizey="4"><oa:textarea
										column='VEHICLE_CAUSERS' table='TA_OA_WHTJY_YONGCHE' title=''
										style='border: 1;width:98%; height: 110px; overflow: auto;' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=92aa88a3-717d-46ff-b63c-00dc023f1b65 class=gs_w data-col="1"
									data-row="11" data-sizex="5" data-sizey="1"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='用车地点' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=30331b25-f3dd-4dc0-80ec-511aef8ab914 class=gs_w data-col="6"
									data-row="11" data-sizex="10" data-sizey="1">
									<!--<oa:input
										title='' type='text' column='VEHICLE_LOCATION'
										table='TA_OA_WHTJY_YONGCHE'
										style='width: 97%;border: 0px;line-height:26px; height:26px;'
										value='' />-->
																				
										<oa:select column='VEHICLE_LOCATION' table='TA_OA_WHTJY_YONGCHE' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' other="onchange = 'selLocationType()' class=''" title =''>
											<oa:option optionName='请选择' optionValue='' />
											<oa:option optionName='市内用车' optionValue='市内用车' />
											<oa:option optionName='市外用车' optionValue='市外用车' />
										</oa:select>
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=5c86cf10-da84-4077-ab12-7f3265d8a640 class=gs_w
									data-col="16" data-row="11" data-sizex="5" data-sizey="1"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='详细地点' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=5d4f9880-d5be-4f1f-b334-e33a92b4f9b4 class=gs_w
									data-col="21" data-row="11" data-sizex="10" data-sizey="1"><oa:input
										title='' type='text' column='DETAIL_LOCATION'
										table='TA_OA_WHTJY_YONGCHE'
										style='width: 97%;border: 0px;line-height:26px; height:26px;'
										value='' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=bee81629-7c63-449d-85fb-c997da259fe2 class=gs_w data-col="1"
									data-row="12" data-sizex="5" data-sizey="1"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='指派车辆' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=8ab9f0e2-9646-4107-96d8-c582b7ccbb53 class=gs_w data-col="6"
									data-row="12" data-sizex="10" data-sizey="1"><oa:select
										column='ASSIGNED_VEHICLE' table='TA_OA_WHTJY_YONGCHE'
										style='width: 50%;line-height:22px; height:22px;margin-top:3px;'
										title=''></oa:select>
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=37225133-5d7c-428c-a20c-97a8bc098059 class=gs_w
									data-col="16" data-row="12" data-sizex="5" data-sizey="1"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='司机' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=728d9868-eef5-4668-8362-50de7235b661 class=gs_w
									data-col="21" data-row="12" data-sizex="10" data-sizey="1"><oa:input
										title='' type='text' column='DIRVER'
										table='TA_OA_WHTJY_YONGCHE'
										style='width: 97%;border: 0px;line-height:26px; height:26px;'
										value='' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=1863e4d2-a79b-4547-a685-5d1bfa4c79ce class=gs_w data-col="1"
									data-row="13" data-sizex="5" data-sizey="1"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='实际回车时间' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=fc506521-2aab-48ca-af4c-014cea0fb2af class=gs_w data-col="6"
									data-row="13" data-sizex="10" data-sizey="1"><oa:date
										dateFmt='yyyy-MM-dd HH:mm:ss' column='RETURN_TIME'
										table='TA_OA_WHTJY_YONGCHE' title=''
										style='width: 97%;border: 0px;line-height:26px; height:26px;'
										other="class='Wdate'" />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=485dd60c-cc8b-43e1-8fcf-866ef13076b2 class=gs_w
									data-col="16" data-row="13" data-sizex="5" data-sizey="1"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='行驶里程' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=5859f277-f0f2-43fb-8647-76e7dc910095 class=gs_w
									data-col="21" data-row="13" data-sizex="10" data-sizey="1"><oa:input
										title='' type='text' column='DRIVING_RANGE'
										table='TA_OA_WHTJY_YONGCHE'
										style='width: 97%;border: 0px;line-height:26px; height:26px;'
										value='（公里数）' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=dd3f29fe-973d-4d6b-8fa7-bf01adeb2855 class=gs_w data-col="1"
									data-row="14" data-sizex="5" data-sizey="3"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='备注' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=ddb53f50-99d7-4627-a81b-551c4677f54e class=gs_w data-col="6"
									data-row="14" data-sizex="25" data-sizey="3"><oa:textarea
										column='REMARK' table='TA_OA_WHTJY_YONGCHE' title=''
										style='border: 1;width:98%; height: 80px; overflow: auto;' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=b68d622f-19b7-44a8-9eea-6197769b4f0e class=gs_w data-col="1"
									data-row="17" data-sizex="5" data-sizey="1"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='申请人' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=79299031-ae56-4a7b-8d56-a0a2491573a2 class=gs_w data-col="6"
									data-row="17" data-sizex="25" data-sizey="1"><oa:input
										title='' type='text' column='APPLICANT'
										table='TA_OA_WHTJY_YONGCHE'
										style='width: 97%;border: 0px;line-height:26px; height:26px;'
										value='<%=user_name%>' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=6bed098f-b1ba-496d-8033-2da9639d9eba class=gs_w data-col="1"
									data-row="18" data-sizex="5" data-sizey="5"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='部门负责人审核' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=4c1ee20d-6fd7-494f-93c5-bd5354f9073d class=gs_w data-col="6"
									data-row="18" data-sizex="25" data-sizey="5"><oa:view
										column='DEPT_OPINION' table='TA_OA_WHTJY_YONGCHE' title=''
										style='border:0;width:98%; height: 120px; overflow: auto;'
										cntab='uuuu,tt' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=9f5fd401-b5d6-4aba-af59-7d3a525003b9 class=gs_w data-col="1"
									data-row="23" data-sizex="5" data-sizey="5"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='后勤保障部负责人审核' />
								</LI>
								<LI
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=5a753f69-c346-4f1a-a7f1-0785c0f831a1 class=gs_w data-col="6"
									data-row="23" data-sizex="25" data-sizey="5"><oa:view
										column='LOGISTICS_OPINION' table='TA_OA_WHTJY_YONGCHE'
										title=''
										style='border:0;width:98%; height: 120px; overflow: auto;'
										cntab='uuuu,tt' />
								</LI>
								<LI id="fgyld"
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=50dc8bb4-0a42-4f97-9fff-e741ebb10cb6 class=gs_w data-col="1"
									data-row="28" data-sizex="5" data-sizey="5"><oa:span
										style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;'
										column='null' table='' value='分管院领导审批' />
								</LI>
								<LI id="fgyld_view"
									style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
									id=5a61645c-141c-4dce-971b-3663a90c2b79 class=gs_w data-col="6"
									data-row="28" data-sizex="25" data-sizey="5"><oa:view
										column='LEAD_OPINION' table='TA_OA_WHTJY_YONGCHE' title=''
										style='border:0;width:98%; height: 120px; overflow: auto;display: none;'
										cntab='uuuu,tt' other="readonly='readonly' "/>
								</LI>
							</ul>
			    </div>		
				</section>
			</article>
		</div>
		</div>	    		
<div style="height:50px">
</div>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</form>
</body>
</oa:init>
</html>
<script>jQuery(function(){ //DOM Ready
	initPageObj();
});
</script>
