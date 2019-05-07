<%--
describe:档案管理-照片档案列表
author:dailianchun
date: 2013-8-08
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.file.service.*"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileConstant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%><html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    String beanId = request.getParameter("beanId");
    String f_doc_deadline = request.getParameter("f_doc_deadline");
    String f_type = request.getParameter("f_type");
    String idList = request.getParameter("idList");
    //获得当前登录用户的id
    String userId = controler.getUserID();    
    //获得缓存的机构信息
    UserCacheBean userBean = UserCache.getUserCacheBean(userId);
    String unitId = userBean.getUnit_id();//所属单位id
    //服务接口
    FileFilesService service = new FileFilesServiceImpl();
    //密级的list
    List<Map<String,String>> secretList = service.queryDictByCode(FileConstant.DICT_TYPE_DAMJ);
    //保管期限
    List<Map<String,String>> deadlineList = service.queryDictByCode(FileConstant.DICT_TYPE_BGQX);
    boolean isManager = KbmUtil.isRolesUser(userId, "单位档案管理员");
%>
<title></title>
<!-- 公共部分开始 -->
<script type="text/javascript"
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 日期控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

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
<script src="../../resources/util/multiSelect.js" type="text/javascript"></script>

<script type="text/javascript">
//当前登录用户所属的机构id
var userId = "<%=userId%>";
var isManager = <%=isManager%>;//是否单位档案管理员
var path = "<%=path%>";
$(function() {
    $(document).keydown(function(){
        if(event.keyCode == 13){
            search();
        }
        });

    //重置按钮添加事件
    jQuery("#reset").click(function(){
        clear();
    });
    
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FileFilesDevolveInfoAddFilesList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       colModel : [
                    {
                        label : "案卷ID",
                        name : 'f_files_id',
                        index : 'f_files_id',
                        hidden : true
                    },{
                        label : "档号",
                        name : 'f_files_no',
                        index : 'f_files_no',
                        editable : false
                    }, {
                        label : "档案年份",
                        name : 'f_doc_year',
                        index : 'f_doc_year',
                        editable : false
                    },{
                        label : "盒号",
                        name : 'f_filesno',
                        index : 'f_filesno',
                        editable : false
                    },{
                        label : "目录号",
                        name : 'f_listno',
                        index : 'f_listno',
                        editable : false
                    },{
                        label : "盒内件数",
                        name : 'f_files_num',
                        index : 'f_files_num',
                        editable : false
                    }, {
                        label : "案卷状态",
                        name : 'f_files_state',
                        index : 'f_files_state',
                        hidden : true
                    }, {
                        label : "案卷状态",
                        name : 'f_files_state_name',
                        index : 'f_files_state_name',
                        editable : false
                    },{
                        label : "保管期限",
                        name : 'f_doc_deadline_name',
                        index : 'f_doc_deadline_name',
                        editable : false       
                    },{
                        label : "密级",
                        name : 'f_secrecy_name',
                        index : 'f_secrecy_name',
                        editable : false    
                    },{
                        label : "密级id",
                        name : 'f_secrecy_id',
                        index : 'f_secrecy_id',
                        hidden : true    
                    },{
                        label : "归档日期",
                        name : 'f_file_time',
                        index : 'f_file_time',
                        editable : false     
                    },{
                        label : "所属部门",
                        name : 'f_dept_name',
                        index : 'f_dept_name',
                        editable : false     
                    },{
                        label : "归档人ID",
                        name : 'f_file_userid',
                        index : 'f_file_userid',
                        hidden : true    
                    },{
                        label : "所属部门ID",
                        name : 'f_dept_id',
                        index : 'f_dept_id',
                        hidden : true    
                    },{
                        label : "案卷状态",
                        name : 'f_files_state',
                        index : 'f_files_state',
                        hidden : true    
                    },{
                        label : "所属分类id",
                        name : 'f_type_id',
                        index : 'f_type_id',
                        hidden : true    
                    },{
                        label : "所属分类名",
                        name : 'f_type_name',
                        index : 'f_type_name',
                        hidden : true    
                    }
        ],
        sortname : 'f_file_time',
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
       	toolbar : [ true, "top" ,"<input id=\"JYSQ\" name=\"JYSQ\" value=\"选 择\" type=\"button\" onclick=\"addLevel()\" class=\"but_y_01\" />"+
				"<input id=\"Collect\" name=\"Collect\" value=\"关闭\" type=\"button\" onclick=\"removeAlertWindows('addFileFilesForBean',true);\" class=\"but_y_01\" />"],
        multiselect : true, 
       	/* onSelectRow:function (id){
        	var model = jQuery("#gridTable").jqGrid('getRowData', id);
        		updateFileDocDetail(model.f_doc_id);
        }   */  
        onCellSelect:function (id,iCol)
		{
			if(iCol != 0)
            {
                var model = jQuery("#gridTable").jqGrid('getRowData', id);
                //update(model.f_files_id,model.f_flag,model.f_type_id,model.f_type_name);
            }
		}
    });
   

    //设置工具栏的宽度
    jQuery("#tool_buttons").width(jQuery("#t_bottombar_contentgridTable").width());
        
    });

