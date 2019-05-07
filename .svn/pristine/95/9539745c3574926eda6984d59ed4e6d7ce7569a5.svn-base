<%--
描述：资料基本管理查询列表页面(index内右)
作者：肖杰
版本：1.0
日期：2013-08-21
--%>
<%@page import="com.chinacreator.xtbg.core.data.service.impl.DataTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.data.service.DataTypeService"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String GET_LIST_CLASS="com.chinacreator.xtbg.core.data.list.DataDataList";
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	//单位ID
	String d_data_unit_id = StringUtil.deNull(userBean.getUnit_id());
	//单位名称	
	String p_data_unit_name = accesscontroler.getChargeOrgName();
	//当前登录人ID
	String userId = accesscontroler.getUserID();
	UserCacheBean userbean=UserCache.getUserCacheBean(userId);
	//获取主键
	String d_type_id = request.getParameter("d_type_id");
	String d_type_name = request.getParameter("d_type_name");
	String d_type_level = request.getParameter("d_type_level");
	
	Map<String,String> parentBean = null;
	String parent_p_typeid = "";
	if(d_type_id!=null&&d_type_id.length()>0){
		DataTypeService service = new DataTypeServiceImpl();
		parentBean = service.getDataTypeBean(d_type_id);
		parent_p_typeid = d_type_id;
	}
	
	
	 //下拉框  选中的id由bean存的值确定
    String p_year_id_dictType = "nianfen";//年份
    String p_year_id_selectHtml = DictDropDownList.buildSelect4DictType(p_year_id_dictType,"d_data_year" , "", "" , true, "" ,"" ,"class='select_100_box_type'","" );
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- 引入formvValidatetion -->
	<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script src="../../resources/util/public.js" type="text/javascript"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<!-- 引入jGrid -->
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	
	
<%--query table begin--%>
<script type="text/javascript">
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			refreshGrid();
	    }
	});
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=<%=GET_LIST_CLASS%>',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['附件','编号','标题','所属分类','发布日期','登记时间','登记人所在部门','p_data_id','p_type_id'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		    {
			    name: 'attach_id',index: 'attach_id',width: '3',sortable:true
			},{
	        	name: 'd_data_code',index: 'd_data_code',width: '5',sortable:true
			},
			{
				name: 'd_data_name',index: 'd_data_name',width: '16',	sortable:true
			},{
				name: 'd_type_name',index: 'd_type_name',width: '7',	sortable:true
			},
			{
				name: 'd_data_put_time',index: 'd_data_put_time',width: '7',sortable:true
			},
			{
				name: 'd_data_create_time',index: 'd_data_create_time',width: '7',sortable:true
			},
			{
				name: 'd_data_dept_name',index: 'd_data_dept_name',width: '6',sortable:true
			},
			{
				name: 'd_data_id',index: 'd_data_id',	sortable:false,hidden:true
			},
			{
				name: 'd_type_id',index: 'd_type_id',	sortable:false,hidden:true
			}
		],
		sortname: 'd_data_create_time',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
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
		multiselect: false,
		onSelectRow: function(id) {
			modifyRow(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh:false
	});
});
function modifyRow(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	window.parent.location="databaseview.jsp?issaved=doview&d_data_id="+model.d_data_id;
};
$(function() {
	if(2==<%=d_type_level%>){
		$("#AddOne").show();
	}else{
		$("#AddOne").hide();
	}
});
/*
函数:  refreshGrid
说明:  静态加载列表数据，主要供子页面调用和删除字段后调用
参数:   无
*/
function refreshGrid() {
	var sdata = { //构建查询需要的参数 
		paramJson : toParamJosn()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search : true
	// 将jqGrid的search选项设为true  
	}).trigger("reloadGrid", [ {
		page : 1
	} ]); //重新载入Grid表格，以使上述设置生效
}

