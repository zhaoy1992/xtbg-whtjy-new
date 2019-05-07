<%--
描述：个人通讯录人员信息展示
姓名：戴连春
日期：2013-06-13
 --%>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.personwork.entity.ListShowUtilBean"%>
<%@page import="com.chinacreator.xtbg.core.personwork.entity.PGroupBean"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.*"%>
<%@page import="com.chinacreator.xtbg.core.personwork.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>

<%
    AccessControl accesscontroler = AccessControl.getInstance();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    String userid = accesscontroler.getUserID();
    String is_public = StringUtil.deNull(request.getParameter("is_public"));//是否公共通讯录(即外部通讯录)

    //个人通讯录操作的service对象
    PersonInfoServiceIfc service = new PersonInfoServiceImpl();
        
    //获得当前用户的所有分组信息
    List<PGroupBean> pgBeanList = service.queryGroup(userid, is_public);
    
    //获得首字母查询的信息
    List<ListShowUtilBean> firstCodeList = service.getFirstCodeShowInfo(userid,is_public);
 
    //是否配置了分组信息
    boolean isConfigGroupInfo =service.isGroupExist(userid,is_public);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>个人通讯录</title>

<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/testcss.css" />
<link href="../../resources/style/blue/css/tjz.css" rel="stylesheet" type="text/css" />

<!-- 引入jQuery -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>

<!-- 引入jGrid -->
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>

<!-- 引入jQuery_dialog （特殊删除有用到）-->
<script src="../../resources/plug/jquery_dialog/jquery_dialog.js"></script>

<!-- 引入其它 -->
<script type="text/javascript"  src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<script type="text/javascript"  src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"  src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>

<script type="text/javascript">
//当前登录用户的id
var userid = "<%=userid%>";

//当前用户的个人通讯录是否存在分组信息
var isConfigGroupInfo = <%=isConfigGroupInfo%>;

//系统更目录
var path = '<%=path%>';

//拼音首字母
var nameindex = "";

// 分组名称
var groupname = "";

// 搜索框的值
var searchInputValue = "";

// 是否正在在查询文本框中输入
var isInputSearchText = false;



