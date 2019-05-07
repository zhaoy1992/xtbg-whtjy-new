<%--
描述：知识库文档分类基本信息
作者：肖杰
版本：1.0
日期：2013-08-06

--%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.impl.KbmDocTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.KbmDocTypeServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.kbm.entity.KbmDocTypeBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileTypeServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileTypeServiceImpl"%>
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
	String k_type_id = "";
	String k_type_level = "";
	String k_parent_type_id = "";
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	boolean canEdit = false;
	KbmDocTypeServiceIfc service=new KbmDocTypeServiceImpl();
	if("insert".equals(actionName)){
		canEdit = true;
		
		
		bean.put("k_type_unit",userBean.getUnit_id());
		bean.put("k_type_unit_name",userBean.getUnit_name());
		
		bean.put("k_type_dept",userBean.getOrg_id());
		bean.put("k_type_dept_name",userBean.getOrg_name());
		
		bean.put("k_create_user",accesscontroler.getUserID());
		bean.put("k_create_user_name",accesscontroler.getUserName());
		bean.put("k_create_time",DateUtil.getCurrentDateTime());
		k_type_level = request.getParameter("k_type_level");
		bean.put("k_type_level",k_type_level);
		k_parent_type_id = request.getParameter("k_parent_type_id");
		//得到默认排序号
		String k_type_order=KbmUtil.getOrder("k_type_order", "oa_kbm_doc_type","k_parent_type_id",k_parent_type_id)+"";
		bean.put("k_type_order", k_type_order);
		if(k_parent_type_id!=null&&k_parent_type_id.length()>0){
			Map<String,String> parentBean = service.getKbmDocTypeBean(k_parent_type_id);
			bean.put("k_parent_type_id",k_parent_type_id);
			bean.put("k_parent_name",parentBean.get("k_type_name"));
			//获取并写入递归值iData:isrecursionData
			KbmDocTypeBean iData = service.getIsrecursionDataForInsert(k_parent_type_id);
			bean.put("k_content_template", iData.getK_content_template());
		}else{
			bean.put("k_parent_type_id","");
			bean.put("k_parent_name","");
		}
		if(KbmDocTypeBean.K_TYPE_LEVEL_ONE.equals(k_type_level)){
			actionNameStr = "增加第一层分类";
			bean.put("k_type_level_name","第一层");
		}else if(KbmDocTypeBean.K_TYPE_LEVEL_TWO.equals(k_type_level)){
			actionNameStr = "增加中间层分类";
			bean.put("k_type_level_name","中间层");
		}else if(KbmDocTypeBean.K_TYPE_LEVEL_THREE.equals(k_type_level)){
			actionNameStr = "增加最底层分类";
			bean.put("k_type_level_name","最底层");
		}
	}else{
		k_type_id = request.getParameter("k_type_id");
		bean = service.getKbmDocTypeBean(k_type_id);
		k_parent_type_id=bean.get("k_parent_type_id");
		Map<String,String> parentbean= service.getKbmDocTypeBean(k_parent_type_id);
		bean.put("k_parent_name", parentbean.get("k_type_name"));
		k_type_level = bean.get("k_type_level");
		if(KbmDocTypeBean.K_TYPE_LEVEL_ONE.equals(k_type_level)){
			bean.put("k_type_level_name","第一层");
		}else if(KbmDocTypeBean.K_TYPE_LEVEL_TWO.equals(k_type_level)){
			bean.put("k_type_level_name","中间层");
		}else if(KbmDocTypeBean.K_TYPE_LEVEL_THREE.equals(k_type_level)){
			bean.put("k_type_level_name","最底层");
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
	if(KbmDocTypeBean.K_TYPE_LEVEL_THREE.equals(bean.get("k_type_level"))){
		needRecursion = false;
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
	<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	<script>
	jQuery(function(){
		initTable();
	});
	</script>
</head>
<body style="overflow-x: auto;" onload="adaptationWH('_top','tabs1',0);">
<iframe name="filetypeinfodoJSPhiddenFrame" id="filetypeinfodoJSPhiddenFrame" width=0 height=0></iframe>
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
							jQuery("#hidden_action").val("addDocTypeInfo");
							jQuery("#onlyFrom").attr("target","filetypeinfodoJSPhiddenFrame");//
							jQuery("#onlyFrom").attr("action","kbmdoctypeinfodo.jsp");
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
							<%if("insert".equals(actionName)){%>
							alert("添加成功,可编辑'阅读权限'");
							parent.location.href="<%=path%>/ccapp/oa/kbm/doctype/jsp/kbmdoctype.jsp?action=add&k_type_id=<%=k_parent_type_id%>&k_child_type_id="+result[1];
							<%}else{%>
							alert(result[0]);
							parent.location.href="<%=path%>/ccapp/oa/kbm/doctype/jsp/kbmdoctype.jsp?k_type_id=<%=k_parent_type_id%>";
							<%}%>		
						}else{
							alert(result);
							parent.location.href="<%=path%>/ccapp/oa/kbm/doctype/jsp/kbmdoctype.jsp?k_type_id=<%=k_parent_type_id%>";
						}
						
					}
				}catch(e){alert(e.description);}
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

