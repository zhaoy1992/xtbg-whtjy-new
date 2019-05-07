<%--
描述：档案管理-档案分类
作者：邹拓
版本：1.0
日期：2013-7-16
UTF-8
参数列表
f_type_id:档案分类id
f_parent_type_id:父级id
f_type_level:档案级别id
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
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%
	String GET_LIST_CLASS ="com.chinacreator.xtbg.core.file.list.FilePurviewList";
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	Map<String,String> bean = new HashMap<String,String>();
	
	String actionName = request.getParameter("actionName");
	String actionNameStr = "";
	String f_type_id = "";
	String f_type_level = "";
	String f_parent_type_id = "";
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	boolean canEdit = false;
	//是否允许调整结构
	boolean canEditJG = false;
	String moveLevel = "";
	FileTypeServiceIfc service = new FileTypeServiceImpl();
	if("insert".equals(actionName)){
		canEdit = true;
		
		bean.put("f_org_id",userBean.getUnit_id());
		bean.put("f_org_name",userBean.getUnit_name());
		
		bean.put("f_dept_id",userBean.getOrg_id());
		bean.put("f_dept_name",userBean.getOrg_name());
		
		bean.put("f_user_id",accesscontroler.getUserID());
		bean.put("f_user_name",accesscontroler.getUserName());
		bean.put("f_creator_time",DateUtil.getCurrentDateTime());
		f_type_level = request.getParameter("f_type_level");
		bean.put("f_type_level",f_type_level);
		f_parent_type_id = request.getParameter("f_parent_type_id");
		if(f_parent_type_id!=null&&f_parent_type_id.length()>0){
			Map<String,String> parentBean = service.getFileTypeBeanById(f_parent_type_id);
			bean.put("f_parent_type_id",f_parent_type_id);
			bean.put("f_parent_name",parentBean.get("f_type_name"));
			//获取并写入递归值iData:isrecursionData
			FileTypeBean iData = service.getIsrecursionDataForInsert(f_parent_type_id);
			if(iData.getF_program_id()!=null){
				bean.put("f_program_id",iData.getF_program_id());
				bean.put("f_program_page",iData.getF_program_page());
				bean.put("f_page_by_isre",iData.getF_program_id());//存值为了比较判断页面是否修改递归值
			}
			if(iData.getF_type_admin()!=null){
				bean.put("f_type_admin",iData.getF_type_admin());
				bean.put("f_type_adminname",iData.getF_type_adminname());
				bean.put("f_admin_by_isre",iData.getF_type_admin());//存值为了比较判断页面是否修改递归值
			}
			if(iData.getF_template_content()!=null){
				bean.put("f_template_content",iData.getF_template_content());
				bean.put("f_content_by_isre",iData.getF_template_content());//存值为了比较判断页面是否修改递归值
			}
			if(iData.getF_template_file()!=null){
				bean.put("f_template_file",iData.getF_template_file());
				bean.put("f_file_by_isre",iData.getF_template_file());//存值为了比较判断页面是否修改递归值
			}
			if(iData.getF_template_record_table()!=null){
				bean.put("f_template_record_table",iData.getF_template_record_table());
				bean.put("f_record_table_by_isre",iData.getF_template_record_table());//存值为了比较判断页面是否修改递归值
			}
			if(iData.getF_fileno_template()!=null){
				bean.put("f_fileno_template",iData.getF_fileno_template());//存值为了比较判断页面是否修改递归值
			}
		}else{
			bean.put("f_parent_type_id","");
			bean.put("f_parent_name","");
		}
		if(FileTypeBean.F_TYPE_LEVEL_ONE.equals(f_type_level)){
			actionNameStr = "增加第一层分类";
			bean.put("f_type_level_name","第一层");
		}else if(FileTypeBean.F_TYPE_LEVEL_TWO.equals(f_type_level)){
			actionNameStr = "增加中间层分类";
			bean.put("f_type_level_name","中间层");
		}else if(FileTypeBean.F_TYPE_LEVEL_THREE.equals(f_type_level)){
			actionNameStr = "增加最底层分类";
			bean.put("f_type_level_name","最底层");
		}
		//获得排序号为新增
		String sql = "select nvl(max(oft.f_type_order),0)+1 maxOrderNo from oa_file_type oft";
		if(f_parent_type_id!=null&&f_parent_type_id.length()>0){
			sql += " where f_parent_type_id ='"+f_parent_type_id+"'";
		}else{
			sql += " where f_parent_type_id is null";
		}
		String maxOrderNo = DaoUtil.sqlToField(sql);
		if(!StringUtil.nullOrBlank(maxOrderNo)){
			bean.put("f_type_order",maxOrderNo);
		}
	}else{
		f_type_id = request.getParameter("f_type_id");
		bean = service.getFileTypeBeanById(f_type_id);
		f_type_level = bean.get("f_type_level");
		if(FileTypeBean.F_TYPE_LEVEL_ONE.equals(f_type_level)){
			bean.put("f_type_level_name","第一层");
		}else if(FileTypeBean.F_TYPE_LEVEL_TWO.equals(f_type_level)){
			bean.put("f_type_level_name","中间层");
		}else if(FileTypeBean.F_TYPE_LEVEL_THREE.equals(f_type_level)){
			bean.put("f_type_level_name","最底层");
		}
		if("update".equals(actionName)){
			canEditJG = true;
			moveLevel = f_type_level;
		
			bean.put("f_page_by_isre",bean.get("f_program_id"));//存值为了比较判断页面是否修改递归值
			bean.put("f_admin_by_isre",bean.get("f_type_admin"));//存值为了比较判断页面是否修改递归值
			bean.put("f_content_by_isre",bean.get("f_template_content"));//存值为了比较判断页面是否修改递归值
			bean.put("f_file_by_isre",bean.get("f_template_file"));//存值为了比较判断页面是否修改递归值
			bean.put("f_record_table_by_isre",bean.get("f_template_record_table"));//存值为了比较判断页面是否修改递归值
			
			actionNameStr = "修改档案分类信息";
			canEdit = true;
		}else if("query".equals(actionName)){
			actionNameStr = "档案分类信息";
			canEdit = false;
		}
		//无论是新增 或 修改,递归checkbox都不被选中(每一次选中,产生的影响一次性的)
		bean.put("f_isrecursion_page",FileTypeBean.IS_RECURSION_NO);
		bean.put("f_isrecursion_admin",FileTypeBean.IS_RECURSION_NO);
		bean.put("f_isrecursion_content",FileTypeBean.IS_RECURSION_NO);
		bean.put("f_isrecursion_file",FileTypeBean.IS_RECURSION_NO);
		bean.put("f_isrecursion_record_table",FileTypeBean.IS_RECURSION_NO);
		bean.put("f_fileno_template_isrecursion",FileTypeBean.IS_RECURSION_NO);
	}
	//1:初始化[关联界面程序]下拉框
	StringBuffer sql = new StringBuffer();
	sql.append("SELECT OFPP.F_PROGRAM_ID, OFPP.F_PROGRAM_PAGE");
	sql.append("  FROM OA_FILE_PROGRAM_PAGE OFPP");
	//sql.append(" WHERE OFPP.F_ORG_ID = '"+StringUtil.deNull(userBean.getUnit_id())+"'");
	sql.append(" ORDER BY OFPP.F_ORDER");
	String selectData = DictDropDownList.buildSelect(sql.toString(),"f_program_id",StringUtil.deNull(bean.get("f_program_id")),"",true,"","");
	
	//2:needRECURSION
	boolean needRecursion = true;
	if(FileTypeBean.F_TYPE_LEVEL_THREE.equals(bean.get("f_type_level"))){
		needRecursion = false;
	}
	//
	String windowId = "filetypeinfoJSP";
	if(request.getParameter("windowId")!=null){
		windowId = request.getParameter("windowId");
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
	<script type="text/javascript">
	jQuery(function(){
	<%--允许修改级别--%>
	<%if(canEditJG&&
			(moveLevel.equals(FileTypeBean.F_TYPE_LEVEL_TWO)||
			 moveLevel.equals(FileTypeBean.F_TYPE_LEVEL_THREE))){%>
		jQuery("#f_parent_name").click(function(){
		    var s = new jQuery.z_tree();
		    s.treeID = 'file_type_tree_id';
		    s.treetypestr = 'radio';
		    s.isShowSeacher = true;
		    s.treeName = "选择父级分类";
		    s.headerName = "选择父级分类";
		    s.isType="FILE_TYPE"; //要设置默认选中值，则需要此类型
		    s.type = "queryParentFileTypeForUpdateFileType";
		    s.selectedIds = jQuery("#f_parent_type_id").val();
		    //set args
		    s.orgId = "<%=StringUtil.deNull(bean.get("f_org_id"))%>";
		    s.moveLevel = "<%=moveLevel%>";
		    s.thisFileType = "<%=StringUtil.deNull(bean.get("f_type_id"))%>";
		    //callBack
		    s.returnFunction = function(userObj,o){
		       try{
		        if (!IsSpace(o)) {
		            jQuery("#f_parent_name").val(o[0].f_type_name);
		            jQuery("#f_parent_type_id").val(o[0].f_type_id);
		        } else {
		            jQuery("#f_parent_type_id").val("");
		            jQuery("#f_parent_name").val("");
		        }
		       }catch(e){
		         /**忽略客户端异常信息**/ 
		       }
		    }
		    s.init();
		});
	<%}%>
	});
	</script>
</head>
<body  onload="adaptationWH('_top','tabs1',5);">
<iframe id="filetypeinfodoJSPhiddenFrame" name="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
<div id='tabs1' style="width:100%">
<%--button list--%>
<div class="content_02_top" style="width:99%" id="divA">
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
							if(jQuery("#f_type_level").val()!='<%=FileTypeBean.F_TYPE_LEVEL_ONE%>'
								&&!jQuery("#f_parent_name").val()){
								alert("'<%=bean.get("f_type_level_name")%>'的所属上级分类不能为空!");
								inputObj.disabled=false;
								return;
							}
							jQuery("#hidden_action").val("addFileTypeInfo");
							jQuery("#onlyFrom").attr("target","filetypeinfodoJSPhiddenFrame");
							jQuery("#onlyFrom").submit();
						}
					}else if(flag==='back'){
						var p={
							headerText:'提示',
							okName:'确认',
					        okFunction:function(){
					        	removeWindows('<%=windowId%>',true);
					        },
					        cancelName:'取消'
						};
						alert("关闭后，数据将不会保存，确定关闭？",p);
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
							<%if("insert".equals(actionName)){%>
							alert("添加成功,可编辑'阅读权限'");
							openWindowsA('filetypeindexJSP','新增后',"<%=path%>/ccapp/oa/file/jsp/filetypeindex.jsp?f_type_id=<%=f_parent_type_id%>&f_child_type_id="+result[1],'filetypeindexJSP',false,window.parent,true,true);
							<%}else{%>
							alert(result[0]);
							openWindowsA('filetypeindexJSP','修改后',"<%=path%>/ccapp/oa/file/jsp/filetypeindex.jsp?f_type_id=<%=f_parent_type_id%>",'filetypeindexJSP',false,window.parent,true,true);
							<%}%>		
						}else{
							alert(result);
							openWindowsA('filetypeindexJSP','修改后',"<%=path%>/ccapp/oa/file/jsp/filetypeindex.jsp?f_type_id=<%=f_parent_type_id%>",'filetypeindexJSP',false,window.parent,true,true);
						}
						
					}
				}catch(e){alert(e.description);}
			}
			function openWindowsA(a,b,c,d,e,f,g){
				window.top.window[a+"href"] = window.parent.location.href;
				window.parent.location.href = c;
			}
		</script>
	<%}else{%>
		<input type="button" class="but_y_01" value="返回" onclick="updateFn('back',this);" id="btn_update"/>
		<script>
			updateFn = function(flag,inputObj){
				try{
					removeWindows('<%=windowId%>',true);
				}catch(e){alert(e.description);}
			};
		</script>
	<%}%>
