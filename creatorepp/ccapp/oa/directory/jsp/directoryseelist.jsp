<%--
描述：名录管理界面
作者：戴连春
日期：2013-06-13
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
		+'=com.chinacreator.xtbg.core.directory.list.DirectoryList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
		datatype: "json",
		//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
		mtype: "POST",
		pageCached:false,
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
			label:'出生年月',
			name: 'directoryyear',
			index: 'directoryyear',
			width: 180,
			editable: true
		},
		{
			label:'性别',
			name: 'directorysex',
			index: 'directorysex',
			width: 180,
			editable: true
		},
		{
			label:'办公手机',
			name: 'mobile2',
			index: 'mobile2',
			width: 150,
			hidden: true,
			search: true
		}
		,
		{
			label:'办公电话',
			name: 'workphone',
			index: 'workphone',
			width: 150,
			hidden: true,
			search: true
		},
		{
			label:'政治面貌',
			name: 'politics',
			index: 'politics',
			width: 150,
			search: true
		},
		{
			label:'人员类别',
			name: 'new_user_type',
			index: 'new_user_type',
			width: 150,
			search: true
		},
		{
			label:'工号',
			name: 'new_job_no',
			index: 'new_job_no',
			width: 150,
			search: true
		},
		{
			label:'级别',
			name: 'directorylevel',
			index: 'directorylevel',
			width: 150,
			hidden: true,
			search: true
		},
		{
			label:'是否党政一把手',
			name: 'numberone',
			index: 'numberone',
			width: 200,
			hidden: true,
			search: true
		},
		{
			label:'所在单位',
			name: 'orgname',
			index: 'orgname',
			width: 230,
			search: true
		},
		{
			label:'有无权限',
			name: 'viewrole',
			index: 'viewrole',
			width: 100,
			search: true,
			sortable: false,
			hidden: true
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
				if("true" == model.ishasviewrole){
					be = "<IMG " +
						"style='POSITION: static; WIDTH: 18px; HEIGHT: 16px;' " +
							"src='../resources/images/yiyinyong.jpg'>";
				}else{
					be = "<IMG " +
					"style='POSITION: static; WIDTH: 18px; HEIGHT: 16px;' " +
						"src='../resources/images/weiyinyong.jpg'>";
				}
				
				userids.push(model.directoryid);
			jQuery("#gridTable").jqGrid('setRowData', ids[i], {
				viewrole: be
			});

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
		          <%if("adminUser".equals(StrRoles)){%>
		          +"<input type='button' class='but_excelgo_01' title='导入excel表格' onMouseOver=javascript:$(this).attr('class','but_excelgo_02'); onMouseOut=javascript:$(this).attr('class','but_excelgo_01');  value='' onclick='openImport()' style='margin-left:5px;'/>"
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
    setSelect("#duties","classinput3");
    setSelect("#usertype","classinput4");
    //setSelect("#usersex","classinput5");
    setSelect("#jszc","classinput6");
    setSelect("#xuewei","classinput7");
    setSelect("#xueli","classinput8");
	
});
	 
