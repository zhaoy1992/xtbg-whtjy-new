<%-- 
描述：机构用户查看详细页面
作者：黄艺平
版本：1.0
日期：2013-09-20
 --%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="org.apache.velocity.runtime.directive.Foreach"%>
<%@page import="com.frameworkset.common.poolman.PreparedDBUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	String n_notice_id = request.getParameter("n_notice_id");
	String n_receiveruser_orgid = request.getParameter("org_id");
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String sql="select org_name from td_sm_organization start with   org_id='"+n_receiveruser_orgid+"' connect by prior org_id=parent_id order by org_sn";
	PreparedDBUtil db=new PreparedDBUtil();
	db.preparedSelect(sql);
	db.executePrepared();
	String org_name="";
	for(int i=0;i<db.size();i++){
		org_name+="['"+db.getString(i,"org_name")+"','"+db.getString(i,"org_name")+"'],";
	}
	if(!StringUtil.isBlank(org_name)){
		org_name.substring(0,org_name.length()-1);
	}
	
%>
<title>机构用户查看详细页面</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<!-- 公共部分引用结束 -->
<!-- 当jqGrid列的字过多的时候显示...样式  -->

<script type="text/javascript">
$(function() {
	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.notice.list.NoticeReadDetail',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['用户', '用户id','联系电话', '查看情况','所属部门'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数

        {
	        label: '用户',
   			name: 'n_receiver_username',
   			index: 'n_receiver_username',
   			width: 40,
   			editable: true,
   			sortable: false
   		},
   		{
   			label: '用户id',
			name: 'n_receiver_userid',
			index: 'n_receiver_userid',
			hidden: true
		}, 
		{
			label: '联系电话',
   			name: 'user_mobiletel1',
   			index: 'user_mobiletel1',
   			width: 40,
   			editable: true,
   			sortable: false
   		},
		{
   			label: '查看情况',
			name: 'n_isview',
			index: 'n_isview',
			width: 20,
			editable: true,
			formatter:function(value){
				if('未查看' == value) {
					return "<strong><span style='color:red'>"+value+"</span></a></strong>"
				} else {
					return value;
				}
 			}
		}, 
		{
			label: '所属部门',
   			name: 'org_name',
   			index: 'org_name',
   			width: 40,
   			editable: true,
   			sortable: false
   		}
		
		],
		sortname: 'n_receiver_userid',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		
		filterNames:["org_name"],
		filterOptions:[[["--所属部门--","--所属部门--"],<%=org_name%>]],//alue text 后的值与显不
		filterOptionsDefValue:[0],
		
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
				if(model.n_isview == '未查看') {
					col = "<strong><span style='color:red'>"+model.n_isview+"</span></a></strong>";
				} else {
					col = model.state;
				}
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					state: col
				});
				
			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//pager: "#gridPager",
		//定义页码控制条Page Bar
		//caption: "备用列表",
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
		toolbar: [ true,"top","<input class='but_y_01' id=returnWin type='button' onclick='BackTo()' value='返回' />"],
		multiselect: false,
		ondblClickRow: function(id) {
			//editPerson(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search: false,
		refresh: false
	});
	
	


});

	 
/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var str = "{'n_receiveruser_orgid':'<%=n_receiveruser_orgid%>','n_notice_id':'<%=n_notice_id%>'}";
	return descape(escape(str));
}

var BackTo = function() {
	history.back();
}
</script>
</head>
<body>
<div><!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea">
<table id="gridTable"></table>
<div id="gridPager"></div>
</div>
<!-- 查询列表区 --></div>

</body>
</html>