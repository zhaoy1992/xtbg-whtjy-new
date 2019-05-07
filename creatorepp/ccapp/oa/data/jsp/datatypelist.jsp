<%--
描述：知识库资料分类管理查询列表页面(index内右)
作者：肖杰
版本：1.0
日期：2013-08-19
--%>
<%@page import="com.chinacreator.xtbg.core.data.entity.DataTypeBean"%>
<%@page import="com.chinacreator.xtbg.core.data.service.impl.DataTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.data.service.DataTypeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String GET_LIST_CLASS="com.chinacreator.xtbg.core.data.list.DataTypeList";
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	String d_type_unit_id = StringUtil.deNull(userBean.getUnit_id());
	String d_type_unit_name = StringUtil.deNull(userBean.getUnit_name());
	String d_type_id = request.getParameter("d_type_id");
	String d_type_level = request.getParameter("d_type_level");
	Map<String,String> parentBean = null;
	String parent_d_type_id = "";
	String parent_d_type_level = "";
	if(d_type_id!=null&&d_type_id.length()>0){
		DataTypeService service=new DataTypeServiceImpl();
		parentBean = service.getDataTypeBean(d_type_id);
		parent_d_type_id = d_type_id;
		parent_d_type_level = StringUtil.deNull(parentBean.get("d_type_level"));
	}
	boolean canEdit = true;
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- 引入formvValidatetion -->
	<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script src="../../resources/js/util/public.js" type="text/javascript"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<!-- 引入jGrid -->
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
</head>
<body style="overflow-x: auto;">
<%--query table begin--%>
<table width="100%">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <th class="input_cx_title_th" style="width:120px;">资料分类名称：</th>
                    <td class="cx_title_td" style="width:150px;">
                        <input id="d_type_name" name="d_type_name" type="text" style="width:150px;" class="input_cx_title_283" />
                    </td>
                    <th class="input_cx_title_th" style="width:10px;">&nbsp;</th>
                    <td>
                    	<input value="搜索" type="button" onclick="refreshGrid()" class="but_y_01" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<script>
/*
 函数:  refreshGrid
 说明:  静态加载列表数据，主要供子页面调用和删除字段后调用
 参数:   无
 */
