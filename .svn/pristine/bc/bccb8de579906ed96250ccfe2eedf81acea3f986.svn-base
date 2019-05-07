<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String userid = accesscontroler.getUserID();
	
	PersonInfoDao personInfodao = (PersonInfoDao)DaoImplClassUtil.getDaoImplClass("personInfoDaoImpl");
	PriManageDao priManageDao = (PriManageDao)DaoImplClassUtil.getDaoImplClass("priManageDaoImpl");
	
	PGroupBean pbGroupBean = new PGroupBean();
	pbGroupBean.setLoginUserID(userid);
	List<PGroupBean> pgBeanList = priManageDao.queryGroup4List(pbGroupBean);
	List<ListShowUtilBean> firstCodeList = personInfodao.getFirstCodeShowInfo(userid,"personal");
	String getGroupSelectHtml = personInfodao.getGroupSelectHtml(userid);
	
	String cnt = DaoUtil.SqlToField("select count(group_id) cnt from TA_OA_PERSONWORK_GROUP where user_id ='"+userid+"'");
	
	boolean isConfigGroupInfo = false;//是否配置了分组信息
	if(Integer.parseInt(cnt) > 0)
		isConfigGroupInfo = true;
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.dao.PersonInfoDao"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.entity.ListShowUtilBean"%>

<%@page import="com.chinacreator.xtbg.pub.util.DaoUtil"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.dao.PriManageDao"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManageProxy"%>
<%@page import="com.chinacreator.xtbg.pub.personwork.entity.PGroupBean"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>个人通讯录</title>

<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入jQuery_dialog （特殊删除有用到）-->
<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery_dialog/jquery_dialog.css" />
<script src="../../../resources/plug/jquery_dialog/jquery_dialog.js"></script>

<!-- 引入其它 -->
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script src="../../../resources/js/common/commoncss.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/testcss.css" />
<link href="../../../resources/css/tjz.css" rel="stylesheet" type="text/css" />
<!--模块特殊，不能去掉，去掉字母样式会不显示  -->

<!-- 公共部分结束 -->


<script type="text/javascript">

var nameindex = "";//拼音首字母

var groupname = "";//分组名称

var searchInputValue = "";//搜索框的值

var isInputSearchText = false;//是否正在在查询文本框中输入
(function( $ ) {
	$.widget( "ui.combobox", {
		_create: function() {
			var self = this,
				select = this.element.hide(),
				selected = select.children( ":selected" ),
				value = selected.val() ? selected.text() : "";

				var button = this.button = $( "<button type='button' class='addgroup'>&nbsp;</button>" )
				.attr( "tabIndex", -1 )
				.attr( "title", "添加到组" )
				.insertAfter( select )
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
						}
					})
				.removeClass("ui-autocomplete-input")
				.click(function() {
					if(!getselectGroupinfo()){
						return;
					}	
					// close if already visible
					if ( button.autocomplete( "widget" ).is( ":visible" ) ) {
						button.autocomplete( "close" );
						return;
					}
					// work around a bug (likely same cause as #5265)
					// pass empty string as value to search for, displaying all results
					button.autocomplete( "search", "" )
				});
				
				this.button.data( "autocomplete" )._renderItem = function( ul, item ) {
					var ischeck = "";
					var groupshowids = $('#groupshowids').val();
					var idsArry = groupshowids.split(",");
					$(idsArry).each(function(n,value){
						if(value == item.option.value){
							ischeck = "checked='checked'";
							return;
						}	
					});
					var islast = false;
					if($("#combobox").children("option").last().val() == item.option.value){
						islast = true;
					}
					var inputhtml =  $( "<li></li>" )
						.data( "item.autocomplete", item )
						.append( "<input type='checkbox'  name='group' onclick='onclickcheckbox()' id='" + item.option.value + "' " + ischeck + " value='" + item.option.text + "'/>" + item.label + "")	
						.appendTo( ul );
					if(islast){
						inputhtml = $( "<li></li>" )
						.data( "item.autocomplete", item )
						.append( "<input type='button' class='saveg' onclick='savePersonGroup()'  />")	
						.appendTo( ul );
					}
					 return inputhtml;
				};
			

		},

		destroy: function() {
			//this.input.remove();
			this.button.remove();
			this.element.show();
			$.Widget.prototype.destroy.call( this );
		}
	});
})( jQuery );


