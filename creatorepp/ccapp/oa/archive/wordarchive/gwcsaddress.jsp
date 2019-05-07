<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String ins_id = request.getParameter("ins_id");
String subid = request.getParameter("subid");
String is_split = request.getParameter("is_split");	//如果是指标文发文，is_split = 1 。其他为0；
String send_org_name=StringUtil.deNull(request.getParameter("send_org_name"));
if(is_split == null || "".equals(is_split)){
	is_split = "0";
}
String send_org_config =  request.getParameter("send_org_config");//获取发文单位配置
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>公文传输地址本</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="This is my page">
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- 引入my97时间控件 -->
	<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
		<!-- 引入其它 -->
	<script src="../../resources/util/public.js" type="text/javascript"></script>
	<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<style type="text/css">
		.oa_address{width: 900px;height: auto;float: left;margin-bottom: 20px;}
		.oa_address_top{width: 900px;height: 30px;line-height: 30px;text-align: left;padding-left:5px;background: #D5E8F9;}
		.oa_address_content{width: 900px;height: auto;padding:0 5px;}
		.oa_address_item{width: 440px;height: 25px;list-style: 25px;float: left;margin-right: 10px;margin-top: 3px;}
		.oa_address_item:hover{background: #D5E8F9;}
		.oa_address_item span{height: 25px;display: block;float: left;}
		.checkbox{vertical-align:middle; margin-top:0;}
		.address_unit{width: 200px;overflow: hidden;line-height: 25px;}
		.address_unit:hover{cursor: pointer;}
		.address_copies{width: 100px;}
		.address_no{width: 130px;}
		.address_input{height: 23px;border: 1px solid #ccc;line-height: 25px;}
	</style>
	<script type="text/javascript">
	var subid = "<%=subid%>";
	var is_split = "<%=is_split%>";
	var ins_id = "<%=ins_id%>";
	var send_org_name='<%=send_org_name%>';
	var ajax_url = "<%=path%>"+"/ccapp/oa/archive/wordarchive/";
	$(function(){
		$("input[type=text]").first().focus();	//设置焦点
		var parentAddress_list = getParentWindow(subid).get_parentAddress_list();
		if(parentAddress_list != ""){
			$("#address_list").html(parentAddress_list);
			$("input[type=text]").first().focus();	//设置焦点
		} else {
			listAddressByConfig("0",function(code,result){
				if(code == 0){
					$("#address_list").html("");
					//先循环取市级信息
					$.each(result,function(key,value){
						var default_copies = value.config_copies;
						if(IsSpace(default_copies)){
							default_copies = 10;
						}
						var default_id = value.config_number;
						if(IsSpace(default_id)){
							default_id = 0;
						}
						$("#address_list").append("<div class='oa_address' id="+value.config_dom_id+" hideval="+value.org_addr+">"+
													"<div class='oa_address_top'>"+
														"<span class='address_unit'><input type='checkbox' class='checkbox'>&nbsp;"+value.org_name+"</span>"+
														"<span class='address_copies'>&nbsp;份数：<input type='text' class='address_input' style='width: 50px;' value='"+default_copies+"'></span>"+
														"<span class='address_no'>&nbsp;编号：<input type='text' class='address_input' style='width: 80px;' value='"+value.config_number+"'></span>"+
													"</div>"+
													"<div class='oa_address_content'></div>"+
												"</div>");
					});
					//循环取县级信息
					listAddressByConfig("1",function(code,result){
						if(code == 0){
							$.each(result,function(key,value){
								var default_copies = value.config_copies;
								if(IsSpace(default_copies)){
									default_copies = 10;
								}
								var default_id = value.config_number;
								if(IsSpace(default_id)){
									default_id = 0;
								}
								var flag="";
								if(send_org_name.indexOf(value.org_name)!=-1){
									flag='checked="checked"';
								}
								$("#"+value.config_dom_id).find(".oa_address_content").append(
										"<div class='oa_address_item' id='"+value.org_id+"'>"+
											"<span class='address_unit'><input type='checkbox' class='checkbox' "+flag+" >&nbsp;<label id="+value.org_addr+" filepath=''>"+value.org_name+"</label></span>"+
											"<span class='address_copies'>份数：<input type='text' class='address_input' style='width: 50px;' value='"+default_copies+"'></span>"+
											"<span class='address_no'>编号：<input type='text' class='address_input' style='width: 80px;' value='"+default_id+"'></span>"+
										"</div>");
							});
						}
						//注册事件
						$(".oa_address_top .address_unit").on("click",function(){
							oa_address_top_checkbox_click($(this).find(".checkbox"));
						})
						$(".oa_address_item  .address_unit").on("click",function(event){
							oa_address_item_click($(this));
						})
						if(is_split == 1){
							getGwcsOrg(ins_id);							
						}
					})
				}
			});
		}
		//注册事件
		$(".oa_address_top .address_unit").on("click",function(){
			oa_address_top_checkbox_click($(this).find(".checkbox"));
		})
		$(".oa_address_item  .address_unit").on("click",function(event){
			oa_address_item_click($(this));
		})
		//填写大标题的份数，编号，下面的子节点自动赋值
		$("#address_list").on("focusout",".oa_address_top .address_input",function(){
			var _this = $(this);
			var tmp_num = _this.val();
			var parent_class = _this.parent().attr("class");
			if(parent_class == "address_copies"){
				if(isNumber(tmp_num)){
					_this.parent().parent().next("div").find(".address_copies .address_input").val(tmp_num);
				} else {
					alert("请正确填写（非空且为正整数）！");
				}
			} else if(parent_class == "address_no"){
				_this.parent().parent().next("div").find(".address_no .address_input").val(tmp_num);
			}
		})
	})
	function backTo(){
		//getParentWindow('windowId').objectSearch();
	    removeAlertWindows(subid,true);
	}
	function oa_address_item_click(_this){
		if(_this.find(".checkbox").attr("checked") == "checked"){
			_this.find(".checkbox").attr("checked","true");			
		} else {
			_this.find(".checkbox").removeAttr("checked");
		}
	}
	function oa_address_top_checkbox_click(_this){
		if(_this.attr("checked") == "checked"){
			_this.attr("checked","true");
			_this.parent().parent().next("div").find(".checkbox").attr("checked","true");
		} else {
			_this.removeAttr("checked");
			_this.parent().parent().next("div").find(".checkbox").removeAttr("checked");
		}
	}
	function saveInfo(){
		var gwcs_org_id = "";
		var gwcs_org_name = "";
		var gwcs_copies = "";
		var gwcs_no = "";
		var gwcs_address = "";	//最终传回去的字符串
		var flag = true;
		$(".oa_address_item .checkbox").each(function(index,dom){
			var _this = $(this);
			if(_this.attr("checked") == "checked"){
				gwcs_address += _this.next("label").attr("id")+",";	//拼接org_id
				var input_org_name = _this.next("label").html();
				gwcs_address += input_org_name+",";		//拼接名称
				gwcs_org_name += input_org_name+",";
				var input_copies = _this.parent().parent().find(".address_copies input").val();	//拼接份数
				if(isNumber(input_copies)){
					gwcs_address += _this.parent().parent().find(".address_copies input").val()+",";	
				} else {
					alert(input_org_name+"中的份数为非整数，请正确填写（非空且为正整数）！");
					flag = false;
					return false;
				}
				gwcs_address += _this.parent().parent().find(".address_no input").val();	//拼接编号
				if(is_split == 1){	//如果是指标文拆分
					gwcs_address += ","+_this.next("label").attr("filepath");	//拼接指标文地址
				}
				gwcs_address += "#";
			}
		});
		if(flag){
			getParentWindow(subid).set_parentAddress_list($("#address_list").html(),gwcs_address,gwcs_org_name);
			removeAlertWindows(subid,true);
		}
	}
	//type = 0取市级信息。type = 1取县级信息
	function listAddressByConfig(tmp_type,callback){
		$.ajax({
			url:ajax_url+'gwcsaddresshandle.jsp',
			type:'post',dataType:'json',
			data:{"method":"listByConfig","type":tmp_type,"send_org_config":"<%=send_org_config%>"},
			success:function(data){
				var code = data.code.index;
				if(code == 0){
					//成功
				} else if (code == -3){
					alert("没有配置地址簿信息！");
				} else {
					alert("操作失败！code:"+code);
				}
				callback(code,data.result);
			}
		})
	}
	//获取公文传输与指标文拆分关联的单位
	function getGwcsOrg(tmp_ins_id){
		$.ajax({
			url:ajax_url+'gwcsaddresshandle.jsp',
			type:'post',dataType:'json',
			data:{"method":"getGwcsOrg","ins_id":tmp_ins_id},
			success:function(data){
				var code = data.code.index;
				if(code == 0){
					//成功
					$.each(data.result,function(key,value){		
						$("#"+value.gwcs_org_id)
								.find(".checkbox").attr("checked","true")
								.next("label").attr("filepath",value.file_path).css("color","red");	//将指标文地址写入到label的filepath自定义属性里面
					})
					alert("标红的单位已与指标文关联！");
				} else if (code == -3){
					alert("没有单位与指标文关联！请先拆分指标文！");
				} else {
					alert("获取指标文与公文传输关联的单位失败！code:"+code);
				}
			}
		})
	}
	</script>
  </head>
  <body>
	<div class="content_02" style="overflow:hidden;float: left;" id="_top">
		<div class="content_02_top" style="margin-bottom:10px;" >
			<input id="saveinfo" value="确定" style="display: inline" type="button" class="but_y_01" onclick="saveInfo()"/>
			<input value="关闭" onclick="backTo()" type="button" class="but_y_01" />
		</div>
	</div>
	<div id="address_list" style="width: 900px;height:500px;margin: 0 auto;float: left;overflow-y:auto;overflow-x:hidden;">
		<!-- 
		<div class="oa_address" >
			<div class="oa_address_top">
				<span class="address_unit"><input type="checkbox" class="checkbox">&nbsp;长沙市范德萨发的萨芬范德萨范德萨财政局</span>
				<span class="address_copies">份数：<input type="text" class="address_input" style="width: 50px;"></span>
				<span class="address_no">编号：<input type="text" class="address_input" style="width: 80px;"></span>
			</div>
			<div class="oa_address_content">
				<div class="oa_address_item">
					<span class="address_unit"><input type="checkbox" class="checkbox">&nbsp;<label hideval='111'>长沙市财政局</label></span>
					<span class="address_copies">份数：<input type="text" class="address_input" style="width: 50px;"></span>
					<span class="address_no">编号：<input type="text" class="address_input" style="width: 80px;"></span>
				</div>
				<div class="oa_address_item">
					<span class="address_unit"><input type="checkbox" class="checkbox">&nbsp;<label hideval='222'>长沙市财政局</label></span>
					<span class="address_copies">份数：<input type="text" class="address_input" style="width: 50px;"></span>
					<span class="address_no">编号：<input type="text" class="address_input" style="width: 80px;"></span>
				</div>
				<div class="oa_address_item">
					<span class="address_unit"><input type="checkbox" class="checkbox">&nbsp;<label hideval='333'>长沙市财政局</label></span>
					<span class="address_copies">份数：<input type="text" class="address_input" style="width: 50px;"></span>
					<span class="address_no">编号：<input type="text" class="address_input" style="width: 80px;"></span>
				</div>
			</div>
		</div> -->
	</div>
  </body>
</html>