</div>
<%--button list--%>

<form id="onlyFrom" name="onlyFrom" method="post" action="filetypeinfodo.jsp" >
<input type='hidden' name='action' id="hidden_action"/>

<input value="<%=StringUtil.deNull(bean.get("f_page_by_isre"))%>" type='hidden' name='f_page_by_isre' id="f_page_by_isre"/>
<input value="<%=StringUtil.deNull(bean.get("f_admin_by_isre"))%>" type='hidden' name='f_admin_by_isre' id="f_admin_by_isre"/>
<input value="<%=StringUtil.deNull(bean.get("f_content_by_isre"))%>" type='hidden' name='f_content_by_isre' id="f_content_by_isre"/>
<input value="<%=StringUtil.deNull(bean.get("f_file_by_isre"))%>" type='hidden' name='f_file_by_isre' id="f_file_by_isre"/>
<input value="<%=StringUtil.deNull(bean.get("f_record_table_by_isre"))%>" type='hidden' name='f_record_table_by_isre' id="f_record_table_by_isre"/>

<input value="<%=StringUtil.deNull(bean.get("f_type_id"))%>" type='hidden' name='f_type_id' id="f_type_id"/>
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
					<th class="content_02_box_div_table_th" style="width: 150px;">档案分类名称<span style="color: red;">*</span>：</th>
					<td class="content_02_box_div_table_td" style="width: 220px;">
						<input value="<%=StringUtil.deNull(bean.get("f_type_name"))%>" type="text" name="f_type_name" id="f_type_name" class="validate[required,maxSize[40]] input_title_text"/>
					</td>
					<th class="content_02_box_div_table_th" style="width: 150px;">所属单位：</th>
					<td class="content_02_box_div_table_td" >
						<input value="<%=StringUtil.deNull(bean.get("f_org_name"))%>" readonly="readonly" type="text" name="f_org_name" id="f_org_name" class="validate[required,maxSize[40]] input_title_text"/>
						<input value="<%=StringUtil.deNull(bean.get("f_org_id"))%>" type="hidden" name="f_org_id" id="f_org_id" class="validate[required,maxSize[40]] input_title_text"/>
						
						<input value="<%=StringUtil.deNull(bean.get("f_dept_id"))%>" type="hidden" name="f_dept_id" id="f_dept_id"/>
						<input value="<%=StringUtil.deNull(bean.get("f_dept_name"))%>" type="hidden" name="f_dept_name" id="f_dept_name"/>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">所属上级分类：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("f_parent_name"))%>" readonly="readonly" type="text" name="f_parent_name" id="f_parent_name" class="validate[maxSize[40]] input_title_text"/>
						<input value="<%=StringUtil.deNull(bean.get("f_parent_type_id"))%>" type="hidden" name="f_parent_type_id" id="f_parent_type_id"/>
					</td>
					<th class="content_02_box_div_table_th" style="width: 150px;">分类层次：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("f_type_level_name"))%>" readonly="readonly" type="text" name="f_type_level_name" id="f_type_level_name" class="validate[required,maxSize[40]] input_title_text"/>
						<input value="<%=StringUtil.deNull(bean.get("f_type_level"))%>" type="hidden" name="f_type_level" id="f_type_level"/>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">档案分类号：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("f_typeno"))%>" type="text" name="f_typeno" id="f_typeno" class="validate[maxSize[40]] input_title_text"/>
					</td>
					<th class="content_02_box_div_table_th" style="width: 150px;">关联界面程序<span style="color: red;">*</span>：</th>
					<td class="content_02_box_div_table_td">
						<%=selectData%>
						<input value="<%=StringUtil.deNull(bean.get("f_program_page"))%>" type="hidden" name="f_program_page" id="f_program_page"/>
						<script type="text/javascript">
							jQuery("#f_program_id").change(function(){
								jQuery("#f_program_page").val(jQuery(this).find("option:selected").text());
							});
							jQuery("#f_program_id").addClass("validate[required]");
							jQuery("#f_program_id").css("width","80%").css("float","left").css("display","block").css("margin-top","3px");
						</script>
						<%if(needRecursion){%>
							<div style="float:right;display:block;">递归</div>
							<input <%if(FileTypeBean.IS_RECURSION_YES.equals(bean.get("f_isrecursion_page"))){%>checked="checked"<%}%>
								type="checkbox" value="1" name="f_isrecursion_page" style="float:right;display:block;margin:7px 2px 0 2px"/>
						<%}%>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width:150px;">档案管理员<span style="color: red;">*</span>：</th>
					<td class="content_02_box_div_table_td">
						<input onclick="selectAdminName();" value="<%=StringUtil.deNull(bean.get("f_type_adminname"))%>" style="width:65%;" readonly="readonly" type="text" name="f_type_adminname" id="f_type_adminname" class="validate[required,maxSize[40]] input_title_text"/>
						<input value="<%=StringUtil.deNull(bean.get("f_type_admin"))%>" type="hidden" name="f_type_admin" id="f_type_admin"/>
						<%if(needRecursion){%>
							<div style="float:right;display:block;">递归</div>
							<input <%if(FileTypeBean.IS_RECURSION_YES.equals(bean.get("f_isrecursion_admin"))){%>checked="checked"<%}%>
								type="checkbox" value="1" name="f_isrecursion_admin" style="float:right;display:block;margin:7px 2px 0 2px"/>
						<%}%>
						<input type="button" value="" class="but_x" onclick="selectAdminName();" style="float:right;display:block;margin-top:3px;"/>
						<script type="text/javascript">
						selectAdminName = function(){
							var s = new jQuery.z_tree();
							s.treeID = 'mianUser';
							s.treetypestr = 'checkbox';
							s.isShowSeacher = true;
							s.treeName = "档案管理员";
							s.headerName = "档案管理员";
							//s.type = "APERSON";
							s.type = "{type:'SEFEUNIT'}";
							s.selectedIds = jQuery("#f_type_admin").val(),
							s.returnFunction = function(userObj,o) {
								if (!IsSpace(userObj)) {
									jQuery("#f_type_admin").val(userObj.id);
									jQuery("#f_type_adminname").val(userObj.name);
								} else {
									jQuery("#f_type_admin").val("");
									jQuery("#f_type_adminname").val("");
								}
							}
							s.init();
						};
						</script>
					</td>
					<th class="content_02_box_div_table_th" style="width: 150px;">排序号<span style="color: red;">*</span>：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("f_type_order"))%>" type="text" name="f_type_order" id="f_type_order" class="validate[required,maxSize[40],custom[number]] input_title_text"/>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">登记人：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("f_user_name"))%>" readonly="readonly" type="text" name="f_user_name" id="f_user_name" class="input_title_text"/>
						<input value="<%=StringUtil.deNull(bean.get("f_user_id"))%>" type="hidden" name="f_user_id" id="f_user_id"/>
					</td>
					<th class="content_02_box_div_table_th" style="width: 150px;">登记时间：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("f_creator_time"))%>" readonly="readonly" name="f_creator_time" id="f_creator_time" class="input_title_text"/>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">
						案卷内容模板：<br/>
						<%if(needRecursion){%>
							<div style="float:right;display:block;">递归</div>
							<input <%if(FileTypeBean.IS_RECURSION_YES.equals(bean.get("f_isrecursion_content"))){%>checked="checked"<%}%>
								type="checkbox" value="1" name="f_isrecursion_content" style="float:right;display:block;margin:7px 2px 0 2px"/>
						<%}%>
					</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<textarea style="height: 80px; overflow: auto;" class="validate[maxSize[500]] input_title_text" name="f_template_content" id="f_template_content"><%=StringUtil.deNull(bean.get("f_template_content"))%></textarea>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">
						文件内容模板：<br/>
						<%if(needRecursion){%>
							<div style="float:right;display:block;">递归</div>
							<input <%if(FileTypeBean.IS_RECURSION_YES.equals(bean.get("f_isrecursion_file"))){%>checked="checked"<%}%>
								type="checkbox" value="1" name="f_isrecursion_file" style="float:right;display:block;margin:7px 2px 0 2px"/>
						<%}%>
					</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<textarea style="height: 80px; overflow: auto;" class="validate[maxSize[500]] input_title_text" name="f_template_file" id="f_template_file"><%=StringUtil.deNull(bean.get("f_template_file"))%></textarea>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">
						备考表模板：<br/>
						<%if(needRecursion){%>
						<div style="float:right;display:block;">递归</div>
						<input <%if(FileTypeBean.IS_RECURSION_YES.equals(bean.get("f_isrecursion_record_table"))){%>checked="checked"<%}%>
							type="checkbox" value="1" name="f_isrecursion_record_table" style="float:right;display:block;margin:7px 2px 0 2px"/>
						<%}%>
					</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<textarea oncontextmenu="toSetTemplatePara(this);return false;"
								onmousedown=lockPosition(this)
								onkeydown=lockPosition(this)
								onkeyup=lockPosition(this)
								onfocus=lockPosition(this)
								name="f_template_record_table" id="f_template_record_table" style="height: 80px; overflow: auto;" class="validate[maxSize[500]] input_title_text"><%=StringUtil.deNull(bean.get("f_template_record_table"))%></textarea>
						
						<script>
						//模板参数设置
						function toSetTemplatePara(obj){
						    var url = "<%=path%>/ccapp/oa/file/jsp/filetypeselectbkb.jsp?random=" + (new Date()).getTime();
						    openAlertWindows('windowId',url,'请选择备考表模板参数',600,400,'20%','20%')
						}
						<%--回调--%>
						function toGetTemplatePara(rtn){
						    var objVal = jQuery("#f_template_record_table").val();
						    var pre = objVal.substr(0, startPos);
						    var post = objVal.substr(endPos);
						    if(!IsSpace(rtn)){
						       rtn = "【" + rtn + "】"; 
						       jQuery("#f_template_record_table").val(pre + rtn + post);
						    }
						}
						var startPos = 0;
						var endPos = 0;
						function lockPosition(obj){
						    if(typeof(obj.selectionStart) == "number"){
						        startPos = obj.selectionStart;
						        endPos = obj.selectionEnd;
						    }else if(document.selection){ //IE6
						        //两个range，一个是已经选择的text(range)，一个是整个textarea(range_all)
						        //range_all.compareEndPoints()比较两个端点，如果range_all比range更往左(further to the left)         
						        //返回小于0的值，则range_all往右移一点，直到两个range的start相同。
						        //calculate selection start point by moving beginning of range_all to beginning of range
						        var range = document.selection.createRange();
						        if(range.parentElement().id == obj.id){
						            var range_all = document.body.createTextRange();
						            range_all.moveToElementText(obj);
						            for (startPos = 0; range_all.compareEndPoints("StartToStart", range) < 0; startPos++){
						                range_all.moveStart('character', 1);
						            }
						            for (var i = 0; i <= startPos; i ++){
						                if (obj.value.charAt(i) == '\n'){
						                    startPos++;
						                }
						            }
						            var range_all = document.body.createTextRange();
						            range_all.moveToElementText(obj);
						            for (endPos = 0; range_all.compareEndPoints('StartToEnd', range) < 0; endPos++){
						                range_all.moveStart('character', 1);
						            }
						            for (var i = 0; i <= endPos; i ++){
						                if (obj.value.charAt(i) == '\n'){
						                    endPos++;
						                }
						            }
						        }
						    }
						}
						</script>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">
						档案档号模板：<br/>
						<%if(needRecursion){%>
							<div style="float:right;display:block;">递归</div>
							<input <%if(FileTypeBean.IS_RECURSION_YES.equals(bean.get("f_fileno_template_isrecursion"))){%>checked="checked"<%}%>
								type="checkbox" value="1" name="f_fileno_template_isrecursion" style="float:right;display:block;margin:7px 2px 0 2px"/>
						<%}%>
					</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<textarea oncontextmenu="toSetTemplateParaB(this);return false;"
								onmousedown=lockPosition(this)
								onkeydown=lockPosition(this)
								onkeyup=lockPosition(this)
								onfocus=lockPosition(this)
								name="f_fileno_template" id="f_fileno_template" style="height: 80px; overflow: auto;" class="validate[maxSize[500]] input_title_text"><%=StringUtil.deNull(bean.get("f_fileno_template"))%></textarea>
						
						<script>
						//模板参数设置
						function toSetTemplateParaB(obj){
						    var url = "<%=path%>/ccapp/oa/file/jsp/filetypeselectdh.jsp?random=" + (new Date()).getTime();
						    openAlertWindows('windowId',url,'请选择档案档号模板参数',600,400,'20%','20%')
						}
						<%--回调--%>
						function toGetTemplateParaB(rtn){
						    var objVal = jQuery("#f_fileno_template").val();
						    var pre = objVal.substr(0, startPos);
						    var post = objVal.substr(endPos);
						    if(!IsSpace(rtn)){
						       rtn = "【" + rtn + "】"; 
						       jQuery("#f_fileno_template").val(pre + rtn + post);
						    }
						}
						
						</script>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">备注：</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<textarea style="height: 80px; overflow: auto;" class="validate[maxSize[500]] input_title_text" name="f_type_remark" id="f_type_remark"><%=StringUtil.deNull(bean.get("f_type_remark"))%></textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<%--main table end--%>
