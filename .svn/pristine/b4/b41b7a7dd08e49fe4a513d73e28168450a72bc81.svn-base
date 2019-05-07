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
String path = request.getContextPath();
String windowsId = request.getParameter("windowsId");
String circularize_id = request.getParameter("circularize_id");
String circutype  = StringUtil.deNull(request.getParameter("circutype"));
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
  <title>湖北特检院收文</title>
  <script language="javascript" src="<%=path %>/ccapp/xtbg/resources/plug/Lodop/LodopFuncs.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
	<embed id="LODOP_EM" type="application/x-print-lodop" 
	width=0 height=0 pluginspage="../../xtbg/resources/plug/Lodop/install_lodop.exe"></embed>
</object> 

  <script>
  var circutype ='<%=circutype%>';
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
	jQuery("#form_print_shouwen").hide();
	jQuery("#"+jQuery("#field_drag_in_title").val()).focus();
	
	//只有是传阅进来才做这个操作
	if("circutype"==circutype){
		hidebuttons();
		jQuery("#chuanye2").css('display','block');
		jQuery("#chuanye3").css('display','block'); 
		jQuery("#chuanye4").css('display','block');
	}
	jQuery("#_fileshow").attr('style','border-bottom: 0px; position: relative; border-left: 0px; line-height: 29px; overflow-x: hidden; overflow-y: auto; margin: 1px; padding-left: 10px; background: white; height: 69px; max-height: 69px; border-top: 0px; border-right: 0px;');
   }
function creaAttach(){
	var attachid = jQuery("#TA_OA_WHTJY_SHOUWEN__T_FJ_ID").val();
	jQuery("#_fileshow_print li").remove();
	MyFancyupload.createUpload('_fileshow_print', '#_filebut_print', '<%=path%>', 
			'<%=path%>/servlet/FileUpload?buessid='+attachid, true,
			attachid,'','','000');
	jQuery(".swiff-uploader-box").hide();
}


