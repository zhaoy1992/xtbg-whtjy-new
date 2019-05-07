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

String busi_id = request.getParameter("busi_id")!=null?request.getParameter("busi_id"):"";
%>

<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
  <title>事业中心油卡领用申请表</title>
  <script>jQuery(function(){ //DOM Ready
	initGridster();
	getCarList();
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
   
var path = "<%=path %>";
function getCarList(){
	var car_id = "<%=busi_id %>";
	jQuery.ajax({
		url:path+"/ccapp/oa/archive/whtjycheliangguanlido.jsp",
		data:{"method":"getCarList","car_id":car_id,"tableName":"TA_OA_WHTJY_YOUKA"},
		type:'post',dataType:'json',
		contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		success:function(data){
			if(data){//成功
				jQuery("#TA_OA_WHTJY_YOUKA__CAR_INFO").append(data.result);
			}
		}
	});
}

//点击完成
var afterActionSuccessFn=function(){
	getParentWindow('<%=windowsId%>').location.href = "<%=path%>/ccapp/xtbg/tjy/processing/mainhandlist.jsp";
	removeAlertWindows('<%=windowsId%>',true);
	
};
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
<oa:input type='hidden' column='ORG_ID' table='TA_OA_WHTJY_YOUKA' value='<%=org_id%>' />
<oa:input type='hidden' column='CREATER_USER_ID' table='TA_OA_WHTJY_YOUKA' value='<%=user_id%>' />
<oa:input type='hidden' column='CREATER_USER_NAME' table='TA_OA_WHTJY_YOUKA' value='<%=user_name%>' />
<oa:input type='hidden' column='CREATER_UNIT_ID' table='TA_OA_WHTJY_YOUKA' value='<%=unit_id%>' />
<oa:input type='hidden' column='CREATER_UNIT_NAME' table='TA_OA_WHTJY_YOUKA' value='<%=unit_name%>' />
<oa:input type='hidden' column='CREATER_DATE' table='TA_OA_WHTJY_YOUKA' value='<%=time%>' />
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
						<li id="771ce2d1-453d-455a-900b-f7281473dc89" data-col="1" data-row="1" data-sizex="30" data-sizey="2" class="gs_w" style="display: list-item; background: white; height: 62px; margin-bottom: -1.5px;">
							<oa:span style='font-size: 35px; color: #000000; padding-left: 23%; line-height: 40px;' column='null'  table='' value= '湖北特检设备检验检测研究院' />
						</li>
						<li id="bb02d705-ea51-409b-9b9d-588f2f4b76de" data-col="1" data-row="3" data-sizex="30" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 40%; line-height: 30px;' column='null'  table='' value= '油卡领用申请审批单' />
						</li>
						<li id="1bf10185-4998-4484-b0b6-9182f13181e1" data-col="1" data-row="4" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '申请人' />
						</li>
						<li id="7c404cb8-96a5-4c46-8b66-d864bf2e8b2e" data-col="6" data-row="4" data-sizex="25" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:input title='' type='text' column='APPLICATION' table='TA_OA_WHTJY_YOUKA' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name %>'/>
						</li>
						<li id="d5d93793-ece6-424e-bf30-c107a8521534" data-col="1" data-row="5" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '申请科室' />
						</li>
						<li id="4f25652b-627f-43b1-a028-d5008aa55f6e" data-col="6" data-row="5" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:input title='' type='text' column='ORG_NAME' table='TA_OA_WHTJY_YOUKA' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=org_name %>'/>
						</li>
						<li id="58ba9afd-2846-4330-becc-a030faa9f9ea" data-col="16" data-row="5" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '申请时间' />
						</li>
						<li id="12f81c67-1a03-4ed6-a6c9-f2c6ea0e5a7d" data-col="21" data-row="5" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:date defaultValue='sysDate' dateFmt='yyyy-MM-dd HH:mm:ss' column='APPLICATION_DATE' table='TA_OA_WHTJY_YOUKA' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/>
						</li>
						<li id="63dc820c-acd3-4c8b-9442-2adc8927f5c4" data-col="1" data-row="6" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '申请事由' />
						</li>
						<li id="965a9bb7-29db-4372-9828-f6ef9c8241b8" data-col="6" data-row="6" data-sizex="25" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:input title='' type='text' column='SHENQINGSHIYOU' table='TA_OA_WHTJY_YOUKA' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/>
						</li>
						<li id="259a4481-b20a-4c11-81fa-71a8cd90ea4c" data-col="1" data-row="7" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '车牌号' />
						</li>
						<li id="d8e2d189-a6e6-48d4-b2b5-5f00f837058d" data-col="6" data-row="7" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;"> 
							<oa:select column='CAR_INFO' table='TA_OA_WHTJY_YOUKA' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title =''>
							</oa:select>
						</li>
						<li id="2f886fcf-2977-48d3-8564-618ec3876618" data-col="16" data-row="7" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '充值金额' />
						</li>
						<li id="7a0daf59-8f49-4c91-8134-bc647840d77b" data-col="21" data-row="7" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:input title='' type='text' column='MONEY' table='TA_OA_WHTJY_YOUKA' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/>
						</li>
						<li id="5def4cce-ce5f-4dbb-8b89-552128d7d5f7" data-col="1" data-row="8" data-sizex="5" data-sizey="3" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '部门负责人意见' />
						</li>
						<li id="793ce540-8fe7-4623-bb80-b891365dfe90" data-col="6" data-row="8" data-sizex="25" data-sizey="3" class="gs_w" style="display: list-item; background: white;">
							<oa:view column='VIEW_BMFZR' table='TA_OA_WHTJY_YOUKA' title ='' style='border:0;width:90%; height: 80px; overflow: auto;' cntab='uuuu,tt' />
						</li>
						<li id="05b108f2-c98b-4aed-b664-e0d3c00ff935" data-col="1" data-row="11" data-sizex="5" data-sizey="3" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '事业中心主任意见' />
						</li>
						<li id="9fac4dc4-d3cf-4a01-89f1-c6af2842a764" data-col="6" data-row="11" data-sizex="25" data-sizey="3" class="gs_w" style="display: list-item; background: white;">
							<oa:view column='VIEW_SYZXZR' table='TA_OA_WHTJY_YOUKA' title ='' style='border:0;width:90%; height: 80px; overflow: auto;' cntab='uuuu,tt' />
						</li>
						<li id="7e99d782-06be-4e3f-a5df-b7613fed8332" data-col="1" data-row="14" data-sizex="5" data-sizey="3" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '后勤保障部负责人意见' />
						</li>
						<li id="e870c3c2-a7a6-41d3-838b-35269391f761" data-col="6" data-row="14" data-sizex="25" data-sizey="3" class="gs_w" style="display: list-item; background: white;">
							<oa:view column='VIEW_HQBZBFZR' table='TA_OA_WHTJY_YOUKA' title ='' style='border:0;width:90%; height: 80px; overflow: auto;' cntab='uuuu,tt' />
						</li>
						<li id="9da83a19-3099-41b5-b9fd-2b76247d9ece" data-col="1" data-row="17" data-sizex="5" data-sizey="3" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '油卡管理员' />
						</li>
						<li id="a422f34e-a264-43f8-944d-caf3ffea059b" data-col="6" data-row="17" data-sizex="25" data-sizey="3" class="gs_w" style="display: list-item; background: white;"> 
							<oa:select column='VIEW_YKGLY' table='TA_OA_WHTJY_YOUKA' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title =''>
								<oa:option optionName='请选择' optionValue='-1' />
								<oa:option optionName='同意发放' optionValue='0' />
								<oa:option optionName='不同意发放' optionValue='1' />
							</oa:select>
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
</body>
</oa:init>
</html>
<script>jQuery(function(){ //DOM Ready
	initPageObj();
});
</script>
