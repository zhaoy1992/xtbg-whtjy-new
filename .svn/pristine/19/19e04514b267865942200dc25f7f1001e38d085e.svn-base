<%--
describe:新建会议室时选择模板
author:dailianchun
date: 2013-7-2
--%>
<%--
describe:会议模板列表
author:dailianchun
date: 2013-6-29
--%>
<%--
describe:会议模板已发布列表
author:dailianchun
date: 2013-6-26
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

<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%><html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();    
    //获得当前登录用户的id
    String userId = controler.getUserID();    
    UserCacheBean usercachebean=UserCache.getUserCacheBean(userId);
    
    String orgId = usercachebean.getUnit_id();//accesscontroler.getChargeOrgId();//用户所属机构id
    //会议模板状态 0：暂存，1：发布
    String flag = StringUtil.deNull(request.getParameter("flag"));
    //父窗口id
    String windowId = StringUtil.deNull(request.getParameter("windowId"));
    //没有传入，则设置为1
    flag = StringUtil.nullOrBlank(flag) ? "1" : flag;
    
    //会议类型数据
    MeetingTypeService typeService = new MeetingTypeServiceImpl();
    //根据机构id查询对应的会议类型数据
    List<MeetingTypeBean> typeList = typeService.queryListMeetingTypeByOrgId(orgId);

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
    
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.meeting.list.MeetingTemplateList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "模板id",
            name : 'm_tmp_id',
            index : 'm_tmp_id',
            hidden : true
        }, {
            label : "会议模板标题",
            name : 'm_title',
            index : 'm_title',
            width:300
        }, {
            label : "会议类型",
            name : 'm_type_name',
            index : 'm_type_name',
            editable : false
        }, {
            label : "登记部门",
            name : 'm_tmp_unit_name',
            index : 'm_tmp_unit_name',
            editable : false
        }, {
            label : "登记人",
            name : 'm_tmp_creator_name',
            index : 'm_tmp_creator_name',
            editable : false
        }, {
            label : "登记人id",
            name : 'm_tmp_creator_id',
            index : 'm_tmp_creator_id',
            hidden : true
        }, {
            label : "登记时间",
            name : 'm_tmp_create_time',
            index : 'm_tmp_create_time',
            editable : false
        }
        ],
        sortname : 'm_tmp_create_time',
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
        toolbar : [ true, "top"],
        multiselect : false,
        onCellSelect:function (id,iCol,c,d){
                var model = jQuery("#gridTable").jqGrid('getRowData', id);
                setParentValue(model.m_tmp_id);
                
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
        var str = "{'m_tmp_unit_id':'" + orgId  
                  + "','m_title':'" + control.val()
                  + "','m_type_id':'" + jQuery("#m_type_id").val()
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

    /**
     *调用父页面的赋值方法
     */
  var setParentValue = function(id){
      try{
    	 var parentWindow = getParentWindow("<%=windowId%>");
    	//关闭窗口
         removeAlertWindows("<%=windowId%>",true);            
    	 if(parentWindow && parentWindow.backTemplate)
    	 {
    		 parentWindow.backTemplate(id);
    	 }
    	  	  
      }catch(e){
          /**忽略异常信息**/
          alert(e.message+"");
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
                            <input type="text" id="m_title" name="m_title" class="input_cx_title_283" style="width:200px;"/>
                        </td>
                        <th  class="input_cx_title_th" style="width:110px;">会议类型：</th>
                        <td class="cx_title_td">
                             <select style="width:150px;" name ="m_type_id" id= "m_type_id" size ="1"  class ="select_100_box_type" >
                                <option value ="">---请选择---</option>
                                <%for(MeetingTypeBean type : typeList){ %>
                                <option value="<%=StringUtil.deNull(type.getM_type_id()) %>"><%=StringUtil.deNull(type.getM_type_name()) %></option>
                                <%} %>
                            </select>   
                        </td>
                        
                        <td width="60" >
                            <input value="搜索" id="sel" type="button" onclick="search();" class="but_y_01" />
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