$(function() {

	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			personSearch();
		}
	});
	var defaultSearchShow = "输入姓名、号码或邮箱"
	
	$("#filters a").click(function (event){
		if($(event.target).html() == "全部"){
			nameindex = "";
			groupname = "";
			searchInputValue = "";
			$("#searchInput").val(defaultSearchShow);
			  $("#searchInput").addClass("focus");
		}else{
			nameindex = $(event.target).html();
		}
		personSearch();
	})
	
	$("#filters_group a").click(function (event){
		nameindex = "";
		groupname = "";
		groupname = $(event.target).html();
		personSearch();
	})
	
	$("#btn_Search").bind('click', searchByLikename);

	$("#searchInput").focus(function(){
		isInputSearchText = true;
		if(IsSpace(searchInputValue)){
		  $("#searchInput").removeClass("focus");
		  $("#searchInput").val("");
		}
	});

	$("#searchInput").bind("propertychange",function(){
		if(isInputSearchText){
			searchInputValue = $("#searchInput").val();
		}
	});

	$("#searchInput").blur(function(){
		isInputSearchText = false;
		searchInputValue = $("#searchInput").val();
		if(IsSpace($("#searchInput").val())){
		  $("#searchInput").val(defaultSearchShow);
		  $("#searchInput").addClass("focus");
		}
	});
			
	
	
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=personalAddressBookList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		//定义使用哪种方法发起请求，GET或者POST
		height: "99%",//270
		//Grid的高度，可以接受数字、%值、auto，默认值为150
		//width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
		//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
		autowidth: true,
		//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
		colNames: ['人员id', '姓名' , '办公手机', 'QQ', '电子邮箱', '所在分组', '分组id','信息来源','增加用户ID','信息来源code'],
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
			width: 100,
			editable: true
		},
		{
			name: 'commonlymobile',
			index: 'commonlymobile',
			width: 80,
			editable: true
		},
		{
			name: 'qqNum',
			index: 'qq',
			width: 80,
			hidden:true,
			editable: true
		},
		{
			name: 'email',
			index: 'email',
			width: 180,
			editable: true
		},
		{
			name: 'group',
			index: 'group_name',
			width: 150,
			editable: true
		},
		{
			name: 'group_id',
			index: 'group_id',
			hidden: true
		},
		{
			name: 'info_source_name',
			index: 'info_source_name',
			width: 80,
			search: true
		},
		{
			name: 'user_id',
			index: 'user_id',
			hidden: true
		},
		{
			name: 'info_source',
			index: 'info_source',
			hidden: true
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
			$("#gridTable").setGridWidth($(window).width()*0.98);
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];

			}

			$( "#combobox" ).combobox();
			$( "#toggle" ).click(function() {
				$( "#combobox" ).toggle();
			});
			
		 	$(".t_taoobar_content_left").attr("style","width:350px");
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",

		//定义页码控制条Page Bar
		//caption: "个人通讯录",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
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
		toolbar: [true,"top","<input type='button' id='addperson' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='新增' onclick='addPerson()' /><input type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='删除' onclick='deletePerson()' /><input type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value=' 添加到组 ' onclick='getselectGroupinfo()'/>"
			<%if(CacheCommonManageProxy.getBooleanSystemParam("personwork.publicAddressBookList_sendSms")){%>
				+"<input type='button' id='sendMsg' class='but_y_01' title='发送短信' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');  value='发送短信' onclick='sendSms()'/>"
			<%}%>],
		multiselect: true,
		onCellSelect : function (id,iCol){
		if(iCol != 0)
		{
			editPerson(id);
		}
	}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search: false,
		refresh: false
	});
	
	
	//$("#t_gridTable").append("<div>")
	//.append("<input type='button' id='addperson' class='addlm' onclick='addPerson()' />")
	//.append("<input type='button' class='dellm' onclick='deletePerson()' />")
	//.append("<%=getGroupSelectHtml%>")
	//.append("<input type='button' class='confg' onclick='configUserGroup()'  />")
	//.append("<select id='combobox'><option value='1'>组1</option><option value='2'>组2</option><option value='3'>组3</option></select>")	
	//.append("</div>");


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

	 
/**
* 发送短信
*/
 function sendSms() {
	 		var ids = "";
	 		var tempSendArrs = [];
	 		var tempArrs = [];
	 		var tempUserNamesArrs = [];
	 		var tempUser_id=[];
	 		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	 		$(selectedIds).each(function(){
		 		var model = jQuery("#gridTable").jqGrid('getRowData', this);
		 		//用户ID
		 		if(!IsSpace(model.person_id))
		 			tempSendArrs.push(model.person_id);
		 		//来源用户ID
		 		if(!IsSpace(model.user_id))
		 			tempArrs.push(model.user_id);
		 		
		 		if(!IsSpace(model.name))
		 			tempUserNamesArrs.push(model.name);
	 		})
	 		ids = tempArrs.join();
	 		if (IsSpace(ids)) {
	 			alert("请选择要发送的人！");
	 		} else {
	 			var params = {
	 					windowId : 'windowId',
	 					beSendUserIds : tempSendArrs.join(),
	 					is_source:tempArrs.join(),
	 					beSendUserNames : _pub.lang.zwzm(tempUserNamesArrs.join())
	 				 };
	 			var alertUrl = getContextPath() + '/ccapp/xtbg/huaihua/messagesend/jsp/addSendSms.jsp?'+jQuery.param(params);
	 			openAlertWindows('windowId',alertUrl,'短信发送',700,270,'25%','25%');
	 		}
	 	} 
	 