/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
		 userids.length = 0;//清空该变量
		 var department = ""; //是否是党政一把手
			var directorylevel = ""; //级别
			var duties = ""; //职务
			var politics="" ; //政治面貌
			var orgid ="" ; //所在单位
			var hetong_nowsend_date1 = ""; //  现合同终止期起始时间
			var hetong_nowsend_date2 = ""; //  现合同终止期截止时间
			var hetong_tryend_date1 = ""; //   合同试用终止期起始时间
			var hetong_tryend_date2 = ""; //   合同试用终止期截止时间
			var directoryyear1 = "";
			var directoryyear2 = "";
			var leavetime_date1 = ""; //离职日期 起始时间
			var leavetime_date2 = ""; //离职日期 结束时间
			var radio = $("[name=radio]:checked").val();
			if("undefined" != $("#directorylevel").val()){
				directorylevel = $("#directorylevel").val();
			}
			if("undefined" != $("#duties").val()){
				duties = $("#duties").val();
			}
			if("undefined" != $("#politics").val()){
				politics = $("#politics").val();
			}
			if("undefined" != $("#orgid").val()){
				orgid = $("#orgid").val();
			}
			if("undefined" != $("#hetong_nowsend_date1").val()){
				hetong_nowsend_date1 = $("#hetong_nowsend_date1").val();
			}
			if("undefined" != $("#hetong_nowsend_date2").val()){
				hetong_nowsend_date2 = $("#hetong_nowsend_date2").val();
			}
			if("undefined" != $("#hetong_tryend_date1").val()){
				hetong_tryend_date1 = $("#hetong_tryend_date1").val();
			}
			if("undefined" != $("#hetong_tryend_date2").val()){
				hetong_tryend_date2 = $("#hetong_tryend_date2").val();
			}
			if("undefined" != $("#directoryyear1").val()){
				directoryyear1 = $("#directoryyear1").val();
			}
			if("undefined" != $("#directoryyear2").val()){
				directoryyear2 = $("#directoryyear2").val();
			}
			if("undefined" != $("#leavetime_date1").val()){
				leavetime_date1 = $("#leavetime_date1").val();
			}
			if("undefined" != $("#leavetime_date2").val()){
				leavetime_date2 = $("#leavetime_date2").val();
			}
			
			 if($("[name=radio]:checked")){
			 	if(typeof(radio)=="undefined"){
			 		radio="";
			 	}else{
			    department = radio ;
			 	}
			} 
		 
	var str = "{'orgid':'<%=orgid %>','strRoles':'<%=StrRoles%>','':'<%=orgUserMan%>','userid':'<%=userid%>','likevalue':'" + searchInputValue 
		+ "','nameindex':'" + nameindex + "','listtype':'view','department':'"+department+"','directorylevel':'"+directorylevel+"','duties':'"+duties
		+"','hetong_nowsend_date1':'"+hetong_nowsend_date1+"','hetong_nowsend_date2':'"+hetong_nowsend_date2+"','hetong_tryend_date1':'"+hetong_tryend_date1+"','hetong_tryend_date2':'"+hetong_tryend_date2
		+"','orgids':'"+orgid+"','directoryyear1':'"+directoryyear1+"','directoryyear2':'"+directoryyear2+"','politics':'"+politics
		+"','new_user_type':'"+$("#usertype").val()+"','directorysex':'"+$("#usersex").val()+"','intime1':'"+$("#intime1").val()
		+"','intime2':'"+$("#intime2").val()+"','new_jszc':'"+$("#jszc").val()+"','new_zg_xl':'"+$("#xueli").val()
		+"','leavetime_date1':'"+leavetime_date1+"','leavetime_date2':'"+leavetime_date2
		+"','job_name':'"+$("#job_name").val()
		+"','new_zg_xw':'"+$("#xuewei").val()+"'}";
		
		
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
	if("adminUser"=="<%=StrRoles%>"){    //人资管理员
		var mes = "查看人员信息";
		openAlertWindows('windowId',getCurrentFilePath() +'updateview4directory.jsp?typeid='+ model.directoryid+'&strRoles=<%=StrRoles%>&urls=have',mes,800,450,'16%','25%');
	}else{
		if("true" == model.ishasviewrole){
			var mes = "查看人员信息";
			//系统管理员或部门管理员
			if("1"=="<%=userid%>"){
				openAlertWindows('windowId',getCurrentFilePath() +'updateview4directory.jsp?typeid='+ model.directoryid+'&strRoles=<%=StrRoles%>&urls=have',mes,800,450,'16%','25%');
			}else{
				openAlertWindows('windowId',getCurrentFilePath() +'view4directory.jsp?typeid='+ model.directoryid+'&urls=have',mes,800,450,'16%','25%');
			}
		}
	}
	
}

/**
 * 导出
 */
function exportFile(){
    var url = "ajaxexcel.jsp";
    var html = new Array();
    html.push("<div id='export_excel'>");
    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
    html.push("<input type='hidden' name='userids' value='"+userids.join()+"' /> ");
    html.push("<input type='hidden' name='parmjson' value='"+toUserParamJosn()+"' /> ");
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
    openAlertWindows('windowId', getCurrentFilePath()+'directoryexcelimport.jsp',
            '导入excel表格', '455px', '70%', '10%', '40%', function() {
                location.reload();
            });
}


