<%--
描述：新增/编辑信息页面
作者：黄海
版本：1.0
日期：2013-09-25
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
<%@page import="com.chinacreator.xtbg.core.paper.dao.PaperDao"%>
<%@page import="com.chinacreator.xtbg.core.common.startup.LoadSpringContext"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache" %>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String cebversion = OASystemCache.getContextProperty("cebversion");
	String actionName = request.getParameter("actionName");
	String actionNameStr = "";
	String user_id = accesscontroler.getUserID();
	UserCacheBean userBean = UserCache.getUserCacheBean(accesscontroler.getUserID());
	if (userBean == null) {
		userBean = new UserCacheBean();
	}
	boolean canUpdate = false;
	if(KbmUtil.isRolesUser(user_id, "信息报送管理领导批示角色") 
			&& "updatefromok".equals(actionName)){
		canUpdate=true;
	};
	//信息表主键id
	String p_manage_id = request.getParameter("p_manage_id");
	//附件
    String p_rep_attach_id = StringUtil.getUUID();
    //word正文id 新增时取uuid
    String p_contents = StringUtil.getUUID();
    
    String save_p_contents = StringUtil.getUUID();//采编后的word 正文id
    
    PaperService service=new PaperServiceImpl();
    Map<String, String> bean = new HashMap<String, String>();
	//来源操作判断
	if ("AddOne4Acc".equals(actionName)) {
		bean.put("p_acc_unit_id",userBean.getUnit_id());
		bean.put("p_acc_unit_name", userBean.getUnit_name());
		bean.put("p_acc_user_id",userBean.getUser_id());
		bean.put("p_acc_user_name",userBean.getUser_realname());
		actionNameStr = "新增信息页面";
		save_p_contents=p_contents;
	}else if ("AddOne4Published".equals(actionName)){
		bean.put("p_rep_unit_id",userBean.getUnit_id());
		bean.put("p_rep_unit_name", userBean.getUnit_name());
		
		bean.put("p_acc_unit_id",userBean.getUnit_id());
		bean.put("p_acc_unit_name", userBean.getUnit_name());
		bean.put("p_acc_user_id",userBean.getUser_id());
		bean.put("p_acc_user_name",userBean.getUser_realname());
		
		bean.put("p_pub_unit_id",userBean.getUnit_id());
		bean.put("p_pub_unit_name", userBean.getUnit_name());
		bean.put("p_pub_user_id",userBean.getUser_id());
		bean.put("p_pub_user_name",userBean.getUser_realname());
		actionNameStr = "发布信息页面";
		save_p_contents=p_contents;
	}else if ("updatefromacced".equals(actionName)){
		bean = service.getPaperBeanById(p_manage_id);
		if(!StringUtil.nullOrBlank(bean.get("p_rep_contents"))){//已采编列表只能用默认采编的word 或 无word 用uuid
			p_contents = bean.get("p_rep_contents");
		}
		actionNameStr = "已采编信息页面";
	}else if ("updatefromtmp".equals(actionName)){
		bean = service.getPaperBeanById(p_manage_id);
		if(!StringUtil.nullOrBlank(bean.get("p_contents"))){//已采编列表只能用默认采编的word 或 无word 用uuid
			p_contents = bean.get("p_contents");
			save_p_contents=p_contents;
		}
		actionNameStr = "采编（草稿）页面";
	}else if ("viewpending".equals(actionName)){//来自已送审列表
		bean = service.getPaperBeanById(p_manage_id);
		if(!StringUtil.nullOrBlank(bean.get("p_contents"))){//保存过的话,就用之前的 
			p_contents = bean.get("p_contents");
		}
		save_p_contents=p_contents;
		actionNameStr = "已送审信息页面";
	}else if ("updatefromrevise".equals(actionName)){
		bean = service.getPaperBeanById(p_manage_id);
		if(!StringUtil.nullOrBlank(bean.get("p_contents"))){
			p_contents = bean.get("p_contents");
		}
		save_p_contents=p_contents;
		actionNameStr = "发布（草稿）信息页面";
	}else if ("updatefromundone".equals(actionName)){
		bean = service.getPaperBeanById(p_manage_id);
		if(!StringUtil.nullOrBlank(bean.get("p_contents"))){
			p_contents = bean.get("p_contents");
		}
		save_p_contents=p_contents;
		actionNameStr = "已退回信息页面";
	}else if ("updatefromwait".equals(actionName)){
		bean = service.getPaperBeanById(p_manage_id);
		if(!StringUtil.nullOrBlank(bean.get("p_contents"))){
			p_contents = bean.get("p_contents");
		}
		bean.put("p_pub_unit_id",userBean.getUnit_id());
		bean.put("p_pub_unit_name", userBean.getUnit_name());
		bean.put("p_pub_user_id",userBean.getUser_id());
		bean.put("p_pub_user_name",userBean.getUser_realname());
		save_p_contents=p_contents;
		actionNameStr = "待发布信息页面";
	}else if ("updatefromok".equals(actionName)){
		bean = service.getPaperBeanById(p_manage_id);
		if(!StringUtil.nullOrBlank(bean.get("p_contents"))){
			p_contents = bean.get("p_contents");
		}
		save_p_contents=p_contents;
		actionNameStr = "已发布信息页面";
	}else if ("query".equals(actionName)){
		bean = service.getPaperBeanById(p_manage_id);
		Connection conn = null;
		try {
			conn = DbManager.getInstance().getTransactionConnection();
			PaperDao paperDao=(PaperDao)LoadSpringContext.getApplicationContext().getBean("paperDaoImpl");
			paperDao.updateReadStatusByUnit(conn,p_manage_id,userBean.getUnit_id());
			paperDao.updateReadStatusByUser(conn,p_manage_id,userBean.getUser_id());
        } catch (Exception e) {
            DbManager. rollBackNoThrow(conn);
        } finally{
             if(conn != null ){
                 DbManager. closeConnection(conn);
            }
        }
		
		if(!StringUtil.nullOrBlank(bean.get("p_contents"))){
			p_contents = bean.get("p_contents");
		}
		save_p_contents=p_contents;
		actionNameStr = "信息浏览页面";	
	}
	boolean isFromPubList = false;
	if("updatefromok".equals(actionName)
			||"updatefromwait".equals(actionName)
			||"updatefromundone".equals(actionName)
			||"updatefromrevise".equals(actionName)
			||"AddOne4Published".equals(actionName)){
		isFromPubList = true;
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
	var a = "<%=actionName%>";
	var path = "<%=path%>";//路径
	var WebOffice = null;
	var isFromPubList = "<%=isFromPubList%>";
	var webform;
	window.attachEvent("onload", function () {
	    init();
		setTimeout(function(){jQuery("#p_acc_title").focus();},1100);// 
	});
	jQuery(function(){
		webform = onlyFrom;
		<%if ("AddOne4Acc".equals(actionName)) {
		%>
			jQuery("#p_acc_user_id").val("<%=StringUtil.deNull(bean.get("p_acc_user_id"))%>");
			jQuery("#p_acc_user_name").val("<%=StringUtil.deNull(bean.get("p_acc_user_name"))%>");
			jQuery("#p_acc_unit_id").val("<%=StringUtil.deNull(bean.get("p_acc_unit_id"))%>");
			jQuery("#p_acc_unit_name").val("<%=StringUtil.deNull(bean.get("p_acc_unit_name"))%>");
		<%
		}else if("AddOne4Published".equals(actionName)){//新增发布
		%>
			jQuery("#p_rep_unit_id").val("<%=StringUtil.deNull(bean.get("p_rep_unit_id"))%>");
			jQuery("#p_rep_unit_name").val("<%=StringUtil.deNull(bean.get("p_rep_unit_name"))%>");
			
			jQuery("#p_acc_user_id").val("<%=StringUtil.deNull(bean.get("p_acc_user_id"))%>");
			jQuery("#p_acc_user_name").val("<%=StringUtil.deNull(bean.get("p_acc_user_name"))%>");
			jQuery("#p_acc_unit_id").val("<%=StringUtil.deNull(bean.get("p_acc_unit_id"))%>");
			jQuery("#p_acc_unit_name").val("<%=StringUtil.deNull(bean.get("p_acc_unit_name"))%>");
			
			jQuery("#p_pub_user_id").val("<%=StringUtil.deNull(bean.get("p_pub_user_id"))%>");
			jQuery("#p_pub_user_name").val("<%=StringUtil.deNull(bean.get("p_pub_user_name"))%>");
			jQuery("#p_pub_unit_id").val("<%=StringUtil.deNull(bean.get("p_pub_unit_id"))%>");
			jQuery("#p_pub_unit_name").val("<%=StringUtil.deNull(bean.get("p_pub_unit_name"))%>");
		<%
		}else{
		%>
			//上报过，即待采编的信息不能再存草稿了
			if(isFromPubList==="false"){
				jQuery("#p_acc_user_id").val("<%=StringUtil.deNull(bean.get("p_acc_user_id"))%>");
				jQuery("#p_acc_user_name").val("<%=StringUtil.deNull(bean.get("p_acc_user_name"))%>");
				jQuery("#p_acc_unit_id").val("<%=StringUtil.deNull(bean.get("p_acc_unit_id"))%>");
				jQuery("#p_acc_unit_name").val("<%=StringUtil.deNull(bean.get("p_acc_unit_name"))%>");
			}else if(isFromPubList==="yes"){
				jQuery("#p_pub_user_id").val("<%=StringUtil.deNull(bean.get("p_pub_user_id"))%>");
				jQuery("#p_pub_user_name").val("<%=StringUtil.deNull(bean.get("p_pub_user_name"))%>");
				jQuery("#p_pub_unit_id").val("<%=StringUtil.deNull(bean.get("p_pub_unit_id"))%>");
				jQuery("#p_pub_unit_name").val("<%=StringUtil.deNull(bean.get("p_pub_unit_name"))%>");
			}
		<%	
		}
		%>
		
		jQuery("#p_contents").val("<%=save_p_contents%>");//采编后的word 正文id
		
		//处理附件
		var attachFlag=true;
		//isFileEnble(p_rep_attach_id,attachFlag);
		//处理滚动条
		var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
		jQuery("#treediv").height(_documentBodyHeight-100);
	});
	
	/*
	函数：init 
	描述：初始化方法
	*/
	function init() {
	    //WebOffice = document.getElementsByName("WebOffice")[0];
	    //
	    var weburltemp = "../../resources/plug/iWebOffice2009/OfficeServer.jsp";
	    webform.WebOffice.WebUrl = weburltemp; //设置控件与服务器交互的url地址
	    webform.WebOffice.FileType = ".doc"; //设置文件类型，确定控件开发的应用程序
	    webform.WebOffice.EditType = "1,0"; //设置编辑状态
	    webform.WebOffice.ShowType = "1"; //设置显示状态
	    webform.WebOffice.ShowToolBar = "0"; //是否显示工具栏 0不显示 1显示
	    webform.WebOffice.ShowMenu = "0"; //是否显示菜单 0不显示 1显示
	    webform.WebOffice.MaxFileSize = 64 * 1024; //设置文件最大值
	    webform.WebOffice.Language="CH"; //设置界面显示语言
	    webform.WebOffice.UserName = ""; //设置用户名
	    webform.WebOffice.RecordID = "<%=p_contents%>";
	    webform.WebOffice.WebOpen();
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
	var saveWORD = function(pid){
		webform.WebOffice.RecordID = "<%=save_p_contents%>";//这里的保存为采编后发布前要用的word。
		webform.WebOffice.FILENAME=pid+".doc";
		webform.WebOffice.EXTPARAM="<%=isFromPubList%>";
		webform.WebOffice.WebSave(true)
		if(isfb=="4"){
			copydoc2pdf(pid);
		}
	}
	//doc另存为一份名字一样pdf
	var copydoc2pdf = function(pid){
		jQuery.ajax({
            type: "post",
            url: "paperlist4reporteddetaildo.jsp",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: {
                action: "copydoc2pdf",//送审即改为待发布
                p_manage_id: pid //要删除的id列表      
            },
            dataType: "json",
            success: function (result) {
            },
        });
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
				autoTitle("#p_acc_title",jQuery("#_fileshow li:first").contents().first().text());
			},'100');
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
	var isfb="";
	var updateFn = function(flag,flagname,inputObj){
		try{
			
			inputObj.disabled=true;
			if (inputObj.id=="btn_waitpublish" || inputObj.id=="btn_tmp" || inputObj.id=="btn_pub" || inputObj.id=="btn_save" || inputObj.id=="btn_pub"){
				if(!isSpace(flag)){
					var isFlag = jQuery('#formTable').validationEngine('validate'); //是否全部验证通过
					if (isFlag){
						jQuery("#hidden_action").val("addpaperlist4managedetail");
						jQuery("#p_flag_id").val(flag);
						jQuery('#p_flag_name').val(flagname);
						jQuery("#p_rep_type_name").val(jQuery("#p_rep_type_id option[value='']~option:selected").text());
						jQuery("#onlyFrom").submit();
					}
				}
				isfb=flag;
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
			        	removeWindows('paperlist4managedetail',true);
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
						saveWORD(result[1]);
					}
					window.location.href="<%=path%>/ccapp/oa/paper/jsp/"+result[2]+".jsp";
				}
				
			}
		}catch(e){alert(e.description);}
	};
	var chooseOrgbak = function (){//待删
		var s = new jQuery.z_tree();
		  s.treeID='mian';
		  s.treetypestr='radio';
		  s.isShowSeacher=true;
		  s.treeName="选取部门";
		  s.isType='dept';
		  s.headerName="选取部门";
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
	/*
	函数:  chooseOrg
	说明:  选择人员
	参数：   userId（回填父页面的控件id）,userName（回填父页面的控件id）,treetypestr（单选radio或多选checkbox）
	*/
	var chooseActUsers = function (userId,userName,treetypestr){
		var s = new jQuery.z_tree();
		s.treeID = 'mianUser';
		s.treetypestr = treetypestr;
		s.isShowSeacher = true;
		s.treeName = "选取人员";
		s.headerName = "选取人员";
		s.type = "APERSON";
		s.selectedIds = jQuery("#"+userId).val(),
		s.returnFunction = function(userObj,o) {
			if (!IsSpace(userObj)) {
				jQuery('#'+userId).val(userObj.id);
				jQuery('#'+userName).val(userObj.name);
			} else {
				jQuery('#'+userId).val("");
				jQuery('#'+userName).val("");
			}
		}
		s.init();
	}
	//更新领导批示
	var updateLeaderRemark = function(){
		jQuery.ajax({
            type: "post",
            url: "paperlist4reporteddetaildo.jsp",
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data: {
                action: "updateLeaderRemark",//送审即改为待发布
                p_manage_id: jQuery("#p_manage_id").val(),   
                p_leader_remark: jQuery("#p_leader_remark").val()
            },
            dataType: "json",
            success: function (result) {
                if (result.flag) {
                    alert("操作成功！");
                } else {
                    alert("操作失败！");
                }
            },
        });
	}
	</script>
</head>
<body>
<div id='tabs1' style="width:100%">
<%--button list--%>
<div class="content_02_top" style="margin-bottom:10px;width:99%" id="divA">
	<%//放这里速度快一些   //新增  
	if("AddOne4Acc".equals(actionName)  
			|| ("updatefromacced".equals(actionName) && StringUtil.deNull(bean.get("p_rep_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_ACCEPT) && StringUtil.deNull(bean.get("p_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_ACCEPT))
			|| ("updatefromtmp".equals(actionName) && StringUtil.deNull(bean.get("p_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_TMP))){ 
	%>
		<input type="button" class="but_y_01" value="送审"    onclick="updateFn('<%=PaperConstants.STATUS_WAIT_PUBLISH %>','待发布',this);" id="btn_waitpublish"/>
		<input type="button" class="but_y_01"  value="存草稿" title="草稿（采编）"  onclick="updateFn('<%=PaperConstants.STATUS_TMP %>','草稿（采编）',this);" id="btn_tmp"/>
	<%//已采编 第一次操作 两 个状态 都1时
	}else if(("updatefromacced".equals(actionName) 
			&& StringUtil.deNull(bean.get("p_rep_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_ACCEPT) 
			&& StringUtil.deNull(bean.get("p_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_ACCEPT))){
	%>
		<input type="button" class="but_y_01" value="送审"    onclick="updateFn('<%=PaperConstants.STATUS_WAIT_PUBLISH %>','待发布',this);" id="btn_waitpublish"/>
		<input type="button" class="but_y_01"  value="存草稿" title="草稿（采编）"  onclick="updateFn('<%=PaperConstants.STATUS_TMP %>','草稿（采编）',this);" id="btn_tmp"/>
	<%//已采编 ，做送审等处理的  即已送审过 且为退回时 才能有下列按钮的操作权限
	}else if(("updatefromacced".equals(actionName) 
			&& StringUtil.deNull(bean.get("p_rep_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_ACCEPT) 
			&& StringUtil.deNull(bean.get("p_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_UNDONE))){
	%>
		<input type="button" class="but_y_01" value="送审"    onclick="updateFn('<%=PaperConstants.STATUS_WAIT_PUBLISH %>','待发布',this);" id="btn_waitpublish"/>
		<input type="button" class="but_y_01"  value="存草稿" title="草稿（采编）"  onclick="updateFn('<%=PaperConstants.STATUS_TMP %>','草稿（采编）',this);" id="btn_tmp"/>
	<%//已送审的都不可编辑，只有被退回
	}else if("viewpending".equals(actionName) 
			&& StringUtil.deNull(bean.get("p_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_UNDONE)){
	%>
		<input type="button" class="but_y_01" value="送审"    onclick="updateFn('<%=PaperConstants.STATUS_WAIT_PUBLISH %>','待发布',this);" id="btn_waitpublish"/>
		<input type="button" class="but_y_01"  value="存草稿" title="草稿（采编）"  onclick="updateFn('<%=PaperConstants.STATUS_TMP %>','草稿（采编）',this);" id="btn_tmp"/>
	<%//草稿箱 可以操作
	}else if("updatefromtmp".equals(actionName)
			&& (StringUtil.deNull(bean.get("p_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_TMP))){
	%>
		<input type="button" class="but_y_01" value="送审"    onclick="updateFn('<%=PaperConstants.STATUS_WAIT_PUBLISH %>','待发布',this);" id="btn_waitpublish"/>
		<input type="button" class="but_y_01"  value="存草稿" title="草稿（采编）"  onclick="updateFn('<%=PaperConstants.STATUS_TMP %>','草稿（采编）',this);" id="btn_tmp"/>
	<%		
	}
	/* 发布操作权限
	前提不能是从已送审列表中打开的
	AddOne4Published 新增发布时
	STATUS_REVISE 为草稿时
	STATUS_WAIT_PUBLISH 等待发布时，但列表入口不是‘viewpending’已送审列表中打开时
	*/
	//新增发布，都可用
	if("AddOne4Published".equals(actionName)){
	%>
		<input type="button" class="but_y_01" value="发布"    onclick="updateFn('<%=PaperConstants.STATUS_PUBLISHED %>','已发布',this);" id="btn_pub"/>
		<input type="button" class="but_y_01"  value="存草稿"   onclick="updateFn('<%=PaperConstants.STATUS_REVISE %>','草稿（发布）',this);" id="btn_pub"/>
	<%		
	}else if ("updatefromwait".equals(actionName) 
			&& (StringUtil.deNull(bean.get("p_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_WAIT_PUBLISH)) ){
	%>
		<input type="button" class="but_y_01" value="发布"    onclick="updateFn('<%=PaperConstants.STATUS_PUBLISHED %>','已发布',this);" id="btn_pub"/>
		<input type="button" class="but_y_01"  value="存草稿"   onclick="updateFn('<%=PaperConstants.STATUS_REVISE %>','草稿（发布）',this);" id="btn_pub"/>
		<input type="button" class="but_y_01"  value="退回"   onclick="updateFn('<%=PaperConstants.STATUS_UNDONE %>','退回',this);" id="btn_pub"/>
	<%	
	}else if ("updatefromok".equals(actionName)){
	}else if ("updatefromundone".equals(actionName)
			&& (StringUtil.deNull(bean.get("p_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_UNDONE)) ){
		%>
		<input type="button" class="but_y_01"  value="存草稿"   onclick="updateFn('<%=PaperConstants.STATUS_REVISE %>','草稿（发布）',this);" id="btn_pub"/>
	<%	
	}else if ("updatefromrevise".equals(actionName)
			&& (StringUtil.deNull(bean.get("p_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_REVISE)) ){
	%>
		<input type="button" class="but_y_01" value="发布"    onclick="updateFn('<%=PaperConstants.STATUS_PUBLISHED %>','已发布',this);" id="btn_pub"/>
		<input type="button" class="but_y_01"  value="存草稿"   onclick="updateFn('<%=PaperConstants.STATUS_REVISE %>','草稿（发布）',this);" id="btn_pub"/>
		<input type="button" class="but_y_01"  value="退回"   onclick="updateFn('<%=PaperConstants.STATUS_UNDONE %>','退回',this);" id="btn_pub"/>
	<%
	} 
	%>
	<input type="button" class="but_y_01" value="返回"    onclick="cancelFn('back',this);" id="btn_cancel"/>
</div>
<%--button list--%>

<form id="onlyFrom" name="onlyFrom" method="post" action="paperlist4reporteddetaildo.jsp" target="fileTempleateinfodoJSPhiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<input value="<%=p_manage_id%>" type="hidden" name="p_manage_id" id="p_manage_id"/>
<input value="" type="hidden" name="p_acc_user_id" id="p_acc_user_id"/><!-- 采编人 -->
<input value="" type="hidden" name="p_acc_user_name" id="p_acc_user_name"/>
<input value="" type="hidden" name="p_acc_unit_id" id="p_acc_unit_id"/><!-- 采编单位 -->
<input value="" type="hidden" name="p_acc_unit_name" id="p_acc_unit_name"/>
<input value="" type="hidden" name="p_flag_id" id="p_flag_id"/><!-- 状态  ，送审和存草稿就不处理之前的上报状态（p_rep_flag_id）了 -->
<input value="" type="hidden" name="p_flag_name" id="p_flag_name"/>
<input value="" type="hidden" name="p_rep_type_name" id="p_rep_type_name"/><!-- 类型名 -->
<input value="" type="hidden" name="p_contents" id="p_contents"/>
<input value="1" type="hidden" name="p_is_use" id="p_is_use"/>
<input value="" type="hidden" name="p_pub_user_id" id="p_pub_user_id"/><!-- 发布人 -->
<input value="" type="hidden" name="p_pub_user_name" id="p_pub_user_name"/>
<input value="" type="hidden" name="p_pub_unit_id" id="p_pub_unit_id"/><!-- 发布单位 -->
<input value="" type="hidden" name="p_pub_unit_name" id="p_pub_unit_name"/>
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
									<input value="<%if(StringUtil.deNull(bean.get("p_flag_id")).equalsIgnoreCase(PaperConstants.STATUS_ACCEPT)){out.print(StringUtil.deNull(bean.get("p_rep_title")));}else {out.print(StringUtil.deNull(bean.get("p_acc_title")));}%>" type="text" name="p_acc_title" id="p_acc_title" class="validate[required,maxSize[200]] input_title_text" />
								</td>
								<th class="content_02_box_div_table_th" style="width: 15%;">
									<span style="color: red;">*</span>类型：</th>
								<td class="content_02_box_div_table_td" style="width: 35%;">
									<%=p_rep_type_id_selectHtml %>
								</td>
							</tr>
							<tr>
								<th class="content_02_box_div_table_th" style="width: 150px;">
									<span style="color: red;">*</span>信息来源：</th>
								<td class="content_02_box_div_table_td" style="width: 150px;">
									<input value="<%=StringUtil.deNull(bean.get("p_rep_unit_name"))%>" type="text" name="p_rep_unit_name" id="p_rep_unit_name" onclick="chooseOrg()" readonly class="input_title_text" style="width:220px;" />
									<input value="<%=StringUtil.deNull(bean.get("p_rep_unit_id"))%>" type="hidden" name="p_rep_unit_id" id="p_rep_unit_id" />
									<input name="chooseOrgbutton" id="chooseOrgbutton" type="button" class="but_x" style="height: 26px;" onclick="chooseOrg()" />
								</td>
								<%if (!isFromPubList){ //非发布才显示%>
									<th class="content_02_box_div_table_th" style="width: 150px;">
										<span style="color: red;">*</span>审核人员：</th>
									<td class="content_02_box_div_table_td" style="width: 150px;">
										<input type="hidden" name="p_sub_user_ids" id="p_sub_user_ids" value="<%=StringUtil.deNull(bean.get("p_sub_user_ids"))%>" class="validate[required]" />
									    <input type="text" id="p_sub_user_names" name="p_sub_user_names" value="<%=StringUtil.deNull(bean.get("p_sub_user_names"))%>" class="validate[required] input_title_text" 
									    	onclick="chooseActUsers('p_sub_user_ids','p_sub_user_names','checkbox')" />
									</td>
								<%}else{ %>
									<th class="content_02_box_div_table_th" style="width: 150px;">
									<span style="color: red;"></span></th>
									<td class="content_02_box_div_table_td" style="width: 150px;">
									</td>
								<%} %>
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
				<%if ("updatefromok".equals(actionName)||"query".equals(actionName)) {%>
				<div class="content_02_box" style="width:850px;">
					<div class="content_02_box_div" style="width:850px;">
						<table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width:850px;">
							<tr>
								<th class="content_02_box_div_table_th" style="width: 50px;">
									领导批示：
								</th>
								
								<td class="content_02_box_div_table_td" style="width: 150px;" colspan=3>
									<input value="<%=StringUtil.deNull(bean.get("p_leader_remark"))%>" 
									type="text" name="p_leader_remark" id="p_leader_remark" 
									class="validate[required,maxSize[200]] input_title_text"  style="width:480px;" />
									<%if (canUpdate) {%><input type="button"  class="but_y_01" style="float:right;" value="提交" onclick="updateLeaderRemark()"/><%} %>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<%} %>
			</div>
		</td>
	</tr>
</table>
</form>
<iframe name="fileTempleateinfodoJSPhiddenFrame" width=0 height=0></iframe>
</div>
</body>
</html>
