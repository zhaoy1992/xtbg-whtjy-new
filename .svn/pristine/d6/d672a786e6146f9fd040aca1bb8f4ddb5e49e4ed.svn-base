<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant"%>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID(); //用户id
	String user_name = accesscontroler.getUserName(); //用户中文名

	String table = request.getParameter("table");
	String column = request.getParameter("column");
	
	StringBuffer sql = new StringBuffer();
	sql.append("select Idea_Content,Idea_Content from OA_DOCUMENT_COMIDEA");

	String commonIdeaList = DictDropDownList.buildSelect(sql.toString(),
			"common_idea", "", "", true, "","width:100px");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="java.util.List"%>

<head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery_dialog -->
<script src="../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
var table = '<%=table%>';
var column = '<%=column%>';
var ycidearid = "YJ<%=Constant.SEPARATOR %>"+table+"<%=Constant.SEPARATOR %>"+column;//意见隐藏域
var idearid = table+"<%=Constant.SEPARATOR %>"+column;//意见textarea
var hisidearid ="HIS<%=Constant.SEPARATOR %>"+table+"<%=Constant.SEPARATOR %>"+column;//历史数据
jQuery(function() { 
	var content ="";
	jQuery("select[id*=common_idea]").change(function(){
		if(jQuery("#common_idea").val() == '只签名'){
			jQuery("#idea_info").val(content);
		}else{
			jQuery("#idea_info").val(jQuery("#common_idea").val());
		}
		if(jQuery("#idea_info").val() == content){
			jQuery("#idea_info").attr("disabled",true);
		}else{
			jQuery("#idea_info").attr("disabled",false);
		}
	}); 
	jQuery("#button_submit").bind("click",onsubmit);
	var idea = getParentWindow("").jQuery("[id='"+idearid+"']").val().replace(/\n.*/,"");
	//if(idea == content){
	//	jQuery("#idea_info").attr("disabled",true);
	//}else{
	//	jQuery("#idea_info").attr("disabled",false);
	//}
	jQuery("#idea_info").focus();
	jQuery("#idea_info").val(getParentWindow("").jQuery("[id='"+ycidearid+"']").val().replace(/\n.*/,""));
	
});
	function onsubmit(){
		if(!IsSpace(jQuery("#idea_info").val())){
				if(IsSpace(getParentWindow("").jQuery("[id='"+hisidearid+"']").val())){
					getParentWindow("").jQuery("[id='"+idearid+"']").val(jQuery("#idea_info").val()+"\n<%=user_name%>   <%=DateUtil.getCurrentDate_Time()%>");
				}else{
					getParentWindow("").jQuery("[id='"+idearid+"']").val(jQuery("#idea_info").val()+"\n<%=user_name%>  <%=DateUtil.getCurrentDate_Time()%>"+"\n"+getParentWindow("").jQuery("[id='"+hisidearid+"']").val());
				}
		}else{
			getParentWindow("").jQuery("[id='"+idearid+"']").val(getParentWindow("").jQuery("[id='"+hisidearid+"']").val());
		}
		getParentWindow("").jQuery("[id='"+ycidearid+"']").val(jQuery("#idea_info").val()+"\n<%=user_name%>   <%=DateUtil.getCurrentDate_Time()%>");
		//getParentWindow("").createIdeaInfo();
		removeAlertWindows('',true);
	}


</script>
<title>输入意见信息</title>
</head>
<body >
<form id="form1" name="form1" method="post">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="padding-top: 10px;">
			<tr>
				<td class="poptableLable" width="15%" align="right">常用意见：&nbsp;</td>
				<td><%=commonIdeaList %></td>
			</tr>
			<tr><td colspan="2" height="5"></td></tr>
			<tr>
				<td class="poptableLable" width="15%" align="right">意见信息：&nbsp;</td>
				<td  class="tableValue" width="70%" >
				<textarea class="validate[required,maxSize[500]]" rows="5"
				 style="width: 95%;overflow-y:auto;"  name="idea_info"
					id="idea_info"></textarea>
				</td>
			</tr>
		</table>
	<div class="cue_box_foot">
		<input  type="button" class="but_y_01" id="button_submit"  value="确定" /></span>
  	</div>
</form>
</body>
</html>