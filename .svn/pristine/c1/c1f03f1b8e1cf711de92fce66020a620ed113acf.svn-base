<%--
　　描述：知识库管理文档明细界面---含查询权限控制
　　作者：黄海
　　版本：1.0
　　日期：2013-8-13
--%>
<%@page import="com.chinacreator.xtbg.core.upload.util.UploadConstants"%>
<%@page import="java.sql.Timestamp"%>
<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.dao.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmConstants"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<%
	String windowId = StringUtil.deNull(request.getParameter("windowId"));
	String opentype = StringUtil.deNull(request.getParameter("opentype"));

	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	
	String type = StringUtil.deNull(request.getParameter("type"));//首页传过来的参数
	String subid1 = StringUtil.deNull(request.getParameter("subid1"));
	String k_doc_id = StringUtil.deNull(request.getParameter("k_doc_id"));
	String k_receiverid = StringUtil.deNull(request.getParameter("k_receiverid"));//浏览接收表主键ID
	String k_title = "";
	String k_code = "";
	String k_type_id = "";
	String k_type_name = "";

	String k_key = "";
	String k_secrecy_id = "";//select的name就id选定时确定
	String k_first_time = "";
	String user_id = accesscontroler.getUserID();

	UserCacheBean usercachebean = UserCache.getUserCacheBean(user_id);
	String type_unit = usercachebean.getUnit_id();//当前用户单位
	String type_dept = usercachebean.getOrg_id();//当前用户部门

	String k_unit = "";//单位
	String k_unit_name = "";
	String k_dept = "";//部门
	String k_dept_name = "";

	String k_contents = "";
	String k_attach_id ="";
	String k_flag = "";
	String k_flag_name = "";
	String k_remark = "";

	String isCanDownLoad = "";
	
	String isSuggest = "";
	
	String k_users = "";
	String k_upload_type ="";

	if (StringUtil.nullOrBlank(k_doc_id)) {//为空，新增时

	} else {
		KbmDocService service = new KbmDocServiceImpl();
		KbmDocBean model = new KbmDocBean();
		model = service.getKbmDocBeanById(k_doc_id);
		k_title = StringUtil.encoding4jQuery(model.getK_title());
		k_code = StringUtil.encoding4jQuery(model.getK_code());
		k_type_id = model.getK_type_id();
		k_type_name = model.getK_type_name();
		k_key = StringUtil.encoding4jQuery(model.getK_key());
		k_secrecy_id = model.getK_secrecy_id();
		k_first_time = model.getK_first_time().toString()
				.substring(0, 10);
		k_unit = model.getK_unit();//单位   更新时单位还是新增时的单位不变
		k_unit_name = model.getK_unit_name();
		k_dept = model.getK_dept();//部门
		k_dept_name = model.getK_dept_name();
		k_contents = StringUtil.encoding4jQuery(model.getK_contents());
		if (!StringUtil.nullOrBlank(model.getK_attach_id()))
			k_attach_id = model.getK_attach_id();
		k_flag = model.getK_flag();
		k_remark = StringUtil.encoding4jQuery(model.getK_remark());
		k_flag_name = model.getK_flag_name();
		k_upload_type = model.getK_upload_type();

		/* 权限判断 条件满足其一，便有下载附件的权限
		a)	知识库管理员;
		b)	上传人;
		c)	知识分类中定义的阅读权限;
		d)	被推荐的人。
		 */
		if (user_id.equalsIgnoreCase(model.getK_create_user())
				|| KbmUtil.isRolesUser(user_id, KbmConstants.ROLE_NAME)
				|| KbmUtil.isSuggestUser(k_doc_id, user_id)
				|| KbmUtil.isHaveRight(k_secrecy_id, k_type_id, user_id, type_unit, type_dept)) {
			isCanDownLoad = "yes";
		}
		
		//判断推荐按钮的权限add by jie.xiao 13-8-27
		if(user_id.equalsIgnoreCase(model.getK_create_user())
				||KbmUtil.isRolesUser(user_id, KbmConstants.ROLE_NAME)){
			isSuggest="yes";
		}
		//得到所以推荐人员，id用逗号隔开
        k_users = StringUtil.deNull(KbmUtil.getSuggestUserByDocId(k_doc_id));
		
      	//修改体系文件接收人状态
		KbmDocReceiveUserService kbmdocreceiveuserservice = new KbmDocReceiveUserServiceImpl();
		if(!StringUtil.isBlank(k_receiverid)){
			kbmdocreceiveuserservice.updateDocReceiverUserState(k_receiverid);
		}
	}
	
	//得到该文档所有评阅
	KbmDocBbsService service=new KbmDocBbsServiceImpl();
	List<Map<String,String>> list=service.selectKbmDocBbs(k_doc_id);

	//下拉框  选中的id由bean存的值确定
	String k_secrecy_id_dictType = "damj";//密级
	String k_secrecy_id_selectHtml = DictDropDownList
			.buildSelect4DictType(k_secrecy_id_dictType,
					"k_secrecy_id", StringUtil.deNull(k_secrecy_id),
					"", true, "", "",
					"class='validate[required] select_240'", "");
	
	//添加文档用户操作记录，表示该文档用户已经查看
	KbmDocOperateLogService logservice=new KbmDocOperateLogServiceImpl();
	KbmDocOperateLogBean  logbean=new KbmDocOperateLogBean();
	logbean.setK_create_user(usercachebean.getUser_id());
	logbean.setK_create_user_name(usercachebean.getUser_realname());
	String k_create_time= StringUtil.convertTimeToString(new Timestamp(System.currentTimeMillis()), "");
	logbean.setK_create_time(k_create_time);
	logbean.setK_doc_id(k_doc_id);
	logbean.setK_title(k_title);
	logbean.setK_is_read("1");
	logservice.addorupdataKbmDocOperateLog(logbean);
	
	if(StringUtil.isBlank(k_attach_id)){
		k_attach_id=StringUtil.getUUID();
	}
    
	//附件 上传 
	String departid = request.getParameter("departid");

	String serverName = (String) request.getServerName();
	String serverPort = String.valueOf(request.getServerPort());
	String contextPath = (String) request.getContextPath();

	String rootPath = request.getSession().getServletContext()
			.getRealPath("");
	rootPath = rootPath.replace("\\", "/");

	String tableName = "OA_FILEUPLOAD_KBM";
	String oType="0";
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>知识库管理文档明细界面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入提示 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<!-- 引入formvValidatetion -->
<script type="text/javascript" src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/formvalidation/jquery.validationEngine.js" charset="utf-8"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/util/public.js" ></script>
<script type="text/javascript" src="../resources/js/kbmdoc.js" ></script>
	<script src="<%=path%>/ccapp/oa/resources/util/htmlutil.js"
    type="text/javascript"></script>