<form id="onlyFrom" name="onlyFrom" method="post" >
<input type='hidden' name='action' id="hidden_action"/>


<input value="<%=StringUtil.deNull(bean.get("k_type_id"))%>" type='hidden' name='k_type_id' id="k_type_id"/>
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
					<th class="content_02_box_div_table_th" style="width: 150px;">分类名称<span style="color: red;">*</span>：</th>
					<td  class="content_02_box_div_table_td" style="width: 220px;">
						<input value="<%=StringUtil.deNull(bean.get("k_type_name"))%>" type="text" name="k_type_name" id="k_type_name" onkeyup="checkInsert(this)" onbeforepaste="checkPaste()" class="validate[required,maxSize[100]] input_title_text"/>
					</td>
						<th class="content_02_box_div_table_th" style="width: 150px;">所属单位：</th>
					<td class="content_02_box_div_table_td" >
						<input value="<%=StringUtil.deNull(bean.get("k_type_unit_name"))%>" readonly="readonly" type="text" name="k_type_unit_name" id="k_type_unit_name" class="validate[required,maxSize[100]] input_title_text"/>
						<input value="<%=StringUtil.deNull(bean.get("k_type_unit"))%>" type="hidden" name="k_type_unit" id="k_type_unit" class="validate[required,maxSize[40]] input_title_text"/>
						
						<input value="<%=StringUtil.deNull(bean.get("k_type_dept"))%>" type="hidden" name="k_type_dept" id="k_type_dept"/>
						<input value="<%=StringUtil.deNull(bean.get("k_type_dept_name"))%>" type="hidden" name="k_type_dept_name" id="k_type_dept_name"/>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">所属上级分类：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("k_parent_name"))%>" readonly="readonly" type="text" name="k_parent_name" id="k_parent_name" class="validate[maxSize[40]] input_title_text"/>
						<input value="<%=StringUtil.deNull(bean.get("k_parent_type_id"))%>" type="hidden" name="k_parent_type_id" id="k_parent_type_id"/>
					</td>
					<th class="content_02_box_div_table_th" style="width: 150px;">分类层次：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("k_type_level_name"))%>" readonly="readonly" type="text" name="k_type_level_name" id="k_type_level_name" class="validate[required,maxSize[40]] input_title_text"/>
						<input value="<%=StringUtil.deNull(bean.get("k_type_level"))%>" type="hidden" name="k_type_level" id="k_type_level"/>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">排序号<span style="color: red;">*</span>：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("k_type_order"))%>" type="text" name="k_type_order" id="k_type_order" class="validate[required,maxSize[40],custom[number]] input_title_text"/>
					</td>
					<th class="content_02_box_div_table_th" style="width: 150px;"></th>
					<td class="content_02_box_div_table_td">
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">登记人：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("k_create_user_name"))%>" readonly="readonly" type="text" name="k_create_user_name" id="k_create_user_name" class="input_title_text"/>
						<input value="<%=StringUtil.deNull(bean.get("k_create_user"))%>" type="hidden" name="k_create_user" id="k_create_user"/>
					</td>
					<th class="content_02_box_div_table_th" style="width: 150px;">登记时间：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("k_create_time"))%>" readonly="readonly" name="k_create_time" id="k_create_time" class="input_title_text"/>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">
						内容模板：<br/>
						<%if(needRecursion){%>
							<div style="float:right;display:block;">递归</div>
							<input <%if(KbmDocTypeBean.IS_RECURSION_YES.equals(bean.get("k_isrecursion_content"))){%>checked="checked"<%}%>
								type="checkbox" value="1" name="k_isrecursion_content" style="float:right;display:block;margin:7px 2px 0 2px"/>
						<%}%>
					</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<textarea style="height: 80px; overflow: auto;" class="validate[maxSize[500]] input_title_text" name="k_content_template" id="k_content_template"><%=StringUtil.deNull(bean.get("k_content_template"))%></textarea>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">备注：</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<textarea style="height: 80px; overflow: auto;" class="validate[maxSize[500]] input_title_text" name="k_remark" id="k_remark"><%=StringUtil.deNull(bean.get("k_remark"))%></textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<%--main table end--%>
