<%--  
描述：公共通讯录界面
作者：戴连春
版本：1.0
日期：2013-06-13
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.personwork.entity.ListShowUtilBean"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.*"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.impl.*"%>

<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
String path = request.getContextPath();
String userId = accesscontroler.getUserID();
//机构id
String orgId = request.getParameter("orgid");

//个人通讯录操作的service对象
PersonInfoServiceIfc service = new PersonInfoServiceImpl();

//没有传入机构id，则查询根机构id
if (null == orgId){
    orgId = service.queryRootOrg();
}

//查询得到存在数据的首字母
List<ListShowUtilBean> firstCodeList = service.getFirstCodeShowInfo4PublicAddress(orgId);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>公共通讯录</title>

<!-- 引入jQuery -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"  href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/testcss.css" />

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"  src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"  src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"  src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/util/multiSelect.js"></script>



<script type="text/javascript">

var nameindex = "";//拼音首字母

var searchInputValue = "";//搜索框的值

var isInputSearchText = false;//是否正在在查询文本框中输入

var orgId = "<%=orgId %>";//机构id
var userId = "<%=userId %>";//用户id
var path  = "<%=path %>";//页面路径

$(function() {
	adaptationWH("","vcenter",65);
    // 监听回车键
    $(document).keydown(function() {
        if (event.keyCode == 13) {
            personSearch();
        }
    });
    var defaultSearchShow = "输入姓名、号码、邮箱、所在单位或者短号";
    // 字母搜索框添加点击事件
    $("#filters a").click(function(event) {
        if ($(this).html() == "全部") {
            nameindex = "";
            searchInputValue = "";
            $("#searchInput").val(defaultSearchShow);
            $("#searchInput").addClass("focus");
        } else {
            nameindex = $(this).html();
        }
        $("a").removeClass("onclicks");
        $(this).addClass("onclicks");
        personSearch();
    });

    // search按钮添加点击事件
    $("#btn_Search").bind('click', personSearch);

    // input输入框添加获得焦点事件
    $("#searchInput").focus(function() {
        isInputSearchText = true;
        if (IsSpace(searchInputValue)) {
            $("#searchInput").removeClass("focus");
            $("#searchInput").val("");
        }
    });

    // 修改属性时触发
    $("#searchInput").bind("propertychange", function() {
        if (isInputSearchText) {
            searchInputValue = $("#searchInput").val();
        }
    });

    // 失去焦点事件
    $("#searchInput").blur(function() {
        isInputSearchText = false;
        searchInputValue = $("#searchInput").val();
        if (IsSpace($("#searchInput").val())) {
            $("#searchInput").val(defaultSearchShow);
            $("#searchInput").addClass("focus");
        }
    });

    // table
    $("#gridTable")
            .jqGrid(
                    {
                        url : path + '/pubListServlet?classNameId' + '=com.chinacreator.xtbg.core.personwork.list.PublicAddressBook4RoleuserList', // servlet路径
                        datatype : "json",// 这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
                        mtype : "POST",// 定义使用哪种方法发起请求，GET或者POST
                        height : "100%",
                        autowidth : true,

                        // 字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
                        colModel : [ {
                            label : '名录id',
                            name : 'directoryid',
                            index : 'directoryid',
                            hidden : true
                        }, {
                            label : '姓名',
                            name : 'directoryname',
                            index : 'directoryname',
                            width : 120,
                            editable : true
                        },

                        {
                            label : '职务',
                            name : 'post',
                            index : 'post',
                            width : 120,
                            search : true
                        },
                        {
                            label : '办公手机',
                            name : 'mobile',
                            index : 'mobile',
                            width : 150,
                            search : true
                        }, {
                            label : '办公电话',
                            name : 'workphone',
                            index : 'workphone',
                            width : 150,
                            search : true
                        },

                        {
                            label : '住宅号码',
                            name : 'homephone',
                            index : 'homephone',
                            hidden : true,
                            hidden : true,
                            width : 150,
                            search : true
                        }, {
                            label : '短号',
                            name : 'remark4',
                            index : 'remark4',
                         /*    hidden : true,
                            hidden : true, */
                            width : 120,
                            search : true
                        }, {
                            label : '电子邮箱',
                            name : 'email',
                            index : 'email',
                            hidden : true,
                            hidden : true,
                            search : true
                        }, {
                            label : '备注',
                            name : 'remark5',
                            index : 'remark5',
                            width : 150,
                            search : true
                        }, {
                            label : '是否引用',
                            name : 'is_relation',
                            index : 'is_relation',
                            width : 100,
                            search : true,
                            hidden : true,
                            sortable : false
                        }, {
                            label : '有无权限',
                            name : 'viewrole',
                            index : 'viewrole',
                            search : true,
                            sortable : false,
                            hidden : true
                        }, {
                            label : '权限隐藏值',
                            name : 'ishasviewrole',
                            index : 'ishasviewrole',
                            hidden : true
                        } ],
                        sortname : '',
                        // 指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
                        sortorder : 'desc',
                        viewrecords : true,

                        // 设置是否在Pager Bar显示所有记录的总数。
                        rowNum : 10,
                        // 用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
                        rowList : [ 10, 20, 30 ],
                        // 一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
                        gridComplete : function() { // var
                                                    // idss=jQuery("#gridTable").jqGrid('getColNames');
                            // alert(idss);
                            $("#gridTable").setGridWidth(
                                    $(window).width() * 0.98);
                            var ids = $("#gridTable").getDataIDs(); // jqGrid('getDataIDs');
                            for ( var i = 0; i < ids.length; i++) {
                                var cl = ids[i];
                                var model = jQuery("#gridTable").jqGrid(
                                        'getRowData', cl);
                                if ("已引用" == model.is_relation) {
                                    be = "<IMG "
                                            + "style='POSITION: static; WIDTH: 18px; HEIGHT: 16px;' "
                                            + "src='../resources/images/yiyinyong.jpg'>";
                                } else if ("true" == model.ishasviewrole) {
                                    be = "<IMG "
                                            + "style='POSITION: static; WIDTH: 18px; HEIGHT: 16px;' "
                                            + "src='../resources/images/yiyinyong.jpg'>";
                                } else {
                                    be = "<IMG "
                                            + "style='POSITION: static; WIDTH: 18px; HEIGHT: 16px;' "
                                            + "src='../resources/images/weiyinyong.jpg'>";
                                }
                                jQuery("#gridTable").jqGrid('setRowData',
                                        ids[i], {
                                            is_relation : be,
                                            viewrole : be
                                        });

                            }
                        },
                        jsonReader : { // 这又是一个数组，用来设定如何解析从Server端发回来的json数据
                            repeatitems : false
                        },
                        // 设置Grid表格的标题，如果未设置，则标题区域不显示。
                        pagerintoolbar : true,// 上面的分页条
                        pagerinBottombar : true,// 下面的分页条
                        search : toUserParamJosn(),
                        prmNames : { // 这是一个数组，用于设置jqGrid将要向Server传递的参数名称
                            rows : "rows",
                            // 表示请求行数的参数名称
                            sort : "sidx",
                            // 表示用于排序的列名的参数名称
                            order : "sord",
                            // 表示采用的排序方式的参数名称
                            search : "search"
                        },
                        toolbar : [
                                true,
                                "top",
                                /**
                                 *暂时屏蔽添加以及导入人员到通讯录的功能
                                 *@alter by  戴连春
                                 *@alter date 2013-06-21
                                 */
                               // "<input type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_02'); value='添加' onclick='openSingleInput()'/>"
                               // + "<input type='button' class='but_excelgo_01' title='导入excel表格' onMouseOver=javascript:$(this).attr('class','but_excelgo_02'); onMouseOut=javascript:$(this).attr('class','but_excelgo_01'); value='' onclick='openImport()'/>"
                               "<input type='button' title='转存到个人通讯录' class='but_infoOut_01' onMouseOver=javascript:$(this).attr('class','but_infoOut_02'); onMouseOut=javascript:$(this).attr('class','but_infoOut_01'); value='' onclick='bindDirectToPersonal()' style='margin-left:5px;'/>"
                               +"<input type='button' class='but_excelout_01' title='导出excel表格' onMouseOver=javascript:$(this).attr('class','but_excelout_02'); onMouseOut=javascript:$(this).attr('class','but_excelout_01');  value='' onclick='exportFile()' style='margin-left:5px;'/>"
                                ],

                        multiselect : true,
                        beforeSelectRow : function(id, e) {
                            var $myGrid = $(this), i = $.jgrid.getCellIndex($(
                                    e.target).closest('td')[0]), cm = $myGrid
                                    .jqGrid("getGridParam", "colModel");
                            if (cm[i].name != 'cb') {
                                editPerson(id);
                            }
                            return (cm[i].name === 'cb');
                        }
                    }).navGrid('#gridPager', {
                edit : false,
                add : false,
                del : false,
                search : false,
                refresh : false
            });

    setSelect("#politics", "classinput1");
    setSelect("#directorylevel", "classinput2");

    
});

