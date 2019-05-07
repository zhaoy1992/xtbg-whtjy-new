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

%>

<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
  <title>湖北特检院-事故调查处理中心人员请假</title>
  <script>jQuery(function(){ //DOM Ready
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
	jQuery("#"+jQuery("#field_drag_in_title").val()).focus();
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
<input id="windowsId" name="windowsId" type="hidden" value="<%=windowsId %>"/>
<oa:input type='hidden' column='T_USER_ID' table='TA_OA_ATTENDANCELEAVE' value='<%=user_id%>' />
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
					<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=0c11cafb-68d6-4b99-a808-696b80468966 class=gs_w data-sizey="2" data-sizex="30" data-row="1" data-col="1"><oa:span style='font-size: 28px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '湖北特检院请假审批单' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=2e8fb948-55b0-435e-a049-8b6e1aedf73e class=gs_w data-sizey="2" data-sizex="7" data-row="3" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '申请人' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=44875112-c769-4c24-b93e-c0870a30f160 class=gs_w data-sizey="2" data-sizex="8" data-row="3" data-col="8"><oa:input title='' type='text' column='T_NAME' table='TA_OA_ATTENDANCELEAVE' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=9862ce20-066e-4080-895b-bd3005817e1a class=gs_w data-sizey="2" data-sizex="7" data-row="3" data-col="16"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '所属部门' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=a4b93798-1845-4901-9a02-89a078da6f79 class=gs_w data-sizey="2" data-sizex="8" data-row="3" data-col="23"><oa:input title='' type='text' column='T_DEPART_NAME' table='TA_OA_ATTENDANCELEAVE' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=org_name%>'/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=96d6a455-5b18-4b0f-a00f-3597f007ccdb class=gs_w data-sizey="2" data-sizex="7" data-row="5" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '申请日期' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=0ae71afe-cfc3-4102-af0e-30905fc8bae3 class=gs_w data-sizey="2" data-sizex="8" data-row="5" data-col="8"><oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='T_SQ_TIME' table='TA_OA_ATTENDANCELEAVE' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=eb12a752-e0ab-4d90-9ea0-465d5683bd6b class=gs_w data-sizey="2" data-sizex="7" data-row="5" data-col="16"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '请假类型' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=840d6317-9c7a-4cc3-9031-571121effa00 class=gs_w data-sizey="2" data-sizex="8" data-row="5" data-col="23"> <oa:select column='T_TYPE' table='TA_OA_ATTENDANCELEAVE' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title =''><oa:option optionName='年休假' optionValue='value1' /><oa:option optionName='婚假' optionValue='value2' /><oa:option optionName='工伤假' optionValue='value3' /><oa:option optionName='产假' optionValue='value4' /><oa:option optionName='计划生育假' optionValue='value5' /><oa:option optionName='病(伤)假' optionValue='value6' /><oa:option optionName='事假' optionValue='value7' /><oa:option optionName='公差假' optionValue='value8' /><oa:option optionName='丧假' optionValue='value9' /><oa:option optionName='学习培训假' optionValue='value10' /><oa:option optionName='陪产假' optionValue='value11' /><oa:option optionName='调休假' optionValue='value12' /></oa:select></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=2f8e03bc-a9bc-425d-856c-3466032a443c class=gs_w data-sizey="2" data-sizex="5" data-row="7" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 13%; line-height: 30px;' column='null'  table='' value= '请假开始日期' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=dfb35c6b-d3f6-4d42-98eb-527f50300ea3 class=gs_w data-sizey="2" data-sizex="5" data-row="7" data-col="6"><oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='T_STARTTIME' table='TA_OA_ATTENDANCELEAVE' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=fe0f9ba0-1587-40e4-9100-4c3f7217c8dc class=gs_w data-sizey="2" data-sizex="5" data-row="7" data-col="11"><oa:span style='font-size: 20px; color: #000000; padding-left: 13%; line-height: 30px;' column='null'  table='' value= '请假结束日期' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=77273c9d-6a64-40da-b9b5-e656d9496e43 class=gs_w data-sizey="2" data-sizex="5" data-row="7" data-col="16"><oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='T_ENDTIME' table='TA_OA_ATTENDANCELEAVE' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/></LI>
<LI style="FILTER: none; WIDTH: 155px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1px" id=41dab8d7-1bce-47c4-ba72-84c2a15b524a class=gs_w data-sizey="2" data-sizex="5" data-row="7" data-col="21"><oa:span style='font-size: 20px; color: #000000; padding-left: 13%; line-height: 30px;' column='null'  table='' value= '请假天数' /></LI>
<LI style="FILTER: none; WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1px" id=ac479ea7-44dd-40fd-95e6-9fd092791712 class=gs_w data-sizey="2" data-sizex="3" data-row="7" data-col="26"><oa:input title='' type='text' column='T_LEAVETIMES' table='TA_OA_ATTENDANCELEAVE' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=86b4887e-ba1f-4e72-963e-ddf27ad19317 class=gs_w data-sizey="2" data-sizex="2" data-row="7" data-col="29"><oa:span style='font-size: 20px; color: #000000; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '天' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=9a6e5dc4-209e-4620-9631-08b172a5dd89 class=gs_w data-sizey="2" data-sizex="7" data-row="9" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '请假事由' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=b0e92462-6f98-4d3d-b613-0790027f0104 class=gs_w data-sizey="2" data-sizex="23" data-row="9" data-col="8"><oa:textarea column='T_TITLE' table='TA_OA_ATTENDANCELEAVE' title ='' style='border: 1;width:80%; height: 30px; overflow: auto;'  /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=9038beee-8ae1-4300-b839-b84482c8ad53 class=gs_w data-sizey="2" data-sizex="7" data-row="11" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '人事部审核' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=6cf2e145-5ab8-49dd-8674-8303fdc013a6 class=gs_w data-sizey="2" data-sizex="23" data-row="11" data-col="8"><oa:view column='T_HUMANRESOURCE_IDEA' table='TA_OA_ATTENDANCELEAVE' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=1a1d78e3-86bb-47c4-8195-6efbb8052685 class=gs_w data-sizey="2" data-sizex="7" data-row="13" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 13%; line-height: 30px;' column='null'  table='' value= '分管领导审核' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=720c52d5-1815-4191-8c63-f9aab4b6ce54 class=gs_w data-sizey="2" data-sizex="23" data-row="13" data-col="8"><oa:view column='T_FENGUAN_LEADER_IDEA' table='TA_OA_ATTENDANCELEAVE' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=9a25b095-22c1-4f13-9803-ad28df7eee77 class=gs_w data-sizey="2" data-sizex="7" data-row="15" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '院长审核' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=42c11834-6c2d-4f50-a9fd-85ad4ea185f8 class=gs_w data-sizey="2" data-sizex="23" data-row="15" data-col="8"><oa:view column='T_PRESIDENT_IDEA' table='TA_OA_ATTENDANCELEAVE' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=6195e2aa-21e7-42f7-8c14-14e2a3f7b649 class=gs_w data-sizey="2" data-sizex="7" data-row="17" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '销假登记' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=197cde79-de9e-4d65-b4ca-5fd7f41ab4f8 class=gs_w data-sizey="2" data-sizex="23" data-row="17" data-col="8"><oa:view column='T_REMOVELEAVE_LOG' table='TA_OA_ATTENDANCELEAVE' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' /></LI>
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
