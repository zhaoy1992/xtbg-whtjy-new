<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.security.AccessControl"%>
<html>
<%
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request,response);
	String path = request.getContextPath();
	
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>科技反腐首页</title>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js" charset="UTF-8"></script>
<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<style type="text/css">
	body{margin: 0;padding: 0;background: #fff;}
</style>
<script type="text/javascript">
	$(function(){
		$("#gridTable").jqGrid({
			url: '<%= path %>' + '/commonListServlet?classNameId=wc_landManagerList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
			colNames: ['土地ID','地块位置','乡镇、村','面积(亩)','办证情况','抵押情况','征拆情况','登记人id','登记人'],
			//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
			colModel: [ //最重要的数组之一，用于设定各列的参数
		        {
		        	name: 'land_id',index: 'land_id',width: '10',sortable:false,hidden:true
				},
				{
					name: 'land_location',index: 'land_location',width: '20',sortable:false
				},
				{
					name: 'lacation_village',index: 'lacation_village',width: '20',sortable:false
				},
				{
					name: 'area',index: 'area',width: '10',sortable:false
				},
				{
					name: 'certificate',index: 'certificate',width: '20',sortable:false
				},
				{
					name: 'pledge',index: 'pledge',width: '20',sortable:false
				},
				{
					name: 'remove',index: 'remove',	width: '20',editable: true
				},
				{
					name: 'user_id',index: 'user_id',width: '0',hidden:true
				},
				{
					name: 'userName',index: 'userName',width: '10'
				}
			],
			sortname: 'created',
			//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
			sortorder: 'desc',
			viewrecords: true,
			
			//设置是否在Pager Bar显示所有记录的总数。
			rowNum: 7,
			//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
			rowList: [10, 20, 30],
			//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
			gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
				// alert(idss);
				var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
				for (var i = 0; i < ids.length; i++) {
					var cl = ids[i];
					var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				}
			},
			jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
				repeatitems: false
			},
			//pager: "#gridPager",
			pagerintoolbar:true,//上面的分页条
			pagerinBottombar:false,//下面的分页条
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
			toolbar: [true,"top","(近三个月)项目动态"],
			multiselect: false,
			onCellSelect:function(rowid,iCol){
				if(iCol != 0){
					//editItem(rowid);
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
	/*
	函数:  objectSearch
	说明:  查询用户信息
	参数:   无
	返回值: 用户列表
	*/ 
	var objectSearch = function() {
		var sdata = { //构建查询需要的参数 
			paramJson: toParamJosn()
		}; //获得当前postData选项的值  
		var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		$.extend(postData, sdata);
		$("#gridTable").jqGrid("setGridParam", {
			search: true // 将jqGrid的search选项设为true  
		}).trigger("reloadGrid", [{
			page: 1
		}]); //重新载入Grid表格，以使上述设置生效 
	}
	
	function toParamJosn(){
		var str = "{'type':'1','state':'1'}";
		return escape(str);
	}
</script>
</head>
<body>
	<div id="kjff_wrap">
		<div id="kjff_top">
			<div id="kjff_left">
				<div class="kjff_left_content">
					<div class="kjff_title_wrap">
						<span class="kjff_title">待办事项（26）</span>
						<span class="kjff_title_more"><a href="###">更多>>></a></span>
					</div>
					<ul>
						<li>
							<span class="kjff_left_content_first">规划编制专项经费使用情况规划编制专项经费使用情况规划编制专项经费使用情况规划编制专项经费使用情况</span>
							<span class="kjff_left_content_second">2013-10-22</span>
						</li>
						<li>
							<span class="kjff_left_content_first">市政管线工程调查红线走廊</span>
							<span class="kjff_left_content_second">2013-10-22</span>
						</li>
						<li>
							<span class="kjff_left_content_first">建设用地规划许可证</span>
							<span class="kjff_left_content_second">2013-10-22</span>
						</li>
						<li>
							<span class="kjff_left_content_first">建设工程规划许可证</span>
							<span class="kjff_left_content_second">2013-10-22</span>
						</li>
						<li>
							<span class="kjff_left_content_first">建设工程规划许可证效果图</span>
							<span class="kjff_left_content_second">2013-10-22</span>
						</li>
					</ul>
				</div>
				<div class="kjff_left_content">
					<div class="kjff_title_wrap">
						<span class="kjff_title">已办事项（28）</span>
						<span class="kjff_title_more"><a href="###">更多>>></a></span>
					</div>
					<ul>
						<li>
							<span class="kjff_left_content_first">规划编制专项经费使用情况</span>
							<span class="kjff_left_content_second">2013-10-22</span>
						</li>
						<li>
							<span class="kjff_left_content_first">市政管线工程调查红线走廊</span>
							<span class="kjff_left_content_second">2013-10-22</span>
						</li>
						<li>
							<span class="kjff_left_content_first">建设用地规划许可证</span>
							<span class="kjff_left_content_second">2013-10-22</span>
						</li>
						<li>
							<span class="kjff_left_content_first">建设工程规划许可证</span>
							<span class="kjff_left_content_second">2013-10-22</span>
						</li>
						<li>
							<span class="kjff_left_content_first">建设工程规划许可证效果图</span>
							<span class="kjff_left_content_second">2013-10-22</span>
						</li>
					</ul>
				</div>
			</div>
			<div id="kjff_right">
				<div class="kjff_title_wrap">
					<span class="kjff_title">预警情况</span>
				</div>
				<div id="kjff_right_content">
					<div class="kjff_right_content_top">
						<span class="kjff_right_title">行政问责</span>
						<img src="../resources/images/fgx02.gif" style="border: none;">
					</div>
					<div class="kjff_rigt_content_show" id="img1"><a href="###">问责通报(0)</a></div>
					<div class="kjff_rigt_content_show" id="img2"><a href="###">监察建议书(0)</a></div>
					<div class="kjff_right_content_top">
						<span class="kjff_right_title">超时预警</span>
						<img src="../resources/images/fgx02.gif" style="border: none;">
					</div>
					<div class="kjff_rigt_content_show" id="img3"><a href="###">红色预警(0)</a></div>
					<div class="kjff_rigt_content_show" id="img4"><a href="###">橙色预警(0)</a></div>
					<div id="kjff_rigt_count">本月共产生预警0个，红色预警0个，橙色预警0个</div>
				</div>
			</div>
		</div>
		<div id="kjff_bottom">
			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
	</div>
</body>
</html>