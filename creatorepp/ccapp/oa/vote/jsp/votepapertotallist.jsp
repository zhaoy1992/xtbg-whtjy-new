<%-- 
描述：问卷类型维护
作者：戴连春
版本：1.0
日期：2013-05-13
 --%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page
    import="com.chinacreator.xtbg.core.vote.service.VotePaperService"%>
<%@page
    import="com.chinacreator.xtbg.core.vote.service.impl.VotePaperServiceImpl"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.commonlist.Constant"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<%
AccessControl accesscontroler = AccessControl.getInstance();
accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    String userId = accesscontroler.getUserID();
    String userName = accesscontroler.getUserName();
    boolean isAdmin = accesscontroler.isAdmin();//是否为管理员
    //问卷service
    VotePaperService service = new  VotePaperServiceImpl();   
    //获得所有问卷类型
    List<Map<String,Object>> paperTypeList = (List<Map<String,Object>>)service.findListPaperType();
    
%>
<title>问卷</title>

<!-- 引入jQuery -->
<script type="text/javascript"
    src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script
    src="<%=path %>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
    type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script
    src="<%=path %>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js"
    type="text/javascript"></script>
<!-- 引入jGrid -->
<script
    src="<%=path %>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
    type="text/javascript"></script>
<script
    src="<%=path %>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
    type="text/javascript"></script>
<!-- 引入其它 -->
<script src="<%=path %>/ccapp/oa/resources/util/public.js"
    type="text/javascript"></script>
<script type="text/javascript"
    src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"
    src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js"
    charset="utf-8"></script>
<script type="text/javascript"
    src="<%=path %>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">
var path = "<%=path%>";//工程路径
//查询列表数据的类名全路径
var className = "com.chinacreator.xtbg.core.vote.list.VotePaperList";
var userId = '<%=userId %>';//当前登录用户id
var userName = '<%=userName %>';//当前登录用户
var isAdmin = <%=isAdmin%>;//当前登录用户是否为系统管理员 
var rycpid  = "<%=Constant.RYCPID%>";//人员测评类型id