function toParamJosn(){
	//标题
	var d_data_name = jQuery("#d_data_name").val();
	//编号,
	var d_data_code =  jQuery("#d_data_code").val();
	//年份
	var d_data_year = jQuery("#d_data_year").val();
	
	var str = "{'d_data_unit_id':'<%=userbean.getUnit_id()%>','d_type_id':'<%=d_type_id%>','d_data_name':'"+d_data_name+"','d_data_code':'"+d_data_code+"','d_data_year':'"+d_data_year+"'}";	
	return escape(str);
}

btnClickFn = function(btnObj){
	try{
			btnObj.disabled=true;
			flag = btnObj.name;
			//新增
			if(flag =='AddOne'){
				urlTmp="&actionName=insert&d_type_id=<%=d_type_id%>&d_type_name=<%=d_type_name%>";
				toNewPage(urlTmp,btnObj.value);
			}
			//删除
			 if(flag==='Delete'){
				var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
				if(selectedIds.length>0){
					deleteList = '';
					for ( var i = 0; i < selectedIds.length; i++){
						model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[i]);
						deleteList+=model.d_data_id+",";
					}
					$("#hidden_action").val("deleteDataBaseInfo");
					$("#hidden_delete").val(deleteList);
					$("#onlyFrom").submit();
				}else{
					alert("请选择数据");
				}
			}//导出
			else if(flag =='UpLoad'){
				var url = getCurrentFilePath()+"/ajaxexcedatabase.jsp?"  +"windowId=windowId_paperPS&sJson="+toParamJosn();  
				if(jQuery("#hiddenFrame").size()==0){
				jQuery('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>'+
			           '<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">'+
			           '</form>').appendTo("body").submit();
				}
				if(jQuery("#downFrom").size()>0){
					jQuery("#downFrom").remove();
				}
			}
			
			btnObj.disabled=false;
		}catch(e){
			btnObj.disabled=false;
		}
	};
	
	toNewPage = function (urlTmp,pageName){
		pageCode = "databaseinfo";
		baseUrl = "databaseinfo.jsp?subid="+pageCode;
		if(urlTmp){
			baseUrl = baseUrl+urlTmp;
		}
		openWindows(pageCode,pageName,baseUrl,pageCode,false,window);
	};
	
	<%--提交后回调--%>
	afterSubmitFn=function(result){
		try{
			alert(result);
			window.parent.location.href="<%=path%>/ccapp/oa/data/jsp/databasemain.jsp?d_type_id=<%=d_type_id%>";
		}catch(e){alert(e.description);}
	}
	
</script>
</head>
<body style="overflow-x: auto;">
<table width="100%">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <th class="input_cx_title_th" style="width:50px;">标题：</th>
                    <td class="cx_title_td" style="width:150px;">
                        <input id="d_data_name" name="d_data_name" type="text" style="width:150px;" class="input_cx_title_283" />
                    </td>
                    <th class="input_cx_title_th" style="width:50px;">编号：</th>
                    <td class="cx_title_td" style="width:150px;">
                        <input id="d_data_code" name="d_data_code" type="text" style="width:150px;" class="input_cx_title_283" />
                    </td>
                    <th class="input_cx_title_th" style="width:80px;">资料年份：</th>
                    <td class="cx_title_td" style="width:150px;">
						<input class="date_120 Wdate"  type="text" id="d_data_year" name="d_data_year" onclick="WdatePicker({dateFmt:'yyyy'})" />
                    </td>
                    <td>
                    	<input value="搜索" type="button" onclick="refreshGrid()" class="but_y_01" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<%--query table end--%>
<table width="100%" style="margin-left: 0" class="tabs_search_ctable_box">
	<tr>
		<td width="100%" align="left" valign="top">
			<input name="UpLoad" value="导出" type="button" onclick="btnClickFn(this)" class="but_y_06" />
		</td>
	</tr>
	<tr>
		<td width="100%" align="left" valign="top">
		<div style="float:left;width:100%;margin-left: -10px" class="cGridArea">
			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
		</td>
	</tr>
</table>
<form id="onlyFrom" name="onlyFrom" method="post" action="databaseinfodo.jsp" target="filebaselisthiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<input type='hidden' name='delete' id="hidden_delete"/>
</form>
<iframe name="filebaselisthiddenFrame" width=0 height=0></iframe>
</body>
</html>