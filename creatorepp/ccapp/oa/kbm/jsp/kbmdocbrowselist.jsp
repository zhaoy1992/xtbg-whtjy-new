<%--
描述：文件更新通知查询界面
作者：邱炼
版本：1.0
日期：2014-04-01

--%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.kbm.dao.KbmDocReceiveDao"%>
<%@page import="com.chinacreator.xtbg.core.kbm.dao.impl.KbmDocReceiveDaoImpl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid=accesscontroler.getUserID();
	UserCacheBean usercachebean=UserCache.getUserCacheBean(userid);
	KbmDocReceiveDao dao = new KbmDocReceiveDaoImpl();
	String txwjManager = dao.getTXWJManager();
	String is_txwjManager = "0";
	String tableName = "OA_FILEUPLOAD_KBM";
	String del = "";
	if(txwjManager.indexOf(userid)>=0){
		is_txwjManager = "1";
		del = "<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='删除' id=del type='button' onclick='deleteFn()' value=''/>";
	}
	
%>
<title>文件更新通知查询界面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script
	src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<script type="text/javascript">
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			sysKbmDocSearch();
		}
	});

	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.kbm.list.KbmDocReceiveList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
            label : "知识库ID",
            name : 'k_doc_id',
            index : 'k_doc_id',
            hidden : true
        },{
            label : "k_attach_id",
            name : 'k_attach_id',
            index : 'k_attach_id',
            hidden : true
        },{
            label : "k_type_id",
            name : 'k_type_id',
            index : 'k_type_id',
            hidden : true
        },{
            label : "k_receiverid",
            name : 'k_receiverid',
            index : 'k_receiverid',
            hidden : true
        }, {
            label : "标题",
            name : 'k_title',
            index : 'k_title',
            editable : false,
            width:200
        }, {
            label : "资料分类",
            name : 'k_type_name',
            index : 'k_type_name',
            width:150,
            editable : false
        }, {
            label : "发布单位",
            name : 'k_unit_name',
            index : 'k_unit_name',
            width:150,
            hidden : true
        }
        , {
            label : "上传人",
            name : 'k_create_user_name',
            index : 'k_create_user_name',
            width:120,
            hidden : true
        },{
            label : "上传时间",
            name : 'k_create_time',
            index : 'k_create_time',
            width:200,
            editable : false
        },{
        	label : "备注",
            name : 'k_remark',
            index : 'k_remark',
            width:200,
            editable : false,
            formatter:function(cellvalue, options, rowObject){
                return "<strong><span class=rowhighlight>"+cellvalue+"</span></strong>";
			}
        },{
            label : "查看附件",
            name : 'lookatt',
            index : 'lookatt',
            width:50,
            formatter:function(cellvalue, options, rowObject){
				return "<input class='but_y_01'  type='button' id='notice' value='查看附件' onclick='lookattch("+options.rowId+")'/>";  
			}
        },{
        	label : "下载附件",
            name : 'xiazai',
            index : 'xiazai',
            width:50,
            formatter:function(cellvalue, options, rowObject){
				return "<input class='but_y_01'  type='button' id='notice' value='下载附件' onclick='downFile("+options.rowId+")'/>";  
			}
        },{
        	label : "djsn",
            name : 'djsn',
            index : 'djsn',
            hidden : true
        },{
        	label : "file_type",
            name : 'file_type',
            index : 'file_type',
            hidden : true
        },{
        	label : "fileName",
            name : 'fileName',
            index : 'fileName',
            hidden : true
        },
        <%if("1".equals(is_txwjManager)){%>
        {
            label : "操作",
            name : 'act',
            index : 'act',
            width:50,
            formatter:function(cellvalue, options, rowObject){
				return "<input class='but_y_01'  type='button' id='notice' value='删除' onclick='deleteNotice("+options.rowId+")'/>";  
			}
        }
        <%}%>
        /* {
            label : "上传类型",
            name : 'k_upload_type',
            index : 'k_upload_type',
            width: 150,
            editable : false
        }, */
        /* {
        	label:"状态",
			name: 'k_flag',
			index: 'k_flag',
			width: 80,
			hidden: false
        }, */
        ],
		sortname: 'k_title',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'asc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() {
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
                var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				//if(model.k_flag == '未阅读') {
					isview = "<span>"+model.k_flag+"</span>";
					bt = "<strong><span class=rowhighlight>"+model.k_title+"</span></strong>";
					typename = "<strong><span class=rowhighlight>"+model.k_type_name+"</span></strong>";
					unit_name = "<strong><span class=rowhighlight>"+model.k_unit_name+"</span></strong>";
					create_username = "<strong><span class=rowhighlight>"+model.k_create_user_name+"</span></strong>";
					create_time = "<strong><span class=rowhighlight>"+model.k_create_time+"</span></strong>";
					//upload_type = "<strong><span class=rowhighlight>"+model.k_upload_type+"</span></strong>";
				//} else {
				/* 	isview = model.k_flag;
					bt = model.k_title;	
					typename = model.k_type_name;
					unit_name = model.k_unit_name;
					create_username = model.k_create_user_name;
					create_time = model.k_create_time; */
					//upload_type = model.k_upload_type;
				//}
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					k_isview:isview,
					k_title: bt,
					k_type_name: typename,
					k_unit_name: unit_name,
					k_create_user_name: create_username,
					k_create_time: create_time
					//k_upload_type:upload_type
				});
			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "接收到的电子公告",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toJson(),
		filterNames:["k_flag"],
		filterOptions:[[["--请选择--","--请选择--"],["未阅读","未阅读"],["已阅读","已阅读"]]],//alue text 后的值与显不
		filterOptionsDefValue:[0],
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar : [ true, "top","<%=del%>"],
		multiselect: true,
		onCellSelect:function (id,iCol)
        {
          if(iCol != 0)
            {
        	  update(id);
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
/*
	 函数:  toJson
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toJson = function() {
	var str ="{'k_title':'"+$("#k_title").val()+
		"','k_type_id':'"+$("#k_type_id").val()+
		"','k_create_time':'"+getWhere4Date()+
		"','k_create_user':'<%=userid%>'}";
	return descape(escape(str));
}

/*
函数:  getWhere4Date
说明:  得到起始日期
*/
var getWhere4Date = function() {
	var bt = jQuery("#begin_time").val();
	var et = jQuery("#end_time").val();
	var re = (isSpace(bt+et))?"":bt+","+et;
	return re;
}

//查看附件
var lookattch = function(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var file_id = model.djsn;//附件主键编号
	var file_extra = trim(model.file_type);//文件类型
	var height = window.screen.availHeight;
	var width = window.screen.availWidth;
	if(IsSpace(file_id)){
		alert("没有附件");
	}else{
		if(file_extra =='.doc' || file_extra =='.docx'){
			window.open("<%=path%>/servlet/pubFileDownload?djsn="+model.djsn+"&openType=online&fileName="+encodeURI(model.fileName),"_blank","width="+width+",height="+height+",left=0px,top=0px");
		}else if(file_extra =='.pdf'){
			var url = "<%=path%>/ccapp/oa/archive/viewpdf.jsp?djsn="+file_id;
			openAlertWindows('windowId',url,'预览文件',1500,710,0,0);
		}else{
			alert("暂不支持在线预览！");
		}
	}
}

//下载
var downFile = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var file_id = model.djsn;//附件主键编号
	if(IsSpace(file_id)){
		alert("没有附件");
	}else{
		try{ 
	        var elemIF = document.createElement("iframe");   
	        elemIF.src = "<%=path%>/servlet/pubFileDownload?djsn="+model.djsn+"&openType=download&fileName="+encodeURI(model.fileName);   
	        elemIF.style.display = "none";
	        document.body.appendChild(elemIF);   
	    }catch(e){ 
	 
	    }
	}
} 

/*
	 函数:  sysKbmDocSearch
	 说明:  查询存放位置信息
	 参数:   无
	 返回值: 
*/
var sysKbmDocSearch = function() {
	var sdata = { //构建查询需要的参数 
		paramJson: toJson()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search: true ,// 将jqGrid的search选项设为true  
		userFilters:toJson()
	}).trigger("reloadGrid", [{
		page: 1
	}]); //重新载入Grid表格，以使上述设置生效 
	
}