var addLevel = function() {
	var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
	var idsArrTemp = new Array();
	jQuery(selectedIds).each(function () {
		var model = jQuery("#gridTable").jqGrid('getRowData', this);
		if(!IsSpace(model.f_files_id)){
			idsArrTemp.push(model.f_files_id);
		}
	});
	ids = idsArrTemp.join();
	if (IsSpace(ids)) {
		alert("请选择要移交的案卷！");
	} else {
		jQuery("#hidden_delete").val(ids);
		jQuery("#hidden_action_two").val("addfiles");
		jQuery("#secordFrom").attr("target","filefilesdevolveinfoJSPhiddenFrame");
		jQuery("#secordFrom").submit();
	}
}

afterSubmitFn=function(result){
	try{
		alert(result);
		getParentWindow('addFileFilesForBean').searchData();
		removeAlertWindows('addFileFilesForBean',true);
	}catch(e){alert(e.description);}
}
    /*
	     函数:  toUserParamJosn
	     说明:  构建要查询的参数
	     参数:   无
	     返回值: 返回要查询的参数
     */
    var toUserParamJosn = function(objName){ 
    	var param="{";
    	param+="'f_dept_name':'"+descape(escape(jQuery("#f_dept_name").val()))+"'";
    	param+=",'f_doc_year':'"+descape(escape(jQuery("#f_doc_year").val()))+"'";
    	param+=",'f_doc_deadline_name':'"+descape(escape(jQuery("#f_doc_deadline_name").val()))+"'";
    	param+=",'f_secrecy_name':'"+descape(escape(jQuery("#f_secrecy_name").val()))+"'";
    	param+=",'f_org_id':'<%=unitId%>'";
    	param+=",'f_doc_deadline':'<%=f_doc_deadline%>'";
    	param+=",'f_type':'<%=f_type%>'";
    	param+=",'f_files_id':\"<%=idList%>\"";
    	param+="}";
        return param;
    }

    /*
         函数:  search
         说明:  查询
         参数:   无
         返回值: 
     */
    var search = function() {
       
        //查询参数
        var sdata = { //构建查询需要的参数 
          paramJson : toUserParamJosn()
      };
        var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
        $.extend(postData, sdata);
        $("#gridTable").jqGrid("setGridParam", {
            search : true
        // 将jqGrid的search选项设为true  
        }).trigger("reloadGrid", [ {
            page : 1
        } ]); //重新载入Grid表格，以使上述设置生效 
    }

    /**
     *重置查询条件
     */
     var clear = function(){
         //清空输入框的值
        jQuery("input[type=text]").val("");
        jQuery("#searchTable input[type=checkbox]:checked").removeAttr("checked"); 
        //查询
        search();
     }
</script>
<!-- 公共部分结束 -->
</head>
<body>
<div>
    <table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
        <tr>
            <td>
            <!-- 固定查询 -->
                <table id="searchTable" width="100%" border="0" cellspacing="3" cellpadding="0" class="tabs_search_ctable">
                    <tr>
                       
                        <th  class="input_cx_title_th" style="width:60px;">所属部门 ：</th>
                         <td width="120" class="cx_title_td">
                             <input type="text"
                                    class="input_cx_title_283"  style="width:120px;" id="f_dept_name" name="f_dept_name"/>
                             
                        </td>
                         <th style="width:60px;" class="input_cx_title_th">档案年份：</th>
                        <td width="100" class="cx_title_td">
                        <input style = "width:100px;;background:url(/xtbg/ccapp/oa/resources/style/blue/images/date_img_year.jpg) right 1px no-repeat;" type="text" class="date_120 Wdate" name="f_doc_year" id="f_doc_year"
                             onclick="WdatePicker({dateFmt:'yyyy'})"/>
                        </td>
                      <th  class="input_cx_title_th" style="width:60px;">&nbsp;</th>
                         <td valign="top" width="60"  class="cx_title_td">
                           &nbsp;
                        </td>
                        <td style="width:120px;">
                            <input value="搜索" id="sel" type="button" onclick="search();" class="but_y_01" />
                            <input value="重置" id="reset" type="button" class="but_y_01" />
                        </td>
                    </tr>
                </table>
            <!-- 固定查询 end-->
            </td>
        </tr>
    </table>
    
    
    <!-- 查询列表区 cGridArea(查询区样式)-->
    <div class="cGridArea">
     <table id="gridTable"></table>
     <div id="gridPager"></div>
    </div>
</div>


<form id="secordFrom" name="secordFrom" method="post" action="filefilesdevolveinfodo.jsp">
<input type='hidden' name='action' id="hidden_action_two" value="addfiles"/>
<input type='hidden' name='delete' id="hidden_delete"/>
<input type='hidden' name='beanId' id="beanId" value='<%=beanId%>'/>
</form>

<iframe id="filetypeinfodoJSPhiddenFrame" name="filefilesdevolveinfoJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>