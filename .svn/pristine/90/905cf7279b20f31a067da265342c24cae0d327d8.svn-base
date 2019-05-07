<%--
describe:新建会议时选择模板
describe:短信模板列表
date: 2013-7-10
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.meeting.service.*"%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    //父窗口id
    String windowId = StringUtil.deNull(request.getParameter("windowId"));
    String canChoose = StringUtil.deNull(request.getParameter("canChoose"));
	boolean isFromMenu = true;//是否由菜单触发
	if ("yes".equalsIgnoreCase(canChoose)){//判断是否由会议基本信息页面选择短信模板触发
		isFromMenu = false;
	}
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
//搜索框的控制对象
var control = new defaultValueControl('请输入短信模板名称','#m_name');
$(function() {
    //初始化 
    control.init();
    
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
        });
    
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.meeting.list.MeetingNoteTemplateList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "模板id",
            name : 'm_id',
            index : 'm_id',
            hidden : true
        }, {
            label : "会议id",
            name : 'm_notice_id',
            index : 'm_notice_id',
            hidden : true
        }, {	
            label : "短信模板名称",
            name : 'm_name',
            index : 'm_name'
        }, {
            label : "内容",
            name : 'm_contents',
            index : 'm_contents',
            width:300
        }
        ],
        sortname : 'm_name',
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
        <%if(isFromMenu){%> 
        	toolbar : [ true, "top" ,"<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add value='添加' type='button' onclick='addMeetingNote()' value=''/><input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='删除' id=del type='button' onclick='deleteFn()' value=''/>"],
        	multiselect : true, 
        <%}%>
        onCellSelect:function (id,iCol,c,d){
        	if(iCol != 0){
        		var model = jQuery("#gridTable").jqGrid('getRowData', id);
        		if('yes'=='<%=canChoose%>'){
                    setParentValue(model.m_contents);
        		}else{
        			updateMeetingNote(model.m_id);
        		}
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
        var str = "{ 'm_name':'" + control.val() + "'}";
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

    /**
     *调用父页面的赋值方法
     */
  var setParentValue = function(contents){
      try{
    	 var parentWindow = getParentWindow("<%=windowId%>");
    	 //关闭窗口
         removeAlertWindows("<%=windowId%>",true);            
    	 if(parentWindow && parentWindow.replaceNoteContents)
    	 {
    		 parentWindow.replaceNoteContents(contents);
    	 }
      }catch(e){
          alert(e.message+"");
      }
  }

    
    
  /*
  函数:  addMeetingNote
  说明:  添加
  参数:   无
  返回值: 无
*/
var addMeetingNote = function() {
 openAlertWindows('addMeetingNoteWindow'
         ,getCurrentFilePath()+'meetingnotetemplateadd.jsp?windowId=addMeetingNoteWindow','添加短信模板'
         ,520,360,'25%','25%');
}

/*
  函数:  updateMeetingNote
  说明:  修改
  参数:  无
  返回值: 无
*/
var updateMeetingNote = function(m_id) {
 openAlertWindows('updateMeetingNoteWindow'
         ,getCurrentFilePath()+'meetingnotetemplateadd.jsp?windowId=updateMeetingNoteWindow&m_id='
         +m_id,'修改短信模板',520,360,'25%','25%');
}

/*
     函数:  deleteFn
    说明:  删除
    参数:  无
    返回值: 无
*/
var deleteFn = function(id) {
	    var ids = "";
	    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	    var ids = new Array();
	    $(selectedIds).each(function () {
	        var model = jQuery("#gridTable").jqGrid('getRowData', this);
	        //id不为空
	        ids.push(model.m_id);  
	    });
	        
	    if (!ids.length) {
	        alert("未选中短信模板，请重新选择要删除的短信模板！");
	    } else {
	        var okF = function(){
	            //ajax方式提交数据
	            jQuery.ajax({ 
	                type: "post", 
	                url: "meetingnotedo.jsp", 
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
                        <th width="90" class="input_cx_title_th">会议模板标题：</th>
                        <td width="200" class="cx_title_td">
                            <input type="text" id="m_name" name="m_name" class="input_cx_title_283" style="width:200px;"/>
                        </td>
                        
                        <td>
                            <input value="搜索" id="sel" type="button" onclick="search();" class="but_y_01" />
                            <%if(!isFromMenu){%> <input value="关闭"   type="button" onclick="removeAlertWindows('<%=windowId%>',true)" class="but_y_01" /><%} %>
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