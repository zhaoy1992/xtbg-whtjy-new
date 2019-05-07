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
  <title>发文测试表单</title>
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
<input id="businessType" name="businessType" type="hidden"/>

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
					<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=4cdbb883-1177-46c4-a9c9-5cd14678aa87 class=gs_w data-col="1" data-row="1" data-sizex="30" data-sizey="1"><oa:input title='标题：' type='text' column='TITEL' table='OA_TEST_FORM' style= 'width: 90%;border: 0px;line-height:28px; height:28px;' value = ''/></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=2fd212a4-7e19-4d4f-b4ca-54429ba3e9ff class=gs_w data-col="1" data-row="2" data-sizex="15" data-sizey="4"><oa:view column='ZR_VIEW' table='OA_TEST_FORM' title ='签发：' style='border:0;width:90%; height: 60%; overflow: auto;'  /></LI>
<LI style="POSITION: absolute; BACKGROUND-COLOR: white; DISPLAY: list-item" id=65bea889-de0b-4e93-b706-d4dee6b9f482 class=gs_w data-col="1" data-row="6" data-sizex="15" data-sizey="4"><oa:input title='主送：' type='text' column='ZS' table='OA_TEST_FORM' style= 'width: 80%;border: 0px;line-height:28px; height:28px;' value = '<%=accesscontroler.getUserName() %>'/></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=0ae5aead-d7f0-4d2a-ac97-24efe91420e2 class=gs_w data-col="16" data-row="2" data-sizex="15" data-sizey="8"><oa:view column='LD_VIEW' table='OA_TEST_FORM' title ='核稿：' style='border:0;width:90%; height: 80%; overflow: auto;'  /></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=210ac2ee-4fd3-4218-88c3-a6628c9104f9 class=gs_w data-col="1" data-row="10" data-sizex="30" data-sizey="1"><span style='float:left;padding-left:5px;padding-top:10px;'>附件： </span><oa:affixbut butName='请选择文件' column='FJ_ID' table='OA_TEST_FORM' /> </LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=dd3e1292-dce5-4a38-89eb-f1a9f63d5c33 class=gs_w data-col="1" data-row="11" data-sizex="30" data-sizey="1"><span style='float:left;padding-left:5px;padding-top:10px;'>附件 </span><oa:affixshow /></LI>
					</ul>
			    </div>		
				</section>
			</article>
		</div>
				<div id="tabs-3">
			<oa:webtext column="ZW_ID" table="OA_TEST_FORM"/>
		</div>	
		</div>	    		
<div style="height:50px">
</div>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</form>
</body>
</oa:init>
</html>
