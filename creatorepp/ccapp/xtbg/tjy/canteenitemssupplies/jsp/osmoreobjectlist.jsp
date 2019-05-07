<%--
描述：易耗品库存列表界面
作者：童佳
版本：1.0
日期：2014-03-09
--%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	 //获得当前登录的用户信息
	String userId = accesscontroler.getUserID();
	String userName = accesscontroler.getUserName();
	//获得当前登录用户所属单位信息
	UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
	String unit_id = usercachebean.getUnit_id();
	String unit_name = usercachebean.getUnit_name();
	String loginUserName = accesscontroler.getUserAccount();
	
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
	if(rolesNames.indexOf("食堂物品管理员")!=-1){
		StrRoles = "rkUser";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- 引入jQuery -->
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery1.7/jquery-1.7.1.min.js"></script>

<script src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>


<!-- 引入my97时间控件 -->
<script src="<%=path%>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<script src="<%=path%>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript"></script>
<script src="<%=path%>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript"></script>

<!-- 引入其它 -->
<script src="<%=path%>/ccapp/oa/resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js" ></script>
<title>易耗品库存列表</title>

<script type="text/javascript">
var loginUserName = '<%=loginUserName%>';
$(function() {
	
	var _documentBodyHeight = window.top.findPageCacheName("_documentBodyHeight");
	var width=jQuery(window).width();
	if(width<880){
		jQuery("#maindiv").width(775);
	}
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			userSearch();
		}
	
	});
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.tjy.canteenitemssupplies.list.OsHavaMoreList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		colNames: ['库存id','物品ID','物品名称','物品类型ID','物品类型名称','规格ID','规格名称 ','单价','数量','入库时间'],
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
           {
   			name: 't_ha_id',
   			index: 't_ha_id',
   			width: '0',
   			hidden: true
   		},
   		{
   			name: 'ofustype_id',
   			index: 'ofustype_id',
   			width: '0',
   			hidden: true
    	},
		{
			name: 'ofustype_name',
			index: 'ofustype_name',
			width: '40',
			search: true
		},
   		{
   			name: 'oftype_id',
   			index: 'oftype_id',
   			width: '0',
   			hidden: true
    	},
		{
			name: 'oftype_name',
			index: 'oftype_name',
			width: '40',
			search: true
		},
   		{
   			name: 'it_id',
   			index: 'it_id',
   			width: '0',
   			hidden: true
    	},
		{
			name: 'it_name',
			index: 'it_name',
			width: '40',
			search: true
		},
    	{
   			name: 't_ha_dj',
   			index: 't_ha_dj',
   			width: '40',
			search: true
    	},
    	{
   			name: 't_ha_no',
   			index: 't_ha_no',
   			width: '40',
			search: true
    	},
		{
			name: 't_ha_buydate',
			index: 't_ha_buydate',
			width: '100',
			search: true
		}
		],
		//sortname: 'last_updatetime',
		//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
		sortname: 't_ha_buydate',
		sortorder: 'desc',
		viewrecords: true,
		
		//设置是否在Pager Bar显示所有记录的总数。
		rowNum: 10,
		//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
		rowList: [10, 20, 30],
		//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
		gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
			var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			
		},
		
		jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
			repeatitems: false
		},
		//pager: "#gridPager",
		//定义页码控制条Page Bar
		//caption: "待办列表",
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
		/*
		filterNames:["act_name"],
		filterOptions:[
		               [
		                ["xd","name"],[2,"page"],[3,"daf"]],//value text 后的值与显不
		                [
		                 ['王奎',"王奎"],["马坤","马坤"],["文电科","文电科"]
		                 ]
		               ],
		filterOptionsDefValue:[1,2],*/
		pagerintoolbar:true,//上面的分页条
		pagerinBottombar:true,//下面的分页条
		toolbar: [true,"top",
		          <%if("rkUser".equals(StrRoles)){%>
		         	// "<input class='but_y_01' id=add value='入库' type='button' onclick='addLevel()'/><input class='but_y_06' id=add value='办公用品申购审批表' type='button' onclick='newosxaFlow()'/>"
		          "<input class='but_y_06' id=add value='食堂物品申购表' type='button' onclick='newosxaFlow()'/>"
		          <%}%>
		          ],
		multiselect: true,
		onSelectRow: function(id) {
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


/*
函数:  clearSearch
说明:  重置
参数:   无
返回值: 无
*/
var clearSearch = function() {
var sdata = {
	paramJson: descape(escape("{'username':'"+loginUserName+"'}"))
};
var postData = $("#gridTable").jqGrid("getGridParam", "postData");
$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
$("#gridTable").jqGrid("setGridParam", {
	search: true // 将jqGrid的search选项设为false  
}).trigger("reloadGrid", [{
	page: 1
}]);
resetSingleSearchDialog();
};

	/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toUserParamJosn = function() {
		 var str = "{'t_ha_iswhat':'2','ofustype_name':'"+jQuery("#ofustype_name").val()
 		+"','startSlTime':'"+jQuery("#startSlTime").val()+"','endSlTime':'"+jQuery("#endSlTime").val()+"','unit_id':'<%=unit_id%>'}";
	return descape(escape(str));
}

/*
函数:  resetSingleSearchDialog
说明:  清空值查询值
参数:   无
返回值: 无
*/
var resetSingleSearchDialog = function() { //$("radio","#singleSearchDialog").attr("checked", false);  

}

function addLevel(id){   
	var path ="<%=path%>/ccapp/xtbg/tjy/canteenitemssupplies/jsp/osmoreobjectinfo.jsp?windowsId=windowIds1";
	openAlertWindows('windowIds1',path,'易耗品入库',1024,768,'25%','25%');
}


function newosxaFlow(){
	var url="<%=path%>/ccapp/xtbg/tjy/canteenitemssupplies/jsp/osexamination.jsp?busiTypeCode=uuid_521";
	var flowname="食堂物品申购审批表";
	var width = jQuery(window.top).width();//界面宽度
	var height = jQuery(window.top).height();//界面高度
	url= url+"&height="+height;
	url= url+"&width="+width;
	url= url+"&windowsId=windowIdList";
	//弹出款TOP下移，空出标签页及以上位置，165为TOP图片高度，暂时写死，应该是根据TOP的页面高度去动态获取
	openAlertWindows('windowIdList',url,flowname,width,height-86,86,'0%','','',true);
	
}

</script>
</head>
<body>
<table width="100%" id="queryTable">
	<tr>
		<td>
						
			<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box" >
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
							<tr>
								<th class="input_cx_title_th">物品名称：</th>
								<td width="385" class="cx_title_td"><input id="ofustype_name" name="ofustype_name" type="text" class="input_cx_title_283" /></td>
								<td width="385"  colspan="2"  ><input name="Input2" value="搜索" type="button" onclick="userSearch()" class="but_y_01"/>
								<span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span></td>
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
								<th class="input_cx_title_th">入库时间：</th>
								<td  class="cx_title_td">
								<input id="startSlTime" name="startSlTime" type="text" class="date_120"　
								onFocus="var input_endtime=$dp.$('endSlTime');WdatePicker({onpicked:function(){endSlTime.focus();},dateFmt:'yyyy-MM-dd '})"   /> 
								<span class="date_120_span">至</span>
								 <input id="endSlTime" name="endSlTime" type="text"  class="date_120" 
								 onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startSlTime\')}',dateFmt:'yyyy-MM-dd '})" />
								</td>
							</tr>
						</table>
						<!-- 隐藏查询 end-->
						
					</td>
				</tr>
			</table>
		<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
						
		</td>
		</tr>

		<tr>
			<td>
					<div id="maindiv" class="cGridArea" style="overflow: auto;">
						<table id="gridTable"></table>
						<div id="gridPager"></div>
					</div>
					<!-- 查询列表区 -->
			</td>
		</tr>	

</body>
</html>