var c = 0;
function hidebuttons(){
	jQuery(".but_y_01").each(function(i){
		 var a  = jQuery(".but_y_01")[i].value;
		 if(a =="填写意见" ){
			 jQuery(this).attr("id","chuanye"+c);
			 c++;
		 }
	});
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
<input id="circularize_id" name="circularize_id" type="hidden" value="<%=circularize_id %>"/>
<input id="abc" name="abc" type="hidden" value="abc"/>
<oa:input type='hidden' column='USER_ID' table='TA_OA_WHTJY_SHOUWEN' value='<%=user_id%>' /><oa:input type='hidden' column='USER_NAME' table='TA_OA_WHTJY_SHOUWEN' value='<%=user_name%>' /><oa:input type='hidden' column='CREATED' table='TA_OA_WHTJY_SHOUWEN' value='<%=time%>' /><oa:input type='hidden' column='ORG_ID' table='TA_OA_WHTJY_SHOUWEN' value='<%=unit_id%>' />
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
					<LI class=gs_w id=60b5a907-8d80-45c4-b50a-93a94fc4c668 style="BACKGROUND: white; ZOOM: 1; DISPLAY: list-item" data-col="1" data-row="3" data-sizex="4" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '来文单位' /></LI>
<LI class=gs_w id=089f115a-da9c-42a9-80de-44461c52760b style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="5" data-row="3" data-sizex="11" data-sizey="1"><oa:input title='' type='text' column='FILE_COMPANY' table='TA_OA_WHTJY_SHOUWEN' style= 'width: 95%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI class=gs_w id=f70b0b19-7b52-4938-98ba-b9d4ad5f2d63 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="16" data-row="3" data-sizex="4" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '文件编号' /></LI>
<LI class=gs_w id=cb231f2e-8da8-4d18-977a-6ea3984db077 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="20" data-row="3" data-sizex="11" data-sizey="1"><input type='hidden' id='field_drag_in_number' value='TA_OA_WHTJY_SHOUWEN__FILE_NO'/><oa:numberinput title='' column='FILE_NO' table='TA_OA_WHTJY_SHOUWEN' style= 'width: 180px;border: 0px;line-height:26px; height:26px;float:left;'/></LI>
<LI class=gs_w id=281af101-ff18-4c53-ae71-24d9efa2e77e style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="4" data-sizex="4" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '收文日期' /></LI>
<LI class=gs_w id=93071388-addc-46e0-9c90-215630828502 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="5" data-row="4" data-sizex="11" data-sizey="1"><oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='GET_FILE_DATE' table='TA_OA_WHTJY_SHOUWEN' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/></LI>
<LI class=gs_w id=1ddff477-7cdd-4f50-8832-d4274fd61df1 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="16" data-row="4" data-sizex="4" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '收文编号' /></LI>
<LI class=gs_w id=2b4a353e-1f10-4911-a905-1066094ef106 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="20" data-row="4" data-sizex="11" data-sizey="1"><oa:input title='' type='text' column='GET_FILE_NO' table='TA_OA_WHTJY_SHOUWEN' style= 'width: 95%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI class=gs_w id=baa92e6e-33e4-4791-a51b-b32a26ebe51a style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="5" data-sizex="4" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '文件标题' /></LI>
<LI class=gs_w id=494f835e-43b7-46ff-b2d8-f033446711f5 style="BACKGROUND: white; ZOOM: 1; DISPLAY: list-item" data-col="5" data-row="5" data-sizex="26" data-sizey="1"><input type='hidden' id='field_drag_in_title' value='TA_OA_WHTJY_SHOUWEN__FILE_TITLE'/><oa:input title='' type='text' column='FILE_TITLE' table='TA_OA_WHTJY_SHOUWEN' style= 'width: 95%;border: 0px;line-height:26px; height:26px;' value = '<%=drag_in_title%>'/></LI>
<LI class=gs_w id=2b2a882c-f648-4d48-915d-818264409fd7 style="BACKGROUND: white; ZOOM: 1; DISPLAY: list-item" data-col="1" data-row="6" data-sizex="2" data-sizey="5"><oa:span style='font-size: 20px; color: #ff0000; margin:auto;margin-top:20px; width:30%;line-height: 30px;display:block;' column='null'  table='' value= '拟办意见' /></LI>
<LI class=gs_w id=e8d597b4-328f-4847-b082-65190e6dd093 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="3" data-row="6" data-sizex="28" data-sizey="5"><oa:view column='TO_DO_OPINION' table='TA_OA_WHTJY_SHOUWEN' title ='' style='border:0;width:99%; height: 120px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI class=gs_w id=ff1bdb86-e452-460b-b489-d1ca04592af9 style="BACKGROUND: white; ZOOM: 1; DISPLAY: list-item" data-col="1" data-row="11" data-sizex="2" data-sizey="6"><oa:span style='font-size: 20px; color: #ff0000; margin:auto;margin-top:20px; width:30%;line-height: 30px;display:block;' column='null'  table='' value= '领导批示' /></LI>
<LI class=gs_w id=de267c3f-620a-49ca-aa82-96b6ee63bab5 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="3" data-row="11" data-sizex="28" data-sizey="6"><oa:view column='LEADER_OPINION' table='TA_OA_WHTJY_SHOUWEN' title ='' style='border:0;width:99%; height: 150px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI class=gs_w id=eb94c583-fe3d-414c-b90b-3502645c04ca style="BACKGROUND: white; ZOOM: 1; DISPLAY: list-item" data-col="1" data-row="23" data-sizex="2" data-sizey="5"><oa:span style='font-size: 20px; color: #ff0000; margin:auto;margin-top:20px; width:30%;line-height: 30px;display:block;' column='null'  table='' value= '办理情况' /></LI>
<LI class=gs_w id=ce005551-baa6-4c42-8693-eb09037aec0e style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="3" data-row="23" data-sizex="28" data-sizey="5"><oa:view column='MANAGEMENT_OPINION' table='TA_OA_WHTJY_SHOUWEN' title ='' style='border:0;width:99%; height: 120px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI class=gs_w id=a018511c-8ffb-463c-b957-30a3e42f4210 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="28" data-sizex="2" data-sizey="5"><oa:span style='font-size: 20px; color: #ff0000; margin:auto;margin-top:20px; width:30%;line-height: 30px;display:block;' column='null'  table='' value= '传阅签名' /></LI>
<LI class=gs_w id=54f1ea1b-2c2b-4f0a-ae9e-8a05953fc550 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="3" data-row="28" data-sizex="28" data-sizey="5"><oa:view column='CIRCULATE_OPINION' table='TA_OA_WHTJY_SHOUWEN' title ='' style='border:0;width:99%; height: 130px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI class=gs_w id=02fe33b2-b3ad-4ec9-9673-f9d252f53348 style="BACKGROUND: white; POSITION: absolute; ZOOM: 1; DISPLAY: list-item" data-col="1" data-row="17" data-sizex="2" data-sizey="6"><oa:span style='font-size: 20px; color: #ff0000; margin:auto;margin-top:20px; width:30%;line-height: 25px;display:block;' column='null'  table='' value= '领导传阅签名' /></LI>
<LI class=gs_w id=a4efe952-b117-45b8-958f-4bd5675bdb96 style="BACKGROUND: white; POSITION: absolute; ZOOM: 1; DISPLAY: list-item" data-col="3" data-row="17" data-sizex="28" data-sizey="6"><oa:view column='LDYS' table='TA_OA_WHTJY_SHOUWEN' title ='' style='border:0;width:90%; height: 150px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI class="gs_w player-revert" id=76e2d2cb-7d73-43e6-9730-fcc93e573ca5 style="BACKGROUND: white; POSITION: absolute; DISPLAY: list-item" data-col="1" data-row="1" data-sizex="30" data-sizey="2"><oa:span style='font-size: 20pt; color: #ff0000; display:block;width:100%;text-align:center;line-height:60px;' column='null'  table='' value= '湖北特种设备检验检测研究院文件处理单' /></LI>
<LI class=gs_w id=239a3dad-2e95-4adb-83c1-fabb93f4ad14 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="33" data-sizex="2" data-sizey="4"><oa:span style='font-size: 18px; color: #ff0000; margin:auto;margin-top:10px; width:30%;line-height: 30px;display:block;' column='null'  table='' value= '相关附件' /></LI>
<LI class=gs_w id=a57efa96-e7e1-4a7c-9297-23f30f9a6ffd style="WIDTH: 186px; BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item; MARGIN-RIGHT: -1px" data-col="3" data-row="33" data-sizex="6" data-sizey="4"><input type='hidden' id='field_drag_in_attach' value='TA_OA_WHTJY_SHOUWEN__T_FJ_ID'/><oa:affixbut butName='请选择文件' column='T_FJ_ID' table='TA_OA_WHTJY_SHOUWEN'  title ='' operType='111' initFjDJBHForArchive ='<%=drag_in_attach%>' /></LI>
<LI class=gs_w id=206c5ce5-33d7-40f2-bfbe-3d9005152b42 style="HEIGHT: 123px; WIDTH: 681px; BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="9" data-row="33" data-sizex="22" data-sizey="4"><oa:affixshow  title =''/></LI>
					</ul>
			    </div>		
				</section>
			</article>
		</div>
				<div id="tabs-3">
			<oa:webtext column="T_ZW_ID" table="TA_OA_WHTJY_SHOUWEN" defautValue="<%=drag_in_webtext%>"/>
			<input type='hidden' id='field_drag_in_webtext' value="TA_OA_WHTJY_SHOUWEN__T_ZW_ID"/>
		</div>	
		</div>	    		
<div style="height:50px">
</div>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</form>

<form id="form_print_shouwen">
<table  width="100%" id="form_print_shouwen" style="font-size:12pt;display:none; font-family:宋体;margin:0px; border-spacing: 0px; border-collapse: 0px;">
			<table style="border-collapse:collapse;background:#ffffff;padding:0px;color: #FF0000; margin: 0px;border: 1px solid #FF0000;font-size: 12pt;font-family:宋体;width:95%;" id="queryTable1" >
				<tr>
					<td align="center" colspan="10" >
							<span style="font-size:24pt; font-family:方正小标宋简体;color: red ;line-height: 30px;">湖北特种设备检验检测研究院文件处理单</span>
					</td>
				</tr>
			<tr >
		            <td width="15%"  colspan="2" align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
						<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
						来文单位
						</font>
		            </td>
		            <td width="35%"  colspan="3"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
						<oa:input title='' type='text' column='FILE_COMPANY' table='TA_OA_WHTJY_SHOUWEN' style= 'width: 95%;border: 0px;line-height:26px; height:26px;' value = ''/>
		            </td>
		            <td width="15%"   colspan="2" align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
						<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
						文件编号
						</font>
		            </td>
		            <td width="35%" colspan="3"    align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
						<oa:input title='' type='text' column='FILE_NO' table='TA_OA_WHTJY_SHOUWEN' style= 'width: 150px;border: 0px;line-height:26px; height:26px;float:left;'/>
		            </td>
		              
            </tr>
            <tr >
		            <td width="15%"  colspan="2" align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
						<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
						收文日期
						</font>
		            </td>
		            <td width="35%"  colspan="3"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
						<oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='GET_FILE_DATE' table='TA_OA_WHTJY_SHOUWEN' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px; width:180px; border:0px;'/>
		            </td>
		            <td width="15%"   colspan="2" align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
						<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
						收文编号
						</font>
		            </td>
		            <td width="35%" colspan="3"    align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
						<oa:input title='' type='text' column='GET_FILE_NO' table='TA_OA_WHTJY_SHOUWEN' style= 'width: 95%;border: 0px;line-height:26px; height:26px;' value = ''/>
		            </td>
            </tr>
           	<tr >
	            <td width="15%"   colspan="2" align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
					<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					文件标题
					</font>
	            </td>
	            <td width="85%"  colspan="8"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
					<oa:input title='' type='text' column='FILE_TITLE' table='TA_OA_WHTJY_SHOUWEN' style= 'width: 95%;border: 0px;line-height:26px; height:26px;' value = '<%=drag_in_title%>'/>
	            </td>
           	</tr>

           <tr >
	            <td width="7%"  colspan="1" align="center" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
					<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					拟<br>办<br>意<br>见	
					</font>
	            </td>
	            <td width="93%"   colspan="9" align="left" style="border:1px solid #FF0000; padding: 5px; color:#000000;vertical-align: top;">
	           			<div id="aa" style="color:#000000;">
						</div>
				</td>
           	</tr>
           	<tr >
	            <td width="7%"  colspan="1" align="center" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
					<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					领<br>导<br>批<br>示
					</font>
	            </td>
	            <td width="93%"  id ="bb" colspan="9" align="left" style="border:1px solid #FF0000; padding: 5px; color:#000000;vertical-align: top;">
						<div id="bb" style="color:#000000;">
						</div>
	            </td>
           	</tr>
			<tr >
	            <td width="7%"  colspan="1" align="center" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
					<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					领<br>导<br>传<br>阅<br>签<br>名
					</font>
	            </td>
	            <td width="93%"   colspan="9" align="left" style="border:1px solid #FF0000; padding: 5px; color:#000000;vertical-align: top;">
	           			<div id="cc" style="color:#000000;">
						</div>
	            </td>
           	</tr>
           	<tr >
	            <td width="7%"  colspan="1" align="center" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
					<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					办<br>理<br>情<br>况
					</font>
	            </td>
	            <td width="93%"   colspan="9" align="left" style="border:1px solid #FF0000; padding: 5px; color:#000000;vertical-align: top;">
	            	<div id="dd" style="color:#000000;">
						</div>
	            </td>
           	</tr>
           	<tr >
	            <td width="7%"  colspan="1" align="center" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
					<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					传<br>阅<br>签<br>名
					</font>
	            </td>
	            <td width="93%"  colspan="9" align="left" style="border:1px solid #FF0000; padding: 5px; color:#000000;vertical-align: top;">
	            	<div id="ee" style="color:#000000;">
						</div>
	            </td>
           	</tr>
<!--            	<tr > -->
<!-- 	            <td width="7%"  colspan="1" align="center" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;"> -->
<!-- 					<font style='font-size: 18px; color: #ff0000; margin:auto;margin-top:10px; width:30%;line-height: 30px;display:block;' > -->
<!-- 					相<br>关<br>附<br>件 -->
<!-- 					</font> -->
<!-- 	            </td> -->
<!-- 	            <td width="93%"  colspan="9" align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;"> -->
<!-- 					<div style="overflow-y:scroll; height: 50px"> -->
<!-- 				          			<ul id="_fileshow_print"></ul> -->
<!-- 				    </div> -->
<!-- 	            </td> -->
<!--            	</tr> -->
         </table>
       		</td>
       </tr>
</table>
         
    </table>
</form>
<script language="javascript" type="text/javascript">
     var LODOP; //声明为全局变量 
	function prn_preview() {
		jQuery("#form_print_shouwen").show();
		var a = jQuery("#TA_OA_WHTJY_SHOUWEN__TO_DO_OPINION").val();
		if(IsSpace(a)){
			jQuery("#aa").css("height","80px");
		}else{
			jQuery("#aa").html(a.replaceAll('\n','<br>').replaceAll('\t','&nbsp;&nbsp;&nbsp;'));
		}
		var b = jQuery("#TA_OA_WHTJY_SHOUWEN__LEADER_OPINION").val();
		if(IsSpace(b)){
			jQuery("#bb").css("height","80px");
		}else{
			jQuery("#bb").html(b.replaceAll('\n','<br>').replaceAll('\t','&nbsp;&nbsp;&nbsp;'));	
		}
		

		var c = jQuery("#TA_OA_WHTJY_SHOUWEN__LDYS").val();
		if(IsSpace(c)){
			jQuery("#cc").css("height","80px");
		}else{
			jQuery("#cc").html(c.replaceAll('\n','<br>').replaceAll('\t','&nbsp;&nbsp;&nbsp;'));	
		}
		
		

		var d = jQuery("#TA_OA_WHTJY_SHOUWEN__MANAGEMENT_OPINION").val();
		if(IsSpace(d)){
			jQuery("#dd").css("height","80px");
		}else{
			jQuery("#dd").html(d.replaceAll('\n','<br>').replaceAll('\t','&nbsp;&nbsp;&nbsp;'));
		}
		

		var e = jQuery("#TA_OA_WHTJY_SHOUWEN__CIRCULATE_OPINION").val();
		if(IsSpace(e)){
			jQuery("#ee").css("height","80px");
		}else{
			jQuery("#ee").html(e.replaceAll('\n','<br>').replaceAll('\t','&nbsp;&nbsp;&nbsp;'));	
		}
		
		//creaAttach();
		hidebutton();
		CreateOneFormPage_fawen();	
		LODOP.PREVIEW();	
		jQuery("#form_print_shouwen").hide();
		showbutton();
		
	};

	function CreateOneFormPage_fawen(){
		LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));  
		LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_表单一");
		LODOP.SET_PRINT_STYLE("Bold",1);
		LODOP.ADD_PRINT_TEXT(50,231,260,39,"");
		LODOP.ADD_PRINT_HTM(60,45,'95%',980,document.getElementById("form_print_shouwen").innerHTML);
	};	                     
	
</script>
</body>
</oa:init>
</html>
<script>
jQuery(function(){ //DOM Ready
	initPageObj();
});
</script>
