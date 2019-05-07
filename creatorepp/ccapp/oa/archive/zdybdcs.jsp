<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="archiveformerrorhandler.jsp"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
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
    
    String drag_in_title = StringUtil.deNull(request.getParameter("flowTitle"));
String drag_in_attach = StringUtil.deNull(request.getParameter("oldAttachId"));
String drag_in_webtext = StringUtil.deNull(request.getParameter("textIdZW"));

%>

<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
  <title>自定义表单测试</title>
  <script>
		jQuery(function(){ //DOM Ready
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
		});
		//.do页面的回调函数，将验证框架里的isSubmit重置，用来防止提交失败后再提交失效。
		function resetSubmit(){
			jQuery("#form1").resetSubmit(false);
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
<oa:input type='hidden' column='ID' table='OA_TEST_FORM' value='<%=org_id%>' />
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
	<LI style="FILTER: ; ZOOM: 1; DISPLAY: block; BACKGROUND: white"
		id=f3c3128b-ca93-48cc-8e79-92b1f560fa3b class=gs_w data-sizey="1"
		data-sizex="30" data-row="1" data-col="1"><span
		style='font-size: 20px; color: #ff0000; padding-left: 43%; line-height: 30px;'>自定义表单
	</span></LI>
	<LI style="ZOOM: 1; DISPLAY: block; BACKGROUND: white"
		id=a5acc044-6fec-4e0f-a23c-4ec702cfa86f class=gs_w data-sizey="10"
		data-sizex="15" data-row="2" data-col="1"><oa:view
		column='ZR_VIEW' table='OA_TEST_FORM' title='主任意见：'
		style='border:0;width:90%; height: 80%; overflow: auto;' /></LI>
	<LI style="ZOOM: 1; DISPLAY: block; BACKGROUND: white"
		id=fce9495c-4939-4960-b761-31372d307af5 class=gs_w data-sizey="10"
		data-sizex="15" data-row="2" data-col="16"><oa:input
		title='领导意见：' type='text' column='LD_VIEW' table='OA_TEST_FORM'
		style='width: 90%;border: 0px;line-height:26px; height:26px;'
		value='<%=user_name+ "  "+date%>' /></LI>
	<LI
		style="POSITION: absolute; WIDTH: 929px; ZOOM: 1; DISPLAY: block; BACKGROUND: white; HEIGHT: 30px"
		id=c332b752-c563-4a43-8e27-42c3f8d17b15 class=gs_w data-sizey="1"
		data-sizex="30" data-row="13" data-col="1"><input type='hidden'
		id='field_drag_in_title' value='OA_TEST_FORM__TITEL' /><oa:input
		title=' 标    题：' type='text' column='TITEL' table='OA_TEST_FORM'
		style='width: 90%;border: 0px;line-height:26px; height:26px;'
		value='<%=drag_in_title%>' /></LI>
	<LI
		style="POSITION: absolute; ZOOM: 1; DISPLAY: block; BACKGROUND: white"
		id=00858ad8-b3dd-4340-b718-66b3fc5c698c class=gs_w data-sizey="1"
		data-sizex="30" data-row="15" data-col="1"><input type='hidden'
		id='field_drag_in_attach' value='OA_TEST_FORM__FJ_ID' /><oa:affixbut
		butName='请选择文件' column='FJ_ID' table='OA_TEST_FORM' title=' 附     件1：'
		operType='111' initFjDJBHForArchive='<%=drag_in_attach%>' /></LI>
	<LI style="POSITION: absolute; DISPLAY: list-item; BACKGROUND: white"
		id=c3d74765-0e4d-40e8-92af-fe539fe92fa4 class=gs_w data-sizey="1"
		data-sizex="30" data-row="14" data-col="1"><oa:date
		dateFmt='yyyy-MM-dd' column='T_DATES' table='OA_TEST_FORM'
		title='日     期：'
		style='height:22px;line-height: 22px;float:left;margin-top:3px;'
		other="class='Wdate'" /></LI>
	<LI
		style="POSITION: absolute; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white"
		id=f9e99b56-7df2-46c8-b417-4e2063ac0b6f class="gs_w player-revert"
		data-sizey="1" data-sizex="30" data-row="12" data-col="1"><input
		type='hidden' id='field_drag_in_number' value='OA_TEST_FORM__FS_YEAR' /><oa:numberinput
		title='发 文 号：' column='FS_YEAR' table='OA_TEST_FORM'
		style='width: 220px;border: 0px;line-height:26px; height:26px;float:left;' /></LI>
	<LI style="POSITION: absolute; DISPLAY: list-item; BACKGROUND: white"
		id=3f3f84ac-bb0e-44e4-bcac-f0d7486f2ffc class=gs_w data-sizey="1"
		data-sizex="30" data-row="16" data-col="1"><oa:affixshow
		title='附件列表：' /></LI>
</ul>
</div>		
				</section>
			</article>
		</div>
				<div id="tabs-3">
			<oa:webtext column="ZW_ID" table="OA_TEST_FORM" defautValue="<%=drag_in_webtext%>"/>
			<input type='hidden' id='field_drag_in_webtext' value="OA_TEST_FORM__ZW_ID"/>
		</div>	
		</div>	    		
<div style="height:50px">
</div>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</form>
</body>
</oa:init>
</html>
