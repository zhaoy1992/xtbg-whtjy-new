<%--
描述：设备政府采购验收界面
作者：童佳
版本：1.0
日期：2014-03-03
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.impl.DevEquipmentaccServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.device.service.DevEquipmentaccService"%>
<%@page import="antlr.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	//当前用户信息
	String user_id = accesscontroler.getUserID();
	String user_name = accesscontroler.getUserName();
	//当前用户机构
	String org_id = accesscontroler.getChargeOrgId();
	String orgName = accesscontroler.getChargeOrgName();
	//录入时间
	String r_creater_time = DateUtil.getCurrentDateTime();
	//环节ID
	String action_defid = StringUtil.deNull(request.getParameter("action_defid"));
	//父界面行ID
	String tr_id = StringUtil.deNull(request.getParameter("tr_id"));
	//主键ID
	String t_id  = StringUtil.deNull(request.getParameter("t_id"));
	//验收采购单业务
	DevEquipmentaccService devequipmentaccservice = new DevEquipmentaccServiceImpl();
	Map<String,String> bean = new HashMap<String,String>();//验收单信息
	bean = devequipmentaccservice.getDevEquipmentaccBean(t_id);
	
	//流程环节中的采购验收单信息
	String devquipmentaccVo = DataControlUtil.pageUnEscape(StringUtil.deNull(request.getParameter("devquipmentaccVo")));
	//设置保存按钮是否显示
	String isShow = StringUtil.deNull(request.getParameter("isShow"));

	// 选择设备按钮控制
	String buttonString = "fasle";
	//第一,二个环节显示【设备选择】按钮
	if(action_defid.equals("sbzfcgys_wp1_act1")||action_defid.equals("sbzfcgys_wp1_act2")){
		buttonString = "true";
	}
	//第三，四个环节不能 修改信息
	if(action_defid.equals("sbzfcgys_wp1_act3")||action_defid.equals("sbzfcgys_wp1_act4")){
		isShow = "true";
	}
	
%>
	<!-- 公共部分开始 -->
	<title>设备政府采购验收</title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">jQuery.noConflict();</script>
	<!-- 引入jQuery UI -->
	<!-- 引入其它 -->
	<script src="<%=path %>/ccapp/oa/resources/util/public.js" type="text/javascript"></script>
	<script src="<%=path %>/ccapp/oa/resources/js/common/commoncss.js" type="text/javascript"></script>
	<script src="<%=path %>/ccapp/oa/resources/util/jsonutil.js" type="text/javascript"></script>
	<!-- 引入jQuery_dialog -->
	<script src="<%=path %>/ccapp/oa/resources/plug/jquery_dialog/jquery_dialog.js"></script>
	<!-- 引入上传控件 -->
	<link rel="stylesheet" href="<%=path %>/ccapp/oa/resources/plug/fancyupload/fancyupload.css" type="text/css" />
	<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
	<!-- 引入公共JS -->
	<!-- 引入formvValidatetion -->
	<script src="<%=path %>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
	<script src="<%=path %>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
	<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script src="<%=path %>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<script src="<%=path %>/ccapp/oa/resources/util/inputideaarea.js" type="text/javascript"></script>
	
	<script type='text/javascript'>
		var action_defid ="<%=action_defid%>";//环节
		var isShow = "<%=isShow%>";//是否显示保存按钮
		var t_id ="<%=t_id%>";//主键ID
		var devequiactVo = '<%=devquipmentaccVo.replaceAll("'","\"")%>';//采购验收信息
		/*
		函数:  openDevAppLicationList
		说明:  选择仪器设备物品
		参数:   无
		返回值: 无
		*/
	    function openDevAppLicationList(){
	    	var path ="<%=path%>/ccapp/xtbg/tjy/device/jsp/devapplicationlist.jsp?windowsId=windowIds1";
	    	openAlertWindows('windowIds1',path,'已办结采购申请',810,400,'25%','25%');
	    }
		
	    /*
		函数:  openDevAppLicationList
		说明:  选择仪器设备物品
		参数:   sbname:设备名称      ggno：规格编号         factory：出产厂
		返回值: 无
		*/
		function setSBinfo(sbname,ggno,factory,item_plainid,price){
			jQuery("#t_sbname").val(sbname);
			jQuery("#t_ggno").val(ggno);
			jQuery("#t_factory").val(factory);   
			jQuery("#item_id").val(item_plainid);
			//采购申请中预算价格
			jQuery("#price").val(price);
		}
	    
	    jQuery(function(){
	    	//控制按钮 只有在新增的流程时才显示
	    	if('fasle' == '<%=buttonString%>'){      
	    		jQuery("#choseSB").hide();
	    	}
	    	//环节判断 第一环节
	    	if("sbzfcgys_wp1_act1"==action_defid){
	    		//显示设备责任工程师意见
	    		jQuery("#btnsbzrgcs_yj").show();
	    		
	    	} else if("sbzfcgys_wp1_act2"==action_defid){
	    		//显示分院技术负责人意见按钮
	    		jQuery("#btnfyjsfzr_yj").show();
	    	}
	    	
	    	//是否显示保存按钮
	    	if("true"==isShow){
	    		jQuery("#sel").hide();
	    		jQuery("input[type=text]").attr("readonly","readonly");
	    		jQuery("textarea").attr("readonly","readonly");
	    	}
	    	
	    	//显示流程中采购信息
	    	if(devequiactVo!=""){
	    		var devequiactVotemp = eval('('+devequiactVo+')');
	    		jQuery.each(devequiactVotemp, function(id, value){
	    			jQuery("#"+id).val(value + "");
			    });
	    		//设备责任工程师意见
	    		jQuery("#TA_OA_DEVEQUIPMENTACC__T_SBZRGCS_YJ").val(changeTextareaChar2n(devequiactVotemp.t_sbzrgcs_yj));
	    		//分院技术负责人意见
	    		jQuery("#TA_OA_DEVEQUIPMENTACC__T_FYJSFZR_YJ").val(changeTextareaChar2n(devequiactVotemp.t_fyjsfzr_yj));
	    	}
	    });
	</script>

