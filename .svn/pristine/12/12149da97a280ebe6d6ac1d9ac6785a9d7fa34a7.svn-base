<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="archiveformerrorhandler.jsp"%>
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

<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String windowsId = request.getParameter("windowsId");
String user_id = accesscontroler.getUserID();//用户id
String user_name = accesscontroler.getUserName();//用户名
String time = DateUtil.getCurrentDateTime();//当前时间
String date = DateUtil.getCurrentDate();//当日期
UserCacheBean userBean = UserCache.getUserCacheBean(user_id);//获得缓存的机构信息
String org_id = userBean.getOrg_id();//所属部门id
String org_name = userBean.getOrg_name();//所属部门名
String unit_id = userBean.getUnit_id();    //所属单位id
String unit_name =  userBean.getUnit_name();//所属单位名
String user_worktel = userBean.getUser_worktel(); //工作电话
String user_mobiletel1 = userBean.getUser_mobiletel1(); //手机号码
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
	if(mess.length>0){                                                                                                      
		Map<String,String> map = (Map<String,String>)mess[0];                                                                 
		drag_in_title = StringUtil.deNull(map.get(FormserviceImpl.DRAG_IN_TITLE));                                            
		drag_in_attach = StringUtil.deNull(map.get(FormserviceImpl.DRAG_IN_ATTACH));                                          
	}                                                                                                                       
}                                                                                                                        

%>

<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
  <title>云南发文</title>
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
					<LI style="DISPLAY: list-item; BACKGROUND: white" id=ded3ec6e-c19f-4843-ae48-d9053227e6a1 class=gs_w data-col="1" data-row="1" data-sizex="12" data-sizey="6"><oa:view column='FAWEN_LEADER_IDER' table='OA_YL_FAWEN' title ='领导签发：' style='border:0;width:90%; height: 150px; overflow: auto;'  /></LI>
<LI style="POSITION: absolute; DISPLAY: list-item; BACKGROUND: white" id=5207fca8-d75b-4537-9383-b103ca17e197 class=gs_w data-col="13" data-row="1" data-sizex="18" data-sizey="3"><oa:view column='FAWEN_CH_IDEA' table='OA_YL_FAWEN' title ='处(室)核稿：' style='border:0;width:90%; height: 50px; overflow: auto;'  /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=bcda9648-ab58-4a02-9ff3-6115380ea94d class=gs_w data-col="13" data-row="4" data-sizex="18" data-sizey="3"><oa:view column='FAWEN_HG_IDEA' table='OA_YL_FAWEN' title ='核稿：' style='border:0;width:90%; height: 50px; overflow: auto;'  /></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=4c7e247f-8d6f-4460-b414-1abd4192872b class=gs_w data-col="1" data-row="7" data-sizex="6" data-sizey="1"> <oa:select column='FAWEN_HJ' table='OA_YL_FAWEN' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title ='缓        急：'><oa:option optionName='text1' optionValue='value1' /><oa:option optionName='text2' optionValue='value2' /><oa:option optionName='text13' optionValue='value3' /></oa:select></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=ad5fbf53-c24f-43f1-8609-903891a61d3b class=gs_w data-col="7" data-row="7" data-sizex="24" data-sizey="1"> <oa:select column='FAWEN_MJ' table='OA_YL_FAWEN' style ='width: 12%;line-height:22px; height:22px;margin-top:3px;' title ='密        级：'><oa:option optionName='text1' optionValue='value1' /><oa:option optionName='text2' optionValue='value2' /><oa:option optionName='text13' optionValue='value3' /></oa:select></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=7830e55b-8e84-4646-8a58-c95776acb139 class=gs_w data-col="1" data-row="8" data-sizex="30" data-sizey="1"><oa:input title='主        送：' type='text' column='FAWEN_ZS' table='OA_YL_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=15e78fce-db50-41b9-b5fe-3910f3487c87 class=gs_w data-col="1" data-row="9" data-sizex="30" data-sizey="1"><oa:input title='抄        送：' type='text' column='FAWEN_CS' table='OA_YL_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=a6e18130-7bbd-46e6-9620-63aaf23c3c31 class=gs_w data-col="1" data-row="10" data-sizex="12" data-sizey="1"><oa:input title='拟稿单位：' type='text' column='FAWEN_UNIT' table='OA_YL_FAWEN' style= 'width: 80%;border: 0px;line-height:26px; height:26px;' value = '<%=unit_name%>'/></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=fefa154e-87ea-4574-a0da-9b1200c2111f class=gs_w data-col="13" data-row="10" data-sizex="18" data-sizey="1"><oa:input title='拟稿人：' type='text' column='FAWEN_MAN' table='OA_YL_FAWEN' style= 'width: 60%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=777dfc62-7b52-4cc6-8dd7-0b35083504d4 class=gs_w data-col="1" data-row="11" data-sizex="30" data-sizey="1"><input type='hidden' id='field_drag_in_title' value='OA_YL_FAWEN__FAWEN_TITLE'/><oa:input title='文件标题：' type='text' column='FAWEN_TITLE' table='OA_YL_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=drag_in_title%>'/></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=70415517-6f85-4d90-98af-a37407ac378e class=gs_w data-col="1" data-row="12" data-sizex="30" data-sizey="1"><oa:input title='主题词：' type='text' column='FAWEN_ZTC' table='OA_YL_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=70d5ae66-5d43-4c38-82b5-afbe6eaa5600 class=gs_w data-col="1" data-row="13" data-sizex="30" data-sizey="1"><input type='hidden' id='field_drag_in_attach' value='OA_YL_FAWEN__FAWEN_FJ'/><oa:affixbut butName='请选择文件' column='FAWEN_FJ' table='OA_YL_FAWEN'  title ='请选择文件1：' operType='111' initFjDJBHForArchive ='<%=drag_in_attach%>' /></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=67d0882f-1dd8-4c8b-848d-085ec318a7bc class=gs_w data-col="1" data-row="15" data-sizex="30" data-sizey="1"><input type='hidden' id='field_drag_in_number' value='OA_YL_FAWEN__FAWEN_NUM'/><oa:numberinput title='发文号：' column='FAWEN_NUM' table='OA_YL_FAWEN' style= 'width: 120px;border: 0px;line-height:26px; height:26px;float:left;'/></LI>
<LI style="POSITION: absolute; BACKGROUND-COLOR: white; DISPLAY: list-item" id=232fca9a-f43a-4434-8f1b-87bd602b659b class="gs_w player-revert" data-col="1" data-row="14" data-sizex="30" data-sizey="1"><oa:affixshow  title ='附件列表：'/></LI>
					</ul>
			    </div>		
				</section>
			</article>
		</div>
				<div id="tabs-3">
			<oa:webtext column="FAWEN_ZW" table="OA_YL_FAWEN" defautValue="<%=drag_in_webtext%>"/>
			<input type='hidden' id='field_drag_in_webtext' value="OA_YL_FAWEN__FAWEN_ZW"/>
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
