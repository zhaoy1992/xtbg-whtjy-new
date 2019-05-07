<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.chinacreator.xtbg.pub.util.*"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>

<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request,response);
	String path = request.getContextPath();
	String userid = accesscontroler.getUserID();
	String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
	String widowsid = request.getParameter("widowsid");
	
 	//贸促会 需求 除了设备名称 其他不做必填项  tao.ren 2013-05-22
 	String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");//421003贸促会
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>易耗品 领用登记单</title>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../../resources/js/util/jsonutil.js" type="text/javascript"></script>
<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
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
var userArea=<%=userArea%>;
jQuery(document).ready(function() {
	jQuery("#conferenceBase").validationEngine();
});

//选择联系人
function chooseActUser(objId,objName){
	var s = new $.z_tree();
	  s.treeID='mian';
	  s.treetypestr="radio";
	  s.ischekc="false";
	  s.isShowSeacher=true;
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.type="APERSON";
	  s.selectedIds=$('#'+objId).val();
	  s.returnFunction=function(orgObj){
		$('#'+objId).val(orgObj.id);
		$('#'+objName).val(orgObj.name);
		queryUserDepart(orgObj.id);
	  }
    s.otherParam={"toporgId":"<%=theRootOrgid%>","userid":"<%=userid%>","resourceType":"GUESTRECEPTION_ADD_CHOOSECONTACTPERSON","backchooseuserids":"","showLevel":"1"};
    s.init();
}

