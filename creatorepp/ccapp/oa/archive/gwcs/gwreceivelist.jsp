<%-- 
描述：来文管理列表
作者：肖杰
版本：1.0
日期：2013-12-13
 --%>

<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache"%>
<%@page import="com.chinacreator.xtbg.core.archive.entity.OfficialDocumentRegisterHandleBean"%>
<%@page import="com.chinacreator.xtbg.core.archive.gwcs.services.impl.ReceiveGwServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.archive.gwcs.services.ReceiveGwService"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	
	String loginUserName = accesscontroler.getUserAccount();
	String typecode=StringUtil.deNull(OASystemCache.getContextProperty("shouwenbustypecode"));
	String busitype_code="";//记录typecode分割的xxx:yyy中的yyy
	String type="";//记录typecode分割的xxx:yyy中的xxx
	//int count=0;//记录typecode分割的长度
	if(!StringUtil.isBlank(typecode)){
		String[] arrtype= typecode.split(":");
		if(arrtype.length==2){
			type=arrtype[0];
			busitype_code=arrtype[1];
		}
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 引入my97时间控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<title>待办列表</title>

<script type="text/javascript">
var loginUserName = '<%=loginUserName%>';
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	
	});
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.archive.gwcs.list.ReceiveGwList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		//colNames: ['ins_id','公文传输返回ID','公文标题','文号','成文时间','公文是否发送成功','是否盖章成功','操作'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
            {
    			label:"gwreceive_id",
    			name: 'gwreceive_id',
    			index: 'gwreceive_id',
    			hidden: true
    		},{
    			label:"attach_id",
    			name: 'attach_id',
    			index: 'attach_id',
    			hidden: true
    		},
    		{
    			label:"公文标题",
    			name: 'title',
    			index: 'title',
    			width: 150,
    			editable: true
    		},
    		{
    			label:"文号",
    			name: 'serial_number',
    			index: 'serial_number',
    			width: 150,
    			editable: true
    		},
    		{
    			label:"主题词",
    			name: 'caption',
    			index: 'caption',
    			width: 150,
    			editable: true
    		}
    		,
    		{
    			label:"公文文件名",
    			name: 'file_name',
    			index: 'file_name',
    			width: 150,
    			editable: true
    		},
    		{
    			label:"是否分送",
    			name: 'is_accept',
    			index: 'is_accept',
    			width: 30,
    			editable: false,
    			formatter : function(value,column,model){
    				if(model.is_accept!="1"){
    					return "否";
    				}else{
    					return "是";
    				}
    			}
    		},
    		{
    			label:"分送单位",
    			name: 'org_name',
    			index: 'org_name',
    			width: 80,
    			editable: true
    		}
    		,
    		{
    			label:"公文发送时间",
    			name: 'send_date',
    			index: 'send_date',
    			width: 80,
    			editable: true,
    			formatter : function(value){
    				if(value&&value.length>10){
    					return value.substring(0,10);
    				}else{
    					return value;
    				}
    			}
    		},
    		{
    			label:"成文时间",
    			name: 'create_date',
    			index: 'create_date',
    			width: 80,
    			editable: true
    		},
    		{
    			label:"创建时间",
    			name: 'creator_time',
    			index: 'creator_time',
    			width: 80,
    			editable: true,
    			formatter : function(value){
    				if(value&&value.length>10){
    					return value.substring(0,10);
    				}else{
    					return value;
    				}
    			}
    		},
    		{
    			label:"信息来源",
    			name: 'insert_by_self',
    			index: 'insert_by_self',
    			width: 80,
    			formatter : function(value){
    				if(value&&value==1){
    					return "手动输入";
    				}else{
						return "公文落地";
    				}
    			}
    		},
    		{
    			label:"操作",
    			name: 'oper',
    			index: 'oper',
    			width: '80',
    			editable: true,
    			formatter : function(value,column,model){
    				var id = model.gwreceive_id;
    				if(model.is_accept!="1"){
    					return "<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02');"
    					+" onMouseOut=javascript:$(this).attr('class','but_y_01');  type='button' onclick=\"sendArchive('"+id+"')\" value='收文分发'/>";
    				}else{
    					return "";
    				}
    				
    			}
    		}
		],
		//sortname: 'last_updatetime',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortname: 'creator_time',
		sortorder: 'desc',
		viewrecords: true,
		loadComplete: function() {
	        var grid = $("#gridTable");
	        var ids = grid.getDataIDs();
	        for (var i = 0; i < ids.length; i++) {
	            grid.setRowData ( ids[i], false, {height: 20+i*2} );
	        }
	    },
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [5, 10, 15],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
		
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		//定义页码控制条Page Bar
		//caption: "待办列表",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toUserParamJosn(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		toolbar: [true,"top","<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id='addBtn' value='收文登记' type='button' onclick='addFileDocDetail()'/><input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='删除' id=del type='button' onclick='deleteFn()' value=''/>"],
		multiselect: true,
		onCellSelect:function (id,icol){
			if(icol>0){
				handle(id);
			}
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh:false
	});
});
var addFileDocDetail = function () {
	var path =  "<%=path%>/ccapp/oa/archive/gwcs/gwreceiveinfo.jsp?windowsId=addFileDocDetailWindow";
	openAlertWindows('addFileDocDetailWindow',path,'来文详细信息',900,530,'10%','10%');
}
afterSubmitFn=function(result){
	try{
		alert(result);
	}catch(e){alert(e.description);}
}
var deleteFn = function() {
	var ids = "";
    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
    var ids = new Array();
    var canDelete = true;
    $(selectedIds).each(function () {
        var model = jQuery("#gridTable").jqGrid('getRowData', this);
        ids.push(model.gwreceive_id);
        if(typeof(model.insert_by_self)=="undefined"||model.insert_by_self=='公文落地'||(model.insert_by_self=='手动输入'&&model.is_accept=='是')){
        	canDelete = false;
        	return;
        }
    });
    if(!canDelete){
    	alert("只能删除手动添加且还没发起流程的公文！");
    	return;
    }
	
    var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
    var ids = new Array();
    jQuery(selectedIds).each(function () {
        var model = jQuery("#gridTable").jqGrid('getRowData', this);
        ids.push(model.gwreceive_id);  
    });
    if (!ids.length) {
        alert("未选中文件项，请重新选择要删除的文件项！");
    } else {
        var okF = function(){
            //ajax方式提交数据
            jQuery.ajax({ 
                type: "post", 
                url: "gwreceiveinfodo.jsp", 
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data : {
                	action : "deleteGwreceiveBean",
                	delete1 : ids.join(",") //要删除的id列表      
                },
                dataType: "text", 
                success: function(flag){         
                	if (flag) {
    					alert("操作成功！");
    					userSearch();
    				} else {
    					alert("操作失败！");
    				}
                }, 
                error: function (XMLHttpRequest, textStatus, errorThrown) { 
                    alert("系统异常，请稍后再试！");
                }
             });
        }
        var p={
                    headerText:'提示',
                    okName:'确认',
                    okFunction:okF,
                    cancelName:'取消'
            };
        alert("删除后将不能恢复，确定删除吗？",p); 
    }
}
/*
函数:  userSearch
说明:  查询用户信息
参数:   无
返回值: 用户列表
*/
var userSearch = function() {
var sdata = { //构建查询需要的参数 
	paramJson: toUserParamJosn()
}; //获得当前postData选项的值  
var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
$.extend(postData, sdata);
$("#gridTable").jqGrid("setGridParam", {
	search: true // 将jqGrid的search选项设为true  
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
var sdata = {
	paramJson: descape(escape("{'username':'"+loginUserName+"'}"))
};
var postData = $("#gridTable").jqGrid("getGridParam", "postData");
$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
$("#gridTable").jqGrid("setGridParam", {
	search: true // 将jqGrid的search选项设为false  
}).trigger("reloadGrid", [{
	page: 1
}]);
resetSingleSearchDialog();
};

	/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
		var str="";
		var str = "{'creator_time':'"+$('#startSlTime').val()+"','create_date':'"+$('#endSlTime').val()+
				  "','title':'"+$('#title').val()+"','serial_number':'"+$('#serial_number').val()+"','is_send':'"+$('#is_send').val()+
				  "','isdxtx':'1'}";
	return descape(escape(str));
}

/*
函数:  resetSingleSearchDialog
说明:  清空值查询值
参数:   无
返回值: 无
*/
var resetSingleSearchDialog = function() {
$("text", "#queryTable").val("");
$("select:first option:first").attr("selected","selected");
}
/*
函数:  handle
说明:  查看详情
参数:   无
返回值: 无
*/
var handle = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var path =  "<%=path%>/ccapp/oa/archive/gwcs/gwreceiveinfo.jsp?windowsId=windowIds1&gwreceive_id="+model.gwreceive_id+"&org_name="+model.org_name;
	openAlertWindows('windowIds1',path,'来文详细信息',900,530,'10%','10%');
}


