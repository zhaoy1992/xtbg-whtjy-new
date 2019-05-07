<%--
描述：知识库分类基本信息
作者：肖杰
版本：1.0
日期：2013-08-20

--%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<%@page import="com.chinacreator.xtbg.core.data.entity.DataTypeBean"%>
<%@page import="com.chinacreator.xtbg.core.data.service.impl.DataTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.data.service.DataTypeService"%>
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
	String GET_LIST_CLASS ="com.chinacreator.xtbg.core.kbm.list.KbmDocTypeConfigList";
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	String actionNameStr = "";
	String d_type_id = "";
	String d_type_level = "";
	String d_type_parent_id = "";
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	boolean canEdit = false;
	DataTypeService service=new DataTypeServiceImpl();
	if("insert".equals(actionName)){
		canEdit = true;
		
		bean.put("d_type_unit_id",userBean.getUnit_id());
		bean.put("d_type_unit_name",userBean.getUnit_name());
		
		bean.put("d_type_user_id",accesscontroler.getUserID());
		bean.put("d_type_user_name",accesscontroler.getUserName());
		bean.put("d_type_create_time",DateUtil.getCurrentDateTime());
		d_type_level = request.getParameter("d_type_level");
		bean.put("d_type_level",d_type_level);
		d_type_parent_id = request.getParameter("d_type_parent_id");
		
		//设置默认排序
		String d_type_order=KbmUtil.getOrder("d_type_order", "oa_data_type", "d_type_parent_id",d_type_parent_id )+"";
		bean.put("d_type_order", d_type_order);
		if(d_type_parent_id!=null&&d_type_parent_id.length()>0){
			Map<String,String> parentBean = service.getDataTypeBean(d_type_parent_id);
			bean.put("d_type_parent_id",d_type_parent_id);
			bean.put("d_parent_name",parentBean.get("d_type_name"));
			
		}else{
			bean.put("k_parent_type_id","");
			bean.put("k_parent_name","");
		}
		if(DataTypeBean.D_TYPE_LEVEL_ONE.equals(d_type_level)){
			actionNameStr = "增加中间层分类";
			bean.put("d_type_level_name","中间层");
		}else if(DataTypeBean.D_TYPE_LEVEL_TWO.equals(d_type_level)){
			actionNameStr = "增加最底层分类";
			bean.put("d_type_level_name","最底层");
		}
	}else{
		d_type_id = request.getParameter("d_type_id");
		bean = service.getDataTypeBean(d_type_id);
		d_type_parent_id=bean.get("d_type_parent_id");
		Map<String,String> parentbean= service.getDataTypeBean(d_type_parent_id);
		bean.put("d_parent_name", parentbean.get("d_type_name"));
		d_type_level = bean.get("d_type_level");
		if(DataTypeBean.D_TYPE_LEVEL_ONE.equals(d_type_level)){
			bean.put("d_type_level_name","中间层");
		}else if(DataTypeBean.D_TYPE_LEVEL_TWO.equals(d_type_level)){
			bean.put("d_type_level_name","最底层");
		}
		if("update".equals(actionName)){
			actionNameStr = "修改档案分类信息";
			canEdit = true;
		}else if("query".equals(actionName)){
			actionNameStr = "档案分类信息";
			canEdit = false;
		}
	}
	
	//2:needRECURSION
	boolean needRecursion = true;
	if(DataTypeBean.D_TYPE_LEVEL_TWO.equals(bean.get("d_type_level"))){
		needRecursion = false;
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">jQuery.noConflict();</script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- 引入formvValidatetion -->
	<link rel="stylesheet" href="../../resources/plug/formvalidation/css/validationEngine.jquery.css" type="text/css" />
	<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script type="text/javascript" src="../../resources/util/public.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<!-- 引入jGrid -->
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>

</head>
<body style="overflow-x: auto;" onload="adaptationWH('_top','tabs1',0);">
<div id='tabs1' style="width:100%">
<%--button list--%>
<div class="content_02_top" style="margin-bottom:10px;width:99%" id="divA">
	<%if(canEdit){ %>
		<input type="button" class="but_y_01" value="保存" onclick="updateFn('save',this);" id="btn_insert"/>
		<input type="button" class="but_y_01" value="返回" onclick="updateFn('back',this);" id="btn_update"/>
		<script>
			updateFn = function(flag,inputObj){
				try{
					inputObj.disabled=true;
					if(flag==='save'){
						var isFlag = jQuery('#formTable').validationEngine('validate'); //是否全部验证通过
						if (isFlag){
							jQuery("#hidden_action").val("addDataTypeInfo");
							jQuery("#onlyFrom").submit();
						}
					}else if(flag==='back'){
						var p={
							headerText:'提示',
							okName:'确认',
					        okFunction:function(){
					        	removeWindows('filetypeinfoJSP',true);
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
							window.parent.location.href="<%=path%>/ccapp/oa/data/jsp/datatype.jsp?d_type_id=<%=d_type_parent_id%>";
						} else {
							alert(result);
							window.parent.location.href="<%=path%>/ccapp/oa/data/jsp/datatype.jsp?d_type_id=<%=d_type_parent_id%>";
						}
					}
				}catch(e){alert(e.description);}
			}
			var chooseDataType = function (){
				var s = new jQuery.z_tree();
				s.treeID = 'mianType';
				s.treetypestr = "radio";
				s.isShowSeacher = true;
				s.treeName = "选择分类";
				s.headerName = "选择分类";
				s.type = "DATA_TYPE";
				s.isType="dept"; //要设置默认选中值，则需要此类型
				s.selectedIds = jQuery("#d_type_parent_id").val(),
				s.f_org_id = '<%=userBean.getUnit_id()%>';//所属单位id 全局的js变量 引用时注意
				s.typeis='parent';
				s.returnFunction = function(nothing,object){    
				    try{
				    	jQuery("#d_type_parent_id").val(object[0].id);
				    	jQuery("#d_parent_name").val(object[0].name);
				    }catch(e){
				    }
				}
				s.init();
			}
			
		</script>
	<%}else{%>
		<input type="button" class="but_y_01" value="返回" onclick="updateFn('back',this);" id="btn_update"/>
		<script>
			updateFn = function(flag,inputObj){
				try{
					removeWindows('filetypeinfoJSP',true);
				}catch(e){alert(e.description);}
			};
		</script>
	<%}%>
</div>
<%--button list--%>

<form id="onlyFrom" name="onlyFrom" method="post" action="datatypeinfodo.jsp" target="filetypeinfodoJSPhiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>


<input value="<%=StringUtil.deNull(bean.get("d_type_id"))%>" type='hidden' name='d_type_id' id="d_type_id"/>
<table>
	<tr>
		<td width="98%" align="left" valign="top">
<%--main table begin--%>
<div id="vcenter" style="float:left;width:100%; overflow:hidden">
	<div class="content_02_box" >
		<div class="content_02_box_title_bg"><span><%=actionNameStr%></span></div>
		<div class="content_02_box_div">
			<table id='formTable' border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;"><span style="color: red;">*</span>资料分类名称：</th>
					<td  class="content_02_box_div_table_td" style="width: 220px;">
						<input value="<%=StringUtil.deNull(bean.get("d_type_name"))%>" type="text" name="d_type_name" id="d_type_name" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[required,maxSize[100]] input_title_text"/>
					</td>
						<th class="content_02_box_div_table_th" style="width: 150px;">所属单位：</th>
					<td class="content_02_box_div_table_td" >
						<input value="<%=StringUtil.deNull(bean.get("d_type_unit_name"))%>" readonly="readonly" type="text" name="d_type_unit_name" id="d_type_unit_name" class="validate[maxSize[100]] input_title_text"/>
						<input value="<%=StringUtil.deNull(bean.get("d_type_unit_id"))%>" type="hidden" name="d_type_unit_id" id="k_type_unit_id" />
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">所属上级分类：</th>
					<td class="content_02_box_div_table_td">
					    <%if((!StringUtil.isBlank(bean.get("d_type_id"))) && DataTypeBean.D_TYPE_LEVEL_ONE.equals(bean.get("d_type_level"))){%> 
						    <input value="<%=StringUtil.deNull(bean.get("d_parent_name"))%>" readonly="readonly" type="text" name="d_parent_name" id="d_parent_name"  style="width: 100%;"  class="validate[maxSize[100]] input_160"/>
							<input value="<%=StringUtil.deNull(bean.get("d_type_parent_id"))%>" type="hidden" name="d_type_parent_id" id="d_type_parent_id"/>
					    <%}else{%>
							<input value="<%=StringUtil.deNull(bean.get("d_parent_name"))%>" readonly="readonly" type="text" name="d_parent_name" id="d_parent_name"  style="width: 180px;"  class="validate[maxSize[100]] input_160"/>
							<input name="p_type_name_button" id="p_type_name_button" onclick="chooseDataType();"  type="button" class="but_x" style="height: 26px;" /> 
							<input value="<%=StringUtil.deNull(bean.get("d_type_parent_id"))%>" type="hidden" name="d_type_parent_id" id="d_type_parent_id"/>
						<%} %>
					</td>
					<th class="content_02_box_div_table_th" style="width: 150px;">分类层次：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("d_type_level_name"))%>" readonly="readonly" type="text" name="d_type_level_name" id="d_type_level_name" class="validate[required,maxSize[40]] input_title_text"/>
						<input value="<%=StringUtil.deNull(bean.get("d_type_level"))%>" type="hidden" name="d_type_level" id="d_type_level"/>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">排序号：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("d_type_order"))%>" type="text" name="d_type_order" id="d_type_order" class="validate[maxSize[40],custom[number]] input_title_text"/>
					</td>
					<th class="content_02_box_div_table_th" style="width: 150px;"></th>
					<td class="content_02_box_div_table_td">
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">登记人：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("d_type_user_name"))%>" readonly="readonly" type="text" name="d_type_user_name" id="d_type_user_name" class="input_title_text"/>
						<input value="<%=StringUtil.deNull(bean.get("d_type_user_id"))%>" type="hidden" name="d_type_user_id" id="d_type_user_id"/>
					</td>
					<th class="content_02_box_div_table_th" style="width: 150px;">登记时间：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("d_type_create_time"))%>" readonly="readonly" name="d_type_create_time" id="d_type_create_time" class="input_title_text"/>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">备注：</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<textarea style="height: 80px; overflow: auto;" class="validate[maxSize[1000]] input_title_text" name="d_type_remark" id="d_type_remark"><%=StringUtil.deNull(bean.get("d_type_remark"))%></textarea>
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
</html>
<script type="text/javascript">
jQuery(function(){
	jQuery("#formTable").validationEngine();
});

</script>