<%--
描述：薪酬管理界面
作者：童佳
日期：2014-03-25
 --%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.directory.dao.DirectoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.directory.entity.ListShowUtilBean"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.*"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.impl.*"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String userid = accesscontroler.getUserID();	
	String orgid = request.getParameter("orgid");
	if (null == orgid){
		orgid = accesscontroler.getChargeOrgId();//查询机构根节点		
	}
	//是否部门管理员
	boolean isManager = accesscontroler.isOrganizationManager(orgid);
	
	String orgUserMan = "no";
	if(isManager){
		orgUserMan = "yes";
	}
	
	AuthRole authRoles[] = accesscontroler.getAllRoleofUser(accesscontroler.getUserAccount());
	String StrRoles="";
	String rolesNames = "";
	StringBuffer buf = new StringBuffer();
	for(int i=0;i<authRoles.length;i++){
		buf.append(authRoles[i].toString()+ ",");
	}   
	rolesNames = buf.toString();
	if(rolesNames.length()>0){
		rolesNames = rolesNames.substring(0,rolesNames.length()-1);
	}
	if(rolesNames.indexOf("人资管理员")!=-1){
		StrRoles = "adminUser";
	}
	else if(rolesNames.indexOf("薪酬院领导")!=-1){
		StrRoles = "yuanldUser";
	}
	else if(rolesNames.indexOf("薪酬部门责任人")!=-1){
		StrRoles = "orgUser";
	}else{
		StrRoles = "putongUser";
	}
	
	DirectoryServiceIfc service = new DirectoryServiceImpl();
	List<ListShowUtilBean> firstCodeList = service.getFirstCodeShowInfo(orgid);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>JGRID</title>
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/testcss.css" />

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<!--模块特殊，不能去掉，去掉字母样式会不显示  -->
<script type="text/javascript"src="../../resources/util/multiSelect.js"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<script type="text/javascript">
var nameindex = "";//拼音首字母

var searchInputValue = "";//搜索框的值

var isInputSearchText = false;//是否正在在查询文本框中输入

