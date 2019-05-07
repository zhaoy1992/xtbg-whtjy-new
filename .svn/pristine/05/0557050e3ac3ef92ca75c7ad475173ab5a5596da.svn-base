$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	});
	$("#gridTable").jqGrid({
		url: path + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.common.iweboffice.list.ThWordTemplateList',  
		datatype: "json",
		mtype: "POST",
		height: "100%",
		autowidth: true,
		colModel: [ 
        {
        	label:"模版id",
			name: 'mb_id',
			index: 'mb_id',
			hidden: true
		},
		{
			label:"名称",
			name: 'mb_mc',
			index: 'template_name_th',
			width: '100',
			editable: true
		},
		{
			label:"创建者",
			name: 'mb_cjz',
			index: 'template_username_th',
			width: '30',
			editable: true
		},
		{
			label:"创建时间",
			name: 'mb_cjsj',
			index: 'template_creatortime_th',
			width: '40',
			editable: true
		},
		{
			label:"备注",
			name: 'mb_remark',
			index: 'template_remark_th',
			width: '40',
			editable: true
		},
		{
			label:"序号",
			name: 'template_sn',
			index: 'template_sn_th',
			width: '30',
			editable: true
		},
		{
			label:"业务类型",
			name: 'busitype_name',
			index: 'busitype_name',
			width: '30',
			editable: true
		}
		],
		sortname: 'template_sn_th',
		sortorder: 'asc',
		viewrecords: true,
		
		rowNum: 10,
		rowList: [10, 20, 30],
		gridComplete: function() { 
			var ids = $("#gridTable").getDataIDs(); 
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				
			}
		},
		jsonReader: { 
			repeatitems: false
		},
		pagerintoolbar:true,
		pagerinBottombar:true,
		search : toUserParamJosn(),
		filterOptionsDefValue:[0],
		prmNames: {
			rows: "rows",
			sort: "sidx",
			order: "sord",
			search : "search"
		},
		toolbar: [true,"top","<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add type='button' onclick='addWordTemplate()' value='添加'/>"
		/*+"<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=copy type='button' onclick='copyMB()' value='复制'/>"*/
		+"<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=delete type='button' onclick='deleteMB()' value='删除'/>"],
		multiselect: true,
		onCellSelect:function(id,iCol){
			if(iCol != 0 )
			{
				updateWordTemplate(id);
			}
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh:false
	});
	
	
	$("#t_gridTable").append("<div>").append("</div>");


});

	 
/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */

var toUserParamJosn = function() {
	var str = "{'template_name_th':'"+$('#mb_mc').val()+"'}";
	return descape(escape(str));
}

/*
函数:  personSearch
说明:  查询用户信息
参数:   无
返回值: 用户列表
*/
var userSearch = function() {
	
var sdata = { //构建查询需要的参数 
	paramJson: toUserParamJosn()
}; 
var postData = $("#gridTable").jqGrid("getGridParam", "postData"); 
$.extend(postData, sdata);
$("#gridTable").jqGrid("setGridParam", {
	search: true, 
	search : toUserParamJosn()
}).trigger("reloadGrid", [{
	page: 1
}]); 
}


var refreshGrid4WfactionInfo = function() {
	var sdata = { 
			paramJson: toUserParamJosn()
		}; 
		var postData = $("#gridTable").jqGrid("getGridParam", "postData"); 
		$.extend(postData, sdata);
		$("#gridTable").jqGrid("setGridParam", {
			search: true 
		}).trigger("reloadGrid", [{
			page: 1
		}]); 
}


/*
函数:  resetSingleSearchDialog
说明:  清空值查询值
参数:   无
返回值: 无
*/
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
$(":text", "#queryTable").val("");
$(":hidden", "#queryTable").val("");
$("select").each(function(){
	$(this).find("option:first").attr("selected","selected");
})
};

/*
函数:  clearSearch
说明:  重置
参数:   无
返回值: 无
*/
var clearSearch = function() {
	resetSingleSearchDialog();
	var sdata = {
		paramJson: toUserParamJosn()
	};
	var postData = $("#gridTable").jqGrid("getGridParam", "postData");
	$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
	$("#gridTable").jqGrid("setGridParam", {
		search: true // 将jqGrid的search选项设为false  
	}).trigger("reloadGrid", [{
		page: 1
	}]);

};

function updateWordTemplate(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var url = "thwordtemplatedetailframe.jsp?mb_id="+model.mb_id+"&org_id="+org_id+"&org_name="+org_name;
	
	openAlertWindows('windowId',getCurrentFilePath() + 'thwordtemplatedetailframe.jsp?mb_id='+model.mb_id+'&org_id='+org_id+'&org_name='+org_name+'&windowsId=windowId','更新套红模版','100%','100%','0%','0%',userSearch);
}	

function addWordTemplate(){
	var url = "thwordtemplatedetailframe.jsp?org_id="+org_id+"&org_name="+org_name;
	var width = screen.availwidth ;
	var height = screen.availheight;

	openAlertWindows('windowId',getCurrentFilePath() + 'thwordtemplatedetailframe.jsp?org_id='+org_id+'&org_name='+org_name+'&windowsId=windowId','新建套红模版','100%','100%','0%','0%',userSearch);
	
}

//删除
function deleteMB() {
	var ids = "";
	var tempArrs = [];
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	$(selectedIds).each(function(){
		var model = jQuery("#gridTable").jqGrid('getRowData', this);
		if(!IsSpace(model.mb_id))
		tempArrs.push("'"+model.mb_id+"'");
	})
	ids = tempArrs.join();
	if (IsSpace(ids)) {
		alert("请选择要删除的记录！");
	} else {
		doReturnOK = function(){
			alert("操作成功");
			userSearch();
		};
		var okF = function(){

			var url = "thwordtemplatedo.jsp?operationType=dodeletewordtemplate&ids="+ids;
			document.all.form1.action = url;
			document.all.form1.target = "hiddenFrame";
			document.all.form1.submit();
		}
		var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:okF,
		        cancelName:'取消'
		};
	alert("确定删除吗？",p)
	
	}
}

//复制
function copyMB() {
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	var jSelectedIds = $(selectedIds);
	if(jSelectedIds.size()==1){
		doReturnOK = function(actionType,mess){
			if(mess){
				userSearch();
				alert("操作成功,是否编辑?",{
					headerText:'提示',
					okName:'确认',
			        okFunction:function(){
			        	var url = getCurrentFilePath() + "thwordtemplatedetailframe.jsp?mb_id="+mess+"&org_id="+org_id+"&org_name="+org_name+'&windowsId=windowId';
						openAlertWindows('windowId',url,'更新套红模版','100%','100%','0%','0%',userSearch);
			        },
			        cancelName:'取消'
				});
			}else{
				alert("操作失败");
			}
		};
		jSelectedIds.each(function(){
			var model = jQuery("#gridTable").jqGrid('getRowData', this);
			var ids = model.mb_id;
			if(!IsSpace(ids)){
				var okF = function(){
					var url = "thwordtemplatedo.jsp?operationType=docopywordtemplate&ids="+ids;
					document.all.form1.action = url;
					document.all.form1.target = "hiddenFrame";
					document.all.form1.submit();
				};
				var p={
						headerText:'提示',
						okName:'确认',
				        okFunction:okF,
				        cancelName:'取消'
				};
				alert("确定复制吗？",p);
			}
		});
	}else if(jSelectedIds.size()==0){
		alert("请先选中一条记录！");
	}else if(jSelectedIds.size()>1){
		alert("每次只能复制一条记录!");
	}
}

function doReturnOK(){
	alert("操作成功");
	userSearch();
}
