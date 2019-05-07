<%--
  Description：仪器设备标对记录表列表页面
  Author：AutoGenerator
  Version：1.0
  Date：Fri Apr 04 14:01:03 CST 2014
--%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
%>
<!DOCTYPE HTML>
<html>
<head>
<title>仪器设备标对记录表列表页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../../resources/js/util/public.js"></script>
<script type="text/javascript" src="../../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript">
$(function(){
	$(document).keydown(function(){
		if(event.keyCode == 13){
			objectSearch();
		}
	});
	
	$("#gridTable").jqGrid({
		//servletBean.xml示例配置，id请自行修改，配完请删除此注释！菜单配置请看页面最下面！
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.tjy.device.list.DevSubjectRecordList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		datatype: "json",
		mtype: "POST",
		height: "100%",
		autowidth: true,
		colModel: [ //最重要的数组之一，用于设定各列的参数
			{label:'主键ID',name: 'sub_id',index: 'sub_id',width: '100',hidden:true},
			{label:'设备编号',name: 'dev_code',index: 'dev_code',width: '100',hidden:false},
			{label:'设备名称',name: 'dev_name',index: 'dev_name',width: '100',hidden:false},
			{label:'标样名称',name: 'sub_name',index: 'sub_name',width: '100',hidden:false},
			{label:'标对结果',name: 'sub_result',index: 'sub_result',width: '100',hidden:false},
			{label:'标对时间',name: 'creator_time',index: 'creator_time',width: '100',hidden:false},
			{label:'备注',name: 'remark',index: 'remark',width: '100',hidden:false}
		],
		sortname: '',
		sortorder: 'desc',
		viewrecords: true,
		rowNum: 15,
		rowList: [10, 20, 30],
		gridComplete: function() {
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		search : toParamJosn(),
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			sort: "sidx",
			order: "sord",
			search : "search"
		},
		toolbar: [true,"top","<input class='but_y_01' id='add' type='button' onclick='openInfoPage()' value='新增'/>"+
							"<input class='but_y_01' id='delete' type='button' onclick='deleteData()' value='删除'/>"],
		multiselect: true,
		onCellSelect:function(rowid,iCol){
			if(iCol != 0){
				editItem(rowid);
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

var objectSearch = function() {
	var sdata = { //构建查询需要的参数 
		paramJson: toParamJosn()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable").jqGrid("getGridParam", "postData")
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search: true // 将jqGrid的search选项设为true  
	}).trigger("reloadGrid", [{
		page: 1
	}]); //重新载入Grid表格，以使上述设置生效 
}
function clearData(){	//重置搜索
	//设置重置表单
	//$("#name").val("");
	objectSearch();
 }
function toParamJosn(){
	var name = $("#name").val();
	var str = "{'name':'"+descape(name)+"'}";
	return escape(str);
}

function openInfoPage(){
    var tmp_subid = "devsubjectrecord_add";
    var url = "<%=path%>"+"/ccapp/xtbg/tjy/device/type/jsp/devsubjectrecordinfo.jsp?subid="+tmp_subid;
    openAlertWindows(tmp_subid,url,'新增仪器设备标对记录表',530,400,'15%','15%');
}
function editItem(rowid){
    var object = $("#gridTable").jqGrid('getRowData', rowid);
    var tmp_subid = "devsubjectrecord_update";
    var url = "<%=path%>"+"/ccapp/xtbg/tjy/device/type/jsp/devsubjectrecordinfo.jsp?subid="+tmp_subid+"&sub_id="+object.sub_id
    openAlertWindows(tmp_subid,url,'更新仪器设备标对记录表',530,400,'15%','15%');
}
function deleteData(){
	var ids = "";
	var tempArrs = [];
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	$(selectedIds).each(function(){
		var model = jQuery("#gridTable").jqGrid('getRowData', this);
		if(!IsSpace(model.sub_id)){
			tempArrs.push("'"+model.sub_id+"'")
		}
	})
	ids = tempArrs.join();
	if (IsSpace(ids)) {
		alert("请选择要删除的记录！");
	} else {
		var okF = function(){
			$.ajax({
				url:'devsubjectrecorddo.jsp',
				type:'post',dataType:'json',
				data:{"method":"delete","sub_id":ids},
				success:function(data){
					if(data.code.index == 0){
						alert("删除数据成功！");
						objectSearch();
					} else {
						alert("删除数据失败！errorCode["+data.code.index+"]");
					}
				}
			})
		}
		var p={
			headerText:'提示',
			okName:'确认',
			okFunction:okF,
			cancelName:'取消'
		};
		alert("确定要删除吗？",p);
	}
}
</script>
<body style="overflow-x:hidden;overflow-y:auto;">
<table width="100%" id="queryTable">
		<!--代码自动生成的时候条件搜索隐藏  可自行放开 去掉display:none-->
		<tr style='display:none;'>
			<td>
				<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
						<tr>
							<td>
								<!-- 固定查询 -->
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
									<tr>
										<th width="90" class="input_cx_title_th">标题：</th>
										<td width="296"  class="cx_title_td">
											<input class="input_cx_title_283 " type="text" id="unit_name"/>
										</td>
										<td>
											<input name="Input2" value="搜索" type="button"	onclick="objectSearch()" class="but_y_01"/>
											<input name="Input2" value="重置" type="button"	onclick="clearData()" class="but_y_01"/>
											<span id="selAreaImg" class="all_search_condition">
												<a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a>
											</span>
										</td>
									</tr>
								</table>
							</td>
						</tr>	
						<!-- 固定查询 end-->
						<tr>
							<td>
								<!-- 隐藏查询 -->
								<table width="70%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" id="hiddenArea" style="display:none">
									<tr>
										<th width="90" class="input_cx_title_th">标题：</th>
										<td width="296"  class="cx_title_td">
											<input class="input_cx_title_283 " type="text" id="name"/>
										</td>
										<th>&nbsp;</th>
										<td>&nbsp;</td>
									</tr>
								</table>
								<!-- 隐藏查询 end-->
							</td>
						</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<div class="cGridArea" >
					<table id="gridTable"></table>
					<div id="gridPager"></div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>
<!-- 菜单配置示例,菜单id请自行修改 配完请删此注释 module.xml 
<item datasource="bspf" default="false" id="auto_devsubjectrecordlist" isdelete="true" isedit="true" name="仪器设备标对记录表">
    <workspace>
        <toolbar />
        <content>/ccapp/xtbg/tjy/device/type/jsp/devsubjectrecordlist.jsp</content>
    </workspace>
</item>
-->
