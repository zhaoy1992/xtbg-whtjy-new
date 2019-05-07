<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String subid = request.getParameter("subid");
String unit_id = StringUtil.deNull(request.getParameter("unit_id"));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>拆分单位添加更新</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="This is my page">
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- 引入my97时间控件 -->
	<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
		<!-- 引入其它 -->
	<script src="../../../resources/util/public.js" type="text/javascript"></script>
	<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<!-- 引入自己的js -->
	<script type="text/javascript" src="../resources/js/jquery.form.js"></script>
	<script type="text/javascript" src="../resources/js/jquery.initForm.js"></script>
	<script type="text/javascript">
	var subid = "<%=subid%>";
	var unit_id = "<%=unit_id%>";
	var ajax_url = "<%=path%>"+"/ccapp/oa/archive/split/jsp/";
	$(function(){
		$("#unit_name").focus();
		if(!IsSpace(unit_id)){
			$("#method").val("update");
			//$("#tr_is_valid").css("display","");	//注释掉更改删除状态的，不让用户删除了的数据再设置为有效。这个在与公文传输机构一对一关联的时候会有问题
			list(unit_id,function(){
				//初始化表单
				getById(unit_id,function(code,result){
					if(code == 0){
		    			$("#form1").initForm({jsonValue:result,isDebug:false});	//表单初始化方法，用了自己写的插件
		    		}
				});
			});
		} else {
			list(unit_id,function(){});
		}
		$("#saveinfo").on("click",function(){
			if(validateForm()){
				$("#saveinfo").attr("disabled","disabled");
				//用jquery.form进行ajax提交,对于是添加还是更新，这里通过hidden域中的method后台判断
				jQuery("#form1").ajaxSubmit({dataType:"json",type:"post",
					success:function(data){
						if(data.code.index == 0){
							alert("操作成功！");
							backTo();
						} else if(data.code.index == -45) {
							alert("请输入单位名称！");
						} else {
							alert("操作失败！errorCode["+data.code.index+"]");
						}
						$("#saveinfo").removeAttr("disabled");
					}
				})
			}
		})
	})
	function validateForm(){
		if(jQuery("#form1").validationEngine("validateform")){
			return true;
		}else{
			return false;
		}
	}
	//根据ID查询
	function getById(tmp_id,callback){
		if(!IsSpace(tmp_id)){
			jQuery.ajax({
				url:ajax_url+'splitunithandle.jsp',
				type:'post',dataType:'json',
				data:{"method":"getById","unit_id":tmp_id},
				success:function(data){
					if(data.code.index == 0){
						//callback(data.code.index,data.result);
					} else {
						alert("查询数据失败！errorCode["+data.code.index+"]");
					}
					callback(data.code.index,data.result);
				}
			})
		}
	}	
	//查询有效的一级分类
	function list(tmp_id,callback){
		jQuery.ajax({
			url:ajax_url+'splitunithandle.jsp',
			type:'post',dataType:'json',
			data:{"method":"list","is_valid":1,"parent_id":"-1"},
			success:function(data){
				if(data.code.index == 0){
					$("#parent_id").html("<option value=''>---请选择---</option>");
					$.each(data.result,function(key,value){
						if(tmp_id != value.unit_id ){	//过滤掉当前页面的分类id
							$("#parent_id").append("<option value='"+value.unit_id+"'>"+value.unit_name+"</option>");	
						}
					});
				} else {
					$("#parent_id").html("<option value=''>---请选择---</option>");
				}
				callback();
			}
		})
	}
	
	function backTo(){
		getParentWindow('windowId').objectSearch();
	    removeAlertWindows('windowId',true);
	}
	function openGwcsOrgTree(){
	    var s = new jQuery.z_tree();
	    s.treeID = 'gwcs_org_name_tree';
	    s.treetypestr = 'radio';
	    //s.isShowSeacher = true;
	    s.treeName = "选择公文传输关联地址";
	    s.headerName = "选择公文传输关联地址";
	    s.isType="dept"; //要设置默认选中值，则需要此类型
	    s.type = "queryGwcsOrgTree";
	    s.selectedIds = jQuery("#gwcs_org_id").val();
	    //set args
	    //s.orgId = jQuery("#gwcs_org_id").val();
	    //s.moveLevel = //这个为自定义参数
	    //callBack
	    s.returnFunction = function(userObj,o){
	       try{
	        if (!IsSpace(o)) {
	        	getUnitByGwcsOrgId(unit_id,o[0].id,function(code,result){
	        		if(code == -3){
	        			jQuery("#gwcs_org_name").val(o[0].name);
	            		jQuery("#gwcs_org_id").val(o[0].id);
	        		} else if(code == 0){
	        			alert("该机构已与拆分单位("+result.unit_name+")关联了，请选择其他的机构！");
	        		} else{
	        			alert("操作失败！");
	        		}
	        	});
	        } else {
	            jQuery("#gwcs_org_id").val("");
	            jQuery("#gwcs_org_name").val("");
	        }
	       }catch(e){
	         /**忽略客户端异常信息**/ 
	       }
	    }
	    s.init();
	}
	function getUnitByGwcsOrgId(tmp_unit_id,tmp_gwcs_org_id,callback){
		jQuery.ajax({
			url:ajax_url+'splitunithandle.jsp',
			type:'post',dataType:'json',
			data:{"method":"getUnitByGwcsOrgId","unit_id":tmp_unit_id,"gwcs_org_id":tmp_gwcs_org_id},
			success:function(data){
				callback(data.code.index,data.result);
			}
		})
	}
	</script>
  </head>
  
  <body>
  	<!-- table页面跳转 -->
	<div  class="content_02" style="overflow:hidden;" id="_top">
		<!-- 操作-->
		<div class="content_02_top" style="margin-bottom:10px;" >
			<input id="saveinfo" value="保存" style="display: inline" type="button" class="but_y_01" />
			<input value="关闭" onclick="backTo()" type="button" class="but_y_01" />
		</div>
	</div>
	<!-- 表格-->
	<div id="vcenter" style="float:left; width:98%;height:auto;">
		<div class="content_02_box_title_bg" style="width: 98%"><span>基本信息</span></div>
		<div style="width: 98%;float: left;overflow-y:auto;">
		<form action="splitunithandle.jsp" id="form1" name="form1" method="post">
			<input type="hidden" id="method" name="method" value="add"/>
			<input type="hidden" id="unit_id" name="unit_id" value="unit_id"/>
 			<table width="100%" border="1" cellspacing="0" cellpadding="0" class="content_02_box_div_table_02">
 				 <tr id="tr_name">
	           	   <th style="width: 20%" class="content_02_box_div_table_th"><FONT style="COLOR: red">*</FONT>单位名称：</th>
		           <td style="width: 80%" class="content_02_box_div_table_td">
		           		<input type="text" name="unit_name" id="unit_name" class="validate[required,maxSize[100]] input_title_text" style="width: 98%">
		           </td>
		         </tr>
		         <tr id="tr_parent_id">
	           	   <th style="width: 20%" class="content_02_box_div_table_th">上级分类：</th>
		           <td style="width: 80%" class="content_02_box_div_table_td">
		           		<select name="parent_id" id="parent_id">
		           			<option value="">---请选择---</option>
		           		</select>
		           </td>
		         </tr>
		         <tr id="tr_gwcs_id">
	           	   <th style="width: 20%" class="content_02_box_div_table_th">公文传输关联机构：</th>
		           <td style="width: 80%" class="content_02_box_div_table_td">
		           		<input type="text" name="gwcs_org_name" id="gwcs_org_name" readonly="readonly" onclick="openGwcsOrgTree();" class="validate[maxSize[100]] input_title_text" style="width: 98%">
		           		<input type="hidden" name="gwcs_org_id" id="gwcs_org_id">
		           </td>
		         </tr>
		         <tr id="tr_is_valid" style="display: none;">
	           	   <th style="width: 20%" class="content_02_box_div_table_th">是否有效：</th>
		           <td style="width: 80%" class="content_02_box_div_table_td">
		           		&nbsp;有效<input type="radio" name="is_valid" checked="checked" value="1">&nbsp;&nbsp;
		           		无效<input type="radio" name="is_valid" value="0">
		           </td>
		         </tr>
		         <tr id="tr_booker_dept_name">
	           	   <th style="width: 20%" class="content_02_box_div_table_th">备注：</th>
		           <td style="width: 80%" class="content_02_box_div_table_td">
		           		<input type="text" name="remark" id="remark" class="validate[maxSize[200]] input_title_text" style="width: 98%"/>
		           </td>
		         </tr>
		 	</table>
		 </form>
	</div>
  </body>
</html>
