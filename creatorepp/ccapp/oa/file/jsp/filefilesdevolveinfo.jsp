<%--
描述：档案管理-档案移交-移交记录
作者：邹拓
版本：1.0
日期：2013-7-16
UTF-8
参数列表
f_devolve_id:档案分类id
actionName:insert OR update OR query
--%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesDevolveService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesDevolveServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileConstant"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesService"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileFilesDevolveBean"%>
<%
	String GET_LIST_CLASS ="com.chinacreator.xtbg.core.file.list.FilePurviewList";
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	
	
	
	String actionName = request.getParameter("actionName");
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	boolean canEdit = false;
	FileFilesDevolveService service = new FileFilesDevolveServiceImpl();
	Map<String,String> bean = new HashMap<String,String>();
	String actionNameStr = "";
	if("insert".equals(actionName)){
		actionNameStr = "移交记录";
		canEdit = true;
		bean.put("f_attach_id",StringUtil.getUUID());
		
		bean.put("f_log_user_id",accesscontroler.getUserID());
		bean.put("f_log_user_name",accesscontroler.getUserName());
		
		bean.put("f_log_time",DateUtil.getCurrentDate());
		bean.put("f_year",DateUtil.getCurrentYear());
		bean.put("f_num","0");
		
		bean.put("f_org_id",userBean.getUnit_id());
		bean.put("f_org_name",userBean.getUnit_name());
		
		bean.put("f_dept_id",userBean.getOrg_id());
		bean.put("f_dept_name",userBean.getOrg_name());
		
		bean.put("f_state",FileFilesDevolveBean.STATE_ONE);
		
		bean.put("f_fonds_no",service.getQZH(userBean.getUnit_id()));
	}else{
		actionNameStr = "移交记录";
		String f_devolve_id = request.getParameter("f_devolve_id");
		bean = service.getBeanById(f_devolve_id);
		if("update".equals(actionName)){
			canEdit = true;
		}else if("query".equals(actionName)){
			canEdit = false;
		}
	}
	//
	String windowId = "updateFileFilesDevolveBean";
	if(request.getParameter("windowId")!=null){
		windowId = request.getParameter("windowId");
	}
	//保管期限
	FileFilesService service1 = new FileFilesServiceImpl();
    List<Map<String,String>> deadlineList =  service1.queryDictByCode(FileConstant.DICT_TYPE_BGQX);
    
    List<String[]> typeList = new ArrayList<String[]>();

    typeList.add(new String[]{"1","文书"});
    typeList.add(new String[]{"2","照片"});
    typeList.add(new String[]{"3","视频"});
    typeList.add(new String[]{"4","光盘"});
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
	
	<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	
	<link rel='stylesheet' href='../../resources/plug/fancyupload/fancyupload.css' type='text/css' />
	<script type='text/javascript' src='../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js'></script>
	<script type='text/javascript' src='../../resources/plug/fancyupload/source/Fx.ProgressBar.js'></script>
	<script type='text/javascript' src='../../resources/plug/fancyupload/source/Swiff.Uploader.js'></script>
	<script type='text/javascript' src='../../resources/plug/fancyupload/source/FancyUpload3.Attach.js'></script>
	<script type='text/javascript' src='../../resources/plug/fancyupload/myfancyupload.js'></script>
	<script type="text/javascript">
