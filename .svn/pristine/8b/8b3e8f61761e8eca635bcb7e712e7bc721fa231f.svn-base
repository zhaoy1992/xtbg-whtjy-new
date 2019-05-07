<%--
描述：档案管理-档案分类-档案密级信息
作者：邹拓
版本：1.0
日期：2013-7-18
UTF-8
参数列表
f_type_id:档案分类id
f_purview_id:档案密级信息id[选择下拉框,发现存在信息后,再次进入页面]
actionName:insert OR update OR query
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileTypeBean"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileTypeServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FilePurviewBean"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	Map<String,String> bean = new HashMap<String,String>();
	String f_type_id = request.getParameter("f_type_id");
	
	if(f_type_id==null){
		return;
	}
	

	
	String actionName = request.getParameter("actionName");
	String actionNameStr = "";
	String f_type_level = "";
	String f_parent_type_id = "";
	
	boolean canEdit = false;
	boolean canDelete = false;
	//1:初始化[密级]下拉框
	StringBuffer sql = new StringBuffer();
	FileTypeServiceIfc service = new FileTypeServiceImpl();
	if("insert".equals(actionName)){
		canEdit = true;
		bean.put("f_type_id",f_type_id);
		
		sql.append("SELECT ODD.DICTDATA_ID, ODD.DICTDATA_NAME");
		sql.append("  FROM OA_DICT_DATA ODD");
		sql.append(" WHERE ODD.DICT_ID = '"+FilePurviewBean.DICT_ID+"'");
		sql.append("   AND ODD.DICTDATA_ID NOT IN");
		sql.append("       (SELECT OFP.F_SECRECY_ID");
		sql.append("          FROM OA_FILE_PURVIEW OFP");
		sql.append("         WHERE OFP.F_TYPE_ID = '"+f_type_id+"')");
		sql.append(" ORDER BY ODD.DICTDATA_ORDER");
	}else{
		String f_purview_id = request.getParameter("f_purview_id");
		bean = service.getFilePurviewBeanById(f_purview_id);
		sql.append("SELECT ODD.DICTDATA_ID, ODD.DICTDATA_NAME");
		sql.append("  FROM OA_DICT_DATA ODD");
		sql.append(" WHERE ODD.DICT_ID = '"+FilePurviewBean.DICT_ID+"'");
		sql.append("   AND (ODD.DICTDATA_ID = '"+StringUtil.deNull(bean.get("f_secrecy_id"))+"' OR ODD.DICTDATA_ID NOT IN");
		sql.append("       (SELECT OFP.F_SECRECY_ID");
		sql.append("          FROM OA_FILE_PURVIEW OFP");
		sql.append("         WHERE OFP.F_TYPE_ID = '"+f_type_id+"'))");
		sql.append(" ORDER BY ODD.DICTDATA_ORDER");
		if("update".equals(actionName)){
			actionNameStr = "修改档案分类信息";
			canEdit = true;
			canDelete = true;
		}else if("query".equals(actionName)){
			actionNameStr = "档案分类信息";
			canEdit = false;
		}
	}
	String selectData = DictDropDownList.buildSelect(sql.toString(),"f_secrecy_id",StringUtil.deNull(bean.get("f_secrecy_id")),"fetchSecrecyId(this);",true,"","");
	//2:needRECURSION
	boolean needRecursion = true;
	if(FileTypeBean.F_TYPE_LEVEL_THREE.equals(bean.get("f_type_level"))){
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
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	
	<!-- 引入jGrid -->
	<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	
	<script type="text/javascript" src="../../resources/js/util/jsonutil.js" ></script>
	
	<!-- 引入上传控件 -->
	<link   rel="stylesheet" href="../../resources/plug/fancyupload/fancyupload.css" type="text/css" />
	<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
	
</head>
<body style="overflow-x: auto;" onload="adaptationWH('_top','tabs1',0);">
<div id='tabs1' style="width:600px;">
<%--button list--%>
<div class="content_02_top" style="margin-bottom:10px;width:100%" id="divA">
	<%if(canEdit){ %>
		<input type="button" class="but_y_01" value="保存" onclick="updateFn('save',this);"/>
		<%if(canDelete){%>
		<input type="button" class="but_y_01" value="删除" onclick="updateFn('delete',this);"/>
		<%}%>
		<input type="button" class="but_y_01" value="关闭" onclick="updateFn('close',this);"/>
		<script>
			updateFn = function(flag,inputObj){
				try{
					inputObj.disabled=true;
					if(flag==='save'){
						var isFlag = jQuery('#formTable').validationEngine('validate'); //是否全部验证通过
						if (isFlag){
							jQuery("#hidden_action").val("addFilePurviewInfo");
							jQuery("#onlyFrom").submit();
						}
					}else if(flag==='close'){
						var p={
							headerText:'提示',
							okName:'确认',
					        okFunction:function(){
					        	removeAlertWindows('windowId',true);
					        },
					        cancelName:'取消'
						};
						alert("关闭后，数据将不会保存，确定关闭？",p);
					}else if(flag==='delete'){
						jQuery("#hidden_action").val("deleteFilePurviewInfo");
						jQuery("#hidden_delete").val("<%=StringUtil.deNull(bean.get("f_purview_id"))%>");
						jQuery("#onlyFrom").submit();
					}
					inputObj.disabled=false;
				}catch(e){alert(e.description);inputObj.disabled=false;}
			};
			<%--提交后回调--%>
			afterSubmitFn=function(result){
				try{
					getParentWindow('windowId').searchData();
					removeAlertWindows('windowId',true);
					alert(result);
				}catch(e){alert(e.description);}
			}
		</script>
	<%}else{%>
		<input type="button" class="but_y_01" value="关闭" onclick="updateFn('back',this);" id="btn_update"/>
		<script>
			updateFn = function(flag,inputObj){
				try{
					removeAlertWindows('windowId',true);
				}catch(e){alert(e.description);}
			};
		</script>
	<%}%>
</div>
<%--button list--%>
<iframe name="filetypefilepurviewinfoJSPhiddenFrame" width=0 height=0></iframe>
<form id="onlyFrom" name="onlyFrom" method="post" action="filetypeinfodo.jsp" target="filetypefilepurviewinfoJSPhiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<input type='hidden' name='delete' id="hidden_delete"/>
<input value="<%=StringUtil.deNull(bean.get("f_type_id"))%>" type='hidden' name='f_type_id' id="f_type_id"/>
<input value="<%=StringUtil.deNull(bean.get("f_purview_id"))%>" type='hidden' name='f_purview_id' id="f_purview_id"/>
<table>
	<tr>
		<td width="98%" align="left" valign="top">
<%--main table begin--%>
<div id="vcenter">
	<div class="content_02_box" style="width:95%;">
		<div class="content_02_box_title_bg" style="width:100%;"><span><%=actionNameStr%></span></div>
		<div class="content_02_box_div" style="width:100%;">
			<table id='formTable' border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table" style="width:100%;">
				<tr>
					<th class="content_02_box_div_table_th" style="width: 120px;">密级<span style="color: red;">*</span>：</th>
					<td class="content_02_box_div_table_td" style="width: 440px;">
						<%=selectData%>
						<input value="<%=StringUtil.deNull(bean.get("f_secrecy_name"))%>" type="hidden" name="f_secrecy_name" id="f_secrecy_name"/>
						<script>
						jQuery("#f_secrecy_id").addClass("validate[required]");
						fetchSecrecyId = function(selectObj){
							if(selectObj.value){
								jQuery("#f_secrecy_name").val(jQuery(selectObj).find("option:selected").text());
							}else{
								jQuery("#f_secrecy_name").val("");
							}
						}
						</script>
					</td>
				</tr>
				<tr>
					<th vAlign rowspan="2" class="content_02_box_div_table_th" style="width: 120px;" >电子档案可阅读角色：</th>
					<td class="content_02_box_div_table_td">
						<input value="1" <%if(FilePurviewBean.CAN_DO.equals(bean.get("f_read_all_user"))){%>checked="checked"<%}%>
							name="f_read_all_user" id="f_read_all_user" style="float:left;display:block;margin:7px 2px 0 2px" type="checkbox"/>
						<div style="float:left;display:block;">&nbsp;所有人&nbsp;&nbsp;&nbsp;&nbsp;</div>
						<input value="1" <%if(FilePurviewBean.CAN_DO.equals(bean.get("f_read_dept_user"))){%>checked="checked"<%}%>
							name="f_read_dept_user" id="f_read_dept_user" style="float:left;display:block;margin:7px 2px 0 2px" type="checkbox"/>
						<div style="float:left;display:block;">&nbsp;本部门&nbsp;&nbsp;&nbsp;&nbsp;</div>
						<input type="button" id="f_read_user_groupid_Btn" class="but_x" onclick="selectUserGroup(this);" style="float:left;display:block;margin-top:3px;"/>
						<div style="float:left;display:block;">&nbsp;用户组&nbsp;&nbsp;&nbsp;&nbsp;</div>
						
					</td>
				</tr>
				<tr>
					<td id="f_read_user_groupid_TD" <%if(StringUtil.nullOrBlank(bean.get("f_read_user_groupname"))){%>style="display: none"<%}%> class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("f_read_user_groupid"))%>" id="f_read_user_groupid" name="f_read_user_groupid" type="hidden"/>
						<textarea readonly="readonly" name="f_read_user_groupname" id="f_read_user_groupname" style="height: 80px; overflow: auto;" class="validate[maxSize[500]] input_title_text"><%=StringUtil.deNull(bean.get("f_read_user_groupname"))%></textarea>
					</td>
				</tr>
				<tr>
					<th vAlign rowspan="2" class="content_02_box_div_table_th" style="width: 120px;">电子档案可下载角色：</th>
					<td class="content_02_box_div_table_td">
						<input value="1" <%if(FilePurviewBean.CAN_DO.equals(bean.get("f_download_all_user"))){%>checked="checked"<%}%>
							type="checkbox" id="f_download_all_user" name="f_download_all_user" style="float:left;display:block;margin:7px 2px 0 2px"/>
						<div style="float:left;display:block;">&nbsp;所有人&nbsp;&nbsp;&nbsp;&nbsp;</div>
						<input value="1" <%if(FilePurviewBean.CAN_DO.equals(bean.get("f_download_dept_user"))){%>checked="checked"<%}%>
							type="checkbox" id="f_download_dept_user" name="f_download_dept_user" style="float:left;display:block;margin:7px 2px 0 2px"/>
						<div style="float:left;display:block;">&nbsp;本部门&nbsp;&nbsp;&nbsp;&nbsp;</div>
						<input type="button" id="f_download_user_groupid_Btn" class="but_x" onclick="selectUserGroup(this);" style="float:left;display:block;margin-top:3px;"/>
						<div style="float:left;display:block;">&nbsp;用户组&nbsp;&nbsp;&nbsp;&nbsp;</div>
						
						
					</td>
				</tr>
				<tr>
					<td id="f_download_user_groupid_TD" <%if(StringUtil.nullOrBlank(bean.get("f_download_user_groupname"))){%>style="display: none"<%}%> class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("f_download_user_groupid"))%>" id="f_download_user_groupid" name="f_download_user_groupid" type="hidden"/>
						<textarea readonly="readonly" name="f_download_user_groupname" id="f_download_user_groupname" style="height: 80px; overflow: auto;" class="validate[maxSize[500]] input_title_text"><%=StringUtil.deNull(bean.get("f_download_user_groupname"))%></textarea>
					</td>
				</tr>
			</table>
			<script>
			<%--
			 * 覆盖ifrom-ui-ztree.1.1.js的getTreeType支持selectUserGroup
			 * 得到树类型调用方法
			 * @param treeType
			 * @returns {Array}
			 */--%>
			function getTreeType(treeProperty){
				return ["queryUserGroup","config",'{"user":""}'];
			}
			<%--点击设置用户组:与TreeBusinessDaoImpl.queryUserGroup()协同--%>
			selectUserGroup = function (btnObj){
				hiddenId = "";
				showId = "";
				areaTDId = "";
				btnId = btnObj.id;
				if("f_read_user_groupid_Btn"==btnId){
					hiddenId = "f_read_user_groupid";
					showId = "f_read_user_groupname";
					areaTDId = "f_read_user_groupid_TD";
				}else if("f_download_user_groupid_Btn"==btnId){
					hiddenId = "f_download_user_groupid";
					showId = "f_download_user_groupname";
					areaTDId = "f_download_user_groupid_TD";
				}
				var s = new jQuery.z_tree();
				s.treeID = 'userGroup';
        		s.treetypestr = 'checkbox';
        		s.isShowSeacher = true;
		        s.treeName = "选取用户组";
			    s.headerName = "选取用户组";
        		//ifrom-ui-ztree.1.1.js:function OK
        		s.isType = "dept";
        		s.selectedIds = jQuery("#"+hiddenId).val(),
				s.returnFunction=function(objj,o) {
					if(!IsSpace(objj)){
						if(objj.id){
							jQuery('#'+hiddenId).val(objj.id);
							jQuery('#'+showId).val(objj.name);
							jQuery('#'+areaTDId).show();
							return;
						}
					}
					jQuery('#'+hiddenId).val("");
					jQuery('#'+showId).val("");
					jQuery('#'+areaTDId).hide();
				};
				
				s.init();
			};
			<%--点击[所有人]缓存数据|删除元素数据 和 恢复数据|删除缓存--%>
			var messCache={};
			clickCheckBoxAll=function(){
				<%--1:选定元素--%>
				objId = this.id;
				checkBoxDeptId = "";
				userGroupBtnId = "";
				userGroupInputId="";
				userGroupTextareaId="";
				userGroupTextareaTdId="";
				if("f_read_all_user"==objId){
					checkBoxDeptId = "f_read_dept_user";
					userGroupBtnId = "f_read_user_groupid_Btn";
					userGroupInputId="f_read_user_groupid";
					userGroupTextareaId="f_read_user_groupname";
					userGroupTextareaTdId="f_read_user_groupid_TD";
				}else if("f_download_all_user"==objId){
					checkBoxDeptId = "f_download_dept_user";
					userGroupBtnId = "f_download_user_groupid_Btn";
					userGroupInputId="f_download_user_groupid";
					userGroupTextareaId="f_download_user_groupname";
					userGroupTextareaTdId="f_download_user_groupid_TD";
				}
				<%--2:缓存数据+改变元素样式--%>
				if(this.checked){
					//1部门下拉框
					if(jQuery("#"+checkBoxDeptId).attr("checked")){
						messCache[checkBoxDeptId]="1";
					}
					jQuery("#"+checkBoxDeptId).removeAttr("checked");
					jQuery("#"+checkBoxDeptId).attr("disabled","disabled");
					//2用户组隐藏域
					messCache[userGroupInputId]=jQuery("#"+userGroupInputId).val();
					jQuery("#"+userGroupInputId).val("");
					//3用户组文本域
					messCache[userGroupTextareaId]=jQuery("#"+userGroupTextareaId).val();
					jQuery("#"+userGroupTextareaId).val("");
					//4用户组按钮
					jQuery("#"+userGroupBtnId).attr("disabled","disabled");
					//5用户组td
					jQuery("#"+userGroupTextareaTdId).hide();
				}else{
					//1部门下拉框
					jQuery("#"+checkBoxDeptId).removeAttr("disabled");
					if(messCache[checkBoxDeptId]){
						jQuery("#"+checkBoxDeptId).attr("checked","checked");
					}
					//2用户组隐藏域
					if(messCache[userGroupInputId]){
						jQuery("#"+userGroupInputId).val(messCache[userGroupInputId]);
					}
					//3用户组文本域+//5用户组td
					if(messCache[userGroupTextareaId]){
						jQuery("#"+userGroupTextareaId).val(messCache[userGroupTextareaId]);
						jQuery("#"+userGroupTextareaTdId).show();
					}
					//4用户组按钮
					jQuery("#"+userGroupBtnId).removeAttr("disabled");
					//6清空
					messCache={};
				}
			}
			jQuery("#f_read_all_user").click(clickCheckBoxAll);
			jQuery("#f_download_all_user").click(clickCheckBoxAll);
			</script>
		</div>
	</div>
