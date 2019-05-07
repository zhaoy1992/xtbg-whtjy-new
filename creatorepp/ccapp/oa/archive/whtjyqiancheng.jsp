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
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowInstanceDataSaveDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao"%>       

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String userID = accesscontroler.getUserID();
String windowsId = request.getParameter("windowsId");
String circularize_id = request.getParameter("circularize_id");
String drag_in_title = "";
String drag_in_attach = "";
String drag_in_webtext = "";
FlowMoveBean fmb = new FlowMoveBean(request);
if("cywj".equals(windowsId)){
	//修改传阅 的查看状态
	FlowInstanceDataSaveDao flowinstancedatasavedao = new FlowInstanceDataSaveDaoImpl();
	flowinstancedatasavedao.updateFlowActInsState(circularize_id,userID,"1");
}
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
  <title>武汉特检院签呈</title>
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
<oa:input type='hidden' column='USER_ID' table='TA_OA_WHTJY_QIANCHENG' value='<%=user_id%>' /><oa:input type='hidden' column='USER_NAME' table='TA_OA_WHTJY_QIANCHENG' value='<%=user_name%>' /><oa:input type='hidden' column='CREATED' table='TA_OA_WHTJY_QIANCHENG' value='<%=time%>' /><oa:input type='hidden' column='ORG_ID' table='TA_OA_WHTJY_QIANCHENG' value='<%=org_id%>' />
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
					<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; MARGIN-BOTTOM: -1px; BACKGROUND: white; HEIGHT: 62px" id=65053a1c-f565-4295-bb95-fff54426e042 class=gs_w data-col="1" data-row="1" data-sizex="30" data-sizey="2"><oa:span style='font-size: 35px; color: #000000; padding-left: 25%; line-height: 60px;' column='null'  table='' value= '湖北省特种设备检验检测研究院' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; MARGIN-BOTTOM: -1px; BACKGROUND: white; HEIGHT: 31px" id=7db8e583-124d-45fa-b839-6950a209e482 class=gs_w data-col="1" data-row="3" data-sizex="30" data-sizey="1"><oa:span style='font-size: 20px; color: #000000; padding-left: 47%; line-height: 30px;' column='null'  table='' value= '签        呈' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=e21e8fe3-3368-44b0-931e-0e64967161b6 class=gs_w data-col="1" data-row="4" data-sizex="30" data-sizey="1"><oa:input title='' type='text' column='PETITION_DATE' table='TA_OA_WHTJY_QIANCHENG' style= 'width: 20%;border: 0px;line-height:26px; height:26px;padding-left: 79%;' value = '<%=time%>'/></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=0441d96c-3701-4933-98c6-8c28c60cd44a class=gs_w data-col="1" data-row="5" data-sizex="15" data-sizey="18"><oa:textarea column='PETITION_NOTE' table='TA_OA_WHTJY_QIANCHENG' title ='内容：' style='border: 1;width:98%; height: 525px; overflow: auto;'  /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=2ff0deb7-ab86-4e2b-b439-eb263babc769 class=gs_w data-col="16" data-row="5" data-sizex="15" data-sizey="6"><oa:view column='DEPT_OPINION' table='TA_OA_WHTJY_QIANCHENG' title ='' style='border:0;width:99%; height: 150px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=799da46c-7508-4274-b0e8-36c1017db602 class=gs_w data-col="16" data-row="11" data-sizex="15" data-sizey="6"><oa:view column='OFFICE_OPINION' table='TA_OA_WHTJY_QIANCHENG' title ='' style='border:0;width:99%; height: 150px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=01e791e7-8812-490d-812b-5d069a81fed2 class=gs_w data-col="16" data-row="17" data-sizex="15" data-sizey="6"><oa:view column='LEAD_OPINION' table='TA_OA_WHTJY_QIANCHENG' title ='' style='border:0;width:99%; height: 150px; overflow: auto;' cntab='uuuu,tt' /></LI>
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
