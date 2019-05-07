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
  <title>文件处理笺</title>
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
<input 	type='hidden' id='attach_id_name' value='OA_FILE_SHOUWEN__T_FJ_ID' />

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
								<LI style="DISPLAY: list-item; BACKGROUND: white"
									id=23035fe3-ea19-4d4f-9197-3f365c6dab2e class=gs_w data-col="1"
									data-row="1" data-sizex="30" data-sizey="2"><oa:span
										style='font-size: 30px; color: #000000; width:100%;height:100%;display:block;text-align:center;line-height: 60px;font-weight:bold;letter-spacing:8px;'
										column='null' table='' value='公文处理笺' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=266280c5-fc5d-44c4-8617-259af05b53dd class=gs_w data-col="1"
									data-row="3" data-sizex="3" data-sizey="1"><oa:span
										style='font-size: 18px; color: black; padding-left: 10%; line-height: 30px;'
										column='null' table='' value='文件名称' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=d1c8df8e-eeba-417a-9460-dde4ec47fce7 class=gs_w data-col="4"
									data-row="3" data-sizex="27" data-sizey="1"><input
									type='hidden' id='field_drag_in_title'
									value='OA_FILE_SHOUWEN__WJMC' />
								<oa:input title='' type='text' column='WJMC'
										table='OA_FILE_SHOUWEN'
										style='width: 90%;border: 0px;line-height:26px; height:26px;'
										value='<%=drag_in_title%>' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=6cd24583-559f-4ba5-8148-6b6da748f18e class=gs_w data-col="1"
									data-row="4" data-sizex="3" data-sizey="1"><oa:span
										style='font-size: 18px; color: black; padding-left: 10%; line-height: 30px;'
										column='null' table='' value='来文单位' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=9d93b30a-e235-4d0a-9caf-14e500f1a19b class=gs_w data-col="4"
									data-row="4" data-sizex="17" data-sizey="1"><oa:input
										title='' type='text' column='LWDW' table='OA_FILE_SHOUWEN'
										style='width: 90%;border: 0px;line-height:26px; height:26px;'
										value='' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=a187cc91-26b0-45da-99e4-711b14cd69ef class=gs_w
									data-col="21" data-row="4" data-sizex="3" data-sizey="1"><oa:span
										style='font-size: 18px; color: black; padding-left: 10%; line-height: 30px;'
										column='null' table='' value='快慢等级' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=96df3b80-780c-44cd-999e-7d958cefb677 class=gs_w
									data-col="24" data-row="4" data-sizex="7" data-sizey="1"><oa:input
										title='' type='text' column='KMDJ' table='OA_FILE_SHOUWEN'
										style='width: 90%;border: 0px;line-height:26px; height:26px;'
										value='' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=24589f88-7087-42bf-8a46-b912bd42ea75 class=gs_w data-col="1"
									data-row="5" data-sizex="3" data-sizey="1"><oa:span
										style='font-size: 18px; color: black; padding-left: 16%; line-height: 30px;'
										column='null' table='' value='原文号' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=c8fe7b8e-7b89-4e6c-a8d5-54e6aea18dbb class=gs_w data-col="4"
									data-row="5" data-sizex="5" data-sizey="1"><oa:input
										title='' type='text' column='YWH' table='OA_FILE_SHOUWEN'
										style='width: 90%;border: 0px;line-height:26px; height:26px;'
										value='' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=a2b29419-b756-491b-b9d8-ee495f73dcfa class=gs_w data-col="9"
									data-row="5" data-sizex="2" data-sizey="1"><oa:span
										style='font-size: 18px; color: black; padding-left: 10%; line-height: 30px;'
										column='null' table='' value='份数' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=743ba744-f42c-4429-a133-20cea7b9af2c class=gs_w
									data-col="11" data-row="5" data-sizex="3" data-sizey="1"><oa:input
										title='' type='text' column='FS' table='OA_FILE_SHOUWEN'
										style='width: 90%;border: 0px;line-height:26px; height:26px;'
										value='' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=dad290d5-2b77-4390-90c3-c7355fdf3c03 class=gs_w
									data-col="14" data-row="5" data-sizex="3" data-sizey="1"><oa:span
										style='font-size: 18px; color: black; padding-left: 10%; line-height: 30px;'
										column='null' table='' value='收到日期' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=29c6d558-99ff-4c46-9dcf-02bee592942d class=gs_w
									data-col="17" data-row="5" data-sizex="4" data-sizey="1"><oa:date
										dateFmt='yyyy-MM-dd HH:mm:ss' column='SDRQ'
										table='OA_FILE_SHOUWEN' title=''
										style='width: 90%;height:22px;line-height: 22px;margin-left:5px;margin-top:3px;display:block;'
										other="class='Wdate'" />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=62a952dc-ad8e-41d8-8e6a-39cf0a97a89d class=gs_w
									data-col="21" data-row="5" data-sizex="2" data-sizey="1"><oa:span
										style='font-size: 18px; color: black; padding-left: 10%; line-height: 30px;'
										column='null' table='' value='编号' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=6dd47f9b-68c6-4522-867f-61d12a01209d class=gs_w
									data-col="23" data-row="5" data-sizex="3" data-sizey="1"><oa:input
										title='' type='text' column='BH' table='OA_FILE_SHOUWEN'
										style='width: 90%;border: 0px;line-height:26px; height:26px;'
										value='' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=da4d5cb2-5bb2-43ed-b4da-d50ccc8dd8b4 class=gs_w
									data-col="26" data-row="5" data-sizex="2" data-sizey="1"><oa:span
										style='font-size: 18px; color: black; padding-left: 10%; line-height: 30px;'
										column='null' table='' value='入卷号' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=68d3a1aa-617e-4a10-8564-09a4381f2d00 class=gs_w
									data-col="28" data-row="5" data-sizex="3" data-sizey="1"><oa:input
										title='' type='text' column='RJH' table='OA_FILE_SHOUWEN'
										style='width: 90%;border: 0px;line-height:26px; height:26px;'
										value='' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=bfbcf445-54e5-4354-a6db-1a19d49b6545 class=gs_w data-col="1"
									data-row="6" data-sizex="3" data-sizey="4"><oa:span
										style='font-size: 18px; color: black; margin:auto;margin-top:20px; width:30%;line-height: 20px;display:block;'
										column='null' table='' value='拟办意见' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=cadef440-d8a3-463b-ba3f-0d1a16cf18e0 class=gs_w data-col="4"
									data-row="6" data-sizex="27" data-sizey="4"><oa:view
										column='NBYJ' table='OA_FILE_SHOUWEN' title=''
										style='border:0;width:90%; height: 80%; overflow: auto;display:block;margin-top:4px;'
										cntab='uuuu,tt' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=a3a6a02e-dd18-4317-a5e1-836464b7f9c9 class=gs_w data-col="1"
									data-row="10" data-sizex="3" data-sizey="4"><oa:span
										style='font-size: 18px; color: black; margin:auto;margin-top:10px; width:30%;line-height: 20px;display:block;'
										column='null' table='' value='批阅人意见' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=d759d847-bfe6-4f25-9e5c-9e346f566b8c class=gs_w data-col="4"
									data-row="10" data-sizex="27" data-sizey="4"><oa:view
										column='PYRYJ' table='OA_FILE_SHOUWEN' title=''
										style='border:0;width:90%; height: 80%; overflow: auto;display:block;margin-top:4px;'
										cntab='uuuu,tt' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=8a5ef951-1a1d-40d0-b17e-d9d491f8a01c class=gs_w data-col="1"
									data-row="14" data-sizex="3" data-sizey="12"><oa:span
										style='font-size: 18px; color: black; margin:auto;margin-top:12px; width:50%;line-height: 24px;display:block;'
										column='null' table='' value='<br><br><br><br><br>传阅人签名或意见' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=a2dccd29-eb78-4055-9885-eff68e38113d class=gs_w data-col="4"
									data-row="14" data-sizex="27" data-sizey="12"><oa:view
										column='CYRQMHYJ' table='OA_FILE_SHOUWEN' title=''
										style='border:0;width:90%; height: 90%; overflow: auto;display:block;margin-top:4px;'
										cntab='uuuu,tt' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=23cd6808-f9fc-4d40-9e8f-07021d55d5a4 class=gs_w data-col="1"
									data-row="26" data-sizex="3" data-sizey="12"><oa:span
										style='font-size: 18px; color: black; margin:auto;margin-top:12px; width:50%;line-height: 24px;display:block;'
										column='null' table='' value='<br><br><br><br><br>主办单位执行意见' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=fe732574-3018-4762-ba03-d7cbf2487b6e class=gs_w data-col="4"
									data-row="26" data-sizex="27" data-sizey="12"><oa:view
										column='ZBDWZXYJ' table='OA_FILE_SHOUWEN' title=''
										style='border:0;width:90%; height: 90%; overflow: auto;display:block;margin-top:4px;'
										cntab='uuuu,tt' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=91bea1b6-b05c-4db2-8f85-2b313cb77a6a class=gs_w data-col="1"
									data-row="38" data-sizex="3" data-sizey="2"><oa:span
										style='font-size: 18px; color: black; padding-left: 30%; line-height: 60px;'
										column='null' table='' value='备注' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=29a1ab46-6ed1-4adb-ba6b-538bccc1253e class=gs_w data-col="4"
									data-row="38" data-sizex="27" data-sizey="2"><oa:textarea
										column='BZ' table='OA_FILE_SHOUWEN' title=''
										style='border: 0;width:98%; height: 76%;margin:auto;margin-top:4px; overflow: auto;display:block;' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=d2737d1b-81dd-442d-8922-66489a9ac392 class=gs_w data-col="1"
									data-row="40" data-sizex="3" data-sizey="2"><oa:span
										style='font-size: 18px; color: black; padding-left: 30%; line-height: 60px;'
										column='null' table='' value='附件' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=b106bfcf-f68a-458d-a620-34d9d769a30c class=gs_w data-col="4"
									data-row="40" data-sizex="7" data-sizey="2"><input
									type='hidden' id='field_drag_in_attach'
									value='OA_FILE_SHOUWEN__T_FJ_ID' />
								<oa:affixbut butName='请选择文件' column='T_FJ_ID'
										table='OA_FILE_SHOUWEN' title='' operType='111'
										initFjDJBHForArchive='<%=drag_in_attach%>' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=b054d8ea-0e93-40a1-8cf6-13be3b7fbad7 class=gs_w
									data-col="11" data-row="40" data-sizex="3" data-sizey="2"><oa:span
										style='font-size: 18px; color: black; padding-left: 11%; line-height: 60px;'
										column='null' table='' value='附件列表' />
								</LI>
								<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item"
									id=f5ce6f80-f4ed-4cb2-9245-99cc3930f671 class=gs_w
									data-col="14" data-row="40" data-sizex="17" data-sizey="2"><oa:affixshow
										title='' style='height:55px;line-height:55px; background-color: white;' 
										ulstyle='overflow-y: auto;overflow-x:hidden;height:55px;line-height:55px;margin:4px ;padding-left:10px;background:white;border:0px;max-height:55px;background:white;border:0;'  />
								</LI>
							</ul>
						</div>		
				</section>
			</article>
		</div>
				<div id="tabs-3">
			<oa:webtext column="T_ZW_ID" table="OA_FILE_SHOUWEN" defautValue="<%=drag_in_webtext%>"/>
			<input type='hidden' id='field_drag_in_webtext' value="OA_FILE_SHOUWEN__T_ZW_ID"/>
		</div>	
		</div>	    		
