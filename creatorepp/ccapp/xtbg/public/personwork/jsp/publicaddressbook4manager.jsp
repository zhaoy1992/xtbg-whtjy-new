<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String userid = accesscontroler.getUserID();
String orgid = StringUtil.nullOrBlank(request.getParameter("orgid"))?accesscontroler.getChargeOrgId(): StringUtil.deNull(request.getParameter("orgid"));

PersonInfoDao personInfodao = (PersonInfoDao)DaoImplClassUtil.getDaoImplClass("personInfoDaoImpl");

List<ListShowUtilBean> firstCodeList = personInfodao.getFirstCodeShowInfo(orgid,"public");

String getGroupSelectHtml = personInfodao.getGroupSelectHtml(userid);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.dao.PersonInfoDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.entity.ListShowUtilBean"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>个人通讯录</title>
<link rel="stylesheet" type="text/css" media="screen"
	href="../resources/css/testcss.css" />
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
<script type="text/javascript">

var nameindex = "";//拼音首字母
(function( $ ) {
	$.widget( "ui.combobox", {
		_create: function() {
			var self = this,
				select = this.element.hide(),
				selected = select.children( ":selected" ),
				value = selected.val() ? selected.text() : "";
			var input = this.input = $( "<input>" )
				.insertAfter( select )
				.val( value )
				.autocomplete({
					delay: 0,
					minLength: 0,
					source: function( request, response ) {
						var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
						response( select.children( "option" ).map(function() {
							var text = $( this ).text();
							if ( this.value && ( !request.term || matcher.test(text) ) )
								return {
									label: text.replace(
										new RegExp(
											"(?![^&;]+;)(?!<[^<>]*)(" +
											$.ui.autocomplete.escapeRegex(request.term) +
											")(?![^<>]*>)(?![^&;]+;)", "gi"
										), "<strong>$1</strong>" ),
									value: text,
									option: this
								};
						}) );
					},
					select: function( event, ui ) {
						ui.item.option.selected = true;
						self._trigger( "selected", event, {
							item: ui.item.option
						});
					},
					change: function( event, ui ) {
						if ( !ui.item ) {
							var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
								valid = false;
							select.children( "option" ).each(function() {
								if ( $( this ).text().match( matcher ) ) {
									this.selected = valid = true;
									return false;
								}
							});
							if ( !valid ) {
								// remove invalid value, as it didn't match anything
								$( this ).val( "" );
								select.val( "" );
								input.data( "autocomplete" ).term = "";
								return false;
							}
						}
					}
				})
				.addClass( "ui-widget ui-widget-content ui-corner-left" );

			input.data( "autocomplete" )._renderItem = function( ul, item ) {
				var ischeck = "";
				var groupshowids = $('#groupshowids').val();
				var idsArry = groupshowids.split(",");
				$(idsArry).each(function(n,value){
					if(value == item.option.value){
						ischeck = "checked='checked'";
						return;
					}	
				});
				
				var inputhtml =  $( "<li></li>" )
					.data( "item.autocomplete", item )
					.append( "<input type='checkbox'  name='group' onclick='onclickcheckbox()' id='" + item.option.value + "' " + ischeck + " value='" + item.option.text + "'/>" + item.label + "")
					.appendTo( ul );
				 return inputhtml;
			};

			this.button = $( "<button type='button'>&nbsp;</button>" )
				.attr( "tabIndex", -1 )
				.attr( "title", "Show All Items" )
				.insertAfter( input )
				.button({
					icons: {
						primary: "ui-icon-triangle-1-s"
					},
					text: false
				})
				.removeClass( "分组展示" )
				.addClass( "ui-corner-right ui-button-icon" )
				.click(function() {
					// close if already visible
					if(!getselectGroupinfo()){
						return;
					}					
					if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
						input.autocomplete( "close" );
						return;
					}

					// work around a bug (likely same cause as #5265)
					$( this ).blur();

					// pass empty string as value to search for, displaying all results
					input.autocomplete( "search", "" );
					input.focus();
				});
		},

		destroy: function() {
			this.input.remove();
			this.button.remove();
			this.element.show();
			$.Widget.prototype.destroy.call( this );
		}
	});
})( jQuery );

