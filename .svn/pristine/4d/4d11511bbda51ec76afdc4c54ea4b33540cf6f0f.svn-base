
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String userId = accesscontroler.getUserID();
//当前用户的机构id和机构名


String orgId = "";
String userOrgName = "";
String deptCode = "";
//教育考试院真的当前用户机构 
if(CacheCommonManageProxy.getBooleanSystemParam("gwcs_ReceiveOrg")){
	deptCode = accesscontroler.getChargeOrgId();
}

String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>外部发文查询</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"
	href="../../jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script
	src="../../jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>
<script type="text/javascript" src="../../jquery-ui-1.8.17.custom/development-bundle/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>

<script
	src="../../My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript"></script>
<script src="../../jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>

<!-- 引入jQuery_dialog -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../jquery_dialog/jquery_dialog.css" />
<script src="../../jquery_dialog/jquery_dialog.js"></script>

<!-- 引入其它 -->
<script src="../../../js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>

<script type="text/javascript">
$(function() {
	//tab2
		$("#gridTable").jqGrid({
			url: '<%= path %>' + '/commonListServlet?classNameId=receiveGwcsList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
			//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
			datatype: "json",
			//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
			mtype: "POST",
			//定义使用哪种方法发起请求，GET或者POST
			height: "100%",//270
			//Grid的高度，可以接受数字、%值、auto，默认值为150
			//width ："1800", //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
			//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
			//autowidth: true,
			width: "1000",
			//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
			colNames: ['公文传输ID', '收文日期 ', '公文标题', '公文密级', '主题词', '来文单位', '是否已签收', '操作' ],
			//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
			colModel: [ //最重要的数组之一，用于设定各列的参数
			{
				name: 'gwreceive_id',
				index: 'gwreceive_id',
				hidden: true
			},
			{
				name: 'create_date',
				index: 'create_date',
				width: 90,
				search: true
			},
			{
				name: 'title',
				index: 'title',
				width: 90,
				search: true
			},
			{
				name: 'secrecy_grade',
				index: 'secrecy_grade',
				width: 90,
				search: true
			},
			{
				name: 'caption',
				index: 'caption',
				width: 90,
				search: true
			},
			{
				name: 'send_org_name',
				index: 'send_org_name',
				width: 90,
				search: true
			},
			{
				name: 'is_accept',
				index: 'is_accept',
				width: 90,
				search: true
			},
			{
				name: 'act',
				index: 'act',
				width: 90,
				search: true,
				sortable: false
			}
			],
			sortname: 'create_date',
			//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
			sortorder: 'desc',
			viewrecords: true,
			
			//设置是否在Pager Bar显示所有记录的总数。
			rowNum: 10,
			//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
			rowList: [10, 20, 30],
			//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
			gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
				// alert(idss);
				
				var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
				for (var i = 0; i < ids.length; i++) {
					var cl = ids[i];
					var model = jQuery("#gridTable").jqGrid('getRowData', cl);
					be = "<input type='button' class='but_y_01' value='签收' onclick=useTheGwcsInfo('"+model.gwreceive_id+"')>";
					jQuery("#gridTable").jqGrid('setRowData', ids[i], {
						act: be
					});
				}
			},
			jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
				repeatitems: false
			},
			//pager: "#gridPager",
			pagerintoolbar:true,//上面的分页条
			pagerinBottombar:true,//下面的分页条
			//定义页码控制条Page Bar
			//caption: "来文缓急维护",
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
			toolbar: [true,"top"],
			multiselect: false,
			ondblClickRow: function(id) {
				//updateLevel(id);
			}
		}).navGrid('#gridPager', {
			edit: false,
			add: false,
			del: false,
			refresh: false,
			search: false
		});
		$("#t_gridTable").append("<div>")

			.append("</div>");

	});

		 
	/*
		 函数:  toUserParamJosn
		 说明:  构建要查询的参数
		 参数:   无
		 返回值: 返回要查询的参数
		 */
	var toUserParamJosn = function() {
		var str = "{'title':'" + $("#title").val() + "','secrecy_grade':'" + $("#secrecy_grade").val() + "',"+
					"'caption':'" + $("#caption").val() + "','receive_starttime':'" + $("#receive_starttime").val() + "',"+
					"'receive_endtime':'" + $("#receive_endtime").val() + "','recv_org_name':'" + $("#recv_org_name").val() + "','deptCode':'"+'<%=deptCode %>'+"'}";
		return descape(escape(str));
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
		var sdata = { //构建查询需要的参数 
				paramJson: "{}"
			}; //获得当前postData选项的值  
			var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
			$.extend(postData, sdata);
			$("#gridTable").jqGrid("setGridParam", {
				search: true // 将jqGrid的search选项设为true  
			}).trigger("reloadGrid", [{
				page: 1
			}]); //重新载入Grid表格，以使上述设置生效 
		resetSingleSearchDialog();
	};


	/*
	函数:  resetSingleSearchDialog
	说明:  清空值查询值
	参数:   无
	返回值: 无
	*/
	var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
	$(":text", "#queryTable").val("");
	$("select", "#queryTable").val("");
	$(":hidden", "#queryTable").val("");
	};

	/*
		 函数:  updateLevel
		 说明:  修改缓急程度
		 参数:   无
		 返回值: 无
		 */
	var updateLevel = function(id) {
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
		JqueryDialog.Open('修改缓急程度', 'addorupdatereceivelevel.jsp?hjid=' + model.hjid, 300, 105, true, true, true);
	}


	function useTheGwcsInfo(gwcs_id){
		var returnObj = new Object();
		returnObj.gwreceive_id = gwcs_id;
		window.returnValue = returnObj;
		window.close();
	}

	var getCheckBoxValue = function() {
		/*得到所选择的值*/
		var str = "";
		$("[.jqgrow td input][checked]").each(function() {
			str += $(this).val() + ",";
		});
	}

	window.onload = function () {
		setDataTimeClickShowOrHide('receive_starttime',window);
		setDataTimeClickShowOrHide('receive_endtime',window);
	  }
	</script>
	</head>
	<body>

	<!-- 查询列表区 cGridArea(查询区样式)-->
	<!-- 栏目+快速搜索 -->
		<table class="ColumnTableArea">
	      <tr>
	        <td class="Columnbg">&nbsp;公文传输查询</td>
	        <td>&nbsp;</td>
	        <td ></td>
	      </tr>
	    </table>
	<!--<div  class="content_02" style="overflow:hidden;" >-->
	<!--<div id="vcenter" style="float:left; width:100%; overflow:scroll;overflow-x:hidden;" scrolling="yes">-->
	<!--<div style="float: left; width: 775px; "> -->
	<!--<div class="content_02_box" >-->
	<!--<div class="content_02_box_title_bg"><span>基本信息</span></div>-->
	<!--<div class="content_02_box_div">-->
	<!--</div>-->
	<!--</div>-->
	<!--</div>-->
	<!--</div>-->
	<!--</div>-->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" id="queryTable" style="border: 1px solid #ccc;width:98%; margin-bottom: 10px;" align="center">
			<tr>
					<th class="content_02_box_div_table_th">
						来文标题：
					</th>
					<td class="content_02_box_div_table_td">
						<input class="input_185" id="title" name="title" type="text" />
					</td>
					<th class="content_02_box_div_table_th">密级：</th>
					<td class="content_02_box_div_table_td">
					<select id="secrecy_grade" name="secrecy_grade" style="width: 130px;">
					<option value="">--请选择--</option>
					<option value="无">无</option>
					<option value="机密">机密</option>
					<option value="绝密">绝密</option>
					</select>
					</td>
					 <th class="content_02_box_div_table_th">主题词：</th>
					 <td class="content_02_box_div_table_td" width="24%"><input class="input_185" id="caption" name="caption" type="text" /></td>
				</tr>
				<tr>
					<td class="content_02_box_div_table_th">
						收文开始日期：
					</td>
					<td class="content_02_box_div_table_td">
						<input class="date_120 Wdate" id="receive_starttime" name="receive_starttime" type="text" onclick="WdatePicker()" />
					</td>
					<th class="content_02_box_div_table_th">收文结束日期：</th>
					<td class="content_02_box_div_table_td">
						<input class="date_120 Wdate" id="receive_endtime" name="receive_endtime" type="text" onclick="WdatePicker()" />
					</td>
					 <th class="content_02_box_div_table_th">来文单位：</th>
					 <td class="content_02_box_div_table_td"><input class="input_185" id="recv_org_name" name="recv_org_name" type="text" /></td>
				</tr>
				
					
					<!-- 查询功能区 cQueryFunArea(查询区样式), cButton(按钮样式)-->
					<tr class="cQueryFunArea" height="40">
						<td colspan="6">
							<input class="but_y_01" type="button" id="sel"  value="查询" onclick="userSearch()" />
							<input class="but_y_01" type="button" id="resert" value="重置" onclick="clearSearch()" />
						</td>
					</tr>
					<!-- 查询功能区 -->
				</table>
			<!-- 查询列表区 cGridArea(查询区样式)-->
			<div class="cGridArea">
			<table id="gridTable"></table>
			<div id="gridPager"></div>
			</div>
			<!-- 查询列表区 -->



	<iframe name="hiddenFrame2" width=0 height=0></iframe>
	</body>
	</html>