jQuery(function() {
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            userSearch();
        }       
    });
    //绑定查询事件
    jQuery("#stauts").change(function(){
        userSearch();
    });
    //绑定查询事件
    jQuery("#papaer_type").change(function(){
        userSearch();
    });
    $("#gridTable").jqGrid({
        url: path + '/pubListServlet?classNameId='+className,  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype: "json",
        //这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
        mtype: "POST",
        //定义使用哪种方法发起请求，GET或者POST
        height: "100%",//270
        //Grid的高度，可以接受数字、%值、auto，默认值为150
        //width ："1800", //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
        //shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
        autowidth: true,        
        colNames: ['问卷id',"问卷类型",//注意：更改列后需要将函数onCellSelect也调整下
                   '是否置顶','是否置顶',
                   '考核标题','考核类型','创建人','所属单位','创建时间','状态',
                    '状态','评分情况','已提交','创建人id',"操作",''],
        //字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
        colModel: [ //最重要的数组之一，用于设定各列的参数
        {
            name: 'id',
            index: 'id',
            hidden: true
        },{
            name: 'papaer_type',
            index: 'papaer_type',
            hidden: true
        },        
        {
            name: 'istop',
            index: 'istop',
            hidden:true
        },{
            name: 'istopname',
            index: 'istopname',
            width:100
        },
        {
            name: 'title',
            index: 'title',
            width:200
        },
        {
            name : 'type_name',
            index : 'type_name'
        },
        {
            name : 'user_name',
            index : 'user_name'
        },
        {
            name : 'org_name',
            index : 'org_name'
        },
        {
            name : 'creatdate',
            index : 'creatdate',
            width:200
        },
        {
            name : 'stauts',
            index : 'stauts',
            hidden:true
        },
        {
            name : 'stautsname',
            index : 'stautsname',
            hidden:true
        },
        {
            name : 'voterate',
            index : 'voterate',
            hidden : false,
            search: false,
            sortable: false,
            editable: false
        },{
            name : 'submitpaper',
            index : 'voterate',
            hidden : false,
            search: false,
            sortable: false,
            editable: false
        },
        {
            name : 'user_id',
            index : 'user_id',
            hidden : true
        },
        {
            name : 'action_column',
            index : 'action_column',
           	width:40,
            hidden : false,
            search: false,
            sortable: false,
            editable: false
        },
        {
            name : 'action_column1',
            index : 'action_column1',
            width:0,
            hidden : false,
            search: false,
            sortable: false,
            editable: false
        }
        ],
        sortname: 'creatdate',
        //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
        sortorder: 'desc',
        viewrecords: true,
        
        //设置是否在Pager Bar显示所有记录的总数。
        rowNum: 10,
        //用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
        rowList: [10, 20, 30],
        //一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
     
        gridComplete : function() {
            var ids = $("#gridTable").getDataIDs();
            for ( var i = 0; i < ids.length; i++) {
                var cl = ids[i];
                var model = jQuery("#gridTable").jqGrid('getRowData', cl);
                var col = "";
                if(model.stauts == '1') {

                    col = "<strong><a href='javascript:void(0);' "+
                        " onclick='answerRate(\""+cl
                        +"\")' style='color:red'><span style='color:red'>"
                        +model.voterate+"</span></a></strong>";
                }
                
                var showStr = "";

                //导出或者统计
                if(model.stauts == '1' ) {
                	var msg ="";
                	var voterate = model.voterate;
                	var s = voterate.substr(0, 1); 
                	if(parseInt(s) > 1){
                		var msg = (rycpid == model.papaer_type)? "导出":"统计"
                        showStr += "<a href='javascript:void(0);' "+
                            " onclick='paperTJ(\""+cl
                            +"\")' style='font-weight:bold;color:red;'>"+msg+"</a>";
                	}else{
                		  showStr += "<a href='javascript:void(0);' "+
                          " onclick='paperTJ(\""+cl
                          +"\")' style='font-weight:bold;color:red;'>"+msg+"</a>";
                	}
                	
                  
                }
                var showStrwnda="";
                //问答题的统计，
                if(model.stauts == '1' ) {
                	var msg ="";
                	var voterate = model.voterate;
                	var s = voterate.substr(0, 1); 
                	//if(parseInt(s) > 1){
                		var msg = (rycpid == model.papaer_type)? "":"查看"
                			showStrwnda += "<a href='javascript:void(0);' "+
                            " onclick='paperCK(\""+cl
                            +"\")' style='font-weight:bold;color:red;'>"+msg+"</a>";
                	//}else{
                	//	showStrwnda += "<a href='javascript:void(0);' "+
                   //       " onclick='paperTJ(\""+cl
                   //       +"\")' style='font-weight:bold;color:red;'>"+msg+"</a>";
                	//}
                	
                  
                }

                //已提交问卷
                var submitStr = "";
                if(model.stauts == "1"){
                	submitStr = "<strong><a href='javascript:void(0);' "+
                    " onclick='submitPaper(\""+cl
                    +"\")' style='color:red'><span style='color:red'>"+model.voterate+"</span></a></strong>"
                }

                //重新定义列显示的值
                jQuery("#gridTable").jqGrid('setRowData', ids[i], {
                    voterate: col,
                    action_column : showStr,
                    submitpaper : submitStr
                });
            }
        },
        jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
            repeatitems: false
        },
        pagerintoolbar:true,//上面的分页条
        pagerinBottombar:true,//下面的分页条
        //定义页码控制条Page Bar
        //caption: "来文缓急维护",
        //设置Grid表格的标题，如果未设置，则标题区域不显示。
        search : toUserParamJosn(),
        prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
            rows: "rows",
            //表示请求行数的参数名称  
            sort: "sidx",
            //表示用于排序的列名的参数名称  
            order: "sord",
            //表示采用的排序方式的参数名称 
            search : "search"
        },
        toolbar:[true, "top" ,""],
        multiselect: true,
        onCellSelect:function (id,iCol)
        {
            
            if(iCol != 0 && iCol != 12&& iCol != 13&& iCol != 14)
            {
                updateLevel(id);
            }
        }
    }).navGrid('#gridPager', {
        edit: false,
        add: false,
        del: false,
        refresh: false,
        search: false
    });

});

     
/*
     函数:  toUserParamJosn
     说明:  构建要查询的参数
     参数:   无
     返回值: 返回要查询的参数
     */
var toUserParamJosn = function() {
    var str = "{'title':'" + $("#title").val() 
    + "','user_name':'" + userName 
    + "','startdate':'" + $("#startdate").val() 
    + "','enddate':'" + $("#enddate").val() 
    + "','stauts':'1" //这里每次都传已发布
    + "','papaer_type':'" + $("#papaer_type").val() 
    + "'}";
    return descape(escape(str));
}

