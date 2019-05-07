<%--
描述：新增角色
作者：王博
版本：1.0
时间：2013-5-15
 --%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.chinacreator.sysmgrcore.manager.RoleTypeManager"%>
<%@ page import="com.chinacreator.sysmgrcore.entity.RoleType"%>
<%@ page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page import="java.util.*"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkManagerAccess(request, response);
	
	RoleTypeManager rtm = new RoleTypeManager();
	List<RoleType> typenamelist = (List<RoleType>)rtm.getTypeNameList();
	if(typenamelist == null){
		typenamelist = new ArrayList<RoleType>();
	}
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
		$("#role_name").focus();
		jQuery("#form1").validationEngine();
	});
	
	function addRole(){
		var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
		if(isFlag){
			var form = document.forms[0];
			form.action = "addroledo.jsp";
			form.target = "hiddenFrame";
			form.submit();
		}else{
			return false;
		}
	}
	
	function checkRoleName(){
		var role_name = $("#role_name").val();
		if(role_name != ""){//角色名称验证
			$.ajax({
				type: "POST",
				url: "checkrolename.jsp",
				data: "role_name="+role_name+"&action=add",
				contentType: "application/x-www-form-urlencoded; charset=utf-8", 
				success: function(msg){
					if(trim(msg) == "true"){//角色名称已经存在
						$("#role_name_pk_check").show();
						$("#role_name").focus();
						return false;
					}else{
						$("#role_name_pk_check").hide();
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
						<font color="red">*</font>角色名称：
					</th>
					<td class="content_02_box_div_table_td">
						<input type="text" name="role_name" id="role_name" onblur="checkRoleName()"
							onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[required,maxSize[50]] input_152" style="width:70%;height=23px"  value="" maxlength="50">
						<span style="display:none;" id="role_name_pk_check"><font color="red"><nobr>角色名称已存在</nobr></font></span>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>角色类型：
					</th>
					<td class="content_02_box_div_table_td">
						<select name="role_type" id="role_type" class="validate[required]" style="width:70%;">
								<option value="">--请选择--</option>
							<%for(RoleType bean : typenamelist) {%>
								<option value="<%=bean.getRoleTypeID() %>"><%=bean.getTypeName() %></option>
							<%} %>
						</select>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th">
						<font color="red">*</font>角色描述：
					</th>
					<td class="content_02_box_div_table_td">
						<textarea name="role_desc" id="role_desc" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[required,maxSize[500]] textarea_556" style="width:70%;" ></textarea>
					</td>
				</tr>
			</table>
		</div>
		
		<div class="cue_box_foot" style="position: absolute;bottom: 0px;">
			<input class="but_y_01" type="button" value="关闭" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="保存" onclick="addRole()"/>
		</div>
	</form>
	<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>