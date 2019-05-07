<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.PurchaseApprovalRoolDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.PurchaseApprovalRoolDao"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.OfficeStockDaoImple"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.OfficeEquipmentTypeDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.dao.imploracle.OfficeConsumeTypeDaoImpl"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeStock"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeEquipmentTypeBean"%>
<%@page import="com.chinacreator.xtbg.yimingju.officeassets.entity.OfficeConsumeTypeBean"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort() + path + "/";
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response); 
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String time= format.format(new Date());
	String widowsid = request.getParameter("widowsid");
	String whatDo = request.getParameter("whatDo");
	
 	OfficeStock officeStock = new OfficeStock();
 	OfficeStockDaoImple OfficeStockDao = new OfficeStockDaoImple();
 	List<OfficeEquipmentTypeBean> equiList = null;
 	List<OfficeConsumeTypeBean> consList = null;
 	OfficeEquipmentTypeDaoImpl officeEquipmentTypeDao = new OfficeEquipmentTypeDaoImpl();
 	PurchaseApprovalRoolDao purchaseApprovalRoolDao=new PurchaseApprovalRoolDaoImpl();
 	List<Map<String,String>> listmap =purchaseApprovalRoolDao.queryGoods();
 	equiList=officeEquipmentTypeDao.findAll();
 	
 	//贸促会 需求 除了设备名称 其他不做必填项  tao.ren 2013-05-22
 	String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");//421003贸促会
%>
<title>办公设备 采购入库单</title>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入其它JS -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"> </script> 
<script src="../../../resources/js/conference.js" type="text/javascript"></script>
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<!-- 引入提示 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" ></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<script type="text/javascript">
jQuery(document).ready(function() {
	jQuery("#conferenceBase").validationEngine();
});

//添加物品
function Add_Row4NewDay1(){
	var firstTr = $("[name=dayrow]").first().clone();
	
	$(firstTr).find("input[type=text]").val("");
	
	$(firstTr).find("input[type=hidden]").val("");
	
	firstTr.find("input[type=text]").val("");
	
	
	var dayTable = $("#dayTable");
	
	firstTr.appendTo(dayTable);
	
	$(firstTr).find(".date_187").each(function(i,e){
		setDataTimeClickShowOrHide($(this).attr("id"),window);
	})
}
//删除物品
function deleteDay(tag,goodsId){
	
	var intable=$(tag).parents("table");
	var tr=$(tag).parents("tr").first();
	var trsize= $(intable).find("tr[name=dayrow]").size();
	if(trsize==1){
		Add_Row4NewDay1();
		$(tr).remove();
	}else{
		$(tr).remove();
	}
}

//提交方法
function saveInfo(){	
 	$('#conferenceBase').attr("target","hiddenFrame");
 	<%if("410003".equals(userArea)) {%>
	 	var tem=$("#kc").val();
	 	tem=$.trim(tem);
		if(""!=tem && "false"!=tem){
			 alert($("#kc").val());
		}else if("false"==$("#kc").val()){
			
		}else{
			$('#conferenceBase').submit();
		}
 	<%}else{%>
 	$('#conferenceBase').submit();
 	<%}%>
}
/* 返回 */
function backTo(){
	
	var okF = function(){
		removeWindows('<%=widowsid%>',true,false);
		}
		 var p={
			headerText:'提示',
			okName:'确认',
		    okFunction:okF,
		    cancelName:'取消'
		};
	alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
} 

function setgoodsid(obj){
	var inputobj= $(obj).parent().find("input");
	var sl= $(obj).find("option:selected");
	$(inputobj).val($(sl).attr("goodsid"));
}


