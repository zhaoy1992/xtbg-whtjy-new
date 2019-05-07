<%--
　　描述：档案管理--待归档管理--列表
		显示两部分的内容:
			一是从公文归档过来的记录（状态0：未提交），
			一是从“部门文件接收”模块退回的记录（状态1：退回）。状态为（2：已提交  3、已接收）的不显示。
		需求变更太大,代码结构已经很复杂,显示的两部分内容做到两个页面之中1,filedocdetailforarchive.jsp,2,filedocdetailforarchivetwo.jsp
		操作者:公文拟稿人
　　作者：邹拓
　　日期：2014-04-24
	参数 ：null
--%>
<%@page import="com.chinacreator.xtbg.core.file.util.ModuleUtil"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<%@taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
	AccessControl controler = AccessControl.getAccessControl();
	controler.checkAccess(request, response);
	String userId = controler.getUserID();
	String role = ModuleUtil.checkRoleForGWDGD(userId);
	
	String path = request.getContextPath();
	
	UserCacheBean userBean = UserCache.getUserCacheBean(controler.getUserID());
	if (userBean == null) {
		userBean = new UserCacheBean();
	}
	String f_unit_id = userBean.getUnit_id();
	String f_unit_name = userBean.getUnit_name();
	String f_org_id = userBean.getOrg_id();
	String f_org_name = userBean.getOrg_name();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<!-- 公共部分开始 -->
		<script type="text/javascript"
			src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
		<!-- 引入jQuery UI -->
		<script
			src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
			type="text/javascript"></script>
		<!-- 引入jGrid -->
		<link rel="stylesheet" type="text/css" media="screen"
			href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
		<script
			src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
			type="text/javascript"></script>
		<script
			src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
			type="text/javascript"></script>
		<!-- 引入其它 -->
		<script type="text/javascript"
			src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"
			charset="utf-8"></script>
		<script src="../../resources/util/public.js" type="text/javascript"></script>
		<script type="text/javascript"
			src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"
			charset="utf-8"></script>
		<script src="../../resources/plug/My97DatePicker/WdatePicker.js"
			type="text/javascript"></script>
<script type="text/javascript">
var cleara = function(){
	$('#f_title').val("");
	$('#f_file_no').val("");
	search();
}

var updateFileDocDetail = function(bean) {
	if(bean.datahome=='0'){
		openAlertWindows('updateFileDocDetailWindow', getCurrentFilePath() +'filedocdetailforarchive.jsp?id='+bean.f_id+'&windowId=updateFileDocDetailWindow', '公文归档' ,1020,520,'10%','10%');
	}else{
		openAlertWindows('updateFileDocDetailWindow', getCurrentFilePath() +'filedocdetailforarchivetwo.jsp?id='+bean.f_id+'&windowId=updateFileDocDetailWindow'+'&fj='+bean.fj+'&gongwen_id='+bean.gongwen_id+'&f_flow_state='+bean.f_flow_state, '公文归档' ,1020,520,'10%','10%');
	}
}
var search = function() {
      var sdata = { //构建查询需要的参数 
          paramJson : toUserParamJosn()
      }; //获得当前postData选项的值  
      var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
      $.extend(postData, sdata);
      $("#gridTable").jqGrid("setGridParam", {
          search : true
      // 将jqGrid的search选项设为true  
      }).trigger("reloadGrid", [ {
          page : 1
      } ]); //重新载入Grid表格，以使上述设置生效 
}
var toUserParamJosn = function() {
	<%if(role.equals(ModuleUtil.ROLE_DWDAGLY)){%>
		var str = "{";
		str += "'f_org_id':'<%=f_unit_id%>',";
		//==================by lian.qiu 2015-01-14 start
		str += "'f_dept_id':'<%=f_org_id%>',";
		str += "'f_title':'"+$('#f_title').val()+"',";
		str += "'f_file_no':'"+$('#f_file_no').val()+"',";
		str += "}";
	<%}else if(role.equals(ModuleUtil.ROLE_DWDAGLY)){%>
		var str = "{";
		str += "'f_org_id':'<%=f_unit_id%>',";
		str += "'f_dept_id':'<%=f_org_id%>',";
		str += "'f_title':'"+$('#f_title').val()+"',";
		str += "'f_file_no':'"+$('#f_file_no').val()+"',";
		str += "}";
	<%}else{%>
		var str = "{";
		str += "'f_org_id':'<%=f_unit_id%>',";
		str += "'f_dept_id':'<%=f_org_id%>',";
		str += "'f_create_user_id':'<%=userId%>',";
		str += "'f_title':'"+$('#f_title').val()+"',";
		str += "'f_file_no':'"+$('#f_file_no').val()+"',";
		str += "}";
	<%}%>
	return descape(escape(str));
}

