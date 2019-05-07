<%--
　　描述：查阅情况——已阅读 
　　作者：黄海
　　版本：1.0
　　日期：2013-09-28
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    String k_create_user = controler.getUserID();
    String p_manage_id=request.getParameter("p_manage_id");
    String gridtitlename ="单位";
    String gridtitlename2="个人";
%>
<title>查阅情况——已阅读 </title>
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
<script type="text/javascript">
//搜索框的控制对象
$(function() {
    
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.paper.list.PaperReceiveInfoList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "p_receive_id",
            name : 'p_receive_id',
            index : 'p_receive_id',
            hidden : true
        },{
            label : "p_manage_id",
            name : 'p_manage_id',
            index : 'p_manage_id',
            hidden : true
        }, {	
            label : "单位名称",
            name : 'p_receive_unit_name',
            index : 'p_receive_unit_name',
            width: '350'
        }, {	
            label : "联系人",
            name : 'user_name',
            index : 'user_name',
            width: '100'
        }, {	
            label : "联系电话",
            name : 'user_phone',
            index : 'user_phone',
            width: '100'
        }, {	
            label : "阅读时间",
            name : 'p_read_time',
            index : 'p_read_time',
            width: '100'
        }
        ],
        sortname : 'p_read_time',
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
       	toolbar : [ true, "top" ],
       	multiselect : true, 
        onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
			}
		}
    });
    
    $("#gridTable2").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.paper.list.PaperReceiveInfoList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "p_receive_id",
            name : 'p_receive_id',
            index : 'p_receive_id',
            hidden : true
        },{
            label : "p_manage_id",
            name : 'p_manage_id',
            index : 'p_manage_id',
            hidden : true
        }, {	
            label : "单位名称",
            name : 'p_receive_unit_name',
            index : 'p_receive_unit_name',
            width: '350'
        }, {	
            label : "联系人",
            name : 'user_name',
            index : 'user_name',
            width: '100'
        }, {	
            label : "联系电话",
            name : 'user_phone',
            index : 'user_phone',
            width: '100'
        }, {	
            label : "阅读时间",
            name : 'p_read_time',
            index : 'p_read_time',
            width: '100'
        }
        ],
        sortname : 'p_read_time',
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
        search : toUserParamJosn2(),
        prmNames : { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
            rows : "rows",
            //表示请求行数的参数名称  
            sort : "sidx",
            //表示用于排序的列名的参数名称  
            order : "sord",
            //表示采用的排序方式的参数名称 
            search : "search"
        },
       	toolbar : [ true, "top" ],
       	multiselect : true, 
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
        var str = "{'p_manage_id':'<%=p_manage_id%>','p_read_status':'1','p_type_id':'1'}";
        return descape(escape(str));
    }
    var toUserParamJosn2 = function() {
        var str = "{'p_manage_id':'<%=p_manage_id%>','p_read_status':'1','p_type_id':'2'}";
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
    
  var search = function() {
      var sdata = { //构建查询需要的参数 
          paramJson : toUserParamJosn2()
      }; //获得当前postData选项的值  
      var postData = $("#gridTable2").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
      $.extend(postData, sdata);
      $("#gridTable2").jqGrid("setGridParam", {
          search : true
      // 将jqGrid的search选项设为true  
      }).trigger("reloadGrid", [ {
          page : 1
      } ]); //重新载入Grid表格，以使上述设置生效 
   }
 
</script>
</head>
<body>
<div>
	<div class="content_02_top" style="margin-left: 10px">
		<input class="but_y_01" type="button" value="关闭"
			onclick="removeAlertWindows('',true)" style="margin-left: 10px"/>
	</div>
	<div class="content_02_box_title_bg" style="margin-left: 10px;width: 100%">
		<span><%=gridtitlename%></span>
	</div>
    <!-- 查询列表区 cGridArea(查询区样式)-->
    <div class="content_02_box_div_special" style="width:99%" >
        <table id="gridTable"></table>
        <div id="gridPager"></div>
    </div>
    <div class="content_02_box_title_bg" style="margin-left: 10px;width: 100%">
		<span><%=gridtitlename2%></span>
	</div>
    <!-- 查询列表区 cGridArea(查询区样式)-->
    <div class="content_02_box_div_special" style="width:99%" >
        <table id="gridTable2"></table>
        <div id="gridPager"></div>
    </div>
</div>
</body>
</html>