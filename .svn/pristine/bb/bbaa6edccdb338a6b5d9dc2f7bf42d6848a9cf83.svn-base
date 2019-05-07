<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.impl.FlowInstanceDataSaveDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.process.flowprocessing.dao.FlowInstanceDataSaveDao"%>
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

//环节ID
String action_defid = StringUtil.deNull(request.getParameter("action_defid"));

String curuser_id = accesscontroler.getUserID();
//修改传阅 的查看状态
FlowInstanceDataSaveDao flowinstancedatasavedao = new FlowInstanceDataSaveDaoImpl();
//传阅性ID
String circularize_id = StringUtil.deNull(request.getParameter("circularize_id"));
if(!StringUtil.isBlank(circularize_id)){
	flowinstancedatasavedao.updateFlowActInsState(circularize_id,curuser_id,"1");
}

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

//已办
String operType = StringUtil.deNull(request.getParameter("operType"));

%>

<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
	<script language="javascript" src="<%=path %>/ccapp/oa/resources/plug/Lodop/LodopFuncs.js"></script>
	<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
		<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="install_lodop.exe"></embed>
	</object> 
  <title>签呈稿纸</title>
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
<input 	type='hidden' id='attach_id_name' value='OA_FILE_QIANCHENG__T_FJ_ID' />
 
<input type='hidden' id='field_drag_in_title' value='OA_FILE_QIANCHENG__QC_CONTENT' />

