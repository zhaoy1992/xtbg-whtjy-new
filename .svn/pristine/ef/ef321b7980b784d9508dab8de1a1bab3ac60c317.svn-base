<%--
描述：上报信息--新增界面
作者：黄海
版本：1.0
日期：2013-09-13
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DbManager"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.paper.util.PaperConstants"%>
<%@page import="com.chinacreator.xtbg.core.paper.util.PaperUtil"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.PaperService"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.impl.PaperServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String cebversion = OASystemCache.getContextProperty("cebversion");
	String actionName = request.getParameter("actionName");
	String actionNameStr = "";
	String user_id = accesscontroler.getUserID();
	UserCacheBean userBean = UserCache.getUserCacheBean(user_id);
	if (userBean == null) {
		userBean = new UserCacheBean();
	}
	//信息表主键id
	String p_manage_id = request.getParameter("p_manage_id");
	//附件
    String p_rep_attach_id = StringUtil.getUUID();
    //word正文id 新增时取uuid
   	//modifu by shuqi.liu 采用seq的形势获取ID，适配表分区
   	DbManager dbManager = DbManager.getInstance();
	String p_rep_contents = dbManager.getSequence(null, "SEQ_OA_DOCUMENT_FILE");
    //String p_rep_contents = StringUtil.getUUID();
    PaperService service=new PaperServiceImpl();
    Map<String, String> bean = new HashMap<String, String>();
	//来源操作判断
	if ("insert".equals(actionName)) {
		bean.put("p_rep_unit_id",userBean.getUnit_id());
		bean.put("p_rep_unit_name", userBean.getUnit_name());
		bean.put("p_rep_user_id",userBean.getUser_id());
		bean.put("p_rep_user_name",userBean.getUser_realname());
		actionNameStr = "新增信息页面";
	}else if ("update".equals(actionName)){
		bean = service.getPaperBeanById(p_manage_id);
		p_rep_attach_id = bean.get("p_rep_attach_id");
		p_rep_contents = bean.get("p_rep_contents");
		actionNameStr = "修改信息页面";
	}else if ("update2acc".equals(actionName)){
		bean = service.getPaperBeanById(p_manage_id);
		p_rep_attach_id = bean.get("p_rep_attach_id");
		p_rep_contents = bean.get("p_rep_contents");
		actionNameStr = "待采编信息页面";
	}
	
	//附件权限（或者说表单修改权限）   
	boolean canEdit=true;
	//当 来自信息采编接收列表待采编时  或  上报列表的待采编时      都是已上报，故不能改
	//已采编、退稿也不能改
	if("update".equals(actionName) 
			|| StringUtil.deNull(bean.get("p_rep_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_PENDING)
			|| StringUtil.deNull(bean.get("p_rep_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_ACCEPT)
			|| StringUtil.deNull(bean.get("p_rep_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_UNACCEPT)){
		canEdit=false;
	}
	//草稿可以编辑的
	if (StringUtil.deNull(bean.get("p_rep_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_DRAFT)){
		canEdit=true;
	}
	
	//下拉框  选中的id由bean存的值确定
    String p_rep_type_id_dictType = "infotype";//类型
    String p_rep_type_id_selectHtml = DictDropDownList.buildSelect4DictType(p_rep_type_id_dictType,"p_rep_type_id" ,  StringUtil.deNull(bean.get("p_rep_type_id")), "" , true, "" ,"" ,"class='validate[required] select_240' style='width: 200px;height:24px;'","" );

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
	<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
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
	<!-- 引入上传控件 -->
	<link rel="stylesheet" href="../../resources/plug/fancyupload/fancyupload.css" type="text/css" />
	<script type="text/javascript" src="../../resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
	<!-- 引入jGrid -->
	<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	<script type="text/javascript" src="../../resources/util/jsonutil.js" ></script>
	<script type="text/javascript">
	var p_rep_attach_id="<%=p_rep_attach_id%>";//附件
	var path = "<%=path%>";//路径
	var iWebOffice = null;
	window.attachEvent("onload", function () {
	    
	});
	jQuery(function() {
		//上报过，即待采编的信息不能再存草稿了
		
		jQuery("#p_rep_user_id").val("<%=StringUtil.deNull(bean.get("p_rep_user_id"))%>");
		jQuery("#p_rep_user_name").val("<%=StringUtil.deNull(bean.get("p_rep_user_name"))%>");
		jQuery("#p_rep_attach_id").val("<%=p_rep_attach_id%>");//附件id
		jQuery("#p_rep_contents").val("<%=p_rep_contents%>");//word 正文id
		
		<%	if ("insert".equals(actionName) || StringUtil.deNull(bean.get("p_rep_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_DRAFT)) {
		%>
	        	jQuery("#_filebut").width(105).height(22);
		<%}%>
		//处理附件
		var attachFlag=<%=canEdit%>;
		isFileEnble(p_rep_attach_id,attachFlag);
		
		init();
		setTimeout(function(){jQuery("#p_rep_title").focus();},1100); 
		//处理滚动条
		var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
		jQuery("#treediv").height(_documentBodyHeight-140);
	});
	
	/*
	函数：init
	描述：初始化方法
	*/
	function init() {
	    iWebOffice = document.getElementsByName("WebOffice")[0];
	    var weburltemp = "../../resources/plug/iWebOffice2009/OfficeServer.jsp";
	    iWebOffice.WebUrl = weburltemp; //设置控件与服务器交互的url地址
	    iWebOffice.FileType = ".doc"; //设置文件类型，确定控件开发的应用程序
	    iWebOffice.EditType = "1,0"; //设置编辑状态
	    iWebOffice.ShowType = "1"; //设置显示状态
	    iWebOffice.ShowToolBar = "0"; //是否显示工具栏 0不显示 1显示
	    iWebOffice.ShowMenu = "0"; //是否显示菜单 0不显示 1显示
	    iWebOffice.MaxFileSize = 64 * 1024; //设置文件最大值
	    iWebOffice.Language="CH"; //设置界面显示语言
	    iWebOffice.UserName = ""; //设置用户名
	    iWebOffice.RecordID = "<%=StringUtil.deNull(bean.get("p_rep_contents"))%>";
	    //iWebOffice.ExtParam="fromPaper";  
	    combakTemplet();
	}
	/*
	函数：opentmpFn
	描述：选择模板
	*/
	var opentmpFn = function(){
		
	}
	/*
	函数：saveWORD
	描述：保存WORD文件
	*/
	var saveWORD = function(){
		iWebOffice.RecordID = "<%=p_rep_contents%>";
		iWebOffice.WebSave();
	}
	/*
	函数：combakTemplet
	描述：打开word编辑器
	*/
	function combakTemplet() {
	    //iWebOffice.Template = "word"+template_id; //这是模板id
	    iWebOffice.WebOpen();
	}
	/**
	 *附件是否可以编辑
	 *@p_rep_attach_id :附件id
	 *@attachFlag : 是否可以操作的参数  true(可操作)  false（不可操作）
	 */
	function isFileEnble(p_rep_attach_id,attachFlag){
		if(attachFlag){ 
	    	MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+p_rep_attach_id, attachFlag, p_rep_attach_id,'',function(){
				//上传附件回调
				autoTitle("#p_rep_title",jQuery("#_fileshow li:first").contents().first().text());
			},'111');
		}else{
			MyFancyupload.createUpload('_fileshow', '_filebut', path, path+'/servlet/pubFileUpload?buessid='+p_rep_attach_id, attachFlag, p_rep_attach_id,'','','001');
		}
	    if(!attachFlag){
	        //设置上传按钮大小，间接实现隐藏
	       jQuery("#_filebut").width(1).height(1);
	    } 
	}
	/*
	函数：autoTitle
	描述：生成文件名
	*/
	function autoTitle(tmp_titleDom,tmp_fileName){
		try {
			var lastindexofpoint = tmp_fileName.lastIndexOf(".");
			if( lastindexofpoint != -1){
				var fileName = tmp_fileName.substring(0,lastindexofpoint);
				if(jQuery(tmp_titleDom).val()!=""){
					
				}else{
					jQuery(tmp_titleDom).val(jQuery(tmp_titleDom).val()+fileName);
				}
			} else {
				if(jQuery(tmp_titleDom).val()==""){
					jQuery(tmp_titleDom).val(tmp_fileName);
				}
			}
		} catch(error){
			jQuery(tmp_titleDom).val("");
		}
	}
	/*
	函数：updateFn
	描述：上报和存草稿
	*/
	var updateFn = function(flag,flagname,inputObj){
		try{
			inputObj.disabled=true;
			if(inputObj.id=="btn_acc"){
		        var okF = function () {
		            jQuery.ajax({
		                type: "post",
		                url: "paperlist4reporteddetaildo.jsp",
		                contentType: "application/x-www-form-urlencoded; charset=utf-8",
		                data: {
		                    action: "accpaper4pending",
		                    ids: jQuery("#p_manage_id").val() //要删除的id列表      
		                },
		                dataType: "json",
		                success: function (result) {
		                    if (result.flag) {
		                        alert("操作成功！");
		                        removeWindows('paperlist4reporteddetail',true);
		                    } else {
		                        alert("操作失败！");
		                    }
		                },
		            });
		        }
		        var p = {
		            headerText: '提示',
		            okName: '确认',
		            okFunction: okF,
		            cancelName: '取消'
		        };
		        alert("确定"+inputObj.value+"吗？", p);
			}else if (inputObj.id=="btn_unacc"){
				var strAction = "unaccpaper"; 
			    openAlertWindows('unaccpaperremark', getCurrentFilePath() +'paparsetunaccremark.jsp?p_manage_id=<%=p_manage_id%>&windowId=unaccpaperremark', '请输入退稿原因' ,600,200,'10%','10%');
			}else{
				if(!isSpace(flag)){
					var isFlag = jQuery('#formTable').validationEngine('validate'); //是否全部验证通过
					if (isFlag){
						var okF = function(){
							jQuery("#hidden_action").val("addpaperlist4reporteddetail");
							jQuery("#p_flag_id").val(flag);
							jQuery('#p_flag_name').val(flagname);
							jQuery("#p_rep_flag_id").val(flag);
							jQuery('#p_rep_flag_name').val(flagname);
							jQuery("#p_rep_type_name").val(jQuery("#p_rep_type_id option[value='']~option:selected").text());
							var array_p_acc_unit_ids = new Array();
							var array_p_acc_unit_names = new Array();
							var checkcount=0;
						    jQuery("input[id='arr_p_acc_unit_ids']:checked").each(function(){         
						    	array_p_acc_unit_ids.push(jQuery(this).val());
						    	array_p_acc_unit_names.push(jQuery(this).attr("title"));
						    	checkcount++;
						    });       
						    if(checkcount==0){
						    	alert("请选择‘接收单位’！");
						    	inputObj.disabled=false;
						    	return;
						    }
							jQuery('#p_acc_unit_ids').val(array_p_acc_unit_ids.join(","));//把全部的多选框组的值用逗号连接存好
							jQuery('#p_acc_unit_names').val(array_p_acc_unit_names.join(","));//把全部的多选框组的值用逗号连接存好
							jQuery("#onlyFrom").submit();
						}
						
						var p = {
				            headerText: '提示',
				            okName: '确认',
				            okFunction: okF,
				            cancelName: '取消'
				        };
				        alert("确定"+inputObj.value+"吗？", p);
					}
				}
			}
			inputObj.disabled=false;
		}catch(e){alert(e.description);inputObj.disabled=false;}
	};
	
	/*
	函数：cancelFn
	描述：取消返回到列表
	*/
	var cancelFn = function(flag,inputObj){
		try{
			if(flag==='back'){
				var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:function(){
			        	removeWindows('paperlist4reporteddetail',true);
			        },
			        cancelName:'返回'
				};
				alert("返回后，数据将不会保存，确定返回？",p);
			}
			inputObj.disabled=false;
		}catch(e){alert(e.description);inputObj.disabled=false;}
	};
			
	<%--提交后回调--%>
	var afterSubmitFn=function(result){
		try{
			if(result.indexOf("delete")!=-1){
				alert(result.split(",")[1]);
				searchData();
			}else{
				if(result.split(",").length=="3"){
					result = result.split(",");
					alert(result[0]);
					if(result[0]==="操作成功"){
						saveWORD();
					}
					window.location.href="<%=path%>/ccapp/oa/paper/jsp/"+result[2]+".jsp";
				}
				
			}
		}catch(e){alert(e.description);}
	};
	var chooseOrgbak = function (){//暂不用
		var s = new jQuery.z_tree();
		  s.treeID='mian';
		  s.treetypestr='radio';
		  s.isShowSeacher=true;
		  s.treeName="选取报送单位";
		  s.isType='dept';
		  s.headerName="选取报送单位";
		  s.item_id = 'org_id';
		  s.selectedIds=jQuery('#p_rep_unit_id').val();
		  s.type='ADEPT';
		  s.returnFunction=function(orgObj){
			  if(!IsSpace(orgObj)){
				  jQuery('#p_rep_unit_id').val(orgObj.id);
				  jQuery('#p_rep_unit_name').val(orgObj.name);
				 }
		  }
		  s.init();
	}
	
	var chooseOrg = function (){
		var s = new jQuery.z_tree();
		  s.treeID='mian';
		  s.treetypestr='radio';
		  s.isShowSeacher=true;
		  s.treeName="选取单位";
		  s.isType='unit';
		  s.headerName="选取单位";
		  s.item_id = 'org_id';
		  s.selectedIds=jQuery('#p_rep_unit_id').val();
		  s.type='{"type":"32"}';
		  s.valueKey='unit';
		  s.returnFunction=function(orgObj,arr,o){
			    var ids = "";
				var names = "";
				for(var j=0;j<arr.length;j++){
					if(!arr[j].isParent){
						ids+=","+arr[j].id;
						names+=","+arr[j].name;
					}
				}
				if(arr.length>0){
					ids=ids.substring(1);
					names=names.substring(1);
				}
				jQuery('#p_rep_unit_id').val(ids); 
				jQuery('#p_rep_unit_name').val(names);
		  }
		  s.init();
	}
	</script>
</head>
<body>
<div id='tabs1' style="width:100%">
<%--button list--%>
<div class="content_02_top" style="margin-bottom:10px;width:99%" id="divA">
	<%//放这里速度快一些
	//新增                                        可上报、可存草稿、调模板                                               有
	//草稿箱                                     可上报、可存草稿、调模板                                               有
	//已上报（待采编）                  返回(上报后不能再执行操作了)               没有操作附件权限
	//来自信息采编接收列表           采编、退稿（用异步处理，表单就算修改也没有）         没有操作附件权限
	if ("insert".equals(actionName) 
			 || StringUtil.deNull(bean.get("p_rep_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_UNACCEPT)
			 || StringUtil.deNull(bean.get("p_rep_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_DRAFT)) {
	%>
		<input type="button" class="but_y_01" value="上报"    onclick="updateFn('<%=PaperConstants.STATUS_PENDING %>','待采编',this);" id="btn_insert"/>
		<input type="button" class="but_y_01"  value="存草稿"   onclick="updateFn('<%=PaperConstants.STATUS_DRAFT %>','草稿',this);" id="btn_draft"/>
		<!--  <input type="button" class="but_y_01" value="调用模板" onclick="opentmpFn('opentmp',this);" id="btn_opentmp"/>-->
	<%
	}else if ("update2acc".equals(actionName) && StringUtil.deNull(bean.get("p_rep_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_PENDING)){
	%>
		<input type="button" class="but_y_01" value="采编"    onclick="updateFn('<%=PaperConstants.STATUS_ACCEPT %>','已采编',this);" id="btn_acc"/>
		<input type="button" class="but_y_01" value="退稿"    onclick="updateFn('<%=PaperConstants.STATUS_UNACCEPT %>','退稿',this);" id="btn_unacc"/>
	<%	
	}
	%>
	<input type="button" class="but_y_01" value="返回"    onclick="cancelFn('back',this);" id="btn_update"/>
</div>
<%--button list--%>

<form id="onlyFrom" name="onlyFrom" method="post" action="paperlist4reporteddetaildo.jsp" target="fileTempleateinfodoJSPhiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<input value="<%=p_manage_id %>" type="hidden" name="p_manage_id" id="p_manage_id"/>
<input value="" type="hidden" name="p_rep_user_id" id="p_rep_user_id"/>
<input value="" type="hidden" name="p_rep_user_name" id="p_rep_user_name"/>
<input value="" type="hidden" name="p_flag_id" id="p_flag_id"/>
<input value="" type="hidden" name="p_flag_name" id="p_flag_name"/>
<input value="" type="hidden" name="p_rep_flag_id" id="p_rep_flag_id"/>
<input value="" type="hidden" name="p_rep_flag_name" id="p_rep_flag_name"/>
<input value="" type="hidden" name="p_rep_type_name" id="p_rep_type_name"/>
<input value="" type="hidden" name="p_rep_contents" id="p_rep_contents"/>
<input value="" type="hidden" name="p_acc_unit_ids" id="p_acc_unit_ids"/>
<input value="" type="hidden" name="p_acc_unit_names" id="p_acc_unit_names"/>
<input value="1" type="hidden" name="p_is_use" id="p_is_use"/>
<input value="<%=StringUtil.deNull(request.getParameter("loadurl")) %>" type="hidden" name="loadurl" id="loadurl"/>


<table>
	<tr>
		<td width="98%" align="left" valign="top">
			<div class="vcenter" style="float: left; width: 100%; height:860px;overflow-y: scroll" scrolling="yes" id="treediv">
				<div class="content_02_box" style="width:850px;">
					<div class="content_02_box_title_bg" style="width:850px;">
						<span>基本信息</span>
					</div>
					<div class="content_02_box_div" style="width:850px;">
						<table id='formTable' border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width:850px;">
							<tr>
								<th class="content_02_box_div_table_th" style="width: 20%;">
									<span style="color: red;">*</span>标题：</th>
								<td class="content_02_box_div_table_td" style="width: 30%;">
									<input value="<%=StringUtil.deNull(bean.get("p_rep_title"))%>" type="text" name="p_rep_title" id="p_rep_title" class="validate[required,maxSize[200]] input_title_text" />
								</td>
								<th class="content_02_box_div_table_th" style="width: 15%;">
									<span style="color: red;">*</span>类型：</th>
								<td class="content_02_box_div_table_td" style="width: 35%;">
									<%=p_rep_type_id_selectHtml %>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;">
									<span style="color: red;">*</span>报送单位：</th>
								<td class="content_02_box_div_table_td" style="width: 150px;">
									<input value="<%=StringUtil.deNull(bean.get("p_rep_unit_name"))%>" type="text" name="p_rep_unit_name" id="p_rep_unit_name" onclick="chooseOrg()" readonly class="input_title_text" style="width:220px;" />
									<input value="<%=StringUtil.deNull(bean.get("p_rep_unit_id"))%>" type="hidden" name="p_rep_unit_id" id="p_rep_unit_id" />
									<input name="chooseOrgbutton" id="chooseOrgbutton" type="button" class="but_x" style="height: 26px;" onclick="chooseOrg()" />
								</td>
								<th class="content_02_box_div_table_th" style="width: 150px;">
									<span style="color: red;">*</span>接收单位：</th>
								<td class="content_02_box_div_table_td" style="width: 150px;">
									<%
									Connection conn = DbManager.getInstance().getTransactionConnection();
									PaperUtil paperutil=new PaperUtil();
									String strChecked="";
									List<Map<String, String>>  unitids = paperutil.getOrg4AccUnit(conn,StringUtil.deNull(bean.get("p_rep_user_id")),PaperConstants.PAPERREPORTTOUNIT);
									for (int i = 0; i < unitids.size(); i++) {
										strChecked="";
										if(StringUtil.deNull(bean.get("p_acc_unit_ids")).toString().indexOf(unitids.get(i).get("unitid").toString())>-1){
											strChecked="checked='checked'";
										}
									%>
										<input type="checkbox" <%=strChecked %> value="<%=unitids.get(i).get("unitid") %>" title="<%=unitids.get(i).get("unitname") %>"  style="float:left;display:block;margin:8px 5px 2px 2px" name="p_acc_unit_ids_<%=i %>" id="arr_p_acc_unit_ids" />
										<span style="float:left;display:block;width: 100px"><%=unitids.get(i).get("unitname") %></span>
									<%	
									}
									%>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;">
									<span style="color: red;">*</span>责任编辑：</th>
								<td class="content_02_box_div_table_td" style="width: 150px;">
									<input value="<%=StringUtil.deNull(bean.get("p_editor"))%>" type="text" name="p_editor" id="p_editor" class="validate[required,maxSize[100]] input_title_text" />
								</td>
								<th class="content_02_box_div_table_th" style="width: 150px;">
									<span style="color: red;">*</span>签发领导：</th>
								<td class="content_02_box_div_table_td" style="width: 150px;">
									<input value="<%=StringUtil.deNull(bean.get("p_leader"))%>" type="text" name="p_leader" id="p_leader" class="validate[required,maxSize[100]] input_title_text" />
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;">关键字(用<font color=red>半角的“,”</font>分开)：</th>
								<td class="content_02_box_div_table_td" colspan=3>
									<input value="<%=StringUtil.deNull(bean.get("p_rep_keyword"))%>" type="text" name="p_rep_keyword" id="p_rep_keyword" class="input_title_text" />
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th">附件：</th>
								<td class="content_02_box_div_table_td" colspan=3>
									<input class="but_y_03" type="button" id="_filebut" value="请选择文件" style="width:1px;height:1px;"/>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" valign="top">附件列表：</th>
								<td class="content_02_box_div_table_td" colspan=3>
									<ul id="_fileshow"></ul><input type="hidden" id="p_rep_attach_id" name="p_rep_attach_id" value="" />
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="content_02_box" style="width:850px;">
					<div class="content_02_box_title_bg" style="width:850px;">
						<span>正文</span>
					</div>
					<div class="content_02_box_div" style="width:850px;">
						<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width:850px;">
							<tr>
								<td colspan="4">
									<OBJECT
										id="WebOffice_WebOffice1"
										style="LEFT: 0px; WIDTH: 100%; HEIGHT: 100%" codeBase="../../resources/plug/WebOffice2009/<%=cebversion %>"
										classid="clsid:8B23EA28-2009-402F-92C4-59BE0E063499" name="WebOffice">
										<PARAM NAME="Visible" VALUE="-1">
										<PARAM NAME="Caption" VALUE="HandWriteCtrl">
										<PARAM NAME="Color" VALUE="4278190095">
										<PARAM NAME="Font" VALUE="MS Sans Serif">
										<PARAM NAME="HelpFile" VALUE="">
										<PARAM NAME="Enabled" VALUE="-1">
										<PARAM NAME="RecordID" VALUE="">
										<PARAM NAME="UserName" VALUE="未定义">
										<PARAM NAME="EditType" VALUE="">
										<PARAM NAME="PenColor" VALUE="#FF0000">
										<PARAM NAME="PenWidth" VALUE="2">
										<PARAM NAME="Print" VALUE="0">
										<PARAM NAME="ExtParam" VALUE="">
										<PARAM NAME="ShowTools" VALUE="-1">
										<PARAM NAME="HideName" VALUE="">
										<PARAM NAME="Template" VALUE="">
										<PARAM NAME="FileName" VALUE="">
										<PARAM NAME="FileType" VALUE=".doc">
										<PARAM NAME="Status" VALUE="">
										<PARAM NAME="Copyright" VALUE="iWebOffice 9.3.2.0-vfC48b/GvLxpV2ViT2ZmaWNlMjAwNltWUNHdyr6w5lY5LjMuMi4wQ107MjAxMjsxOzI7Mzs0OzU7Njs3Ozg7OTtFWD1ERU1PX1ZQX1VDX0FTXzQ7VlA9VHJ1ZTtVQz1UcnVlO1U4PUZhbHNlO1JNPUZhbHNlO01UPUZhbHNlO0FTPVRydWU7RkM9NDs=">
										<PARAM NAME="ShowMenu" VALUE="-1">
										<PARAM NAME="Modify" VALUE="0">
										<PARAM NAME="CopyType" VALUE="-1">
										<PARAM NAME="ShowToolBar" VALUE="-1">
										<PARAM NAME="ShowTitle" VALUE="-1">
										<PARAM NAME="BodyStyle" VALUE="1">
										<PARAM NAME="InputText" VALUE="">
										<PARAM NAME="Zoom" VALUE="100">
										<PARAM NAME="ClearType" VALUE="0">
										<PARAM NAME="EnablePrint" VALUE="-1">
										<PARAM NAME="ShowType" VALUE="1">
										<PARAM NAME="ToolsSpace" VALUE="-1">
										<PARAM NAME="ClearPages" VALUE="-1">
										<PARAM NAME="Compressed" VALUE="0">
										<PARAM NAME="MaxFileSize" VALUE="8192">
										<PARAM NAME="ShowUsers" VALUE="-1">
										<PARAM NAME="ShowWindow" VALUE="0">
										<PARAM NAME="ShowAllUsers" VALUE="-1">
										<PARAM NAME="Office2007Ribbon" VALUE="4">
										<PARAM NAME="RibbonUIXml" VALUE="">
										<PARAM NAME="ShortCutKey" VALUE="CTRL+S">
										<PARAM NAME="ChangeSize" VALUE="-1">
										<PARAM NAME="Encrypted" VALUE="0">
										<PARAM NAME="Binary" VALUE="">
										<PARAM NAME="PopInputWindow" VALUE="0">
										<PARAM NAME="FontName" VALUE="宋体">
										<PARAM NAME="FontSize" VALUE="12">
										<PARAM NAME="FontColor" VALUE="255">
										<PARAM NAME="ShowPages" VALUE="">
										<PARAM NAME="PreviewEnable" VALUE="-1">
										<PARAM NAME="UIType" VALUE="-1">
										<PARAM NAME="InputSign" VALUE="">
										<PARAM NAME="UserConfig" VALUE="0">
										<PARAM NAME="AllowEmpty" VALUE="-1">
									</OBJECT>
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
<iframe name="fileTempleateinfodoJSPhiddenFrame" width=0 height=0></iframe>
</div>
</body>
</html>