/**
 * 拼接查询条件
 */
var toUserParamJosn = function() {
    var department = ""; // 是否是党政一把手
    var directorylevel = ""; // 级别
    var politics = ""; // 政治面貌
    var orgname = ""; // 所在单位
    var radio = $("[name=radio]:checked").val();
    if ("undefined" != $("#directorylevel").val()) {
        directorylevel = $("#directorylevel").val();
    }
    if ("undefined" != $("#politics").val()) {
        politics = $("#politics").val();
    }
    if ("undefined" != $("#orgname").val()) {
        orgname = $("#orgname").val();
    }
    if ($("[name=radio]:checked")) {
        if (typeof (radio) == "undefined") {
            radio = "";
        } else {
            department = radio;
        }
    }
	//特检院OA 增加对【短号】字段的查询
    var siv = $("#searchInput").val() == "输入姓名、号码、邮箱、所在单位或者短号" ? "" : $(
            "#searchInput").val();
    var str = "{'orgid':'" + orgId + "','userid':'" + userId
            + "','likevalue':'" + siv + "','nameindex':'" + nameindex
            + "','listtype':'view','department':'" + department
            + "','directorylevel':'" + directorylevel + "','orgname':'"
            + orgname + "','politics':'" + politics + "'}";
    return descape(escape(str));
}

