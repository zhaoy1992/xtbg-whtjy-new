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
  <title>办公用品申领表</title>
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
					<li id="371fcf73-11cc-4710-8b0f-177d360758dd" data-col="1" data-row="1" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;"><oa:span style='font-size: 10px; color: #ff0000; padding-left: 90px; line-height: 30px;' column='null'  table='' value= '领用部室：' /></li><li id="d1aeb225-03f6-48c8-afbd-79c6e4112540" data-col="6" data-row="1" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;"><oa:input title='' type='text' column='T_APPREGYHP_ORG_NAME' table='TA_OA_OSAPPREGYHP' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></li><li id="037824ce-3476-4be1-938f-b0f51651951e" data-col="16" data-row="1" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;"><oa:span style='font-size: 10px; color: #ff0000; padding-left:100px; line-height: 30px;' column='null'  table='' value= '申领人：' /></li><li id="f0ad274c-7476-4f4a-8b4f-c19c4c985b81" data-col="21" data-row="1" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;"><oa:input title='' type='text' column='T_APPREGYHP_USER_NAME' table='TA_OA_OSAPPREGYHP' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></li><li id="304a3295-b98f-4997-be33-b400b73630a8" data-col="1" data-row="2" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;"><oa:span style='font-size: 10px; color: #ff0000; padding-left: 90px; line-height: 30px;' column='null'  table='' value= '填写时间：' /></li><li id="1a88a920-8f73-485b-b21c-55f7c621dc33" data-col="6" data-row="2" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;"><oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='T_APPREGYHP_DATE' table='TA_OA_OSAPPREGYHP' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/></li><li id="5684f0f7-1901-4ab9-b2f1-278b16e7ee80" data-col="16" data-row="2" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;"><oa:span style='font-size: 10px; color: #ff0000; padding-left: 90px; line-height: 30px;' column='null'  table='' value= '采购清单：' /></li><li id="ab52977d-6b66-411a-b480-1bed944d1a74" data-col="21" data-row="2" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;">oa_ab52977d-6b66-411a-b480-1bed944d1a74</li><li id="e74ba600-265c-4cb4-9a6e-b505354ee9c0" data-col="1" data-row="3" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;"><oa:span style='font-size: 10px; color: #ff0000; padding-left: 90px; line-height: 30px;' column='null'  table='' value= '申领标题：' /></li><li id="bcbb4812-97dc-474f-9c64-4a524bd4b7d0" data-col="6" data-row="3" data-sizex="25" data-sizey="1" class="gs_w" style="display: list-item; background: white;"><oa:input title='' type='text' column='T_APPREGYHP_TITLE' table='TA_OA_OSAPPREGYHP' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></li><li id="a0692f30-5c96-4db5-988d-4b66ee9246b2" data-col="1" data-row="4" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;"><oa:span style='font-size:10px; color: #ff0000; padding-left: 55px; line-height: 30px;' column='null'  table='' value= '部门负责人意见：' /></li><li id="1222f082-c21c-48d7-b92a-c281149c2df3" data-col="6" data-row="4" data-sizex="25" data-sizey="1" class="gs_w" style="display: list-item; background: white;"><oa:view column='T_APPREGYHP_BMFZRYJ' table='TA_OA_OSAPPREGYHP' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' /></li><li id="48f19207-61e5-4322-abe8-64fb79b00e95" data-col="1" data-row="5" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;"><oa:span style='font-size: 10px; color: #ff0000; padding-left:45px; line-height: 30px;' column='null'  table='' value= '后勤部负责人意见：' /></li><li id="b428e546-eda9-4699-8405-4411aac18099" data-col="6" data-row="5" data-sizex="25" data-sizey="1" class="gs_w" style="display: list-item; background: white;"><oa:view column='T_APPREGYHP_HQBFZRYJ' table='TA_OA_OSAPPREGYHP' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' /></li><li id="a89176f4-1845-46bc-80d8-ba0e2cd10646" data-col="1" data-row="6" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;"><oa:span style='font-size: 10px; color: #ff0000; padding-left:55px; line-height: 30px;' column='null'  table='' value= '仓库管理员办结：' /></li><li id="b019152e-12e5-475b-a324-54be3fe7ca81" data-col="6" data-row="6" data-sizex="25" data-sizey="1" class="gs_w" style="display: list-item; background: white;"> <oa:select column='T_APPREGYHP_CKGLY' table='TA_OA_OSAPPREGYHP' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title =''><oa:option optionName='同意发放' optionValue='0' /><oa:option optionName='不同意发放' optionValue='1' /></oa:select></li>
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
