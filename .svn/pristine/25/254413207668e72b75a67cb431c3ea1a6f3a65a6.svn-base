<%--
describe:会议室管理
author:dailianchun
date: 2013-6-25
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%><html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    String userId = controler.getUserID();
    //获得当前登录用户的单位id
    UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
    String orgId = usercachebean.getUnit_id();//单位id
%>
<title>会议室管理</title>
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
<!-- 公共部分结束 -->
<script type="text/javascript">
//当前登录用户所属的机构id
var orgId = "<%=orgId%>";
$(function() {   
	
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
        });
    
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.meeting.list.MeetingRoomList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [
        {
            label : "会议室id",
            name : 'm_room_id',
            index : 'm_room_id',
            hidden : true
        }, {
            label : "会议室名称",
            name : 'm_room_name',
            index : 'm_room_name',
            width:100
        }, {
            label : "会议室地点",
            name : 'm_address',
            index : 'm_address',
            editable : false,
            width:80
        }, {
            label : "管理部门",
            name : 'm_dept_name',
            index : 'm_dept_name',
            editable : false,
            width:100
        }, {
            label : "可容纳人数",
            name : 'm_people_num',
            index : 'm_people_num',
            width:70
        },{
            label : "是否有效",
            name : 'm_is_use_flag',
            index : 'm_is_use_flag',
            width:60,
            formatter : function(value,column){
	            if(!IsSpace(value)&&value == "1"){
	               return "是";
	            }
	            return "否";
            }
        }, {
            label : "管理人员",
            name : 'administrator_names',
            index : 'administrator_names',
            editable : false,
            formatter :function(value){
            	return value.replaceAll("title=","");//有title时显示有bug
            }
        }, {
            label : "备注",
            name : 'm_remark',
            index : 'm_remark',
            editable : false
        }
        ],
        sortname : 'm_reg_time',
        //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
        sortorder : 'desc',
        //设置是否在Pager Bar显示所有记录的总数。
        viewrecords : true,
        
        rowNum : 10,
        //用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
        rowList : [ 10, 20, 30 ],//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
        gridComplete : function() { 
            
            var ids = $("#gridTable").getDataIDs(); 
            for ( var i = 0; i < ids.length; i++) {
                var cl = ids[i];
            }
        },
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
        toolbar : [ true, "top" ,"<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add value='添加' type='button' onclick='add()' value=''/><input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='删除' id=del type='button' onclick='del()' value=''/>"],
        multiselect : true,
        onCellSelect:function (id,iCol)
        {
           if(iCol != 0)
            {
                var model = jQuery("#gridTable").jqGrid('getRowData', id);
                update(model.m_room_id);
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
        var str = "{'m_unit_id':'" + orgId  
                  + "','m_room_name':'" + jQuery("#m_room_name").val()
                  + "','m_address':'" + jQuery("#m_address").val()
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
	     函数:  add
	     说明:  添加 
	     参数:   无
	     返回值: 无
      */
    var add = function() {
    	openWindows('add_meetingRoom','新建会议室'
                ,'meetingroomadd.jsp?windowId=add_meetingRoom'
                ,'meetingmanager',false,window);
    }

    /*
         函数:  update
         说明:  修改 
         参数:  无
         返回值: 无
     */
    var update = function(id) {
    	openWindows('update_meetingRoom','更新会议室'
                ,'meetingroomadd.jsp?windowId=update_meetingRoom&id='+id
                ,'meetingmanager',false,window);
    }

    /*
            函数:  del
           说明:  删除
           参数:  无
           返回值: 无
    */
     var del = function(id) {
    	    var ids = "";
    	    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
    	    var ids = new Array();
    	    $(selectedIds).each(function () {
    	        var model = jQuery("#gridTable").jqGrid('getRowData', this);
    	        //id不为空
    	        ids.push(model.m_room_id);  
    	    });
    	        
    	    if (!ids.length) {
    	        alert("未选中会议室，请重新选择要删除的会议室！");
    	    } else {
    	        var okF = function(){
    	            //ajax方式提交数据
    	            jQuery.ajax({ 
    	                type: "post", 
    	                url: "meetingroomdo.jsp", 
    	                contentType: "application/x-www-form-urlencoded; charset=utf-8",
    	                data : {
    	                	action : "delete",
    	                    ids : ids.join(",") //要删除的id列表      
    	                },
    	                dataType: "json", 
    	                success: function (data) {
    	                    if(data){
        	                    if(data.msg){
    	                            alert(data.msg);
        	                    }
	    	                    //如果删除成功，刷新数据
	    	                    if(data.flag&&"true" == data.flag){
	    	                        search();
	    	                    }
    	                    }
    	                }, 
    	                error: function (XMLHttpRequest, textStatus, errorThrown) { 
    	                    alert("系统异常，请稍后再试！");
    	                }
    	             });
    	        }
    	        var p={
    	                    headerText:'提示',
    	                    okName:'确认',
    	                    okFunction:okF,
    	                    cancelName:'取消'
    	            };
    	        alert("删除后将不能恢复，确定删除吗？",p); 
    	    }
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
		        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
		            <tr>
		                <th width="90" class="input_cx_title_th">会议室名称：</th>
		                <td width="250" class="cx_title_td">
		                    <input type="text" id="m_room_name" name="m_room_name" class="input_cx_title_240">
		                </td>
		                <th width="90" class="input_cx_title_th">会议室地点：</th>
                        <td width="250" class="cx_title_td">
                            <input type="text" id="m_address" name="m_address" class="input_cx_title_240">
                        </td>
		                
		                <td  colspan="2">
		                    <input value="搜索" id="sel" type="button" onclick="search()" class="but_y_01" />
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
</body>
</html>