<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.security.authorization.AuthRole"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	String n_type = StringUtil.deNull(request.getParameter("n_type"));//公告栏类型
	if(n_type.equals("")){
		n_type="0";//查询 【院内咨询】和【员工天地】
	}
	AuthRole authRoles[] = accesscontroler.getAllRoleofUser(accesscontroler.getUserAccount());
    String StrRoles= "";
    String rolesNames = "";
    StringBuffer buf = new StringBuffer();
    boolean flag_delbut = false;
    for(int i=0;i<authRoles.length;i++){
         buf.append(authRoles[i].toString()+ ",");
    }  
    rolesNames = buf.toString();
    if(rolesNames.length()>0){
         rolesNames = rolesNames.substring(0,rolesNames.length()-1);
    }
    if(rolesNames.indexOf("工作动态")!=-1){
         flag_delbut = true;
    }

%>
<title>已发布列表</title>
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
<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>

<script type="text/javascript">
$(function() {
	$(document).keydown(function(){
		if(event.keyCode == 13){ 
			noticeSearch();
		}
	});

	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.news.list.newsViewList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
		//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
		colModel: [ //最重要的数组之一，用于设定各列的参数
		{
			label:"公告ID",
			name: 'n_id',
			index: 'n_id',
			hidden: true
		},
		
		{
			label:"标题",
			name: 'n_title',
			index: 'n_title',
			width: 340,
			editable: true
		},
		{
			label:"发布部门",
			name: 'n_org_name',
			index: 'n_org_name',
			width: 80,
			sortable: false
			
		},
		{
			label:"发布时间",
			name: 'n_date',
			index: 'n_date',
			width: 100
		}
		<% if(flag_delbut){%>
			 ,
			{
				label:"操作",
				name: 'act',
				index: 'act',
				width: 100
			}
		<%}%>
		],
		sortname: 'n_date',
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
				tt = "<span onclick=veiwNotice("+cl+") >"+model.n_title+"</span>";
				be = "<input type='button' class='but_y_01'  onclick='deleteNews("+cl+")' value = '删除' />";
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					<% if(flag_delbut){%>
						act: be,
					<%}%>
					n_title:tt
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
		search : toNoticeParamJosn(),

		prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
			rows: "rows",
			//表示请求行数的参数名称  
			sort: "sidx",
			//表示用于排序的列名的参数名称  
			order: "sord",
			//表示采用的排序方式的参数名称 
			search : "search"
		},
		//toolbar: [true,"top","<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=qxfb type='button' value='取消发布' onclick='cacelRelease()'/>"],
		multiselect: true
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		refresh: false,
		search: false
	});

	
});

/*
函数:  veiwNotice
说明:  查看通知公告信息
参数:   无
返回值: 无
*/
var veiwNotice = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	location.href="newsview.jsp?n_id="+ model.n_id;
}
/*
	 函数:  toNoticeParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */
var toNoticeParamJosn = function() {
		 var n_title = jQuery("#n_title").val();
		 var str = "{'n_title':'" + n_title
         + "'}";
	return descape(escape(str));
}

	/*
	 函数:  noticeSearch
	 说明:  查询用户信息
	 参数:   无
	 返回值: 用户列表
	 */
	var noticeSearch = function() {
		var sdata = { //构建查询需要的参数 
		}; //获得当前postData选项的值  
		var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		$.extend(postData, sdata);
		$("#gridTable").jqGrid("setGridParam", {
			search : true,
			userFilters:toNoticeParamJosn()
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
			paramJson : toNoticeParamJosn()
		};
		var postData = $("#gridTable").jqGrid("getGridParam", "postData");
		$.extend(postData, sdata); //将postData中的查询参数覆盖为空值  
		$("#gridTable").jqGrid("setGridParam", {
			search : true
		// 将jqGrid的search选项设为false  
		}).trigger("reloadGrid", [ {
			page : 1
		} ]);
	}
	function deleteNews(id){
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
		
		var json =  {
				n_id : model.n_id,
				action : "delete"
			};
			var okF = function() {
				var url = "newsreleasedo.jsp";
				jQuery.ajax({
					url : url,
					type : 'POST',
					dataType : 'json',
					data : json,
					async : true,
					success : function(flag) {
						if (flag) {
							alert("操作成功！");
							location.href="newsviewlist.jsp";
						} else {
							alert("操作失败！");
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("error:" + textStatus);
					}
				});
			};
			var p = {
				headerText : '提示',
				okName : '确认',
				okFunction : okF,
				cancelName : '取消'
			};
			alert("确定删除吗？", p);
	}


</script>
</head>
<body>
<div>
<table width="100%">
<input type="hidden" id="n_type" value="1">
	<tr>
		<td><!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="tabs_search_ctable_box">
			<tr>
				<td><!-- 固定查询 -->
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="tabs_search_ctable">
					<tr>
						<th width="90" class="input_cx_title_th">标题：</th>
						<td width="296" class="cx_title_td"><input
							class="input_cx_title_283" type="text" id="n_title" name="n_title" />
							</td>
						<td width="385" colspan="3"><input name="Input2" value="搜索"
							type="button" onclick="noticeSearch()" class="but_y_01" />
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea">
<table id="gridTable"></table>
<div id="gridPager"></div>
</div>
<!-- 查询列表区 --></div>
<form id="cacelReleaseForm" name="cacelReleaseForm" method="post" action="noticedo.jsp">
	<input type="hidden" name="calcel_n_notice_ids" id="calcel_n_notice_ids" /> 
	<input type="hidden" name="action" value="cacelRelease" />
</form>
<iframe name="hiddenFrame" width="0" height="0"></iframe>
</body>
</html>