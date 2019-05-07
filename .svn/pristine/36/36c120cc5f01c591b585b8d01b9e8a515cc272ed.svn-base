<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.chinacreator.xtbg.jiaoyuksy.userstamp.dao.imploracle.UserStampDaoImpl"%>
<%@page import="com.chinacreator.xtbg.jiaoyuksy.userstamp.dao.UserStampDao"%>
<%@page import="java.util.HashMap"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID(); //用户id
	String user_name = accesscontroler.getUserName(); //用户中文名
	
	UserStampDao userStampDao = new UserStampDaoImpl();
	HashMap<String,String > map = (HashMap<String,String>)userStampDao.findUserStampByUserId(user_id);
	String password = map.get("stamp_password");
		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<html>
<head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery_dialog/jquery_dialog.css" />

<!-- 引入公共JS -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>

<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>


<meta http-equiv="Content-Type" content="text/html; charset=GBK">

<script type="text/javascript">
var user_id = "<%=user_id%>";
	jQuery.noConflict();    

jQuery(function(){
	jQuery(document).bind("keydown",function(e){
		if(event.keyCode==13){
			onsubmit();
		}
	})
	
	jQuery("#button_submit").bind("click",onsubmit);
})

function onsubmit(){
	window.returnValue = jQuery("#seal_password").val();
	window.close();
}


</script>
<title>请输入盖章密码</title>
</head>
<body >
<form id="form1" name="form1" method="post" >
	<input type=hidden id="user_id" name="user_id" value="<%=user_id %>"></input>
	<table style="width:98%; margin-bottom: 10px;"align="center">
			<tr >
				<th class="content_02_box_div_table_th" >盖章密码</th>
				<td class="content_02_box_div_table_td" width="75%" >
				<input type="password" id="seal_password" name="seal_password" style="width: 50%"
				 class="cText_out validate[maxSize[15]]"  value="" 
				 onkeydown="javascript:if(event.keyCode==13) return false;"   onkeypress=""></input>
				</td>
			</tr>
			<tr>
				<td   align="center" colspan="2">
					<input  type="button" class="but_y_01" id="button_submit"  value="确定" />
				</td>
			</tr>
	</table>
</form>
<IFRAME name=frame1 width=100% height=0> </IFRAME>
</body>
</html>