function chooseOrg (){
	  var s = new jQuery.z_tree_leftRigth();
	  s.treeID='mianDept';
	  s.isShowSeacher="aa";
	  s.treeName="选取部门";
	  s.headerName="选取部门";
	  s.titelText = "选取部门";
	  s.rightHeaderText="已添加机构和人员";
	  s.returnFunction=function(orgObj){
		  if(IsSpace(orgObj.dept) || null ==orgObj.dept )
		  	{
			   jQuery('#orgid').val('');
			   jQuery('#orgname').val('');
			 }else{
				jQuery('#orgid').val(orgObj.dept.id);
				jQuery('#orgname').val(orgObj.dept.name);
			 }
	  }
	  s.treeList=
			  [{
				  leftHeaderText:'按部门选择',
				  item_id :'org_id',
				  isType:'dept', 
				  valueKey:'dept',
				  selectedIds:jQuery('#orgid').val(),
				  type:"ADEPT"
			}];
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
						<td width="100px" >条件查询：</td>
						<td class="cx_title_td" >
			
							<input name="search"  id="searchInput"  style="float:left;" type="text" value="输入姓名、号码、邮箱或者所在单位" class="input_cx_title_240" />
	                   	
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
						<td width="100px" >政治面貌：</td>
						<td align="left" width="328px">
							<P id="pid1" style="position: absolute;margin: 0;z-index:1;width: 180px">
							    <select id='politics' name='politics'  class="redbost" multiple="multiple">
					                <option value=""  type='checkbox' all='11'>&nbsp;全选</option>
					                <option value='1' type='checkbox' name="option">&nbsp;中共党员</option>
					                <option value='2' type='checkbox' >&nbsp;中共预备党员</option>
					                <option value='3' type='checkbox' >&nbsp;共青团员</option>
					                <option value='4' type='checkbox' >&nbsp;民革党员</option>
					                <option value='5' type='checkbox' >&nbsp;民盟盟员</option>
					                <option value='6' type='checkbox' >&nbsp;民建会员</option>
								    <option value='7' type='checkbox' >&nbsp;民进会员</option>
									<option value='8' type='checkbox' >&nbsp;农工党党员</option>
									<option value='9'  type='checkbox' >&nbsp;致公党党员</option>
									<option value='10' type='checkbox' >&nbsp;九三学社社员</option>
									<option value='11' type='checkbox' >&nbsp;台盟盟员</option>
									<option value='12' type='checkbox' >&nbsp;无党派民主人士</option>
									<option value='13' type='checkbox' >&nbsp;群众</option>
							    </select>
							</P>&nbsp;
						</td>
						<td width="50px">级别：</td>
						<td align="left">
						<P id="pid2" style="position: absolute;margin: 0;z-index:1; width: 180px;">
								<select  style='width: 180px;' name="directorylevel" id='directorylevel' class="redbost" multiple="multiple">
									<option value='' type='checkbox' all='22' >&nbsp;全选</option>
									<option value='正处级' type='checkbox' name="option">&nbsp;正处级</option>
									<option value='副处级' type='checkbox' >&nbsp;副处级</option>
									<option value='正科级' type='checkbox' >&nbsp;正科级</option>
									<option value='副科级' type='checkbox' >&nbsp;副科级</option>
									<option value='科员'   type='checkbox' >&nbsp;科员</option>
									<option value='其他'   type='checkbox'>&nbsp;其他</option>
						        </select> 
					        </P>&nbsp;
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable"   >
				    <tr>
						<td width="100px">所在单位：</td>
						<td align="left">
						   <input name="orgid"  id="orgid"  style="float:left;" type="hidden" />
						    <input name="orgname"  id="orgname"  style="float:left;" onclick="chooseOrg();" type="text" class="input_cx_title_188" readonly="readonly"/>
						</td>
						<td width="100px">是否党政一把手：</td>
						<td class="cx_title_td"  >
						    <input type="radio" name="radio" value="是 " />是 
							<input type="radio" name="radio" value="否" />否
						    <input type="radio" name="radio" value=""  />全部                                
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable"   >
				    <tr>
						<td width="100px">现合同终止期：</td>
						<td align="left">
						    <input name="hetong_nowsend_date1"  id="hetong_nowsend_date1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="float:left;" type="text" class="input_cx_title_188" />
						</td>
						<td>至</td>
						<td align="left">
						    <input name="hetong_nowsend_date2"  id="hetong_nowsend_date2" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="float:left;" type="text" class="input_cx_title_188" />                        
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable"   >
				    <tr>
						<td width="100px">合同试用终止期：</td>
						<td align="left">
						    <input name="hetong_tryend_date1"  id="hetong_tryend_date1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="float:left;" type="text" class="input_cx_title_188" />
						</td>
						<td>至</td>
						<td align="left" >
						    <input name="hetong_tryend_date2"  id="hetong_tryend_date2" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="float:left;" type="text" class="input_cx_title_188" />                        
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable"   >
				    <tr>
						<td width="100px">离职时间：</td>
						<td align="left">
						    <input name="leavetime_date1"  id="leavetime_date1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="float:left;" type="text" class="input_cx_title_188" />
						</td>
						<td>至</td>
						<td align="left" >
						    <input name="leavetime_date2"  id="leavetime_date2" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="float:left;" type="text" class="input_cx_title_188" />                        
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable"   >
				    <tr>
						<td width="100px">职务：</td>
						<td align="left" width="320px">
							<P id="pid2" style="position: absolute;margin: 0;z-index:1; width: 192px;">
								<select  style='width: 192px;' name="duties" id='duties' class="redbost" multiple="multiple">
									<option value='' type='checkbox' all='22' >&nbsp;全选</option>
									<option value='院长' type='checkbox' name="option">&nbsp;院长</option>
									<option value='副院长' type='checkbox' name="option">&nbsp;副院长</option>
									<option value='省院总工程师' type='checkbox' name="option">&nbsp;省院总工程师</option>
									<option value='党委书记' type='checkbox' >&nbsp;党委书记</option>
									<option value='纪检书记' type='checkbox' >&nbsp;纪检书记</option>
									<option value='院长助理' type='checkbox' >&nbsp;院长助理</option>
									<option value='部长'   type='checkbox' >&nbsp;部长</option>
									<option value='副部长'   type='checkbox' >&nbsp;副部长</option>
									<option value='省院副总工程师'   type='checkbox' >&nbsp;省院副总工程师</option>
									<option value='主任' type='checkbox' >&nbsp;主任</option>
									<option value='副主任' type='checkbox' >&nbsp;副主任</option>
									<option value='部长兼省院副总工程师' type='checkbox' >&nbsp;部长兼省院副总工程师</option>
									<option value='总经理' type='checkbox' >&nbsp;总经理</option>
									<option value='副总经理' type='checkbox' >&nbsp;副总经理</option>
									<option value='工会主席' type='checkbox' >&nbsp;工会主席</option>
									<option value='分院院长' type='checkbox' >&nbsp;分院院长</option>
									<option value='分院副院长' type='checkbox' >&nbsp;分院副院长</option>
									<option value='分院总工' type='checkbox' >&nbsp;分院总工</option>
									<option value='分院工会主席' type='checkbox' >&nbsp;分院工会主席</option>
									<option value='其他'   type='checkbox'>&nbsp;其他</option>
						        </select> 
					        </P>&nbsp;
						</td>
						<td width="60px">人员类别：</td>
						<td align="left">
						    <P id="pid2" style="position: absolute;margin: 0;z-index:1; width: 180px;">
								<select  style='width: 180px;' name="usertype" id='usertype' class="redbost" multiple="multiple">
									<option value='' type='checkbox' all='22' >&nbsp;全选</option>
								    <option value="bnzg" type='checkbox'>编内职工</option>
								    <option value="bwzg" type='checkbox'>编外职工</option>
								    <option value="txzg" type='checkbox'>退休职工</option>
									<option value='其他'   type='checkbox'>&nbsp;其他</option>
						        </select> 
					        </P>&nbsp;
						</td>
					</tr>
				</table>
			  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable"   >
				    <tr>
						<td width="100px">出生日期：</td>
						<td align="left">
						    <input name="directoryyear1"  id="directoryyear1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="float:left;" type="text" class="input_cx_title_188" />
						</td>
						<td>至</td>
						<td align="left">
						    <input name="directoryyear2"  id="directoryyear2" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="float:left;" type="text" class="input_cx_title_188" />                        
						</td>
					</tr>
				</table>
			 	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable"   >
				    <tr>
						<td width="100px">入院时间：</td>
						<td align="left">
						    <input name="intime1"  id="intime1" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="float:left;" type="text" class="input_cx_title_188" />
						</td>
						<td>至</td>
						<td align="left">
						    <input name="intime2"  id="intime2" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="float:left;" type="text" class="input_cx_title_188" />                        
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable"   >
				    <tr>
						<td width="100px">性别：</td>
						<td align="left" width="320px">
								<select  style='width: 193px;height: 22px' name="usersex" id='usersex' class="redbost">
									<option value=''  all='22' >&nbsp;--请选择--</option>
									<option value='M'  name="option">&nbsp;男</option>
									<option value='F'  name="option">&nbsp;女</option>
						        </select> 
						</td>
						<td width="60px">技术职称：</td>
						<td align="left">
						    <P id="pid2" style="margin: 0; width: 180px;">
								<select  style='width: 180px;' name="jszc" id='jszc' class="redbost" multiple="multiple">
									<option value='' type='checkbox' all='22' >&nbsp;全选</option>
									<option value='yjygjgcs' type='checkbox'>研究员级高级工程师</option>
									<option value='gjgcs' type='checkbox'>高级工程师</option>
									<option value='gcs' type='checkbox'>工程师</option>
									<option value='zlgcs' type='checkbox'>助理工程师</option>
									<option value='jsy' type='checkbox'>技术员</option>
									<option value='gjjjs' type='checkbox'>高级经济师</option>
									<option value='jjs' type='checkbox'>经济师</option>
									<option value='zljjs' type='checkbox'>助理经济师</option>
									<option value='gjkjy' type='checkbox'>高级会计师</option>
									<option value='zlkjy' type='checkbox'>助理会计师</option>
									<option value='kjy' type='checkbox'>会计员</option>
									<option value='kjs' type='checkbox'>会计师</option>
						        </select> 
					        </P>&nbsp;
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable"   >
				    <tr>
						<td width="100px">学历：</td>
						<td align="left" width="320px">
							<P id="pid2" style="position: absolute;margin: 0;z-index:1; width: 192px;">
								<select  style='width: 192px;' name="xueli" id='xueli' class="redbost" multiple="multiple">
									<option value='' type='checkbox' all='22' >&nbsp;全选</option>
									<option value='phd' type='checkbox'>研究生</option>
									<option value='undergraduate' type='checkbox'>本科</option>
									<option value='specialist' type='checkbox'>专科</option>
									<option value='highschool' type='checkbox'>高中</option>
									<option value='secondary' type='checkbox'>中专</option>
									<option value='juniorhighschool' type='checkbox'>初中</option>
									<option value='primaryschool' type='checkbox'>小学</option>
									<option value='其他'   type='checkbox'>&nbsp;其他</option>
						        </select> 
					        </P>&nbsp;
						</td>
						<td width="60px">学位：</td>
						<td align="left">
						    <P id="pid2" style="position: absolute;margin: 0;z-index:1; width: 180px;">
								<select  style='width: 180px;' name="xuewei" id='xuewei' class="redbost" multiple="multiple">
									<option value='' type='checkbox' all='22' >&nbsp;全选</option>
									<option value='bs' type='checkbox'>博士</option>
									<option value='ss' type='checkbox'>硕士</option>
									<option value='xs' type='checkbox'>学士</option>
						        </select> 
					        </P>&nbsp;
						</td>
					</tr>
					<tr>
					
				</table>		
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable"   >
				    <tr>
						<td width="100px">岗位：</td>
						<td align="left">
						    <input name="job_name"  id="job_name" style="float:left;" type="text" class="input_cx_title_188" />
						</td>
					
					<tr>
					
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