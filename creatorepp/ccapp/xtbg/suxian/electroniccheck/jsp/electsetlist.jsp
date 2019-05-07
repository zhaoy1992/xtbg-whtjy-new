<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.pub.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.entity.ElectInfoBean"%>
<%@page import="com.chinacreator.xtbg.suxian.electroniccheck.dao.ElectInfoDao"%>
<%@page import ="java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
AccessControl accesscontroler = AccessControl.getInstance();

accesscontroler.checkAccess(request, response);
String userid=accesscontroler.getUserID();
String sql = "select i.status_name,i.status_name from sx_ta_oa_electcheck_state i ";
String work_sys="1";
String end_sys="0";
String infotypeHtml="";
infotypeHtml= DictDropDownList.buildSelect(sql,"electstate","","",true,"");//信息类型下拉框
//String sql = "select i.infotype_id,i.infotype_name from ta_oa_briefs_infotype i ";
//String infotypeHtml = DictDropDownList.buildSelect(sql,"infotype_id","","",true,"");
String currenttime= new SimpleDateFormat("yyyy-MM-dd").format(new Date());
ElectInfoBean electInfoBean = new ElectInfoBean();
electInfoBean.setDatetime(currenttime);
electInfoBean.setUserid(userid);
ElectInfoBean electInfoBean1 = new ElectInfoBean();
ElectInfoDao electInfoDao = (ElectInfoDao)DaoImplClassUtil.getDaoImplClass("electInfoDaoImpls");
boolean flag=electInfoDao.findButtonState(currenttime,userid);//判断电子考勤控制按钮表是否有数据,如果为true,说明已插入数据
if(flag){
	electInfoBean1=electInfoDao.isAddOrUpdate(electInfoBean);//查询当前日期的考勤基本信息
	if(!StringUtil.nullOrBlank(electInfoBean1.getStart_time())){//如果考勤上班时间不为空
		electInfoDao.updateButtonState(userid, "1", "0");//置灰上班按钮
	}
	if(!StringUtil.nullOrBlank(electInfoBean1.getEnd_time())){//如果下班时间不为空	
		electInfoDao.updateButtonState(userid,"1","1");
	}
	 if(StringUtil.nullOrBlank(electInfoBean1.getStart_time())&&StringUtil.nullOrBlank(electInfoBean1.getEnd_time())){
		if(!"请假".equals(electInfoBean1.getState()) ){ //请假
		   electInfoDao.updateButtonState(userid,"0","1");
		}
	} 
	electInfoBean=electInfoDao.getButtonStateInfo(currenttime, userid);//查询按钮控制表中当前用户在当天是否有数据
	if(StringUtil.isBlank(electInfoBean.getWork_sys())){
		work_sys="0";//获得上班标识
	}else{
		work_sys=electInfoBean.getWork_sys();
	}
	if(StringUtil.isBlank(electInfoBean.getEnd_sys())){
		end_sys="1";//获得下班标识
	}else{
		end_sys=electInfoBean.getEnd_sys();//获得下班标识
	}
	
}
else{
	electInfoDao.addButtonState(currenttime, userid);//给电子考勤控制按钮表添加数据
	work_sys="0";//上班按钮为可点击
	end_sys="1";//下班按钮置灰
}

%>
<title>JGRID</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入my97时间控件 -->
<script src="../../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>  

<!-- 引入其它 -->
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
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
			electSearch();
		}
		
	
	});
	
	

	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=electSetList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
		
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
		colNames: ['编号', '单位名称 ', '上班时间','下班时间'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			name: 'elect_id',
			index:'elect_id',
			 hidden: true
			//editable: true
		},
		{
			name: 'orgname',
			index: 'orgname',
			width: 220,
			editable: true
		},
		{
			name: 'start_time',
			index: 'start_time',
			width: 60,
			editable: true
		},
		{
			name: 'end_time',
			index: 'end_time',
			width: 70,
			editable: true
		}
		],
		sortname: 'start_time',
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
		
			}
