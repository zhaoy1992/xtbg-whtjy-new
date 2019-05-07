<%--
　　描述：知识库文档发布列表 --已阅读
　　作者：黄海
　　版本：1.0
　　日期：2014-04-08
--%>
<%@page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
  	//主键ID
    String k_doc_id = request.getParameter("k_doc_id");
    String k_create_user = controler.getUserID();
    UserCacheBean usercachebean=UserCache.getUserCacheBean(k_create_user);
    String k_unit=usercachebean.getUnit_id();//单位
    String k_unit_name=usercachebean.getUnit_name();
%>
<title>知识库文档已阅读列表</title>
<!-- 公共部分开始 -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入提示 与tree -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script src="../resources/js/kbmdoc.js" type="text/javascript"></script>
<script type="text/javascript">
//搜索框的控制对象
$(function() {
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
    });
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.kbm.list.KbmDocUserReadList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "机构名称",
            name : 'k_receiveruser_orgname',
            index : 'k_receiveruser_orgname',
            hidden : true
        }, {	
            label : "联系人",
            name : 'k_receiver_username',
            index : 'k_receiver_username'
        }, {	
            label : "阅读时间",
            name : 'k_creator_time',
            index : 'k_creator_time'
        }, {	
            label : "联系电话",
            name : 'user_mobiletel1',
            index : 'user_mobiletel1'
        }
        ],
        sortname : 'o.k_creator_time',
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
				
			}
		}
    });
    
});
   
/*
    函数:  toUserParamJosn
    说明:  构建要查询的参数
    参数:   无
    返回值: 返回要查询的参数
 */
var toUserParamJosn = function() {
    var str = "{'k_doc_id':'<%=k_doc_id%>'}";
    return descape(escape(str));
}

/*
	 函数:  search
	 说明:  查询
	 参数:   无
	 返回值: 
 */
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

/*
函数:  clear
说明:  重置
参数:   无
返回值: 
*/
var clearParamJosn = function(){
    //清空输入框的值
   jQuery("input[type=text]").val("");
   jQuery("#k_type_id").val("");
   //查询
   search();
}

/**
 * 导出
 */
function exportExcel(){
	var url = getCurrentFilePath()+"/ajaxexcel4kbmdoc.jsp?"
    +"windowId=windowId_paperTJ&sJson="+toUserParamJosn();      
    jQuery('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>'+
           '<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">'+
           '</form>').appendTo("body").submit().remove();
}
</script>
</head>
<body>
<div>
    <!-- 查询列表区 cGridArea(查询区样式)-->
    <div class="cGridArea">
        <table id="gridTable"></table>
        <div id="gridPager"></div>
    </div>
</div>
</body>
</html>