<script>

var k_users = "<%=k_users%>";
var isCanDownLoad = "<%=isCanDownLoad%>";

var type="<%=type%>";
var subid1="<%=subid1%>";
var isSuggest = "<%=isSuggest%>";

var detailjsp = 'kbmdocdetail4query.jsp';
var bbsjsp = 'kbmdocbbsinfo.jsp'
var path = "<%=path%>";
var windowId = "<%=windowId%>";
var opentype = "<%=opentype%>";

var k_title="<%=k_title%>";
var k_doc_id="<%=k_doc_id%>";
var k_code="<%=k_code%>";
var k_type_id="<%=k_type_id%>";
var k_type_name="<%=k_type_name%>";
var k_key="<%=k_key%>";
var k_secrecy_id="<%=k_secrecy_id%>";
var k_unit="<%=k_unit%>";
var k_unit_name="<%=k_unit_name%>";
var k_dept="<%=k_dept%>";
var k_dept_name="<%=k_dept_name%>";
var k_first_time="<%=k_first_time%>";
var k_attach_id="<%=k_attach_id%>";
var k_flag="<%=k_flag%>";
var k_flag_name="<%=k_flag_name%>";
var oType="<%=oType%>";
var k_upload_type ="<%=k_upload_type%>";

jQuery(function() {
	MyFancyupload.createUpload('file_list', '#file_attach', '<%=path%>', '<%=path%>/servlet/pubFileUpload?buessid=<%=k_attach_id%>', false, "<%=k_attach_id%>",'','','011');
	jQuery("#k_title").focus();
	//1）绑定控件值
	initFormValues();
	
	jQuery("#eWebEditor1").attr("src",jQuery("#eWebEditor1").attr("src")+"&readonly=1");
	
	jQuery("#downloadButton").click(function(){
		//异步调用后台方法，把文档下载字段值更新+1
		updatekdcount(k_doc_id);
    });
	
    jQuery("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.kbm.list.KbmDocList4Where', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "k_doc_id",
            name : 'k_doc_id',
            index : 'k_doc_id',
            hidden : true
        }, {	
            label : "标题",
            name : 'k_title',
            index : 'k_title'
        }, {	
            label : "资料分类",
            name : 'k_type_name',
            index : 'k_type_name'
        }, {	
            label : "上传人",
            name : 'k_create_user_name',
            index : 'k_create_user_name'
        }, {	
            label : "上传时间",
            name : 'k_create_time',
            index : 'k_create_time'
        }
        ],
        sortname : 'k_create_time',
        //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
        sortorder : 'desc',
        //设置是否在Pager Bar显示所有记录的总数。
        viewrecords : true,
        
        rowNum : 10,
        //用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
        rowList : [ 10, 20, 30 ],//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
        jsonReader : { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
            repeatitems : false
        },
        //定义页码控制条Page Bar
        pagerintoolbar:true,//上面的分页条
        pagerinBottombar:true,//下面的分页条
    
        //设置Grid表格的标题，如果未设置，则标题区域不显示。
        search : toUserParamJosn(),
        prmNames : { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
            rows : "rows",
            //表示请求行数的参数名称  
            sort : "sidx",
            //表示用于排序的列名的参数名称  
            order : "sord",
            //表示采用的排序方式的参数名称 
            search : "search"
        },
        onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
				var model = jQuery("#gridTable").jqGrid('getRowData', id);
        		updateKbmDocDetail(model.k_doc_id);
			}
		}
    });
});

