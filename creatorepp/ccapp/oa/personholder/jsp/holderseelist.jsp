<%--
	描述：人员持证管理界面
	作者：邱炼
	版本：1.0
	日期：2014-02-21
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.DaoUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.directory.dao.DirectoryDao"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.directory.entity.ListShowUtilBean"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.*"%>
<%@page import="com.chinacreator.xtbg.core.personholder.util.PersonHolderConstants"%>
<%@page import="com.chinacreator.xtbg.core.personholder.util.PersonHolderUtil"%>
<%@page import="com.chinacreator.xtbg.core.directory.service.impl.*"%>
<%
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String path = request.getContextPath();
	String userid = accesscontroler.getUserID();	
	String orgid = request.getParameter("orgid");
	String parent_id = request.getParameter("parent_id");
	if (null == orgid){
		orgid = accesscontroler.getChargeOrgId();//查询机构根节点		
	}
	DirectoryServiceIfc service = new DirectoryServiceImpl();
	List<ListShowUtilBean> firstCodeList = service.getFirstCodeShowInfo(orgid);
	//人员持证管理员角色
	boolean isROLE = PersonHolderUtil.isRolesUser(userid, PersonHolderConstants.ROLE_NAME);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
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
	
	$("#new_user_type").change(function(){  //如果选择了编内职工 则显示在岗状态
		if($("#new_user_type").val() == "bnzg"){
			$("#zgzt").show();
		}else{
			$("#zgzt").hide();
		}
	});
	
	 //搜索按钮添加点击事件
	 $("#btn_Search").bind('click', userSearch);


	//初始化grid表格
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId'
		+'=com.chinacreator.xtbg.core.personholder.list.PersonHolderList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
			label:'人员类别',
			name: 'new_user_type',
			index: 'new_user_type',
			width: 180,
			editable: true
		},
		{
			label:'在岗状态',
			name: 'new_job_state',
			index: 'new_job_state',
			width: 150,
			search: true
		}
		,
		{
			label:'职工工号',
			name: 'new_job_no',
			index: 'new_job_no',
			width: 150,
			search: true
		},
		{
			label:'姓名',
			name: 'directoryname',
			index: 'directoryname',
			width: 150,
			search: true
		},
		{
			label:'部门',
			name: 'orgname',
			index: 'orgname',
			width: 150,
			search: true
		},
		{
			label:'职称',
			name: 'new_jszc',
			index: 'new_jszc',
			width: 150,
			search: true
		},
		{
			label:'持证项目',
			name: 'persionHold_name',
			index: 'persionHold_name',
			width: 200,
			search: true
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
			//设置工具栏宽度
			$(".t_taoobar_content_left").css("width","330px");
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
				//人员类别
				if("bnzg"==model.new_user_type){
					new_user_type1="编内职工";
				} else if("bwzg"==model.new_user_type){
					new_user_type1="编外职工";
				}else if("txzg"==model.new_user_type){
					new_user_type1="退休职工";
				} else {
					new_user_type1="";
				}
				//员工在岗状态
				if("1"==model.new_job_state){
					new_job_state1="编内在岗职工";
				} else if("2"==model.new_job_state){
					new_job_state1="省院内部借调职工";
				}else if("3"==model.new_job_state){
					new_job_state1="质监系统借调职工";
				} else if("4"==model.new_job_state){
					new_job_state1="在编不在岗职工";
				} else if("5"==model.new_job_state){
					new_job_state1="无固定期劳动合同(参编职工)";
				} else if("6"==model.new_job_state){
					new_job_state1="岳阳事业部编内";
				}   else {
					new_job_state1="";
				}
				//技术职称
				var new_jszc = model.new_jszc;
				if("yjygjgcs"==new_jszc)
				{
					new_jszc = "研究员级高级工程师";
				}
				else if("gjgcs"==new_jszc)
				{
					new_jszc = "高级工程师";
				}
				else if("gcs"==new_jszc)
				{
					new_jszc = "工程师";
				}
				else if("zlgcs"==new_jszc)
				{
					new_jszc = "助理工程师";
				}
				else if("jsy"==new_jszc)
				{
					new_jszc = "技术员";
				}
				else if("gjjjs"==new_jszc)
				{
					new_jszc = "高级经济师";
				}
				else if("jjs"==new_jszc)
				{
					new_jszc = "经济师";
				}
				else if("zljjs"==new_jszc)
				{
					new_jszc = "助理经济师";
				}
				else if("gjkjy"==new_jszc)
				{
					new_jszc = "高级会计师";
				}
				else if("zlkjy"==new_jszc)
				{
					new_jszc = "助理会计师";
				}
				else if("kjy"==new_jszc)
				{
					new_jszc = "会计员";
				}else{
					new_jszc = "";
				}
				
				//名录ID
				userids.push(model.directoryid);
			jQuery("#gridTable").jqGrid('setRowData', ids[i], {
				viewrole: be,
				new_user_type:new_user_type1,
				new_job_state:new_job_state1,
				new_jszc:new_jszc
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
			<%if(isROLE==true){%>
					"<input type='button' class='but_y_01' title='持证导出Excel表格' value='持证导出' onclick='exportFile()'/>"+
		          "<input type='button' class='but_y_01' title='持证导入Excel表格'  value='持证导入' onclick='openImport()'/>"+
		          "<input type='button' class='but_y_01' title='培训导出Excel表格' value='培训导出' onclick='exportTrainFile()' />"+
		          "<input type='button' class='but_y_01' title='培训导入Excel表格' value='培训导入' onclick='openTrainImport()'/>"+
		          "<input type='button' class='but_y_01' title='打印' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');  value='打印' onclick='printHolderAndTrain()'/>"
             <%}else{%>
                "<input type='button' class='but_y_01' title='打印' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01');  value='打印' onclick='printHolderAndTrain()'/>"
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

/**
 * 人员持证导出
 */
function exportFile(){
	
    var url = "ajaxholdinfoexcel.jsp";
    var html = new Array();
    html.push("<div id='export_excel'>");
    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
    html.push("<input type='hidden' name='userids' value='"+userids.join()+"' /> ");
    html.push("<input type='hidden' name='parent_id' value='<%=parent_id%>' /> ");
    html.push("<input type='hidden' name='parmjson' value='"+toUserParamJosn()+"' /> ");
    
    html.push('</form>');
    html.push("</div>");
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body");
    jQuery("#downFrom").submit();
    jQuery("#export_excel").remove();
}

/**
 *  打开人员持证导入excel页面,
 */
function openImport() {
    openAlertWindows('windowId', getCurrentFilePath()+'holderexcelimport.jsp',
            '导入excel表格', '455px', '70%', '10%', '40%', function() {
                location.reload();
            });
}

/**
 * 人员培训导出
 */
function exportTrainFile(){
    var url = "ajaxtrainexcel.jsp";
    var html = new Array();
    html.push("<div id='export_excel'>");
    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
    html.push("<input type='hidden' name='userids' value='"+userids.join()+"' /> ");
    html.push("<input type='hidden' name='parent_id' value='<%=parent_id%>' /> ");
    html.push("<input type='hidden' name='parmjson' value='"+toUserParamJosn()+"' /> ");
    html.push('</form>');
    html.push("</div>");
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body");
    jQuery("#downFrom").submit();
    jQuery("#export_excel").remove();
}

/**
 *  打开人员培训导入excel页面,
 */
function openTrainImport() {
    openAlertWindows('windowId', getCurrentFilePath()+'trainexcelimport.jsp',
            '导入excel表格', '455px', '70%', '10%', '40%', function() {
                location.reload();
            });
}

/**
 * 打印持证和培训记录
 */
function printHolderAndTrain(){
    var url = "printHolderAndTrain.jsp";
    var html = new Array();
    html.push("<div id='export_excel'>");
    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
    html.push("<input type='hidden' name='userids' value='"+userids.join()+"' /> ");
    html.push("<input type='hidden' name='parent_id' value='<%=parent_id%>' /> ");
    html.push("<input type='hidden' name='parmjson' value='"+toUserParamJosn()+"' /> ");
    html.push('</form>');
    html.push("</div>");
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body");
    jQuery("#downFrom").submit();
    jQuery("#export_excel").remove();
}

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
		var politics="" ; //政治面貌
		var orgid ="" ; //所在单位
		var hold_name="";//持证项目
		var new_user_type="";//人员类别
		var new_job_state="";//在岗状态
		
		var radio = $("[name=radio]:checked").val();
			if("undefined" != $("#directorylevel").val()){
				directorylevel = $("#directorylevel").val();
			}
			if("undefined" != $("#politics").val()){
				politics = $("#politics").val();
			}
			if("undefined" != $("#orgid").val()){
				orgid = $("#orgid").val();
			}
		 if($("[name=radio]:checked")){
		 	if(typeof(radio)=="undefined"){
		 		radio="";
		 	}else{
		    department = radio ;
		 	}
		  }
		 //持证管理
		 if("undefined" != $("#hold_name").val()){
			 hold_name = $("#hold_name").val();
		 }
		//人员类别
		 if("undefined" != $("#new_user_type").val()){
			 new_user_type = $("#new_user_type").val();
		 }
		//在岗状态
		 if("undefined" != $("#new_job_state").val()){
			 new_job_state = $("#new_job_state").val();
		 }
		 
	var str = "{'orgid':'<%=orgid %>','userid':'<%=userid%>','likevalue':'" + searchInputValue + "','nameindex':'" +nameindex + "','listtype':'view','department':'"+department+
		"','directorylevel':'"+directorylevel+
		"','new_job_state':'"+new_job_state+
		"','new_user_type':'"+new_user_type+
		"','persionHold_name':'"+hold_name+
		"','directoryname':'"+jQuery("#directoryname").val()+ //姓名
		"','hold_ratify_starttime':'"+jQuery("#hold_ratify_starttime").val()+ //姓名
		"','hold_ratify_endtime':'"+jQuery("#hold_ratify_endtime").val()+ //姓名
		"','orgids':'"+orgid+"','politics':'"+politics+"'}";
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
	var mes = "查看人员信息";
	//系统管理员或部门管理员
	openAlertWindows('windowId007',getCurrentFilePath() +'updatedirectoryinfo.jsp?windowsId=windowId&typeid='+ model.directoryid+'&urls=have',mes,820,650,'16%','25%');
}
/**
 * 选取机构
 */
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
	<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
	<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
		<tr>
			<td>
				<!-- 固定查询 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
					<tr>
						<td width="60px" >持证项目：</td>
						<td class="cx_title_td" >
							<input name="hold_name"  id="hold_name"  style="float:left;" type="text" value="" class="input_cx_title_240" />
	                   		<input name="btn_Search" id="btn_Search" style="float:left; margin-left:5px;"  class="but_y_01" type="button" value="搜索"/>
						</td>
						<td width="385">
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
						<td width="60px" >人员类别：</td>
						<td align="left">
							<P id="pid1" style="position: absolute;margin: 0;z-index:1;width: 180px">
							    <select style="width: 190px;" name="new_user_type" id="new_user_type">
								    <option value="">--请选择--</option>
								    <option value="bnzg">编内职工</option>
								    <option value="bwzg">编外职工</option>
								    <option value="txzg">退休职工</option>
								</select>
							</P>&nbsp;
						</td>
					</tr>
					<tr id="zgzt" >
						<td width="60px">在岗状态：</td>
						<td align="left" >
							<select style="width: 190px;" name="new_job_state" id="new_job_state">
							    <option value=''>--请选择--</option>
								<option value='1'>编内在岗职工</option>
								<option value='2'>省院内部借调职工</option>
								<option value='3'>质监系统借调职工</option>
								<option value='4'>在编不在岗职工</option>
								<option value='5'>无固定期劳动合同(参编职工)</option>
								<option value='6'>岳阳事业部编内</option>
							</select>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable"   >
				    <tr>
						<td width="60px">工作部门：</td>
						<td align="left">
					   		 <input name="orgname"  id="orgname"  style="float:left;" type="text" class="input_cx_title_188" onclick="chooseOrg();"/>
					   		 <input name="orgid"  id="orgid"  type="hidden" />
						</td>
					</tr>
					<tr style="height: 5px;"></tr>
					 <tr>
						<td width="60px">&nbsp;&nbsp;&nbsp;&nbsp;姓名：</td>
						<td align="left">
					   		 <input name="directoryname"  id="directoryname"  style="float:left;" type="text" class="input_cx_title_188"/>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable"   >
					<tr>
				 		<td width="100px;">初次取证日期：</td>
						<td align="left">
						    <input name="hold_ratify_starttime"  id="hold_ratify_starttime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="float:left;" type="text" class="input_cx_title_188" />
						</td>
						<td>至</td>
						<td align="left" >
						    <input name="hold_ratify_endtime"  id="hold_ratify_endtime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="float:left;" type="text" class="input_cx_title_188" />                        
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