<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="archiveformerrorhandler.jsp"%>
<%@taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%@page import="com.chinacreator.security.AccessControl"%>											  
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>                                   
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>                        
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>                                            
<%@page import="java.util.Map"%>                                                                       
<%@page import="java.util.HashMap"%>                                                                   
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>                                                                
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>                                                                
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>                                                                
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
String ins_id = request.getParameter("ins_id");

String action_defid = StringUtil.deNull(request.getParameter("action_defid"));
%>

<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
  <title>湖北特检-信息发布审批表</title>
  <script>
  var ins_id = "<%=ins_id%>";
  var action_defid = "<%=action_defid%>";
  jQuery(function(){ //DOM Ready
		if(IsSpace(ins_id)){
			jQuery("#HBTJ_XXFBSPD__XXFB_SQSJ").val("<%=time%>");
		}
		//办结环节
		if(action_defid == "HBTJYXXFBLC_wp1_act7"){
			jQuery("#HBTJ_XXFBSPD__CYRQ").val("<%=time%>");
		}
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
	jQuery("#_fileshow").attr('style','border-bottom: 0px; position: relative; border-left: 0px; line-height: 29px; overflow-x: hidden; overflow-y: auto; margin: 1px; padding-left: 10px; background: white; height: 59px; max-height: 79px; border-top: 0px; border-right: 0px;');
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
						<LI class=gs_w id=85afa081-4b69-4265-a3c8-43726abc1b55 style="MARGIN-BOTTOM: -1px; HEIGHT: 31px; BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="1" data-sizex="30" data-sizey="1">
							<oa:span style='font-size: 25px; color: #ff0000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '湖北特种设备检验检测研究院' />
						</LI>
						<LI class=gs_w id=85c64263-32c2-4b3d-ae17-48cd3e91f2cf style="HEIGHT: 30px; BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item; WIDTH: 929px" data-col="1" data-row="2" data-sizex="30" data-sizey="1">
							<oa:span style='font-size: 25px; color: #ff0000; padding-left: 40%; line-height: 30px;' column='null'  table='' value= '新闻信息发布审批单' />
						</LI>
						<LI class=gs_w id=7fc50b5d-65ca-4423-808d-002050189166 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="3" data-sizex="7" data-sizey="1">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 43%; line-height: 30px;' column='null'  table='' value= '编号' />
						</LI>
						<LI class=gs_w id=110e8fea-29cb-475c-8420-edc505e03f0e style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="3" data-sizex="8" data-sizey="1">
							<oa:input title='' type='text' column='XXFB_BH1' table='HBTJ_XXFBSPD' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/>
						</LI>
						<LI class=gs_w id=32f4afa6-7e39-4ef5-a3cb-eadb8ea7bdd0 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="16" data-row="3" data-sizex="7" data-sizey="1">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '申请日期' />
						</LI>
						<LI class=gs_w id=037a72d5-7bc9-49e7-afee-ef9194b5c102 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="23" data-row="3" data-sizex="8" data-sizey="1">
							<oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='XXFB_SQSJ' table='HBTJ_XXFBSPD' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/>
						</LI>
						<LI class=gs_w id=9555c883-5753-4b35-8949-c2a740111bad style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="4" data-sizex="7" data-sizey="2">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 30%; line-height: 50px;' column='null'  table='' value= '投稿单位/部门' />
						</LI>
						<LI class=gs_w id=093d3f3c-71bf-4fad-bea3-45e8320ad6d1 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="4" data-sizex="8" data-sizey="2">
							<oa:input title='' type='text' column='XXFB_NGDW' table='HBTJ_XXFBSPD' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=org_name%>'/>
						</LI>
						<LI class=gs_w id=5b567116-7ea0-4784-a511-b6bc42a825a6 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="16" data-row="4" data-sizex="7" data-sizey="2">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 40%; line-height: 50px;' column='null'  table='' value= '拟稿人' />
						</LI>
						<LI class=gs_w id=5b772469-7f9f-45e4-a323-65fb51e0a13c style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="23" data-row="4" data-sizex="8" data-sizey="2">
							<oa:input title='' type='text' column='XXFB_NGR' table='HBTJ_XXFBSPD' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/>
						</LI>
						<LI class=gs_w id=fb0cb07c-c506-489c-91bf-18638dcddb5e style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="6" data-sizex="7" data-sizey="2">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 36%; line-height: 50px;' column='null'  table='' value= '稿件标题' />
						</LI>
						<LI class=gs_w id=439ee942-7105-4d1b-85d2-5d0b713a2c3a style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="6" data-sizex="23" data-sizey="2">
							<oa:textarea column='XXFB_GJBT' table='HBTJ_XXFBSPD' title ='' style='border: 1;width:80%; height: 30px; overflow: auto;'  />
						</LI>
						<LI class=gs_w id=240621b3-9c0e-45f4-b88e-8be78a0e6630 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="8" data-sizex="7" data-sizey="2">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 40%; line-height: 50px;' column='null'  table='' value= '拟发布' />
						</LI>
						<LI class=gs_w id=b3db90c9-063e-4cd0-bc99-9355017805db style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="8" data-sizex="23" data-sizey="2">
							<oa:select column='XXFB_YMHWZ' table='HBTJ_XXFBSPD' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title =''>
								<oa:option optionName='院门户网站' optionValue='value1' />
								<oa:option optionName='省局门户网站' optionValue='value2' />
								<oa:option optionName='其他网站' optionValue='value3' />
								<oa:option optionName='内部信息发布' optionValue='value4' />
								<oa:option optionName='院微博发布' optionValue='value5' />
							</oa:select>
						</LI>
						<LI class=gs_w id=aa4326d6-9919-43dc-9bff-641ca4d9c80a style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="10" data-sizex="7" data-sizey="2">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 10%; line-height:50px;' column='null'  table='' value= '分院/部门核稿人意见' />
						</LI>
						<LI class=gs_w id=797fae4b-5dc8-46e9-ba4e-7e3852420c9e style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="10" data-sizex="23" data-sizey="2">
							<oa:view column='XXFB_FYHGRYJ' table='HBTJ_XXFBSPD' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' />
						</LI>
						<LI class=gs_w id=4d32f281-80cc-4b01-a580-3594f57f6a63 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="12" data-sizex="7" data-sizey="2">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 13%; line-height: 50px;' column='null'  table='' value= '院办公室核稿意见' />
						</LI>
						<LI class=gs_w id=456aa7e7-d6f1-4a32-8fc6-a598f485a148 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="12" data-sizex="23" data-sizey="2">
							<oa:view column='XXFB_YBGSHGYJ' table='HBTJ_XXFBSPD' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' />
						</LI>
						<LI class=gs_w id=d9bef26f-ce7b-4ab9-ad41-f0f02efb7392 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="14" data-sizex="7" data-sizey="2">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 18%; line-height: 50px;' column='null'  table='' value= '分管院领导审批' />
						</LI>
						<LI class=gs_w id=c6d97298-208c-4140-b48c-825954298e96 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="14" data-sizex="23" data-sizey="2">
							<oa:view column='XXGB_YLDSPYJ' table='HBTJ_XXFBSPD' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' />
						</LI>
						<LI class=gs_w id=9efe96a3-3203-4922-a76a-ff6207235608 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="16" data-sizex="7" data-sizey="2">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 23%; line-height: 50px;' column='null'  table='' value= '经办人确认' />
						</LI>
						<LI class=gs_w id=29bf3af5-5e1e-4be9-bf2f-5263e7c452c7 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="16" data-sizex="23" data-sizey="2">
							<oa:view column='XXFB_JBRQR' table='HBTJ_XXFBSPD' title ='' style='border:0;width:90%; height: 30px; overflow: auto;' cntab='uuuu,tt' />
						</LI>
						<LI class=gs_w id=9fd42177-828f-46dc-acc4-9a20d62cefb7 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="18" data-sizex="7" data-sizey="2">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 40%; line-height: 50px;' column='null'  table='' value= '备注' />
						</LI>
						<LI class=gs_w id=95a1369a-e069-4c81-9f0b-81b454294850 style="BACKGROUND: white; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="18" data-sizex="23" data-sizey="2">
							<oa:textarea column='XXFB_BZ' table='HBTJ_XXFBSPD' title ='' style='border: 1;width:80%; height: 30px; overflow: auto;'  />
						</LI>
						<LI class=gs_w id=2dda34bf-5eb8-456b-8e3b-a4bb207dffec style="MARGIN-BOTTOM: -1px; HEIGHT: 31px; BACKGROUND: white; POSITION: absolute; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="20" data-sizex="23" data-sizey="1">
							<input type='hidden' id='field_drag_in_attach' value='HBTJ_XXFBSPD__T_FJ_ID'/>
							<oa:affixbut butName='请选择文件' column='T_FJ_ID' table='HBTJ_XXFBSPD'  title ='' operType='111' initFjDJBHForArchive ='<%=drag_in_attach%>' />
						</LI>
						<LI class=gs_w id=b14f48a8-edfc-4c48-9b36-0e405b664527 style="BACKGROUND: white; POSITION: absolute; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="1" data-row="23" data-sizex="7" data-sizey="2">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 35%; line-height: 30px;' column='null'  table='' value= '是否采用' />
						</LI>
						<LI class=gs_w id=a55c5f32-dbd2-459f-ba73-92e3b965b1ff style="BACKGROUND: white; POSITION: absolute; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="8" data-row="23" data-sizex="8" data-sizey="2"> 
							<oa:select column='SFCY' table='HBTJ_XXFBSPD' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title =''>
								<oa:option optionName=' ' optionValue='value2' />
								<oa:option optionName='是' optionValue='value2' />
								<oa:option optionName='否' optionValue='value3' />
							</oa:select>
						</LI>
						<LI class=gs_w id=cb3eb458-3394-4743-9440-1a68a869c7c4 style="BACKGROUND: white; POSITION: absolute; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="16" data-row="23" data-sizex="7" data-sizey="2">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 33%; line-height: 30px;' column='null'  table='' value= '采用日期' />
						</LI>
						<LI class=gs_w id=f72132f4-577d-49cd-a00a-6def7a26f904 style="BACKGROUND: white; POSITION: absolute; ZOOM: 1; FILTER: none; DISPLAY: list-item" data-col="23" data-row="23" data-sizex="8" data-sizey="2">
							<oa:date dateFmt='yyyy-MM-dd HH:mm:ss' column='CYRQ' table='HBTJ_XXFBSPD' title ='采用日期' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/>
						</LI>
						<LI class=gs_w id=aef85551-849b-44f3-a31e-08b05ffbcf45 style="BACKGROUND: white; POSITION: absolute; ZOOM: 1; FILTER: ; DISPLAY: list-item" data-col="1" data-row="20" data-sizex="7" data-sizey="3">
							<oa:span style='font-size: 20px; color: #ff0000; padding-left: 40%; line-height: 80px;' column='null'  table='' value= '附件' />
						</LI>
						<LI class=gs_w id=c214e2bf-4160-4896-984b-97a8387d27f3 style="BACKGROUND: white; POSITION: absolute; ZOOM: 1; FILTER: ; DISPLAY: list-item" data-col="8" data-row="21" data-sizex="23" data-sizey="2">
							<oa:affixshow  title =''/>
						</LI>
					</ul>
			    </div>		
				</section>
			</article>
		</div>
		<div id="tabs-3">
			<oa:webtext column="T_ZW_ID" table="HBTJ_XXFBSPD" defautValue="<%=drag_in_webtext%>"/>
			<input type='hidden' id='field_drag_in_webtext' value="HBTJ_XXFBSPD__T_ZW_ID"/>
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
