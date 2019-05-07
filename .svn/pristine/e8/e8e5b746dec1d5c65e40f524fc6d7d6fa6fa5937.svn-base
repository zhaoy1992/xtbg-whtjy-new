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
%>

<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
  <title>武汉特检院发文</title>
<script language="javascript" src="<%=path %>/ccapp/xtbg/resources/plug/Lodop/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
	<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="../../xtbg/resources/plug/Lodop/install_lodop.exe"></embed>
</object> 
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
	jQuery("#form_print_fawen").hide();
	jQuery("#"+jQuery("#field_drag_in_title").val()).focus();
	jQuery("#_fileshow").attr('style','border-bottom: 0px; position: relative; border-left: 0px; line-height: 29px; overflow-x: hidden; overflow-y: auto; margin: 1px; padding-left: 10px; background: white; height: 59px; max-height: 69px; border-top: 0px; border-right: 0px;');
	
  }
function creaAttach(){
		var attachid = jQuery("#TA_OA_WHTJY_FAWEN__T_FJ_ID").val();
		jQuery("#_fileshow_print li").remove();
		MyFancyupload.createUpload('_fileshow_print', '#_filebut_print', '<%=path%>', 
				'<%=path%>/servlet/FileUpload?buessid='+attachid, true,
				attachid,'','','000');
		jQuery(".swiff-uploader-box").hide();
   }
   
var arry = new Array();
var b = 0;
function hidebutton(){
	jQuery(".but_y_01").each(function(i){
		 var a  = jQuery(".but_y_01")[i].style.display;
		 if(a !="none" ){
			jQuery(this).attr("id","showandhide"+i);
			jQuery(this).hide();
			arry[b]= i;
			b++;
		 }
	});
}

