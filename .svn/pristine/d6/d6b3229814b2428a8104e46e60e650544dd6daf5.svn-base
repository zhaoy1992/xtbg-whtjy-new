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
  <title>湖北特检请假审批事业中心一般</title>
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
					<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=4e599dfa-eba6-48ee-898d-a2ea12ac45f6 class=gs_w data-sizey="2" data-sizex="30" data-row="1" data-col="1"><oa:span style='font-size: 28px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '湖北特检院请假审批单' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=df49ab31-a7f1-4c4d-b2e2-50a1aeb2bfde class=gs_w data-sizey="2" data-sizex="7" data-row="3" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '申请人' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=14bf5800-162b-4ae2-8174-2a1533a76ab9 class=gs_w data-sizey="2" data-sizex="8" data-row="3" data-col="8"><oa:input title='' type='text' column='T_NAME' table='TA_OA_ATTENDANCELEAVE' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=581c540c-ef80-4d2d-8d26-9c1542e1fffb class=gs_w data-sizey="2" data-sizex="7" data-row="3" data-col="16"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '所属部门' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=f60710cf-5964-470c-a0e1-8a4e38e18fb4 class=gs_w data-sizey="2" data-sizex="8" data-row="3" data-col="23"><oa:input title='' type='text' column='T_DEPART_NAME' table='TA_OA_ATTENDANCELEAVE' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=org_name%>'/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=8d18cfb1-6603-4f03-a32d-0ece27cb0ffc class=gs_w data-sizey="2" data-sizex="7" data-row="5" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '申请日期' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=f7c8bb72-37fa-423e-9d49-3e73739483b8 class=gs_w data-sizey="2" data-sizex="8" data-row="5" data-col="8"><oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='T_SQ_TIME' table='TA_OA_ATTENDANCELEAVE' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=1aa43cd9-2300-42ec-b740-a239a98e19f4 class=gs_w data-sizey="2" data-sizex="7" data-row="5" data-col="16"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '请假类型' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=6cb4165c-04f5-4742-a463-cc32c035d4c6 class=gs_w data-sizey="2" data-sizex="8" data-row="5" data-col="23"> <oa:select column='T_TYPE' table='TA_OA_ATTENDANCELEAVE' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title =''><oa:option optionName='年休假' optionValue='value1' /><oa:option optionName='婚假' optionValue='value2' /><oa:option optionName='工伤假' optionValue='value3' /><oa:option optionName='产假' optionValue='value4' /><oa:option optionName='计划生育假' optionValue='value5' /><oa:option optionName='病(伤)假' optionValue='value6' /><oa:option optionName='事假' optionValue='value7' /><oa:option optionName='公差假' optionValue='value8' /><oa:option optionName='丧假' optionValue='value9' /><oa:option optionName='学习培训假' optionValue='value10' /><oa:option optionName='陪产假' optionValue='value11' /><oa:option optionName='调休假' optionValue='value12' /></oa:select></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=506d022e-cf8e-42db-b29f-27e3ba65afe8 class=gs_w data-sizey="2" data-sizex="5" data-row="7" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 13%; line-height: 30px;' column='null'  table='' value= '请假开始日期' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=72bcbc62-c25f-4351-b979-873b8c55842a class=gs_w data-sizey="2" data-sizex="5" data-row="7" data-col="6"><oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='T_STARTTIME' table='TA_OA_ATTENDANCELEAVE' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=951692cf-4312-48f7-87b8-b008182a5a80 class=gs_w data-sizey="2" data-sizex="5" data-row="7" data-col="11"><oa:span style='font-size: 20px; color: #000000; padding-left: 13%; line-height: 30px;' column='null'  table='' value= '请假结束日期' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=34150f18-0e13-41de-b3ab-7474caf65cfa class=gs_w data-sizey="2" data-sizex="5" data-row="7" data-col="16"><oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='T_ENDTIME' table='TA_OA_ATTENDANCELEAVE' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/></LI>
<LI style="FILTER: none; WIDTH: 155px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1px" id=68492468-9ff4-4455-b081-a4352a836999 class=gs_w data-sizey="2" data-sizex="5" data-row="7" data-col="21"><oa:span style='font-size: 20px; color: #000000; padding-left: 28%; line-height: 30px;' column='null'  table='' value= '请假天数' /></LI>
<LI style="FILTER: none; WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1px" id=599f523d-0fe7-4e7f-b98b-e56e5a1c7abf class=gs_w data-sizey="2" data-sizex="3" data-row="7" data-col="26"><oa:input title='' type='text' column='T_LEAVETIMES' table='TA_OA_ATTENDANCELEAVE' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI style="FILTER: none; WIDTH: 61px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 61px" id=f215a3a8-1e88-491c-9586-6285d9452c84 class=gs_w data-sizey="2" data-sizex="2" data-row="7" data-col="29"><oa:span style='font-size: 20px; color: #000000; padding-left: 13%; line-height: 30px;' column='null'  table='' value= '天' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=69c9bbfc-975b-4b8e-9912-24f1e7a4363a class=gs_w data-sizey="2" data-sizex="7" data-row="9" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '请假事由' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=3e71e440-65df-477d-a90a-bd588c448d97 class=gs_w data-sizey="2" data-sizex="23" data-row="9" data-col="8"><oa:textarea column='T_TITLE' table='TA_OA_ATTENDANCELEAVE' title ='' style='border: 1;width:80%; height: 30px; overflow: auto;'  /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=4436553f-ef59-46f1-ba2d-f1e690d4d85d class=gs_w data-sizey="2" data-sizex="7" data-row="11" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '部门负责人审核' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=3407f9e9-2bc0-41c6-90f4-959e00b80380 class=gs_w data-sizey="2" data-sizex="23" data-row="11" data-col="8"><oa:view column='T_DEPARTMANAGER_IDEA' table='TA_OA_ATTENDANCELEAVE' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=52dfe637-ab8f-4a6e-a47f-3ecafc548195 class=gs_w data-sizey="2" data-sizex="7" data-row="13" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '人力资源部审核' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=e2f3089b-2272-4917-9ef6-a189361df46f class=gs_w data-sizey="2" data-sizex="23" data-row="13" data-col="8"><oa:view column='T_HUMANRESOURCE_IDEA' table='TA_OA_ATTENDANCELEAVE' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=20dc3248-1ad7-483a-b9aa-c7830b01288d class=gs_w data-sizey="2" data-sizex="7" data-row="15" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 13%; line-height: 30px;' column='null'  table='' value= '事业中心领导审核' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=ec7d57ba-7764-445e-9eb3-78654d80c1f3 class=gs_w data-sizey="2" data-sizex="23" data-row="15" data-col="8"><oa:view column='T_FENGUAN_LEADER_IDEA' table='TA_OA_ATTENDANCELEAVE' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=01480447-f6a8-47d0-90eb-2735a7338b51 class=gs_w data-sizey="2" data-sizex="7" data-row="17" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '销假登记' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=73b737e3-4e7a-44d5-8373-715b79d13c28 class=gs_w data-sizey="2" data-sizex="23" data-row="17" data-col="8"><oa:view column='T_REMOVELEAVE_LOG' table='TA_OA_ATTENDANCELEAVE' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' /></LI>
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