/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
	var str = "{'userid':'<%=userid%>','likevalue':'" + searchInputValue + "','nameindex':'" + nameindex + "','groupname': '"+groupname +"'}";
	return descape(escape(str));
}

var addPerson = function() {
	var url = "persondetailinfo.jsp";
	location.href = url;
	/* openWindows('sub_main_newbriefs','新建简报','../../../briefs/jsp/briefseditordrew.jsp?type=0&subid=sub_main_newbriefs','bjjb',false,window); */
}

//分组checkbox点击方法
var onclickcheckbox = function(){

	var groupids = "";
	$("input[name='group']").each(function (i) {
		if($(this).prop("checked")){//如果被选中了
			groupids += $(this).attr("id") + ",";
		}
	});
	//alert(groupstr);
	if (groupids.length > 0 ) groupids = groupids.substring(0,groupids.length-1);
	$('#groupshowids').val(groupids);
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

var savePersonGroup = function() {
	if(IsSpace($('#personids').val())){
		alert("请选择要添加到分组的名片！");	
	}
	closeGroupDiv();
	var url = "savepersongroupinfoform.jsp";
	
	document.all.form1.action = url;
	document.all.form1.target = "hiddenFrame";
	$('#form1').submit();
	
}

//关闭分组div
var closeGroupDiv = function() {
	//$("#alertmod").remove();
	//alert($(".saveg").parents("ul").first().html());
	$(".saveg").parents("ul").first().hide();
	//$( "#combobox" ).destroy();
}

var configUserGroup = function() {
	openAlertWindows('windowId','../../personwork/jsp/pGroupNew.jsp','编辑分组',490,290,'25%','25%');
	//var url = "pGroup.jsp";
	//JqueryDialog.Open1('配置人员分组', url, 500, 420, false, false, true);
	//JqueryDialog.BeforeCloseFunction = refreshWindow;
}

var refreshWindow = function() {
	location.href = location.href
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


//获得当前选中的数据的分组整合信息
var getselectGroupinfo = function() {
	if(<%=!isConfigGroupInfo%>){//如果没配置分组
		alert("您还没有配置分组信息！");
		return;
	}

	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	var tempArrs = [];
	var dirUserArrs = [];
	var personArrs = [];
	$(selectedIds).each(function(){
		var model = jQuery("#gridTable").jqGrid('getRowData', this);
		if(!IsSpace(model.group_id))
			tempArrs.push(model.group_id);
		if(model.info_source == "personaladdress")//如果信息来源为个人通讯录
			personArrs.push(model.person_id);
		else
			dirUserArrs.push(model.person_id);
	})
	ids = tempArrs.join().split(",").unique();
	$('#personids').val(personArrs.join());
	$('#groupshowids').val(ids);

	if(dirUserArrs.length > 0){
		alert("来自公共通讯录联系人不能进行分组！");
		return false;
	}
	if (IsSpace(personArrs.join())) {
			alert("请选择要添加到分组的名片！");
		return false;
	}
	openAlertWindows('windowId','../../personwork/jsp/configPersonGroup.jsp?personids='+personArrs.join()+'&groupshowids='+ids,'编辑分组',490,390,'25%','25%');
	//openWindows('windowId','../../personwork/jsp/configPersonGroup.jsp?personids='+personArrs.join()+'&groupshowids='+ids,'编辑分组',700,270,'40%','10%');
	//openWindows('windowId','编辑分组','../../personwork/jsp/configPersonGroup.jsp?personids='+personArrs.join()+'&groupshowids='+ids,'sub_main_personwork',false,window);
	return true;
	
}

var ssss = function(){
	return "dsfadfadsfa";

}

var deletePerson = function() {
	var personalids = "";
	var directoryids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	var tempArrs = [];
	var tempDirectArrs = [];
	$(selectedIds).each(function(){
		var model = jQuery("#gridTable").jqGrid('getRowData', this);
		if(!IsSpace(model.person_id) && model.info_source == "personaladdress")
			tempArrs.push(model.person_id);
		if(!IsSpace(model.person_id) && model.info_source == "directory")
			tempDirectArrs.push(model.person_id);
	})
	personalids = tempArrs.join();
	directoryids = tempDirectArrs.join();
	if (IsSpace(personalids) && IsSpace(directoryids)) {
		alert("请选择要删除的记录！");
	} else {
		var okF = function(){
			$("#personids").val(personalids);
			$("#directoryids").val(directoryids);
			$("#form1").attr("target","hiddenFrame");
			$("#form1").submit();
		}
		var p={
					headerText:'提示',
					okName:'确认',
			        okFunction:okF,
			        cancelName:'取消'
			};
		alert("确定要删除用户信息吗？",p)
	}
}

var editPerson = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var url = "";
	if(model.info_source == "personaladdress"){
		url = "persondetailinfo.jsp?person_id="+model.person_id;
		location.href = url;
	}else{
		//url = "viewdirectory.jsp?typeid="+model.person_id+"&ispersonal=yes";
		openAlertWindows('windowId','../../personwork/jsp/viewdirectory4publicaddress.jsp?typeid=' + model.person_id,'查看人员信息',800,300,'20%','10%');
	}
	
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
<table width="100%" >
<tr>
	<td>
	<div class="btn-bar" style="border-top:1px solid #EAEAEA;">
		<div  class="filters logClass" style="height: auto!important;height: 26px;height: 26px;">
		<span  style="width:100px; color:#000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;分组：</span>
		<%for(int i = 0; i < pgBeanList.size() ; i ++){ 
			
			PGroupBean pgBean = pgBeanList.get(i);
			String groupName = pgBean.getGroupName();
			if(groupName.length() > 5)
			{
				groupName	=groupName.substring(0,5) + "...";
			}
		%>
			<div class="tjdiv" id="filters_group" >
			<a style="width:80px;" href="javascript:void(0)" title="<%=pgBean.getGroupName() %>">
			<%=groupName %></a>
			</div>
		<%
			if((i+1)%9==0){
			%>	
			<span  style="width:100px; color:#000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<%
			}
		} %>
		<a style="color:#FF6600;width:50px;" href="javascript:void(0)" onClick="configUserGroup()">编辑分组</a>
		</div>
		</div>
	</td>
</tr>

<tr>
	<td>
	<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="btn-bar">
		<div  class="filters logClass" id="filters" >
		<span  style="width:100px; color:#000">首字母查询：</span>
			<a style="width:30px;" href="javascript:void(0)">全部</a>
			<%for(ListShowUtilBean showBean:firstCodeList){ 
				if(showBean.isExsit){%>
				<a style="width:20px;" href="javascript:void(0)"><%=showBean.getFirstCode() %></a>
			<%}else{ %>
				<span style='width: 20px;'><%=showBean.getFirstCode() %></span>
			<%}} %>
		</div>
		</div>
	</td>
</tr>

<tr>
	<td>
	<div class="btn-bar">
		<div  class="filters logClass">
		<span  style="width:100px; color:#000">&nbsp;条件查询：</span>
			<input name="search"  id="searchInput"  style="float:left;" type="text" value="输入姓名、号码或邮箱" class="input_cx_title_188" />
			<input name="btn_Search" id="btn_Search" style="float:left; margin-left:5px;"  class="but_y_01" type="button" value="搜索"/>
		</div>
		</div>
	</td>
</tr>

<tr>
	<td>
	<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
	</div>
	</td>
</tr>
</table>	
	
	<!-- 查询列表区 -->
<form id="form1" name="form1" method="post" action="deletepersoninfoform.jsp">
<input id="userid" name="userid" value="<%=userid %>" type="hidden"></input>
<input id="personids" name="personids" value="" type="hidden"></input>
<input id="directoryids" name="directoryids" value="" type="hidden"></input>
<input id="groupshowids" name="groupshowids" type="hidden" value=""></input>
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>