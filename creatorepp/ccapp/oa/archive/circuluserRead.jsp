<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.chinacreator.security.AccessControl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	String ins_id = request.getParameter("ins_id");
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	//当前用户id
	String userId = accesscontroler.getUserID();
	//当前用户英文名
	String userName = accesscontroler.getUserAccount();
	//当前用户名字
	String userRealName = accesscontroler.getUserName();
%>
<meta http-equiv="Content-Type" content="text/html;">
<title>已阅读单位情况查看</title>
<!-- 公共部分开始 -->
<!-- 引入jQuery -->
<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->

<script type="text/javascript">
var userid = "<%=userId%>";

$(function() {
	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.archive.list.CirculUserReadList', //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
					//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
					datatype : "json",
					//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
					mtype : "POST",
					//定义使用哪种方法发起请求，GET或者POST
					height : "100%",//270
					//Grid的高度，可以接受数字、%值、auto，默认值为150
					//width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
					//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
					autowidth : true,
					//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
					colNames : ['机构名称', '联系人','联系电话'],
					//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
					colModel : [ //最重要的数组之一，用于设定各列的参数
					{
						name : 'org_name',
						index : 'org_name',
						width : '220',
						editable : true
					}, {
						name : 'user_realname',
						index : 'user_realname',
						width : 230,
						search : true
					}, {
						name : 'phone',
						index : 'phone',
						width : 230,
						search : true
					}
					],
					sortname : 'org_name desc,circularize_id',
					//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
					sortorder : 'desc',
					viewrecords : true,

					//设置是否在Pager Bar显示所有记录的总数。
					rowNum: 10,
					//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
					rowList: [10, 20, 30],
					//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
					gridComplete : function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
						// alert(idss);
						var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
						for ( var i = 0; i < ids.length; i++) {
							var cl = ids[i];
						}
					},
					jsonReader : { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
						repeatitems : false
					},
					//设置Grid表格的标题，如果未设置，则标题区域不显示。
					search : toUserParamJosn(),
					//pager: "#gridPager",
					pagerintoolbar:true,//上面的分页条
					pagerinBottombar:true,//下面的分页条
					prmNames : { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
						rows : "rows",
						//表示请求行数的参数名称  
						sort : "sidx",
						//表示用于排序的列名的参数名称  
						order : "sord",
						//表示采用的排序方式的参数名称 
						search : "search"
					},
					toolbar : [ true, "top",""],
					//
					multiselect : false
				}).navGrid('#gridPager', {
			edit : false,
			add : false,
			del : false
			});
	
		
	
	//返回
	$("#return").click(function() {
		parent.JqueryDialog.Close();
	});
	});
	/*
	 colModel的重要选项

	 和jqGrid一样colModel也有许多非常重要的选项，在使用搜索、排序等方面都会用到。这里先只说说最基本的。

	 name ：为Grid中的每个列设置唯一的名称，这是一个必需选项，其中保留字包括subgrid、cb、rn。
	 index ：设置排序时所使用的索引名称，这个index名称会作为sidx参数（prmNames中设置的）传递到Server。
	 label ：当jqGrid的colNames选项数组为空时，为各列指定题头。如果colNames和此项都为空时，则name选项值会成为题头。
	 width ：设置列的宽度，目前只能接受以px为单位的数值，默认为150。
	 sortable ：设置该列是否可以排序，默认为true。
	 search ：设置该列是否可以被列为搜索条件，默认为true。
	 resizable ：设置列是否可以变更尺寸，默认为true。
	 hidden ：设置此列初始化时是否为隐藏状态，默认为false。
	 formatter ：预设类型或用来格式化该列的自定义函数名。常用预设格式有：integer、date、currency、number等
	
	 资料:http://www.trirand.com/jqgridwiki/doku.php?id=wiki:common_rules
	 */

	/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
	var toUserParamJosn = function() {
		 var str = "{'ins_id':'<%=ins_id%>',"+"'loginUserid':'"+<%=userId%>  +"','is_view':'1'}";
		return descape(str);
	}

</script>
<!-- 公共部分结束 -->
<script type="text/javascript">
     window.onload = function () {
     	adaptationWH("content_02_top","vcenter",395,true);
     } 
 </script>
</head>
<body>
	<div class="cGridArea" id="vcenter">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
	</div>

<iframe name="hiddenageFrame" width=0 height=0></iframe>
<iframe name="hiddenFrame" width=0 height=0></iframe>	
<iframe name="hiddenFrame2" width=0 height=0></iframe>
</body>
</html>