/*
     函数:  userSearch
     说明:  查询用户信息
     参数:   无
     返回值: 用户列表
     */
var userSearch = function() {
    var sdata = { //构建查询需要的参数 
        paramJson: toUserParamJosn()
    }; //获得当前postData选项的值  
    var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
    $.extend(postData, sdata);
    $("#gridTable").jqGrid("setGridParam", {
        search: true // 将jqGrid的search选项设为true  
    }).trigger("reloadGrid", [{
        page: 1
    }]); //重新载入Grid表格，以使上述设置生效 
}
/*
函数:  addlevel
说明:  添加问题
参数:   无
返回值: 无
*/
var addQuestion = function() {
    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
    if(selectedIds.length<=0){
       alert("请先选择考核!");
       return;
    }
    if(selectedIds.length>1){
       alert("每次只能操作一份考核!");
       return;
    } 
    
    var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[0]);
        //不是自己创建的问卷且不是系统管理员登陆则不能操作 
    if(userId != model.user_id && !isAdmin){
        alert("只能操作您自己创建的考核!");
        return;
    }
    //获得选中的第一行数据
    var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[0]);
    openAlertWindows('windowId',path+"/ccapp/oa/vote/jsp/votequestionlist.jsp?subid=windowId&paper_id="+model.id
            +"&status="+model.stauts,'考核问题管理',800,430,'10%','20%');
}
/* 
     函数:  addlevel
     说明: 添加
     参数:   无
     返回值: 无
 */
var addLevel =  function() {
        openWindows('sub_main_newVotePaper','新建考核'
                ,'addvotepaper.jsp?subid=sub_main_newVotePaper&stauts=0&type=0'
                ,'cz_dwll',false,window);
}
 
/*
     函数:  updateLevel
     说明:  修改
     参数:   无
     返回值: 无
     */
var updateLevel = function(id) {
   var model = jQuery("#gridTable").jqGrid('getRowData', id);
   openWindows('sub_main_updateVotePaper','新建考核'
           ,'addvotepaper.jsp?subid=sub_main_updateVotePaper&stauts='
           +model.stauts+'&type=0&id='+model.id,'cz_dwll',false,window);
}

/*
     函数:  deleteFn
     说明:  删除
     参数:   无
     返回值: 无
     */