jQuery(function(){
	jQuery("#f_title").focus();
	jQuery("#formTable").validationEngine();
	<%if(!"insert".equals(actionName)){%>
	initTable();
	<%}%>
	initFJ();
});
initFJ=function(){
	jQuery("#f_begin_time").removeAttr("onclick").removeAttr("onfocus").attr("readOnly","readOnly");
	jQuery("#f_den_time").removeAttr("onclick").removeAttr("onfocus").attr("readOnly","readOnly");
<%if(!canEdit){%>
	MyFancyupload.createUpload('_fileshow',
	'#_filebut',
	'<%=path%>',
	'<%=path%>/servlet/pubFileUpload?buessid=<%=StringUtil.deNull(bean.get("f_attach_id"))%>',
	<%=canEdit%>,
	'<%=StringUtil.deNull(bean.get("f_attach_id"))%>','','','011','');
	jQuery("#_filebut").hide();
	jQuery(".swiff-uploader-box").hide();
	jQuery("#f_title").attr("readOnly","readOnly");
	jQuery("#f_receive_org_name").attr("readOnly","readOnly");
	
<%}else{%>
	MyFancyupload.createUpload('_fileshow',
	'#_filebut',
	'<%=path%>',
	'<%=path%>/servlet/pubFileUpload?buessid=<%=StringUtil.deNull(bean.get("f_attach_id"))%>',
	<%=canEdit%>,
	'<%=StringUtil.deNull(bean.get("f_attach_id"))%>','','','111','');
<%}%>
};
<%if(canEdit){ %>
updateFn = function(flag,inputObj){
	try{
		inputObj.disabled=true;
		if(flag==='save'){
			var isFlag = jQuery('#formTable').validationEngine('validate'); //是否全部验证通过
			if (isFlag){
				jQuery("#f_deadline").removeAttr("disabled");
				jQuery("#f_type").removeAttr("disabled");
				jQuery("#hidden_action").val("addFileFilesDevolveBean");
				jQuery("#onlyFrom").attr("target","filefilesdevolveinfoJSPhiddenFrame");
				jQuery("#onlyFrom").submit();
			}
		}else if(flag==='submit'){
			var isFlag = jQuery('#formTable').validationEngine('validate'); //是否全部验证通过
			if (isFlag){
				var a_num = jQuery("#gridTable").jqGrid('getGridParam','records');
				if(a_num<1){
					alert("请添加移交案卷!");
					inputObj.disabled=false;
					return;
				}
				okF = function(){
					jQuery("#f_deadline").removeAttr("disabled");
					jQuery("#f_type").removeAttr("disabled");
					jQuery("#f_state").val("<%=FileFilesDevolveBean.STATE_TWO%>");
					jQuery("#hidden_action").val("addFileFilesDevolveBean");
					jQuery("#onlyFrom").attr("target","filefilesdevolveinfoJSPhiddenFrame");
					jQuery("#onlyFrom").submit();
				};
				var p={headerText:'提示',okName:'确认',okFunction:okF,cancelName:'取消'};
				alert("确定移交吗？",p);
			}
		}else if(flag==='back'){
			var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:function(){
		        	getParentWindow('<%=windowId%>').search(); 
		        	removeAlertWindows('<%=windowId%>',true);
		        },
		        cancelName:'取消'
			};
			alert("关闭后，数据将不会保存，确定关闭？",p);
		}else if(flag==='export'){
			var url = "<%=path%>/ccapp/oa/file/jsp/exportfilefilesdevolveinfo.jsp";
			url += "?busi_id=<%=StringUtil.deNull(bean.get("f_devolve_id"))%>";
			url += "&windowId=exportfilefilesdevolveinfo";
			url += "&f_title="+descape(escape(jQuery("#f_title")));
			url += "&f_type="+jQuery("#f_type").val();
			openAlertWindows('exportfilefilesdevolveinfo',url, '导出本次移交涉及的所有文件' ,600,300,'30%','30%');
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
					alert("添加成功,可编辑'案卷移交清单'");
					getParentWindow('<%=windowId%>').search();
					getParentWindow('<%=windowId%>').update(result[1]);
					removeAlertWindows('<%=windowId%>',true);
				<%}else{%>
					alert(result[0]);
					getParentWindow('<%=windowId%>').search();
					removeAlertWindows('<%=windowId%>',true);
				<%}%>
			}else{
				alert(result);
				getParentWindow('<%=windowId%>').search();
				removeAlertWindows('<%=windowId%>',true);
			}
		}
	}catch(e){alert(e.description);}
}
<%}else{%>
updateFn = function(flag,inputObj){
	try{
		inputObj.disabled=true;
		if(flag==='back'){
			try{
				removeAlertWindows('<%=windowId%>',true);
			}catch(e){alert(e.description);}
		}else if(flag==='export'){
			var url = "<%=path%>/ccapp/oa/file/jsp/exportfilefilesdevolveinfo.jsp";
			url += "?busi_id=<%=StringUtil.deNull(bean.get("f_devolve_id"))%>";
			url += "&windowId=exportfilefilesdevolveinfo";
			url += "&f_title="+descape(escape(jQuery("#f_title").val()));
			url += "&f_type="+jQuery("#f_type").val();
			openAlertWindows('exportfilefilesdevolveinfo',url, '导出本次移交涉及的所有文件' ,600,300,'30%','30%');
		}
		inputObj.disabled=false;
	}catch(e){alert(e.description);inputObj.disabled=false;}
};
<%}%>
	</script>
