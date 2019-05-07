<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="archiveformerrorhandler.jsp"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID();//用户id
    String user_name = accesscontroler.getUserName();//用户名
    String time = DateUtil.getCurrentDateTime();//当前时间
    String date = DateUtil.getCurrentDate();//当日期
    UserCacheBean userBean = UserCache.getUserCacheBean(user_id);//获得缓存的机构信息
    String org_id = userBean.getOrg_id();//所属部门id
    String org_name = userBean.getOrg_name();//所属部门名
    String unit_id = userBean.getUnit_id();    //所属单位id
    String unit_name =  userBean.getUnit_name();//所属单位名
    
    String drag_in_title = StringUtil.deNull(request.getParameter("archiveTitle"));
String drag_in_attach = StringUtil.deNull(request.getParameter("oldAttachId"));
String drag_in_webtext = StringUtil.deNull(request.getParameter("sign_id"));

%>

<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
  <title>tet</title>
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
			width:1272px;
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
<body style="width:1272px">
<form id="form1" name="form1" action="" method="post">
<input id="busi_id" name="busi_id" type="hidden"/>
<input id="opt_type" name="opt_type" type="hidden"/>
<input id="busiTypeCode" name="busiTypeCode" type="hidden"/>

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
					<LI style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=00053767-4c67-4b53-8404-f6c227466ae2 class=gs_w data-col="1" data-row="1" data-sizex="20" data-sizey="1"><oa:input title='标题' type='text' column='T_TITLE' table='T_OA_TEST' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=drag_in_title%>'/></LI>
<LI style="POSITION: absolute; FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id=4a8e437b-ff63-40c8-87ec-3ee0a1e416ae class="gs_w player-revert" data-col="1" data-row="3" data-sizex="20" data-sizey="1"><oa:affixbut butName='请选择文件' column='T_FJ' table='T_OA_TEST'  title ='附件' operType='111' defaultValue ='<%=drag_in_attach%>' /></LI>
					</ul>
			    </div>		
				</section>
			</article>
		</div>
				<div id="tabs-3">
			<oa:webtext column="T_TITLE" table="T_OA_TEST" defautValue="<%=drag_in_webtext%>"/>
			<input type='hidden' id='field_drag_in_webtext' value="T_OA_TEST__T_TITLE"/>
		</div>	
		</div>	    		
<div style="height:50px">
</div>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</form>
</body>
</oa:init>
</html>
