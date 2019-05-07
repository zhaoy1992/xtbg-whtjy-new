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
  <title>发文稿纸</title>
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
					<LI style="WIDTH: 929px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 61px" id=efde385e-3e7b-4ba2-9ef2-dd3d30488598 class="gs_w player-revert" data-col="1" data-row="1" data-sizex="30" data-sizey="2"><oa:span style='font-size: 30px; color: #ff0000; line-height: 60px;display:block;height:100%;width:100%;text-align:center;letter-spacing:6px;' column='null'  table='' value= '湖南省特种设备检验检测研究院发文稿纸' /></LI>
<LI style="WIDTH: 123px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px" id=f2dfa9c6-4bdb-4acb-86c0-ed1837d66944 class=gs_w data-col="1" data-row="3" data-sizex="4" data-sizey="1"> <oa:select column='FW_FWZ' table='OA_FILE_FAWEN' style ='width: 80%;line-height:22px; height:22px;margin-top:3px;float:right;' title =''><oa:option optionName='湘特检发' optionValue='湘特检发' /><oa:option optionName='湘特检函' optionValue='湘特检函' /></oa:select></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 31px; ZOOM: 1; DISPLAY: list-item; MARGIN-LEFT: -1.5px; MARGIN-RIGHT: -1.5px" id=2ff99a43-32b4-44ea-951b-aaf31911018e class=gs_w data-col="5" data-row="3" data-sizex="1" data-sizey="1"><oa:span style='font-size: 15px; color: black; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '' /></LI>
<LI style="WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-LEFT: -1.5px; MARGIN-RIGHT: -1.5px" id=df23eebf-f3bc-4a03-86a9-d3bb07a19e83 class=gs_w data-col="6" data-row="3" data-sizex="3" data-sizey="1"> <oa:select column='FW_YEAR' table='OA_FILE_FAWEN' style ='width: 80%;line-height:22px; height:22px;margin-top:3px;' title =''><oa:option optionName='2013' optionValue='2013' /><oa:option optionName='2014' optionValue='2014' /><oa:option optionName='2015' optionValue='2015' /></oa:select></LI>
<LI style="WIDTH: 31px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-LEFT: -1.5px; MARGIN-RIGHT: -1.5px" id=65f3b464-5f4c-4ee3-ad4a-e80a2d9892d4 class=gs_w data-col="9" data-row="3" data-sizex="1" data-sizey="1"><oa:input title='' type='text' column='FW_NO' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 31px; ZOOM: 1; DISPLAY: list-item; MARGIN-LEFT: -1.5px; MARGIN-RIGHT: -1.5px" id=8bbbaac8-ca17-4102-bd66-46d60e6cdc98 class=gs_w data-col="10" data-row="3" data-sizex="1" data-sizey="1"><oa:span style='font-size: 15px; color: red; padding-left: 0%; line-height: 30px;' column='null'  table='' value= '号' /></LI>
<LI style="WIDTH: 62px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-LEFT: -1.5px; MARGIN-RIGHT: -1.5px" id=1107ed7d-1a6e-426f-aca8-a7f64be8cd04 class=gs_w data-col="11" data-row="3" data-sizex="2" data-sizey="1"><oa:span style='font-size: 15px; color: red; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '日期' /></LI>
<LI style="WIDTH: 186px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-LEFT: -1.5px; MARGIN-RIGHT: -1.5px" id=83bff278-f10f-4639-8ee8-e8e87e2e470c class=gs_w data-col="13" data-row="3" data-sizex="6" data-sizey="1"><oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='FW_DATE2' table='OA_FILE_FAWEN' title ='' style='width: 90%;height:22px;line-height:22px;float:left;margin-top:3px;' other="class='Wdate'"/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; MARGIN-RIGHT: -1.5px" id=5a3062f0-6cbc-455d-86f2-74b6a0937277 class=gs_w data-col="19" data-row="3" data-sizex="3" data-sizey="1"><oa:span style='font-size: 15px; color: red; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '缓急' /></LI>
<LI style="WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1.5px" id=e044bf6f-74bb-4505-8eb5-04dd3aa326b0 class=gs_w data-col="22" data-row="3" data-sizex="3" data-sizey="1"> <oa:select column='FW_PRIO' table='OA_FILE_FAWEN' style ='width: 90%;line-height:22px; height:22px;margin-top:3px;' title =''><oa:option optionName='特急' optionValue='特急' /><oa:option optionName='急' optionValue='急' /><oa:option optionName='一般' optionValue='一般' /></oa:select></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; MARGIN-RIGHT: -1.5px" id=6d3379b3-8bad-4e52-ac4c-9752c76d67ea class=gs_w data-col="25" data-row="3" data-sizex="3" data-sizey="1"><oa:span style='font-size: 15px; color: red; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '密级' /></LI>
<LI style="WIDTH: 92px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px" id=aae7ef3f-d862-4d2d-be19-48112173a6d7 class=gs_w data-col="28" data-row="3" data-sizex="3" data-sizey="1"> <oa:select column='FW_SECUR' table='OA_FILE_FAWEN' style ='width: 90%;line-height:22px; height:22px;margin-top:3px;' title =''><oa:option optionName='特密' optionValue='特密' /><oa:option optionName='秘密' optionValue='秘密' /><oa:option optionName='公开' optionValue='公开' /></oa:select></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 61px; ZOOM: 1; DISPLAY: list-item; HEIGHT: 185px" id=41fbe35f-7d4d-4b71-8472-95c0128737f4 class=gs_w data-col="1" data-row="4" data-sizex="2" data-sizey="6"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '签发' /></LI>
<LI style="WIDTH: 403px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-LEFT: -1.5px" id=e95e0a99-6a8f-4b12-8987-8fe3a0c359ba class=gs_w data-col="3" data-row="4" data-sizex="13" data-sizey="6"><oa:view column='FW_QFVIEW' table='OA_FILE_FAWEN' title ='' style='border:0;width:92%; height: 80%; overflow: auto;margin-top:4px;margin-left:4%' cntab='uuuu,tt' /></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 62px; ZOOM: 1; DISPLAY: list-item; MARGIN-RIGHT: -1.5px" id=661a6884-0587-4e38-8e1d-90241934904d class=gs_w data-col="16" data-row="4" data-sizex="2" data-sizey="6"><oa:span style='font-size: 15px; color: red; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '会签' /></LI>
<LI style="WIDTH: 402px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 185px" id=1912b96c-8495-47cf-8f1a-cf8f5d62e090 class=gs_w data-col="18" data-row="4" data-sizex="13" data-sizey="6"><oa:view column='FW_HQVIEW' table='OA_FILE_FAWEN' title ='' style='border:0;width:92%; height: 80%; overflow: auto;margin-top:4px;margin-left:4%' cntab='uuuu,tt' /></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 61px; ZOOM: 1; DISPLAY: list-item; HEIGHT: 61px" id=7b5cedef-b909-4853-892a-d5fb194bfc4b class=gs_w data-col="1" data-row="10" data-sizex="2" data-sizey="2"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 60px;' column='null'  table='' value= '主送' /></LI>
<LI style="WIDTH: 867px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 61px" id=e293cecf-bfab-4a5d-8baf-e745b0cb23cc class=gs_w data-col="3" data-row="10" data-sizex="28" data-sizey="2"><oa:input title='' type='text' column='FW_PRIM' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:50%;padding-top:16px;padding-left:10px;' value = ''/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 61px; ZOOM: 1; DISPLAY: list-item; HEIGHT: 61px" id=4bf844cc-decd-450b-b583-f0e8c6311eff class=gs_w data-col="1" data-row="12" data-sizex="2" data-sizey="2"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 60px;' column='null'  table='' value= '抄送' /></LI>
<LI style="WIDTH: 867px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 61px" id=fc82e6a3-7c40-42e7-8cc8-dc197a280b61 class=gs_w data-col="3" data-row="12" data-sizex="28" data-sizey="2"><oa:input title='' type='text' column='FW_SENIO' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:50%;padding-top:16px;padding-left:10px;' value = ''/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 123px; ZOOM: 1; DISPLAY: list-item; HEIGHT: 30px" id=afb12237-e69a-4a3b-9854-ffe3a38be35a class=gs_w data-col="1" data-row="14" data-sizex="4" data-sizey="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '拟稿单位' /></LI>
<LI style="WIDTH: 248px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-LEFT: -1.5px" id=d3a93f16-61ff-4f4c-97c5-fdfe9e7bcd1d class=gs_w data-col="5" data-row="14" data-sizex="8" data-sizey="1"><oa:input title='' type='text' column='FW_DRAFTUNIT' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=org_name%>'/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; MARGIN-RIGHT: -1.5px" id=aa944320-6fd8-4114-9bf5-948be8d8aecd class=gs_w data-col="13" data-row="14" data-sizex="3" data-sizey="1"><oa:span style='color:red;font-size: 15px; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '拟稿' /></LI>
<LI style="ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=56abfa7e-4fc5-4ce2-bf39-00718dfa0981 class=gs_w data-col="16" data-row="14" data-sizex="6" data-sizey="1"><oa:input title='' type='text' column='FW_DRAFTMAN' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; MARGIN-RIGHT: -1.5px" id=e6568404-6bf9-4fcf-82c4-4e8db2911e67 class=gs_w data-col="22" data-row="14" data-sizex="3" data-sizey="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '核稿' /></LI>
<LI style="WIDTH: 185px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px" id=a6040305-beb2-42f7-ada4-682b242cd969 class=gs_w data-col="25" data-row="14" data-sizex="6" data-sizey="1"><oa:input title='' type='text' column='FW_AUDIT' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 123px; ZOOM: 1; DISPLAY: list-item; HEIGHT: 30px" id=5569b149-3045-40ce-8450-2ea9aa4545f7 class=gs_w data-col="1" data-row="15" data-sizex="4" data-sizey="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '院办核稿' /></LI>
<LI style="WIDTH: 248px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-LEFT: -1.5px" id=cc99aba1-5548-41eb-a5d9-c5baec13ea4a class=gs_w data-col="5" data-row="15" data-sizex="8" data-sizey="1"><oa:input title='' type='text' column='FW_OFFICEAUDIT' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; MARGIN-RIGHT: -1.5px" id=322d00ca-1f3d-4feb-9c49-4e17de2a71e2 class=gs_w data-col="13" data-row="15" data-sizex="3" data-sizey="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '封发' /></LI>
<LI style="WIDTH: 464px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px" id=1145aa1a-e7e3-4c2c-bd75-f5f9d5f66cfb class=gs_w data-col="16" data-row="15" data-sizex="15" data-sizey="1"><oa:input title='' type='text' column='FW_DISTRIBUT' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 123px; ZOOM: 1; DISPLAY: list-item; HEIGHT: 30px" id=7bb60139-5abe-49eb-b53e-2007cbf0ce38 class=gs_w data-col="1" data-row="16" data-sizex="4" data-sizey="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '打字印刷' /></LI>
<LI style="WIDTH: 248px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-LEFT: -1.5px" id=9a758be3-32c5-4ef7-94c4-dc52e2758d74 class=gs_w data-col="5" data-row="16" data-sizex="8" data-sizey="1"><oa:input title='' type='text' column='FW_PRINT' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; MARGIN-RIGHT: -1.5px" id=075671f6-d22b-4751-8853-a2f5270b9859 class=gs_w data-col="13" data-row="16" data-sizex="3" data-sizey="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '校对' /></LI>
<LI style="ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=88a3bcf9-8cec-46b6-b6c1-7a93eda5a3af class=gs_w data-col="16" data-row="16" data-sizex="6" data-sizey="1"><oa:input title='' type='text' column='FW_CHECK' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; MARGIN-RIGHT: -1.5px" id=1de7aef5-4ef6-4c87-8c6d-de8c4f66e7f8 class=gs_w data-col="22" data-row="16" data-sizex="3" data-sizey="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '份数' /></LI>
<LI style="WIDTH: 185px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px" id=e5ba2e56-1a8f-4a82-b4dd-fbb542713c62 class=gs_w data-col="25" data-row="16" data-sizex="6" data-sizey="1"><oa:input title='' type='text' column='FW_COPIES' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 123px; ZOOM: 1; DISPLAY: list-item; HEIGHT: 30px" id=a0d019bd-b68a-419e-95af-73eb5e2ffa68 class=gs_w data-col="1" data-row="17" data-sizex="4" data-sizey="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '附件' /></LI>
<LI style="WIDTH: 248px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-LEFT: -1.5px" id=9ca5d698-611e-4d03-8212-ddbbbbe87f0d class=gs_w data-col="5" data-row="17" data-sizex="8" data-sizey="1"><input type='hidden' id='field_drag_in_attach' value='OA_FILE_FAWEN__T_FJ_ID'/><oa:affixbut butName='请选择文件' column='T_FJ_ID' table='OA_FILE_FAWEN'  title ='' operType='111' initFjDJBHForArchive ='<%=drag_in_attach%>' /></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 93px; ZOOM: 1; DISPLAY: list-item; MARGIN-RIGHT: -1.5px" id=75360651-0602-4e24-ae75-c47aaa8ae3fc class=gs_w data-col="13" data-row="17" data-sizex="3" data-sizey="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '附件列表' /></LI>
<LI style="WIDTH: 464px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px" id=0d328217-6878-43b2-a5d5-2c6240e0bf80 class=gs_w data-col="16" data-row="17" data-sizex="15" data-sizey="1"><oa:affixshow  title =''/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 123px; ZOOM: 1; DISPLAY: list-item; HEIGHT: 30px" id=b3a239f5-ff59-4ef2-9b6e-52701d10d7b2 class=gs_w data-col="1" data-row="18" data-sizex="4" data-sizey="1"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '主题词' /></LI>
<LI style="WIDTH: 805px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px" id=2363ec84-c12d-4841-86aa-de92596c7d9d class=gs_w data-col="5" data-row="18" data-sizex="26" data-sizey="1"><oa:input title='' type='text' column='FW_KEYWORDS' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 123px; ZOOM: 1; DISPLAY: list-item; HEIGHT: 61px" id=ad9b78e6-1f9c-422b-9061-d907fa3de093 class=gs_w data-col="1" data-row="19" data-sizex="4" data-sizey="2"><oa:span style='font-size: 15px; color: red; padding-left: 23%; line-height: 60px;' column='null'  table='' value= '标题' /></LI>
<LI style="WIDTH: 805px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 61px" id=efcfb80e-21b1-44e6-907a-0b400c98f150 class=gs_w data-col="5" data-row="19" data-sizex="26" data-sizey="2"><input type='hidden' id='field_drag_in_title' value='OA_FILE_FAWEN__TITLE'/><oa:input title='' type='text' column='TITLE' table='OA_FILE_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:50%;padding-top:16px;padding-left:10px;' value = '<%=drag_in_title%>'/></LI>
					</ul>
			    </div>		
				</section>
			</article>
		</div>
				<div id="tabs-3">
			<oa:webtext column="T_ZW_ID" table="OA_FILE_FAWEN" defautValue="<%=drag_in_webtext%>"/>
			<input type='hidden' id='field_drag_in_webtext' value="OA_FILE_FAWEN__T_ZW_ID"/>
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
