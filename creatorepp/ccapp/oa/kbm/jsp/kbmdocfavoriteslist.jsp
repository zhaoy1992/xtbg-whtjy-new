<%--
描述：知识库我的收藏界面
作者：肖杰
版本：1.0
日期：2013-08-09

--%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userid=accesscontroler.getUserID();
	UserCacheBean usercachebean=UserCache.getUserCacheBean(userid);
	String tableName = "OA_FILEUPLOAD_KBM";
%>
<title>知识库我的收藏界面</title>
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
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.kbm.list.KbmDocFavoritesList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		    label : "我的收藏id",
		    name : 'k_favorites_id',
		    index : 'k_favorites_id',
		    hidden : true
		},{
            label : "k_attach_id",
            name : 'k_attach_id',
            index : 'k_attach_id',
            hidden : true
        },{
		    label : "收藏文档id",
		    name : 'k_doc_id',
		    index : 'k_doc_id',
		    hidden : true
		}, {
		    label : "标题",
		    name : 'k_title',
		    index : 'k_title',
		    editable : false,
		    width:300
		}, {
		    label : "资料分类",
		    name : 'k_type_name',
		    index : 'k_type_name',
		    width:200,
		    editable : false
		}, {
		    label : "上传人",
		    name : 'k_doc_user_name',
		    index : 'k_doc_user_name',
		    width:100,
		    hidden : true
		},{
			label : "上传时间",
			name : 'create_time',
			index : 'create_time',
			width : 100
		}, {
		    label : "收藏时间",
		    name : 'k_create_time',
		    index : 'k_create_time',
		    width:100,
		    editable : false
		},{
            label : "查看附件",
            name : 'lookatt',
            index : 'lookatt',
            width:60,
            formatter:function(cellvalue, options, rowObject){
				return "<input class='but_y_01'  type='button' id='notice' value='查看附件' onclick='lookattch("+options.rowId+")'/>";  
			}
        },{
            label : "下载附件",
            name : 'xiazai',
            index : 'xiazai',
            width:60,
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
        	label : "filename",
            name : 'filename',
            index : 'filename',
            hidden : true
        }
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
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		toolbar : [ true, "top","<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=del type='button' value='取消收藏' onclick='delFavorites()'/>"],
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
				"','k_create_time':'"+getWhere4Date()+
				"','k_dept_name':'"+$("#k_dept_name").val()+
				"','k_type_name':'"+$("#k_type_name").val()+
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
	 函数:  resetSingleSearchDialog
	 说明:  清空值查询值
	 参数:   无
	 返回值: 无
	 */
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
	$(":text", "#queryTable").val("");
	$('#ckzt option:first').attr('selected', 'selected');
};

var chooseOrg = function (){
	var s = new $.z_tree();
	  s.treeID='mian';
	  s.treetypestr='radio';
	  s.isShowSeacher=true;
	  s.treeName="选取部门";
	  s.isType='dept';
	  s.headerName="选取部门";
	  s.item_id = 'org_id';
	  s.selectedIds=$('#k_dept_name').val();
	  s.type='ADEPT';
	  s.returnFunction=function(orgObj){
		  if(!IsSpace(orgObj)){
				 $('#k_dept_name').val(orgObj.name);
			 }else{
				 $('#k_dept_name').val("");
			 }

		 }
	  s.init();
}
var chooseFileType = function (){
	var s = new jQuery.z_tree();
	s.treeID = 'mianType';
	s.treetypestr = "radio";
	s.isShowSeacher = true;
	s.treeName = "选择分类";
	s.headerName = "选择分类";
	s.type = "KBM_TYPE";
	s.selectedIds = jQuery("#k_type_name").val(),
	s.f_org_id = "<%=usercachebean.getUnit_id()%>";//所属单位id 全局的js变量 引用时注意
	s.returnFunction = function(nothing,object){    
	    try{
	    	if(!IsSpace(object)){
	    		jQuery("#k_type_name").val(object[0].name);
	    	}else{
	    		jQuery("#k_type_name").val("");
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
	 openAlertWindows('updateKbmDocDetailWindow', getCurrentFilePath() +'kbmdocdetail4query.jsp?'+typeurl+'&k_doc_id='+model.k_doc_id+'&windowId=updateKbmDocDetailWindow', '查询文档' ,1020,520,'5%','5%');
}

/*
函数:  delFavorites
说明:  删除
参数:   无
返回值: 无
*/
var delFavorites = function() {
	 var ids = "";
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		for ( var i = 0; i < selectedIds.length; i++) {
			var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
			if ("" != ids) {
				ids += ",";
			}
			ids += "'" + model.k_favorites_id + "'";
		}		 
	if (IsSpace(ids)) {
		alert("请选择要取消的收藏！");
	} else {
		var okF = function(){	
			$("#k_favorites_id").val(ids);
			var fm = document.getElementById("delForm1");
			fm.target = "hiddenFrame";
			fm.submit();}
			var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
			alert("确定要取消收藏吗？",p)
	}
}

	
var clear111 = function(){
    //清空输入框的值
   jQuery("input[type=text]").val("");
   //查询
   sysKbmDocSearch();
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
					<table id="searchTable" width="100%" border="0" cellspacing="3"
						cellpadding="0" class="tabs_search_ctable">
						<tr>

							<th class="input_cx_title_th" style="width: 70px;">标题：</th>
							<td  class="cx_title_td"><input type="text"
								class="input_cx_title_150" id="k_title"
								name="k_title" /></td>
							<th class="input_cx_title_th" style="width: 70px;">所属分类：</th>
							<td  width="120" class="cx_title_td"
								style="padding- top: 0px;">
								<input type="text" class="input_cx_title_150"  id="k_type_name" name="k_type_name" readonly onclick='chooseFileType()' />
							</td>
							<th class="input_cx_title_th" style="width: 90px;">所属部门：</th>
							<td   class="cx_title_td">
								<input type="text" class="input_cx_title_150"  id="k_dept_name" name="k_dept_name" readonly onclick='chooseOrg()' />
							</td>
						</tr>
						<tr>
							<th class="input_cx_title_th" style="width:100px;">上传时间：</th>
                    		<td class="cx_title_td">
                    			<input class="date_120 Wdate"type="text" id="begin_time" name="begin_time"onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 137px;"/>
							</td> 
							<th class="input_cx_title_th">至：</th>
                    		<td class="cx_title_td">
                    			<input class="date_120 Wdate"type="text" id="end_time" name="end_time"onfocus="WdatePicker({minDate:'#F{$dp.$D(\'begin_time\')}',dateFmt:'yyyy-MM-dd'})" style="width: 137px;"/>
							</td>
							<th class="input_cx_title_th" style="width: 70px;"></th>
							<td width="120">
								<input value="搜索" id="sel" type="button"onclick="sysKbmDocSearch();" class="but_y_01" />
								<input value="重置" id="reset" type="button" onclick="clear111();" class="but_y_01" />
							</td>
						</tr>
					</table> <!-- 固定查询 end-->
				</td>
			</tr>
		</table>


		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea">

			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
	</div>
<form id="delForm1" name="delForm1" method="post" action="delfavoritesdo.jsp">
	<input type="hidden" name="k_favorites_id" id="k_favorites_id" /> 
	<input type="hidden" name="action" value="delFavorites" />
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>