</head>
<body style="overflow-x: auto;overflow-y: auto;margin-top:-4px;">
<div style="width:1020px;float:left;">
<iframe id="filetypeinfodoJSPhiddenFrame" name="filefilesdevolveinfoJSPhiddenFrame" width=0 height=0></iframe>

<%--button list--%>
<div class="content_02_top" style="margin-bottom:10px;width:99%" id="divA">
	<%if(canEdit){%>
		<input type="button" class="but_y_01" value="暂存" onclick="updateFn('save',this);" id="btn_insert"/>
		<input type="button" class="but_y_01" value="移交" onclick="updateFn('submit',this);" id="btn_submit" <%if("insert".equals(actionName)){%>style="display:none"<%}%>/>
		<input type="button" class="but_y_01" value="返回" onclick="updateFn('back',this);" id="btn_back"/>
	<%}else{%>
		<input type="button" class="but_y_01" value="返回" onclick="updateFn('back',this);" id="btn_back"/>
		<input type="button" value="导出档案文件" onclick="updateFn('export',this);" id="btn_export" class="but_y_03" style="width:105px;float: left;margin-left: 5px;" />
	<%}%>
</div>
<%--button list--%>

<form id="onlyFrom" name="onlyFrom" method="post" action="filefilesdevolveinfodo.jsp" >
	<input type='hidden' name='action' id="hidden_action"/>
	<input value="<%=StringUtil.deNull(bean.get("f_devolve_id"))%>" type='hidden' name='f_devolve_id' id="f_devolve_id"/>
	<input value="<%=StringUtil.deNull(bean.get("f_state"))%>" type='hidden' name='f_state' id="f_state"/>
	<input value="<%=StringUtil.deNull(bean.get("f_attach_id"))%>" type='hidden' name='f_attach_id' id="f_attach_id"/>
<table style="clear: both;">
	<tr>
		<td width="98%" align="left" valign="top">
