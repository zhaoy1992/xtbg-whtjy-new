<%-- 
描述：持证列表维护
作者：邱炼
版本：1.0
日期：2014-02-21
 --%>
<%@page import="com.chinacreator.xtbg.core.personholder.util.PersonHolderConstants"%>
<%@page import="com.chinacreator.xtbg.core.personholder.util.PersonHolderUtil"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
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
	String windowsId = StringUtil.deNull(request.getParameter("windowsId"));//窗口id
	String hold_usesnid = StringUtil.deNull(request.getParameter("hold_usesnid"));//选择人员id
	//人员持证管理员角色
	boolean isROLE = PersonHolderUtil.isRolesUser(userId, PersonHolderConstants.ROLE_NAME);
	//部室持证管理员
	boolean isPersionRole = PersonHolderUtil.isRolesUser(userId, PersonHolderConstants.ORG_PERSIONROLE);
%>
<title>问卷</title>
<!-- 引入jQuery -->
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="<%=path%>/ccapp/oa/resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入my97时间控件 -->
<script src="<%=path%>/ccapp/oa/resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<script src="<%=path%>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="<%=path%>/ccapp/oa/resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="<%=path%>/ccapp/oa/resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<!-- 引入上传控件 -->
<script type="text/javascript" src="<%=path%>/ccapp/xtbg/resources/plug/fancyupload/mootools-1.2.5-core-jm.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/xtbg/resources/plug/fancyupload/source/Fx.ProgressBar.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/xtbg/resources/plug/fancyupload/source/Swiff.Uploader.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/xtbg/resources/plug/fancyupload/source/FancyUpload3.Attach.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=path%>/ccapp/xtbg/resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">

