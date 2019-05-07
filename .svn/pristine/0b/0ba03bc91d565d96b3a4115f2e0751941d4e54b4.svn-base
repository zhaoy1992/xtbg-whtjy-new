<%--
　　描述：档案管理--档案移交-列表
　　作者：邹拓
　　版本：1.0
　　日期：2013-9-16
--%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileFilesDevolveBean"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
	AccessControl controler = AccessControl.getAccessControl();
	controler.checkAccess(request, response);
	//获取页面基础数据
	String path = request.getContextPath();
	UserCacheBean userBean= UserCache.getUserCacheBean(controler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	String f_org_id = userBean.getUnit_id();
	//WJZH初始化
    String wjzhTime = DateUtil.getCurrentYear();
    if(wjzhTime==null){
    	wjzhTime = "2013";
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- 公共部分开始 -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"></script>
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script	type="text/javascript" src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"></script>
<script type="text/javascript" src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/util/public.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
	$(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
    });
	initTable();
});

var initTable = function(){
	$("#gridTable").jqGrid({
    	gridComplete: function(){},
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FileFilesDevolveList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : '移交标题',
            name : 'f_title',
            index : 'f_title',
            width:200
        }, {
        	label : '档案起止日期',
            name : 'f_begin_end_time',
            index : 'f_begin_end_time',
            width:150
        }, {	
            label :'本次移交的卷数',
            name : 'f_num',
            index : 'f_num',
            width:80
        }, {
            label : "档案接收单位",
            name : 'f_receive_org_name',
            index : 'f_receive_org_name',
            width:120
        }, {
            label : "登记日期",
            name : 'f_log_time',
            index : 'f_log_time',
            width:80
        }, {
            label : "登记人",
            name : 'f_log_user_name',
            index : 'f_log_user_name',
            width:60
        }, {	
            label : "f_devolve_id",
            name : 'f_devolve_id',
            index : 'f_devolve_id',
            hidden:true
        }, {
            label : "移交状态",
            name : 'f_state',
            index : 'f_state_show',
            formatter : function(value){
            	if (value=='<%=FileFilesDevolveBean.STATE_TWO%>'){
            		return "已移交";
            	}else{
            		return "暂存";
            	}
          	},
            width:60
        },{	
            label : "f_state",
            name : 'f_state',
            index : 'f_state',
            hidden:true
        }
        ],
        sortname : 'f_log_time',
        //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
        sortorder : 'desc',
        //设置是否在Pager Bar显示所有记录的总数。
        viewrecords : true,
        
        rowNum : 10,
        //用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
        rowList : [ 10, 20, 30 ],//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
        jsonReader : { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
            repeatitems : false
        },
        //定义页码控制条Page Bar
        pagerintoolbar:true,//上面的分页条
        pagerinBottombar:true,//下面的分页条
    
        //设置Grid表格的标题，如果未设置，则标题区域不显示。
        search : toUserParamJson(),
        prmNames : { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
            rows : "rows",
            //表示请求行数的参数名称  
            sort : "sidx",
            //表示用于排序的列名的参数名称  
            order : "sord",
            //表示采用的排序方式的参数名称 
            search : "search"
        },
       	toolbar : [ true, "top" ,"<input value='添加' type='button' onclick='add()' class='but_y_01' onMouseOver=\"javascript:$(this).attr('class','but_y_02');\" onMouseOut=\"javascript:$(this).attr('class','but_y_01');\"/>"+
       	"<input value='删除' type='button' onclick='deleteFn()' class='but_y_01' onMouseOver=\"javascript:$(this).attr('class','but_y_02');\" onMouseOut=\"javascript:$(this).attr('class','but_y_01');\"/>"],
       	multiselect : true, 
        onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
				var model = jQuery("#gridTable").jqGrid('getRowData', id);
        		update('',model);
			}
		}
    });
};

var search = function() {
    var sdata = {
        paramJson : toUserParamJson()
    }; //获得当前postData选项的值  
    var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
    $.extend(postData, sdata);
    $("#gridTable").jqGrid("setGridParam", {
        search : true
    // 将jqGrid的search选项设为true  
    }).trigger("reloadGrid", [ {
        page : 1
    } ]); //重新载入Grid表格，以使上述设置生效 
};

var clearclear = function(){
	jQuery('#f_year').val("");
	search();
};

