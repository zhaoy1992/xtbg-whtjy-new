<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
%>

<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
  <title>测试</title>
  <script>
		jQuery(function(){ //DOM Ready
			jQuery(".gridster ul").gridster({
					widget_margins: [1, 1],//元素间隔
					widget_base_dimensions: [60,30],//初始化宽度 
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
	</script>
	<style>
		body{
			font-family: Helvetica, arial, sans-serif;
			margin:10px auto;
			color: #fff;
			font-size: 12px;
			width:994px;
			text-align:center;
		}
		ul{	
			background:red;
			list-style:none;
			border: solid 2px red;
		}
		li{	
			background:white;
			border-collapse:collapse;
			color: black;
			margin:-0.5px;
			text-align: left;
			line-height: 100%;
			font: normal;
		}
	</style>

</head>
<body style="width:994px">
<form id="form1" name="form1" action="" method="post">

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
					<li id="2e15b9db-91fe-4733-8788-37b1a497c722" data-col="1" data-row="1" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_2e15b9db-91fe-4733-8788-37b1a497c722</li><li id="ee9447c6-b5ed-4382-a078-12959296bb2f" data-col="1" data-row="2" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;"><oa:input title='' type='text' column='null' table='' style= 'width: 90%;border: 0px;line-height:28px; height:28px;'/></li><li id="1ef3ab00-5e64-4233-b60d-64cf2e55b6fa" data-col="1" data-row="3" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_1ef3ab00-5e64-4233-b60d-64cf2e55b6fa</li><li id="80cbed13-5e69-4d90-9c98-8e66ed915428" data-col="1" data-row="4" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_80cbed13-5e69-4d90-9c98-8e66ed915428</li><li id="17af35c2-2147-427f-961f-a58541d985c8" data-col="1" data-row="5" data-sizex="5" data-sizey="1" class="gs_w" style="display: list-item;">oa_17af35c2-2147-427f-961f-a58541d985c8</li><li id="cc08ef54-b470-4634-aeba-57e01feb1e8f" data-col="6" data-row="5" data-sizex="11" data-sizey="1" class="gs_w" style="display: list-item;">oa_cc08ef54-b470-4634-aeba-57e01feb1e8f</li>			
			<li id="852ebc6b-cb6f-4a37-9403-f11bedc80cae" data-col="1" data-row="6" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_852ebc6b-cb6f-4a37-9403-f11bedc80cae</li><li id="cf0c6ed7-9487-4f2c-beb5-0218d6f2393c" data-col="1" data-row="7" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_cf0c6ed7-9487-4f2c-beb5-0218d6f2393c</li><li id="91f4b4b1-2a9f-480a-8e6a-a2752044e670" data-col="1" data-row="8" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_91f4b4b1-2a9f-480a-8e6a-a2752044e670</li><li id="00c31a68-e2fb-40db-8f8d-19372ec6782c" data-col="1" data-row="9" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_00c31a68-e2fb-40db-8f8d-19372ec6782c</li><li id="07bf1744-8c69-4819-9ffa-19037dc80baf" data-col="1" data-row="10" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_07bf1744-8c69-4819-9ffa-19037dc80baf</li><li id="dcfeead5-1bda-41f3-aa78-b31d36ab5b8c" data-col="1" data-row="11" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_dcfeead5-1bda-41f3-aa78-b31d36ab5b8c</li><li id="aa884442-4390-45e9-9f0a-659dd5cb8db1" data-col="1" data-row="12" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_aa884442-4390-45e9-9f0a-659dd5cb8db1</li><li id="37ef7da8-4b76-4978-a234-9320c708bede" data-col="1" data-row="13" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_37ef7da8-4b76-4978-a234-9320c708bede</li><li id="c14e409c-e79f-4d26-b158-b0c4a986f713" data-col="1" data-row="14" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_c14e409c-e79f-4d26-b158-b0c4a986f713</li><li id="d14237dd-0f56-45c6-b3b6-296d0fa4b5f6" data-col="1" data-row="15" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_d14237dd-0f56-45c6-b3b6-296d0fa4b5f6</li><li id="a9cb77b8-75c1-45b7-8c1a-0d7b118d037d" data-col="1" data-row="16" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_a9cb77b8-75c1-45b7-8c1a-0d7b118d037d</li><li id="47c9f901-2620-4671-b08d-da4981b47b08" data-col="1" data-row="17" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_47c9f901-2620-4671-b08d-da4981b47b08</li><li id="ad698cd0-f8b9-4a5c-8ea6-a7bf70c8c66e" data-col="1" data-row="18" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_ad698cd0-f8b9-4a5c-8ea6-a7bf70c8c66e</li><li id="07a63b54-1e4d-4753-a9f3-4da6617c0467" data-col="1" data-row="19" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_07a63b54-1e4d-4753-a9f3-4da6617c0467</li><li id="6bbc83e2-9612-4324-880f-0d801db0a5bf" data-col="1" data-row="20" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_6bbc83e2-9612-4324-880f-0d801db0a5bf</li><li id="d98862d8-833e-46dd-bb7d-837e64a506fe" data-col="1" data-row="21" data-sizex="16" data-sizey="1" class="gs_w" style="display: list-item;">oa_d98862d8-833e-46dd-bb7d-837e64a506fe</li>
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