//ajax检测是否有库存
function checkgoods(){
	var goods= $("[name=goodsid]");
	var goodsids="";
	for(var i=0;i<goods.length;i++){
		goodsids+=$(goods[i]).val()+",";
	}
	goodsids=goodsids.substr(0,goodsids.length-1)
	if(""!=goodsids){
 	var params={"goodsids":goodsids};
	$.ajax({
		url: "../../../yimingju/officeassets/jsp/getcheckgoods.jsp",
		type: 'POST',
		dataType: 'text',
		data: params,
		success: function(data){
			$("#kc").val(data);
			saveInfo();
		},
		error: function(jqXHR, textStatus, errorThrown){
		}
	})
	}else{
		alert("请填写内容!");
	}
};
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('content_02_top','vcenter',40)">
<form id="conferenceBase" name="conferenceBase" method="post" action="addOfficeStockDo.jsp" >
	<input type="hidden" name="widowsid" id="widowsid" value='<%=widowsid%>'/>
	<input type="hidden" name="action" value="add"/>
	<input type="hidden" id="kc" value="false" />
	<input type="hidden" id="kc" value="false" />
	<div  class="content_02" style="overflow:hidden;" id="content_02_top">
	<!--   操作 -->
    <div class="content_02_top" style="margin-bottom:10px;">
    	<%if("410003".equals(userArea)) {%>
    		<input id=response_notice onclick='checkgoods()' value="确定" type="button" class="but_y_01"/>
    	<%}else{%>
    		<input id=response_notice onclick='saveInfo()' value="确定" type="button" class="but_y_01"/>
   		<%}%>
   		<input name="" value="返回" type="button" class="but_y_01" onclick="backTo()"/> 
  	</div> 
  	</div> 
	 
	<!-- 表格-->
	<div id="vcenter" class="content_02"  style="float: left; width: 100%; overflow: scroll" scrolling="yes">
	<div style="float: left; width: 775px; ">
	<div class="content_02_box" >
	<div class="content_02_box_title_bg">
		<span>  
				办公设备 采购入库单
		</span>
	</div>
	 <div class="content_02_box_div">
	   <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" width="100%">
         <tr>
           <th  class="content_02_box_div_table_th" id="content_title_name">入库人:</th>
           <td class="content_02_box_div_table_td">
           		<%=accesscontroler.getUserName()%>
           	</td>
           <th width="191" class="content_02_box_div_table_th">入库日期：</th>
           <td class="content_02_box_div_table_td" >
           		<%=time%>
           		<input type="hidden" id="stock_data" name="stock_data" value="<%=time%>" />
			</td>
         </tr> 
	 </table>
    </div>
   </div>
   </div> 
  	<!-- 形成安排表 -->
	<div class="content_02_box">
	<div class="content_02_box_title_bg">
	<span>物品列表</span>
	<div class="content_02_box_add">
	<a onclick="Add_Row4NewDay1()">
		<img src="../../../resources/images/add.gif"/>
		添加物品
	</a>
	</div>
	</div>
	<div class="content_02_box_div">
	<%if("421003".equals(userArea)) {%>
	<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0" width="100%">
			 	<tr>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 类别</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> <span style="color: red">*</span>设备名称</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 设备编号</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 型号</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 单价(元)</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 供货厂商</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"> 售后电话</td>
					<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 147px">操作</td>
				</tr>
					<tr name="dayrow">
						<td class="content_02_box_div_table_td"> 
										<select name="type_ids" id="type_ids" size="1"
											class="select_188_box"
											style="width: 188px;" >
												<option value="">---请选择---</option>
												
													<%	
														for (int i = 0; i < equiList.size(); i++) {
													%>
														<option value="<%=equiList.get(i).getOetype_id()%>"><%=equiList.get(i).getOetype_name()%></option>
													
													<%
													}
													%>
												
								       </select>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="equipment_name" name="equipment_name" class="validate[required,maxSize[50]] input_title_text"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="equipment_no" name="equipment_no" class="input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="equipment_model" name="equipment_model" class="input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="equipment_price" name="equipment_price" class="input_title_text" onblur="if(this.value<=0){alert('不能为空或者为0！');this.value=''}"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="suppliers" name="suppliers" class="input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="service_phone" name="service_phone" class="input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
													<a onClick="deleteDay(this,'')"> <img src="../../../resources/images/del.gif" id="del"/>删除</a>
								 </div>
												
						</td>
					</tr>
		</table>
	
	<%}else if("410003".equals(userArea)){ %>
	<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0" width="100%">
			 	<tr>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 类别</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 设备名称</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 设备编号</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 型号</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 单价(元)</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 供货厂商</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 售后电话</td>
					<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 147px">操作</td>
				</tr>
					<tr name="dayrow">
						<td class="content_02_box_div_table_td"> 
										<select name="type_ids" id="type_ids" size="1"
											class="validate[required] select_188_box"
											style="width: 188px;" >
												<option value="">---请选择---</option>
												
													<%	
														for (int i = 0; i < equiList.size(); i++) {
													%>
														<option value="<%=equiList.get(i).getOetype_id()%>"><%=equiList.get(i).getOetype_name()%></option>
													
													<%
													}
													%>
												
								       </select>
						</td>
						<td class="content_02_box_div_table_td"> 
<!-- 								<input type="text" id="equipment_name" name="equipment_name" class="validate[required,maxSize[50]] input_title_text"/>
 -->							<select name="equipment_name" id="equipment_name" size="1"
											class="validate[required] select_188_box"
											style="width: 150px;" onchange="setgoodsid(this)">
											<option value="">---请选择---</option>
										<%	
											for (int i = 0; i < listmap.size(); i++) {
										%>
											<option value="<%=listmap.get(i).get("goods_name")%>"  goodsid="<%= listmap.get(i).get("goods_id")%>"><%=listmap.get(i).get("goods_name")%></option>
										<%
										}
										%>
								</select>
								<input type="hidden" name="goodsid" value=""/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="equipment_no" name="equipment_no" class="validate[required,maxSize[50]] input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="equipment_model" name="equipment_model" class="validate[required,maxSize[25]] input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="equipment_price" name="equipment_price" class="validate[custom[number],required] input_title_text" onblur="if(this.value<=0){alert('不能为空或者为0！');this.value=''}"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="suppliers" name="suppliers" class="validate[required,maxSize[25]] input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="service_phone" name="service_phone" class="validate[custom[phone],required] input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
													<a onClick="deleteDay(this,'')"> <img src="../../../resources/images/del.gif" id="del"/>删除</a>
								 </div>
												
						</td>
					</tr>
		</table>
		<%}else{ %>
				<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0" width="100%">
			 	<tr>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 类别</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 设备名称</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 设备编号</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 型号</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 单价(元)</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 供货厂商</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 售后电话</td>
					<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 147px">操作</td>
				</tr>
					<tr name="dayrow">
						<td class="content_02_box_div_table_td"> 
										<select name="type_ids" id="type_ids" size="1"
											class="validate[required] select_188_box"
											style="width: 188px;" >
												<option value="">---请选择---</option>
												
													<%	
														for (int i = 0; i < equiList.size(); i++) {
													%>
														<option value="<%=equiList.get(i).getOetype_id()%>"><%=equiList.get(i).getOetype_name()%></option>
													
													<%
													}
													%>
												
								       </select>
						</td>
						<td class="content_02_box_div_table_td"> 
 								<input type="text" id="equipment_name" name="equipment_name" class="validate[required,maxSize[50]] input_title_text"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="equipment_no" name="equipment_no" class="validate[required,maxSize[50]] input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="equipment_model" name="equipment_model" class="validate[required,maxSize[25]] input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="equipment_price" name="equipment_price" class="validate[custom[number],required] input_title_text" onblur="if(this.value<=0){alert('不能为空或者为0！');this.value=''}"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="suppliers" name="suppliers" class="validate[required,maxSize[25]] input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="service_phone" name="service_phone" class="validate[custom[phone],required] input_title_text" />
						</td>
						<td class="content_02_box_div_table_td"> 
								 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
													<a onClick="deleteDay(this,'')"> <img src="../../../resources/images/del.gif" id="del"/>删除</a>
								 </div>
												
						</td>
					</tr>
		</table>
		<%} %>
		</div>
	  	<div class="content_02_box_div">
	  	 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02" width="100%">
        	 <tr>
	           <th  class="content_02_box_div_table_02_th" id="content_title_name">备注：</th>
			   <td > 
						 <textarea type="text" id="remark" name="remark" class=""  rows=3 style="width: 98%"></textarea>
			   </td>
         </tr> 
	 </table>
   	 </div>
   	 </div>
   	 </div>
</form>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>