/*
 * 查询用户信息
 */
var personSearch = function() {
    var sdata = { // 构建查询需要的参数
        paramJson : toUserParamJosn()
    };// 获得当前postData选项的值

    var postData = $("#gridTable").jqGrid("getGridParam", "postData"); // 将查询参数融入postData选项对象
    $.extend(postData, sdata);
    $("#gridTable").jqGrid("setGridParam", {
        search : true
    // 将jqGrid的search选项设为true
            }).trigger("reloadGrid", [ {
        page : 1
    } ]); // 重新载入Grid表格，以使上述设置生效
}

/**
 * 刷新grid列表数据
 */
var refreshGrid4WfactionInfo = function() {
    var sdata = { // 构建查询需要的参数
        paramJson : toUserParamJosn()
    }; // 获得当前postData选项的值
    var postData = $("#gridTable").jqGrid("getGridParam", "postData"); // 将查询参数融入postData选项对象
    $.extend(postData, sdata);
    $("#gridTable").jqGrid("setGridParam", {
        search : true
    }).trigger("reloadGrid", [{
        page : 1
    }]); // 重新载入Grid表格，以使上述设置生效
}

/**
 * 编辑公共通讯录信息
 */
var editPerson = function(id) {
    var model = jQuery("#gridTable").jqGrid('getRowData', id);
    
    //如果拥有修改权限，才能修改公共通讯录的信息
    if ("true" == model.ishasviewrole) {
        openAlertWindows(
                'windowId',
                getCurrentFilePath()+'viewdirectory4publicaddress.jsp?typeid=' + model.directoryid + '&urls=have',
                '查看人员信息', 800, 360, '25%', '20%');
    }
}