var deleteNotice = function(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	if (!confirm("确定要删除该记录吗？")) {
		return;
	}
	jQuery.ajax({
        type: "post",
        url: "<%=path%>/ccapp/oa/kbm/jsp/deleteupdatenotice.jsp",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data: {
        	k_doc_id : model.k_doc_id
        },
        dataType: "json",
        success: function (result) {
            if (result.flag) {
                alert(result.info);
            } else {
                alert(result.info);
            }
            sysKbmDocSearch();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("系统异常，请稍后再试！");
        }
    });
}

/*
	 函数:  clearSearch
	 说明:  重置
	 参数:   无
	 返回值: 无
	 */
var clearSearch = function() {
		 resetSingleSearchDialog();
	var sdata = {
		paramJson: toJson()
	};
	var postData = $("#gridTable").jqGrid("getGridParam", "postData");
	$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
	$("#gridTable").jqGrid("setGridParam", {
		search: true // 将jqGrid的search选项设为false  
	}).trigger("reloadGrid", [{
		page: 1
	}]);
	
};

/*
	 函数:  resetSingleSearchDialog
	 说明:  清空值查询值
	 参数:   无
	 返回值: 无
	 */
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
	$(":text", "#queryTable").val("");
	$('#ckzt option:first').attr('selected', 'selected');
};

