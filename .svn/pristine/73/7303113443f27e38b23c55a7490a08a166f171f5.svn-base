<%--
描述：个人资料分类基本信息
作者：邱炼
版本：1.0
日期：2013-08-12
--%>
<%@page import="com.chinacreator.xtbg.core.persondata.service.impl.PsdataTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.persondata.service.PsdataTypeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	String actionNameStr = "";
	//当前类别ID
	String p_type_id = "";
	//父类别ID
	String p_type_parentid = "";
	
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	PsdataTypeService service=new PsdataTypeServiceImpl();
	if("insert".equals(actionName)){
		//单位信息
		bean.put("p_type_unit",userBean.getUnit_id());
		bean.put("p_type_unit_name",userBean.getUnit_name());
		//用户信息
		bean.put("p_creater_userid",accesscontroler.getUserID());
		bean.put("p_creater_username",accesscontroler.getUserName());
		//当前系统时间
		bean.put("p_creater_time",DateUtil.getCurrentDateTime());
		//父级类别
		p_type_parentid = request.getParameter("p_type_parentid");
		//父级类别信息
		if(!StringUtil.isBlank(p_type_parentid)){
			Map<String,String> parentBean = service.getPsdataTypeBean(p_type_parentid);
			bean.put("p_type_parentid",p_type_parentid);
			bean.put("p_parent_name",parentBean.get("p_type_name"));
		} else {
			bean.put("p_type_parentid","0");
			bean.put("p_parent_name","");
		}
		//排序号
		String whereSql ="";
		if(!StringUtil.isBlank(p_type_parentid)){
			whereSql="  p_type_parentid='"+p_type_parentid+"' and p_creater_userid='"+accesscontroler.getUserID()+"'";
		} else {
			whereSql=" 1=1";
		}
		String p_type_order = PsdataTypeServiceImpl.getOrder("p_type_order","oa_persondata_type",whereSql)+"";
		bean.put("p_type_order",p_type_order);
	} else {
		p_type_id = request.getParameter("p_type_id");
		//父级类别
		p_type_parentid = request.getParameter("p_type_parentid");
		bean = service.getPsdataTypeBean(p_type_id);
		//单位信息
		bean.put("p_type_unit",bean.get("p_type_unit"));
		bean.put("p_type_unit_name",userBean.getUnit_name());
		//当前系统时间
		bean.put("p_creater_time",bean.get("p_creater_time"));
		Map<String,String> parentbean= service.getPsdataTypeBean(p_type_parentid);
		//父类别名称
		bean.put("p_parent_name", parentbean.get("p_type_name"));
	}
	
	if("update".equals(actionName)){
		actionNameStr = "修改资料分类信息";
	} else if("insert".equals(actionName)){
		actionNameStr = "资料分类信息";
	} else if("query".equals(actionName)){
		actionNameStr = "资料分类信息";
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">jQuery.noConflict();</script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- 引入formvValidatetion -->
	<link rel="stylesheet" href="../../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
	<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script type="text/javascript" src="../../../resources/util/public.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<!-- 引入jGrid -->
	<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
	<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	<script type="text/javascript" src="../../../resources/util/jsonutil.js" ></script>
	
	<script type="text/javascript">
			updateFn = function(flag,inputObj){
				try{
					inputObj.disabled=true;
					if(flag==='save'){
						var isFlag = jQuery('#formTable').validationEngine('validate'); //是否全部验证通过
						if (isFlag){
							jQuery("#hidden_action").val("addPsdataTypeInfo");
							jQuery("#onlyFrom").submit();
						}
					}else if(flag==='back'){
						var p={
							headerText:'提示',
							okName:'确认',
					        okFunction:function(){
					        	removeWindows('psdatatypeinfo',true);
					        },
					        cancelName:'取消'
						};
						alert("返回后，数据将不会保存，确定返回？",p);
					}
					inputObj.disabled=false;
				}catch(e){alert(e.description);inputObj.disabled=false;}
			};
			
			<%--提交后回调--%>
			afterSubmitFn=function(result){
				try{
					if(result.indexOf("delete")!=-1){
						alert(result.split(",")[1]);
						searchData();
					}else{
						if(result.split(",").length>1){
								result = result.split(",");
								alert(result[0]);
								window.parent.location.href="<%=path%>/ccapp/oa/persondata/type/jsp/psdatatypemain.jsp?p_type_id=<%=p_type_parentid%>";
						} else {
							alert(result);
							window.parent.location.href="<%=path%>/ccapp/oa/persondata/type/jsp/psdatatypemain.jsp?p_type_id=<%=p_type_parentid%>";
						}
						
					}
				}catch(e){alert(e.description);}
			};
		</script>
</head>
<body style="overflow-x: auto;" onload="adaptationWH('_top','tabs1',0);">
<div id='tabs1' style="width:100%">
<%--button list--%>
<div class="content_02_top" style="margin-bottom:10px;width:99%" id="divA">
		<input type="button" class="but_y_01" value="保存" onclick="updateFn('save',this);" id="btn_insert"/>
		<input type="button" class="but_y_01" value="返回" onclick="updateFn('back',this);" id="btn_update"/>
</div>
<%--button list--%>

<form id="onlyFrom" name="onlyFrom" method="post" action="psdatatypeinfodo.jsp" target="filetypeinfodoJSPhiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<input value="<%=StringUtil.deNull(bean.get("p_type_id"))%>" type='hidden' name='p_type_id' id="p_type_id"/>

<table>
	<tr>
		<td width="98%" align="left" valign="top">
			<div id="vcenter" style="float:left;width:100%; overflow:hidden">
				<div class="content_02_box" >
					<div class="content_02_box_title_bg"><span><%=actionNameStr%></span></div>
					<div class="content_02_box_div">
						<table id='formTable' border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;"><span style="color: red;">*</span>资料分类名称：</th>
								<td  class="content_02_box_div_table_td" style="width: 220px;">
									<input value="<%=StringUtil.deNull(bean.get("p_type_name"))%>" type="text" name="p_type_name" id="p_type_name" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[required,maxSize[100]] input_title_text"/>
								</td>
									<th class="content_02_box_div_table_th" style="width: 150px;">所属单位：</th>
								<td class="content_02_box_div_table_td" >
									<input value="<%=StringUtil.deNull(bean.get("p_type_unit_name"))%>" readonly="readonly" type="text" name="p_type_unit_name" id="p_type_unit_name" class="validate[required,maxSize[100]] input_title_text"/>
									<input value="<%=StringUtil.deNull(bean.get("p_type_unit"))%>" type="hidden" name="p_type_unit" id="p_type_unit" class="validate[required,maxSize[40]] input_title_text"/>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;">所属上级分类：</th>
								<td class="content_02_box_div_table_td">
									<input value="<%=StringUtil.deNull(bean.get("p_parent_name"))%>" readonly="readonly" type="text" name="p_parent_name" id="p_parent_name" class="validate[maxSize[100]] input_title_text"/>
									<input value="<%=StringUtil.deNull(bean.get("p_type_parentid"))%>" type="hidden" name="p_type_parentid" id="p_type_parentid"/>
								</td>
								<th class="content_02_box_div_table_th" style="width: 150px;"><span style="color: red;">*</span>排序号：</th>
								<td class="content_02_box_div_table_td">
									<input value="<%=StringUtil.deNull(bean.get("p_type_order"))%>" type="text" name="p_type_order" id="p_type_order" class="validate[required,maxSize[40],custom[number]] input_title_text"/>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;">登记人：</th>
								<td class="content_02_box_div_table_td">
									<input value="<%=StringUtil.deNull(bean.get("p_creater_username"))%>" readonly="readonly" type="text" name="p_creater_username"  id="p_creater_username" class="input_title_text"/>
									<input value="<%=StringUtil.deNull(bean.get("p_creater_userid"))%>" type="hidden" name="p_creater_userid" id="p_creater_userid"/>
								</td>
								<th class="content_02_box_div_table_th" style="width: 150px;">登记时间：</th>
								<td class="content_02_box_div_table_td">
									<input value="<%=StringUtil.deNull(bean.get("p_creater_time"))%>" readonly="readonly" name="p_creater_time" id="p_creater_time" class="input_title_text"/>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;">备注：</th>
								<td class="content_02_box_div_table_td" colspan="3">
									<textarea style="height: 80px; overflow: auto;" class="validate[maxSize[500]] input_title_text" name="p_remark" id="p_remark"><%=StringUtil.deNull(bean.get("p_remark"))%></textarea>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</td>
	</tr>
</table>
</form>
<iframe name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
</div>
<script>
if(jQuery("#vcenter").width()>jQuery("body").width()){<%--1024*?分辨率下,拉长divA宽度--%>
	jQuery("#divA").width(jQuery("#vcenter").width()+10);
}else{<%--1440*?分辨率下,缩短divA宽度,防止横向滚动条出现--%>
	jQuery("#divA").width(jQuery("body").width()-19);
}
</script>
</body>
<script type="text/javascript" >
jQuery(function(){
	jQuery("#formTable").validationEngine();
});
</script>
</html>
