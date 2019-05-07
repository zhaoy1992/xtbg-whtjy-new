<%-- 
描述：持证列表维护
作者：邱炼
版本：1.0
日期：2014-02-21
 --%>
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
	String hold_usesnid = "";//选择人员id
	String current = DateUtil.getCurrentDate(); //当天
	String year = (Integer.parseInt(DateUtil.getFormatCurrentTime("yyyy")) + 1)+"";//一年以后
	String vailendData = year +"-"+ DateUtil.getCurrentMonth()+"-"+DateUtil.getCurrentDay();
	
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
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<!-- 公共部分引用结束 -->
<script type="text/javascript">

var hold_usesnid = '<%=hold_usesnid%>';
jQuery(function() {
    $("#gridTable").jqGrid({
        url: '<%=path%>' + '/pubListServlet?classNameId=com.chinacreator.xtbg.core.personholder.list.HolderYujingList',  //pubListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
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
        //width: "1000",
        //默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
        colNames: ['主键id','持证人','持证项目','考证机构','证书编号','初次取证日期','发证日期','有效截止日期','持证级别','证书原件存放地','是否注册'],
        //字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
        colModel: [ //最重要的数组之一，用于设定各列的参数
        {
            name: 'hold_id',
            index: 'hold_id',
            hidden: true
        }, 
        {
            name: 'hold_userrealname',
            index: 'hold_userrealname',
            width:	200
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
            index : 'hold_state'
        },
        {
            name : 'register_flag',
            index : 'register_flag'
        }
        ],
        sortname: 'hold_usesnid desc ,hold_ratifytime ',
        //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
        sortorder: 'desc',
        viewrecords: true,
        
        //设置是否在Pager Bar显示所有记录的总数。
        rowNum: 10,
        //用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
        rowList: [10, 20, 30],
        //一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
        gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
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
        toolbar:[true, "top","<input type='button' class='but_excelout_01' title='导出excel表格' onMouseOver=javascript:$(this).attr('class','but_excelout_02'); onMouseOut=javascript:$(this).attr('class','but_excelout_01');  value='' onclick='exportFile()' style='margin-left:5px;'/>"],
        multiselect: false,
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


/**
 * 导出
 */
function exportFile(){
	var url = "${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/ajaxexcel.jsp";
    var html = new Array();
    html.push("<div id='export_excel'>");
    html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
    html.push("<input type='hidden' name='validStart_time' value='"+jQuery("#validStart_time").val()+"' /> ");
    html.push("<input type='hidden' name='validEtart_time' value='"+jQuery("#validEtart_time").val()+"' /> ");
    html.push("<input type='hidden' name='orgIds' value='"+jQuery("#orgid").val()+"' /> ");
    html.push("<input type='hidden' name='excelname' value='人员持证预警信息' /> ");//导出的主题
    html.push("<input type='hidden' name='excelImplClass' value='personHolderYujingToData' /> ");//导入导出的实现类，要提前在spring中或orcleConfig中配置好
    html.push("<input type='hidden' name='excelTemplateFilePath' value='personholder_excelTemplateFilePath' /> ");//导出的excel模版路径，要提前在系统properties中配置好
    html.push('</form>');
    html.push("</div>");
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body");
    jQuery("#downFrom").submit();
    jQuery("#export_excel").remove();
}

/*
     函数:  toUserParamJosn
     说明:  构建要查询的参数
     参数:   无
     返回值: 返回要查询的参数
     */
var toUserParamJosn = function() {
    var str = "{'validStart_time':'" + jQuery("#validStart_time").val()+
    "','validEtart_time':'" + jQuery("#validEtart_time").val() +
    "','orgIds':'" + jQuery("#orgid").val() +
    "','orgName':'" + jQuery("#orgname").val() + 
    "'}";
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
     说明:  添加问卷
     参数:   无
     返回值: 无
     */
var addLevel = function() {   
    openAlertWindows('windowId1',getCurrentFilePath() +'persionholdinfo.jsp?windowsId=windowId&actionName=insert&hold_usesnid='+hold_usesnid,"持证信息",800,300,'16%','25%');
}
 
/*
     函数:  updateLevel
     说明:  修改
     参数:   无
     返回值: 无
     */
var updateLevel = function(id) {
   var model = jQuery("#gridTable").jqGrid('getRowData', id);
   openAlertWindows('windowId1',getCurrentFilePath() +'persionholdinfo.jsp?windowsId=windowId&actionName=update&hold_usesnid='+hold_usesnid+'&hold_id='+model.hold_id,"持证信息",800,300,'16%','25%');
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
function chooseOrg (){
	  var s = new jQuery.z_tree_leftRigth();
	  s.treeID='mianDept';
	  s.isShowSeacher="aa";
	  s.treeName="选取部门";
	  s.headerName="选取部门";
	  s.titelText = "选取部门";
	  s.rightHeaderText="已添加机构和人员";
	  s.returnFunction=function(orgObj){
		  if(IsSpace(orgObj.dept) || null ==orgObj.dept )
		  	{
			   jQuery('#orgid').val('');
			   jQuery('#orgname').val('');
			 }else{
				jQuery('#orgid').val(orgObj.dept.id);
				jQuery('#orgname').val(orgObj.dept.name);
			 }
	  }
	  s.treeList=
			  [{
				  leftHeaderText:'按部门选择',
				  item_id :'org_id',
				  isType:'dept', 
				  valueKey:'dept',
				  selectedIds:jQuery('#orgid').val(),
				  type:"ADEPT"
			}];
	  s.init();
}
</script>
</head>
<body style="overflow-y:auto;">
<div>
	<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
	<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
			<tr>
				<td>
					<!-- 固定查询 -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
						   <tr>
								<th width="90" class="input_cx_title_th">有效日期：</th>
								<td width="296"  class="cx_title_td">
									<input type="text" name="validStart_time" id="validStart_time" class="date_120 Wdate" value="<%=current %>"  onclick="WdatePicker({maxDate:'#F{$dp.$D(\'validEtart_time\')}',dateFmt:'yyyy-MM-dd'})">
									<span  style="float:left; font:12px/20px "宋体"; margin:0 6px 0 7px;">至</span>
									<input type="text" name="validEtart_time" id="validEtart_time" class="date_120 Wdate" value="<%=vailendData %>" onclick="WdatePicker({minDate:'#F{$dp.$D(\'validStart_time\')}',dateFmt:'yyyy-MM-dd'})">
								</td>
								<td width="385"  colspan="3"  >
									<input value="搜索" id="sel" type="button" onclick="userSearch()" class="but_y_01"/>
									<span id="selAreaImg" class="all_search_condition"><a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span>
								</td>
						</tr>
					</table>
					<!-- 固定查询 end-->
				</td>
			</tr>
			<tr>
				<td id="hiddenArea"  style="display:none">
					<!-- 隐藏查询 -->
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" >
						<!-- 正规 4列 -->
						<tr>
							<td align="left" class="input_cx_title_th">工作部门：</td>
							<td align="left" width="296" class="cx_title_td" colspan="4">
							    <input name="orgid"  id="orgid"  style="float:left;" type="hidden" />
						 	    <input name="orgname"  id="orgname"  style="float:left;" onclick="chooseOrg();" type="text" class="input_cx_title_188" readonly="readonly"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			</table>
	<div>
		<!-- 查询列表区 cGridArea(查询区样式)-->
		<div class="cGridArea">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
		</div>
		<!-- 查询列表区 -->
	</div>
</div>
<form id="delForm2" name="delForm2" method="post" action="persionholdinfodo.jsp">
	<input type="hidden" name="delete" id="delete"> 
	<input type="hidden" name="action" value="deleteInf">
</form>
<iframe name="hiddenFrame2" width=0 height=0></iframe>
</body>
</html>