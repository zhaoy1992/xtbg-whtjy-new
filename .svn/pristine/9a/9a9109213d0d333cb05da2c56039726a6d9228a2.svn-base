
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieTypeService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsupplieTypeServiceImpl"%>
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
    
	String actionName = request.getParameter("actionName");
	String oftype_id = request.getParameter("oftype_id");
	Map<String,String> map = new HashMap<String,String>();
	OsupplieTypeService service = new OsupplieTypeServiceImpl();
	
	if(!StringUtil.isBlank("oftype_id") && actionName.equals("update")){
		map = service.getOsupplieTypeBean(oftype_id,"");
	}else{
		map.put("unit_id",unit_id);
		map.put("unit_name",unit_name);
		map.put("parent_id","");
	}
	//父类别选择框
	String sql = " select  oftype_id as parent_id,oftype_name from ta_oa_osupplietype where unit_id = '"+unit_id+"' and parent_id is null";
	String p_oftype = DictDropDownList.buildSelect(sql,"parent_id",StringUtil.deNull(map.get("parent_id")),"",true,"");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>缓急程度维护</title>
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
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript">
var action = "<%=actionName%>";
	jQuery(document).ready(function() {
		jQuery("#form1").validationEngine();
		jQuery("#oftype_name").focus();
		if(action == "update"){//更新
		}else if(action == "insert"){//新增父
			jQuery("#p_oftype").hide();
		}else if(action == "insert1"){//新增子
		}
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
		jQuery("#hidden_action").val("addOsupplieTypeInfo");
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
					getParentWindow("windowId").closeAlertWin();
					getParentWindow("windowId").userSearch();
					removeAlertWindows("windowId",true);
			} else {
				alert(result);
				getParentWindow("windowId").closeAlertWin();
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
	var value = $("#oetype_no").val(); //排序号值
	if(value.search(pattern)!=0 ){
		 alert("排序号只能是数字");
		return false;
		}   
	if (document.getElementById('oetype_no').value != ""
			&& document.getElementById('oetype_no').value <= 0) {
		alert("排序号必须大于0！");
		return false;
	}
	return true;
}
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="osupplietypedo.jsp" method="post"  >
		<input type="hidden" name="oftype_id" id="oftype_id" value="<%=StringUtil.deNull(map.get("oftype_id")) %>">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>类别名称：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="oftype_name" id="oftype_name" class="validate[required,maxSize[200]] input_188" 
							       style="width:90%;height=23px" value="<%=StringUtil.deNull(map.get("oftype_name")) %>">
						</td>
					</tr>
					<tr id = "p_oftype">
						<th class="content_02_box_div_table_th"><font color="red">*</font>父类别名称：</th>
						<td class="content_02_box_div_table_td">
							<%=p_oftype %>
						</td>
					</tr>
					<tr>
						<th class="content_02_box_div_table_th">所属单位名称：</th>
						<td class="content_02_box_div_table_td">
							<input type="text" name="unit_name" id="unit_name" readonly="readonly"class="input_188" 
							       style="width:90%;height=23px" value="<%=StringUtil.deNull(map.get("unit_name")) %>">
							<input type="hidden" id="unit_id" name="unit_id" value="<%=StringUtil.deNull(map.get("unit_id")) %>"/> 
						</td>
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>排序号：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="oftype_no" id="oftype_no"class="validate[required,maxSize[10],custom[positiveinteger]] input_188" 
							       style="width:90%;height=23px" value="<%=StringUtil.deNull(map.get("oftype_no")) %>">
						</td>
						
					</tr>
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable">备注：</td>
						<td class="content_02_box_div_table_td">
							<input style="width:90%;height=23px" type="text" name="oftype_remark" class="validate[maxSize[200]] input_188" 
							       id="oftype_remark"value="<%=StringUtil.deNull(map.get("oftype_remark")) %>">
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