$(function() {
	$("#filters a").click(function (event){
		nameindex =  ($(event.target).html() == "全部")?"":$(event.target).html();
		personSearch();
	})
	$("#btn_Search").bind('click', searchByLikename);
	
	
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=publicAddressBook4ManagerList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['人员id', '姓名' , '常用手机', '办公电话', '家庭电话' ,'电子邮箱' ,'所在单位'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
			colModel: [ //最重要的数组之一，用于设定各列的参数
        {
			name: 'person_id',
			index: 'person_id',
			hidden: true
		},
		{
			name: 'name',
			index: 'name',
			width: 80,
			editable: true
		},
		{
			name: 'commonlymobile',
			index: 'commonlymobile',
			width: 100,
			editable: true
		},
		{
			name: 'officphone',
			index: 'officphone',
			width: 100,
			editable: true
		},
		{
			name: 'homephone',
			index: 'homephone',
			width: 100,
			editable: true
		},
		{
			name: 'email',
			index: 'email',
			width: 80,
			editable: true
		},
		{
			name: 'org_name',
			index: 'org_name',
			width: 80,
			editable: true
		}
		],
		sortname: 'person_id',
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

			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pager: "#gridPager",
		//定义页码控制条Page Bar
		//caption: "公共通讯录",
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
		multiselect: true,
		ondblClickRow: function(id) {
			editPerson(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search: false,
		refresh: false
	});
	
	
	$("#t_gridTable").append("<div>")
	.append("<input type='button' class='addlm' onclick='addPerson()' />")
	.append("<input type='button' class='dellm' onclick='deletePerson()' />")
	.append("<input type='button' class='confp' onclick='configRole()' />")
	.append("</div>");


	/*
	$("#addin").button({
        icons: {
            primary: "ui-icon-plus"
        }
     });*/
	
	$("#userReName").datepicker({
		showOn: "button",
		buttonImage: "../../../resources/plug/jquery-ui-1.8.17.custom/development-bundle/demos/images/calendar.gif",
		buttonImageOnly: true,
		dateFormat:"yy-mm-dd"
	});
	//.setDefaults($.datepicker.regional['zh-CN']);
	//$("#datepicker" ).datepicker( "yyyy-mm-dd", "dateFormat", $(this).val() );
	//$("input:submit, a, button", ".demo" ).button();
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


	 $(function() {
			$( "#combobox" ).combobox();
			$( "#toggle" ).click(function() {
				$( "#combobox" ).toggle();
			});
	 });
	 
/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var str = "{'orgid':'<%=orgid%>','likevalue':'" + $('#searchInput').val() + "','nameindex':'" + nameindex + "'}";
	return descape(str);
}

var addPerson = function() {
	var url = "publicpersondetailinfo.jsp?org_id=<%=orgid%>";
	JqueryDialog.Open1('新增人员', url, 800, 500, false, false, false, true);
	JqueryDialog.BeforeCloseFunction = refreshGrid4WfactionInfo;
	//location.href = url;
}



/*
函数:  personSearch
说明:  查询用户信息
参数:   无
返回值: 用户列表
*/
var personSearch = function() {
	
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


var searchByLikename = function() {
	personSearch();
}



var refreshGrid4WfactionInfo = function() {
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




var deletePerson = function() {
	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	var tempArrs = [];
	$(selectedIds).each(function(){
		var model = jQuery("#gridTable").jqGrid('getRowData', this);
		if(!IsSpace(model.person_id))
		tempArrs.push(model.person_id);
	})
	ids = tempArrs.join();
	
	if (IsSpace(ids)) {
		alert("请选择要删除的记录！");
	} else {
		if (!confirm("确定要删除人员信息吗？")) {
			return;
		}
		var url = "deletepersoninfoform.jsp";
		$("#personids").val(ids);
		document.all.form1.action = url;
		document.all.form1.target = "hiddenFrame";
		document.all.form1.submit();
	}
}

var editPerson = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var url = "publicpersondetailinfo.jsp?person_id="+model.person_id;
	JqueryDialog.Open1('修改人员', url, 800, 500, false, false, false, true);
	JqueryDialog.BeforeCloseFunction = refreshGrid4WfactionInfo;
	//location.href = url;
}

var configRole = function() {
	var url = "priManage.jsp";
	JqueryDialog.Open1('配置人员权限', url, 800, 600, false, false, true);
	JqueryDialog.BeforeCloseFunction = refreshGrid4WfactionInfo;
		
}

function exportCsv() {
	alert("正在导出为CSV文件......请稍等");
}

var getCheckBoxValue = function() {
	/*得到所选择的值*/
	var str = "";
	$("[.jqgrow td input][checked]").each(function() {
		str += $(this).val() + ",";
	});
}

</script>
</head>
<body>
<!-- 栏目+快速搜索 -->
	<table class="ColumnTableArea">
      <tr>
        <td class="Columnbg">公共通讯录(管理者)</td>
        <td>&nbsp;</td>
        <td ></td>
      </tr>
    </table>
<!-- 查询列表区 cGridArea(查询区样式)-->
<div class="btn-bar">
<div class="ffilters logClass" id="filters" >
<span style="width:100px; color:#000">首字母查询：</span>
	<a style="width:30px;" href="javascript:void(0)">全部</a>
		<%for(ListShowUtilBean showBean:firstCodeList){ 
		if(showBean.isExsit){%>
		<a style="width:20px;" href="javascript:void(0)"><%=showBean.getFirstCode() %></a>
	<%}else{ %>
		<span style='width: 20px;'><%=showBean.getFirstCode() %></span>
	<%}} %>


	<input name="search"  id="searchInput" type="text" value=""/>
	<input name="btn_Search" id="btn_Search" class="icon-search-btn" type="button"/>

</div>
</div>

	<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
	</div>
	<!-- 查询列表区 -->
<form id="form1" name="form1" method="post" >
<input id="personids" name="personids" value="" type="hidden"></input>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>