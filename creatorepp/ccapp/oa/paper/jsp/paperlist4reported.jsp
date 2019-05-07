<%--
　　描述：已上报信息
　　作者：黄海
　　日期：2013-09-11
--%>
<%@page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.paper.util.PaperConstants"%>
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
    String userid = controler.getUserID();
    UserCacheBean usercachebean=UserCache.getUserCacheBean(userid);
    String repunit=usercachebean.getUnit_id();//上报单位
    String repunitname=usercachebean.getUnit_name();
    
    
  	//下拉框  选中的id由bean存的值确定
    String p_rep_title_dictType = "infotype";//信息类型
    String p_rep_title_selectHtml = DictDropDownList.buildSelect4DictType(p_rep_title_dictType,"p_rep_type_id" ,  "", "" , true, "" ,"" ,"class='validate[required] select_240' style='width: 138px;height:24px;'","" );

    //信息状态flag
    String strWhere = " and (d.dictdata_value='"+PaperConstants.STATUS_PENDING+"' or d.dictdata_value='"+PaperConstants.STATUS_UNACCEPT+"' or d.dictdata_value='"+PaperConstants.STATUS_ACCEPT+"') ";
    String sql = "select d.dictdata_value, d.dictdata_name, d.dictdata_id from oa_dict_data d, oa_dict_type t where 1=1 "+strWhere+" and t.dict_id = d.dict_id and d.dictdata_is_valid='1' and t.dict_is_valid='1' and t.dict_code = 'infoflag' order by d.dictdata_order desc";
    String p_flag_id_selectHtml = DictDropDownList.buildSelect4Sql(sql,"p_rep_flag_id" ,  "", "" , true, "" ,"" ,"class='validate[required] select_240' style='width: 138px;height:24px;'","" );

%>
<title>已上报信息列表</title>
<!-- 公共部分开始 -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"            type="text/javascript"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"   type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"  type="text/javascript"></script>
<script src="../../resources/util/public.js"                       type="text/javascript"></script>
<script src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"     type="text/javascript"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js"   type="text/javascript"></script>
<script src="../resources/js/paperpublic.js"                       type="text/javascript"></script>
<script type="text/javascript">
var userid = '<%=userid%>';
var opentype ="reported";
var repunit="<%=repunit%>";
var repunitname="<%=repunitname%>";
//搜索框的控制对象
$(function() {
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
    });
    
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.paper.list.PaperList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "信息标题",
            name : 'p_rep_title',
            index : 'p_rep_title',
            width: '450'
        }, {	
            label : "p_rep_type_id",
            name : 'p_rep_type_id',
            index : 'p_rep_type_id',
			hidden:true
        }, {	
            label : "信息类型",
            name : 'p_rep_type_name',
            index : 'p_rep_type_name',
            width: '100'
        }, {	
            label : "上报时间",
            name : 'p_rep_time',
            index : 'p_rep_time',
            width: '200',
            formatter:getFormatterDate
        }, {	
            label : "信息状态",
            name : 'p_rep_flag_name',
            index : 'p_rep_flag_name',
            width: '100'    
        }, {	
            label : "p_rep_flag_id",
            name : 'p_rep_flag_id',
            index : 'p_rep_flag_id',
            hidden:true
        }, {	
            label : "p_manage_id",
            name  : 'p_manage_id',
            index : 'p_manage_id',
            hidden:true
        }
        ],
        sortname : 'p_rep_time',
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
       	multiselect : true, 
        onCellSelect:function (id,icol)
		{
        	if(icol != 0)
			{
				var model = jQuery("#gridTable").jqGrid('getRowData', id);
        		urlTmp = "&loadurl=paperlist4reported&actionName=update&p_manage_id="+model.p_manage_id;
				toNewPage(urlTmp,"修改");
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
        var str = "{'opentype':'"+opentype
        	+"','p_rep_title':'"+jQuery("#p_rep_title").val()
        	+"','p_rep_type_id':'"+jQuery("#p_rep_type_id").val()
        	+"','p_rep_time':'"+getWhere4Date()
        	+"','p_rep_flag_id':'"+jQuery("#p_rep_flag_id").val()
        	+"','p_rep_unit_id':'"+repunit
        	+"'}";
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
    

//提交后回调
var afterSubmitFn=function(result){
	try{
		alert(result);
		window.location.href="<%=path%>/ccapp/oa/paper/jsp/paperlist4reported.jsp";
	}catch(e){alert(e.description);}
}
</script>
</head>
<body>
<div>
	<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
        <tr>
            <td>
	            <!-- 固定查询 -->
	            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
	               <tr>
	                   <th width="90" class="input_cx_title_th">信息标题：</th><!-- 敏感字符的问题 -->
	                   <td width="200" class="cx_title_td">
	                       <input type="text" id="p_rep_title" name="p_rep_title" class="input_cx_title_283" style="width:133px;"/>
	                   </td>
	                   <th width="90" class="input_cx_title_th">信息类型：</th>
	                   <td width="200" class="cx_title_td" style="padding-left:5px;">
	                   <%=p_rep_title_selectHtml %>
	                   </td>
	                   <th width="90" class="input_cx_title_th">信息状态：</th>
	                   <td width="200" class="cx_title_td">
             	           <%=p_flag_id_selectHtml %>
	                   </td>
	               </tr>
	               <tr>
	                   <th width="90" class="input_cx_title_th">上报日期：</th>
	                   <td width="200" class="cx_title_td" colspan=3 >
	                   <input id="begin_time"
								name="begin_time"
								onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'end_time\')}',dateFmt:'yyyy-MM-dd'})"
								style="float: left" class="date_120 Wdate" type="text" /><span
								style="float: left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至：&nbsp;&nbsp;&nbsp;&nbsp;</span> <input
								class="date_120 Wdate" type="text" id="end_time" name="end_time"
								onfocus="WdatePicker({minDate:'#F{$dp.$D(\'begin_time\')}',dateFmt:'yyyy-MM-dd'})" />
	                   </td>
	                   <td >
	                       <input value="搜索" id="sel" type="button" onclick="search();" class="but_y_01" />
	                   </td>
	               </tr>
	            </table>
	            <!-- 固定查询 end-->
            </td>
        </tr>
    </table>
    
    <table width="100%" style="margin-left: 0" class="tabs_search_ctable_box">
		<tr>
			<td width="100%" align="left" valign="top">
				<input name="AddOne" value="新建" type="button" onclick="btnClickFn(this)" class="but_y_01" /><span style="width:5px;display:block;float:left;">&nbsp;</span>
			</td>
		</tr>
		<tr>
			<td width="100%" align="left" valign="top">
			<div style="float:left;width:100%;margin-left: -10px" class="cGridArea">
				<table id="gridTable"></table>
				<div id="gridPager"></div>
			</div>
			</td>
		</tr>
	</table>
    
    
</div>
</body>
</html>