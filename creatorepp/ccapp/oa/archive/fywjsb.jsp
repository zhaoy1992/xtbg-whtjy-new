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
  <title>湖北特检院分院文件上报</title>
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
							</ul>
		</div>
		<div id="tabs-1">
			<article>
				<section>
				<div class="gridster">
					<ul>
					<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=87cf1a2e-ed58-4ecb-9361-d6b0c7193d1b class=gs_w data-sizey="1" data-sizex="5" data-row="1" data-col="1"><oa:span style='font-size: 15px; color: #ff0000; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '标题' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=3360486a-bb9e-44ff-a730-c4dbd1b12180 class=gs_w data-sizey="1" data-sizex="25" data-row="1" data-col="6"><oa:input title='' type='text' column='TITLE' table='OA_FILE_FYFAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI style="FILTER: none; WIDTH: 154px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px" id=f732ce3a-bdc2-4696-9846-1d12db74e61e class=gs_w data-sizey="1" data-sizex="5" data-row="2" data-col="1"><oa:span style='font-size: 15px; color: #ff0000; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '申请人' /></LI>
<LI style="POSITION: absolute; FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=5a1de87b-ac4b-484d-a911-387ab4c2982d class="gs_w player-revert" data-sizey="1" data-sizex="10" data-row="2" data-col="6"><oa:input title='' type='text' column='FW_DRAFTMAN' table='OA_FILE_FYFAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=0a4aaa9d-8721-4360-88fe-1d46acc099dd class=gs_w data-sizey="1" data-sizex="10" data-row="2" data-col="21"><oa:input title='' type='text' column='FW_DRAFTUNIT' table='OA_FILE_FYFAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=org_name%>'/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=d3a5fab6-a24a-4165-a7b2-fc83e631dbf5 class=gs_w data-sizey="1" data-sizex="5" data-row="2" data-col="16"><oa:span style='font-size:15px; color: #ff0000; padding-left:40%; line-height: 30px;' column='null'  table='' value= '所属机构' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=8d08b97e-b8e2-4641-9109-224a95ab0549 class=gs_w data-sizey="3" data-sizex="5" data-row="3" data-col="1"><oa:span style='font-size: 15px; color: #ff0000; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '相关事由' /></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=2ead6fa2-bb8a-4b2d-b34e-de876522a5d2 class=gs_w data-sizey="3" data-sizex="25" data-row="3" data-col="6"><oa:input title='' type='text' column='FW_XGSY' table='OA_FILE_FYFAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:60px;' value = ''/></LI>
<LI style="FILTER: none; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=91cc7028-6601-4fe6-b1d1-70ac9b9839b8 class=gs_w data-sizey="1" data-sizex="5" data-row="6" data-col="1"><oa:span style='font-size: 15px; color: #ff0000; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '附件上传' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=a4e642fe-0ce1-45a5-9f18-71e903046d67 class=gs_w data-sizey="1" data-sizex="5" data-row="6" data-col="6"><input type='hidden' id='field_drag_in_attach' value='OA_FILE_FYFAWEN__T_FJ_ID'/><oa:affixbut butName='请选择文件' column='T_FJ_ID' table='OA_FILE_FYFAWEN'  title ='' operType='111' initFjDJBHForArchive ='<%=drag_in_attach%>' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=85f6c039-1118-4f7a-a494-9daaa2fcf862 class=gs_w data-sizey="1" data-sizex="20" data-row="6" data-col="11"><oa:affixshow  title =''/></LI>
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