<%if(!StringUtil.nullOrBlank(k_type_id)){
	//3:获得密级种类
	int maxRecordNum =service.getMaxDocTypeConfigNum();
	%>
	<%--set role table begin--%>
	<div id="vcenter" style="float:left;width:100%; overflow:hidden">
		<div class="content_02_box" >
			<div class="content_02_box_title_bg">
				<span>权限设置</span>
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
							var url = "<%=path%>/ccapp/oa/kbm/doctype/jsp/doctypepurviewinfo.jsp?k_type_id=<%=k_type_id%>&actionName=insert";
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
								deleteList+=model.k_id+",";
							}
							jQuery("#hidden_delete").val(deleteList);
							jQuery("#secordFrom").submit();
						}else{
							alert("请选择数据");
						}
					}
				};
				function toParamJosn(){
					var str = "{'k_type_id':'<%=k_type_id%>'}";	
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
				initTable = function(){
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
					colNames: ['密级','可下载角色','k_id','k_secrecy_id'],
					//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
					colModel: [ //最重要的数组之一，用于设定各列的参数
				        {
				        	name: 'k_secrecy_name',index: 'k_secrecy_name',width: '10',sortable:false
						},
						{
							name: 'download_role',index: 'download_role',width: '30',sortable:false
						},
						{
							name: 'k_id',index: 'k_id',width: '10',sortable:false,hidden:true
						},
						{
							name: 'k_secrecy_id',index: 'k_secrecy_id',	width: '10',sortable:false,hidden:true
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
					toolbar: [true,"top","<input name='insert' type='button' onclick='clickAElement(this);' value='新增' class='but_y_01' onMouseOver=\"javascript:jQuery(this).attr('class','but_y_02');\" onMouseOut=\"javascript:jQuery(this).attr('class','but_y_01');\"/><input name='delete' type='button' onclick='clickAElement(this);' value='删除' class='but_y_01' onMouseOver=\"javascript:jQuery(this).attr('class','but_y_02');\" onMouseOut=\"javascript:jQuery(this).attr('class','but_y_01');\"/>"],
					onCellSelect:function(rowid,iCol){
						model = jQuery("#gridTable").jqGrid('getRowData',rowid);
						<%if(canEdit){%>
							if(iCol>0){
								jQuery("#gridTable").setSelection(rowid,false);
								url = "<%=path%>/ccapp/oa/kbm/doctype/jsp/doctypepurviewinfo.jsp?k_id="+model.k_id+"&k_type_id=<%=k_type_id%>&actionName=update";
								openAlertWindows('windowId',url,'增加权限',600,400,'20%','20%');
							}
						<%}else{%>
							url = "<%=path%>/ccapp/oa/kbm/doctype/jsp/doctypepurviewinfo.jsp?k_id="+model.k_id+"&k_type_id=<%=k_type_id%>&actionName=query";
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
				}
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

<form id="secordFrom" name="secordFrom" method="post" action="kbmdoctypeinfodo.jsp" target="filetypeinfodoJSPhiddenFrame">
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
});

</script>