var sendArchive = function(id){
	var height = window.screen.availHeight;
	var width = window.screen.availWidth;
	var busitype_code='<%=busitype_code%>';
	var type='<%=type%>';
	if("type"==type){
		url = [
			'<%=path%>/ccapp/oa/archive/gwcs/gwreceivehandle.jsp',
			'?windowsId=newwindows',
			"&height="+height,
			"&width="+width,
			"&busitype_code="+busitype_code,
			"&<%=OfficialDocumentRegisterHandleBean.OFF_DOC_REG_ID%>="+id
		       ];
		openAlertWindows('newwindows',url.join(''),"来文处理",width,height,'0%','0%',function(){
			userSearch();
		});
	}else if("type_type"==type){
		openAlertWindows('newwindows','<%=path%>/ccapp/oa/archive/newflowmain.jsp?busitype_type_code='+busitype_code+'&<%=OfficialDocumentRegisterHandleBean.OFF_DOC_REG_ID%>='+id,"来文处理",800,400,'0%','0%',function(){
			userSearch();
		});
	}else{
		openAlertWindows('newwindows','<%=path%>/ccapp/oa/archive/newflowmain.jsp?<%=OfficialDocumentRegisterHandleBean.OFF_DOC_REG_ID%>='+id,"来文处理",800,400,'0%','0%',function(){
			userSearch();
		});
		
	}
}
</script>
</head>
<body>
<table width="100%" id="queryTable">
	<tr>
		<td>
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box" id="queryTable_search">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
								<th class="input_cx_title_th">标题：</th>
							    <td width="385" class="cx_title_td">
							   		<input id="title" name="title" type="text" class="input_cx_title_283" />
							    </td>
								<td width="385"  colspan="2"  >
									<input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01"/>
									<span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span>
								</td>
								
							</tr>
						</table>
						<!-- 固定查询 end-->
					</td>
					</tr>
					
					<tr>
						<td>
					<!-- 隐藏查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" id="hiddenArea" style="display:none">
						    <tr>
							    <th class="input_cx_title_th">文号：</th>
							    <td class="cx_title_td">
							   	 <input  id="serial_number" name="serial_number" type="text" class="input_cx_title_283" />
							    </td>
							    <th class="input_cx_title_th">创建时间：</th>
							<td class="cx_title_td" >
							<input class="date_120 Wdate" type="text" id="startSlTime" name="startSlTime" 
							onfocus="WdatePicker({onpicked:function(){$('#endSlTime').focus();}})"
							/>
							<span class="date_120_span">至</span>
							<input class="date_120 Wdate"  type="text" id="endSlTime" name="endSlTime" 
							onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startSlTime\')}',dateFmt:'yyyy-MM-dd'})"
							/>
						</td>
						    </tr>
						</table>
						<!-- 隐藏查询 end-->
						</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
			<!-- 查询列表区 cGridArea(查询区样式)-->
			<div class="cGridArea">
				<table id="gridTable"></table>
				<div id="gridPager"></div>
			</div>
			<!-- 查询列表区 -->
<form id="form1" name="form1"  method="post" >
</form>	
<iframe src=""  id="hiddenFrame"  name="hiddenFrame"  width="789px;" height="250px" style="display:none;border: 0;margin-top: 10px;margin-left: 0px" frameborder="0" />
</body>
</html>