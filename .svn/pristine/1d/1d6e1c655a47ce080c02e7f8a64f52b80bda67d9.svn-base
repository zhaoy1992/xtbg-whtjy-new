<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID();//用户id
    String user_name = accesscontroler.getUserName();//用户名
    String time = DateUtil.getCurrentDateTime();//当前时间
    String date = DateUtil.getCurrentDate();//当日期
    //获得缓存的机构信息
    UserCacheBean userBean = UserCache.getUserCacheBean(user_id);
    String org_id = userBean.getOrg_id();//所属部门id
    String org_name = userBean.getOrg_name();//所属部门名
    String unit_id = userBean.getUnit_id();    //所属单位id
    String unit_name =  userBean.getUnit_name();//所属单位名
%>

<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
  <title>云南发文管理</title>
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
					<li style="position: absolute; zoom: 1; display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;" id="91fac250-2de2-42b4-960d-6d7b9d7f31f8" class="gs_w" data-col="1" data-row="7" data-sizex="6" data-sizey="1"> <oa:select column='FAWEN_NO' table='OA_YL_FAWEN' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title ='发文字号：'><oa:option optionName='t自卫队林' optionValue='自卫队林' /><oa:option optionName='text2' optionValue='value2' /><oa:option optionName='text13' optionValue='value3' /></oa:select></li><li style="position: absolute; width: 93px; zoom: 1; display: list-item; background-color: white; margin-right: -1px; background-position: initial initial; background-repeat: initial initial;" id="1d003e2f-7f2a-47b8-9684-af483a41fd18" class="gs_w" data-col="7" data-row="7" data-sizex="3" data-sizey="1"><oa:input title='（' type='text' column='FAWEN_YEAR' table='OA_YL_FAWEN' style= 'width: 70%;border: 0px;line-height:22px; height:22px;margin-top:3px;' value = ''/></li><li style="position: absolute; width: 93px; zoom: 1; display: list-item; background-color: white; margin-right: -1px; background-position: initial initial; background-repeat: initial initial;" id="7f53af54-733b-432b-8658-0566295a5457" class="gs_w" data-col="10" data-row="7" data-sizex="3" data-sizey="1"><oa:input title='）' type='text' column='FAWEN_NUM' table='OA_YL_FAWEN' style= 'width: 70%;border: 0px;line-height:22px; height:22px;margin-top:3px;' value = ''/></li><li style="POSITION: absolute; FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id="cc705bda-d575-42fb-9fad-7b8c65b306a7" class="gs_w" data-col="1" data-row="8" data-sizex="6" data-sizey="1"> <oa:select column='FAWEN_HJ' table='OA_YL_FAWEN' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title ='缓        急：'><oa:option optionName='text1' optionValue='value1' /><oa:option optionName='text2' optionValue='value2' /><oa:option optionName='text13' optionValue='value3' /></oa:select></li><li style="position: absolute; zoom: 1; display: list-item; background-color: white; width: 186px; margin-right: -1.5px; background-position: initial initial; background-repeat: initial initial;" id="dd110538-2bd0-4815-92fd-93a21ad781e9" class="gs_w" data-col="7" data-row="8" data-sizex="6" data-sizey="1"> <oa:select column='FAWEN_MJ' table='OA_YL_FAWEN' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title ='密        级：'><oa:option optionName='text1' optionValue='value1' /><oa:option optionName='text2' optionValue='value2' /><oa:option optionName='text13' optionValue='value3' /></oa:select></li><li style="position: absolute; zoom: 1; display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;" id="ff3ec9e3-a969-4b23-944c-eee6912b7379" class="gs_w" data-col="13" data-row="7" data-sizex="18" data-sizey="1"><span style='font-size: 20px; color: #ff0000; padding-left: 43%; line-height: 30px;'>号 </span></li><li style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id="1087ab44-705a-4c4f-bcd8-d7f1ae3306aa" class="gs_w" data-col="1" data-row="1" data-sizex="12" data-sizey="6"><oa:view column='FAWEN_LEADER_IDER' table='OA_YL_FAWEN' title ='领导签发：' style='border:0;width:90%; height: 80%; overflow: auto;'  /></li><li style="width: 372px; zoom: 1; display: list-item; background-color: white; margin-right: -1px; background-position: initial initial; background-repeat: initial initial;" id="e9ab6e5c-96b2-448c-858d-a033dfd6b17a" class="gs_w" data-col="13" data-row="1" data-sizex="12" data-sizey="3"><oa:view column='FAWEN_CH_IDEA' table='OA_YL_FAWEN' title ='处（室）核稿：' style='border:0;width:90%; height: 60%; overflow: auto;'  /></li><li style="zoom: 1; display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;" id="beef096b-447c-40d1-b980-f2330b3ca224" class="gs_w" data-col="25" data-row="1" data-sizex="6" data-sizey="3">oa_beef096b-447c-40d1-b980-f2330b3ca224</li><li style="width: 372px; zoom: 1; display: list-item; background-color: white; margin-right: -1px; background-position: initial initial; background-repeat: initial initial;" id="2ddecacd-0f0f-404d-bdb1-756e18a12ff3" class="gs_w" data-col="13" data-row="4" data-sizex="12" data-sizey="3"><oa:view column='FAWEN_HG_IDEA' table='OA_YL_FAWEN' title ='核稿:：' style='border:0;width:90%; height: 60%; overflow: auto;'  /></li><li style="zoom: 1; display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;" id="8276a908-c1e7-4f75-bbc0-f66b32ff280d" class="gs_w" data-col="25" data-row="4" data-sizex="6" data-sizey="3">oa_8276a908-c1e7-4f75-bbc0-f66b32ff280d</li><li style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id="9565de67-8c5d-4d7c-b559-9d8d193dac7a" class="gs_w" data-col="1" data-row="9" data-sizex="24" data-sizey="1"><oa:input title='主        送：' type='text' column='FAWEN_ZS' table='OA_YL_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></li><li style="zoom: 1; display: list-item; background-color: white; position: absolute; background-position: initial initial; background-repeat: initial initial;" id="386d2ceb-31d6-4abd-87fc-6c3c817096f9" class="gs_w" data-col="25" data-row="11" data-sizex="6" data-sizey="1">oa_386d2ceb-31d6-4abd-87fc-6c3c817096f9</li><li style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id="4c5caa44-c645-4215-a9c7-bb15768a9791" class="gs_w" data-col="1" data-row="10" data-sizex="24" data-sizey="1"><oa:input title='抄        送：' type='text' column='FAWEN_CS' table='OA_YL_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></li><li style="zoom: 1; display: list-item; background-color: white; position: absolute; background-position: initial initial; background-repeat: initial initial;" id="b272a191-e682-4a23-aeaa-8ff6d2c28375" class="gs_w" data-col="25" data-row="10" data-sizex="6" data-sizey="1">oa_b272a191-e682-4a23-aeaa-8ff6d2c28375</li><li style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id="9aaa84e0-99f3-447d-b0af-b903dc1496eb" class="gs_w" data-col="1" data-row="11" data-sizex="12" data-sizey="1"><oa:input title='拟稿单位：' type='text' column='FAWEN_UNIT' table='OA_YL_FAWEN' style= 'width: 80%;border: 0px;line-height:26px; height:26px;' value = '<%=unit_name%>'/></li><li style="zoom: 1; display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;" id="acee9f1a-b781-4b35-a1d7-b7afecd258de" class="gs_w" data-col="13" data-row="11" data-sizex="12" data-sizey="1"><oa:input title='拟稿人' type='text' column='FAWEN_MAN' table='OA_YL_FAWEN' style= 'width: 80%;border: 0px;line-height:26px; height:26px;' value = '<%=user_name%>'/></li><li style="zoom: 1; display: list-item; background-color: white; position: absolute; background-position: initial initial; background-repeat: initial initial;" id="fc8f831f-dcf4-4d7d-9b04-334224dffaff" class="gs_w" data-col="25" data-row="9" data-sizex="6" data-sizey="1"><span style='font-size: 20px; color: #ff0000; padding-left: 43%; line-height: 30px;'> </span></li><li style="FILTER: ; ZOOM: 1; DISPLAY: list-item; BACKGROUND: white" id="e511cb5c-7ed3-4475-818c-6e1205b04a2e" class="gs_w" data-col="1" data-row="12" data-sizex="24" data-sizey="1"><oa:input title='文件标题：' type='text' column='FAWEN_TITLE' table='OA_YL_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></li><li style="zoom: 1; display: list-item; position: absolute; background-color: white; background-position: initial initial; background-repeat: initial initial;" id="46601661-b1b0-4b6a-8d62-781d77a091e6" class="gs_w" data-col="25" data-row="13" data-sizex="6" data-sizey="1">oa_46601661-b1b0-4b6a-8d62-781d77a091e6</li><li style="zoom: 1; display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;" id="00c36616-534e-4252-982c-aaa78256a064" class="gs_w" data-col="1" data-row="13" data-sizex="24" data-sizey="1"><oa:input title='主  题  词：' type='text' column='FAWEN_ZTC' table='OA_YL_FAWEN' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></li><li style="zoom: 1; display: list-item; background-color: white; position: absolute; background-position: initial initial; background-repeat: initial initial;" id="e7b3bf8a-8428-491f-9946-6b1ab26a08cf" class="gs_w" data-col="25" data-row="12" data-sizex="6" data-sizey="1">oa_e7b3bf8a-8428-491f-9946-6b1ab26a08cf</li>			<li id="a1060c4c-99f2-4317-b364-e4084d823f96" data-col="1" data-row="14" data-sizex="24" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:affixbut butName='请选择文件' column='FAWEN_FJ' table='OA_YL_FAWEN'  title ='请选择文件：' /> </li><li id="50201562-3ac3-4940-85a8-714e1722514f" data-col="25" data-row="14" data-sizex="6" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;">oa_50201562-3ac3-4940-85a8-714e1722514f</li><li id="7620ead6-b09f-441b-a828-8301035ed3cb" data-col="1" data-row="15" data-sizex="24" data-sizey="1" class="gs_w" style="display: list-item; background-color: white; background-position: initial initial; background-repeat: initial initial;"><oa:affixshow  title ='附件列表：'/></li><li id="37d5325f-0dfa-45fc-b9e3-f4e6d9442d47" data-col="25" data-row="15" data-sizex="6" data-sizey="1" class="gs_w" style="display: list-item;">oa_37d5325f-0dfa-45fc-b9e3-f4e6d9442d47</li>
			<li id="363777dd-0758-4796-b9d7-0b0053f0b54e" data-col="13" data-row="8" data-sizex="18" data-sizey="1" class="gs_w player-revert" style="display: list-item; position: absolute; background-color: white; background-position: initial initial; background-repeat: initial initial;">oa_363777dd-0758-4796-b9d7-0b0053f0b54e</li>
					</ul>
			    </div>		
				</section>
			</article>
		</div>
				<div id="tabs-3">
			<oa:webtext column="FAWEN_ZW" table="OA_YL_FAWEN"/>
		</div>	
		</div>	    		
<div style="height:50px">
</div>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</form>
</body>
</oa:init>
</html>