//页面加载后执行
$(function() {
    adaptationWH("","vcenter",43);
    // 设置焦点在当前页面时，按回车键触发搜索
    $(document).keydown(function() {
        if (event.keyCode == 13) {
            personSearch();
        }
    });

    // 搜索框默认的值
    var defaultSearchShow = "输入姓名、号码或邮箱"

    // 字母搜索框添加点击事件
    $("#filters a").click(function(event) {
        if ($(event.target).html() == "全部") {
            nameindex = "";
            groupname = "";
            searchInputValue = "";
            $("#searchInput").val(defaultSearchShow);
            $("#searchInput").addClass("focus");
            // 移除所有超链接的选中属性
            $("a").removeClass("onclicks");
            //当前点击对象添加选中样式
            $(this).addClass("onclicks");
        } else {
            nameindex = $(event.target).html();
            //移除其他字母链接的选中样式
            $("#filters a").removeClass("onclicks");
            //当前点击对象添加选中样式
            $(this).addClass("onclicks");
        }
        personSearch();
    })
        
    // 分组工具条添加点击事件
    $("#filters_group a").click(function(event) {
        //控制点击后的样式
        $("#filters_group a").removeClass("onclicks");
        //如果拼音搜索工具条选中的是全部，则要去掉其样式        
        $("#filters a[name=quanbu]").removeClass("onclicks");
        $(this).addClass("onclicks");
                
        nameindex = "";
        groupname = "";
        //获得超链接的标题
        groupname = $(this).attr("title");
        personSearch();
    });

    // 搜索按钮添加点击事件
    $("#btn_Search").bind('click', searchByLikename);

    // 搜索框添加获得焦点事件
    $("#searchInput").focus(function() {
        isInputSearchText = true;
        if (IsSpace(searchInputValue)) {
            $("#searchInput").removeClass("focus");
            $("#searchInput").val("");
        }
    });

    // 搜索框添加属性更改事件
    $("#searchInput").bind("propertychange", function() {
        if (isInputSearchText) {
            searchInputValue = $("#searchInput").val();
        }
    });

    // 搜索框添加失去焦点事件
    $("#searchInput").blur(function() {
        isInputSearchText = false;
        searchInputValue = $("#searchInput").val();
        if (IsSpace($("#searchInput").val())) {
            $("#searchInput").val(defaultSearchShow);
            $("#searchInput").addClass("focus");
        }
    });

    // 定义表格数据
    $("#gridTable").jqGrid({
                        url : path + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.personwork.list.PersonalAddressBookList', 
                        // jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
                        datatype : "json",
                        // 这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
                        mtype : "POST",
                        // 定义使用哪种方法发起请求，GET或者POST
                        height : "99%",// 270
                        // Grid的宽度，可以接受数字、%值、auto，默认值为150
                        autowidth : true,
                        // 最重要的数组之一，用于设定各列的参数
                        colModel : [ {
                            label : "人员id",
                            name : 'person_id',
                            index : 'person_id',
                            hidden : true
                        }, {
                            label : "姓名",
                            name : 'name',
                            index : 'name',
                            width : 100,
                            editable : true
                        }, {
                            label : "办公手机",
                            name : 'commonlymobile',
                            index : 'commonlymobile',
                            width : 80,
                            editable : true
                        }, {
                            label : "QQ",
                            name : 'qqNum',
                            index : 'qq',
                            width : 80,
                            hidden : true,
                            editable : true
                        }, {
                            label : "电子邮箱",
                            name : 'email',
                            index : 'email',
                            width : 180,
                            editable : true
                        }, {
                            label : "所在分组",
                            name : 'group',
                            index : 'group_name',
                            width : 150,
                            editable : true
                        }, {
                            label : "分组id",
                            name : 'group_id',
                            index : 'group_id',
                            hidden : true
                        <%
                        if(!is_public.equals("1")){//非公共通讯录才显示信息来源
                        %>
                        }, {
                            label : "信息来源",
                            name : 'info_source_name',
                            index : 'info_source_name',
                            width : 80,
                            search : true
                        <%
                        }
                        %>
                        }, {
                            label : "增加用户ID",
                            name : 'user_id',
                            index : 'user_id',
                            hidden : true
                        }, {
                            label : "信息来源code",
                            name : 'info_source',
                            index : 'info_source',
                            hidden : true
                        } ],
                        sortname : 'person_id',
                        // 指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
                        sortorder : 'desc',
                        viewrecords : true,
                        // 设置是否在Pager Bar显示所有记录的总数。
                        rowNum : 10,
                        // 用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
                        rowList : [ 10, 20, 30 ],
                        // 一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
                        gridComplete : function() {
                            $("#gridTable").setGridWidth($(window).width() * 0.98);
                            var ids = $("#gridTable").getDataIDs(); // jqGrid('getDataIDs');
                            for ( var i = 0; i < ids.length; i++) {
                                var cl = ids[i];
                            }
                            $(".t_taoobar_content_left").attr("style","width:350px");
                            if("<%=is_public%>" == 1){	//暂时屏蔽掉公共通讯录导入
								$("#import").css("display","none");                            	
                            }
                        },
                        // 用来设定如何解析从Server端发回来的json数据
                        jsonReader : {
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
                                "<input type='button' id='addperson' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='新增' onclick='addPerson()'  style='margin-left:5px;'/>"+
                                "<input type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='删除' onclick='deletePerson()'  style='margin-left:5px;'/>"+
                                "<input type='button' class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value=' 添加到组 ' onclick='getselectGroupinfo()'  style='margin-left:5px;'/>"+
                                "<input type='button' id='import' class='but_y_01' title='导入excel' value='导入excel' style='margin-left:5px;' onclick='openImport()'/>" ],
                        multiselect : true,
                        onCellSelect : function(id, iCol) {
                            if (iCol != 0) {
                                editPerson(id);
                            }
                        }
                    }).navGrid('#gridPager', {
                edit : false,
                add : false,
                del : false,
                search : false,
                refresh : false
            }); 
});