<div id="tabs1" style="width:100%;border: 0px;">
		<table width="100%" border="0" cellspacing="1" cellpadding="0" style="display: inline;">
			<tr style="height:60px">
				<td style="display: inline;"><oa:flowcommonstart flowType="1" />
				<div style="float:left;padding-right: 5px;padding-left:5px;display: none;" name="printBtn" id="printBtn16"><input class='but_y_01'  type="button" value="打印" onClick="prn1_preview_fawen()"/></div>
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
								<LI
									style="BACKGROUND-COLOR: white; WIDTH: 929px; DISPLAY: list-item; HEIGHT: 61px"
									id=0fbc42d8-3166-47ba-8bf0-3cd0dadac4cf class=gs_w data-col="1"
									data-row="1" data-sizex="30" data-sizey="2"><oa:span
										style='font-size: 30px; color: #000000; line-height: 74px;width:100%;height:100%;display:block;text-align:center;font-weight:bold;letter-spacing:5px;'
										column='null' table='' value='湖南省特种设备检验检测研究院' />
								</LI>
								<LI
									style="BACKGROUND-COLOR: white; MARGIN-TOP: -1.5px; WIDTH: 929px; DISPLAY: list-item; HEIGHT: 31px"
									id=6d1553e6-05f2-4c56-8ac0-88132b1ff1e8 class=gs_w data-col="1"
									data-row="3" data-sizex="30" data-sizey="1"><oa:span
										style='font-size: 24px; color: #000000; line-height: 30px;width:100%;height:100%;display:block;text-align:center;letter-spacing:20px;'
										column='null' table='' value='签呈' />
								</LI>
								<LI
									style="BACKGROUND-COLOR: white; MARGIN-TOP: -1.5px; WIDTH: 650px; DISPLAY: list-item; HEIGHT: 31px"
									id=3426d332-3b72-4d2f-8fb5-9bf28f2dcff2 class=gs_w data-col="1"
									data-row="4" data-sizex="21" data-sizey="1"><oa:span
										style='font-size: 20px; color: #ff0000; padding-left: 43%; line-height: 30px;'
										column='null' table='' value='' />
								</LI>
								<LI
									style="BACKGROUND-COLOR: white; MARGIN-TOP: -1.5px; WIDTH: 279px; DISPLAY: list-item; HEIGHT: 31px; MARGIN-LEFT: -1.5px; MARGIN-RIGHT: -1.5px"
									id=38b31c71-5a7f-4ca2-aefc-cabbab977840 class=gs_w
									data-col="22" data-row="4" data-sizex="9" data-sizey="1"><oa:date
										dateFmt='yyyy-MM-dd HH:mm:ss' column='QC_DATE'
										table='OA_FILE_QIANCHENG' title=''
										style='height:22px;line-height: 22px;float:right;width:180px;margin-top:3px;margin-right:30px;'
										other="class='Wdate'" />
								</LI>
								<LI
									style="POSITION: absolute; BACKGROUND-COLOR: white; WIDTH: 464px; DISPLAY: list-item; MARGIN-BOTTOM: -1.5px; HEIGHT: 31px"
									id=73ef1abd-46c2-4b1b-92bc-b6ee905e3116
									class="gs_w player-revert" data-col="1" data-row="5"
									data-sizex="15" data-sizey="1"><oa:span
										style='font-size: 18px; color: #000; padding-left: 3%; line-height: 30px;'
										column='null' table='' value='内容：' />
								</LI>
								<LI
									style="BACKGROUND-COLOR: white; WIDTH: 464px; DISPLAY: list-item; MARGIN-BOTTOM: -1.5px; HEIGHT: 31px"
									id=be1dccdf-12b3-4ab8-a5da-099e75926456 class=gs_w
									data-col="16" data-row="5" data-sizex="15" data-sizey="1"><oa:span
										style='font-size: 18px; color: #000; padding-left: 3%; line-height: 30px;'
										column='null' table='' value='领导批示：' />
								</LI>
								<LI
									style="WIDTH: 464px; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 433px"
									id=040aed4e-44e5-4195-a691-c00f72371c3b class=gs_w data-col="1"
									data-row="6" data-sizex="15" data-sizey="14"><oa:textarea
										column='QC_CONTENT' table='OA_FILE_QIANCHENG' title=''
										style='border: 0;width:93%; height: 95%;margin-left:2%; overflow: auto;' />
								</LI>
								<LI
									style="WIDTH: 464px; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 433px"
									id=f096d1af-66cc-4a07-92bc-27870f0ec417 class=gs_w
									data-col="16" data-row="6" data-sizex="15" data-sizey="14"><oa:view
										column='QC_VIEW' table='OA_FILE_QIANCHENG' title=''
										style='border: 0;width:93%; height: 92%;margin-left:2%; overflow: auto;'
										cntab='uuuu,tt' />
								</LI>
								<li
									style="WIDTH: 155px; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px; MARGIN-RIGHT: -1.5px"
									id="cb57f33c-4e93-4c23-9dfa-6b0980990446" class="gs_w"
									data-sizey="1" data-sizex="5" data-row="20" data-col="1"><oa:span
										style='font-size: 18px; color: #000; padding-left: 33%; line-height: 30px;'
										column='null' table='' value='主办单位：' />
								</li>
								<li
									style="WIDTH: 155px; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px; MARGIN-RIGHT: -1.5px"
									id="7ee1cc88-4ba8-4e17-b266-aa67a3fd3323" class="gs_w"
									data-sizey="1" data-sizex="5" data-row="20" data-col="6"><oa:input
										title='' type='text' column='QC_UNIT'
										table='OA_FILE_QIANCHENG'
										style='width: 90%;border: 0px;line-height:26px; height:26px;'
										value='<%=org_name%>' />
								</li>
								<li
									style="WIDTH: 155px; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px; MARGIN-RIGHT: -1.5px"
									id="c26c2d7e-f6e5-489b-8522-ec23bf62a196" class="gs_w"
									data-sizey="1" data-sizex="5" data-row="20" data-col="11"><oa:span
										style='font-size: 18px; color: #000; padding-left: 3%; line-height: 30px;'
										column='null' table='' value='主办单位负责人：' />
								</li>
								<li
									style="WIDTH: 155px; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px; MARGIN-RIGHT: -1.5px"
									id="0dd2b0dc-34ac-4e06-bc65-a5dba6cb21dd" class="gs_w"
									data-sizey="1" data-sizex="5" data-row="20" data-col="16"><oa:input
										title='' type='text' column='QC_UNITLEADER'
										table='OA_FILE_QIANCHENG'
										style='width: 90%;border: 0px;line-height:26px; height:26px;'
										value='<%=user_name%>' />
								</li>
								<li
									style="WIDTH: 154px; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px"
									id="0a6c2622-bd50-441d-9405-4e9eba933e2c" class="gs_w"
									data-sizey="1" data-sizex="5" data-row="20" data-col="21"><oa:span
										style='font-size: 18px; color: #000; padding-left: 33%; line-height: 30px;'
										column='null' table='' value='经办人：' />
								</li>
								<li
									style="WIDTH: 155px; DISPLAY: list-item; BACKGROUND: white; HEIGHT: 30px; MARGIN-LEFT: -1.5px; MARGIN-RIGHT: -1.5px"
									id="6854f97b-487f-4dad-ba48-29c50a6f9276" class="gs_w"
									data-sizey="1" data-sizex="5" data-row="20" data-col="26"><oa:input
										title='' type='text' column='QC_OPERATOR'
										table='OA_FILE_QIANCHENG'
										style='width: 90%;border: 0px;line-height:26px; height:26px;'
										value='<%=user_name%>' />
								</li>
								<li
									style="width: 155px; display: list-item; margin-right: -1.5px; background: white;"
									id="899efb10-3e6d-49ac-93c3-b6988da2cee9" class="gs_w"
									data-sizey="2" data-sizex="5" data-row="21" data-col="1"><oa:span
										style='font-size: 18px; color: #000; padding-left: 33%; line-height: 60px;letter-spacing:5px;'
										column='null' table='' value='附件' />
								</li>
								<li style="display: list-item; background: white;"
									id="2bcd09ea-29d8-427c-a5e3-ece789f552c9" class="gs_w"
									data-sizey="2" data-sizex="10" data-row="21" data-col="6"><input
									type='hidden' id='field_drag_in_attach'
									value='OA_FILE_QIANCHENG__T_FJ_ID' />
								<oa:affixbut butName='请选择文件' column='T_FJ_ID'
										table='OA_FILE_QIANCHENG' title='' operType='111'
										initFjDJBHForArchive='<%=drag_in_attach%>' />
								</li>
								<li
									style="width: 155px; display: list-item; margin-right: -1.5px; background: white;"
									id="ee6dcb52-ab92-48dd-9bc6-9334c5a9f3e3" class="gs_w"
									data-sizey="2" data-sizex="5" data-row="21" data-col="16"><oa:span
										style='font-size: 18px; color: #000; padding-left:20%; line-height: 60px;letter-spacing:5px;'
										column='null' table='' value='附件列表' />
								</li>
								<li style="display: list-item; background: white;"
									id="0ff47104-0123-48a4-9c58-ac1578a94dc4" class="gs_w"
									data-sizey="2" data-sizex="10" data-row="21" data-col="21"><oa:affixshow
										title='' />
								</li>
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

