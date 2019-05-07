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
drag_in_title = request.getParameter("flowTitle");
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
  <title>手机端测试发文</title>
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
								<li><a href="#tabs-3" title="点击加载正文" onclick="changeIndex(3)">正文</a></li>
							</ul>
		</div>
		<div id="tabs-1">
			<article>
				<section>
				<div class="gridster">
					<ul>
					<LI style="FILTER:  ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=2427f4cf-abed-4065-b574-88f7a8ae980e class=gs_w data-col="1" data-row="1" data-sizex="4" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 2%; line-height: 30px;' column='null'  table='' value= '标题：' /></LI>
<LI style="FILTER:  ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=cf22b027-f060-419a-a375-b71f8bd06ab8 class=gs_w data-col="5" data-row="1" data-sizex="26" data-sizey="1"><oa:input title='' type='text' column='TITEL' table='TEST_SJFAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI style="FILTER:  ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=e03c3fd3-ee01-41d4-ad68-dfb7b0c0822d class=gs_w data-col="1" data-row="2" data-sizex="15" data-sizey="8"><oa:view column='YIJIAN1' table='TEST_SJFAWEN' title ='' style='border:0;width:90%; height: 180px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER:  ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=1b942e93-4963-4b19-9134-331e7657832c class=gs_w data-col="16" data-row="2" data-sizex="15" data-sizey="8"><oa:view column='YIJIAN2' table='TEST_SJFAWEN' title ='' style='border:0;width:90%; height: 180px; overflow: auto;' cntab='uuuu,tt' /></LI>
<LI style="FILTER:  ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=587fc8c1-4dfc-4b63-b090-940067c3832d class=gs_w data-col="1" data-row="10" data-sizex="4" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 1%; line-height: 30px;' column='null'  table='' value= '附件：' /></LI>
<LI style="FILTER:  ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=17e3dd05-06d4-4591-9327-3c7df72fc4b7 class=gs_w data-col="5" data-row="10" data-sizex="26" data-sizey="1"><input type='hidden' id='field_drag_in_attach' value='TEST_SJFAWEN__T_FJ_ID'/><oa:affixbut butName='请选择文件' column='T_FJ_ID' table='TEST_SJFAWEN'  title ='' operType='111' initFjDJBHForArchive ='<%=drag_in_attach%>' /></LI>
<LI style="FILTER:  ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=40790bca-8c85-4848-ad4d-9e2a7cc9e0c6 class=gs_w data-col="1" data-row="11" data-sizex="4" data-sizey="1"><oa:span style='font-size: 20px; color: #ff0000; padding-left: 1%; line-height: 30px;' column='null'  table='' value= '附件列表：' /></LI>
<LI style="FILTER:  ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=de7ef4af-28c7-470d-bb1a-6266fdca8da0 class=gs_w data-col="5" data-row="11" data-sizex="26" data-sizey="1"><oa:affixshow  title =''/></LI>
					</ul>
			    </div>		
				</section>
			</article>
		</div>
				<div id="tabs-3">
			<oa:webtext column="T_ZW_ID" table="TEST_SJFAWEN" defautValue="<%=drag_in_webtext%>"/>
			<input type='hidden' id='field_drag_in_webtext' value="TEST_SJFAWEN__T_ZW_ID"/>
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