/**
 * 将公共通讯录的数据绑定到个人通讯录
 */
function bindDirectToPersonal() {
    var ids = "";
    var tempArrs = [];
    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
    $(selectedIds).each(function() {
        var model = jQuery("#gridTable").jqGrid('getRowData', this);
        if (!IsSpace(model.directoryid))
            tempArrs.push(model.directoryid);
    })
    ids = tempArrs.join();
    if (IsSpace(ids)) {
        alert("请选择要绑定的记录！");
    } else {

        var okF = function() {
            var url = "binddirecttopersonal.jsp";
            var isUse = false;
            params = {
                userid : userId,
                directoryids : ids
            };
            $.ajax( {
                url : url,
                type : 'POST',
                dataType : 'json',
                data : params,
                success : function(data) {
                    //传回了返回值
                    if(data){
                        //操作成功
                       if(data.flag){
                           alert(data.msg);
                    	   refreshGrid4WfactionInfo();
                       }else{//操作失败
                           alert(data.msg);
                       }
                    }                      
                },
                error : function(jqXHR, textStatus, errorThrown) {
                    alert("操作失败！");
                }
            });
        }
        var p = {
            headerText : '提示',
            okName : '确认',
            okFunction : okF,
            cancelName : '取消'
        };
        alert("确定要绑定到个人通讯录吗？", p);
    }
}

/**
 * 导出
 */
function exportFile(){
    var url = "ajaxexcel.jsp";      
    var html = new Array();
    html.push("<div id='export_excel'>");
    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');

    html.push("<input type='hidden' name='parmjson' value='"+toUserParamJosn()+"' /> ");
    
    html.push('</form>');
    html.push("</div>");
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body");
    jQuery("#downFrom").submit();
    jQuery("#export_excel").remove();
}

/**
 *  打开导入excel页面
 */
function openImport() {
    openAlertWindows('windowId', getCurrentFilePath()+'addressbookimport.jsp',
            '导入excel表格', '455px', '70%', '10%', '40%', function() {
                location.reload();
            });
}
/**
 * 打开手工添加页面
 */