var userids = new Array();//当前列表的用户id的数组
$(function() {
	//文档添加回车按钮事件
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	});
	
	
		var defaultSearchShow = "输入姓名、号码、邮箱或者所在单位";  
		//拼音搜索栏添加点击事件
		$("#filters a").click(function (event){
			if($(event.target).html() == "全部"){
				nameindex = "";
				searchInputValue = "";
				$("#searchInput").val(defaultSearchShow);
				$("#searchInput").addClass("focus");
			}else{
				nameindex = $(this).html();
			}
			jQuery("a").removeClass("onclicks");
            jQuery(this).addClass("onclicks");
			userSearch();
		})
		//搜索按钮添加点击事件
		$("#btn_Search").bind('click', userSearch);

		//多条件搜索框添加获得焦点事件
		$("#searchInput").focus(function(){
			isInputSearchText = true;
			if(IsSpace(searchInputValue)){
			  $("#searchInput").removeClass("focus");
			  $("#searchInput").val("");
			}
		});

		//多条件搜索框添加属性更改监听事件
		$("#searchInput").bind("propertychange",function(){
			if(isInputSearchText){
				searchInputValue = $("#searchInput").val();
			}
		});

		//多条件搜索框添加失去焦点事件
		$("#searchInput").blur(function(){
			isInputSearchText = false;
			searchInputValue = $("#searchInput").val();
			if(IsSpace($("#searchInput").val())){
			  $("#searchInput").val(defaultSearchShow);
			  $("#searchInput").addClass("focus");
			}
		});

	//初始化grid表格
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId'
		+'=com.chinacreator.xtbg.core.directory.list.DirectoryXCList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		//定义使用哪种方法发起请求，GET或者POST
		height: "100%",//270
		autowidth: true,
		//最重要的数组之一，用于设定各列的参数
		colModel: [ 
		{
			label:'名录id',
			name: 'directoryid',
			index: 'directoryid',
			hidden: true
		},
		{
			label:'姓名',
			name: 'directoryname',
			index: 'directoryname',
			width: 180,
			editable: true
		},
		{
			label:'工作部门id',
			name: 'orgid',
			index: 'orgid',
			hidden: true
		}
		,
		{
			label:'工作部门',
			name: 'orgname',
			index: 'orgname',
			width: 100,
			search: true
		},
		{
			label:'岗位工资',
			name: 'new_xc_gwgz',
			index: 'new_xc_gwgz',
			width: 100,
			search: true
		},
		{
			label:'薪级工资',
			name: 'new_xc_xjgz',
			index: 'new_xc_xjgz',
			width: 100,
			search: true
		},
		{
			label:'应发合计',
			name: 'new_xc_yfgz',
			index: 'new_xc_yfgz',
			width: 100,
			search: true
		},
		{
			label:'扣款合计',
			name: 'new_xc_cbhj',
			index: 'new_xc_cbhj',
			width: 100,
			search: true
		},
		{
			label:'实发合计',
			name: 'new_xc_sfhj',
			index: 'new_xc_sfhj',
			width: 100,
			search: true,
			sortable: false
		},
		{
			label:'权限隐藏值',
			name: 'ishasviewrole',
			index: 'ishasviewrole',
			hidden: true
		}
		
		],
		sortname: '',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortorder: 'desc',
		viewrecords: true,
		//scroll:true,
		//scrollOffset:18,
		//scrollrows:true,
		//lastpage:1,
		
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
				
				userids.push(model.directoryid);

			}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		//定义页码控制条Page Bar
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		
		//caption: "名录管理",
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
		toolbar: [true,"top",
		          "<input type='button' class='but_excelout_01' title='导出excel表格' onMouseOver=javascript:$(this).attr('class','but_excelout_02'); onMouseOut=javascript:$(this).attr('class','but_excelout_01');  value='' onclick='exportFile()' style='margin-left:5px;'/>"
		          <%if(StrRoles.equals("adminUser")){%>
		          +"<input type='button' id='daoruexcel' class='but_excelgo_01' title='导入excel表格' onMouseOver=javascript:$(this).attr('class','but_excelgo_02'); onMouseOut=javascript:$(this).attr('class','but_excelgo_01');  value='' onclick='openImport()' style='margin-left:5px;'/>"
		          <%}%>
		          ],
		multiselect: false,
		onSelectRow: function(id) {
			updateUser(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search: false,
		refresh: false
	});

	setSelect("#politics", "classinput1");
    setSelect("#directorylevel","classinput2");
	
});
	 
/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
		 userids.length = 0;//清空该变量
		 var directoryname = "";
		 var org_id = "";
		if("undefined" != $("#directoryname").val()){
			directoryname = $("#directoryname").val();
		}
		if("undefined" != $("#org_id").val()){
			org_id = $("#org_id").val();
		}
		 
	var str = "{'orgid':'<%=orgid %>','strRoles':'<%=StrRoles%>','orgUserMan':'<%=orgUserMan%>','userid':'<%=userid%>','likevalue':'" + searchInputValue 
		+ "','nameindex':'" + nameindex + "','directoryname':'"+directoryname+"','org_id':'"+org_id+"','listtype':'view'}";
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

/**
 *函数:  updateUser
 *说明:  修改用户
 *参数:  无
 *返回值: 无
 */
var updateUser = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	if("true" == model.ishasviewrole){
		var mes = "查看人员信息";
		//薪酬管理员
		if("adminUser"=="<%=StrRoles%>"){
			openAlertWindows('windowId',getCurrentFilePath() +'updateXCview4directory.jsp?typeid='+ model.directoryid+'&urls=have',mes,800,350,'16%','25%');
		}else{
			openAlertWindows('windowId',getCurrentFilePath() +'viewXC4directory.jsp?typeid='+ model.directoryid+'&urls=have',mes,800,350,'16%','25%');
		}
	}
}

