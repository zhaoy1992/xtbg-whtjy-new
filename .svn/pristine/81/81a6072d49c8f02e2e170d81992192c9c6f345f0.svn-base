<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>

<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID(); //用户id
	String user_name = accesscontroler.getUserName(); //用户中文名

	String send_id = request.getParameter("send_id");
	String ideatextid = request.getParameter("ideaid");
	String action_defid = request.getParameter("action_defid");
	
	String infor_cz = request.getParameter("infor_cz");  // 郴州请假管理个性化参数
	
	StringBuffer sql = new StringBuffer();
	//update by shixing.he begin 望城OA的常用意见绑定到个人
	String userArea = CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");
	if("421005".equals(userArea)){//望城OA
		sql.append("select Idea_Content,Idea_Content from TA_OA_DOCUMENT_COMIDEA t ");
		sql.append(" where t.user_id is null or (t.user_id is not null and t.user_id = '"+user_id+"')");
	} else {
		sql.append("select Idea_Content,Idea_Content from TA_OA_DOCUMENT_COMIDEA");
	}
	//update by shixing.he end 望城OA的常用意见绑定到个人

	String commonIdeaList = DictDropDownList.buildSelect(sql.toString(),
			"common_idea", "", "", true, "","width:358px");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="java.util.List"%>

<head>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
var ideatextid = '<%=ideatextid%>';
jQuery(function() {
	var content ="";                            
	<%if("yes".equals(infor_cz)){%>
	 jQuery("input[name=czflow_info]").change(function(){
			 jQuery("#idea_info").val(jQuery("input[name=czflow_info]:checked").val());
	 }); 
	<%}else{ %>
	jQuery("select[id*=common_idea]").change(function(){
		if(jQuery("#common_idea").val() == '只签名'){
			jQuery("#idea_info").val(content);
		}else{
			jQuery("#idea_info").val(jQuery("#common_idea").val());
		}
	  //获得oacommon下配置文件中对应项目配置的InputIdeare属性的值
		<%if(CacheCommonManageProxy.getBooleanSystemParam("InputIdeare")){%>
			if(jQuery("#idea_info").val() == content){
				jQuery("#idea_info").attr("disabled",true);
			}else{
				jQuery("#idea_info").attr("disabled",false);
			}
		<%}%>
	}); 
	<%} %>		
	jQuery("#button_submit").bind("click",onsubmit);
	var idea = getParentWindow("").jQuery('#action_handeridea').val().replace(/\n.*/,"");
	jQuery("#idea_info").focus();
	
	var str = getParentWindow("").jQuery('#action_handeridea').val();
	if(str){
		if(str.lastIndexOf('\n')>=0){<%--多行意见,多个\n--%>
			jQuery("#idea_info").val(str.substring(0,str.lastIndexOf('\n')));
		}else{
			jQuery("#idea_info").val(str);
		}
	}
	
});
	function onsubmit(){
		var s = (getParentWindow("").jQuery('#action_handeridea').val().replace("\n<%=user_name%>   <%=DateUtil.getCurrentDate_Time()%>",""));
		if(!IsSpace(jQuery("#idea_info").val())){
				if(IsSpace(getParentWindow("").jQuery("action_handeridea").val())){
					getParentWindow("").jQuery("#action_handeridea").val(jQuery("#idea_info").val()+"\n<%=user_name%>   <%=DateUtil.getCurrentDate_Time()%>");
				}else{<%--百分百 进不来--%>
					getParentWindow("").jQuery("#action_handeridea").val(getParentWindow("").jQuery("#action_handeridea").val()+"\n"+jQuery("#idea_info").val()+"\n<%=user_name%>  <%=DateUtil.getCurrentDate_Time()%>");
				}
		}else{
			if(jQuery("#idea_info").val() == ''){
					getParentWindow("").jQuery("#action_handeridea").val(jQuery("#idea_info").val()+"\n<%=user_name%>   <%=DateUtil.getCurrentDate_Time()%>");
			}else{<%--几乎 进不来--%>
				getParentWindow("").jQuery("#action_handeridea").val(getParentWindow("").jQuery("#action_handeridea").val());
			}
		}
		getParentWindow("").createIdeaInfo();
		removeAlertWindows('',true)
	}


</script>
<title>输入意见信息</title>
</head>
<body >
<form id="form1" name="form1" method="post">
	<table width="100%" border="0" cellpadding="0" cellspacing="0" style="padding-top: 10px;">
	<%if("yes".equals(infor_cz)){%>
	        <tr>
				<td class="poptableLable" width="15%" align="right">常用意见：&nbsp;</td>
				<td><input type="radio" name="czflow_info" id="czflow_info1" value="同意" />同意&nbsp;&nbsp;<input type="radio" name="czflow_info" id="czflow_info2" value="不同意" />不同意</td>
			</tr>
	<%}else{ %>
			<tr>
				<td class="poptableLable" width="15%" align="right">常用意见：&nbsp;</td>
				<td><%=commonIdeaList %></td>
			</tr>
	<%} %>		
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