<div style="height:50px">
</div>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</form>



<form id="form_print" style="display: none;">
	<table  align="center" border="0" bordercolor="#000000" width="100%" cellspacing="1" cellpadding="0"  style="margin-left: 15px;margin-right: 15px; display: inline;">
      <tr>
        <td style="padding-bottom:10px;">
       	<div align='center'><span style='font-size: 30px; color: #000000; line-height: 50px;width:100%;height:100%;display:block;text-align:center;font-weight:bold;letter-spacing:5px;'>公文处理笺</span></div>	
        <table width="100%" border="0" align="center" cellpadding="5px" cellspacing="1" class="f_main" 
            style="font-size:12px;font-family: 宋体;background: #000000;line-height:30px; ">
	          <tr>
		            <td  valign="top" style="background:#ffffff; width:10%;text-align: center;" >
		  				<span style="font-size: 16px; color: black;line-height: 30px;">文件名称</span>
		            </td>
		             <td  valign="top" style="background:#ffffff;width:90%;text-align: left;" colspan="9" >
		  				<span style="font-size: 16px; color: black;line-height: 30px;text-align: left;" id="print_wjmc"></span>
		            </td>
	          </tr>
             <tr>
	             <td  valign="top" style="background:#ffffff;text-align: center;" >
	  				<span style="font-size: 16px;color: black;line-height: 30px;">来文单位</span>
	             </td>
	             <td  valign="top" style="background:#ffffff;text-align: left;" colspan="5">
	  				<span style="width: 90%;border: 0px;line-height:30px;color: black; height:30px;font-size: 16px;" id="print_lwdw"></span>
	            </td>
	            <td  valign="top" style="background:#ffffff;text-align: center;" >
	  				<span style="width: 90%;border: 0px;line-height:30px;color: black; height:30px;font-size: 16px;">快慢等级</span>
	            </td>
	             <td  valign="top" style="background:#ffffff;text-align: left;" colspan="3">
	  				<span style="width: 90%;border: 0px;line-height:30px;color: black; height:30px;font-size: 16px;" id="print_kmdj"></span>
	            </td>
             </tr>
             <tr>
	             <td  valign="top" style="background:#ffffff;text-align: center;" >
	  				<span style="font-size: 16px; color: black;line-height: 30px;">原文号</span>
	             </td>
	             <td  valign="top" style="background:#ffffff;width: 5%;">
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;font-size: 16px;color: black;" id="print_ywh"></span>
	            </td>
	            <td  valign="top" style="background:#ffffff;width: 5%;text-align: center;" >
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;font-size: 16px;color: black;">份数</span>
	            </td>
	             <td  valign="top" style="background:#ffffff;width: 5%">
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;font-size: 16px;color: black;" id="print_fs"></span>
	            </td>
	            <td  valign="top" style="background:#ffffff;width: 10%;text-align: center;" >
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;font-size: 16px;color: black;">收到日期</span>
	            </td>
	             <td  valign="top" style="background:#ffffff;width: 25%">
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;font-size: 16px;color: black;" id="print_sdrq"></span>
	            </td>
	            <td  valign="top" style="background:#ffffff;width: 10%;text-align: center;" >
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;font-size: 16px;color: black;">编号</span>
	            </td>
	             <td  valign="top" style="background:#ffffff;width: 8%">
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;font-size: 16px;color: black;" id="print_bh"></span>
	            </td>
	             <td  valign="top" style="background:#ffffff;width: 10%;text-align: center;" >
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;font-size: 16px;color: black;">入卷号</span>
	            </td>
	             <td  valign="top" style="background:#ffffff;width: 8%">
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;font-size: 16px;color: black;" id="print_rjh"></span>
	            </td>
             </tr>
             <tr>
	             <td  valign="top" style="background:#ffffff;text-align: center;" height="150px">
	  				<span style="font-size: 16px; color: black;line-height: 30px;">拟<br>办<br>意<br>见</span>
	             </td>
	             <td  valign="top" style="background:#ffffff;text-align: left;" colspan="9">
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;color: black;font-size: 16px;margin-top:18px;" id="print_nbyj"></span>
	            </td>
             </tr>
             <tr>
	             <td  valign="top" style="background:#ffffff;text-align: center;" height="200px">
	  				<span style="font-size: 16px; color: black;line-height: 30px;">批<br>阅<br>人<br>意<br>见</span>
	             </td>
	             <td  valign="top" style="background:#ffffff;text-align: left;" colspan="9">
	  				<span style="width: 90%;border: 0px;line-height:30px;color: black; height:30px;font-size: 16px;margin-top:18px;" id="print_pyryj"></span>
	            </td>
             </tr>
             <tr>
	             <td  valign="top" style="background:#ffffff;text-align: center;" height="200px">
	  				<span style="font-size: 16px; color: black;line-height: 30px;">传阅<br>人签<br>名或<br>意见</span>
	             </td>
	             <td  valign="top" style="background:#ffffff;text-align: left;" colspan="9">
	  				<span style="width: 90%;border: 0px;line-height:30px; color: black;height:30px;font-size: 16px;margin-top:18px;" id="print_cyrqmhyj"></span>
	            </td>
             </tr>
              <tr>
	             <td  valign="top" style="background:#ffffff;text-align: center;" height="200px">
	  				<span style="font-size: 16px;color: black;line-height: 30px;">主办<br>单位<br>执行<br>意见</span>
	             </td>
	             <td  valign="top" style="background:#ffffff;text-align: left;" colspan="9">
	  				<span style="width: 90%;border: 0px;line-height:30px;color: black; height:30px;font-size: 16px;margin-top:18px;" id="print_zbdwzxyj"></span>
	            </td>
             </tr>
            <tr>
	             <td  valign="top" style="background:#ffffff;text-align: center;" >
	  				<span style="font-size: 16px; color: black;line-height: 60px;">备注</span>
	             </td>
	             <td  valign="top" style="background:#ffffff;text-align: left;" colspan="9">
	  				<span style="width: 90%;border: 0px;line-height:60px;color: black; height:60px;font-size: 16px;" id="print_bz"></span>
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
	jQuery("#print_wjmc").text(jQuery("#OA_FILE_SHOUWEN__WJMC").val());//文件名称
	jQuery("#print_lwdw").text(jQuery("#OA_FILE_SHOUWEN__LWDW").val());//来文单位
	jQuery("#print_kmdj").text(jQuery("#OA_FILE_SHOUWEN__KMDJ").val());//快慢等级
	jQuery("#print_ywh").text(jQuery("#OA_FILE_SHOUWEN__YWH").val());//原文号
	jQuery("#print_fs").text(jQuery("#OA_FILE_SHOUWEN__FS").val());//份数
	jQuery("#print_sdrq").text(jQuery("#dis_OA_FILE_SHOUWEN__SDRQ").val());//收到日期
	jQuery("#print_bh").text(jQuery("#OA_FILE_SHOUWEN__BH").val());//编号 
	jQuery("#print_rjh").text(jQuery("#OA_FILE_SHOUWEN__RJH").val());//入卷号
	
	jQuery("#print_nbyj").html(jQuery("#OA_FILE_SHOUWEN__NBYJ").val().replaceAll('\t','&nbsp;&nbsp;&nbsp;&nbsp;').replaceAll(' ','&nbsp;').replaceAll('\n','<br/>'));//拟办意见 
	jQuery("#print_pyryj").html(jQuery("#OA_FILE_SHOUWEN__PYRYJ").val().replaceAll('\t','&nbsp;&nbsp;&nbsp;&nbsp;').replaceAll(' ','&nbsp;').replaceAll('\n','<br/>'));//批阅人意见 
	jQuery("#print_cyrqmhyj").html(jQuery("#OA_FILE_SHOUWEN__CYRQMHYJ").val().replaceAll('\t','&nbsp;&nbsp;&nbsp;&nbsp;').replaceAll(' ','&nbsp;').replaceAll('\n','<br/>'));//传阅人签名或意见 
	jQuery("#print_zbdwzxyj").html(jQuery("#OA_FILE_SHOUWEN__ZBDWZXYJ").val().replaceAll('\t','&nbsp;&nbsp;&nbsp;&nbsp;').replaceAll(' ','&nbsp;').replaceAll('\n','<br/>'));//主办单位执行意见 
	jQuery("#print_bz").text(jQuery("#OA_FILE_SHOUWEN__BZ").val());//备注 
	
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
