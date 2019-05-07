<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String userName = accesscontroler.getUserAccount();
	String userid = accesscontroler.getUserID();
%>
<title>JGRID</title>
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
<!-- 当jqGrid列的字过多的时候显示...样式  -->

<script type="text/javascript">
$(function() {
	gridTableObj = $("#gridTable");			//gridtable对象;
	gridPagerObj = $("#gridPager");			//gridpager对象;
	t_gridTableObj = "#queryTable" ;			//t_gridtable对象;	
	queryTableString = $("#gridTable"); 	//queryTable字串
	jQuery_gridTableObj = $("#gridTable");
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			announcementSearch();
		}
	});

	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.archive.list.CircularizeList',//pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['文件标题', '传阅发送时间 ', '传送者','查看状态','查看率','action_form','busi_id','ins_id','circularize_id','send_userid','业务类型','模板ID','未阅读人数','已阅读人数'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'circularize_title',
			index: 'circularize_title'
			//hidden: true
		},
		{
			name: 'entering_date',
			index: 'entering_date',
			width: 100,
			editable: true
			//hidden: true
		},
		{
			name: 'user_realname',
			index: 'user_realname',
			width: 80,
			sortable: true
			
		},
		{
			name: 'is_view',
			index: 'is_view',
			width: 50,
			sortable: true
			
		},
		{
			name: 'viewrate',
			index: 'viewrate',
			width: 60,
			sortable: false
		},
		{
			name: 'action_form',
			index: 'action_form',
			hidden: true
		},
		{
			name: 'busi_id',
			index: 'busi_id',
			width: 60,
			search: true,
			hidden:true
		},
	
		{
			name: 'ins_id',
			index: 'ins_id',
			width: 50,
			hidden:true
		},
		{
			name: 'circularize_id',
			index: 'circularize_id',
			width: 60,
			hidden:true
		},
		
		{
			name: 'send_userid',
			index: 'send_userid',
			width: 60,
			hidden:true
		},
		{
  			name: 'busitype_code',
  			index: 'busitype_code',
  			hidden: true
   		}, 	
   		{
	   		name: 'template_id',
   			index: 'template_id',
   			hidden: true
	   	}, 	
   		{
	   		name: 'notreadNum',
   			index: 'notreadNum',
   			hidden: true
	   	}, 	
   		{
	   		name: 'readNum',
   			index: 'readNum',
   			hidden: true
	   	}
		],
		sortname: 'entering_date',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
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
				be = "<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); type='button'  value='查看' onmousedown='doview("+cl+")'>";
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					viewrate: be
				});
			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "电子公告管理",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toAnnouncementParamJosn(),
		
	
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
		onSelectRow : function(id) {
			lookcircularize(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		refresh: false,
		search: false
	});

	
});


