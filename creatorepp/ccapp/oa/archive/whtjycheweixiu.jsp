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
<%@page import="java.util.List" %> 
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.entity.CarEditInfoBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.CarEditInfoService"%>
<%@page import="com.chinacreator.xtbg.yimingju.carmanage.service.impl.CarEditInfoServiceImpl"%>       

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String windowsId = request.getParameter("windowsId");
String drag_in_title = "";
String drag_in_attach = "";
String drag_in_webtext = "";
FlowMoveBean fmb = new FlowMoveBean(request);
//正文通过JS搞定
if(fmb.isFlowInFlow()){
String fmb_config = "1,1,1";
fmb_config = (StringUtil.nullOrBlank(fmb_config))?"1,1,1":fmb_config;
String[] fmb_config_arr = fmb_config.split(",");
if(fmb_config_arr[1].equals("1")){
 drag_in_title = request.getParameter("flowTitle");
}
if(fmb_config_arr[2].equals("1")){
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
CarEditInfoService editServicel = new CarEditInfoServiceImpl();

String action_defid = request.getParameter("action_defid");
String busi_id = request.getParameter("busi_id")!=null?request.getParameter("busi_id"):"";
%>


<!DOCTYPE html>
<html style="overflow-y:scroll;">
<head>
	<oa:init>
  <title>武汉特检院车辆维修</title>
    <script language="javascript" src="<%=path %>/ccapp/xtbg/resources/plug/Lodop/LodopFuncs.js"></script>
	<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
		<embed id="LODOP_EM" type="application/x-print-lodop" 
		width=0 height=0 pluginspage="<%=path %>/ccapp/xtbg/resources/plug/Lodop/install_lodop.exe"></embed>
	</object> 
  <script>
  jQuery(function(){ //DOM Ready
	initGridster();
	getCarList();
	
	var action_defid =  parms.flowParmJson.action_defid;
	if(action_defid != "clwx_wp1_act1"){
		jQuery(".tianjia").hide();
	}
	
	jQuery("#project_note").on("focusout",".pro_num,.think_price,.price",function(){
		var $tr = jQuery(this).parent().parent();
		var pro_num = $tr.find(".pro_num").val();
		var think_price = $tr.find(".think_price").val();
		var real_price = $tr.find(".price").val();
		var int_num = /^[0-9]*$/;
		var price = /^[0-9]+(.[0-9]{1})?$/;
		
		if(pro_num != "" && real_price != "" ){
			if(int_num.test(pro_num)!=true){
				alert("数目必须是整数");
				return false;
			}
			if(price.test(think_price)!=true){
				alert("预计单价是整数，或只能带有一位小数");
				return false;
			}
			$tr.find(".count_price").val(parseInt(pro_num)*parseFloat(real_price)); 
		}
		var count_num = 0;
		jQuery("#project_note").find(".pro_num").each(function(){
			count_num += parseInt($(this).value!=""?$(this).value:0);
		 });
		var count_think_price = 0.0;
		jQuery("#project_note").find(".think_price").each(function(){
			count_think_price += parseFloat(($(this).value!=""?$(this).value:0.0));
		 });
		jQuery("#count_think_price").val(count_think_price);
		jQuery("#count_pro_num").val(count_num);
		
		var count_price = 0.0;
		jQuery("#project_note").find(".price").each(function(){
			count_price += parseFloat(($(this).value!=""?$(this).value:0.0));
		 });
		jQuery("#count_price").val(count_price);
		
		var sum_price = 0.0;
		jQuery("#project_note").find(".count_price").each(function(){
			if(price.test($(this).value)!=true){
				alert("实际单价是整数，或只能带有一位小数");
				return false;
			}
			sum_price += parseFloat(($(this).value!=""?$(this).value:0.0));
			
		 });
		jQuery("#sum_price").val(sum_price);
		
	});
});
//.do页面的回调函数，将验证框架里的isSubmit重置，用来防止提交失败后再提交失效。
function resetSubmit(){
	jQuery("#form1").resetSubmit(false);
}
var path = "<%=path %>";
function initGridster(){
   }
   
function initPageObj(){
	jQuery("#print_table").hide();
	jQuery("#"+jQuery("#field_drag_in_title").val()).focus();
   }
   
function getCarList(){
	var car_id = "<%=busi_id %>";
	jQuery.ajax({
		url:path+"/ccapp/oa/archive/whtjycheliangguanlido.jsp",
		data:{"method":"getCarList","car_id":car_id,"tableName":"TA_OA_WHTJY_CHEWEIXIU"},
		type:'post',dataType:'json',
		contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		success:function(data){
			if(data){//成功
				jQuery("#TA_OA_WHTJY_CHEWEIXIU__CAR_INFO").append(data.result);
			}
		}
	});
}  

/**
 * 添加行
 */
function Add_table_rows(){
	var add_row = "<tr id ='dayrow' name='dayrow'>"
					+ "<td><input type='text' class='sequencId' name='sequencId' readonly='readonly' style='text-align: center;' /></td>"
					+ "<td><input type='text' class='pro_name' name='pro_name'></td>"
					+ "<td><input type='text' class='pro_num' name='pro_num'></td>"
					+ "<td><input type='text' class='pro_unit' name='pro_unit'></td>"
					+ "<td><input type='text' class='think_price' name='think_price'></td>"
					+ "<td><input type='text' class='price' name='price'></td>"
					+ "<td><input type='text' class='count_price' readonly='readonly' name='count_price'></td>"
					+ "<td><input type='text' class='remark' name='remark'></td>"
					+ "<td style='border-right:none;'><a onclick='del_table_row(this);'><img src='ccapp/xtbg/resources/images/del.gif' class='x'/>删除</a></td>";
				+ "</tr>";
	
	jQuery("#project_note tr").last().before(add_row);
	
	//序号 赋值
	var newTrsize= jQuery("#project_note").find("tr[name=dayrow]").size();
	for(var i=0;i<newTrsize;i++){
		jQuery("#project_note").find("tr[name=dayrow]").eq(i).find("input[name=sequencId]").val(i+1);
	}
}

/**
 * 删除行
 */
function del_table_row(tag){
	var intable=jQuery(tag).parents("table");
	var tr=jQuery(tag).parents("tr").first();
	var trsize= jQuery(intable).find("tr[name=dayrow]").size();
	if(trsize==1){
		jQuery(tr).remove();
	}else{
		jQuery(tr).remove();
	}
	var newTrsize= jQuery(intable).find("tr[name=dayrow]").size();
	for(var i=0;i<newTrsize;i++){
		jQuery(intable).find("tr[name=dayrow]").eq(i).find("input[name=sequencId]").val(i+1);
	}
}

function save_note(){
// 	jQuery("#dayrowhidden").remove();
	var busi_id = jQuery("#busi_id").val();
	var pro_name = jQuery("input[name=pro_name]");
	var pro_num = jQuery("input[name=pro_num]");
	var pro_unit = jQuery("input[name=pro_unit]");
	var think_price = jQuery("input[name=think_price]");
	var price = jQuery("input[name=price]");
	var count_price = jQuery("input[name=count_price]");
	var remark = jQuery("input[name=remark]");
	if(busi_id!=null){
		if(pro_name.length>0){
			var is_exit = true;
			for(var i=0;i<pro_name.length;i++){
				if(pro_name[i].value.length==0){
					alert("维修保养项目必须填写！");
					is_exit = false;
					return false;
				}
				if(pro_num[i].value.length==0){
					alert("数量必须填写！");
					is_exit = false;
					return false;
				}
				if(pro_unit[i].value.length==0){
					alert("单位必须填写！");
					is_exit = false;
					return false;
				}
				if(think_price[i].value.length==0){
					alert("预计单价必须填写！");
					is_exit = false;
					return false;
				}
				if(price[i].value.length==0){
					alert("实际单价必须填写！");
					is_exit = false;
					return false;
				}
				if(is_exit){
					save_edit_info(busi_id,pro_name[i].value,pro_num[i].value,pro_unit[i].value,
							think_price[i].value,price[i].value,count_price[i].value,remark[i].value);
				}
			}
			return true;
		}else{
			return false;
		}
	}
}

/**
 * 保存数据
 */
function save_edit_info(busi_id,pro_name,pro_num,pro_unit,think_price,price,count_price,remark){
	jQuery.ajax({
		url:path+"/ccapp/oa/archive/whtjycheliangguanlido.jsp",
		data:{
			"method":"editinsert",
			"car_id":busi_id,
			"pro_name":pro_name,
			"pro_num":pro_num,
			"pro_unit":pro_unit,
			"think_price":think_price,
			"price":price,
			"count_price":count_price,
			"remark":remark
		},
		type:'post',dataType:'json',
		contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		success:function(data){
			if(data){
				
			}
		}
	});
}

function del_edit_info(){
	var busi_id = jQuery("#busi_id").val();
	jQuery.ajax({
		url:path+"/ccapp/oa/archive/whtjycheliangguanlido.jsp",
		data:{
			"method":"editdelete",
			"car_id":busi_id
		},
		type:'post',dataType:'json',
		contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		success:function(data){
			if(data){
				save_note();
			}
		}
	});
}

function onkeydownorup(input_name){
	
}


//点击完成
var afterActionSuccessFn=function(){
	getParentWindow('<%=windowsId%>').location.href = "<%=path%>/ccapp/xtbg/tjy/processing/mainhandlist.jsp";
	removeAlertWindows('<%=windowsId%>',true);
	
};
</script>
	
	<style>
/* 		body{ */
/* 			font-family: Helvetica, arial, sans-serif; */
/* 			margin:10px auto; */
/* 			color: #fff; */
/* 			font-size: 12px; */
/* 			width:931px; */
/* 			text-align:center; */
/* 		} */
		body{margin:0 auto; width:90%; font-size:14px;}
		input,div,font,span,h2,h1,h3,img,select,talbe{margin:0; padding:0; border:0;}
		a{text-decoration:none; color:#000;}
		a:hover{text-decoration:none; color:#000;}
		
		.biaoti{font-size:30px; margin-top:10px;}
		.small{margin-top:15px; margin-bottom:5px; font-size:20px;}
		.table_one{ border-left:#000 solid 1px; border-top:#000 solid 1px;}
		.table_one tr td{ border-right:#000 solid 1px; border-bottom:#000 solid 1px; padding:5px;}
		.nei{font-size:12px;}
		select{border:#999 solid 1px; width:200px;}
		.content_table{width:100%;}
		.tianxie{display:block; background:url(img/an.png) repeat-x; width:60px; font-size:12px; color:#fff; line-height:17px; height:17px; border:#387bb2 solid 1px; text-align:center;}
		.x{margin-right:5px;}
		.tianjia{float:right; margin-right:10px;}
</style>

</head>
<body >
<form id="form1" name="form1" action="" method="post">
<input id="busi_id" name="busi_id" type="hidden"/>
<input id="opt_type" name="opt_type" type="hidden"/>
<input id="busiTypeCode" name="busiTypeCode" type="hidden"/>
<input id="windowsId" name="windowsId" type="hidden" value="<%=windowsId %>"/>
<input id="action_defid" name="action_defid" type="hidden" value="<%=action_defid %>"/>
<oa:input type='hidden' column='USER_ID' table='TA_OA_WHTJY_CHEWEIXIU' value='<%=user_id%>' />
<oa:input type='hidden' column='USER_NAME' table='TA_OA_WHTJY_CHEWEIXIU' value='<%=user_name%>' />
<oa:input type='hidden' column='CREATED' table='TA_OA_WHTJY_CHEWEIXIU' value='<%=time%>' />
<oa:input type='hidden' column='ORG_ID' table='TA_OA_WHTJY_CHEWEIXIU' value='<%=unit_id%>' />
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
					<table border="0" cellpadding="0" cellspacing="0" width="100%" class="table_one">
						<tr>
							<td colspan="4" align="center" height="66" valign="middle">
								<div class="biaoti">湖北武汉特种设备检查检测研究院</div>
								<div class="small">车 辆 维 修 申 请</div>
							</td>
						</tr>
						
						<tr>
							<td width="150">申请人</td>
							<td><div class="nei"><oa:input title='' type='text' column='APPLICANT' table='TA_OA_WHTJY_CHEWEIXIU' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></div></td>
							<td>申请日期</td>
							<td><div class="nei"><oa:input title='' type='text' column='APPLICANT_DATE' table='TA_OA_WHTJY_CHEWEIXIU' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = '<%=time%>'/></div></td>
						</tr>
						
						<tr>
							<td>车辆信息</td>
							<td>
								<oa:select column='CAR_INFO' table='TA_OA_WHTJY_CHEWEIXIU' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' >
								</oa:select>
							</td>
							<td>类型</td>
							<td>
								<oa:select column='TYPE' table='TA_OA_WHTJY_CHEWEIXIU' style ='width: 50%;line-height:22px; height:22px;margin-top:3px;' title =''>
									<oa:option optionName='维修保养' optionValue='维修保养' />
									<!--<oa:option optionName='保养' optionValue='保养' /> -->
								</oa:select>
							</td>
						</tr>
						
						<tr>
							<td>申请标题</td>
							<td colspan="3"><oa:input title='' type='text' column='TITLE' table='TA_OA_WHTJY_CHEWEIXIU' style= 'width: 90%;border: 0px;line-height:26px; height:26px;' value = ''/></td>
						</tr>
						
						<tr>
							<td>维修保养内容</td>
							<td colspan="3">
								<oa:textarea title='' column='WEIXIUNEIRONG' table='TA_OA_WHTJY_CHEWEIXIU' style='border:0;width:99%; height: 60px; overflow: auto;' />
							</td>
						</tr>
						<tr>
							<td height="70" valign="top">财务部审核金额</td>
							<td colspan="3" valign="top"><oa:view column='PLAN_PRICE' table='TA_OA_WHTJY_CHEWEIXIU' title ='' style='border:0;width:99%; height: 60px; overflow: auto;' cntab='uuuu,tt' /></td>
						</tr>
						
						<tr>
							<td height="70" valign="top">后勤保障部负责人审核</td>
							<td colspan="2" valign="top">
								<oa:view column='LOGISTICS_SUPPORT' table='TA_OA_WHTJY_CHEWEIXIU' title ='' style='border:0;width:99%; height: 60px; overflow: auto;' cntab='uuuu,tt' />	
							</td>
							<td colspan="1" valign="top">
								<oa:view column='LOGISTICS_SUPPORT2' table='TA_OA_WHTJY_CHEWEIXIU' title ='' style='border:0;width:99%; height: 60px; overflow: auto;' cntab='uuuu,tt' />	
							</td>
						</tr>
						
						<tr>
							<td height="70" valign="top">分管院领导审批</td>
							<td colspan="3" valign="top"><oa:view column='PRESIDENT_OPINION' table='TA_OA_WHTJY_CHEWEIXIU' title ='' style='border:0;width:99%; height: 60px; overflow: auto;' cntab='uuuu,tt' /></td>
						</tr>
						
						<tr>
							<td height="70" valign="top">院长审批</td>
							<td colspan="3" valign="top"><oa:view column='LEAD_OPINION' table='TA_OA_WHTJY_CHEWEIXIU' title ='' style='border:0;width:99%; height: 60px; overflow: auto;' cntab='uuuu,tt' /></td>
						</tr>
						
					</table>
			    </div>		
				</section>
			</article>
		</div>
		</div>	    		
<div style="height:50px">
</div>
<IFRAME name=frame1 width=100% height=0> </IFRAME> 
</form>

<form id = "print_table">
<table  width="100%" id="form_print_shouwen" style="font-size:12pt;display:none; font-family:宋体;margin:0px; border-spacing: 0px; border-collapse: 0px;">
	<table style="border-collapse:collapse;background:#ffffff;padding:0px;color: #FF0000; margin: 0px;border: 1px solid #FF0000;font-size: 12pt;font-family:宋体;width:95%;" id="queryTable1" >
		<tr>
			<td align="center" colspan="10" >
				<span style="font-size:24pt; font-family:方正小标宋简体;color: red ;line-height: 30px;">湖北省特种设备检验检测研究院</span>
			</td>
		</tr>
		<tr >
		    <td width="15%"  colspan="2" align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
				<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					申请人
				</font>
		     </td>
		     <td width="35%"  colspan="3"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
		     	<oa:input title='' type='text' column='APPLICANT' table='TA_OA_WHTJY_CHEWEIXIU' style= 'width: 95%;border: 0px;line-height:26px; height:26px;' value = ''/>
		     </td>
		     <td width="15%"   colspan="2" align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
		     	<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					申请日期
				</font>
		     </td>
		     <td width="35%" colspan="3"    align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
				<oa:input title='' type='text' column='APPLICANT_DATE' table='TA_OA_WHTJY_CHEWEIXIU' style= 'width: 200px;border: 0px;line-height:26px; height:26px;float:left;'/>
		    </td>
		</tr>
        <tr >
        	<td width="15%"  colspan="2" align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
				<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					车辆信息
				</font>
		     </td>
		     <td width="35%"  colspan="3"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
				<input type='text' id="CAR_INFO" name="CAR_INFO" style= 'width: 95%;border: 0px;line-height:26px; height:26px;' value = ''/>
		     </td>
		     <td width="15%"   colspan="2" align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
				<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					类型
				</font>
		     </td>
		     <td width="35%" colspan="3"    align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
		     	<input type='text' id="TYPE" name="TYPE" style= 'width: 95%;border: 0px;line-height:26px; height:26px;' value = ''/>
		     </td>
       </tr>
       <tr>
       		<td width="15%"   colspan="2" align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
				<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					申请标题
				</font>
	        </td>
	        <td width="85%"  colspan="8"  align="left" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">	
				<oa:input title='' type='text' column='TITLE' table='TA_OA_WHTJY_CHEWEIXIU' style= 'width: 95%;border: 0px;line-height:26px; height:26px;' value = ''/>
	        </td>
       </tr>
       <tr>
	        <td width="7%"  colspan="1" align="center" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
				<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					维修<br>保养<br>内容	
				</font>
	        </td>
	        <td width="93%"   colspan="9" align="left" style="border:1px solid #FF0000; padding: 5px; color:#000000;vertical-align: top;">
	            <div id="aa" style="color:#000000;">
				</div>
			</td>
      </tr>
      <tr>
	       <td width="7%"  colspan="1" align="center" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
				<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					财务部<br>审核<br>金额
				</font>
	       </td>
	       <td width="93%"  id ="bb" colspan="9" align="left" style="border:1px solid #FF0000; padding: 5px; color:#000000;vertical-align: top;">
				<div id="bb" style="color:#000000;">
				</div>
	       </td>
      </tr>
	  <tr>
	      <td width="7%"  colspan="1" align="center" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
				<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					后勤<br>保障<br>部负<br>责人<br>审核
				</font>
	      </td>
	      <td width="46%"   colspan="5" align="left" style="border:1px solid #FF0000; padding: 5px; color:#000000;vertical-align: top;">
	           <div id="cc" style="color:#000000;">
			   </div>
	      </td>
	      <td width="46%"   colspan="4" align="left" style="border:1px solid #FF0000; padding: 5px; color:#000000;vertical-align: top;">
	           <div id="dd" style="color:#000000;">
			   </div>
	      </td>
     </tr>
     <tr >
	     <td width="7%"  colspan="1" align="center" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
			<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
				分管院<br>领导<br>审批
			</font>
	    </td>
	    <td width="93%"   colspan="9" align="left" style="border:1px solid #FF0000; padding: 5px; color:#000000;vertical-align: top;">
	        <div id="ee" style="color:#000000;">
			</div>
	    </td>
     </tr>
     <tr >
	       <td width="7%"  colspan="1" align="center" style="border:1px solid #FF0000; padding: 5px; color:#FF0000;vertical-align: top;">
				<font style='font-size: 18px; color: #ff0000; padding-left: 5%; line-height: 30px;'>
					院<br>长<br>审<br>批
				</font>
	      </td>
	      <td width="93%"  colspan="9" align="left" style="border:1px solid #FF0000; padding: 5px; color:#000000;vertical-align: top;">
	           <div id="ff" style="color:#000000;">
			   </div>
	      </td>
     </tr>
  </table>
</table>
</form>

</body>
</oa:init>
</html>
<script>jQuery(function(){ //DOM Ready
	initPageObj();
});

     var LODOP; //声明为全局变量 
	
	function prn_preview() {
		jQuery("#print_table").show();
		//车牌
		var car_number = jQuery("#TA_OA_WHTJY_CHEWEIXIU__CAR_INFO option:selected").text(); 
		jQuery("#CAR_INFO").val(car_number);
		
		//类型
		var TYPE = jQuery("#TA_OA_WHTJY_CHEWEIXIU__TYPE option:selected").text(); 
		jQuery("#TYPE").val(TYPE);
		
		var a = jQuery("#TA_OA_WHTJY_CHEWEIXIU__WEIXIUNEIRONG").val();
		if(IsSpace(a)){
			jQuery("#aa").css("height","80px");
		}else{
			jQuery("#aa").html(a.replaceAll('\n','<br>').replaceAll('\t','&nbsp;&nbsp;&nbsp;'));
		}
		
		var b = jQuery("#TA_OA_WHTJY_CHEWEIXIU__PLAN_PRICE").val();
		if(IsSpace(b)){
			jQuery("#bb").css("height","80px");
		}else{
			jQuery("#bb").html(b.replaceAll('\n','<br>').replaceAll('\t','&nbsp;&nbsp;&nbsp;'));
		}
		
		var c = jQuery("#TA_OA_WHTJY_CHEWEIXIU__LOGISTICS_SUPPORT").val();
		if(IsSpace(c)){
			jQuery("#cc").css("height","80px");
		}else{
			jQuery("#cc").html(c.replaceAll('\n','<br>').replaceAll('\t','&nbsp;&nbsp;&nbsp;'));
		}
				
		var d = jQuery("#TA_OA_WHTJY_CHEWEIXIU__LOGISTICS_SUPPORT2").val();
		if(IsSpace(a)){
			jQuery("#dd").css("height","80px");
		}else{
			jQuery("#dd").html(d.replaceAll('\n','<br>').replaceAll('\t','&nbsp;&nbsp;&nbsp;'));
		}
				
		var e = jQuery("#TA_OA_WHTJY_CHEWEIXIU__PRESIDENT_OPINION").val();
		if(IsSpace(e)){
			jQuery("#ee").css("height","80px");
		}else{
			jQuery("#ee").html(e.replaceAll('\n','<br>').replaceAll('\t','&nbsp;&nbsp;&nbsp;'));
		}
		
		var f = jQuery("#TA_OA_WHTJY_CHEWEIXIU__LEAD_OPINION").val();
		if(IsSpace(f)){
			jQuery("#ff").css("height","80px");
		}else{
			jQuery("#ff").html(f.replaceAll('\n','<br>').replaceAll('\t','&nbsp;&nbsp;&nbsp;'));
		}
		CreateOneFormPage();	
		LODOP.PREVIEW();	
		jQuery("#print_table").hide();
	};

	function CreateOneFormPage(){
		LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));  
		LODOP.PRINT_INIT("打印控件功能演示_Lodop功能_表单一");

		LODOP.SET_PRINT_STYLE("Bold",1);
		//LODOP.ADD_PRINT_TEXT(50,0,400,39,"");
		LODOP.ADD_PRINT_HTM("5mm",25,"RightMargin:0.1cm","BottomMargin:9mm",document.getElementById("print_table").innerHTML);
	};	
</script>