var hold_usesnid = '<%=hold_usesnid%>';
jQuery(function() {
    $("#gridTable").jqGrid({
        url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.personholder.list.HolderList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype: "json",
        //这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
        mtype: "POST",
        pageCached:false,
        //定义使用哪种方法发起请求，GET或者POST
        height: "100%",//270
        //Grid的高度，可以接受数字、%值、auto，默认值为150
        //width ："1800", //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
        //shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
        autowidth: true,
        //width: "1000",
        //默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
        colNames: ['主键id','持证项目','考证机构','证书编号','初次取证日期','发证日期','有效截止日期','持证级别','证书原件存放地','是否注册','附件','djsn','filename','备注'],
        //字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
        colModel: [ //最重要的数组之一，用于设定各列的参数
        {
            name: 'hold_id',
            index: 'hold_id',
            hidden: true
        }, 
        {
            name: 'hold_name',
            index: 'hold_name',
            width:	200
        },
        {
            name : 'hold_org',
            index : 'hold_org'
        },{
            name : 'hold_number',
            index : 'hold_number'
        },
        {
            name : 'hold_ratifytime',
            index : 'hold_ratifytime'
        },        
        {
            name : 'hold_replactime',
            index : 'hold_replactime'
        },
        {
            name : 'hold_validtime',
            index : 'hold_validtime'
        },
        {
            name : 'hold_level',
            index : 'hold_level'
        },
        {
            name : 'hold_state',
            index : 'hold_state',
            width : 200
        },
        {
            name : 'register_flag',
            index : 'register_flag'
        },
        {
        	name : 'attachment_id',
        	index : 'attachment_id',
        	formatter:function(cellvalue, options, rowObject){
				if(IsSpace(rowObject.djsn)){
					return "没有附件";
				}else{
					return "<input class='but_y_01'  type='button' id='notice' value='查看' onclick='lookattch("+options.rowId+")'/>";  
				}
			}
        },
        {
            name : 'djsn',
        	index : 'djsn',
        	hidden : true
        },
        {
            name : 'filename',
        	index : 'filename',
        	hidden : true
        },
        {
            name : 'hold_remark',
            index : 'hold_remark'
        }
        ],
        sortname: 'creator_time',
        //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
        sortorder: 'asc',
        viewrecords: true,
        
        //设置是否在Pager Bar显示所有记录的总数。
        rowNum: 5,
        //用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
        rowList: [5, 10, 15],
        //一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
        gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
            var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
            for (var i = 0; i < ids.length; i++) {
                var cl = ids[i];
            }
        },
        jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
            repeatitems: false
        },
        pagerintoolbar:true,//上面的分页条
        pagerinBottombar:true,//下面的分页条
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
        toolbar:[true, "top",
             <%if(isROLE==true || isPersionRole==true){%>
                 "<input class='but_y_01' id='addQuestion' value='添加' type='button'"
                 +" onclick='addLevel()' value=''/>"
                 +"<input class='but_y_01' value='删除' id='delQuestion' type='button'"
                 +" onclick='deleteFn()' value=''/>"
                 +"<input class='but_y_01' value='打印' id='printHolder' type='button'"
                 +" onclick='printHolder()' value=''/>"
             <%}else{%>
                 "<input class='but_y_01' value='打印' id='printHolder' type='button'"
                 +" onclick='printHolder()' value=''/>"
             <%}%>
                 ],
        multiselect: true,
        onCellSelect:function (id,iCol)
        {
            if(iCol != 0)
            {
                updateLevel(id);
            }
        }
    }).navGrid('#gridPager', {
        edit: true,
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
    var str = "{'hold_usesnid':'" + hold_usesnid
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
函数:  printHolder
说明:  打印持证信息
参数:   无
返回值: 无
*/
var printHolder = function() {   
    var url = "printHoldinfoexcel.jsp";
    var html = new Array();
    html.push("<div id='export_excel'>");
    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
    html.push("<input type='hidden' name='userids' value='"+hold_usesnid+"' /> ");
    html.push('</form>');
    html.push("</div>");
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body");
    jQuery("#downFrom").submit();
    jQuery("#export_excel").remove();
}


     /*
     函数:  addlevel
     说明:  添加问卷
     参数:   无
     返回值: 无
     */
var addLevel = function() {   
    openAlertWindows('windowId1',getCurrentFilePath() +'persionholdinfo.jsp?windowsId=windowId&actionName=insert&hold_usesnid='+hold_usesnid,"持证信息",800,440,'16%','25%');
}
 
/*
     函数:  updateLevel
     说明:  修改
     参数:   无
     返回值: 无
     */
var updateLevel = function(id) {
   var model = jQuery("#gridTable").jqGrid('getRowData', id);
   openAlertWindows('windowId1',getCurrentFilePath() +'persionholdinfo.jsp?windowsId=windowId&actionName=update&hold_usesnid='+hold_usesnid+'&hold_id='+model.hold_id,"持证信息",800,440,'16%','25%');
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
        if(!IsSpace(model.hold_id)){
            ids.push(model.hold_id);
        }
    });
        
    if (!ids.length) {
        alert("请选择要删除的记录！");
    } else {
    	var okF = function(){
			$("#delete").val(ids);
			var fm = document.getElementById("delForm2");
			fm.target = "hiddenFrame2";
			fm.submit();
		}
        var p={
                    headerText:'提示',
                    okName:'确认',
                    okFunction:okF,
                    cancelName:'取消'
            };
        alert("确定要删除选中的信息吗？",p);
    }
}
afterSubmitFn=function(result){
	try{
		if(result.indexOf("delete")!=-1){
			alert(result.split(",")[1]);
			userSearch();
		}else{
			if(result.split(",").length>1){
					result = result.split(",");
					alert(result[0]);
					userSearch();
			} else {
				alert(result);
				userSearch();
			}
			
		}
	}catch(e){alert(e.description);}
};
//查看附件
var lookattch = function(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var djsn = model.djsn;//附件主键编号
	var filename = model.filename;//附件主键编号
	var url = "<%=path%>/ccapp/oa/archive/viewpdf.jsp?type=rycz&djsn="+djsn;
	openAlertWindows('windowId',url,'预览文件',1500,710,0,0)
	//MyFancyupload.rootPath='<%=path%>';
	//MyFancyupload.onlineEditFile(djsn);
}
</script>
</head>
<body>
<div><!-- 查询列表区 cGridArea(查询区样式)-->
<div class="cGridArea">
<table id="gridTable"></table>
<div id="gridPager"></div>
</div>
<!-- 查询列表区 --></div>
<form id="delForm2" name="delForm2" method="post" action="persionholdinfodo.jsp">
	<input type="hidden" name="delete" id="delete"> 
	<input type="hidden" name="action" value="deleteInf">
</form>
<iframe name="hiddenFrame2" width=0 height=0></iframe>
</body>
</html>