</head>
<body style="overflow-x:auto;" class="vcenter">
<form id="form1" name="form1" action="" method="post" >
	<input type="hidden" id="t_id"  name="t_id"  value="<%=t_id %>" /> 
	<input type="hidden" id="action_defid" name="action_defid"  value="<%=action_defid%>"/>
    <input type="hidden" id="item_id" name="item_id" value="<%=StringUtil.deNull(bean.get("item_id"))%>" />
    <input type="hidden" id="tr_id" name="tr_id" value="<%=tr_id %>" />
    
<div id="tabs1" style="width:99%;">
	<div id="tabs-1">
		<table width="95%" border="0" cellspacing="1" cellpadding="0"
			style="margin-left: 15px; display: inline;">
			<tr>
				<td>
					<input class="but_y_01" style="margin-left: 15px;margin-top: 15px;" type="reset" id="resert" value="关闭" onclick="closed()" />
					<input class="but_y_01" style="margin-top: 15px;" type="button" id="sel" name="sel" value="保存" onclick="Ok()"/>
				</td>
			</tr>
			<tr>
			<td style="padding-bottom: 10px;">
	<%-- 主表单 begin---%>
	<div class="vcenter" style="float: left; overflow-x: hidden;" scrolling="yes">
			<div style="float: left; width: 996px;">
			<%--shang--%>
			<div class="content_02_box" style="width:998px;">
				<div class="content_02_box_title_bg" style="width: 98%;">
					<span>采购验收表</span>
				</div>
				<div class="content_02_box_div" style="width: 996px;">
					<table border="0" cellspacing="0" cellpadding="0"
						class="content_02_box_div_table" style="width: 98%;">
						<tr><%--row2--%>
							<th class="content_02_box_div_table_th" colspan="2">设备名称：</th>
							<td class="content_02_box_div_table_td" colspan="2">
								<input type="text" id="t_sbname"  value="<%=StringUtil.deNull(bean.get("t_sbname"))%>"
										class="input_cx_title_240 validate[maxSize[100]]" style="width: 170px;"/>
								<input type="button" value="选择设备" style="margin-left: 5px;" class='but_y_01' id="choseSB" onclick="openDevAppLicationList();"/>
							</td>
							<th class="content_02_box_div_table_th">规格型号：</th>
							<td class="content_02_box_div_table_td">
								<input
										type="text" id="t_ggno" value="<%=StringUtil.deNull(bean.get("t_ggno"))%>"
										class="input_cx_title_240 validate[maxSize[100]]"/>
							</td>
						</tr>
						<tr><%--row3--%>
							<th class="content_02_box_div_table_th" colspan="2">生产厂：</th>
							<td class="content_02_box_div_table_td" colspan="2">
								<input
										type="text" id="t_factory"  value="<%=StringUtil.deNull(bean.get("t_factory"))%>"
										class="input_cx_title_240 validate[maxSize[200]]"/>
							</td>
							<th class="content_02_box_div_table_th">出厂编号：</th>
							<td class="content_02_box_div_table_td">
								<input
										type="text" id="t_ccno"  value="<%=StringUtil.deNull(bean.get("t_ccno"))%>"
										class="input_cx_title_240 validate[maxSize[100]]"/>
							</td>
						</tr>
						<tr><%--row4--%>
							<th class="content_02_box_div_table_th" colspan="2">到货日期：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<input type="text" value="<%=StringUtil.deNull(bean.get("t_dhdate"))%>" class='validate[required] date_120 Wdate' style='height:22px;line-height: 22px;float:left;margin-top:3px;'
										 id="t_dhdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
							</td>
							<!-- <th class="content_02_box_div_table_th" >数量：</th>
							<td class="content_02_box_div_table_td" >
								<input  id="t_sl" readonly="readonly" type="text" value="1" 
										 class='input_cx_title_240 validate[required,maxSize[100]]'   />
							</td> -->
						</tr>
						<tr ><%--row5--%>
							<th class="content_02_box_div_table_th" rowspan="15">验收记录：</th>
						</tr>
						
						<%--验收情况 start --%> 
						<tr><%--row1--%>
							<th class="content_02_box_div_table_th">验收内容：</th>
							<th class="content_02_box_div_table_th" align="right" style="text-align:center;" colspan="4">
								验收情况 
							</th>
						</tr>
						<tr><%--row2--%>
							<th class="content_02_box_div_table_th">外观：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<input
										type="text" id="t_wg"  value="<%=StringUtil.deNull(bean.get("t_wg"))%>" 
										class="input_cx_title_240 validate[maxSize[100]]" />
							</td>
						</tr>
						<tr><%--row3--%>
							<th class="content_02_box_div_table_th">合格证或质证书：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<input type="text" id="t_hgzorzzs" value="<%=StringUtil.deNull(bean.get("t_hgzorzzs"))%>" 
										class="input_cx_title_240 validate[maxSize[100]]" />
							</td>
						</tr>
						<tr><%--row4--%>
							<th class="content_02_box_div_table_th">设备清单或项目明细：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<input type="text" id="t_sbqd"  value="<%=StringUtil.deNull(bean.get("t_sbqd"))%>" 
										class="input_cx_title_240 validate[maxSize[100]]" />
							</td>
						</tr>
						<tr><%--row5--%>
							<th class="content_02_box_div_table_th">设备使用说明书：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<input type="text" id="t_sbsysms"  value="<%=StringUtil.deNull(bean.get("t_sbsysms"))%>" 
										class="input_cx_title_240 validate[maxSize[100]]" />
							</td>
						</tr>
						<tr><%--row6--%>
							<th class="content_02_box_div_table_th">设备安装说明书：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<input
										type="text" id="t_sbazsms" value="<%=StringUtil.deNull(bean.get("t_sbazsms"))%>" 
										class="input_cx_title_240 validate[maxSize[100]]" />
							</td>
						</tr>
						<tr><%--row7--%>
							<th class="content_02_box_div_table_th">产品合格证：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<input
										type="text" id="t_cphgz" value="<%=StringUtil.deNull(bean.get("t_cphgz"))%>" 
										class="input_cx_title_240 validate[maxSize[100]]" />
							</td>
						</tr>
						<tr><%--row8--%>
							<th class="content_02_box_div_table_th">质量证明书：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<input
										type="text" id="t_zlsms" value="<%=StringUtil.deNull(bean.get("t_zlsms"))%>" 
										class="input_cx_title_240 validate[maxSize[100]]" />
							</td>
						</tr>
						<tr><%--row9--%>
							<th class="content_02_box_div_table_th">检定、测试报告：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<input
										type="text" id="t_jdcsba" value="<%=StringUtil.deNull(bean.get("t_jdcsba"))%>" 
										class="input_cx_title_240 validate[maxSize[100]]" />
							</td>
						</tr>
						<tr><%--row10--%>
							<th class="content_02_box_div_table_th">配件或辅件：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<input
										type="text" id="t_pzorfj" value="<%=StringUtil.deNull(bean.get("t_pzorfj"))%>" 
										class="input_cx_title_240 validate[maxSize[100]]" />
							</td>
						</tr>
						<tr><%--row11--%>
							<th class="content_02_box_div_table_th">与合同要求：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<input
										type="text" id="t_yhtyq" value="<%=StringUtil.deNull(bean.get("t_yhtyq"))%>" 
										class="input_cx_title_240 validate[maxSize[100]]" />
							</td>
						</tr>
						<tr><%--row12--%>
							<th class="content_02_box_div_table_th">其他：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<textarea  id="t_other" 
										class="validate[maxSize[500]]"  
										style='border: 1;width:50%; height: 80px; overflow: auto;'><%=StringUtil.deNull(bean.get("t_other"))%></textarea> 
							</td>
						</tr>
						<tr><%--row13--%>
							<th class="content_02_box_div_table_th">安装调试或试用情况：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<textarea
										id="t_aztsqk"  style='border: 1;width:50%; height: 80px; overflow: auto;'
										class="validate[maxSize[1500]]" ><%=StringUtil.deNull(bean.get("t_aztsqk"))%></textarea> 
							</td>
						</tr>
						<tr><%--row14--%>
							<th class="content_02_box_div_table_th">验收结论：</th>
							<td class="content_02_box_div_table_td" colspan="4">
								<textarea  style='border: 1;width:50%; height: 80px; overflow: auto;'
										id="t_ysjl" 
										class="validate[maxSize[1000]]" ><%=StringUtil.deNull(bean.get("t_ysjl"))%></textarea> 
							</td>
						</tr>
						<%--验收情况 end --%> 
						<tr><%--row6--%>
							<th class="content_02_box_div_table_th" colspan="2">供方验收人：</th>
							<td class="content_02_box_div_table_td" colspan="2">
								<input
										type="text" id="t_gfysr" value="<%=StringUtil.deNull(bean.get("t_gfysr"))%>"
										class="input_cx_title_240 validate[maxSize[25]]" />
							</td>
							<th class="content_02_box_div_table_th">供方验收人签字时间：</th>
							<td class="content_02_box_div_table_td">
								<input id="t_gfysr_date" value="<%=StringUtil.deNull(bean.get("t_gfysr_date"))%>"  class="date_120 Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style='height:22px;line-height: 22px;float:left;margin-top:3px;'
								    />
							</td>
						</tr>
						
					</table>
				</div>
			</div>
			
			<!--审核意见DIV-->
			 <div class="content_02_box" style="width: 996px;"  >
			 <div class="content_02_box_title_bg" style="width: 98%;">
					<span>验收审核意见</span>
				</div>
			 	  <table width="98%">
			 	  	<tr>
			 	  		<td class="content_02_box_div_table_td">
						 	<span style="float: left;">本院验收人员</span>
						</td>
						<td class="content_02_box_div_table_td">
							 <span style="float: left;">设备责任工程师意见：</span>
							 <br>
							 <input type='button' id="btnsbzrgcs_yj" style="display: none;" class='but_y_01'  value='填写意见' onclick="inputidea('TA_OA_DEVEQUIPMENTACC','T_SBZRGCS_YJ','null')" />
							 <textarea readonly='readonly' name='TA_OA_DEVEQUIPMENTACC__T_SBZRGCS_YJ' id='TA_OA_DEVEQUIPMENTACC__T_SBZRGCS_YJ'  style='border: 1;width:99%;overflow: auto;'   style= 'border: 1;width:99%;overflow: auto;'class='validate[maxSize[1000]] textarea_556'><%=StringUtil.deNull(bean.get("t_sbzrgcs_yj"))%></textarea>
							 <input name='YJ__TA_OA_DEVEQUIPMENTACC__T_SBZRGCS_YJ' id='YJ__TA_OA_DEVEQUIPMENTACC__T_SBZRGCS_YJ' type='hidden' />
							 <input name='HIS__TA_OA_DEVEQUIPMENTACC__T_SBZRGCS_YJ' id='HIS__TA_OA_DEVEQUIPMENTACC__T_SBZRGCS_YJ' value = '<%=StringUtil.deNull(bean.get("t_sbzrgcs_yj"))%>' type='hidden' />
						</td>
						<td class="content_02_box_div_table_td">
							 <span style="float: left;">分院技术负责人意见：</span>
						 	 <br>
							 <input type='button' id="btnfyjsfzr_yj" style="display: none;" class='but_y_01'  value='填写意见' onclick="inputidea('TA_OA_DEVEQUIPMENTACC','T_FYJSFZR_YJ','null')" />
							 <textarea readonly='readonly' name='TA_OA_DEVEQUIPMENTACC__T_FYJSFZR_YJ' id='TA_OA_DEVEQUIPMENTACC__T_FYJSFZR_YJ'  style='border: 1;width:99%;overflow: auto;'   style= 'border: 1;width:99%;overflow: auto;'class='validate[maxSize[1000]] textarea_556'><%=StringUtil.deNull(bean.get("t_fyjsfzr_yj"))%></textarea>
							 <input name='YJ__TA_OA_DEVEQUIPMENTACC__T_FYJSFZR_YJ' id='YJ__TA_OA_DEVEQUIPMENTACC__T_FYJSFZR_YJ' type='hidden' />
							 <input name='HIS__TA_OA_DEVEQUIPMENTACC__T_FYJSFZR_YJ' id='HIS__TA_OA_DEVEQUIPMENTACC__T_FYJSFZR_YJ' value = '<%=StringUtil.deNull(bean.get("t_fyjsfzr_yj"))%>' type='hidden' />
						</td>		
					</tr>
					
				 </table>
			</div>
			<!--审核意见DIV END-->
			</div>
			</div>
			<%-- 主表单 end---%>
			</td>
			</tr>
		</table>
	</div>