<form id="form_print" style="display: none;">
	<table  align="center" border="0" bordercolor="#000000" width="100%" cellspacing="1" cellpadding="0"  style="margin-left: 15px;margin-right: 15px; display: inline;">
      <tr>
        <td style="padding-bottom:10px;">
       	<div align='center'><span style='font-size: 30px; color: #000000; line-height: 50px;width:100%;height:100%;display:block;text-align:center;font-weight:bold;letter-spacing:5px;'>湖南省特种设备检验检测研究院 </br>签呈</span></div>	
        <div align="right"><span style='font-size: 18px; color: #000000; line-height: 30px;width:100%;height:100%;display:block;text-align:right;font-weight:bold;' id="print_qc_date">2015-05-12</span></div>	
        <table width="100%" border="0" align="center" cellpadding="5px" cellspacing="1" class="f_main" 
            style="font-size:12px;font-family: 宋体;background: #000000;line-height:30px; ">
	          <tr>
		            <td  valign="top" style="background:#ffffff; width:50%;text-align: left;" >
		  				<span style="font-family:黑体;font-size: 16px; color: black;line-height: 30px;text-align: left;">&nbsp;&nbsp;&nbsp;内容：</span>
		            </td>
		             <td  valign="top" style="background:#ffffff;width:50%;text-align: left;"  >
		  				<span style="font-family:黑体;font-size: 16px; color: black;line-height: 30px;text-align: left;">&nbsp;&nbsp;&nbsp;领导批示： </span>
		            </td>
	          </tr>
             <tr>
	             <td  valign="top" style="background:#ffffff" height="650px">
	  				<span style="font-family: 宋体;font-size: 16px; color: black;line-height: 30px;" id="print_conent"></span>
	             </td>
	             <td  valign="top" style="background:#ffffff" height="650px">
	  				<span style="width: 90%;border: 0px;line-height:30px; height:30px;font-size: 16px;margin-top:18px;" id="print_ldps"></span>
	            </td>
             </tr>
             <tr height="30px">
	             <td  valign="top" style="background:#ffffff;width: 100%;" colspan="2" >
	  				<table style="font-size:12px;font-family: 宋体;border: 0px;line-height:30px;width: 100%; ">
	  					<tr>
	  						<td valign="top" style="background:#ffffff; width:12%;text-align: left;"><span style="font-family:黑体;font-size: 16px; color: black;line-height: 30px;text-align: left;">主办单位：</span></td>
	  						<td valign="top" style="background:#ffffff; width:18%;text-align: left;"><span style="font-family:宋体;font-size: 16px; color: black;line-height: 30px;text-align: left;" id="print_zbdw"></span></td>
	  						<td valign="top" style="background:#ffffff; width:20%;text-align: left;"><span style="font-family:黑体;font-size: 16px; color: black;line-height: 30px;text-align: left;">主办单位负责人：</td>
	  						<td valign="top" style="background:#ffffff; width:15%;text-align: left;"><span style="font-family:宋体;font-size: 16px; color: black;line-height: 30px;text-align: left;" id="print_zbdwfzr">测试1</span></td>
	  						<td valign="top" style="background:#ffffff; width:10%;text-align: left;"><span style="font-family:黑体;font-size: 16px; color: black;line-height: 30px;text-align: left;">经办人：</span></td>
	  						<td valign="top" style="background:#ffffff; width:15%;text-align: left;"><span style="font-family:宋体;font-size: 16px; color: black;line-height: 30px;text-align: left;" id="print_jbr">测试1dd</span></td>
	  					</tr>
	  				</table>
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
	//仅仅在已办列表查看【签呈】流程的稿纸时显示【打印】按钮。
	if('<%=operType%>'=='yiban'){
		jQuery("#printBtn16").show();
	}
	
});