var chooseFileType = function (){
	var s = new jQuery.z_tree();
	s.treeID = 'mianType';
	s.treetypestr = "radio";
	s.isShowSeacher = true;
	s.treeName = "选择分类";
	s.headerName = "选择分类";
	s.type = "KBM_TYPE";
	s.selectedIds = jQuery("#k_type_id").val(),
	s.f_org_id = "<%=usercachebean.getUnit_id()%>";//所属单位id 全局的js变量 引用时注意
	s.returnFunction = function(nothing,object){    
	    try{
	    	if(!IsSpace(object)){
	    		jQuery("#k_type_name").val(object[0].name);
	    		jQuery("#k_type_id").val(object[0].id);
	    	}else{
	    		jQuery("#k_type_name").val("");
	    		jQuery("#k_type_id").val("");
	    	}
	    }catch(e){
	    }
	}
	s.init();
}
/*
 函数:  update
 说明:  修改
 参数:   无
 返回值: 无
*/
var update = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var typeurl = 'opentype=query'; 
	openAlertWindows('updateKbmDocDetailWindow', getCurrentFilePath() +'kbmdocreceiveinfo.jsp?'+typeurl+'&k_doc_id='+model.k_doc_id+'&k_receiverid='+model.k_receiverid+'&windowId=updateKbmDocDetailWindow', '查询文档' ,1020,520,'5%','5%');
}
var clear111 = function(){
    //清空输入框的值
   jQuery("input[type=text]").val("");
   //查询
   sysKbmDocSearch();
}


/*
函数:  deleteFn
说明:  删除
参数:  无
返回值: 无
*/
var deleteFn = function (id) {
    var ids = "";
    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
       for (var i = 0; i < selectedIds.length; i++) {
           var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[i]);
           if ("" != ids) {
                ids += ",";
            }
           ids += "'"+model.k_doc_id+"'";
        }
    if (IsSpace(ids)) {
        alert("未选中文件项，请重新选择要删除的文件项！");
    } else {
        var okF = function () {
            jQuery.ajax({
                type: "post",
                url: "kbmdocdetaildo.jsp",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data: {
                    action: "deleteUpdate",
                    ids: ids //要删除的id列表      
                },
                dataType: "json",
                success: function (result) {
                    if (result) {
                        alert("操作成功！");
                        sysKbmDocSearch();
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
        alert("删除后将不能恢复，确定删除吗？", p);
    }
}
</script>
</head>
<body>
	<div>
		<table id="queryTable" width="100%" border="0" cellspacing="0"
			cellpadding="0" class="tabs_search_ctable_box">
			<tr>
				<td>
	            <!-- 固定查询 -->
	            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
					<tr>
						<th class="input_cx_title_th">标题：</th>
						<td class="cx_title_td" style="width:150px;"><input type="text"
							id="k_title" name="k_title" class="input_cx_title_283"
							style="width: 133px;" />
						</td>
						<th class="input_cx_title_th">所属分类：</th>
						<td class="cx_title_td" style="width:160px;"><input
							name="k_type_name" id="k_type_name" type="text"
							readonly="readonly"
							class="validate[required,maxSize[100]] input_cx_title_283"
							style="width: 133px; height: 22px;" onclick='chooseFileType();' />  <input name="k_type_id"
							id="k_type_id" type="hidden" />
						</td>
					</tr>
					<tr>
						<th class="input_cx_title_th" style="width:100px;">上传时间：</th>
                    	<td class="cx_title_td"><input class="date_120 Wdate"
							type="text" id="begin_time" name="begin_time"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 137px;"/>
						</td> 
						<th class="input_cx_title_th">至：</th>
                    	<td class="cx_title_td">
                    		<input class="date_120 Wdate"
							type="text" id="end_time" name="end_time"
							onfocus="WdatePicker({minDate:'#F{$dp.$D(\'begin_time\')}',dateFmt:'yyyy-MM-dd'})" style="width: 137px;"/>
						</td>
						<td ><input value="搜索" id="sel" type="button" onclick="sysKbmDocSearch();" class="but_y_01" />
							<input value="重置" id="sel" type="button" onclick="clear111();" class="but_y_01" />
						</td>
						
					</tr>
				</table>
	            <!-- 固定查询 end-->
				</td>
			</tr>
		</table>


		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea">

			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
	</div>
</body>
</html>