var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
for (var i = 0; i < ids.length; i++) {
	var cl = ids[i];
	var model = jQuery("#gridTable").jqGrid('getRowData', cl);
	
	
}
		},
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		//定义页码控",
		//设置Grid表格的标题，如果未设置，则标题区域不显示。
		search : toElectParamJosn(),
		
		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		//判断上下班按钮是否置灰
	    toolbar: [ true,"top","<input class='but_y_01' id='work' type='button' onclick='addStarttime()' value='增加' />"+
	               "<input class='but_y_01' id='workdel' type='button' onclick='delelect()' value='删除' />"
	               ],
	   
 
	
		multiselect: true,

		onCellSelect:function(id,iCol){
				if(iCol != 0 )
				{	
					updateworkip(id);
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
	 函数:  toBriefsParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
	var toElectParamJosn = function() {
		var str = "{'orgname':'" + $("#serchorgname").val()+"'}";
		return descape(escape(str));
	}

	/*
	 函数:  electSearch
	 说明:  查询信息
	 参数:   无
	 返回值: 列表
	 */
	var electSearch = function() {
		var sdata = { //构建查询需要的参数 
			
		}; //获得当前postData选项的值  
		var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		$.extend(postData, sdata);
		$("#gridTable").jqGrid("setGridParam", {
			search : true,
			userFilters:toElectParamJosn()
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
				paramJson: toBriefsParamJosn()
			};
			var postData = $("#gridTable").jqGrid("getGridParam", "postData");
			$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
			$("#gridTable").jqGrid("setGridParam", {
				search: true // 将jqGrid的search选项设为false  
			}).trigger("reloadGrid", [{
				page: 1
			}]);
	};

	/*
	 函数:  resetSingleSearchDialog
	 说明:  清空值查询值
	 参数:   无
	 返回值: 无
	 */
	var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  
		$(":text", "#queryTable").val("");
		$(":hidden", "#queryTable").val("");
		$("select").each(function(){
			$(this).find("option:first").attr("selected","selected");
		})
	};

	/*
	 函数:  addStarttime
	 说明:  添加考勤上班信息
	 参数:   无
	 返回值: 无
	 */
	var addStarttime = function() {
		 //openAlertWindows('windowId','../../../suxian/electroniccheck/jsp/electronicreset.jsp','添加考勤设置',500,145,'25%','25%');
		window.location.href="../../../suxian/electroniccheck/jsp/electronicreset.jsp";
	}
	/*
	 函数:  leave
	 说明:  请假
	 参数:   无
	 返回值: 无
	 */
	var leaveInfo = function() {
		//特检院OA 【请假】按钮的功能改为：点击即跳转到【新增考勤流程】页面。
		var url ="<%=path%>/ccapp/xtbg/tjy/attendancemanage/jsp/newattendanceflowmain.jsp";
		openWindows("windowId",window,url,'windowId',false,window);
		/* var areThere ="";
		var okF = function(){
			var date = new Date();

			var  sdate = date.getDate();
			if(sdate<10){
				sdate ="0"+date.getDate();
			}
			date = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+sdate;

			
			var ids = $("#gridTable").getDataIDs(); 
 			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				if(model.datetime==date){
					areThere = "Y" ;
				}
			}	
 		
			document.all.form1.target = "hiddenFrame";
			$('#form1').attr("action","addorupdateworktimedo.jsp?areThere="+areThere);
			$('#form1').submit(); 
			
		}
		var p={
			headerText:'提示',
			okName:'确认',
			okFunction:okF,
			cancelName:'取消'
			};
		alert("是否确定请假",p) */
	}
	/*
	 函数:  addEndtime
	 说明:  添加考勤下班信息
	 参数:   无
	 返回值: 无
	 */
	var addEndtime = function() {
		 openAlertWindows('windowId','../../../suxian/electroniccheck/jsp/addEndtime.jsp','添加下班时间',500,145,'25%','25%');

	}
	

	var updateworkip = function(id) {
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
		var url = "../../../suxian/electroniccheck/jsp/electronicreset.jsp?elect_id="+model.elect_id;
		//openAlertWindows('windowId',url,'更新办公IP',500,245,'25%','25%');
		location.href = url;
	}
	
	/*
	 函数:  delelect
	 说明:  删除考勤设置
	 参数:   无
	 返回值: 无
	 */
	var delelect = function() {
		// var url = "isaddorupdate.jsp?action=del";
		 var ids = "";
		 var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		 for ( var i = 0; i < selectedIds.length; i++) {
			var model = $("#gridTable").jqGrid('getRowData',selectedIds[i]);
			if ("" != ids) {
				ids += ",";
			}
			ids +=  model.elect_id ;
		 }
		if (IsSpace(ids)) {
			alert("请选择要删除的未发布或者已撤销记录！");
		} else {
			var okF = function(){	
				$("#ids").val(ids);
				var fm = document.getElementById("form1");
				//fm.action=url;
				fm.target = "hiddenFrame";
				fm.submit();}
				var p={
						headerText:'提示',
						okName:'确认',
				        okFunction:okF,
				        cancelName:'取消'
				};
				alert("确定要删除该信息吗？",p)
		}
	 }

</script>
</head>
<body>
	<form id="form1" method="post"  action="isaddorupdate.jsp">
	<input type="hidden" id="ids" name="ids" value=""/>
	<input type="hidden" id="action" name="action" value="del"/>
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
								<th width="90" class="input_cx_title_th" >单位名称：</th>
							<td width="296"  class="cx_title_td">
								<input  type="text" class="input_cx_title_283" id="serchorgname" name="serchorgname"/>
							</td>
							<td width="385"  colspan="3"  >
							<input name="Input2" value="搜索" type="button" onclick="electSearch()" class="but_y_01"/>
							<!-- <span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span></td> -->
									</tr>
						</table>
						<!-- 固定查询 end-->
					</td>
					</tr>
						<tr>
					<td>
					
						<!-- 隐藏查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" id="hiddenArea" style="display:none">
							<!-- 正规 4列 -->
							<tr>
							
							<th class="input_cx_title_th">日期：</th>
							<td  class="cx_title_td"><input class="date_120  Wdate" 
								 type="text" id="create_time"
								name="create_time" 
								class="date_187" onclick="WdatePicker()" /> 
							</td>
					
								
						</tr>


	</table>
	</td></tr></table>
	</td></tr></table>
		<!-- 查询列表区 cGridArea(查询区样式)-->
	<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
	</div>
	<!-- 查询列表区 -->

	</div>
</form>	
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>