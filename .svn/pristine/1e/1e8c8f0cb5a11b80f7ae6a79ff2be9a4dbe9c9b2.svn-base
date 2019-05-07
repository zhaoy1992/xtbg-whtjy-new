<%--
描述：专家库管理界面
作者：邱炼
版本：1.0
日期：2014-02-17
--%>
<%@page import="com.chinacreator.xtbg.tjy.review.service.ReviewUserService"%>
<%@page import="com.chinacreator.xtbg.tjy.review.service.impl.ReviewUserServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	//主键ID
	String ru_id = request.getParameter("ru_id");
	
	//类型业务
	ReviewUserService service = new ReviewUserServiceImpl();
	if("insert".equals(actionName)){
		//ID
		bean.put("ru_id","");
		//专家名称
		bean.put("ru_name","");
		//专业类别
		bean.put("ru_type","");
		//职称级别
		bean.put("ru_profess", "");
		//当前系统时间
		bean.put("ru_creatortime", DateUtil.getCurrentDateTime());
	
	} else {
		bean = service.getReviewUserBean(ru_id);
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>专家库管理</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#ru_name").focus();
	});
/*
函数:  Ok
说明:  提交添加与修改来文单位
参数:   无
返回值: 无
*/
function Ok() {
	var isFlag = jQuery('#form1').validationEngine('validate'); //是否全部验证通过
	if (isFlag){
		jQuery("#hidden_action").val("addInfo");
		jQuery("#form1").attr("target","filetypeinfodoJSPhiddenFrame");
		jQuery("#form1").submit();
	}
}
afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					getParentWindow("windowId").userSearch();
					removeAlertWindows("windowId",true);
			} else {
				alert(result);
				getParentWindow("windowId").userSearch();
				removeAlertWindows("windowId",true);
			}
			
		}
	}catch(e){alert(e.description);}
};
function closed(){
	removeWindows('',true);
}

/**
 * 选取人员
 */
var chooseReportUnits = function(){
	var s = new $.z_tree();
	  s.treeID='mian';
	  s.treetypestr="radio";
	  s.ischekc="false";
	  s.isShowSeacher=true;
	  s.treeName="选取人员";
	  s.headerName="选取人员";
	  s.type="APERSON";
	  s.selectedIds=$('#ru_userid').val();
	  s.returnFunction=function(orgObj){
		 $('#ru_userid').val(orgObj.id);
	  	 $('#ru_name').val(orgObj.name);
	  }
  	 s.init();
	  
}	
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="reviewUserinfodo.jsp" method="post"  >
		<input type="hidden" name="ru_id" id="ru_id" value="<%=StringUtil.deNull(bean.get("ru_id"))%>">
		<input type="hidden" name="ru_userid" id="ru_userid" value="<%=StringUtil.deNull(bean.get("ru_userid"))%>">
		<input type="hidden" name="ru_creatortime" id="ru_creatortime" value="<%=StringUtil.deNull(bean.get("ru_creatortime"))%>">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>人员信息：</th>
						<td class="content_02_box_div_table_td"><input type="text" name="ru_name" id="ru_name" class="validate[required,maxSize[50]] input_160" style="height=23px" 
							value="<%=StringUtil.deNull(bean.get("ru_name"))%>" onclick="chooseReportUnits()">
						<input name="" type="button" value="" class="but_x" onclick="chooseReportUnits()"/></td>
						</td>
						
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>专业类别：</td>
						<td class="content_02_box_div_table_td"><input type="text" name="ru_type" id="ru_type" 
						 class="validate[required,maxSize[100]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("ru_type"))%>">
						</td>
						
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable"><font color="red">*</font>职称级别：</td>
						<td class="content_02_box_div_table_td"><input style="width:90%;height=23px" type="text" name="ru_profess" class="validate[required,maxSize[50]] input_188"
							id="ru_profess"
							value="<%=StringUtil.deNull(bean.get("ru_profess"))%>">
						</td>
					</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="返回" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="完成" onclick="Ok()"/>
		</div>
		
	</form>
	
	<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>