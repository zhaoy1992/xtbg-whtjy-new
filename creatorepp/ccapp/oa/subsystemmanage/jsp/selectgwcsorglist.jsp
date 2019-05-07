<%-- 
描述：公文传输选择列表
作者：shuqi.liu
版本：1.0
日期：2014-03-26
 --%>
<%@page contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();

%>
<title>环节回退</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" ></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type='text/javascript' src='../../../oa/process/flowprocessing/js/alertworkflow.js'></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"></script>

<!-- 当jqGrid列的字过多的时候显示...样式  -->

<script type="text/javascript">
jQuery(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			orgSearch();
		}
	});
	
	var pwindows = getParentWindow("windowIds");
	
	jQuery("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.subsystemmanage.list.GwcsOrgList',
		datatype: "json",
		mtype: "POST",
		height: "100%",
		autowidth: true,
		colModel: [ 
		{
			label:' ',
		  	name: 'rr',
		    index:'rr',
		   	width: 20,
			search: false,
			sortable: false,
			editable: false
		},{
			label:"机构ID",
			name: 'org_id',
			index: 'org_id',
			width: 120
		},
		{
			label:"机构名称",
			name: 'org_name',
			index: 'org_name',
			width: 120
		},
		{
			label:"机构地址码",
			name: 'org_addr',
			index: 'org_addr',
			width: 120
		}
		],
		sortname: 'org_addr',
		sortorder: 'desc',
		viewrecords: true,
		
		rowNum: 10,
		rowList: [10, 20, 30],
		gridComplete: function() {
			var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				if(i==0){
					be = "<input type='radio' checked='checked'   name='r1' />";
				}else{
					be = "<input type='radio'  name='r1' />";
				}
				
				
			jQuery("#gridTable").jqGrid('setRowData', ids[i], {
				rr: be
			});

			}
		},
		jsonReader: { 
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,
		search : toUserParamJosn(),
		
		prmNames: { 
			rows: "rows",
			sort: "sidx",
			order: "sord",
			search : "search"
		},
		multiselect: false,
		onCellSelect: function(id,iCol) {
			
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
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var str = "{'org_name':'"+jQuery("#gwcs_orgname").val()+"'}";
	return descape(escape(str));
}

/*
函数:  userSearch
说明:  查询用户信息
参数:   无
返回值: 用户列表
*/
var orgSearch = function() {
	var sdata = { //构建查询需要的参数 
		//paramJson : toAnnouncementParamJosn()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search : true,
		userFilters:toUserParamJosn()
	// 将jqGrid的search选项设为true  
	}).trigger("reloadGrid", [ {
		page : 1
	} ]); //重新载入Grid表格，以使上述设置生效 
	 
}

//启动流程
function save(){
	var ids = "";
    var j = -1;
    var ids = jQuery("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
   
    jQuery("input[name=r1]").each(function(i,e){
		if(jQuery(this).is(":checked")){
			j = i;
		}
	})
    if(j == -1){
    	alert("请选择要回退的环节!")
    	return false;
    }
	var model = jQuery("#gridTable").jqGrid('getRowData',ids[j]);
	var pwindows = getParentWindow("windowIds");
	pwindows.setGwcsOrgInfo(model.org_id,model.org_name,model.org_addr);
	removeAlertWindows('windowIds',true);
}

//关闭
function closew(){
	removeAlertWindows('windowIds',true);
}
</script>
</head>
<body>

<button id="button1" class="but_y_01" onclick="save()">确定</button>
<button id="button2" class="but_y_01" onclick="closew()">关闭</button>
	<table width="100%">
		<tr>
		<td>
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
								<th width="90" class="input_cx_title_th" >名称：</th>
								<td width="296"  class="cx_title_td">
									<input class="input_cx_title_283" type="text" id="gwcs_orgname" name="gwcs_orgname"  /></td>
								<td width="385"  colspan="3"  >
								<input name="Input2" value="搜索" type="button" onclick="orgSearch()" class="but_y_01"/>
								</td>
							</tr>
						</table>
					</td></tr>
				</table>
		</td>
		</tr>
	</table>
<div id="vcenter"  >
		<div class="content_02_box">
			<table id="gridTable"></table>
		</div>
</div>

</body>
</html>