/**
 * 构建要查询的参数
 * @return 返回要查询的参数
 */
var toUserParamJosn = function() {
    var str = "{'userid':'" + userid + "','likevalue':'" + searchInputValue
            + "','nameindex':'" + nameindex + "','groupname': '" + groupname
            + "','is_public':'<%=is_public%>'}";
    return descape(escape(str));
}

/**
 * 添加用户信息
 * @return
 */
var addPerson = function() {
    var url = "persondetailinfo.jsp?is_public=<%=is_public%>";
    location.href = url;
}

/**
 * 查询通讯录用户信息
 * @return
 */
var personSearch = function() {

    var sdata = { // 构建查询需要的参数
        paramJson : toUserParamJosn()
    };
    // 获得当前postData选项的值
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
 * 搜索
 */
var searchByLikename = function() {
    personSearch();
}


/**
 * 编辑分组信息
 */
var configUserGroup = function() {
	var backFn = function(){window.location.reload();};
    openAlertWindows('windowId', getCurrentFilePath()+'pgroupnew.jsp?is_public=<%=is_public%>', '编辑分组',
            490, 290, '25%', '25%',backFn);

}

/**
 * 刷新grid的数据
 */
var refreshGrid4WfactionInfo = function() {

    var sdata = { // 构建查询需要的参数
        paramJson : toUserParamJosn()
    }; // 获得当前postData选项的值
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
 * 获得当前选中的数据的分组整合信息
 * @return
 */
var getselectGroupinfo = function() {
    if (!isConfigGroupInfo) {// 如果没配置分组
        alert("您还没有配置分组信息！");
        return false;
    }

    var ids = "";
    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
    var tempArrs = [];
    var dirUserArrs = [];
    var personArrs = [];
    $(selectedIds).each(function() {
        var model = jQuery("#gridTable").jqGrid('getRowData', this);
        if (!IsSpace(model.group_id))
            tempArrs.push(model.group_id);
        if (model.info_source == "personaladdress")// 如果信息来源为个人通讯录
                personArrs.push(model.person_id);
            else
                dirUserArrs.push(model.person_id);
        })
    ids = tempArrs.join().split(",").unique();
    $('#personids').val(personArrs.join());
    $('#groupshowids').val(ids);

    if (dirUserArrs.length > 0) {
        alert("来自公共通讯录联系人不能进行分组！");
        return false;
    }
    if (IsSpace(personArrs.join())) {
        alert("请选择要添加到分组的名片！");
        return false;
    }
    openAlertWindows('windowId',
            getCurrentFilePath()+'configpersongroup.jsp?is_public=<%=is_public%>&personids='
                    + personArrs.join() + '&groupshowids=' + ids, '编辑分组', 490,
            290, '25%', '25%');
    return true;
}

/**
 * 删除用户
 * 
 * @return
 */
var deletePerson = function() {
    var personalids = "";
    var directoryids = "";
    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
    var tempArrs = [];
    var tempDirectArrs = [];
    $(selectedIds).each(
            function() {
                var model = jQuery("#gridTable").jqGrid('getRowData', this);
                if (!IsSpace(model.person_id)
                        && model.info_source == "personaladdress")
                    tempArrs.push(model.person_id);
                if (!IsSpace(model.person_id)
                        && model.info_source == "directory")
                    tempDirectArrs.push(model.person_id);
            })
    personalids = tempArrs.join();
    directoryids = tempDirectArrs.join();
    if (IsSpace(personalids) && IsSpace(directoryids)) {
        alert("请选择要删除的记录！");
    } else {
        var okF = function() {
            $("#personids").val(personalids);
            $("#directoryids").val(directoryids);
            $("#form1").attr("target", "hiddenFrame");
            $("#form1").submit();
        }
        var p = {
            headerText : '提示',
            okName : '确认',
            okFunction : okF,
            cancelName : '取消'
        };
        alert("确定要删除用户信息吗？", p)
    }
}

/**
 * 编辑通讯录用户信息
 * @param id 用户id
 * @return
 */
var editPerson = function(id) {
    var model = jQuery("#gridTable").jqGrid('getRowData', id);
    var url = "";
    if (model.info_source == "personaladdress") {
        url = "persondetailinfo.jsp?is_public=<%=is_public%>&person_id=" + model.person_id;
        location.href = url;
    } else {
        openAlertWindows(
                'windowId',
                getCurrentFilePath()+'viewdirectory4publicaddress.jsp?typeid=' + model.person_id,
                '查看人员信息', 800, 300, '20%', '10%');
    }
}

/**
 *  打开导入excel页面,传入一个标志，是表示个人通讯录导入还是公共通讯录导入
 */
function openImport() {
    openAlertWindows('windowId', getCurrentFilePath()+'addressbookimport.jsp?is_public=<%=is_public%>',
            '导入excel表格', '455px', '70%', '10%', '40%', function() {
                location.reload();
            });
}
</script>

</head>
<body>
<div id="vcenter">
<table width="98%">
    <tr>
        <td>
        <div class="btn-bar" style="border-top: 1px solid #EAEAEA;">
            <div class="filters logClass">
                  <span style="width: 100px; color: #000">
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;分组：
                  </span>
            <%
                for (int i = 0; i < pgBeanList.size(); i++) {
    
                    PGroupBean pgBean = pgBeanList.get(i);
                    String groupName = pgBean.getGroupName();
                    if (groupName.length() > 5) {
                        groupName = groupName.substring(0, 5) + "...";
                    }
            %>
                <div class="tjdiv" id="filters_group" style="margin-right: 10px;">
                  <a style="width: 80px;" href="javascript:void(0)" title="<%=pgBean.getGroupName()%>"> 
                     <%=groupName%>
                  </a>
                </div>
            <%
                }
            %> 
            <%if(!(StringUtil.deNull(is_public).equals("1") && !StringUtil.deNull(userid).equals("1"))){//公共通讯录，只有admin可以编辑分组
            %>
            <a style="color: #FF6600; width: 50px;" href="javascript:void(0)"   
                   onClick="configUserGroup()">编辑分组</a>
            <%
            } %>
                
            </div>
        </div>
        </td>
    </tr>

    <tr>
        <td><!-- 查询列表区 cGridArea(查询区样式)-->
            <div class="btn-bar">
                <div class="filters logClass" id="filters">
                  <span style="width: 100px; color: #000">首字母查询：</span> 
                  <a style="width: 30px;" href="javascript:void(0)" name="quanbu">全部</a> 
                  <%for (ListShowUtilBean showBean : firstCodeList) {
                      if (showBean.isExsit) { %> 
                        <a style="width: 20px;" href="javascript:void(0)"><%=showBean.getFirstCode()%></a>
                  <%   } else {%> 
                        <span style='width: 20px;'><%=showBean.getFirstCode()%></span> 
                  <%   
                     }
                   }
                  %>
                </div>
            </div>
        </td>
    </tr>

    <tr>
        <td>
        <div class="btn-bar">
          <div class="filters logClass">
          
            <span style="width: 100px; color: #000">&nbsp;条件查询：</span> 
            <input name="search" id="searchInput" style="float: left;" type="text" 
                   value="输入姓名、号码或邮箱" class="input_cx_title_188" /> 
            <input name="btn_Search" id="btn_Search" style="float: left; margin-left: 5px;" 
                   class="but_y_01" type="button" value="搜索" />
          
          </div>
        </div>
        </td>
    </tr>

    <tr>
        <td>
        <div class="cGridArea">
            <table id="gridTable" style="position:static;"></table>
            <div id="gridPager"></div>
        </div>
        </td>
    </tr>
</table>

</div>
<!-- 用来删除的表单 -->
<form id="form1" name="form1" method="post" action="deletepersoninfoform.jsp">
  <input id="userid" name="userid" value="<%=userid%>" type="hidden"/>
  <input id="personids" name="personids" value="" type="hidden"/> 
  <input id="directoryids" name="directoryids" value="" type="hidden"/> 
  <input id="groupshowids" name="groupshowids" type="hidden" value=""/>
</form>

<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>