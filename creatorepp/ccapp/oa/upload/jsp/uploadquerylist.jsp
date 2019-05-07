<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.upload.util.UploadConstants"%>
<%@page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String userId= accesscontroler.getUserID();
String path = request.getContextPath();
String deployPath = request.getSession().getServletContext().getRealPath("/");
deployPath=deployPath.replace("\\", "/");

String departid = request.getParameter("departid");
String serverName = (String) request.getServerName();
String serverPort = String.valueOf(request.getServerPort());
String contextPath = (String) request.getContextPath();
String rootPath = request.getSession().getServletContext().getRealPath("");
rootPath = rootPath.replace("\\", "/");//-----根目录磁盘路径
String tableName = request.getParameter("tableName");//模块表名
String attach_id = request.getParameter("attach_id");//附件id
String oType = request.getParameter("oType"); //操作 权限   ,0只能下载
/* tableName="OA_FILEUPLOAD_PAPER";
attach_id="e7df4300-ab6e-4f56-b65c-25965ffc29bd";
oType="1"; */
String strPath = UploadConstants.UPLOADSAVEPATH;
%>
<head>
<title>文件上传</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" ></script>
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery_dialog/jquery_dialog.js"></script>

<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 引入其它  上传文件必要的-->
<script type="text/javascript" src="../../resources/util/public.js" ></script>
<script type="text/javascript" src="../../resources/plug/iWebFile2005/iWebFile2005.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/iWebFile2005/fileupload.js"   charset="utf-8"></script>
<script type="text/javascript">
var path='<%=path%>';
var oType = '<%=oType%>';
$(function() {
	$("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.upload.list.UploadList', 
		datatype: "json",
		mtype: "POST",
		height: "100%",
		autowidth: true,
		colNames: ['serverfile_name','file_id','filepos', 'yearfolder','monthfolder','文件名称 ', '添加时间 ', '文件类型 ','操作'],
		colModel: [ //最重要的数组之一，用于设定各列的参数
        {
  			name: 'serverfile_name',
  			index: 'serverfile_name',
  			width: 20,
  			hidden: true
  		},
        {
			name: 'file_id',
			index: 'file_id',
			width: 20,
			hidden: true
		},
        {
			name: 'filepos',
			index: 'filepos',
			width: 20,
			hidden: true
		},
		{
			name: 'yearfolder',
			index: 'yearfolder',
			width: 20,
			hidden: true
		},
		{
			name: 'monthfolder',
			index: 'monthfolder',
			width: 20,
			hidden: true
		},
		{
			name: 'serverfile_name',
			index: 'serverfile_name',
			width: 150,
			editable: true
		},
		{
			name: 'creatortime',
			index: 'creatortime',
			width: 80,
			search: true
		},
		{
			name: 'file_extra',
			index: 'file_extra',
			width: 80,
			editable: true
		},
		{
			name: 'act',
			index: 'act',
			width: 80
		}],
		search: false,
		sortable: false,
		editable: false,
		sortname: 'CREATORTIME',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				ae = "<button id='modify' class='but_y_01' onclick='lookfile(" + cl + ")' >在线预览</button> ";
				be = "<button id='modify' class='but_y_01' onclick='downFile(" + cl + ")' >下载</button> ";
				if(oType==="1"){
					ce = "<button id='delid' class='but_y_01' onclick='delFile(" + cl + ")'>删除</button> ";
				}else{
					ce = "";
				}
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					act:  ae + be + ce
				});
			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//pager: "#gridPager",
		//定义页码控制条Page Bar oType=0,1
		//caption: "jqGrid与Servlet集成",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toUserParamJosn(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search: "search"
			
		},
		 onCellSelect:function (id,icol)
			{
				if(icol != 0)
				{
					jQuery("#gridTable").setSelection(id,false);
					lookfile(id);
				}
			}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		refresh: false,
		search: false
	}); 
});
 
 /**
 *在线打开附件
 */
function lookfile(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var file_id = model.file_id;//附件主键编号
	var file_extra = model.file_extra;//文件类型
	if(file_extra =='doc' || file_extra =='docx'){
		var wordPath ="<%=path%>/ccapp/xtbg/public/util/jsp/iwebOffice2009.jsp?ShowToolBar=1&DBType=fileupload_kbm&FullSize=true&RecordID="+file_id;
		$("#iframe_iwebOffice").attr("src",wordPath);
	}else if(file_extra =='pdf'){
		var url = "<%=path%>/ccapp/oa/upload/jsp/showkbmpdf.jsp?file_id="+file_id;
		openAlertWindows('windowId',url,'预览文件',1500,710,0,0);
	}else{
		alert("暂不支持在线预览！");
	}
 }
 
/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var str = '{"attach_id":"<%=attach_id%>","tableName":"<%=tableName%>"}';
	return descape(str);
}
var downFile = function(id) {
	var attach_id = "<%=attach_id%>";
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var url="<%=deployPath+strPath+tableName%>/"+model.yearfolder+"/"+model.monthfolder+"/"+attach_id+"/"+model.filepos;
	location.href = urlpath+'download.jsp?RealFileName='+_pub.lang.zwzm(model.serverfile_name+'.'+model.file_extra)+'&path='+_pub.lang.zwzm(url);

}

var delFile = function(id) {
	var attach_id="<%=attach_id%>";
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	if (!confirm("确定要删除上传文件吗？")) {
		return;
	}
	jQuery.ajax({
        type: "post",
        url: urlpath+"delete.jsp",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: {
        	file_id:model.file_id,
            tableName:"<%=tableName%>",
            attach_id: "<%=attach_id%>"
        },
        dataType: "json",
        success: function (result) {
            if (result.flag) {
                alert(result.info);
            } else {
                alert(result.info);
            }
            search();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("系统异常，请稍后再试！");
        }
    });
}

/*
函数:  search
说明:  查询
参数:   无
返回值: 
*/
var search = function () {
    var sdata = { //构建查询需要的参数 
        paramJson: toUserParamJosn()
    }; //获得当前postData选项的值  
    var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
    $.extend(postData, sdata);
    $("#gridTable").jqGrid("setGridParam", {
        search: true
        // 将jqGrid的search选项设为true  
    }).trigger("reloadGrid", [{
        page: 1
    }]); //重新载入Grid表格，以使上述设置生效 
}
</script>
</head>
<body>
	<!-- 查询列表区 cGridArea(查询区样式)-->
	<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
	</div>
	<iframe id="iframe_iwebOffice"  name="iframe_iwebOffice" frameborder="0" scrolling="no" width="100%" height="800" style="display: none"></iframe>
</body>
</html>