var toUserParamJson = function(){
	var f_year = $('#f_year').val();
	var f_org_id = '<%=f_org_id%>';
	var str = "{";
	str += "'f_year':'"+f_year+"',";
	str += "'f_org_id':'"+f_org_id+"'";
	str += "}";
	return descape(escape(str));
};

var add = function (){
	var url = "<%=path%>/ccapp/oa/file/jsp/filefilesdevolveinfo.jsp";
	url += "?actionName=insert";
	url += "&windowId=addFileFilesDevolveBean";
	openAlertWindows('addFileFilesDevolveBean',url, '添加移交记录' ,1020,530,'10%','10%');
}

var update = function(id,bean) {
	if(id){
		var url = "<%=path%>/ccapp/oa/file/jsp/filefilesdevolveinfo.jsp";
		url += "?actionName=update";
		url += "&f_devolve_id="+id;
		url += "&windowId=updateFileFilesDevolveBean";
		openAlertWindows('updateFileFilesDevolveBean',url, '修改移交记录' ,1020,530,'10%','10%');
	}
	if(bean){
		var id = bean.f_devolve_id;
		if(bean.f_state=='<%=FileFilesDevolveBean.STATE_ONE%>'){
			var url = "<%=path%>/ccapp/oa/file/jsp/filefilesdevolveinfo.jsp";
			url += "?actionName=update";
			url += "&f_devolve_id="+id;
			url += "&windowId=updateFileFilesDevolveBean";
			openAlertWindows('updateFileFilesDevolveBean',url, '修改移交记录' ,1020,530,'10%','10%');
		}else{
			var url = "<%=path%>/ccapp/oa/file/jsp/filefilesdevolveinfo.jsp";
			url += "?actionName=query";
			url += "&f_devolve_id="+id;
			url += "&windowId=updateFileFilesDevolveBean";
			openAlertWindows('updateFileFilesDevolveBean',url, '查看已移交记录' ,1020,530,'10%','10%');
		}
	}
}

var deleteFn = function(){
	var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
	if(selectedIds.length>0){
		deleteList = '';
		canDelete = true;
		for (var i = 0; i < selectedIds.length; i++){
			model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
			if(model.f_state=='<%=FileFilesDevolveBean.STATE_TWO%>'){
        		canDelete = false;
        		break;
        	}
			deleteList+=model.f_devolve_id+",";
		}
		if(canDelete){
			okF = function(){
				jQuery("#hidden_delete").val(deleteList);
				jQuery("#secordFrom").attr("target","filefilesdevolvelistJSPhiddenFrame");
				jQuery("#secordFrom").submit();
			};
			var p={headerText:'提示',okName:'确认',okFunction:okF,cancelName:'取消'};
			alert("删除后将不能恢复，确定删除吗？",p);
		}else{
			alert("已移交数据不能删除");
		}
	}else{
		alert("请选择数据");
	}
	
	
}

afterSubmitFn=function(result){
	try{
		alert(result);
		search();
	}catch(e){alert(e.description);}
}
</script>
</head>


	<body>
		<div>
			<table id="queryTable" width="100%" border="0" cellspacing="0"
				cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="tabs_search_ctable">
							<tr>
								<th class="input_cx_title_th" style="width: 70px;">
									移交年份：
								</th>
								<td width="200" class="cx_title_td">
									<input id="f_year" name="f_year" style="width: 200px"
										class="date_120" type="text" 
										onfocus="WdatePicker({dateFmt:'yyyy',maxDate:'<%=wjzhTime%>-01-01'})" />
								</td>
								<td width="60">
									<input value="搜索" id="sel" type="button" onclick="search();"
										class="but_y_01" />
									<input value="重置" id="reset" type="button" class="but_y_01"
										onclick='clearclear()' />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<div class="cGridArea">
				<table id="gridTable"></table>
				<div id="gridPager"></div>
			</div>
		</div>

<form id="secordFrom" name="secordFrom" method="post" action="filefilesdevolveinfodo.jsp">
<input type='hidden' name='action' id="hidden_action_two" value="deleteFilesdevolve"/>
<input type='hidden' name='delete' id="hidden_delete"/>
</form>

<iframe id="filefilesdevolvelistJSPhiddenFrame" name="filefilesdevolvelistJSPhiddenFrame" width=0 height=0></iframe>
	</body>
</html>