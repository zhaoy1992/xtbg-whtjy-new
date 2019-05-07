<%@ page contentType="text/html; charset=GBK"%>

<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>密码修改</title>

<!-- dwr begin-->
<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/engine.js'>
	
</script>
<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/util.js'>
	
</script>
<script language="javascript" type="text/javascript" src='<%=request.getContextPath()%>/dwr/interface/applyChange.js'></script>
<!-- dwr end -->

<!-- 提交后页面变灰 -->
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/epp/eppTemplate/pageGrey.js"></script>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="utf-8"></script>
<script src="../../resources/util/public.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>


<script language="javascript" type="text/javascript">
jQuery(document).ready(function() {
	$("#oldpassword").focus();
});

	//
	//去除字符串空格
	function trim(string) {
		var temp = "";
		string = '' + string;
		splitstring = string.split(" ");
		for (i = 0; i < splitstring.length; i++) {
			temp += splitstring[i];
		}
		return temp;
	}

	//验证数据、调用后台JAVA类方法
	function editpass() {
		var form = document.forms[0];
		var username = form.username.value;
		var oldpassword = form.oldpassword.value;
		var newpassword = form.newpassword.value;
		var repassword = form.repassword.value;
		//alert(typeof newpassword);
		if (trim(username).length == 0) {
			document.getElementById("username_message").innerHTML = "请录入用户名！";
			return false;
		} else {
			document.getElementById("username_message").innerHTML = "";
		}

		if (trim(oldpassword).length == 0) {
			document.getElementById("oldpassword_message").innerHTML = "请输入旧密码！";
			return false;
		} else {
			document.getElementById("oldpassword_message").innerHTML = "";
		}
		
		
		if (trim(newpassword).length < 6) {
			document.getElementById("newpassword_message").innerHTML = "密码不能少于 \"6\" 位有效字符！";
			return false;
		} else {
			document.getElementById("newpassword_message").innerHTML = "";
		}

		if (newpassword != repassword) {
			document.getElementById("repassword_message").innerHTML = "确认密码不一致！";
			return false;
		} else {
			document.getElementById("repassword_message").innerHTML = "";
		}

		if ("123456" == newpassword) {
			document.getElementById("repassword_message").innerHTML = "新密码不能为默认密码123456！";
			return false;
		} else {
			document.getElementById("repassword_message").innerHTML = "";
		}
		//提交后页面变灰
		popSignFlow(1);

		//修改密码
		applyChange.editPassword(username, oldpassword, newpassword, result);
	}

	//回调函数，显示修改密码结果
	function result(obj) {
		var message = obj.split(",");
		//页面变灰恢复正常
		cancelSign();
		if (message[0] == "result_message") {
			alert(message[1]);
			window.close();
			window.returnValue = true;
		} else {
			document.getElementById(message[0]).innerHTML = message[1];
		}
	}
	//
</script>
<style type="text/css">
.but_y_01 {
	float: none;
}

.but_y_02 {
	float: none;
}
</style>
</head>
<%@ include file="/epp/css/cssControl.jsp"%>
<body class="contentbodymargin" onload="" scroll="no"
	style="overflow-y: hidden;">

<form id="form1" action="addconferenceroomresult.jsp" method="post">

<div id="users-contain">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="leaderlist_addbox">
	<tr>
		<th class="content_02_box_div_table_th"><span class="color_red">*</span>用户名：</th>
		<td class="content_02_box_div_table_td" colspan="3"><input
			style="width: 50%" type="text" name="username" class="input_188"
			id="username" value="<%=request.getParameter("loginName")%>" readonly /> <span
			id="username_message" style="color: #CC0000;" /></td>
	</tr>

	<tr>
		<th class="content_02_box_div_table_th"><span class="color_red">*</span>旧密码：</th>
		<td class="content_02_box_div_table_td" colspan="3"><input
			style="width: 50%" type="password" name="oldpassword" id="oldpassword"
			class="input_188"
			value="<%=StringUtil.deNull(request.getParameter("password"))%>" /> <span
			id="oldpassword_message" style="color: #CC0000;" /></td>

	</tr>

	<tr>
		<th class="content_02_box_div_table_th"><span class="color_red">*</span>新密码：</th>
		<td class="content_02_box_div_table_td" colspan="3"><input
			style="width: 50%" type="password" name="newpassword"
			class="input_188" /> <span id="newpassword_message"
			style="color: #CC0000;" /></td>
		<td></td>
	</tr>

	<tr>
		<th class="content_02_box_div_table_th"><span class="color_red">*</span>确认密码：</th>
		<td class="content_02_box_div_table_td" colspan="3"><input
			style="width: 50%" type="password" name="repassword"
			class="input_188" /> <span id="repassword_message"
			style="color: #CC0000;" /></td>
	</tr>

	<tr>
		<td colspan="4" align="center">
		<div class="cue_box_foot" >
			<input name="calc" type="button" class="but_y_01" value="关   闭"
				onClick="removeAlertWindows('',true)" /> 
			<input name="update" type="button"
				onclick="editpass();" class="but_y_01" value="修   改" /> 
		</div>
		</td>
	</tr>

</table>

</div>
<div style="text-align: center"></div>

</form>
</body>
</html>
