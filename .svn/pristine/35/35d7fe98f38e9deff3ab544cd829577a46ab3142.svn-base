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
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
accesscontroler.checkAccess(request, response);
String windowsId = request.getParameter("windowsId");
//流程环节
String action_defid = StringUtil.deNull(request.getParameter("action_defid"));
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

%>

<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
  <title>党委发文稿纸</title>
  <script>
  var action_defid ="<%=action_defid%>";
  jQuery(function(){ //DOM Ready
	initGridster();
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
		var busiTypeCode = jQuery("#busiTypeCode").val();
		jQuery("#"+jQuery("#field_drag_in_title").val()).focus();
		if(action_defid==""){
			jQuery("#tabs1" ).tabs({selected:1}); 
			var is_red = jQuery("#is_red").val();
			//套红
			if(is_red=="1"){
				scroll(0,0);
				myWordTemplateTaohong(busiTypeCode); //套红
				
			}
		}
   }
   
function myWordTemplateTaohong(busiTypeCode){
	openAlertWindows('windowId',jQuery("#path").val()+'/ccapp/oa/archive/thwordtemplateviewlist.jsp?windowsId=windowId&busiTypeCode='+busiTypeCode,'选择套红模版',800,340,'25%','25%',closeAlertWindow);
	//隐藏金格控件
	jQuery("#webofficDiv").hide();
}
   
   //选择好套红模板后，点击【确定】按钮完成套红模板的套用，并按照对应关系选择好文号字段的文种，当前年份，选择当前用户为签发人，签发时间为当前时间，空置文号。
   function creatorFwzh(mb_mc){
		var busiTypeCode = jQuery("#busiTypeCode").val();
		if(action_defid==""&&busiTypeCode=="uuid-1104"){
			var myDate = new Date();
			var busi_id = jQuery("#busi_id").val();
			//截取字号（后面的文字
			if(mb_mc.indexOf("（")>-1){
				mb_mc = mb_mc.substr(0,mb_mc.indexOf("（"));
			}
			var number_type = mb_mc;
			var number_year = myDate.getFullYear();
			serialnumberNo(busi_id,number_type,number_year);
			
			jQuery("#OA_FILE_FAWEN__FW_FWZ").val(number_type+"〔"+number_year+"〕      号");
		}
   }
   
   /**
    * 选择套红模版后，点击【确定】。编号保存
    */
   function serialnumberNo(busi_id,number_type,number_year){
   	var url=jQuery("#path").val()+"/ccapp/oa/archive/ajaxserialnumber.jsp";
   	var params =  {busi_id:busi_id,number_type:number_type,number_year:number_year};
   	jQuery.ajax({
   		url: url,
   		type: 'POST',
   		dataType:'json',
   		data: params,
   		async:false,
   		success: function(data){
   			if(data.result=="true"){
   				jQuery("#OA_FILE_FAWEN__FW_FWZ").val(number_type+"〔"+number_year+"〕         号");
   			} 
   		},
   		error: function(jqXHR, textStatus, errorThrown){
   			checkFile = false;
   		}
   	})
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
			background:red;
			list-style:none;
			border: solid 1px red;
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
								<li><a href="#tabs-3" title="点击加载正文" onclick="changeIndex(3)">正文</a></li>
							</ul>
		</div>
		<div id="tabs-1">
			<article>
				<section>
				<div class="gridster">
					<ul>
					<LI style="BACKGROUND-COLOR: white; ZOOM: 1; DISPLAY: list-item" id=6982df76-17a5-48b3-8616-3236ad2450b6 class=gs_w data-sizey="2" data-sizex="30" data-row="1" data-col="1"><oa:span style='font-size: 30px; color: #ff0000; line-height: 60px;display:block;height:100%;width:100%;text-align:center;letter-spacing:6px;' column='null'  table='' value= '湖南省特种设备检验检测研究院发文稿纸' /></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 62px; ZOOM: 1; DISPLAY: list-item; MARGIN-RIGHT: -1.5px" id=a7a9e297-8ac7-4377-bde7-c404656bbdde class=gs_w data-sizey="1" data-sizex="2" data-row="3" data-col="11"><oa:span style='font-size: 15px; color: red; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '日期' /></LI>
<LI style="BACKGROUND-COLOR: white; ZOOM: 1; DISPLAY: list-item" id=6f5be778-4868-4c74-850f-dca561af55bd class=gs_w data-sizey="1" data-sizex="6" data-row="3" data-col="13"><oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='FW_DATE2' table='OA_FILE_FAWEN' title ='' style='width: 90%;height:22px;line-height:22px;float:left;margin-top:3px;' other="class='Wdate'"/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; MARGIN-RIGHT: -1.5px" id=963afddf-3761-49db-b2bb-93c8bd584f1a class=gs_w data-sizey="1" data-sizex="3" data-row="3" data-col="19"><oa:span style='font-size: 15px; color: red; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '缓急' /></LI>
<LI style="WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=86fd814a-30f5-4f2e-8e68-1c7b96d6b946 class=gs_w data-sizey="1" data-sizex="3" data-row="3" data-col="22"> <oa:select column='FW_PRIO' table='OA_FILE_FAWEN' style ='width: 90%;line-height:22px; height:22px;margin-top:3px;' title =''><oa:option optionName='一般' optionValue=' 一般' /><oa:option optionName='急' optionValue='急' /><oa:option optionName='特急' optionValue='特急' /></oa:select></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; MARGIN-RIGHT: -1.5px" id=8442ac85-d27a-4422-99bc-52f37c8c0468 class=gs_w data-sizey="1" data-sizex="3" data-row="3" data-col="25"><oa:span style='font-size: 15px; color: red; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '密级' /></LI>
<LI style="ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=8f3054c9-ac29-40be-b43f-50ecb67dfb3f class=gs_w data-sizey="1" data-sizex="3" data-row="3" data-col="28"> <oa:select column='FW_SECUR' table='OA_FILE_FAWEN' style ='width: 90%;line-height:22px; height:22px;margin-top:3px;' title =''><oa:option optionName='公开' optionValue='公开' /><oa:option optionName='秘密' optionValue='秘密' /><oa:option optionName='特密' optionValue='特密' /></oa:select></LI>
<LI style="WIDTH: 62px; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=f719ee0b-7ba5-47ac-99ac-563b0d9692d2 class=gs_w data-sizey="10" data-sizex="2" data-row="4" data-col="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '签发' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=27997d9c-0f43-49da-88d5-d81f9224fb94 class=gs_w data-sizey="10" data-sizex="13" data-row="4" data-col="3"><oa:view column='FW_QFVIEW' table='OA_FILE_FAWEN' title ='' style='border:0;width:92%; height: 80%; overflow: auto;margin-top:4px;margin-left:4%' cntab='uuuu,tt' /></LI>
<LI style="WIDTH: 62px; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=614cc209-bf39-42a2-8461-fdb5e4bcba4c class=gs_w data-sizey="6" data-sizex="2" data-row="4" data-col="16"><oa:span style='font-size: 15px; color: red; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '会签' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=e2492637-b3ca-4e94-92c2-1bc11cfd016a class=gs_w data-sizey="6" data-sizex="13" data-row="4" data-col="18"><oa:view column='FW_HQVIEW' table='OA_FILE_FAWEN' title ='' style='border:0;width:92%; height: 80%; overflow: auto;margin-top:4px;margin-left:4%' cntab='uuuu,tt' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=ddd56076-bbcf-4c42-ad5e-1e8d7f85154a class=gs_w data-sizey="2" data-sizex="2" data-row="14" data-col="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 60px;' column='null'  table='' value= '主送' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=288fe5f5-3f51-4fcb-8e6e-e45bd51ce9d8 class=gs_w data-sizey="2" data-sizex="28" data-row="14" data-col="3"><oa:input title='' type='text' column='FW_PRIM' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:50%;padding-top:16px;padding-left:10px;' value = ''/></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=7565306c-9e3b-428e-b89d-aff2a55132f5 class=gs_w data-sizey="2" data-sizex="2" data-row="16" data-col="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 60px;' column='null'  table='' value= '抄送' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=1bdc15ee-a1b3-4d80-999e-bc35cab2e2fb class=gs_w data-sizey="2" data-sizex="28" data-row="16" data-col="3"><oa:input title='' type='text' column='FW_SENIO' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:50%;padding-top:16px;padding-left:10px;' value = ''/></LI>
<LI style="WIDTH: 124px; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=deb73c4a-2fb1-4925-8eeb-750f0fa9e7d9 class=gs_w data-sizey="1" data-sizex="4" data-row="18" data-col="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '拟稿单位' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=c62718cd-69ab-4143-bb05-6b6a002f4281 class=gs_w data-sizey="1" data-sizex="8" data-row="18" data-col="5"><oa:input title='' type='text' column='FW_DRAFTUNIT' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=org_name%>'/></LI>
<LI style="WIDTH: 93px; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=06b266f5-e95d-4bcd-9fd9-139a7b630d3b class=gs_w data-sizey="1" data-sizex="3" data-row="18" data-col="13"><oa:span style='color:red;font-size: 15px; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '拟稿' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=4563ec71-4f6c-4f9f-a913-1fbf2f9a1b5e class=gs_w data-sizey="1" data-sizex="6" data-row="18" data-col="16"><oa:input title='' type='text' column='FW_DRAFTMAN' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="WIDTH: 93px; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=30254135-12c6-4ce7-b67e-480d7ab39fde class=gs_w data-sizey="1" data-sizex="3" data-row="18" data-col="22"><oa:span style='color:red;font-size: 15px; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '核稿' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=e2862fff-295f-4d88-8863-5625f40e4c56 class=gs_w data-sizey="1" data-sizex="6" data-row="18" data-col="25"><oa:input title='' type='text' column='FW_AUDIT' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="WIDTH: 124px; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=2ed5a093-522e-46ac-8172-c785642b17fc class=gs_w data-sizey="1" data-sizex="4" data-row="19" data-col="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '院办核稿' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=106537cf-2ef8-498c-bcbf-5c76fc608523 class=gs_w data-sizey="1" data-sizex="8" data-row="19" data-col="5"><oa:input title='' type='text' column='FW_OFFICEAUDIT' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="WIDTH: 93px; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=4ef8d69a-df74-45ba-957f-1c20b902ca10 class=gs_w data-sizey="1" data-sizex="3" data-row="19" data-col="13"><oa:span style='color:red;font-size: 15px; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '封发' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=4d3fb229-93e2-4e71-9261-bbc92f90bc6e class=gs_w data-sizey="1" data-sizex="15" data-row="19" data-col="16"><oa:input title='' type='text' column='FW_DISTRIBUT' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="WIDTH: 124px; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=6e984f5e-b444-4142-8548-bbff5e862704 class=gs_w data-sizey="1" data-sizex="4" data-row="20" data-col="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '打字印刷' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=272c8871-edda-4a39-846c-1c7156ce0a69 class=gs_w data-sizey="1" data-sizex="8" data-row="20" data-col="5"><oa:input title='' type='text' column='FW_PRINT' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="WIDTH: 93px; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=639388a8-136c-44e6-a6d6-caa2599773c0 class=gs_w data-sizey="1" data-sizex="3" data-row="20" data-col="13"><oa:span style='color:red;font-size: 15px; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '校对' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=b08d33e2-88eb-4959-aa0a-dbfbddcb57b6 class=gs_w data-sizey="1" data-sizex="6" data-row="20" data-col="16"><oa:input title='' type='text' column='FW_CHECK' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="WIDTH: 93px; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=5b77121f-3222-4745-aa64-625ccf2dc307 class=gs_w data-sizey="1" data-sizex="3" data-row="20" data-col="22"><oa:span style='color:red;font-size: 15px; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '份数' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=e4a67f8d-8f42-47bc-8590-a120db6079b3 class=gs_w data-sizey="1" data-sizex="6" data-row="20" data-col="25"><oa:input title='' type='text' column='FW_COPIES' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI style="WIDTH: 124px; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=bce9dbc9-49e7-4b53-9b3f-7faf0cc9ad19 class=gs_w data-sizey="2" data-sizex="4" data-row="21" data-col="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 60px;' column='null'  table='' value= '附件' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=d43edb15-4852-4ebe-8dc9-48ae31ff4401 class=gs_w data-sizey="2" data-sizex="8" data-row="21" data-col="5"><input type='hidden' id='field_drag_in_attach' value='OA_FILE_FAWEN__T_FJ_ID'/><oa:affixbut butName='请选择文件' column='T_FJ_ID' table='OA_FILE_FAWEN'  title ='' operType='111' initFjDJBHForArchive ='<%=drag_in_attach%>' />
<br/><span style="width: 250px;height:60px;float: left;color: red;font-weight:bold;" >附件列表仅保存传阅性附件不能编辑或审批只能查阅。若要上传待审批的附件请将附件内容粘贴在正文后面。</span>
</LI>
<LI style="WIDTH: 124px; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=5f9f9244-ac1d-4876-9d13-6d735dd302ca class="gs_w player-revert" data-sizey="2" data-sizex="4" data-row="21" data-col="13"><oa:span style='color:red;font-size: 15px; padding-left: 23%; line-height: 60px;' column='null'  table='' value= '附件列表' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=16fa33e8-28eb-4775-b366-368a0bb886be class=gs_w data-sizey="2" data-sizex="14" data-row="21" data-col="17"><oa:affixshow  title =''  style='height:55px;line-height:55px; background-color: white;' 
										ulstyle='overflow-y: auto;overflow-x:hidden;height:55px;line-height:55px;margin:4px ;padding-left:10px;background:white;border:0px;max-height:55px;background:white;border:0;' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=ef0a3c7a-b199-4c97-8dbc-860a1a9894c9 class=gs_w data-sizey="1" data-sizex="4" data-row="23" data-col="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '主题词' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=df28c598-bf34-4947-a1a7-c3af54e7a930 class=gs_w data-sizey="1" data-sizex="26" data-row="23" data-col="5"><oa:input title='' type='text' column='FW_KEYWORDS' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;padding-left:10px;' value = ''/></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=084932db-18a7-407e-9fc6-3ae41587519e class=gs_w data-sizey="2" data-sizex="4" data-row="24" data-col="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 60px;' column='null'  table='' value= '标题' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=915110d4-bd19-4e3f-9315-8ad7575304ab class=gs_w data-sizey="2" data-sizex="26" data-row="24" data-col="5"><input type='hidden' id='field_drag_in_title' value='OA_FILE_FAWEN__TITLE'/><oa:input title='' type='text' column='TITLE' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:50%;padding-top:16px;padding-left:10px;' value = '<%=drag_in_title%>'/></LI>
<LI style="POSITION: absolute; BACKGROUND-COLOR: white; WIDTH: 310px; DISPLAY: list-item; MARGIN-RIGHT: -1px" id=fc44c245-f04e-45c0-805d-ee613a9b7987 class=gs_w data-sizey="1" data-sizex="10" data-row="3" data-col="1"><input type='hidden' id='field_drag_in_number' value='OA_FILE_FAWEN__FW_FWZ'/><oa:numberinput title='' column='FW_FWZ' table='OA_FILE_FAWEN' style= 'width: 70%;border: 0px;line-height:26px; height:26px;float:right;margin-right:3%;'/></LI>
<LI style="WIDTH: 62px; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=80ef9979-9274-401e-8cc7-5fc79be9d4d2 class=gs_w data-sizey="4" data-sizex="2" data-row="10" data-col="16"><oa:span style='width:50%;display:block;font-size: 15px; color: red; margin-left:35%;margin-top:20%;line-height: 20px;2' column='null'  table='' value= '分管领导意见' /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=4a4aa594-74da-407d-abb9-ebc2258ad29a class=gs_w data-sizey="4" data-sizex="13" data-row="10" data-col="18"><oa:view column='FW_VICEVIEW' table='OA_FILE_FAWEN' title ='' style='display:block;border:0;width:90%; margin-left:2%;margin-top:2%;width:96%;height: 75%; overflow: auto;' cntab='uuuu,tt' /></LI>
					</ul>
			    </div>		
				</section>
			</article>
		</div>
				<div id="tabs-3">
			<oa:webtext column="T_ZW_ID" table="OA_FILE_FAWEN" defautValue="<%=drag_in_webtext%>"/>
			<input type='hidden' id='field_drag_in_webtext' value="OA_FILE_FAWEN__T_ZW_ID"/>
			<input 	type='hidden' id='attach_id_name' value='OA_FILE_FAWEN__T_FJ_ID' />
		</div>	
		</div>	    		
<div style="height:50px">
</div>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</form>


<form id="form_print" style="display: none;">
	<table  align="center" border="0" bordercolor="#ff0000" width="100%" cellspacing="1" cellpadding="0"  style="margin-left: 15px;margin-right: 15px; display: inline;">
      <tr>
        <td style="padding-bottom:10px;">
       	<div align='center'><span style='font-size: 30px; color: #ff0000; line-height: 60px;display:block;height:100%;width:100%;text-align:center;letter-spacing:6px;'>湖南省特种设备检验检测研究院 </br></span></div>	
        <table width="100%" border="0" align="center" cellpadding="5px" cellspacing="1" class="f_main" 
            style="font-size:12px;font-family: 宋体;background: #ff0000;line-height:30px; ">
          	  <tr>
		             <td  valign="top" style="background:#ffffff" width="15%" colspan="2">
		  				<span style="width: 90%;border: 0px; font-size: 20px;" id="print_fwz"></span>
		            </td>
		            <td  valign="top" style="background:#ffffff;text-align: center;" width="8%">
		                <span style="font-size: 20px; color: red; line-height: 30px;" >日期</span>
		            </td> 
		             <td  valign="top" style="background:#FFFFFF;" width="30%" >
		                <span style="border:0;width:95%; height: 30px; overflow: auto;font-size: 20px;" id="print_fw_date2"></span>
		            </td>
		            <td  valign="top" style="background:#ffffff;text-align: center;" width="10%">
		                <span style="font-size: 20px; color: red; line-height: 30px;" >缓急 </span>
		            </td> 
		             <td  valign="top" style="background:#FFFFFF;" width="10%" >
		                <span style="border:0;width:95%; height: 30px; overflow: auto;font-size: 20px;" id="print_fw_prio"></span>
		            </td>
		            <td  valign="top" style="background:#ffffff;text-align: center;" width="10%">
		                <span style="font-size: 20px; color: red; line-height: 30px;" >密级 </span>
		            </td> 
		             <td  valign="top" style="background:#FFFFFF;" width="15%" >
		                <span style="border:0;width:95%; height: 30px; overflow: auto;font-size: 20px;" id="print_fw_secur"></span>
		            </td>
	          </tr>
	          <tr>
		            <td  valign="top" style="background:#ffffff;text-align: center;" width="10%" rowspan="2">
		  				<span style="font-size: 20px; color: red;line-height: 30px;">签发</span>
		            </td>
		             <td  valign="top" style="background:#ffffff" width="40%" colspan="3" rowspan="2">
		  				<span style="width: 90%;border: 0px; height: 190px;font-size: 20px;" id="print_fw_qfview"></span>
		            </td>
		            <td  valign="top" style="background:#ffffff;text-align: center;" width="10%" height="400px;">
		                <span style="font-size: 20px; color: red;line-height: 30px;">会签</span>
		            </td> 
		            <td  valign="top" style="background:#ffffff" width="40%" colspan="3">
		  				<span style="width: 90%;border: 0px; height: 190px;font-size: 20px;" id="print_fw_hqview"></span>
		            </td>
	          </tr>
	          <tr>
	          	 	<td  valign="top" style="background:#ffffff" width="10%" height="120px;">
		                <span style="font-size: 20px; color: red;line-height: 30px;">分管领导<br>&nbsp;&nbsp;意见</span>
		            </td> 
		            <td  valign="top" style="background:#ffffff" width="40%" colspan="3">
		  				<span style="width: 90%;border: 0px; height: 190px;font-size: 20px;" id="print_fw_viceview"></span>
		            </td>
	          </tr>
	           <tr>
		            <td  valign="top" style="background:#ffffff;text-align: center;" height="60px">
		                <span style="font-size: 20px; color: red; line-height: 60px;" >主送 </span>
		            </td> 
		             <td  valign="top" style="background:#FFFFFF;" colspan="7">
		                <span style="width: 90%;border: 0px;line-height:60px; font-size: 20px;margin-top:18px;" id="print_fw_prim"></span>
		            </td>
	          </tr>
	          <tr>
		            <td  valign="top" style="background:#ffffff;text-align: center;" height="60px">
		                <span style="font-size: 16px; color: red;line-height: 60px;" >抄送</span>
		            </td> 
		             <td  valign="top" style="background:#FFFFFF;" colspan="7">
		                <span style="border: 0px;line-height:60px; height:60px;font-size: 20px;margin-top:18px;" id="print_fw_senio"></span>
		            </td>
	          </tr>
	          
       		  <tr>
	             <td  valign="top" style="background:#ffffff;text-align: center;" >
	  				<span style="font-size: 16px; color: red;line-height: 30px;">拟稿单位</span>
	             </td>
	             <td  valign="top" style="background:#ffffff" colspan="2">
	  				<span style="width: 90%;border: 0px;line-height:60px; height:30px;font-size: 20px;margin-top:24px;" id="print_fw_draftunit"></span>
	            </td>
	             <td  valign="top" style="background:#ffffff;text-align: center;" >
	  				<span style="font-size: 16px; color: red;line-height: 30px;">拟稿 </span>
	             </td>
	             <td  valign="top" style="background:#ffffff" colspan="2">
	  				<span style="width: 90%;border: 0px;line-height:60px; height:30px;font-size: 20px;margin-top:24px;" id="print_fw_draftman"></span>
	            </td>
	             <td  valign="top" style="background:#ffffff;text-align: center;" >
	  				<span style="font-size: 16px; color: red;line-height: 30px;">核稿</span>
	             </td>
	             <td  valign="top" style="background:#ffffff" >
	  				<span style="width: 90%;border: 0px;line-height:30px; height:60px;font-size: 20px;margin-top:24px;" id="print_fw_audit"></span>
	            </td>
             </tr>
             <tr>
	             <td  valign="top" style="background:#ffffff;text-align: center;" >
	  				<span style="font-size: 16px; color: red;line-height: 30px;">院办核稿</span>
	             </td>
	             <td  valign="top" style="background:#ffffff" colspan="2">
	  				<span style="width: 90%;border: 0px;line-height:60px; height:30px;font-size: 20px;margin-top:24px;" id="print_fw_officeaudit"></span>
	            </td>
	             <td  valign="top" style="background:#ffffff;text-align: center;" >
	  				<span style="font-size: 16px; color: red;line-height: 30px;">封发  </span>
	             </td>
	             <td  valign="top" style="background:#ffffff" colspan="5">
	  				<span style="width: 90%;border: 0px;line-height:60px; height:30px;font-size: 20px;margin-top:24px;" id="print_fw_distribut"></span>
	            </td>
             </tr>
             <tr>
	             <td  valign="top" style="background:#ffffff;text-align: center;" >
	  				<span style="font-size: 16px; color: red;line-height: 30px;">打字印刷</span>
	             </td>
	             <td  valign="top" style="background:#ffffff" colspan="2">
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;font-size: 20px;margin-top:24px;" id="print_fw_print"></span>
	            </td>
	             <td  valign="top" style="background:#ffffff;text-align: center;" >
	  				<span style="font-size: 16px; color: red;line-height: 30px;">校对  </span>
	             </td>
	             <td  valign="top" style="background:#ffffff" colspan="2">
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;font-size: 20px;margin-top:24px;" id="print_fw_check"></span>
	            </td>
	             <td  valign="top" style="background:#ffffff;text-align: center;" >
	  				<span style="font-size: 16px; color: red;line-height: 30px;">份数  </span>
	             </td>
	             <td  valign="top" style="background:#ffffff" >
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;font-size: 20px;margin-top:24px;" id="print_fw_copies"></span>
	            </td>
             </tr>
              <tr height="30px">
	             <td  valign="top" style="background:#ffffff;text-align: center;" >
	  				<span style="font-size: 20px; color: red; line-height: 30px;">主题词</span>
	             </td>
	             <td  valign="top" style="background:#ffffff" colspan="7">
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;font-size: 20px;margin-top:18px;" id="print_fw_keywords"></span>
	            </td>
             </tr>
             <tr height="60px">
	             <td  valign="top" style="background:#ffffff;text-align: center;" >
	  				<span style="font-size: 20px; color: red;line-height: 60px;">标题 </span>
	             </td>
                <td  valign="top" style="background:#ffffff" colspan="7">
	  				<span style="width: 90%;border: 0px;line-height:60px; height:60px;font-size: 20px;margin-top:18px;" id="print_title"></span>
	            </td>
             </tr>
        </table>
        </td>
      </tr>
    </table>
</form>

</body>
</oa:init>
</html>
<script>jQuery(function(){ //DOM Ready
	initPageObj();
});

function fromdata(){
	jQuery("#print_fwz").text(jQuery("#OA_FILE_FAWEN__FW_FWZ").val());//编号
	jQuery("#print_fw_date2").text(jQuery("#dis_OA_FILE_FAWEN__FW_DATE2").val());//日期
	jQuery("#print_fw_prio").text(jQuery("#OA_FILE_FAWEN__FW_PRIO").val());//缓急
	jQuery("#print_fw_secur").text(jQuery("#OA_FILE_FAWEN__FW_SECUR").val());//密级
	
	jQuery("#print_fw_qfview").html(jQuery("#OA_FILE_FAWEN__FW_QFVIEW").val().replaceAll('\t','&nbsp;&nbsp;&nbsp;&nbsp;').replaceAll(' ','&nbsp;').replaceAll('\n','<br/>'));//签发
	jQuery("#print_fw_hqview").html(jQuery("#OA_FILE_FAWEN__FW_HQVIEW").val().replaceAll('\t','&nbsp;&nbsp;&nbsp;&nbsp;').replaceAll(' ','&nbsp;').replaceAll('\n','<br/>'));//会签
	jQuery("#print_fw_viceview").html(jQuery("#OA_FILE_FAWEN__FW_VICEVIEW").val().replaceAll('\t','&nbsp;&nbsp;&nbsp;&nbsp;').replaceAll(' ','&nbsp;').replaceAll('\n','<br/>'));//分管领导意见
	
	jQuery("#print_fw_prim").text(jQuery("#OA_FILE_FAWEN__FW_PRIM").val());//主送
	jQuery("#print_fw_senio").text(jQuery("#OA_FILE_FAWEN__FW_SENIO").val());//抄送
	jQuery("#print_fw_draftunit").text(jQuery("#OA_FILE_FAWEN__FW_DRAFTUNIT").val());//拟稿单位
	jQuery("#print_fw_draftman").text(jQuery("#OA_FILE_FAWEN__FW_DRAFTMAN").val());//拟稿
	jQuery("#print_fw_audit").text(jQuery("#OA_FILE_FAWEN__FW_AUDIT").val());//核稿
	jQuery("#print_fw_officeaudit").text(jQuery("#OA_FILE_FAWEN__FW_OFFICEAUDIT").val());//院办核稿
	jQuery("#print_fw_distribut").text(jQuery("#OA_FILE_FAWEN__FW_DISTRIBUT").val());//封发
	jQuery("#print_fw_print").text(jQuery("#OA_FILE_FAWEN__FW_PRINT").val());//打字印刷
	jQuery("#print_fw_check").text(jQuery("#OA_FILE_FAWEN__FW_CHECK").val());//校对
	jQuery("#print_fw_copies").text(jQuery("#OA_FILE_FAWEN__FW_COPIES").val());//份数
	jQuery("#print_fw_keywords").text(jQuery("#OA_FILE_FAWEN__FW_KEYWORDS").val());//主题词
	jQuery("#print_title").text(jQuery("#OA_FILE_FAWEN__TITLE").val());//标题
	
	
	var html = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">";
	html+="<html>";
	html+=" <head>";
	html+=" </head>";
	html+=" <body>";
	html+= document.getElementById("form_print").innerHTML;
	html+="</body>";
	html+="</html>";
	return html;
}


/**
 * 表单HTML生产附件图片ID
 */
function formToattach(attachId,title){
	var htmldata = fromdata();
	var url=jQuery("#path").val()+"/ccapp/oa/archive/ajaxfromtoattach.jsp";
	var params =  {htmldata:htmldata,attachId:attachId,title:title};
	jQuery.ajax({
		url: url,
		type: 'POST',
		dataType:'json',
		data: params,
		async:false,
		success: function(data){
		},
		error: function(jqXHR, textStatus, errorThrown){
			checkFile = false;
		}
	})
}
</script>
