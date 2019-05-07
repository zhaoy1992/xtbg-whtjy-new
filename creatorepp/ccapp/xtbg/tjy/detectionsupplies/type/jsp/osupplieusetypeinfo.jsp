<%--
描述：常用物品维护界面
作者：邱炼
版本：1.0
日期：2014-02-18
--%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.OsupplieUseTypeService"%>
<%@page import="com.chinacreator.xtbg.tjy.detectionsupplies.service.impl.OsupplieUseTypeServiceImpl"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	 //获得当前登录的用户信息
    String userId = accesscontroler.getUserID();
    String userName = accesscontroler.getUserName();
    //获得当前登录用户所属单位信息
    UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
    String unit_id = usercachebean.getUnit_id();
    String unit_name = usercachebean.getUnit_name();
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	//物品ID
	String ofustype_id = request.getParameter("ofustype_id");
	//新增物品
	boolean ofustype_flag = true;
	
	String oftype_id = "";
	
	//类型业务
	OsupplieUseTypeService serviceType = new OsupplieUseTypeServiceImpl();
	if("insert".equals(actionName)){
		//物品ID
		bean.put("ofustype_id","");
		//物品名称
		bean.put("ofustype_name","");
		//排序号
		bean.put("ofustype_no","");
		bean.put("unit_id",unit_id);
		bean.put("unit_name",unit_name);
	} else {
		bean = serviceType.getOsupplieUseTypeBean(ofustype_id);
		
		oftype_id = bean.get("oftype_id");
		ofustype_flag = false;
	}
	
	String sql = "select i.oftype_id, i.oftype_name from TA_OA_DETOSUPPLIETYPE i where i.oftype_flag in('1','2') and i.unit_id = '"+unit_id+"' order by i.oftype_no";  //易耗品类型
	
	
	String ofustypeHtml = DictDropDownList.buildSelect(sql,"oftype_id",oftype_id,"",true,"");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>缓急程度维护</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<!-- 引入其它 -->
<script src="../../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<!-- 引入jQuery_dialog -->
<script src="../../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>
<!-- 引入公共JS -->
<!-- 引入formvValidatetion -->
<script src="../../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript"src="../../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="UTF-8"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#ofustype_name").focus();
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
		jQuery("#hidden_action").val("addOsupplieUsetypeInfo");
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

/*
*方法说明:校验排序号
*参数：无
*返回值：true 或者 false  true：校验通过,false: 校验失败
*/
function myValidateNums(){
	var pattern = "^[0-9]*$"; //只能是数字
	var value = $("#ofustype_no").val(); //排序号值
	if(value.search(pattern)!=0 ){
		 alert("排序号只能是数字");
		return false;
		}   
	if (document.getElementById('ofustype_no').value != ""
			&& document.getElementById('ofustype_no').value <= 0) {
		alert("排序号必须大于0！");
		return false;
	}
	return true;
}
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="osupplieusetypeinfodo.jsp" method="post"  >
		<input type="hidden" name="ofustype_id" id="ofustype_id" value="<%=StringUtil.deNull(bean.get("ofustype_id"))%>">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<input type="hidden" name="unit_name" id="unit_name" value='<%=StringUtil.deNull(bean.get("unit_name"))%>'/>
		<input type="hidden" name="unit_id" id="unit_id" value='<%=StringUtil.deNull(bean.get("unit_id"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>物品名称：</th>
						<td class="content_02_box_div_table_td">
						<input type="text" name="ofustype_name" id="ofustype_name" style="width:90%;height=23px;" class="validate[required,maxSize[200]] input_188" value="<%=StringUtil.deNull(bean.get("ofustype_name"))%>">
						</td>
						
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>排序号：</td>
						<td class="content_02_box_div_table_td"><input type="text" name="ofustype_no" id="ofustype_no" 
						 class="validate[required,maxSize[10],custom[positiveinteger]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("ofustype_no"))%>">
						</td>
						
					</tr>
					
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>所属分类：</td>
						<td class="content_02_box_div_table_td">
						    <%=ofustypeHtml %>
						</td>
						
					</tr>
			</table>
		</div>
		
		<div class="cue_box_foot">
			<input class="but_y_01" type="button" value="关闭" onclick="removeAlertWindows('',true)" />
			<input class="but_y_01" type="button" id="sel"  value="保存" onclick="Ok()"/>
		</div>
		
	</form>
	
	<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>