//搜索框的控制对象
$(function() {
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
    });
    
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FileDocBeforeArchiveList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [
        {
            label : "f_id",
            name : 'f_id',
            index : 'f_id',
            hidden : true
        }, {
        	label : "标题",
        	width:120,
            name : 'f_title',
            index : 'f_title'
        }, {	
            label : "文号",
            name : 'f_file_no',
            index : 'f_file_no',
            width:60
        }, {
            label : "所属机构",
            width:50,
            name : 'f_org_name',
            index : 'f_org_name'
        }, {
            label : "归档(所属)部门",
            width:50,
            name : 'f_dept_name',
            index : 'f_dept_name'
        }, {
            label : "创建人",
            name : 'f_create_user_name',
            width:40,
            index : 'f_create_user_name'
        }, {
            label : "创建时间",
            name : 'f_create_date',
            width:40,
            index : 'f_create_date'
        }, {
            label : "提交状态",
            name : 'f_flow_state',
            width:40,
            index : 'f_flow_state',
            formatter:function(v){
            	var val_map={"0":"未提交","1":"已退回","2":"已提交","3":"已接收"};
            	var val1 = val_map[v];
            	if(val1){
            		return val1;
            	}else{
            		return "未提交";
            	}
            }
        }, {
            label : "f_archive_type_name",
            name : 'f_archive_type_name',
            index : 'f_archive_type_name',
            hidden : true
        }, {
            label : "datahome",
            name : 'datahome',
            index : 'datahome',
            hidden : true
        }, {
            label : "fj",
            name : 'fj',
            index : 'fj',
            hidden : true
        }, {
            label : "gongwen_id",
            name : 'gongwen_id',
            index : 'gongwen_id',
            hidden : true
        }, {
            label : "f_flow_state",
            name : 'f_flow_state',
            index : 'f_flow_state',
            hidden : true
        }
        ],
        sortname : 'f_create_date',
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
        search : toUserParamJosn(),
        prmNames : { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
            rows : "rows",
            //表示请求行数的参数名称  
            sort : "sidx",
            //表示用于排序的列名的参数名称  
            order : "sord",
            //表示采用的排序方式的参数名称 
            search : "search"
        },
       	toolbar : [ true, "top" ,""],
       	multiselect : false, 
        onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
				var model = jQuery("#gridTable").jqGrid('getRowData', id);
        		updateFileDocDetail(model);
			}
		}
    });
    
});
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
								<th class="input_cx_title_th" style="width: 50px;">
									标题：
								</th>
								<td width="100" class="cx_title_td">
									<input type="text" id="f_title" name="f_title" class="input_cx_title_283" style="width: 100px;" />
								</td>
								<th style="width: 50px;" class="input_cx_title_th">
									文号：
								</th>
								<td width="100" class="cx_title_td">
									<input type="text" id="f_file_no" name="f_file_no" class="input_cx_title_283" style="width: 100px;" />
								</td>
								<td width="60">
									<input value="搜索" id="sel" type="button" onclick="search();"
										class="but_y_01" />
									<input value="重置" id="reset" type="button" class="but_y_01"
										onclick='cleara()' />
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
		</div>
	</body>
</html>