<%--main table begin--%>
<div id="vcenter" style="float:left;width:100%; overflow:hidden;clear: both;">
	<div class="content_02_box" >
		<div class="content_02_box_title_bg"><span><%="基本信息"%></span></div>
		<div class="content_02_box_div">
			<table id='formTable' border="0" cellspacing="0" cellpadding="0"  class="content_02_box_div_table">
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">
						<span style="color: red;">*</span>标题：
					</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<input value="<%=StringUtil.deNull(bean.get("f_title"))%>" type="text" name="f_title" id="f_title" class="validate[required,maxSize[200]] input_title_text"/>
					</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th" style="width:150px;"><span style="color: red;">*</span>保管期限：</th>
					<td class="content_02_box_div_table_td">
						<select name='f_deadline' id='f_deadline' style="width:189px;" class ="validate[required] select_100_box_type">
							<%for(Map<String,String> dead : deadlineList){ %>
								<option value='<%=StringUtil.deNull(dead.get("dictdata_value"))%>'
									<%if(StringUtil.deNull(bean.get("f_deadline")).equals(StringUtil.deNull(dead.get("dictdata_value")))){%>selected<%}%>
								><%=StringUtil.deNull(dead.get("dictdata_name"))%></option>
							<%}%>
						</select>
					</td>
					<th class="content_02_box_div_table_th" style="width:150px;"><span style="color: red;">*</span>档案类别：</th>
					<td class="content_02_box_div_table_td">
						<select name='f_type' id='f_type' style="width:189px;" class ="validate[required] select_100_box_type">
							<%for(String[] type : typeList){ %>
								<option value='<%=StringUtil.deNull(type[0])%>'
									<%if(StringUtil.deNull(bean.get("f_type")).equals(StringUtil.deNull(type[0]))){%>selected<%}%>
								><%=StringUtil.deNull(type[1])%></option>
							<%}%>
						</select>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">档案接收单位：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("f_receive_org_name"))%>" type="text" name="f_receive_org_name" id="f_receive_org_name" class="validate[maxSize[100]] input_title_text"/>
						<input value="<%=StringUtil.deNull(bean.get("f_receive_org_id"))%>" type="hidden" name="f_receive_org_id" id=f_receive_org_id/>
					</td>
					<th class="content_02_box_div_table_th" style="width: 150px;">起止日期：</th>
					<td class="content_02_box_div_table_td" title="该数据系统自动回填">
						<input value="<%=StringUtil.deNull(bean.get("f_begin_time"))%>" 
						onfocus="var input_endtime=$dp.$('f_den_time');WdatePicker({onpicked:function(){jQuery('#f_den_time').focus();},dateFmt:'yyyy-MM-dd '})" 
						onclick="var input_endtime=$dp.$('f_den_time');WdatePicker({onpicked:function(){jQuery('#f_den_time').focus();},dateFmt:'yyyy-MM-dd '})" 
						readonly="readonly" name="f_begin_time" id="f_begin_time" class="date_120 Wdate" style='width:80px'/>
						<div style="float: left">&nbsp;至&nbsp;</div>
						<input value="<%=StringUtil.deNull(bean.get("f_den_time"))%>" 
						onfocus="WdatePicker({minDate:'#F{$dp.$D(\'f_begin_time\')}',dateFmt:'yyyy-MM-dd '})"
						onclick="WdatePicker({minDate:'#F{$dp.$D(\'f_begin_time\')}',dateFmt:'yyyy-MM-dd '})"
						readonly="readonly" name="f_den_time" id="f_den_time" class="date_120 Wdate" style='width:80px'/>
					</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">本次移交的卷数：</th>
					<td class="content_02_box_div_table_td" title="该数据系统自动回填">
						<input value="<%=StringUtil.deNull(bean.get("f_num"))%>" type="text" name="f_num" id="f_num" class="validate[custom[onlyNumberSp]] input_title_text" readonly="readonly"/>
					</td>
					<th class="content_02_box_div_table_th" style="width: 150px;">登记人：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("f_log_user_name"))%>" type="text" name="f_log_user_name" id="f_log_user_name" class="input_title_text" readonly="readonly"/>
					</td>
				</tr>
				
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">登记时间：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("f_log_time"))%>" readonly="readonly" name="f_log_time" id="f_log_time" class="input_title_text"/>
					</td>
					<th class="content_02_box_div_table_th" style="width: 150px;">登记人所属部门：</th>
					<td class="content_02_box_div_table_td">
						<input value="<%=StringUtil.deNull(bean.get("f_dept_name"))%>" readonly="readonly" type="text" name="f_dept_name" id="f_dept_name" class="input_title_text"/>
						<input value="<%=StringUtil.deNull(bean.get("f_dept_id"))%>" type="hidden" name="f_dept_id" id=f_dept_id/>
						<input value="<%=StringUtil.deNull(bean.get("f_org_id"))%>" type="hidden" name="f_org_id" id=f_org_id/>
						<input value="<%=StringUtil.deNull(bean.get("f_org_name"))%>" type="hidden" name="f_org_name" id=f_org_name/>
						<input value="<%=StringUtil.deNull(bean.get("f_year"))%>" type="hidden" name="f_year" id="f_year" class="input_title_text"/>
					</td>
				</tr>
				<tr>
					<th class="content_02_box_div_table_th" style="width: 150px;">
						附件：<br/>
					</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<span style='padding-left:5px;'>
						<a href="javascript:void(0);" id="_filebut" >请选择文件</a>
						</span>
						<div>
						<ul id="_fileshow" style="float:left;overflow-y: auto;overflow-x:hidden;margin:1px ;padding-left:10px;background:white;border:0px;background:white;border:0;">
						</ul></div>
					</td>
				</tr>
				<tr style="height:60px;">
					<th class="content_02_box_div_table_th" style="width: 150px;">
						备注：<br/>
					</th>
					<td class="content_02_box_div_table_td" colspan="3">
						<textarea name="f_remarks" id="f_remarks"
						style='border: 0;width:99%;overflow: auto;height:60px;' class='validate[maxSize[500]] textarea_556'><%=StringUtil.deNull(bean.get("f_remarks"))%></textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>