//封装打印数据
function fromPrintData(){
	jQuery("#print_qc_date").text(jQuery("#dis_OA_FILE_QIANCHENG__QC_DATE").val());//日期
	jQuery("#print_conent").html(jQuery("#OA_FILE_QIANCHENG__QC_CONTENT").val().replaceAll('\t','&nbsp;&nbsp;&nbsp;&nbsp;').replaceAll(' ','&nbsp;').replaceAll('\n','<br/>'));//内容
	jQuery("#print_ldps").html(jQuery("#OA_FILE_QIANCHENG__QC_VIEW").val().replaceAll('\t','&nbsp;&nbsp;&nbsp;&nbsp;').replaceAll(' ','&nbsp;').replaceAll('\n','<br/>'));//领导批示
	jQuery("#print_zbdw").html(jQuery("#OA_FILE_QIANCHENG__QC_UNIT").val());//主办单位
	jQuery("#print_zbdwfzr").text(jQuery("#OA_FILE_QIANCHENG__QC_UNITLEADER").val());//主办单位负责人
	jQuery("#print_jbr").text(jQuery("#OA_FILE_QIANCHENG__QC_OPERATOR").val());//经办人
	
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

//封装生成图片数据
function fromdata(){
	jQuery("#print_qc_date").text(jQuery("#dis_OA_FILE_QIANCHENG__QC_DATE").val());//日期
	jQuery("#print_conent").text(jQuery("#OA_FILE_QIANCHENG__QC_CONTENT").val().replaceAll('\t','&nbsp;&nbsp;&nbsp;&nbsp;').replaceAll(' ','&nbsp;').replaceAll('\n','<br/>'));//内容
	jQuery("#print_ldps").html(jQuery("#OA_FILE_QIANCHENG__QC_VIEW").val().replaceAll('\t','&nbsp;&nbsp;&nbsp;&nbsp;').replaceAll(' ','&nbsp;').replaceAll('\n','<br/>'));//领导批示
	jQuery("#print_zbdw").html(jQuery("#OA_FILE_QIANCHENG__QC_UNIT").val());//主办单位
	jQuery("#print_zbdwfzr").text(jQuery("#OA_FILE_QIANCHENG__QC_UNITLEADER").val());//主办单位负责人
	jQuery("#print_jbr").text(jQuery("#OA_FILE_QIANCHENG__QC_OPERATOR").val());//经办人
	
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

var LODOP; //声明为全局变量 

function prn1_preview_fawen() {	
	//打字份数赋值		
	CreateOneFormPage_fawen();	
	LODOP.PREVIEW();
};

function CreateOneFormPage_fawen(){
	LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));  
	LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_表单一");
	//LODOP.SET_PRINT_STYLE("FontSize",12);
	//LODOP.SET_PRINT_STYLE("FontName","宋体");
     //jQuery("#print_efficacy").text(jQuery("#send_verify").val());
	LODOP.SET_PRINT_STYLE("Bold",1);
	LODOP.ADD_PRINT_TEXT(50,231,260,39,"");
	LODOP.ADD_PRINT_HTM(60,25,700,980,fromPrintData());
};	
</script>
