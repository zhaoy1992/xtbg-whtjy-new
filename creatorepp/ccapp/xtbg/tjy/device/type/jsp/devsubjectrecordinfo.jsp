<%--
  Description：仪器设备标对记录表详情页面
  Author：AutoGenerator
  Version：1.0
  Date：Fri Apr 04 14:01:03 CST 2014
--%>
<%@ page import="java.util.*" %>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String subid = request.getParameter("subid");
String sub_id = StringUtil.deNull(request.getParameter("sub_id"));
%>
<!DOCTYPE HTML>
<html>
  <head>
 	 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>仪器设备标对记录表详情页面</title>
	 <!-- 引入jQuery -->
	 <script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="utf-8"></script>
	 <!-- 引入my97时间控件 -->
	 <script src="<%=path%>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript" charset="utf-8"></script>
	 <!-- 引入其它 -->
	 <script src="<%=path%>/ccapp/oa/resources/util/public.js" type="text/javascript" charset="utf-8"></script>
	 <script src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	 <script src="<%=path%>/ccapp/oa/resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	 <!-- 引入其它 -->
	 <script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
	 <script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	 <script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
	 
	 <!-- 引入自己的js -->
	 <script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/form/jquery.form.js" charset="utf-8"></script>
	 <script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/form/jquery.initForm.js" charset="utf-8"></script>
 </head>
<script type="text/javascript">
var subid = "<%=subid%>";
var sub_id = "<%=sub_id%>";
$(function(){
	$("#dev_code").focus();//因为为ajax保存数据，有时页面会失去焦点，这里手动为一个可见元素给焦点
	if(!IsSpace(sub_id)){
		$("#method").val("update");
		$("#sub_id").val(sub_id);
		//初始化表单
		getById(sub_id,function(code,result){
			if(code == 0){
		    	$("#myform").initForm({jsonValue:result,isDebug:false});	//表单初始化方法，用了自己写的插件
		    }
		});
	} 
	$("#saveinfo").on("click",function(){
		if(validateForm()){
			$("#saveinfo").attr("disabled","disabled");
			//用jquery.form进行ajax提交,对于是添加还是更新，这里通过hidden域中的method后台判断
			$("#myform").ajaxSubmit({dataType:"json",type:"post",contentType:"application/x-www-form-urlencoded; charset=UTF-8",
				success:function(data){
					if(data.code.index == 0){
						alert("操作成功！");
						backTo();
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
	if(jQuery("#myform").validationEngine("validateform")){
		return true;
	}else{
		return false;
	}
}
//根据ID查询
function getById(tmp_id,callback){
	if(!IsSpace(tmp_id)){
		$.ajax({
			url:'devsubjectrecorddo.jsp',
			type:'post',dataType:'json',contentType:"application/x-www-form-urlencoded; charset=UTF-8",
			data:{"method":"getById","sub_id":tmp_id},
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

/*
函数:  openDevAppInfo
说明:  选择仪器设备物品
返回值: 无
*/
  function openDevAppInfo(){
	//选择设备    状态 为 "完好"+"在库"
	var path ="<%=path%>/ccapp/xtbg/tjy/device/jsp/devInfoList.jsp?windowsId=windowIds1&dev_stockflag=1&dev_state=1";
	openAlertWindows('windowIds1',path,'设备信息',900,450,'25%','25%');
 }

/*
函数:  setDevInfo
说明:  选择仪器设备物品
参数:   sbid:设备ID,sbname:设备名称      sbcode：设备编号         设备状态：sbstat 设备型号:type
		make_users:制造厂商   technical_parameters:设备参数信息
返回值: 无
*/
function setDevInfo(sbid,sbcode,sbname,sbstat,type,make_users,technical_parameters){
	//设备ID
	jQuery("#t_sb_id").val(sbid);
	//设备编号
	jQuery("#dev_code").val(sbcode);  
	//设备名称
	jQuery("#dev_name").val(sbname);   
}

function backTo(){
	getParentWindow(subid).objectSearch();
	removeAlertWindows(subid,true);
	//removeWindows(subid,true);
}
</script>
<body style="overflow-y:auto;overflow-x:hidden;">
	<form id="myform" action="devsubjectrecorddo.jsp" method="post"  >
		<input type="hidden" id="method" name="method" value="insert"/>
		<input type="hidden" id="sub_id" name="sub_id"/>
		<div class="content_02_top" style="width: 100%;"  >
			<input class="but_y_01" type="button" value="保存" id="saveinfo" />
			<input class="but_y_01" type="button" value="返回" id="backto" onclick="backTo()"/>
		</div>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>设备编号：</th>
						<td class="content_02_box_div_table_td">
							<!--设备ID-->
							<input type="hidden" name="t_sb_id" id="t_sb_id" />
							<input type="text" name="dev_code" id="dev_code" class="validate[required,maxSize[100]] input_cx_title_188" readonly="readonly" style="width:190px;height=23px" onclick="openDevAppInfo();" />
							<input type="button" name="btn" id="btn" style="margin-left: 7px;" value="选择设备" class="but_y_01" onclick="openDevAppInfo();"/>
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>设备名称：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="dev_name" id="dev_name"  class="validate[required,maxSize[100]] input_cx_title_188" readonly="readonly" style="width:190px;height=23px" />
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>标样名称：</td>
						<td class="content_02_box_div_table_td">
							   <input type="text" id="sub_name" name="sub_name" class="input_cx_title_188" style="width: 250px;"/>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>标对结果：</td>
						<td class="content_02_box_div_table_td">
							<textarea style="width:90%;" rows="5" cols="7" name="sub_result" class="validate[required,maxSize[500]]"
									id="sub_result" ></textarea>
						</td>
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable">备注：</td>
						<td class="content_02_box_div_table_td">
							<textarea style="width:90%;" rows="5" cols="7" name="remark" class="validate[maxSize[500]]"
									id="remark" ></textarea>
						</td>
					</tr>
			</table>
		</div>
	 </form>
  </body>
</html>
<!-- textarea示例 及 校验示例 
<tr>
    <th class="content_02_box_div_table_th" style="width:40%;">说明：</th>
    <td class="content_02_box_div_table_td" style="width:60%;" colspan="3">
	    <textarea class="validate[required,custom[number],maxSize[400]] textarea_575" id="remark" name="remark" rows="2" style="width:98%;border:none; height: 80px;overflow: auto;"></textarea>
    </td>
</tr>
-->
