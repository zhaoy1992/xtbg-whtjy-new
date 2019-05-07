<%--
描述：新增角色类型
作者：王博
版本：1.0
时间：2013-5-15
 --%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request, response);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>新增角色</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入formvValidatetion -->
<script type="text/javascript" src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" charset="UTF-8"></script>
<script type="text/javascript" src="../../resources/plug/formvalidation/jquery.validationEngine.js" charset="UTF-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script> 
<script type="text/javascript" src="../../resources/util/public.js" ></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		$("#type_name").focus();
		jQuery("#form1").validationEngine();
	});
	
	function addRoleType(){
		var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
		if(isFlag){
			var form = document.forms[0];
			form.action = "addroletypedo.jsp";
			form.target = "hiddenFrame";
			form.submit();
		}else{
			return false;
		}
	}
	
	function checkRoleTypeName(){
		var type_name = $("#type_name").val();
		if(type_name != ""){//角色名称验证
			$.ajax({
				type: "POST",
				url: "checkroletypename.jsp",
				data: "type_name="+type_name+"&action=add",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				success: function(msg){
					if(trim(msg) == "true"){//角色名称已经存在
						$("#type_name_pk_check").show();
						$("#type_name").focus();
						return false;
					}else{
						$("#type_name_pk_check").hide();
					}
				}
			});
		}
	}
	
</script>
</head>
<body style="overflow-y:hidden;">
	<form id="form1" name="form1" action="" method="post">
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>角色类型名称：
					</th>
					<td class="content_02_box_div_table_td">
						<input type="text" name="type_name" id="type_name" onblur="checkRoleTypeName()"
							class="validate[required,maxSize[50]] input_152" style="width:70%;height=23px"  value="" maxlength="50">
						<span style="display:none;" id="type_name_pk_check"><font color="red"><nobr>角色类型名称已存在</nobr></font></span>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>角色类型描述：
					</th>
					<td class="content_02_box_div_table_td">
						<textarea name="type_desc" id="type_desc" class="validate[required,maxSize[250]] textarea_556" style="width:70%;" ></textarea>
					</td>
				</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="关闭" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="保存" onclick="addRoleType()"/>
		</div>
	</form>
	<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>