<%if(!StringUtil.nullOrBlank(f_type_id)){
	//3:获得密级种类
	int maxRecordNum = service.getMaxFilePurviewNum();
	%>
	<%--set role table begin--%>
	<div id="vcenter" style="float:left;width:100%; overflow:hidden">
		<div class="content_02_box" >
			<div class="content_02_box_title_bg">
				<span>阅读权限</span>
			</div>
			<div class="content_02_box_div">
				<div style="float:left;width:100%;margin-left: -10px" class="cGridArea">
					<table id="gridTable"></table>
					<div id="gridPager"></div>
				</div>
				<script>
				clickAElement = function(aObj){
					aName = aObj.name;
					if("insert"==aName){
						records = jQuery("#gridTable").jqGrid("getGridParam", "records");
						if(records<'<%=maxRecordNum%>'){
							var url = "<%=path%>/ccapp/oa/file/jsp/filetypefilepurviewinfo.jsp?f_type_id=<%=f_type_id%>&actionName=insert";
							openAlertWindows('windowId',url,'增加权限',600,400,'20%','20%');
						}else{
							alert("已无可选密级");
						}
					}else if("delete"==aName){
						var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
						if(selectedIds.length>0){
							deleteList = '';
							for ( var i = 0; i < selectedIds.length; i++){
								model = jQuery("#gridTable").jqGrid('getRowData',
										selectedIds[i]);
								deleteList+=model.f_purview_id+",";
							}
							jQuery("#hidden_delete").val(deleteList);
							jQuery("#secordFrom").attr("target","filetypeinfodoJSPhiddenFrame");
							jQuery("#secordFrom").submit();
						}else{
							alert("请选择数据");
						}
					}
				};
				function toParamJosn(){
					var str = "{'f_type_id':'<%=f_type_id%>'}";	
					return escape(str);
				}
				searchData = function(){
					data = {paramJson: toParamJosn()};
					postData = jQuery("#gridTable").jqGrid("getGridParam", "postData");
					jQuery.extend(postData, data);
					jQuery("#gridTable").jqGrid("setGridParam", {
						search : true
					}).trigger("reloadGrid", [{
						page : 1
					}]);
				};
				initTable=function(){
				jQuery("#gridTable").jqGrid({
					url: '<%=path%>' + '/pubListServlet?classNameId=<%=GET_LIST_CLASS%>',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
					//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
					datatype: "json",
					//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
					mtype: "POST",
					//定义使用哪种方法发起请求，GET或者POST
					height: "100%",//270
					//Grid的高度，可以接受数字、%值、auto，默认值为150
					//width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
					//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
					autowidth: true,
					//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
					colNames: ['密级','电子档案可阅读角色','电子档案可下载角色','F_PURVIEW_ID','F_SECRECY_ID'],
					//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
					colModel: [ //最重要的数组之一，用于设定各列的参数
				        {
				        	name: 'f_secrecy_name',index: 'f_secrecy_name',width: '10',sortable:false
						},
						{
							name: 'read_role',index: 'read_role',width: '30',sortable:false
						},
						{
							name: 'download_role',index: 'download_role',width: '30',sortable:false
						},
						{
							name: 'f_purview_id',index: 'f_purview_id',width: '10',sortable:false,hidden:true
						},
						{
							name: 'f_secrecy_id',index: 'f_secrecy_id',	width: '10',sortable:false,hidden:true
						}
					],
					viewrecords: true,
					
					//设置是否在Pager Bar显示所有记录的总数。
					rowNum: 10,
					//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
					rowList: [10, 20, 30],
					//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
					gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
						
					},
					jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
						repeatitems: false
					},
					//pager: "#gridPager",
					pagerintoolbar:true,//上面的分页条
					pagerinBottombar:true,//下面的分页条
					//定义页码控制条Page Bar
					//caption: "草稿箱",
					//设置Grid表格的标题，如果未设置，则标题区域不显示。
					search : toParamJosn(),
					prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
						rows: "rows",
						//表示请求行数的参数名称  
						sort: "sidx",
						//表示用于排序的列名的参数名称  
						order: "sord",
						//表示采用的排序方式的参数名称 
						search : "search"
					},
					multiselect: <%=canEdit%>,
					toolbar: [true,"top","<input name='insert' type='button' onclick='clickAElement(this);' value='新增' class='but_y_01' /><input name='delete' type='button' onclick='clickAElement(this);' value='删除' class='but_y_01' />"],
					onCellSelect:function(rowid,iCol){
						model = jQuery("#gridTable").jqGrid('getRowData',rowid);
						<%if(canEdit){%>
							if(iCol>0){
								url = "<%=path%>/ccapp/oa/file/jsp/filetypefilepurviewinfo.jsp?f_purview_id="+model.f_purview_id+"&f_type_id=<%=f_type_id%>&actionName=update";
								openAlertWindows('windowId',url,'增加权限',600,400,'20%','20%');
							}
						<%}else{%>
							url = "<%=path%>/ccapp/oa/file/jsp/filetypefilepurviewinfo.jsp?f_purview_id="+model.f_purview_id+"&f_type_id=<%=f_type_id%>&actionName=query";
							openAlertWindows('windowId',url,'增加权限',600,400,'20%','20%');
						<%}%>
					}
				}).navGrid('#gridPager', {
					edit: false,
					add: false,
					del: false,
					search:false,
					refresh:false
				});
				};
				</script>
			</div>
		</div>
	</div>
	<%--set role table end--%>
<%}%>
		</td>
	</tr>
</table>
</form>

<form id="secordFrom" name="secordFrom" method="post" action="filetypeinfodo.jsp">
<input type='hidden' name='action' id="hidden_action_two" value="deleteFilePurviewInfo"/>
<input type='hidden' name='delete' id="hidden_delete"/>
</form>
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
	<%if(!StringUtil.nullOrBlank(f_type_id)){%>
	initTable();
	<%}%>
});
<%--
 * 覆盖ifrom-ui-ztree.1.1.js的getTreeType支持jQuery("#f_parent_name").click
 * TreeBusinessDaoImpl.queryParentFileTypeForUpdateFileType
 * 得到树类型调用方法
 * @param treeType
 * @returns {Array}
 */--%>

</script>