/*
函数:  toUserParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toUserParamJosn = function() {
	var str = "{'opentype':'"+opentype+"','k_doc_id':'"+k_doc_id+"','k_key':'"+jQuery("#k_key").val()+"'}";
return descape(escape(str));
}

/*
函数:  search
说明:  查询
参数:   无
返回值: 
*/
var search = function() {
	var sdata = { //构建查询需要的参数 
	  paramJson : toUserParamJosn()
	}; //获得当前postData选项的值  
	var postData = jQuery("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	jQuery.extend(postData, sdata);
	jQuery("#gridTable").jqGrid("setGridParam", {
	  search : true
	// 将jqGrid的search选项设为true  
	}).trigger("reloadGrid", [ {
	  page : 1
	} ]); //重新载入Grid表格，以使上述设置生效 
}

/*
函数:  updateKbmDocDetail
说明:  修改
参数:  无
返回值: 无
*/
var updateKbmDocDetail = function(k_doc_id) {
	var typeurl = 'opentype='+opentype; 
	window.location=getCurrentFilePath()+detailjsp+'?'+typeurl+'&k_doc_id='+k_doc_id+'&windowId=updateKbmDocDetailWindow&subid1='+subid1+'&type='+type;
}


//关闭弹窗
function closed(){
	if('first'==type){
		removeWindows(subid1,true);
	}else{
		closeAlertWindows(windowId, false, true);
	}
}

/**
    函数:  initFormValues
    说明:  “新增”时或“修改”时初始化相关控件
**/ 
function initFormValues(){
	jQuery("#k_title").val(decoding4jQuery(k_title));
	jQuery("#k_doc_id").val(k_doc_id);
	jQuery("#k_code").val(decoding4jQuery(k_code));
	jQuery("#k_type_id").val(k_type_id);
	jQuery("#k_type_name").val(k_type_name);
	jQuery("#k_secrecy_id").val(k_secrecy_id);
	jQuery("#k_unit").val(k_unit);
	jQuery("#k_unit_name").val(k_unit_name);
	jQuery("#k_dept").val(k_dept);
	jQuery("#k_dept_name").val(k_dept_name);
	jQuery("#k_first_time").val(k_first_time);
	jQuery("#k_attach_id").val(k_attach_id);
	jQuery("#k_upload_type").val(k_upload_type);
	jQuery("#k_key").val(k_key);
	//k_dcount新增为0,修改暂时不做处理
	
	//判断是否有推荐权限
	if(isSuggest=='yes'){
		jQuery("#suggest").show();
	}else{
		jQuery("#suggest").hide();
	}
	//不可修改
	jQuery("#k_type_name_button").remove()
	jQuery("textarea").prop("readonly", true);
	jQuery("#vcenter input[type=text][id!=task_name]:visible,#vcenter select:visible").unbind().each(function(){
		   HTMLUtil.readOnly(this);
	   });
}
/* 
函数:  closeform
说明:  关闭指定窗口，刷新其父页面列表
参数:  windowId 窗口id
*/
function closeform(windowId){
	closeAlertWindows(windowId, false, true);
}
/* 
函数:  openBBS
说明:  打开评论信息
参数:  windowId 窗口id
*/
var openBBS = function (){
	var typeurl = 'opentype='+opentype+'&k_doc_id='+k_doc_id+'&k_title='+k_title; 
	window.location=getCurrentFilePath()+bbsjsp+'?'+typeurl+'&windowId=updateKbmDocDetailWindow&type='+type+'&subid1='+subid1;
}

/*
函数:  openSuggest
说明:  选择人员
参数：   userId（回填父页面的控件id）,userName（回填父页面的控件id）,
		orgName(回填父页面的“单位”控件id),treetypestr（单选radio或多选checkbox）
*/
var openSuggest = function (userId,userName,orgName,treetypestr){
	var s = new jQuery.z_tree();
	s.treeID = 'mianUser';
	s.treetypestr = treetypestr;
	s.isShowSeacher = true;
	s.treeName = "选取人员";
	s.headerName = "选取人员";
	s.type = "APERSON";
	s.selectedIds = k_users;
	s.returnFunction = function(userObj,o) {
		if(!isSpace(userObj) && !isSpace(userObj.id)){
			addSuggest(userObj.id,k_doc_id)
		}
	}
	s.init();
};

/*
函数:  updatekdcount()
说明:  更新文档下载数
参数:  无
返回值: 无
*/
var updatekdcount = function (k_doc_id) {
     jQuery.ajax({
         type: "post",
         url: "kbmdocdetaildo.jsp",
         contentType: "application/x-www-form-urlencoded; charset=utf-8",
         data: {
             action: "updatekdcount",
             k_doc_id:k_doc_id
         },
         dataType: "json",
         success: function (result) {
         },
         error: function (XMLHttpRequest, textStatus, errorThrown) {
             alert("系统异常，请稍后再试！");
         }
     });
};
jQuery(function() {
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	if(""==type){
		if(_documentBodyHeight>450){
			jQuery("#vcenter").height(_documentBodyHeight-200);	
		}else{
			jQuery("#vcenter").height(_documentBodyHeight-50);	
		} 
	}else{
		jQuery("#vcenter").height(_documentBodyHeight-50);
	}
});
/*
函数:  addFavorites
说明:  添加收藏
参数:  无
返回值: 无
*/
var addFavorites = function (id) {
    var ids = k_doc_id;
    if (!ids.length) {
        alert("未选中文档项，请重新选择要收藏的文档项！");
    } else {
        var okF = function () {
            jQuery.ajax({
                type: "post",
                url: "kbmdocdetaildo.jsp",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data: {
                    action: "addfavorites",
                    k_doc_ids: ids //要删除的id列表      
                },
                dataType: "json",
                success: function (result) {
                    if (result) {
                        alert("操作成功！");
                        search();
                    } else {
                        alert("操作失败！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("系统异常，请稍后再试！");
                }
            });
        }
        var p = {
            headerText: '提示',
            okName: '确认',
            okFunction: okF,
            cancelName: '取消'
        };
        alert("确定收藏吗？", p);
    }
};
</script>
</head>
<body>
	<div class="content_02_top">
		<input value="评论信息(<%=list.size() %>)" onclick="openBBS()" type="button" class="but_y_03" style="width: 105px"/>
		<input value="推荐" onclick="openSuggest()" type="button" class="but_y_01" id="suggest" />
		<input value="收藏" onclick="addFavorites()" type="button" class="but_y_01" id="suggest" />
		<input value="关闭" onclick="closed()" type="button" class="but_y_01" />
	</div>
	
	<div id="vcenter" class="vcenter" style="float: left; width: 100%; height:650px;overflow-y: scroll" scrolling="yes">
		<table border="0" cellspacing="0" cellpadding="0"
			class="content_02_box_div_table" style="width: 100%;">
			<tr>
				<td>
					<form id="form1" name="form1" action="" method="post">
						<div style="float: left; width: 990px;">
							<div class="content_02_box" style="width: 990px;">
								<div class="content_02_box_title_bg" style="width: 98%;">
									<span>基本信息</span>
								</div>
								<div class="content_02_box_div" style="width: 98%;">
									<table border="0" cellspacing="0" cellpadding="0"
										class="content_02_box_div_table" style="width: 100%;">
										<tr>
											<th class="content_02_box_div_table_th"><span
												class="color_red">*</span>标题：</th>
											<td class="content_02_box_div_table_td" colspan=3><input
												type="text"
												class="validate[required,maxSize[200]] input_cx_title_240"
												style="width: 550px;" name="k_title" id="k_title" />
											</td>
										</tr>
										<tr>
											<th class="content_02_box_div_table_th"><span
												class="color_red">*</span>所属分类：</th>
											<td class="content_02_box_div_table_td" style="width: 290px">
												<input name="k_type_name" id="k_type_name" type="text"
												readonly="readonly"
												class="validate[required,maxSize[100]] input_160"
												style="width: 240px; height: 22px;" /> <input
												name="k_type_name_button" id="k_type_name_button"
												type="button" class="but_x" style="height: 24px;" /> <input
												name="k_type_id" id="k_type_id" type="hidden" />
											</td>
											<th class="content_02_box_div_table_th"><span
												class="color_red">*</span>文件形成日期：</th>
											<td class="content_02_box_div_table_td" style="width: 290px">
												<input class="validate[required] date_120 Wdate" type="text"
												id="k_first_time" name="k_first_time"
												onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
											</td>
										
										</tr>
										<tr>
											<th class="content_02_box_div_table_th">编号：</th>
											<td class="content_02_box_div_table_td"><input
												type="text" class="validate[maxSize[40]] input_cx_title_240"
												name="k_code" id="k_code" />
											</td>
											<th class="content_02_box_div_table_th">上传类型：</th>
											<td class="content_02_box_div_table_td"><input
												type="text" class="validate[maxSize[40]] input_cx_title_240"
												name="k_upload_type" id="k_upload_type" />
											</td>
										</tr>
										<tr>
											<th class="content_02_box_div_table_th"><span
												class="color_red">*</span>密级：</th>
											<td class="content_02_box_div_table_td" style="width: 290px">
												<%=k_secrecy_id_selectHtml%></td>
											<th class="content_02_box_div_table_th"><span
												class="color_red">*</span>发布单位：</th>
											<td class="content_02_box_div_table_td"><input
												type="text" readonly="readonly"
												class="validate[required,maxSize[50]] input_cx_title_240"
												name="k_unit_name" id="k_unit_name" /><input type="hidden"
												name="k_unit" id="k_unit" />
											</td>
										</tr>
										<tr>
											<th class="content_02_box_div_table_th"><span
												class="color_red">*</span>所属部门：</th>
											<td class="content_02_box_div_table_td" colspan="3"><input
												type="text" readonly="readonly"
												class="validate[required,maxSize[50]] input_cx_title_240"
												name="k_dept_name" id="k_dept_name" /><input type="hidden"
												name="k_dept" id="k_dept" />
											</td>
										</tr>
										<tr>
											<th class="content_02_box_div_table_th" valign="top">查看文件：</th>
											<td class="content_02_box_div_table_td" colspan=3>
												<ul id="file_list" ></ul>&nbsp;
											</td>
										</tr>
										<!-- <tr>
											<th class="content_02_box_div_table_th">内容：</th>
											<td class="content_02_box_div_table_td" colspan=3>
											<textarea style="display: none" id="k_contents" name="k_contents" class="validate[maxSize[500]] textarea_575" style="width: 99%;"><%=k_contents %></textarea>
											<iframe id="eWebEditor1" src="../../resources/plug/eWebEditor_V4.60/ewebeditor.htm?id=k_contents&style=gray" frameborder="0" 
											scrolling="no" width="100%" height="400"></iframe>
											</td>
										</tr>
										<tr>
											<th class="content_02_box_div_table_th">关键字：</th>
											<td class="content_02_box_div_table_td" colspan=3><input
												type="text"
												class="validate[maxSize[100]] input_cx_title_240"
												style="width: 550px;" name="k_key" id="k_key" />(关键字用<font
												color=red>半角的“,”</font>分开)</td>
										</tr> -->
										<tr>
											<th class="content_02_box_div_table_th">更新备注：</th>
											<td class="content_02_box_div_table_td" colspan=3><textarea
													id="k_remark" name="k_remark"
													class="validate[maxSize[500]] textarea_575"
													style="width: 550px;"><%=k_remark %></textarea>
											</td>
										</tr>
									</table>
									<div class="content_02_box_title_bg" style="width: 100%;">
										<span>相关文档</span>
									</div>
								</div>
							</div>
						</div>
					</form>
				</td>
			</tr>
			<tr>
				<td>
					<!-- 查询列表区 cGridArea(查询区样式)-->
					<div class="cGridArea" style="width: 990px;">
						<table id="gridTable"></table>
						<div id="gridPager"></div>
					</div>
				</td>
			</tr>
			<tr>
				<td height=50>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>