function showbutton(){
	for(var c=0;c<arry.length;c++){
		var i = arry[c];
		jQuery("#showandhide"+i).show();
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
<oa:input type='hidden' column='USER_ID' table='TA_OA_WHTJY_FAWEN' value='<%=user_id%>' /><oa:input type='hidden' column='USER_NAME' table='TA_OA_WHTJY_FAWEN' value='<%=user_name%>' /><oa:input type='hidden' column='ORG_ID' table='TA_OA_WHTJY_FAWEN' value='<%=org_id%>' /><oa:input type='hidden' column='CREATED' table='TA_OA_WHTJY_FAWEN' value='<%=time%>' />
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
					<LI style="POSITION: absolute; FILTER: ; WIDTH: 929px; ZOOM: 1; DISPLAY: list-item; MARGIN-BOTTOM: -1px; BACKGROUND: white; HEIGHT: 31px" id=c513ae3c-e47e-4de6-b19b-0774ff22ada1 class=gs_w data-col="1" data-row="1" data-sizex="30" data-sizey="1"><oa:span style='font-size: 30px; color: #ff0000; padding-left: 23%; line-height: 30px;' column='null'  table='' value= '湖北特种设备检验检测研究院' /></LI>
<LI style="FILTER: ; WIDTH: 929px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px" id=d81d46e5-94c3-45ae-a742-86afafc93020 class=gs_w data-col="1" data-row="2" data-sizex="30" data-sizey="1"><oa:span style='font-size: 30px; color: #ff0000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '文件起草流转卡' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=5be66c92-5d4b-40f5-b65e-d5d69c0b7b30 class=gs_w data-col="1" data-row="3" data-sizex="4" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '文件编号' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=af6b3494-ddd6-42ee-835f-5d64b1700078 class=gs_w data-col="5" data-row="3" data-sizex="11" data-sizey="1"><input type='hidden' id='field_drag_in_number' value='TA_OA_WHTJY_FAWEN__FILE_NUMBER'/><oa:numberinput title='' column='FILE_NUMBER' table='TA_OA_WHTJY_FAWEN' style= 'width: 180px;border: 0px;line-height:26px; height:26px;float:left;'/></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=e6bf97e8-a208-4ba4-8cd7-1019caa7dd60 class=gs_w data-col="16" data-row="3" data-sizex="4" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '拟搞人' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=22b61569-e260-4e97-93f6-635b98d8bd2c class=gs_w data-col="20" data-row="3" data-sizex="11" data-sizey="1"><oa:input title='' type='text' column='INTENDED_PERSON' table='TA_OA_WHTJY_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=8a853124-f20a-4641-95f1-83b64b6b4d4e class=gs_w data-col="1" data-row="4" data-sizex="4" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '文件标题' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=16065c12-85b1-49b1-a1f8-7b909333d2b4 class=gs_w data-col="5" data-row="4" data-sizex="26" data-sizey="1"><input type='hidden' id='field_drag_in_title' value='TA_OA_WHTJY_FAWEN__FILE_TITLE'/><oa:input title='' type='text' column='FILE_TITLE' table='TA_OA_WHTJY_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=drag_in_title%>'/></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=72a131ec-8f69-44ba-82fd-d32e44a835b1 class=gs_w data-col="1" data-row="5" data-sizex="4" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '主送' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=7d859cbe-0642-4e94-b9d0-bfb86063bd3d class=gs_w data-col="5" data-row="5" data-sizex="26" data-sizey="1"><oa:input title='' type='text' column='MAIN_PERSONS' table='TA_OA_WHTJY_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=f45f4b2d-be81-40f2-b185-48ded1a832cd class=gs_w data-col="1" data-row="6" data-sizex="4" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '抄送' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=ba338235-60e9-46c3-b75f-08e295f5f574 class=gs_w data-col="5" data-row="6" data-sizex="26" data-sizey="1"><oa:input title='' type='text' column='ATTACHED_PERSONS' table='TA_OA_WHTJY_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; MARGIN-BOTTOM: -1px; BACKGROUND: white; HEIGHT: 31px" id=8d1545ad-c1fc-4a51-a3d1-0bbd4b9c7932 class=gs_w data-col="1" data-row="7" data-sizex="15" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 1%; line-height: 30px;' column='null'  table='' value= '主办科室意见' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; MARGIN-BOTTOM: -1px; BACKGROUND: white; HEIGHT: 31px" id=40fc42cd-ffc1-4a57-b4ca-ba68ee6e5a17 class=gs_w data-col="16" data-row="7" data-sizex="15" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 1%; line-height: 30px;' column='null'  table='' value= '办公室核稿意见' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=573eb6e1-b664-410b-af15-48eec348fb30 class=gs_w data-col="1" data-row="8" data-sizex="15" data-sizey="5"><oa:view column='SPONSOR_OPINION' table='TA_OA_WHTJY_FAWEN' title ='' style='border:0;width:99%; height: 120px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=bf78ffbe-0b21-4016-926c-349d1bd89124 class=gs_w data-col="16" data-row="8" data-sizex="15" data-sizey="5"><oa:view column='OFFICE_OPINION' table='TA_OA_WHTJY_FAWEN' title ='' style='border:0;width:99%; height: 120px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; MARGIN-BOTTOM: -1px; BACKGROUND: white; HEIGHT: 31px" id=e96673d4-6783-4ab6-8748-b46d28b58582 class=gs_w data-col="1" data-row="13" data-sizex="30" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 1%; line-height: 30px;' column='null'  table='' value= '处理及会签意见' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=6539d6e2-2860-4ac2-9aad-810077bdae35 class=gs_w data-col="1" data-row="14" data-sizex="30" data-sizey="7"><oa:view column='TREATMENT_OPINION' table='TA_OA_WHTJY_FAWEN' title ='' style='border:0;width:99%; height: 180px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; MARGIN-BOTTOM: -1px; BACKGROUND: white; HEIGHT: 31px" id=57c1bc4f-490c-460e-aafb-45fef2fd48e6 class=gs_w data-col="1" data-row="21" data-sizex="30" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 1%; line-height: 30px;' column='null'  table='' value= '批准意见' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=b7c601dd-2f55-414c-9de3-2959da7e0bc3 class=gs_w data-col="1" data-row="22" data-sizex="30" data-sizey="5"><oa:view column='APPROVAL_OPINION' table='TA_OA_WHTJY_FAWEN' title ='' style='border:0;width:99%; height: 120px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=cf8e54b4-967e-4a77-8e73-635dc431c2f5 class=gs_w data-col="1" data-row="27" data-sizex="4" data-sizey="2"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '附件' /></LI>
<LI style="FILTER: ; WIDTH: 186px; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white; MARGIN-RIGHT: -1px" id=ef80b698-ced5-4c63-ae71-26b9969056cc class=gs_w data-col="5" data-row="27" data-sizex="6" data-sizey="2"><input type='hidden' id='field_drag_in_attach' value='TA_OA_WHTJY_FAWEN__T_FJ_ID'/><oa:affixbut butName='请选择文件' column='T_FJ_ID' table='TA_OA_WHTJY_FAWEN'  title ='' operType='111' initFjDJBHForArchive ='<%=drag_in_attach%>' /></LI>
<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=0a8acd5c-7be4-47b0-89cb-baf60753585c class=gs_w data-col="11" data-row="27" data-sizex="20" data-sizey="2"><oa:affixshow  title =''/></LI>
					</ul>
			    </div>		
				</section>
			</article>
		</div>
				<div id="tabs-3">
			<oa:webtext column="T_ZW_ID" table="TA_OA_WHTJY_FAWEN" defautValue="<%=drag_in_webtext%>"/>
			<input type='hidden' id='field_drag_in_webtext' value="TA_OA_WHTJY_FAWEN__T_ZW_ID"/>
		</div>	
		</div>	    		
<div style="height:50px">
</div>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</form>

<form id="form_print_fawen">
<table  width="100%" id="print_table_fawen" style="font-size:12pt;display:none; font-family:宋体;margin:0px; border-spacing: 0px; border-collapse: 0px;">
			<table style="border-collapse:collapse;background:#ffffff;padding:0px;color: #FF0000; margin: 0px;border: 1px solid #FF0000;font-size: 12pt;font-family:宋体;width:95%;" id="queryTable1" >
				<tr>
					<td align="center" colspan="8" >
							<span style="font-size:24pt; font-family:方正小标宋简体;color: red ;line-height: 30px;">湖北特种设备检验检测研究院<br>文件起草流转卡</span>
					</td>
				</tr>
			<tr >
		            <td width="15%"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
						<font style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
						文件编号
						</font>
		            </td>
		            <td width="35%"  colspan="3"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
						<oa:numberinput title='' column='FILE_NUMBER' table='TA_OA_WHTJY_FAWEN' style= 'width: 140px;border: 0px;line-height:26px; height:26px;float:left;'/>
		            </td>
		            <td width="15%"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
						<font style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
						拟搞人
						</font>
		            </td>
		            <td width="35%" colspan="3"    align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
						<oa:input title='' type='text' column='INTENDED_PERSON' table='TA_OA_WHTJY_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/>
		            </td>
		              
            </tr>
           	<tr >
	            <td width="15%"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
					<font style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					文件标题
					</font>
	            </td>
	            <td width="85%"  colspan="7"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
					<oa:input title='' type='text' column='FILE_TITLE' table='TA_OA_WHTJY_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=drag_in_title%>'/>
	            </td>
           	</tr>
           	<tr >
	            <td width="15%"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
					<font style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					主送
					</font>
	            </td>
	            <td width="85%"  colspan="7"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
					<oa:input title='' type='text' column='MAIN_PERSONS' table='TA_OA_WHTJY_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/>
	            </td>
           	</tr>
           	<tr >
	            <td width="15%"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
					<font style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					抄送
					</font>
	            </td>
	            <td width="85%"  colspan="7"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
					<oa:input title='' type='text' column='ATTACHED_PERSONS' table='TA_OA_WHTJY_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/>
	            </td>
           	</tr>
           <tr >
	            <td width="100%"  colspan="4" align="left" style="border:1px solid #FF0000;
	             padding: 5px; color:#FF0000;vertical-align: top;">主办科室意见<br>	
					<oa:view column='SPONSOR_OPINION' table='TA_OA_WHTJY_FAWEN' title ='' style='border:0;width:99%; height: 90px; overflow: auto;' cntab='uuuu,tt' />
	            </td>
	            <td width="100%"  colspan="4" align="left" style="border:1px solid #FF0000; 
	            padding: 5px; color:#FF0000;vertical-align: top;">办公室核稿意见<br>
					<oa:view column='OFFICE_OPINION' table='TA_OA_WHTJY_FAWEN' title ='' 
					style='border:0;width:99%; height: 90px; overflow: auto;' cntab='uuuu,tt' />
				
	            </td>
           	</tr>
           	
           	 <tr>
	            <td width="100%"  colspan="8" align="left" style="border:1px solid #FF0000;
	             padding: 5px; color:#FF0000;vertical-align: top;">处理及会签意见 <br>
					
					<div id="aaaa" style="color:#000000;">
					</div>
	            </td>
           	</tr>
           	<tr >
	            <td width="100%"  colspan="8" align="left" style="border:1px solid #FF0000; 
	            padding: 5px; color:#FF0000;vertical-align: top;">批准意见<br>
						<div id="bbbb" style="color:#000000;">
					</div>
	            </td>
           	</tr>
          			</table>
	          	</td>
	          </tr>
				</table>
         
    </table>
</form>
<script language="javascript" type="text/javascript">
     var LODOP; //声明为全局变量 
	function prn_preview() {
		var a = jQuery("#TA_OA_WHTJY_FAWEN__TREATMENT_OPINION").val();
		var b = jQuery("#TA_OA_WHTJY_FAWEN__APPROVAL_OPINION").val()
		if(IsSpace(a)){
			jQuery("#aaaa").css("height","190px");
		}else{
			jQuery("#aaaa").html(a.replaceAll('\n','<br>').replaceAll('\t','&nbsp;&nbsp;&nbsp;'));
		}
		if(IsSpace(b)){
			jQuery("#bbbb").css("height","190px");
		}else{
			jQuery("#bbbb").html(b.replaceAll('\n','<br>').replaceAll('\t','&nbsp;&nbsp;&nbsp;'));
		}
		
		hidebutton();
		CreateOneFormPage_fawen();	
		LODOP.PREVIEW();	
		jQuery("#print_table_fawen").hide();
		showbutton();
	};

	function CreateOneFormPage_fawen(){
		LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));  
		LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_表单一");
		//LODOP.SET_PRINT_STYLE("FontSize",12);
		//LODOP.SET_PRINT_STYLE("FontName","宋体");

		LODOP.SET_PRINT_STYLE("Bold",1);
		LODOP.ADD_PRINT_TEXT(50,231,260,39,"");
		LODOP.ADD_PRINT_HTM(60,45,'95%',980,document.getElementById("form_print_fawen").innerHTML);
	};	                     
	
</script>
</body>
</oa:init>
</html>
<script>jQuery(function(){ //DOM Ready
	initPageObj();
	
});
</script>
