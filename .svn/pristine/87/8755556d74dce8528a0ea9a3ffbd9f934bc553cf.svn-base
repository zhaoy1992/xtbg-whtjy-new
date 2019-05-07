<%--
描述：物品规格维护界面
作者：邱炼
版本：1.0
日期：2014-02-17
--%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsupplieUseTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsupplieUseTypeService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.OsUserTypeItemService"%>
<%@page import="com.chinacreator.xtbg.tjy.officesupplies.service.impl.OsUserTypeItemServiceImpl"%>
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
	//当前系统时间
	String time = DateUtil.getCurrentDateString("yyyy-MM-dd");
	//获得当前登录用户所属单位信息
	UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
	String unit_id = usercachebean.getUnit_id();
	String unit_name = usercachebean.getUnit_name();
	
	Map<String,String> bean = new HashMap<String,String>();
	//物品名称信息
	Map<String, String> userTypeMapBean = new HashMap<String,String>();
	String actionName = request.getParameter("actionName");
	//ID
	String it_id = request.getParameter("it_id");
	//类型业务
	OsUserTypeItemService serviceType = new OsUserTypeItemServiceImpl();
	if("insert".equals(actionName)){
		//ID
		bean.put("it_id","");
		//名称
		bean.put("it_name","");
		//说明
		bean.put("it_remark","");
		//排序号
		bean.put("it_no", "");
		//所属单位信息
		bean.put("unit_id", unit_id);
		bean.put("unit_name", unit_name);
	} else {
		bean = serviceType.getOsUserTypeItemBean(it_id);
		OsupplieUseTypeService osupplieusetypeservice = new OsupplieUseTypeServiceImpl();
		userTypeMapBean = osupplieusetypeservice.getOsupplieUseTypeBean(StringUtil.deNull(bean.get("it_typeid")));
	}
	
	String oftype_id = request.getParameter("oftype_id");
	String sql = null;
	if(StringUtil.isBlank(oftype_id)){
		sql = "select distinct t.ofustype_id,t.ofustype_name from TA_OA_HAVA_OBJECT t where t.unit_id = '"+unit_id+"'";
	}else{
		sql = "select distinct t.ofustype_id,t.ofustype_name from TA_OA_HAVA_OBJECT t where t.unit_id = '"+unit_id+"' and t.oftype_id = '"+oftype_id+"'";
	}
	String infotypeHtml = DictDropDownList.buildSelect(sql,"it_typeid",StringUtil.deNull(bean.get("it_typeid")),"",false,"");//物品类型下拉框
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
		jQuery("#it_name").focus();
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
		getParentWindow("windowId").userSearch();
		removeAlertWindows("windowId",true);
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
	var value = $("#it_no").val(); //排序号值
	if(value.search(pattern)!=0 ){
		 alert("排序号只能是数字");
		return false;
		}   
	if (document.getElementById('it_no').value != ""
			&& document.getElementById('it_no').value <= 0) {
		alert("排序号必须大于0！");
		return false;
	}
	return true;
}
</script>
<body style="overflow-y:hidden;">
	<form id="form1" action="osusertypeIteminfodo.jsp" method="post"  >
		<input type="hidden" name="it_id" id="it_id" value="<%=StringUtil.deNull(bean.get("it_id"))%>">
		<input type='hidden' name='action' id="hidden_action"/>
		<input type="hidden" name="user_id" id="user_id" value="<%=userId%>">
		<input type="hidden" name="user_name" id="user_name" value="<%=userName %>"/>
		<input type="hidden" name="time" id="time" value="<%=time %>"/>
		<input type="hidden" name="windowsId" id="windowsId" value='<%=StringUtil.deNull(request.getParameter("windowsId"))%>'/>
		<input type="hidden" name="unit_id" id="unit_id" value='<%=StringUtil.deNull(bean.get("unit_id"))%>'/>
		<input type="hidden" name="unit_name" id="unit_name" value='<%=StringUtil.deNull(bean.get("unit_name"))%>'/>
		<div id="users-contain">
			<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<th class="content_02_box_div_table_th"><font color="red">*</font>物品规格名称：</th>
						<td class="content_02_box_div_table_td"><input type="text" name="it_name" id="it_name" class="validate[required,maxSize[200]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("it_name"))%>">
						</td>
						
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th"><font color="red">*</font>排序号：</td>
						<td class="content_02_box_div_table_td"><input type="text" name="it_no" id="it_no" 
						 class="validate[required,maxSize[10],custom[positiveinteger]] input_188" style="width:90%;height=23px" 
							value="<%=StringUtil.deNull(bean.get("it_no"))%>">
						</td>
						
					</tr>
					<tr>
						<td  class="content_02_box_div_table_th">物品名称：</td>
						<td class="content_02_box_div_table_td">
							<%if("insert".equals(actionName)){//新增的时候显示全部的物品信息%>
								<%=infotypeHtml%>
							<%} else{//修改的时候  只显示添加的物品 %>
								<%=userTypeMapBean.get("ofustype_name")%>
							<%} %>
						</td>
						
					</tr>
					<!--  
					<tr>
						<td class="content_02_box_div_table_th">数量：</td>
						<td class="content_02_box_div_table_td">
							<input type="text" name="number" id="number" style="width:90%;height=23px;" class="validate[required,maxSize[200]] input_188" value="">
						</td>
					</tr>
					-->
					<tr>
						<td class="content_02_box_div_table_th" class="poptableLable">备注：</td>
						<td class="content_02_box_div_table_td"><input style="width:90%;height=23px" type="text" name="it_remark" class="validate[maxSize[200]] input_188"
							id="it_remark"
							value="<%=StringUtil.deNull(bean.get("it_remark"))%>">
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