function openSingleInput() {
    openAlertWindows('windowId', getCurrentFilePath()+'singleInput.jsp', '添加',
            '455px', '173px', '20%', '40%', function() {
                location.reload();
            });
}
</script>
</head>
<body>
  <div id="vcenter" style="width:100%">
	<!-- 查询列表区 cGridArea(查询区样式)-->
	<div class="btn-bar" style="border-top: 1px solid #EAEAEA;">
		<div class="filters logClass" id="filters">
		<span style="width: 100px; color: #000">首字母查询：</span> 
		<a style="width: 30px;" href="javascript:void(0)">全部</a> 
		<%for(ListShowUtilBean showBean:firstCodeList){ 
		     if(showBean.isExsit){%> 
		     <a style="width: 20px;" title="<%=showBean.getFirstCode() %>" href="javascript:void(0)"><%=showBean.getFirstCode() %></a> 
		<%   }else{ %> 
		    <span style='width: 20px;'><%=showBean.getFirstCode() %></span> 
		<%   }
		  } %>
		</div>
	</div>
	
	
	<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
	<table id="queryTable" width="100%" border="0" cellspacing="0"
	    cellpadding="0" class="tabs_search_ctable_box">
	    <tr>
	        <td><!-- 固定查询 -->
	        <table width="100%" border="0" cellspacing="0" cellpadding="0"
	            class="tabs_search_ctable">
	            <tr>
	                <td width="60px">条件查询：</td>
	                <td class="cx_title_td">
		                <input name="search" id="searchInput" style="float: left;" type="text" value="输入姓名、号码、邮箱、所在单位或者短号"
		                    class="input_cx_title_240" /> 
		                <input name="btn_Search" id="btn_Search" style="float: left; margin-left: 5px;"
		                    class="but_y_01" type="button" value="搜索" />
	               </td>
	
	                <td width="385">
		                <span id="selAreaImg" class="all_search_condition">
		                  <a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')">更多搜索条件</a>
		                </span>
	                </td>	
	            </tr>
	        </table>
	        <!-- 固定查询 end--></td>
	    </tr>
	
	    <tr>
	        <td id="hiddenArea" style="display: none"><!-- 隐藏查询 -->
	        <table width="100%" border="0" cellspacing="0" cellpadding="0"
	            class="tabs_search_ctable">
	            <!-- 正规 4列 -->
	            <tr style="display:none;">
	                <td width="60px">政治面貌：</td>
	                <td align="left" width="348px">
		                <P id="pid1" style="position: absolute; margin: 0; z-index: 1; width: 200px">
			                <select id='politics' name='politics' class="redbost" multiple="multiple">
			                    <option value=""  type='checkbox' all='11'>&nbsp;全选</option>
			                    <option value='1' type='checkbox' name="option">&nbsp;中共党员</option>
			                    <option value='2' type='checkbox'>&nbsp;中共预备党员</option>
			                    <option value='3' type='checkbox'>&nbsp;共青团员</option>
			                    <option value='4' type='checkbox'>&nbsp;民革党员</option>
			                    <option value='5' type='checkbox'>&nbsp;民盟盟员</option>
			                    <option value='6' type='checkbox'>&nbsp;民建会员</option>
			                    <option value='7' type='checkbox'>&nbsp;民进会员</option>
			                    <option value='8' type='checkbox'>&nbsp;农工党党员</option>
			                    <option value='9' type='checkbox'>&nbsp;致公党党员</option>
			                    <option value='10' type='checkbox'>&nbsp;九三学社社员</option>
			                    <option value='11' type='checkbox'>&nbsp;台盟盟员</option>
			                    <option value='12' type='checkbox'>&nbsp;无党派民主人士</option>
			                    <option value='13' type='checkbox'>&nbsp;群众</option>
			                </select>
		                </P>
	                    &nbsp;
	                </td>
	                <td width="38px">级别：</td>
	                <td align="left">
		                <P id="pid2" style="position: absolute; margin: 0; z-index: 1; width: 200px">
			                <select name="directorylevel" id='directorylevel' class="redbost" multiple="multiple">
			                    <option value='' type='checkbox' all='22'>&nbsp;全选</option>
			                    <option value='副厅级' type='checkbox' name="option">&nbsp;副厅级</option>
			                    <option value='正处级' type='checkbox'>&nbsp;正处级</option>
			                    <option value='副处级' type='checkbox'>&nbsp;副处级</option>
			                    <option value='正科级' type='checkbox'>&nbsp;正科级</option>
			                    <option value='副科级' type='checkbox'>&nbsp;副科级</option>
			                    <option value='科员' type='checkbox'>&nbsp;科员</option>
			                    <option value='其他' type='checkbox'>&nbsp;其他</option>
			                </select>
		                </P>
		                &nbsp;
	                </td>
	            </tr>
	        </table>
	        <table width="100%" border="0" cellspacing="0" cellpadding="0"
	            class="tabs_search_ctable">
	            <tr>
	                <td width="60px">所在单位：</td>
	                <td align="left" width="342px" colspan="3">
		                <input name="orgname" id="orgname" style="float: left;" type="text"
		                    class="input_cx_title_188" />
	                </td>
	                <td width="100px" style="display: none"><!-- 隐藏查询 -->是否党政一把手：</td>
	                <td class="cx_title_td" style="display: none"><!-- 隐藏查询 -->
		                <input type="radio" name="radio" value="是 " /> 是 
		                <input type="radio" name="radio" value="否" /> 否
		                <input type="radio" name="radio" value="" checked="checked"/> 全部
	                </td>
	            </tr>
	        </table>
	        </td>
	    </tr>
	</table>
	
	<!-- 查询列表区 cGridArea(查询区样式)-->
	<div class="cGridArea" style="width:98%;" >
		<table id="gridTable" style="position:static;"></table>
		<div id="gridPager"></div>
	</div>
	<!-- 查询列表区 -->
	</div>
	<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>