</div>

<%if(!"insert".equals(actionName)){%>
	<%--set role table begin--%>
	<div id="vcenter" style="float:left;width:100%; overflow:hidden">
		<div class="content_02_box" >
			<div class="content_02_box_title_bg">
				<span>案卷移交清单</span>
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
						var f_deadline=jQuery("#f_deadline").val();
						var f_type=jQuery("#f_type").val();
						if(f_deadline&&f_type){
						
						var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
						var idsArr = [];
						if(ids.length>0){
							for(var i=0;i<ids.length;i++){
								var cl = ids[i];
								var model = jQuery("#gridTable").jqGrid('getRowData', cl);
								idsArr.push("'"+model.f_files_id+"'");
							}
						}
						var url = "<%=path%>/ccapp/oa/file/jsp/filefilesdevolveinfoaddfiles.jsp";
						url += "?actionName=insert";
						url += "&beanId=<%=StringUtil.deNull(bean.get("f_devolve_id"))%>";
						url += "&f_type="+f_type;
						url += "&f_doc_deadline="+f_deadline;
						url += "&idList="+idsArr.join(",");
						openAlertWindows('addFileFilesForBean',url, '添加需移交的案卷' ,1020,530,'10%','10%');
						}else{
							alert("请选择保管期限和档案类别");
						}
					}else if("delete"==aName){
						var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
						if(selectedIds.length>0){
							deleteList = '';
							for ( var i = 0; i < selectedIds.length; i++){
								model = jQuery("#gridTable").jqGrid('getRowData',
										selectedIds[i]);
								deleteList+=model.f_devolve_detail_id+",";
							}
							jQuery("#hidden_delete").val(deleteList);
							jQuery("#hidden_action_two").val("deleteFilesdevolveDetail");
							jQuery("#secordFrom").attr("target","filefilesdevolveinfoJSPhiddenFrame");
							jQuery("#secordFrom").submit();
						}else{
							alert("请选择数据");
						}
					}else if("export"==aName){
						var className="com.chinacreator.xtbg.core.file.entity.FileFilesDevolveExportBean";
						var url = "<%=path%>/ccapp/oa/file/jsp/exportexcel.jsp?windowId=windowId_paperTJ"; 
					    var html = new Array();
					    if(jQuery("#hiddenFrame").size()==0){
							html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
						}
						if(jQuery("#downFrom").size()>0){
							jQuery("#downFrom").remove();
						}
					    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
						html.push("<input type='hidden' name='beanId' value='<%=StringUtil.deNull(bean.get("f_devolve_id"))%>'/> ");
						html.push("<input type='hidden' name='className' value='"+className+"' /> ");
					    html.push('</form>');
					    //加载到body，提交后再删除
					    jQuery(html.join("")).appendTo("body").submit();
					}
				};
				function toParamJosn(){
					var str = "{";
					str +="'f_devolve_id':'<%=StringUtil.deNull(bean.get("f_devolve_id"))%>'";	
					str +="}";	
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
						gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
							var f_num = 0;
							var f_begin_time = '';
							var f_den_time = '';
							try{
								f_num = jQuery("#gridTable").jqGrid('getGridParam','records');
								var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
								if(ids.length>0){
									var cl = ids[0];
									var model = jQuery("#gridTable").jqGrid('getRowData', cl);
									f_begin_time = model.min_time;
									f_den_time = model.max_time;
								}
							}catch(e){alert(e.mess)}
							var flag = false;
							if(jQuery("#f_num").val()!=f_num){
								flag = true;
							}
							jQuery("#f_num").val(""+f_num);
							jQuery("#f_begin_time").val(f_begin_time);
							jQuery("#f_den_time").val(f_den_time);
							if(f_num>0){
								jQuery("#f_deadline").attr("disabled","disabled");
								jQuery("#f_type").attr("disabled","disabled");
							}else{
								jQuery("#f_deadline").removeAttr("disabled");
								jQuery("#f_type").removeAttr("disabled");
							}
							jQuery("#f_title").focus();
							if(flag){
								getParentWindow("<%=windowId%>").search();
							}
						},
						url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FileFilesDevolveDetailList', 
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
						colModel : [ 
					        {
					            label : '全宗号',
					            name : 'f_fondsno',
					            index : 'f_fondsno',
					            width:50
					        }, {
					        	label : '目录号',
					            name : 'f_listno',
					            index : 'f_listno',
					            width:80
					        }, {	
					            label :'卷号',
					            name : 'f_filesno',
					            index : 'f_filesno',
					            width:40
					        }, {
					            label :'类别',
					            name : 'f_type_name',
					            index : 'f_type_name'
					        }, {
					            label : "案卷档号",
					            name : 'f_files_no',
					            index : 'f_files_no'
					        }, {
					            label : "起止日期",
					            name : 'f_start_end_time',
					            index : 'f_start_end_time'
					        }, {
					            label : "页数",
					            name : 'f_page_num',
					            index : 'f_page_num',
					            width:40
					        }, {	
					            label : "保管期限",
					            name : 'f_doc_deadline_name',
					            index : 'f_doc_deadline_name',
					            width:60
					        }, {	
					            label : "f_files_id",
					            name : 'f_files_id',
					            index : 'f_files_id',
					            hidden:true
					        }, {	
					            label : "f_devolve_id",
					            name : 'f_devolve_id',
					            index : 'f_devolve_id',
					            hidden:true
					        }, {	
					            label : "f_devolve_detail_id",
					            name : 'f_devolve_detail_id',
					            index : 'f_devolve_detail_id',
					            hidden:true
					        }, {	
					            label : "min_time",
					            name : 'min_time',
					            index : 'min_time',
					            hidden:true
					        }, {	
					            label : "max_time",
					            name : 'max_time',
					            index : 'max_time',
					            hidden:true
					        }
					    ],
						viewrecords: true,
						
						//设置是否在Pager Bar显示所有记录的总数。
						rowNum: 10,
						//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
						rowList: [10, 20, 30],
						//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
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
						toolbar: [true,"top",""
						<%if(canEdit){%>
						+"<input name='insert' type='button' onclick='clickAElement(this);' value='增加' class='but_y_01' />"
						+"<input name='delete' type='button' onclick='clickAElement(this);' value='删除' class='but_y_01' />"
						<%}%>
						+"<input name='export' type='button' onclick='clickAElement(this);' value='导出' class='but_y_01' />"],
						onCellSelect:function(rowid,iCol){
							model = jQuery("#gridTable").jqGrid('getRowData',rowid);
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

<form id="secordFrom" name="secordFrom" method="post" action="filefilesdevolveinfodo.jsp">
<input type='hidden' name='action' id="hidden_action_two" value="deleteFilePurviewInfo"/>
<input type='hidden' name='delete' id="hidden_delete"/>
</form>


</div>
</div>
</body>
</html>