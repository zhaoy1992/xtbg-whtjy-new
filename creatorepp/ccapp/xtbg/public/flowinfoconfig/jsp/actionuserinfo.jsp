<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.chinacreator.xtbg.pub.util.DaoUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String path = request.getContextPath();
	String actionid = request.getParameter("actionid");
	String theRootOrgid = DaoUtil.SqlToField("select org_id from td_sm_organization where parent_id='0'");
	String type = request.getParameter("type");
%>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script
	src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<link href="../../../resources/css/layer.css" rel="stylesheet" type="text/css" />
<link href="../../../resources/css/style.css" rel="stylesheet" type="text/css" />	
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>

<!-- 引入jQuery_dialog -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../../../resources/plug/jquery_dialog/jquery_dialog.css" />
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<link rel="stylesheet" href="../../../resources/plug/JQuery zTree v3.0/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../resources/js/tree.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>环节用户信息</title>
<script type="text/javascript">
$(function() {
	parent.temp='<%=type%>';
	$("#actusergridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=flowActUserList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['环节用户主键', '环节id', '用户 ID', '用户名称 ', '用户类型', '创建时间 '],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'wfactuser_id',
			index: 'wfactuser_id',
			hidden: true
		},
		{
			name: 'action_id',
			index: 'action_id',
			hidden: true
		},
		{
			name: 'user_id',
			index: 'user_id',
			width: 50,
			search: true
		},
		{
			name: 'user_name',
			index: 'user_name',
			search: true
		},
		{
			name: 'actuser_type',
			index: 'actuser_type',
			search: true
		},
		{
			name: 'create_time',
			index: 'create_time',
			hidden: true
		},
		],
		sortname: 'wfactuser_id',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: '',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 5,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			// alert(idss);
			/*var ids = $("#actusergridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				be = "<button id='modify' class='ui-button ui-button-text-only ui-widget ui-state-default ui-corner-all' onclick='startFlow("+cl+")'>" + 
				     "<span class='ui-button-text'>启用</span>" +
					 "</button> ";
				jQuery("#actusergridTable").jqGrid('setRowData', ids[i], {
					act: be
				});
			}*/
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#actusergridPager",
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控制条Page Bar
		//caption: "流程绑定",
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
		toolbar: [true,"top","<input class='but_y_01'onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=button2 type='button' onclick='chooseActUser()' value='添加用户'/><input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=button3 type='button' onclick='deleteActUser()' value='删除用户'/>"],
		multiselect: true,
		ondblClickRow: function(id) {
			
		}
	}).navGrid('#actusergridPager', {
		edit: false,
		add: false,
		del: false,
		search:false,
		refresh:false
	});
	$("#t_actusergridTable").append("<div>")
	.append("流程绑定")
	.append("</div>");
});




/*
函数:  toUserParamJosn
说明:  构建要查询的参数
参数:   无
返回值: 返回要查询的参数
*/
var toUserParamJosn = function() {
var str = "{'action_id':'<%=actionid%>'}";
return descape(str);
}