//根据人员查找部门
function queryUserDepart(userid){
	var url = "getAjaxDepartByUserId.jsp";
	params = {user_id:""+userid+""};
	$.ajax({
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		success: function(data){
			if("null" != data.value){
				showUserDepart(data);
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
		}
	});
}

//显示部门信息
function showUserDepart(data){
	$("#org_id").val(data.org_id);
	$("#org_name").val(data.org_name);
}

//选择领用设备
function Add_Row4NewDay1(){
	var stock_ids = "";
	$("input[name=stock_id]").each(function(i,e){
		stock_ids=stock_ids+ $(e).val() +",";
	});
	stock_ids = stock_ids.substr(0,stock_ids.length-1);
	var flag = openAlertWindows('windowId','../../../yimingju/officeassets/jsp/getCollarSumEqList.jsp?windowsId=windowId&stock_ids='+stock_ids,'选择领用物品',820,470,'25%','25%');
}

//删除领用设备
function deleteDay(tag,goodsId){
	
	var intable=$(tag).parents("table");
	var tr=$(tag).parents("tr").first();
	var trsize= $(intable).find("tr[name=dayrow]").size();
	if(trsize==1){
		$(tr).find("#stock_id").val("");
		$(tr).find("#conEq_name").val("");
		$(tr).find("#conEq_type").val("");
		$(tr).find("#conEq_ruls").val("");
		$(tr).find("#conEq_price").val("");
		$(tr).find("#conStock_count").val("");
		$(tr).find("#collar_count").val("");
	}else{
		$(tr).remove();
	}
}


//提交方法
function saveInfo(id){
	var isFlag = $('#conferenceBase').validationEngine('validate'); //是否全部验证通过
	if (isFlag) {
		var ch = true;
		var callerCounts = $("input[name=collar_count]");
		$(callerCounts).each(function (i,e) {
				var stockCount = $(e).parent("td").eq(0).parent("tr").find("input[name=conStock_count]").val();
				var collarCount = $(e).val();
				if(userArea!="421003"){
					if(collarCount ==0){
						alert("请输入易耗品领用数!");
						ch = false;
					}
				}
				if(collarCount*1 > stockCount*1){
					alert("领用数量不能大于库存数量！");
					ch = false;
				}
				if(ch==false){
					return false;
				}
			}
		)
		if(ch){
			$('#conferenceBase').attr("target","hiddenFrame");
			$('#conferenceBase').submit();
		}
	}else{
		return;
	}
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

/** 判断输入的领用数 */
 var FLAG_CHECK = false;
 function checkCollar(input){
	//锁定焦点事件
	 if(FLAG_CHECK){
		 FLAG_CHECK = false;
		 return false;
	}
	FLAG_CHECK = true;
	var stockCount = $(input).parent("td").eq(0).parent("tr").find("input[name=conStock_count]").val();
	var collarCount = $(input).val();
	if(collarCount ==0){
		alert("请输入易耗品领用数!");
		return false;
	}
	if(collarCount*1 > stockCount*1){
		alert("领用数量不能大于库存数量！");
		return false;
	}
}
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('content_02_top','vcenter',40)">
<form id="conferenceBase" name="conferenceBase" method="post" action="addCollarSumEqStockDo.jsp" >
	<input type="hidden" name="widowsid" id="widowsid" value='<%=widowsid%>'/>
	<div  class="content_02" style="overflow:hidden;" id="content_02_top">
	<!--   操作 -->
    <div class="content_02_top" style="margin-bottom:10px;">
   		<input id=response_notice onclick='saveInfo()' value="确定" type="button" class="but_y_01"/>
   		<input name="" value="返回" type="button" class="but_y_01" onclick="backTo()"/> 
  	</div> 
  	</div> 
	 
	<!-- 表格-->
	<div id="vcenter" class="content_02" style="float: left; width: 100%; overflow: scroll" scrolling="yes">
	<div style="float: left; width: 775px; ">
	<div class="content_02_box" >
	<div class="content_02_box_title_bg">
		<span>  
				易耗品 领用登记单
		</span>
	</div>
	 <div class="content_02_box_div">
	   <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" width="100%">
         <tr>
           <th  class="content_02_box_div_table_th" id="content_title_name"><span style="color: red">*</span>领用人：</th>
           <td class="content_02_box_div_table_td">
           		<input type="text" onclick="chooseActUser('user_id','collar_user')" class="validate[required] input_155" readonly="readonly" id="collar_user" name="collar_user"/>
           		<input type="hidden"  id="user_id" name="user_id"/>
           	</td>
           <th width="191" class="content_02_box_div_table_th">领用部门：</th>
           <td class="content_02_box_div_table_td" >
           		<input type="hidden" id="org_id" name="org_id" value="" />
           		<input type="text" id="org_name" name="org_name" class="validate[required] input_155" readonly="readonly" value="" />
			</td>
			 <th width="191" class="content_02_box_div_table_th"><span style="color: red">*</span>领用日期：</th>
           <td class="content_02_box_div_table_td" >
           	<input type="text" class="validate[required] date_187" id="apply_date" name="apply_date" value=""
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})" />
			</td>
         </tr> 
	 </table>
    </div>
   </div>
   </div> 
  	<!-- 形成安排表 -->
	<div class="content_02_box">
	<div class="content_02_box_title_bg">
	<span>设备列表</span>
	<div class="content_02_box_add">
	<a onclick="Add_Row4NewDay1()">
		<img src="../../../resources/images/add.gif"/>
		选择要领用的物品
	</a>
	</div>
	</div>
	<div class="content_02_box_div">
	<table id="dayTable" class="content_02_box_div_table_02" width="100%" cellspacing="0" cellpadding="0" border="0" width="100%">
			 	<tr>
			 	<%if(("421003").equals(userArea)){ %>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 品名</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">类别</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">规格</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">单价</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">库存数量</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px">领用数量</td>
					<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 147px">操作</td>
			 	<%}else{ %>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 品名</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 类别</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 规格</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 单价</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 库存数量</td>
					<td class="content_02_box_div_table_th" style="text-align: center;width: 147px"><span style="color: red">*</span> 领用数量</td>
					<td class="content_02_box_div_table_th" align="center"style="text-align: center;width: 147px">操作</td>
			 	<%} %>
				</tr>
					<tr name="dayrow" id="dayrow" >
					<%if(("421003").equals(userArea)){ %>
						<td class="content_02_box_div_table_td">
							 <input type="hidden" id="stock_id" name="stock_id"  value=""/>
							 <input type="text" id="conEq_name" name="conEq_name" class="validate[required] input_title_text" style="text-align:center;" readonly="readonly"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="hidden" id="type_id" name="type_id" class="input_title_text" readonly="readonly"/>
								<input type="text" id="conEq_type" name="conEq_type" class="input_title_text" style="text-align:center;" readonly="readonly"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="conEq_ruls" name="conEq_ruls" class="input_title_text" style="text-align:center;" readonly="readonly"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="conEq_price" name="conEq_price" class="input_title_text" style="text-align:center;" readonly="readonly"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="conStock_count" name="conStock_count" class="input_title_text" style="text-align:center;" readonly="readonly"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="collar_count" name="collar_count" class="input_title_text" style="text-align:center;" />
						</td>
						<td class="content_02_box_div_table_td"> 
								 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
													<a onclick="deleteDay(this,'')"> <img src="../../../resources/images/del.gif" id="del"/>删除</a>
								 </div>
						</td>
					<%}else{ %>
						<td class="content_02_box_div_table_td">
							 <input type="hidden" id="stock_id" name="stock_id"  value=""/>
							 <input type="text" id="conEq_name" name="conEq_name" class="validate[required] input_title_text" style="text-align:center;" readonly="readonly"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="hidden" id="type_id" name="type_id" class="validate[required] input_title_text" readonly="readonly"/>
								<input type="text" id="conEq_type" name="conEq_type" class="validate[required] input_title_text" style="text-align:center;" readonly="readonly"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="conEq_ruls" name="conEq_ruls" class="validate[required] input_title_text" style="text-align:center;" readonly="readonly"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="conEq_price" name="conEq_price" class="validate[custom[number]] input_title_text" style="text-align:center;" readonly="readonly"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="conStock_count" name="conStock_count" class="validate[custom[number]] input_title_text" style="text-align:center;" readonly="readonly"/>
						</td>
						<td class="content_02_box_div_table_td"> 
								<input type="text" id="collar_count" name="collar_count" class="validate[custom[onlyNumberSp]] input_title_text" style="text-align:center;" onblur ="checkCollar(this);" />
						</td>
						<td class="content_02_box_div_table_td"> 
								 <div class="content_02_box_del" style="height:24px; margin:0;float: none;text-align: center;">
													<a onclick="deleteDay(this,'')"> <img src="../../../resources/images/del.gif" id="del"/>删除</a>
								 </div>
						</td>
					<%} %>
					</tr>
		</table>
		</div>
	  	<div class="content_02_box_div">
	  	 <table  border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table_02" width="100%">
        	 <tr>
	           <th  class="content_02_box_div_table_02_th" id="content_title_name">备注：</th>
			   <td class="content_02_box_div_table_02_td"> 
						 <textarea id="remark" name="remark"  rows=3 style="width: 98%"></textarea>
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

