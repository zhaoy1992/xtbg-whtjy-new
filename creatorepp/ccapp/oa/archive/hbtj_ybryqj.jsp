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
  <title>湖北特检一般人员请假</title>
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
					<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=e5858878-537e-4eea-8090-a39177d2ac3e class=gs_w data-sizey="2" data-sizex="7" data-row="1" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '申请人' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=e9294063-105b-4243-bb5c-856902cd5e0a class=gs_w data-sizey="2" data-sizex="8" data-row="1" data-col="8"><oa:input title='' type='text' column='T_NAME' table='TA_OA_ATTENDANCELEAVE' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=29a2a247-2c00-47f8-9391-bc52dd5a5842 class=gs_w data-sizey="2" data-sizex="7" data-row="1" data-col="16"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '申请部门' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=c74b10c9-7d38-4d23-b3a9-5a4af93a8517 class=gs_w data-sizey="2" data-sizex="8" data-row="1" data-col="23"><oa:input title='' type='text' column='T_DEPART_NAME' table='TA_OA_ATTENDANCELEAVE' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=org_name%>'/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=c6bc05e4-860e-454c-82f5-13843eab62bb class=gs_w data-sizey="2" data-sizex="7" data-row="3" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '申请日期' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=b8ef17a7-256c-415f-9e45-4a1fe5a0afcc class=gs_w data-sizey="2" data-sizex="8" data-row="3" data-col="8"><oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='T_SQ_TIME' table='TA_OA_ATTENDANCELEAVE' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=71089daa-dfe4-42dc-a11a-3881630e84df class=gs_w data-sizey="2" data-sizex="7" data-row="3" data-col="16"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '请假类型' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=9a8e0d77-9ad2-47fa-ae92-d204b4f6f615 class=gs_w data-sizey="2" data-sizex="8" data-row="3" data-col="23"> <oa:select column='T_TYPE' table='TA_OA_ATTENDANCELEAVE' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title =''><oa:option optionName='年休假' optionValue='value1' /><oa:option optionName='婚假' optionValue='value2' /><oa:option optionName='工伤假' optionValue='value3' /><oa:option optionName='产假' optionValue='value4' /><oa:option optionName='计划生育假' optionValue='value5' /><oa:option optionName='病(伤)假' optionValue='value6' /><oa:option optionName='事假' optionValue='value7' /><oa:option optionName='公差假' optionValue='value8' /><oa:option optionName='丧假' optionValue='value9' /><oa:option optionName='学习培训假' optionValue='value10' /><oa:option optionName='陪产假' optionValue='value11' /><oa:option optionName='调休假' optionValue='value12' /></oa:select></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=9c904a69-4177-4b1a-95f4-9684cb40f5e8 class=gs_w data-sizey="2" data-sizex="5" data-row="5" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 13%; line-height: 30px;' column='null'  table='' value= '请假开始日期' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=1057330b-a32c-4b3d-aaab-aede6539c019 class=gs_w data-sizey="2" data-sizex="5" data-row="5" data-col="6"><oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='T_STARTTIME' table='TA_OA_ATTENDANCELEAVE' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=0792a9f0-8a5d-40af-af5c-5dd47a639c5f class=gs_w data-sizey="2" data-sizex="5" data-row="5" data-col="11"><oa:span style='font-size: 20px; color: #000000; padding-left: 13%; line-height: 30px;' column='null'  table='' value= '请假结束日期' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=ac642929-b124-4dfa-b9c9-7dc06bd03cfc class=gs_w data-sizey="2" data-sizex="5" data-row="5" data-col="16"><oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='T_ENDTIME' table='TA_OA_ATTENDANCELEAVE' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/></LI>
<LI style="FILTER: none; WIDTH: 155px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1px" id=0386c62c-df40-4cd6-b59a-fcfa6064f20a class=gs_w data-sizey="2" data-sizex="5" data-row="5" data-col="21"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '请假天数' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=34dcd833-9706-4177-807c-85510963bbba class=gs_w data-sizey="2" data-sizex="7" data-row="7" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '请假事由' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=aade8b52-7348-4dc4-be95-49558b91f869 class=gs_w data-sizey="2" data-sizex="23" data-row="7" data-col="8"><oa:textarea column='T_TITLE' table='TA_OA_ATTENDANCELEAVE' title ='' style='border: 1;width:80%; height: 50px; overflow: auto;'  /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=f13e2d9f-6ece-4268-97d6-46c473170bfb class=gs_w data-sizey="2" data-sizex="7" data-row="9" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '部门负责人意见' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=0228d821-346f-4d2c-b3f2-7b7ce85bdbe6 class=gs_w data-sizey="2" data-sizex="23" data-row="9" data-col="8"><oa:view column='T_DEPARTMANAGER_IDEA' table='TA_OA_ATTENDANCELEAVE' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=79d62ca2-ad94-4845-82d1-7b54f9051249 class=gs_w data-sizey="2" data-sizex="7" data-row="11" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '人力资源部意见' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=6d0bd45a-9e7e-44d0-8748-a1b9368a9448 class=gs_w data-sizey="2" data-sizex="23" data-row="11" data-col="8"><oa:view column='T_HUMANRESOURCE_IDEA' table='TA_OA_ATTENDANCELEAVE' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=721112d8-e22f-4c6b-a759-f16e5734445d class=gs_w data-sizey="2" data-sizex="7" data-row="13" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 2%; line-height: 30px;' column='null'  table='' value= '人力资源部领导意见' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=dd167f45-5643-4b84-8e6e-ac6b6e8f624e class=gs_w data-sizey="2" data-sizex="23" data-row="13" data-col="8"><oa:view column='T_FENGUAN_LEADER_IDEA' table='TA_OA_ATTENDANCELEAVE' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=db2398df-f214-48f3-81b8-25731b0fa959 class=gs_w data-sizey="2" data-sizex="7" data-row="15" data-col="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '销假记录' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=375d4030-5dae-47c4-a1e7-5a291789e148 class=gs_w data-sizey="2" data-sizex="23" data-row="15" data-col="8"><oa:view column='T_REMOVELEAVE_LOG' table='TA_OA_ATTENDANCELEAVE' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: none; WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1px" id=a38397b6-a045-44ec-b44d-db13108750c2 class=gs_w data-sizey="2" data-sizex="3" data-row="5" data-col="26"><oa:input title='' type='text' column='T_LEAVETIMES' table='TA_OA_ATTENDANCELEAVE' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=41374fec-34af-479b-b350-995bd68023a2 class=gs_w data-sizey="2" data-sizex="2" data-row="5" data-col="29"><oa:span style='font-size: 20px; color: #000000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '天' /></LI>
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