</div>	
</form>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
<script language="javascript" type="text/javascript">
	/*
	函数:  Ok
	说明:  保存 把数据拼接成json窜返回给结算单中
	参数:   
	返回值: 无
	*/
	function Ok(){
		
		var devequipvo = {
			"tr_id": delSpace(jQuery('#tr_id').val()), //父界面行ID
			"t_id": "<%=t_id %>", //主键ID
			"t_sbname" :delSpace(jQuery('#t_sbname').val()),//设备名称
			"t_ggno" :delSpace(jQuery("#t_ggno").val()),//规格型号
			"t_factory" :delSpace(jQuery("#t_factory").val()),//生产厂
			"t_ccno" :delSpace(jQuery("#t_ccno").val()),//出厂编号
			"t_dhdate" :delSpace(jQuery("#t_dhdate").val()),//到货日期
			"t_wg" :delSpace(jQuery("#t_wg").val()),//外观
			"t_hgzorzzs" :delSpace(jQuery("#t_hgzorzzs").val()),//合格证或质证书
			"t_sbqd" :delSpace(jQuery("#t_sbqd").val()),//设备清单或项目明细
			"t_sbsysms" :delSpace(jQuery("#t_sbsysms").val()),//设备使用说明书
			"t_sbazsms" :delSpace(jQuery("#t_sbazsms").val()),//设备安装说明书
			"t_cphgz" :delSpace(jQuery("#t_cphgz").val()),//产品合格证
			"t_zlsms" :delSpace(jQuery("#t_zlsms").val()),//质量证明书
			"t_jdcsba" :delSpace(jQuery("#t_jdcsba").val()),//检定、测试报告
			"t_pzorfj" :delSpace(jQuery("#t_pzorfj").val()),//配件或辅件
			"t_yhtyq" :delSpace(jQuery("#t_yhtyq").val()),//与合同要求
			"t_other" :delSpace(jQuery("#t_other").val()),//其他
			"t_aztsqk" :delSpace(jQuery("#t_aztsqk").val()),//安装调试或试用情况
			"t_ysjl" :delSpace(jQuery("#t_ysjl").val()),//验收结论
			"t_gfysr" :delSpace(jQuery("#t_gfysr").val()),//供方验收人
			"t_gfysr_date" :delSpace(jQuery("#t_gfysr_date").val()),//供方验收人签字时间
			"t_byysr_yj" :delSpace(jQuery("#t_byysr_yj").val()),//本院验收人员意见
			"t_sbzrgcs_yj" :changeTextareaChar2special(delSpace(jQuery("#TA_OA_DEVEQUIPMENTACC__T_SBZRGCS_YJ").val())),//设备责任工程师意见
			"t_fyjsfzr_yj" :changeTextareaChar2special(delSpace(jQuery("#TA_OA_DEVEQUIPMENTACC__T_FYJSFZR_YJ").val())),//分院技术负责人意见
			"t_sb_id" :delSpace(jQuery("#t_sb_id").val()),//设备id
			"item_id" :delSpace(jQuery("#item_id").val()),//申请明细表ID
			"t_sl" :"1"//数量
		}
		 var parentObject = getParentWindow('windowId2');
		 parentObject.setDevEquimentaccInfo(devequipvo);
		 removeAlertWindows('windowId2',true,true,'',false,'','');
	}
	
	/*
	函数:  closed
	说明:  关闭界面
	参数:   
	返回值: 无
	*/
	function closed(){
		removeAlertWindows('windowId2',true,true,'',false,'','');
	}
	
</script>
</body>
</html>