</div>
<%--main table end--%>

		</td>
	</tr>
</table>
</form>

</div>
</body>
</html>
<script type="text/javascript">
jQuery(function(){
	jQuery("#formTable").validationEngine();
});
<%--进入修改页面,初始化页面元素 begin--%>
<%if(FilePurviewBean.CAN_DO.equals(bean.get("f_read_all_user"))){%>
	checkBoxDeptId = "f_read_dept_user";
	userGroupBtnId = "f_read_user_groupid_Btn";
	userGroupInputId="f_read_user_groupid";
	userGroupTextareaId="f_read_user_groupname";
	userGroupTextareaTdId="f_read_user_groupid_TD";
	jQuery("#"+checkBoxDeptId).removeAttr("checked");
	jQuery("#"+checkBoxDeptId).attr("disabled","disabled");
	jQuery("#"+userGroupInputId).val("");
	jQuery("#"+userGroupTextareaId).val("");
	jQuery("#"+userGroupBtnId).attr("disabled","disabled");
	jQuery("#"+userGroupTextareaTdId).hide();
<%}%>
<%if(FilePurviewBean.CAN_DO.equals(bean.get("f_download_all_user"))){%>
	checkBoxDeptId = "f_download_dept_user";
	userGroupBtnId = "f_download_user_groupid_Btn";
	userGroupInputId="f_download_user_groupid";
	userGroupTextareaId="f_download_user_groupname";
	userGroupTextareaTdId="f_download_user_groupid_TD";
	jQuery("#"+checkBoxDeptId).removeAttr("checked");
	jQuery("#"+checkBoxDeptId).attr("disabled","disabled");
	jQuery("#"+userGroupInputId).val("");
	jQuery("#"+userGroupTextareaId).val("");
	jQuery("#"+userGroupBtnId).attr("disabled","disabled");
	jQuery("#"+userGroupTextareaTdId).hide();
<%}%>
<%--进入修改页面,初始化页面元素 end--%>
</script>