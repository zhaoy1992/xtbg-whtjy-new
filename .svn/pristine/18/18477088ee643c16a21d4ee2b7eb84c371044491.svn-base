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
  <title>湖北特检院-信息化设备维修审批表</title>
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
					<LI class=gs_w id=2c5b7243-1182-494f-8032-9e3a4d95a0b1 style="MARGIN-BOTTOM: -1px; HEIGHT: 31px; BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="1" data-sizex="30" data-sizey="1"><oa:span style='font-size: 25px; color: #ff0000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '湖北特种设备检验检测研究院' /></LI>
<LI class=gs_w id=3dea2ffd-dbcd-477a-9dac-b399f2355dd1 style="HEIGHT: 30px; WIDTH: 929px; BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="2" data-sizex="30" data-sizey="1"><oa:span style='font-size: 25px; color: #ff0000; padding-left: 40%; line-height: 30px;' column='null'  table='' value= '信息设备维修审批单' /></LI>
<LI class=gs_w id=d2b172e4-6131-4a4f-9935-519f8c149b2d style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="3" data-sizex="7" data-sizey="2"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 35%; line-height: 50px;' column='null'  table='' value= '申请日期' /></LI>
<LI class=gs_w id=ebc3b5a5-b48d-4cf4-8040-5569c914417e style="HEIGHT: 61px; WIDTH: 712px; BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="3" data-sizex="23" data-sizey="2"><oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='XXSBWX_SQRQ' table='HBTJY_XXSBWXSPB' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/></LI>
<LI class=gs_w id=6a1a6c7f-3882-4836-9780-dca05d684763 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="5" data-sizex="7" data-sizey="2"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 43%; line-height: 50px;' column='null'  table='' value= '部门' /></LI>
<LI class=gs_w id=de3199f1-310d-4640-bff5-95feea0dd14b style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="5" data-sizex="8" data-sizey="2"><oa:input title='' type='text' column='XXSBWX_BM' table='HBTJY_XXSBWXSPB' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=org_name%>'/></LI>
<LI class=gs_w id=9daf3a2e-a3d5-451c-928c-7fecb8c43801 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="16" data-row="5" data-sizex="7" data-sizey="2"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 35%; line-height: 50px;' column='null'  table='' value= '申请人' /></LI>
<LI class=gs_w id=ace1524b-3114-486c-9a68-b8488b78d1f7 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="23" data-row="5" data-sizex="8" data-sizey="2"><oa:input title='' type='text' column='XXSBWX_SQR' table='HBTJY_XXSBWXSPB' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI class=gs_w id=d29135b9-a3ae-408d-acb9-9cebb2bdcee3 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="7" data-sizex="7" data-sizey="2"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 10%; line-height: 50px;' column='null'  table='' value= '设备名称及产品编号' /></LI>
<LI class=gs_w id=f1bd308f-362f-48be-8091-e4f330fc6955 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="7" data-sizex="8" data-sizey="2"><oa:input title='' type='text' column='XXSBWX_SBBHCPMC' table='HBTJY_XXSBWXSPB' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI class=gs_w id=d9b48474-f2fb-4129-9c31-10225f1e0a9c style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="16" data-row="7" data-sizex="7" data-sizey="2"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 35%; line-height: 50px;' column='null'  table='' value= '经办人' /></LI>
<LI class=gs_w id=48b2bf49-c8e5-48d4-ac6d-037aa332a46a style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="23" data-row="7" data-sizex="8" data-sizey="2"><oa:input title='' type='text' column='XXSBWX_JBR' table='HBTJY_XXSBWXSPB' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI class=gs_w id=3a9f1606-30a8-490e-a8f2-3fd3325a14ee style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="9" data-sizex="23" data-sizey="2"><oa:textarea column='XXSBWX_GZLB' table='HBTJY_XXSBWXSPB' title ='' style='border: 1;width:80%; height: 50px; overflow: auto;'  /></LI>
<LI class=gs_w id=3e3fadea-7dd0-4ef7-bbac-dab17209551b style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="11" data-sizex="23" data-sizey="2"><oa:view column='XXFB_HQBYJ' table='HBTJY_XXSBWXSPB' title ='' style='border:0;width:70%; height: 50px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI class=gs_w id=6a4ee2cc-cdab-4898-b03a-a8baa4e05abb style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="9" data-sizex="7" data-sizey="2"><oa:span style='font-size: 18px; color: #ff0000; padding-left: 3%; line-height: 30px;' column='null'  table='' value= '故障类别:硬件故障/软件故障' /></LI>
<LI class=gs_w id=61b3b310-1685-49af-aeae-7feb2201629f style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="13" data-sizex="23" data-sizey="2"><oa:view column='XXSBWX_ZLBYJ' table='HBTJY_XXSBWXSPB' title ='' style='border:0;width:70%; height: 50px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI class=gs_w id=6e289d35-6077-4841-9804-d672c030db01 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="11" data-sizex="7" data-sizey="2"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 13%; line-height: 50px;' column='null'  table='' value= '后勤资产部意见' /></LI>
<LI class=gs_w id=d2acd97c-9870-4b59-85ea-bc8f7e4dfe73 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="15" data-sizex="23" data-sizey="2"><oa:view column='XXSBWX_JHCWBYJ' table='HBTJY_XXSBWXSPB' title ='' style='border:0;width:70%; height: 50px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI class=gs_w id=7b84d123-2432-4d94-a2e2-c9fbfdad6d64 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="13" data-sizex="7" data-sizey="2"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 13%; line-height: 50px;' column='null'  table='' value= '质量技术部意见' /></LI>
<LI class=gs_w id=f742fb0c-d843-40b5-b1c2-495e2d3f0163 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="17" data-sizex="23" data-sizey="2"><oa:view column='XXSBWX_FGLDSH' table='HBTJY_XXSBWXSPB' title ='' style='border:0;width:70%; height: 50px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI class=gs_w id=471caead-9722-4199-aa80-d75cf196fad2 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="15" data-sizex="7" data-sizey="2"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 13%; line-height: 50px;' column='null'  table='' value= '计划财务部意见' /></LI>
<LI class=gs_w id=24246713-c88c-4be0-8e26-47cbc79a9f1e style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="19" data-sizex="23" data-sizey="2"><oa:view column='XXSBWX_YZSPYJ' table='HBTJY_XXSBWXSPB' title ='' style='border:0;width:70%; height: 50px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI class=gs_w id=930fb934-162a-4150-9541-7aea80ed329f style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="17" data-sizex="7" data-sizey="2"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 13%; line-height: 50px;' column='null'  table='' value= '分管领导审批意见' /></LI>
<LI class=gs_w id=5b054463-25d1-4285-9725-ca568a27846a style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="21" data-sizex="23" data-sizey="2"><oa:view column='XXSBWX_JBRQR' table='HBTJY_XXSBWXSPB' title ='' style='border:0;width:70%; height: 50px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI class=gs_w id=81a5ab6f-603b-4846-b5e1-4244b0d7d6cf style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="19" data-sizex="7" data-sizey="2"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 25%; line-height: 50px;' column='null'  table='' value= '院长审批意见' /></LI>
<LI class=gs_w id=9e3cc95e-8c63-49d4-bd03-8456f9783170 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="23" data-sizex="23" data-sizey="2"><oa:textarea column='XXSBWX_BZ' table='HBTJY_XXSBWXSPB' title ='' style='border: 1;width:80%; height: 50px; overflow: auto;'  /></LI>
<LI class=gs_w id=1ba74036-6c9b-4fb1-86f1-9a7b360aa07f style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="21" data-sizex="7" data-sizey="2"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 28%; line-height: 50px;' column='null'  table='' value= '经办人确认' /></LI>
<LI class=gs_w id=a8cb8e10-d86f-4531-8842-d5414b4f1a51 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="23" data-sizex="7" data-sizey="2"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 43%; line-height: 50px;' column='null'  table='' value= '备注' /></LI>
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
