<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.*"%>   
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	AccessControl controler = AccessControl.getAccessControl();
	controler.checkAccess(request, response);
	String path = request.getContextPath();
	//获得当前登录用户的id
	String userId = controler.getUserID();
	UserCacheBean usercachebean = UserCache.getUserCacheBean(userId);

	String orgId = usercachebean.getUnit_id();//accesscontroler.getChargeOrgId();//用户所属机构id
	//会议模板状态 0：暂存，1：发布
	String flag = StringUtil.deNull(request.getParameter("flag"));
	//父窗口id
	String windowId = StringUtil.deNull(request
			.getParameter("windowId"));
	//没有传入，则设置为1
	flag = StringUtil.nullOrBlank(flag) ? "1" : flag;
%>
<title>会议模板暂存列表</title>
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
    src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
//当前登录用户所属的机构id
var userId = "<%=userId%>";
var orgId = "<%=orgId%>"; 
//会议模板状态
var flag = "<%=flag%>";
//搜索框的控制对象
var control = new defaultValueControl('请输入会议模板标题','#m_title');
$(function() {
    //初始化 
    control.init();
    
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
        });
    
    jQuery("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.meeting.list.MeetingNoticeList4Minutes', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
        //表头设置       
        colModel : [
            {
                label : "会议标题",
                name : 'm_title',
                index : 'm_title',
                editable : false,
                
                width:300
            }, {
                label : "会议开始时间",
                name : 'm_begin_time',
                index : 'm_begin_time',
                editable : false 
            }, {
                label : "会议id",
                name : 'm_notice_id',
                index : 'm_notice_id',
                editable : false,
                hidden : true
            }
        ],
        sortname : 'm_begin_time',
        //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
        sortorder : 'desc',
        //设置是否在Pager Bar显示所有记录的总数。
        viewrecords : true,        
        rowNum : 10,
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
        //toolbar : [ true, "top"],
        multiselect : false,
        onCellSelect:function (id,iCol)
        {           
             var model = jQuery("#gridTable").jqGrid('getRowData', id);
             choose(model.m_title,model.m_begin_time,model.m_notice_id);           
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
       var str = "{'m_create_unit_id':'" + orgId
                 + "','m_title':'" + control.val() + "','m_receiver_user_ids':'" + userId                           
                 + "'}";
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
       var postData = jQuery("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
       jQuery.extend(postData, sdata);
       jQuery("#gridTable").jqGrid("setGridParam", {
           search : true
       // 将jqGrid的search选项设为true  
       }).trigger("reloadGrid", [ {
           page : 1
       } ]); //重新载入Grid表格，以使上述设置生效 
    }

    
    /*
    函数:  choose
    说明:  choose
    参数:  无
    返回值: 无
    */
    var choose = function(title,beginTime,noticeId) {
        try{
	       	var parentWindow = getParentWindow("<%=windowId%>");
	       	parentWindow.jQuery("#m_title").val(title);
	       	parentWindow.jQuery("#m_notice_id").val(noticeId);
	       	parentWindow.jQuery("#m_begin_time").val(beginTime);  
	        removeAlertWindows("<%=windowId%>", true);
		} catch (e) {
			/**忽略异常信息**/
		}
	}
</script>
<!-- 公共部分结束 -->
</head>
<body>
<div>
    <table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box" style="margin-left:10px;">
        <tr>
            <td>
            <!-- 固定查询 -->
                 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
                    <tr>
                        <td class="cx_title_td" >
                            <input type="text" id="m_title" name="m_title" class="input_cx_title_283" style="width:150px;"/>&nbsp;
                            <input value="搜索" id="sel" type="button" onclick="search();" class="but_y_01" />
                        </td>
                    </tr>
                </table>
            <!-- 固定查询 end-->
            </td>
        </tr>
    </table>
    
    <!-- 查询列表区 cGridArea(查询区样式)-->
    <div class="cGridArea" style="margin-left:8px;">
        <table id="gridTable"></table>
        <div id="gridPager"></div>
    </div>
</div>
</body>
</html>