/**
 * 导出
 */
function exportFile(){
   /*  var url = "ajaxexcel.jsp";
    var html = new Array();
    html.push("<div id='export_excel'>");
    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
    html.push("<input type='hidden' name='userids' value='"+userids.join()+"' /> ");
    html.push('</form>');
    html.push("</div>");
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body");
    jQuery("#downFrom").submit();
    jQuery("#export_excel").remove(); */
    
	var url = "${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/ajaxexcel.jsp";
    var html = new Array();
    html.push("<div id='export_excel'>");
    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
    html.push("<input type='hidden' name='userids' value='"+userids.join()+"' /> ");
    html.push("<input type='hidden' name='excelname' value='人员薪酬信息' /> ");//导出的主题
    html.push("<input type='hidden' name='excelImplClass' value='directoryDaoExcelImpl' /> ");//导入导出的实现类，要提前在spring中或orcleConfig中配置好
    html.push("<input type='hidden' name='excelTemplateFilePath' value='directryXC_excelTemplateFilePath' /> ");//导出的excel模版路径，要提前在系统properties中配置好
    html.push('</form>');
    html.push("</div>");
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body");
    jQuery("#downFrom").submit();
    jQuery("#export_excel").remove();
}

/**
 *  打开导入excel页面,
 */
function openImport() {
	var title = descape(escape('薪酬信息')); //转码,避免中文传输乱码
	var remark = descape(escape('注意:导入的文件中,用户id必须匹配,否则无法导入成功')); //转码,避免中文传输乱码
	var url = '${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/excelimport.jsp?excelImplClass=directoryDaoExcelImpl&excelTemplateFilePath=directryXC_excelTemplateFilePath&title='+title+'&remark='+remark;
	openAlertWindows('windowId',url,
		    '导入excel表格', '455px', '70%', '10%', '40%', function() {
			location.reload();
		    });
}

var chooseDept = function (){
	var s = new jQuery.z_tree();
	s.treeID = 'mianOrg';
	s.treetypestr = 'radio';
	s.isShowSeacher = true;
	s.treeName = "选取部门";
	s.headerName = "选取部门";
	s.type = "ADEPT";
	s.selectedIds = jQuery("#org_id").val(),
	s.returnFunction = function(orgObj,o) {
		if (!IsSpace(o)) {
			jQuery('#org_id').val(o[0].id);
			jQuery('#org_name').val(o[0].name);
		} else {
			jQuery('#org_id').val("");
			jQuery('#org_name').val("");
		}
	}
	s.init();
}

</script>
</head>
<body>	    
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
		
	<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
	<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
		<tr>
			<td>
				<!-- 固定查询 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
					<tr>
						<td width="100px" >人员名称：</td>
						<td class="cx_title_td" >
			
							<input name="directoryname"  id="directoryname"  style="float:left;" type="text" value="" class="input_cx_title_240" />
	                   	
	                   		<input name="btn_Search" id="btn_Search" style="float:left; margin-left:5px;"  class="but_y_01" type="button" value="搜索"/>
						</td>
						
						<td width="345">
						    <span id="selAreaImg" class="all_search_condition">
						        <a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a>
						    </span>
						</td>
					</tr>
				</table>
				<!-- 固定查询 end-->
			</td>
			</tr>
			  
			<tr>
			<td id="hiddenArea"  style="display:none">
				<!-- 隐藏查询 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" >
					<!-- 正规 4列 -->
					<tr>
						<td width="100px" >所属部门：</td>
						<td class="cx_title_td" >
							<input name="org_id"  id="org_id" type="hidden" value="" class="input_cx_title_240" />
							<input name="org_name"  id="org_name" onclick="chooseDept()" value="" class="input_cx_title_240" />
						</td>
					</tr>
				</table>
		</td>
	</tr>
	</table>
	<div>
		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea">
			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
		<!-- 查询列表区 -->		
	</div>	
</body>
</html>