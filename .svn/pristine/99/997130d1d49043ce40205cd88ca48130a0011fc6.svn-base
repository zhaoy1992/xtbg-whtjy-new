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
  <title>湖南省水库移民开发管理局发文稿纸</title>
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
			width:993px;
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
<body style="width:993px">
<form id="form1" name="form1" action="" method="post">
<oa:input type='hidden' column='DRAFT_USERID' table='YMJ_OA_DOCUMENT_SENDYMJ' value='<%=accesscontroler.getUserID() %>' />
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
					<li id="49027a25-9d63-4a55-98f6-d88b33abd5dd" data-col="1" data-row="1" data-sizex="32" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><span style='font-size: 20px; color: #ff0000; padding-left: 33%; line-height: 30px;'>湖南省水库移民开发管理局发文稿纸  </span></li><li id="a80c40b1-68b1-48fb-983b-526c6f5cbafc" data-col="1" data-row="2" data-sizex="10" data-sizey="16" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:view column='SIGN_SEND' table='YMJ_OA_DOCUMENT_SENDYMJ' title ='签发：' style='border:0;width:90%; height: 80%; overflow: auto;'  /></li><li id="897161a9-bf22-4f7d-9ce8-8c0c986f9c51" data-col="11" data-row="2" data-sizex="11" data-sizey="5" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:view column='SIGN_SEND' table='YMJ_OA_DOCUMENT_SENDYMJ' title ='领导意见：' style='border:0;width:90%; height: 80%; overflow: auto;'  /></li><li id="f5f35bcf-6ad8-425a-9c16-6ab16ec4093a" data-col="22" data-row="2" data-sizex="11" data-sizey="5" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:view column='SEND_OFFICE' table='YMJ_OA_DOCUMENT_SENDYMJ' title ='办公室意见：' style='border:0;width:90%; height: 80%; overflow: auto;'  /></li><li id="56c96f19-a5a8-4f32-a2ca-69f96e532769" data-col="11" data-row="7" data-sizex="11" data-sizey="5" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:view column='SEND_VERIFY' table='YMJ_OA_DOCUMENT_SENDYMJ' title ='核稿：' style='border:0;width:90%; height: 80%; overflow: auto;'  /></li><li id="7bd25d03-e30f-40b9-8e7f-9f6b77fec4dd" data-col="22" data-row="7" data-sizex="11" data-sizey="5" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:input title='主办处室：' type='text' column='SEND_RESPONSIBLE' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width: 60%;border: 0px;line-height:28px; height:28px;'/></li><li id="7229a19b-1b02-47c0-a846-9a967330499a" data-col="11" data-row="12" data-sizex="11" data-sizey="6" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:view column='SEND_COUNTERSIGN' table='YMJ_OA_DOCUMENT_SENDYMJ' title ='会签：' style='border:0;width:90%; height: 80%; overflow: auto;'  /></li><li id="53bceea2-6acd-4850-af7f-41d09f3c85c3" data-col="22" data-row="12" data-sizex="11" data-sizey="4" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:view column='SEND_SPONSOR' table='YMJ_OA_DOCUMENT_SENDYMJ' title ='主办处室负责人：' style='border:0;width:90%; height: 60%; overflow: auto;'  /></li><li id="38976b1b-f1ed-43f2-a9ea-f864b2beaf65" data-col="22" data-row="16" data-sizex="11" data-sizey="2" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:input title='拟稿人：' type='text' column='DRAFT_USERNAME' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width: 60%;border: 0px;line-height:28px; height:28px;' value = '<%=accesscontroler.getUserName() %>'/></li><li id="cd02aff6-73a4-4570-b11e-c267c90c1f26" data-col="1" data-row="18" data-sizex="7" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"> <oa:select column='SEND_TYPEWORD' table='YMJ_OA_DOCUMENT_SENDYMJ' style ='width: 70%;line-height:22px; height:22px;' title ='发文：' optionsql= 'select sendtype_name,sendtype_name  from ta_oa_sendno order by sendtype_no asc' ></oa:select></li><li id="b49d7a2c-dfd8-42e2-8162-2ca487a71e9c" data-col="8" data-row="18" data-sizex="3" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; width: 93px; height: 30px; margin-left: -1.5px; background-position: initial initial; background-repeat: initial initial;"> <oa:select column='SEND_YEAR' table='YMJ_OA_DOCUMENT_SENDYMJ' style ='width: 65%;line-height:22px; height:22px;' title ='字（'><oa:option optionName='2009' optionValue='2009' /><oa:option optionName='2010' optionValue='2010' /><oa:option optionName='2011' optionValue='2011' /><oa:option optionName='2012' optionValue='2012' /><oa:option optionName='2013' optionValue='2013' /></oa:select></li><li id="d52d36cb-2784-4d00-a106-0e1704de70d0" data-col="11" data-row="18" data-sizex="4" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; width: 124px; height: 30px; margin-left: -1.5px; background-position: initial initial; background-repeat: initial initial;"><oa:input title='）第' type='text' column='SEND_WALL' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width:70%;border:1px;line-height:25px; height:25px;'/></li><li id="5bb1f09c-244e-463e-958e-a2393714019b" data-col="15" data-row="18" data-sizex="1" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; width: 31px; margin-left: -1.5px; background-position: initial initial; background-repeat: initial initial;"><span style='font-size:12px; padding-left: 43%; line-height: 30px;'>号 </span></li><li id="95007b6d-7932-492a-97b4-7cf65ac79f8b" data-col="16" data-row="18" data-sizex="6" data-sizey="1" class="gs_w" style="display: list-item; position: absolute; background-color: white; width: 186px; margin-left: -1.5px; background-position: initial initial; background-repeat: initial initial;"> <oa:select column='SECRETLEVEL_NAME' table='YMJ_OA_DOCUMENT_SENDYMJ' style ='width: 50%;line-height:22px; height:22px;' title ='机密程度：'><oa:option optionName='秘密' optionValue='秘密' /><oa:option optionName='机密' optionValue='机密' /><oa:option optionName='绝密' optionValue='绝密' /></oa:select></li><li id="ac936ea7-e514-4583-ad43-704d86256d5d" data-col="22" data-row="18" data-sizex="11" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; width: 341px; margin-left: -1.5px; background-position: initial initial; background-repeat: initial initial;"> <oa:select column='URGENCYLEVEL_NAME' table='YMJ_OA_DOCUMENT_SENDYMJ' style ='width: 50%;line-height:22px; height:22px;' title ='快慢等级：'><oa:option optionName='一般' optionValue='一般' /><oa:option optionName='特别' optionValue='特别' /><oa:option optionName='非常' optionValue='非常' /></oa:select></li><li id="89379f59-cf66-4dad-9a1d-394443da6fcd" data-col="1" data-row="19" data-sizex="32" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:input title='标题：' type='text' column='SEND_TITLE' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width: 90%;border: 0px;line-height:28px; height:28px;'/></li><li id="d859ac64-0bf0-4ffb-95a0-6fbbe8e30c75" data-col="1" data-row="20" data-sizex="32" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:input title='主送：' type='text' column='SEND_ZS' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width: 90%;border: 0px;line-height:28px; height:28px;'/></li><li id="3fa87277-a9ae-4d2f-a566-2096e3e50462" data-col="1" data-row="21" data-sizex="32" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:input title='抄送：' type='text' column='SEND_CS' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width: 90%;border: 0px;line-height:28px; height:28px;'/></li><li id="b3e339ad-6968-44c8-a733-d44a22f5ba15" data-col="1" data-row="22" data-sizex="32" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:input title='主题词：' type='text' column='SEND_WORD' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width: 90%;border: 0px;line-height:28px; height:28px;'/></li><li id="0312fa7f-6a5b-4ee8-b2a3-30bb6bfb40fd" data-col="1" data-row="23" data-sizex="32" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><span style='float:left;padding-left:5px;padding-top:10px;'>附件： </span><oa:affixbut butName='请选择文件' column='RECEIVE_AFFIX' table='YMJ_OA_DOCUMENT_SENDYMJ' /> </li><li id="8c5c11fd-439c-4a7c-a0b4-099936a92d8b" data-col="1" data-row="24" data-sizex="32" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><span style='float:left;padding-left:5px;padding-top:10px;'>附件列表： </span><oa:affixshow /></li>									<li id="8767fe50-7f7d-406b-8dfa-27caa27da3ae" data-col="1" data-row="25" data-sizex="10" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:input title='打印份数：' type='text' column='SEND_NUM' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width: 60%;border: 0px;line-height:28px; height:28px;'/></li><li id="0f4aa278-0edf-4640-8924-38a4bcbb9994" data-col="11" data-row="25" data-sizex="11" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:input title='打  字：' type='text' column='SEND_TYPEWRITE' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width: 60%;border: 0px;line-height:28px; height:28px;'/></li><li id="01b284ca-2d80-45f2-917a-6f57667cd507" data-col="22" data-row="25" data-sizex="11" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:input title='校对：' type='text' column='SEND_EFFICACY' table='YMJ_OA_DOCUMENT_SENDYMJ' style= 'width: 60%;border: 0px;line-height:28px; height:28px;'/></li>
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