function refreshGrid() {
	var sdata = { //构建查询需要的参数 
		paramJson : toParamJosn()
	}; //获得当前postData选项的值  
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
	jQuery.extend(postData, sdata);
	jQuery("#gridTable").jqGrid("setGridParam", {
		search : true
	// 将jqGrid的search选项设为true  
	}).trigger("reloadGrid", [ {
		page : 1
	} ]); //重新载入Grid表格，以使上述设置生效
}
jQuery(function() {
	if('2'=='<%=d_type_level%>'){
		jQuery("#AddOne").hide();
		jQuery("#AddTwo").hide();
		jQuery("#Update").hide();
		jQuery("#Delete").hide();
	}
});
</script>
<%--query table end--%>
<table width="100%" style="margin-left: 0" class="tabs_search_ctable_box">
	<%if(canEdit){%>
	<tr>
		<td width="100%" align="left" valign="top">
			<input id="AddOne" name="AddOne" value="增加中间层分类" type="button" onclick="btnClickFn(this)" class="but_y_06" /><span style="width:5px;display:block;float:left;">&nbsp;</span>
			<input id="AddTwo" name="AddTwo" value="增加最底层分类" type="button" onclick="btnClickFn(this)" class="but_y_06" /><span style="width:5px;display:block;float:left;">&nbsp;</span>
			<input id="Update"  name="Update" value="修改" type="button" onclick="btnClickFn(this)" class="but_y_06" /><span style="width:5px;display:block;float:left;">&nbsp;</span>
			<input id="Delete"  name="Delete" value="删除" type="button" onclick="btnClickFn(this)" class="but_y_06" />
			<script>
			btnClickFn = function(btnObj){
				try{
					btnObj.disabled=true;
					flag = btnObj.name;
					if(flag==='AddOne'){
						urlTmp="&d_type_level=<%=DataTypeBean.D_TYPE_LEVEL_ONE%>&actionName=insert&d_type_parent_id=<%=parent_d_type_id%>";
						toNewPage(urlTmp,btnObj.value);
					}else if(flag==='AddTwo'){
						parentLevel = '<%=parent_d_type_level%>';
						if(parentLevel=='<%=DataTypeBean.D_TYPE_LEVEL_ONE%>'){
							urlTmp="&d_type_level=<%=DataTypeBean.D_TYPE_LEVEL_TWO%>&actionName=insert&d_type_parent_id=<%=parent_d_type_id%>";
							toNewPage(urlTmp,btnObj.value);
						}else{
							alert("请选中左侧的'中间层分类'");
						}
					}else if(flag==='Delete'){
						var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
						if(selectedIds.length>0){
							var p={
								headerText:'提示',
								okName:'确认',
							    okFunction:function(){
								    deleteList = '';
									for ( var i = 0; i < selectedIds.length; i++){
										model = jQuery("#gridTable").jqGrid('getRowData',
										selectedIds[i]);
										deleteList+=model.d_type_id+",";
									}
									$("#hidden_action").val("deleteDataTypeInfo");
									$("#hidden_delete").val(deleteList);
									$("#onlyFrom").submit();
							    },
							    cancelName:'取消'
								};
							alert("你确定要删除该信息？",p);
						}else{
							alert("请选择要删除的数据");
						}
					}else if(flag==='Update'){
						selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
						count = selectedIds.length;
						if(count==1){
							model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[0]);
							urlTmp = "?d_type_id="+model.d_type_id+"&actionName=update";
							openWindows('filetypeinfoJSP','','datatypeinfo.jsp'+urlTmp,'','','','','');
						}else{
							alert("请选择一条数据");
						}
					}
					btnObj.disabled=false;
				}catch(e){btnObj.disabled=false;}
			};
			toNewPage = function (urlTmp,pageName){
				pageCode = "filetypeinfoJSP";
				baseUrl = "datatypeinfo.jsp?subid="+pageCode;
				if(urlTmp){
					baseUrl = baseUrl+urlTmp;
				}
				openWindows(pageCode,pageName,baseUrl,pageCode,false,window);
			};
			<%--提交后回调--%>
			afterSubmitFn=function(result){
				try{
					alert(result);
					window.parent.tomainjsp("<%=path%>/ccapp/oa/data/jsp/datatype.jsp?d_type_id=<%=d_type_id%>");
				}catch(e){alert(e.description);}
			}
			</script>
		</td>
	</tr>
	<%}%>
	<tr>
		<td width="100%" align="left" valign="top">
		<div style="float:left;width:100%;margin-left: -10px" class="cGridArea">
			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
		<script>
		function toParamJosn(){
			var d_type_name = jQuery("#d_type_name").val();
			var str = "{'d_type_unit_id':'<%=d_type_unit_id%>','d_type_id':'<%=d_type_id%>','d_type_name':'"+d_type_name+"'}";	
			return escape(str);
		}
		jQuery(function() {
			$(document).keydown(function(){
				if(event.keyCode == 13){ 
					refreshGrid();
			    }
			});
			
		$("#gridTable").jqGrid({
			url: '<%= path %>' + '/pubListServlet?classNameId=<%=GET_LIST_CLASS%>',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
			colNames: ['资料分类名称','分类层次','排序号','登记人','登记时间','d_type_id'],
			//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
			colModel: [ //最重要的数组之一，用于设定各列的参数
		        {
		        	name: 'd_type_name',index: 'd_type_name',width: '200px',sortable:false
				},
				{
					name: 'd_type_level',index: 'd_type_level',width: '150px',sortable:false,formatter:'select',
					editoptions:{value:"1:中间层;2:最底层"}
				},
				{
					name: 'd_type_order',index: 'd_type_order',width: '100px',	sortable:false
				},
				{
					name: 'd_type_user_name',index: 'd_type_user_name',width: '150px',sortable:false
				},
				{
					name: 'd_type_create_time',index: 'd_type_create_time',width: '180px',sortable:false
				},
				{
					name: 'd_type_id',index: 'd_type_id',sortable:false,hidden:true
				}
			],
			sortname: 'd_type_order',
			//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
			sortorder: '',
			viewrecords: true,
			
			//设置是否在Pager Bar显示所有记录的总数。
			rowNum: 10,
			//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
			rowList: [10, 20, 30],
			//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
			gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
				
			},
			jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
				repeatitems: false
			},
			//pager: "#gridPager",
			pagerintoolbar:true,//上面的分页条
			pagerinBottombar:true,//下面的分页条
			//定义页码控制条Page Bar
			//caption: "草稿箱",
			//设置Grid表格的标题，如果未设置，则标题区域不显示。
			search : toParamJosn(),
			prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
				rows: "rows",
				//表示请求行数的参数名称  
				sort: "sidx",
				//表示用于排序的列名的参数名称  
				order: "sord",
				//表示采用的排序方式的参数名称 
				search : "search"
			},
			multiselect: <%=canEdit%>,
			
			onCellSelect:function(rowid,iCol){
				if(iCol>0){
					var model = jQuery("#gridTable").jqGrid('getRowData', rowid);
					urlTmp = "?d_type_id="+model.d_type_id+"&actionName=update";
					openWindows('filetypeinfoJSP','','datatypeinfo.jsp'+urlTmp,'','','','','');
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
		</script>
		</td>
	</tr>
</table>
<form id="onlyFrom" name="onlyFrom" method="post" action="datatypeinfodo.jsp" target="filetypelisthiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<input type='hidden' name='delete' id="hidden_delete"/>
</form>
<iframe name="filetypelisthiddenFrame" width=0 height=0></iframe>
</body>
</html>