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
  <title>院本部油卡领用申请表</title>
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
						<li id="8aacd654-f6ad-4fcc-9a22-ad9321556f02" data-col="1" data-row="1" data-sizex="30" data-sizey="2" class="gs_w" style="display: list-item; background: white; height: 62px; width: 929px; margin-bottom: -1.5px;">
							<oa:span style='font-size: 35px; color: #000000; padding-left: 23%; line-height: 40px;' column='null'  table='' value= '湖北特检设备检验检测研究院' />
						</li>
						<li id="2d68dc53-a6ad-44a5-9646-acd77a40146f" data-col="1" data-row="3" data-sizex="30" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 40%; line-height: 30px;' column='null'  table='' value= '油卡领用申请审批单' />
						</li>
						<li id="2ecea5fd-4bb3-42c6-b08a-9c1f2fa4ff6f" data-col="1" data-row="4" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '申请人' />
						</li>
						<li id="c529a86b-06eb-4691-958f-dd19e8738566" data-col="6" data-row="4" data-sizex="25" data-sizey="1" class="gs_w" style="display: list-item; position: absolute; background: white;">
							<oa:input title='' type='text' column='APPLICATION' table='TA_OA_WHTJY_YOUKA' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name %>'/>
						</li>
						<li id="284236fc-594a-4efd-bf87-4d07d33d0277" data-col="1" data-row="5" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '申请科室' />
						</li>
						<li id="ac12616e-b890-4e28-95c2-da49c5d27f2d" data-col="6" data-row="5" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:input title='' type='text' column='ORG_NAME' table='TA_OA_WHTJY_YOUKA' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=org_name %>'/>
						</li>
						<li id="b2d35c7d-b42f-47dc-9e05-5a0b22ad08a0" data-col="16" data-row="5" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '申请时间' />
						</li>
						<li id="8a73c531-c2d8-4a41-aede-e8a429c8cef6" data-col="21" data-row="5" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:date defaultValue='sysDate' dateFmt='yyyy-MM-dd HH:mm:ss' column='APPLICATION_DATE' table='TA_OA_WHTJY_YOUKA' title ='' style='height:22px;line-height: 22px;float:left;margin-top:3px;' other="class='Wdate'"/>
						</li>
						<li id="da9a0b01-fd59-4435-85df-c4604480bb27" data-col="1" data-row="6" data-sizex="5" data-sizey="2" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '申请事由' />
						</li>
						<li id="e28873da-b51c-44c8-af01-c4c8bd0c63fa" data-col="6" data-row="6" data-sizex="25" data-sizey="2" class="gs_w" style="display: list-item; background: white;">
							<oa:textarea column='SHENQINGSHIYOU' table='TA_OA_WHTJY_YOUKA' title ='' style='border: 1;width:98%; height: 50px; overflow: auto;'  />
						</li>
						<li id="a20aa646-baff-4ef1-9f9e-8bb3d4788628" data-col="1" data-row="8" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '车牌号' />
						</li>
						<li id="6a36d7aa-e7b3-47ca-9ac8-611464484dca" data-col="6" data-row="8" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;"> 
							<oa:select column='CAR_INFO' table='TA_OA_WHTJY_YOUKA' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title =''>
							</oa:select>
						</li>
						<li id="b1796957-317c-4988-b4ff-d24ea77bae03" data-col="16" data-row="8" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '充值金额' />
						</li>
						<li id="5c4f6eca-5254-4654-8015-78bb2b44195b" data-col="21" data-row="8" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background: white;">
							<oa:input title='' type='text' column='MONEY' table='TA_OA_WHTJY_YOUKA' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/>
						</li>
						<li id="be4a0469-568a-48a6-8bb5-428071b82d82" data-col="1" data-row="9" data-sizex="5" data-sizey="3" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '后勤保障部负责人意见' />
						</li>
						<li id="9c814e54-92bc-4375-88e0-798fdd5eb908" data-col="6" data-row="9" data-sizex="25" data-sizey="3" class="gs_w" style="display: list-item; background: white;">
							<oa:view column='VIEW_HQBZBFZR' table='TA_OA_WHTJY_YOUKA' title ='' style='border:0;width:90%; height: 80px; overflow: auto;' cntab='uuuu,tt' />
						</li>
						<li id="ff2650a3-7667-4068-ba93-8ad87bc70fa7" data-col="1" data-row="12" data-sizex="5" data-sizey="3" class="gs_w" style="display: list-item; background: white;">
							<oa:span style='font-size: 20px; color: #000000; padding-left: 5%; line-height: 30px;' column='null'  table='' value= '油卡管理员' />
						</li>
						<li id="b351afcc-c1d4-44e4-84be-20a11d23acac" data-col="6" data-row="12" data-sizex="25" data-sizey="3" class="gs_w" style="display: list-item; background: white;"> 
							<oa:select column='VIEW_YKGLY' table='TA_OA_WHTJY_YOUKA' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;'  title =''>
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
