<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>


<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
  <title>测试OA</title>
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
<body style="width:931px">
<form id="form1" name="form1" action="" method="post">
<div id="tabs1" style="width:100%;border: 0px;">
		<table width="100%" border="0" cellspacing="1" cellpadding="0" style="display: inline;">
			<tr style="height:65px">
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
					<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=5e0d7c36-0fed-406b-896e-36cd8a2cde20 class=gs_w data-sizey="1" data-sizex="30" data-row="1" data-col="1"><span style='font-size: 20px; color: #ff0000; padding-left: 43%; line-height: 30px;'>OA测试 </span></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=e3d871af-6d7d-41f9-9799-99ba5110f1e4 class=gs_w data-sizey="15" data-sizex="10" data-row="2" data-col="1"><oa:view column='SEND_COUNTERSIGN' table='YMJ_OA_DOCUMENT_SENDYMJ' title ='会签：' style='border:0;width:90%; height: 80%; overflow: auto;'  /></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=6f5aa8de-9f57-430b-9224-8ee74e16e36e class=gs_w data-sizey="5" data-sizex="10" data-row="2" data-col="11"><oa:view column='SEND_RESPONSIBLE' table='YMJ_OA_DOCUMENT_SENDYMJ' title ='主办处室：' style='border:0;width:90%; height: 80%; overflow: auto;'  /></LI>
<LI style="BACKGROUND-COLOR: white; WIDTH: 309px; DISPLAY: list-item; HEIGHT: 154px" id=c3b9ae67-e204-4195-844e-3d7e6c3ee213 class=gs_w data-sizey="5" data-sizex="10" data-row="2" data-col="21"><oa:view column='SEND_SPONSOR' table='YMJ_OA_DOCUMENT_SENDYMJ' title ='主办处室负责人' style='border:0;width:90%; height: 80%; overflow: auto;'  /></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=75d45154-330f-451a-828f-cc9a8711b38d class=gs_w data-sizey="5" data-sizex="10" data-row="7" data-col="11"><oa:view column='SIGN_SEND' table='YMJ_OA_DOCUMENT_SENDYMJ' title ='签发：' style='border:0;width:90%; height: 80%; overflow: auto;'  /></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=6192e724-46f9-4962-a428-182b928f3fe8 class=gs_w data-sizey="5" data-sizex="10" data-row="7" data-col="21"><oa:view column='DRAFT_USERNAME' table='YMJ_OA_DOCUMENT_SENDYMJ' title ='拟稿人：' style='border:0;width:90%; height: 80%; overflow: auto;'  /></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=33502d71-81b0-4a15-94a3-d8f025ecc748 class=gs_w data-sizey="5" data-sizex="10" data-row="12" data-col="11"><oa:view column='DRAFT_USERID' table='YMJ_OA_DOCUMENT_SENDYMJ' title ='拟稿人ID：' style='border:0;width:90%; height: 80%; overflow: auto;'  /></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=92bc82c1-4dd8-40cb-9773-b7b22ace3128 class=gs_w data-sizey="3" data-sizex="10" data-row="12" data-col="21"><oa:input title='发文号：' type='text' column='SEND_WALL' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width: 80%;border: 0px;line-height:28px; height:28px;'/></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=a47acd94-a08a-4f8b-a5d2-0ea17663aeb3 class=gs_w data-sizey="2" data-sizex="10" data-row="15" data-col="21"><oa:input title='' type='text' column='SEND_ID' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width: 90%;border: 0px;line-height:28px; height:28px;'/></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=2e6baf96-37ea-4d43-af87-70a110483996 class=gs_w data-sizey="1" data-sizex="30" data-row="17" data-col="1"><oa:input title='标题：' type='text' column='SEND_TITLE' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width: 90%;border: 0px;line-height:28px; height:28px;'/></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=63084680-2f82-460e-ae45-a17cf77d0e52 class=gs_w data-sizey="1" data-sizex="30" data-row="18" data-col="1"><span style='float:left;padding-left:5px;padding-top:10px;'>请选择附件： </span><oa:affixbut butName='请选择文件' column='RECEIVE_AFFIX' table='YMJ_OA_DOCUMENT_SENDYMJ' /> </LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=58814dfb-52d5-4418-9d33-953cbb25e73f class=gs_w data-sizey="1" data-sizex="30" data-row="20" data-col="1"><oa:input title='年份：' type='text' column='SEND_YEAR' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width: 90%;border: 0px;line-height:28px; height:28px;'/></LI>
<LI style="BACKGROUND-COLOR: white; DISPLAY: list-item" id=eaaf0cac-7da1-4a6d-bc81-3a6e6f7ffae7 class=gs_w data-sizey="1" data-sizex="30" data-row="21" data-col="1"><oa:input title='快慢等级：' type='text' column='URGENCYLEVEL_NAME' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width: 90%;border: 0px;line-height:28px; height:28px;'/></LI>
<LI style="DISPLAY: list-item; BACKGROUND: white" id=4638af39-7ce7-4823-819b-85d6fa59339d class=gs_w data-sizey="1" data-sizex="30" data-row="22" data-col="1"> <oa:select column='SECRETLEVEL_NAME' table='YMJ_OA_DOCUMENT_SENDYMJ' style ='width: 50%;line-height:28px; height:28px;' title ='机密程度：'><oa:option optionName='高' optionValue='高' /><oa:option optionName='一般' optionValue='一般' /><oa:option optionName='低' optionValue='低' /></oa:select></LI>
<LI style="POSITION: absolute; BACKGROUND-COLOR: white; DISPLAY: list-item" id=46a12468-0ea5-43ba-b563-77c0cddbfbbc class="gs_w player-revert" data-sizey="1" data-sizex="30" data-row="19" data-col="1"><span style='float:left;padding-left:5px;padding-top:10px;'>附件列表： </span><oa:affixshow /></LI>
					</ul>
			    </div>		
				</section>
			</article>
		</div>
				<div id="tabs-3">
			<oa:webtext column="RECEIVE_CONTENT" table="YMJ_OA_DOCUMENT_SENDYMJ"/>
		</div>	
		</div>	    		
<div style="height:50px">
</div>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</form>
</body>
</oa:init>
</html>