function refreshGrid(){
	var sdata = { //构建查询需要的参数 
			paramJson: toUserParamJosn()
		}; //获得当前postData选项的值  
		var postData = $("#actusergridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		$.extend(postData, sdata);
		$("#actusergridTable").jqGrid("setGridParam", {
			search: true // 将jqGrid的search选项设为true  
		}).trigger("reloadGrid", [{
			page: 1
		}]); //重新载入Grid表格，以使上述设置生效
}


function chooseActUser(){
	var ids = "";
	var sql = "select  WM_CONCAT(f.user_id) from TA_OA_FLOW_WFACTUSER f, td_sm_user u where action_id = '<%=actionid%>' and f.user_id = u.user_id order by wfactuser_id";
	//查询人员
	ids = _pub.ajax.SelectSqlAjax(sql);
	
		var typeFlag = parent.getParentWindow("").typetemp;
		if(typeFlag == 'flag')
		{
			 var s = new $.z_tree_leftRigth();
			  s.treeID='button_envelop_username';
			  s.isShowSeacher="aa";
			  s.treeName="选取人员";
			  s.headerName="选取人员";
			  s.titelText = "选择人员";
			  s.rightHeaderText="已添加机构和人员";
			  s.returnFunction=function(orgObj){
				  if (!IsSpace(orgObj)) {
						 var jsonparam = "{'action_id':'<%=actionid%>','user_id':'"+orgObj.ps.id+"',"+
							"'user_name':'"+orgObj.ps.user_name+"','actuser_type':'1'}";
						    var url = "saveactionuserform.jsp";
						    $("#jsonparam").val(descape(escape(jsonparam)));
						    document.all.form1.action = url;
						    document.all.form1.target = "hiddenFrame";
						    document.all.form1.submit();
						}
			  }
			  s.treeList=
					  [{
						  leftHeaderText:'按人员选择',
						  valueKey:'ps',
						  selectedIds:ids,
						  type:'{"type":"70"}'
				}];
			  s.init();

		}
		if(typeFlag =='flag1'){
			 var s = new $.z_tree_leftRigth();
			  s.treeID='button_envelop_username';
			  s.isShowSeacher="aa";
			  s.treeName="选取人员";
			  s.headerName="选取人员";
			  s.titelText = "选择人员";
			  s.rightHeaderText="已添加机构和人员";
			  s.returnFunction=function(orgObj){
				  if (!IsSpace(orgObj)) {
					  var jsonparam ="";
					   if(!IsSpace(orgObj.ps)){
						  	jsonparam = "{'action_id':'<%=actionid%>','user_id':'"+orgObj.ps.id+"',"+
							"'user_name':'"+orgObj.ps.user_name+"','actuser_type':'1'}";
					  	} else {
					  		jsonparam = "{'action_id':'<%=actionid%>','user_id':'',"+
							"'user_name':'','actuser_type':'1'}";
					  	}
						  var url = "saveactionuserform.jsp";
						    $("#jsonparam").val(descape(escape(jsonparam)));
						    document.all.form1.action = url;
						    document.all.form1.target = "hiddenFrame";
						    document.all.form1.submit();
					}
			  }
			  s.treeList=
					  [{
						  leftHeaderText:'按人员选择',
						  valueKey:'ps',
						  selectedIds:ids,
						  type:"APERSON"
				}];
			  s.init();
		}
}

function deleteActUser(){
	var ids = "";
	var selectedIds = $("#actusergridTable").jqGrid("getGridParam", "selarrrow");
	for(var i = 0; i < selectedIds.length; i++) {
		var model = jQuery("#actusergridTable").jqGrid('getRowData', selectedIds[i]);
		 if("" != ids){			   
			ids += ",";
		 }
		 ids += "'"+model.wfactuser_id+"'";
		 
	}
	if (IsSpace(ids)) {
		alert("请选择要删除的记录！");
	} else {
		
		var okF = function(){
		var url = "deleteactionuserform.jsp";
		$("#userids").val(ids);
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
	alert("确定要刪除用戶吗？",p)
	}
	
}
--></script>
</head>
<body>
<!--<TABLE>-->
<!--    <TR   class=qFunButton1>-->
<!--       <TD>-->
<!--       <BUTTON   id=button2   class="but_y_01" onclick='chooseActUser()'>添加用户</BUTTON>-->
<!--       <BUTTON   id=button3   class="but_y_01" onclick='deleteActUser()'>删除用户</BUTTON>-->
<!--       </TD>-->
<!--    </TR>-->
<!--    <tr>-->
<!--    	<td>-->
    			<!-- 查询列表区 cGridArea(查询区样式)-->
				<div class="cGridArea">
					<table id="actusergridTable"></table>
					<div id="actusergridPager"></div>
				</div>
				<!-- 查询列表区 -->
<!--    	</td>-->
<!--    </tr>                             -->
<!--</TABLE>-->

<form id="form1" name="form1" method="post" >
<input id="jsonparam" name="jsonparam" type="hidden"></input>
<input id="actionid" name="actionid" value="<%=actionid %>" type="hidden"></input>
<input id="userids" name="userids" value="" type="hidden"></input>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>