//查看率
var doview = function(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var readNum = model.readNum;
	var notreadNum = model.notreadNum;
	openAlertWindows('windowId',getCurrentFilePath()+'circulshowtab.jsp?ins_id='+ model.ins_id,'查看情况            已查看人数：<span style="color:red">'+readNum +'</span>' +'     未查看人数：<span style="color:red">'+notreadNum+'</span>','60%','450','20%');
	
}
/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toAnnouncementParamJosn = function() {
	var str = "{'circularize_title':'" + $("#circularize_title").val() + "','start_time':'" + $("#start_time").val()
				+ "','orgid':'" + $("#orgid").val() + "','end_time':'" + $("#end_time").val() + "','receive_userid':'"+<%=accesscontroler.getUserID()%>+ "','username':'<%=accesscontroler.getUserName()%>'}";
		return descape(escape(str));
	}

	/*
	 函数:  userSearch
	 说明:  查询用户信息
	 参数:   无
	 返回值: 用户列表
	 */
	var announcementSearch = function() {
		
		var sdata = { //构建查询需要的参数 
			//paramJson : toAnnouncementParamJosn()
		}; //获得当前postData选项的值  
		var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		$.extend(postData, sdata);
		$("#gridTable").jqGrid("setGridParam", {
			search : true,
			userFilters:toAnnouncementParamJosn()
		// 将jqGrid的search选项设为true  
		}).trigger("reloadGrid", [ {
			page : 1
		} ]); //重新载入Grid表格，以使上述设置生效 
		 
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
			paramJson : toAnnouncementParamJosn()
		};
		var postData = $("#gridTable").jqGrid("getGridParam", "postData");
		$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
		$("#gridTable").jqGrid("setGridParam", {
			search : true
		// 将jqGrid的search选项设为false  
		}).trigger("reloadGrid", [ {
			page : 1
		} ]);
	};

	/*
	 函数:  resetSingleSearchDialog
	 说明:  清空值查询值
	 参数:   无
	 返回值: 无
	 */
	var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
		$(":text", "#queryTable").val("");
		$('#state option:first').attr('selected', 'selected');

	};

	//查看
	var lookcircularize = function(id) {
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
		//特检院OA 2014-06-05  传阅性公文查看只查看正文内容和附件的问题 
		var busitype_code = model.busitype_code;
		var title = "";
		//签呈流程只显示稿纸
		var url = "";
		if(busitype_code=="uuid-1103"){
			url = '<%=path %>' + model.action_form + "?ins_id="+model.ins_id+"&busi_id="+model.busi_id+"&list_type=worklis&operType=yiban&act_name="+model.act_name+"&actiontype_code=04&busiTypeCode="+model.busitype_code
			  +"&template_id="+model.template_id+"&Template=word"+model.template_id+"&circularize_id="+model.circularize_id;
			title = "签呈";
		} else if(busitype_code=="uuid-1106"){
			url = '<%=path %>' + model.action_form + "?ins_id="+model.ins_id+"&busi_id="+model.busi_id+"&list_type=worklis&operType=yiban&act_name="+model.act_name+"&actiontype_code=04&busiTypeCode="+model.busitype_code
			  +"&template_id="+model.template_id+"&Template=word"+model.template_id+"&circularize_id="+model.circularize_id+"&circutype=circutype";
			title = "收文";
		}
		else {
			url = '<%=path %>' + "/ccapp/oa/archive/showWordConext.jsp?ins_id="+model.ins_id+"&busi_id="+model.busi_id+"&list_type=worklis&operType=yiban&act_name="+model.act_name+"&actiontype_code=04&busiTypeCode="+model.busitype_code
			  +"&template_id="+model.template_id+"&Template=word"+model.template_id+"&circularize_id="+model.circularize_id;
			title = model.circularize_title;
		}
		var width = jQuery(window.top).width();//界面宽度
	    var height = jQuery(window.top).height();//界面高度
		url= url+"&height="+height+"&width="+width;
		url= url+"&windowsId=newwindows"
		openAlertWindows('newwindows',url,title,width,height-86,86,'0%','','',true);
	}


</script>
</head>
<body>
<div>
	

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
								<th width="90" class="input_cx_title_th" >标题：</th>
						<td width="296"  class="cx_title_td">
							<input class="input_cx_title_283" type="text" id="circularize_title" name="circularize_title" /></td>
						<td width="385"  colspan="3"  >
						<input name="Input2" value="搜索" type="button" onclick="announcementSearch()" class="but_y_01"/></td>
									</tr>
								</table>
								</td></tr>
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
</div>	
	<form id="delForm" name="delForm" method="post" action="announcementdrewdo.jsp">
		<input type="hidden" name="userIds" id="userIds" />
		<input type="hidden" name="action" value="del" />
	</form>	
	<form id="delDateFrom" name="delDateFrom" method="post" action="announcementdrewdo.jsp">
		<input type="hidden" name="delIds" id="delIds" />
		<input type="hidden" name="action" value="delDate" />
	</form>	
	<form id="qxfbForm" name="qxfbForm" method="post" action="announcementdrewdo.jsp">
		<input type="hidden" name="qxids" id="qxids" />
		<input type="hidden" name="action" value="qxfb" />
		
	</form>	
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>