var deleteFn = function(id) {
    var ids = "";
    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
    var ids = new Array();
    $(selectedIds).each(function () {
        var model = jQuery("#gridTable").jqGrid('getRowData', this);
        //id不为空且是自己创建的问卷
        if(!IsSpace(model.id) 
                && ( userId  == model.user_id || isAdmin)){ 
            ids.push(model.id);  
        }  
    });
        
    if (!ids.length) {
        alert("未选中您自己创建的问卷，请重新选择要删除的考核！");
    } else {
        debugger;
        var okF = function(){
            //ajax方式提交数据
            jQuery.ajax({ 
                type: "post", 
                url: "votepaperaction.jsp", 
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data : {
                    action : "deleteList",
                    ids : ids.join(",") //要删除的id列表      
                },
                dataType: "json", 
                success: function (data) {         
                    if(data&&data.msg){
                      alert(data.msg);
                    }
                    //如果删除成功，刷新数据
                    if(data&&data.flag&&"true" == data.flag){
                        userSearch();
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
        alert("删除操作只能删除选中的考核中您自己创建的考核，确定删除吗？",p); 
    }
}

/**
 * 投票情况查看
 */
var answerRate = function(id){
    var model = jQuery("#gridTable").jqGrid('getRowData', id);
    var url = path+"/ccapp/oa/vote/jsp/paperanswerlist.jsp?windowId=windowId_answerRate&id="+model.id;
    openAlertWindows('windowId_answerRate',url,'评分情况查看','700px','450px','10%','25%');
  
 }

/**
 * 已提交问卷查看
 */
var submitPaper = function(id){
    var model = jQuery("#gridTable").jqGrid('getRowData', id);
    var url = path+"/ccapp/oa/vote/jsp/votecompletelist.jsp?windowId=windowId_submitPaper&paperId="+model.id;
    openAlertWindows('windowId_submitPaper',url,'已提交考核列表','800px','500px','10%','10%');
}
/**
 * 问卷预览
 */
var paperYL = function(id){
    var model = jQuery("#gridTable").jqGrid('getRowData', id);
    var page = "voteview.jsp";
    //人员评测暂时硬编码
    if(rycpid == model.papaer_type){
        page = "voteevalview.jsp";
    }
    var url = path+"/ccapp/oa/vote/jsp/"+page+"?windowId=windowId_paperYL&paperId="+model.id;
    //openAlertWindows('paperYL_windowId',url,'问卷预览','800px','600px','10%','20%');

    openWindows('windowId_paperYL','问卷预览'
            ,url,'cz_dwll',false,window);
 }
/** 
 * 问卷统计
 */
var paperTJ = function(id){
    var model = jQuery("#gridTable").jqGrid('getRowData', id);
    if(rycpid == model.papaer_type){     
        var url = path+"/ccapp/oa/vote/jsp/ajaxexcel.jsp?"
        +"windowId=windowId_paperTJ&paperId="+model.id;      
        jQuery('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>'+
        	   '<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">'+
               '</form>').appendTo("body").submit().remove();       
    }else{
      var url = path+"/ccapp/oa/vote/jsp/voteviewtotal.jsp?windowId=windowId_paperTJ&paperId="+model.id;
       //openAlertWindows('windowId_paperTJ',url,'问卷统计','800px','600px','10%','20%');
      openWindows('windowId_paperTJ','问卷统计'
            ,url,'cz_dwll',false,window);
    }
}
/**
 * 查看问答题
 */
var paperCK = function(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	//人员测评的条件
	if(rycpid == model.papaer_type){  
		 
	}else{
		//事件测评的条件
		var url = path+"/ccapp/oa/vote/jsp/answerlook.jsp?windowId=windowId_paperCK&paperId="+model.id;
		openWindows('windowId_paperCK','答案查看',url,'ck_dwll',false,window);
	}
}
</script>

</head>
<body>
<div><!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
<table id="queryTable" width="100%" border="0" cellspacing="0"
    cellpadding="0" class="tabs_search_ctable_box">
    <tr>
        <td><!-- 固定查询 -->
        <table width="100%" style="padding: 5px;" cellspacing="0"
            cellpadding="2" class="tabs_search_ctable">
            <tr>
                <th width="15%" class="input_cx_title_th">标题：</th>
                <td width="20%" class="cx_title_td"><input type="text"
                    id="title" name="title" class="input_cx_title_150" /></td>
              	<th class="input_cx_title_th" style="display:none;">创建人：</th>
                <td class="cx_title_td" style="display:none;"><input type="text" id="user_name"
                    name="user_name" class="input_cx_title_150" /></td>
                <th width="100" class="input_cx_title_th">考核类型：</th>
                <td class="cx_title_td" width="150"><select id="papaer_type"
                    name="papaer_type"
                    style="width: 133px; height: 23px; border: 1px solid #C6C6C6; font: 12px/ 20px '宋体';">
                    <option value="">--请选择--</option>
                    <%if(null !=paperTypeList && !paperTypeList.isEmpty()){
                      for(Map<String,Object> map : paperTypeList){
                          %>
                    <option value="<%=map.get("id") %>"><%=map.get("name") %></option>

                    <%
                      }
                  }%>

                </select></td>

                <td rowspan="2"><input value="搜索" id="sel" type="button"
                    onclick="userSearch()" class="but_y_01" /></td>
            </tr>
            <tr>
                <th class="input_cx_title_th">创建时间：</th>
                <td class="cx_title_td"><input class="date_120" type="text"
                    id="startdate" name="startdate"
                    onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'enddate\'||\'2099-01-01\')}',dateFmt:'yyyy-MM-dd'})" /></td>
                <th class="input_cx_title_th" style='text-align: center'>至</th>
                <td class="cx_title_td"><input class="date_120" type="text"
                    id="enddate" name="enddate"
                    onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startdate\'||\'1980-01-01\')}',dateFmt:'yyyy-MM-dd'})" /></td>
            </tr>
        </table>
        <!-- 固定查询 end--></td>
    </tr>
    <tr>
        <td></td>
    </tr>

</table>

<!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea">
<table id="gridTable"></table>
<div id="gridPager"></div>
</div>
<!-- 查询列表区 --></div>
</body>
</html>