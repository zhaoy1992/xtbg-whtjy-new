<%--
　　描述：知识库查询 
　　作者：黄海
　　版本：1.0
　　日期：2013-08-13
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    String k_create_user = controler.getUserID();
    UserCacheBean usercachebean=UserCache.getUserCacheBean(k_create_user);
    String k_unit=usercachebean.getUnit_id();//单位
    String k_unit_name=usercachebean.getUnit_name();
    String k_type_id = StringUtil.deNull(request.getParameter("k_type_id"));
    String k_type_name = StringUtil.deNull(request.getParameter("k_type_name"));
    String tableName = "OA_FILEUPLOAD_KBM";
    String detailjsp = "kbmdocdetail4query.jsp";
%>
<title>知识库文档列表</title>
<!-- 公共部分开始 -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入提示 与tree -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script src="../resources/js/kbmdoc.js" type="text/javascript"></script>
<script type="text/javascript">
var detailjsp = '<%=detailjsp%>';
var k_create_user = '<%=k_create_user%>';
var opentype = "query";

var k_unit = '<%=k_unit%>';
var k_type_id = '<%=k_type_id%>';
var k_type_name = '<%=k_type_name%>';
//搜索框的控制对象
$(function() {
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
    });
    
    jQuery("#k_type_id").val(k_type_id);
	jQuery("#k_type_name").val(k_type_name);
    
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.kbm.list.KbmDocList4Where', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        pageCached:false,
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "k_doc_id",
            name : 'k_doc_id',
            index : 'k_doc_id',
            hidden : true
        },{
            label : "k_attach_id",
            name : 'k_attach_id',
            index : 'k_attach_id',
            hidden : true
        },{
            label : "k_is_read",
            name : 'k_is_read',
            index : 'k_is_read',
            hidden : true
        }, {	
            label : "标题",
            name : 'k_title',
            index : 'k_title',
            formatter : publicFormatter,
            width : 230
        }, {	
            label : "资料分类",
            name : 'k_type_name',
            index : 'k_type_name',
            formatter : publicFormatter,
            width : 230
        }, {	
            label : "上传人",
            name : 'k_create_user_name',
            index : 'k_create_user_name',
            hidden : true
        }, {	
            label : "上传时间",
            name : 'k_create_time',
            index : 'k_create_time',
            formatter : publicFormatter,
            width : 90
        },{
            label : "查看附件",
            name : 'lookatt',
            index : 'lookatt',
            width:40,
            formatter:function(cellvalue, options, rowObject){
				return "<input class='but_y_01'  type='button' id='notice' value='查看附件' onclick='lookattch("+options.rowId+")'/>";  
			}
        },{
            label : "下载附件",
            name : 'xiazai',
            index : 'xiazai',
            width:40,
            formatter:function(cellvalue, options, rowObject){
				return "<input class='but_y_01'  type='button' id='notice' value='下载附件' onclick='downFile("+options.rowId+")'/>";  
			}
        },{
        	label : "djsn",
            name : 'djsn',
            index : 'djsn',
            hidden : true
        },{
        	label : "file_type",
            name : 'file_type',
            index : 'file_type',
            hidden : true
        },{
        	label : "filename",
            name : 'filename',
            index : 'filename',
            hidden : true
        }
        ],
        sortname : 'k_title',
        //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
        sortorder : 'asc',
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
       	multiselect : true, 
        onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
				var model = jQuery("#gridTable").jqGrid('getRowData', id);
        		updateKbmDocDetail(model.k_doc_id);
			}
		}
    });
    
});
/**
 *公用的列格式函数(设置未读加粗)
 *@param value:当前列的值
 *@param column:当前列对象
 *@param 当前行对象
 */
var publicFormatter = function(value,column,model){        
    if("1"!=model.k_is_read){
        value = "<span style='font-weight:bolder;'>"+value+"</span>";
    }            
    return value;
}
    /*
        函数:  toUserParamJosn
        说明:  构建要查询的参数
        参数:   无
        返回值: 返回要查询的参数
     */
    var toUserParamJosn = function() {
       	var str = "{'opentype':'"+opentype+
	       	"','k_type_id':'"+jQuery("#k_type_id").val()+
	       	"','k_title':'"+jQuery("#k_title").val()+
	   		"','k_dept':'"+jQuery("#k_dept").val()+
	   		"','k_create_time':'"+getWhere4Date()+
	   		"','k_create_user':'"+k_create_user+"'}";
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
  函数:  updateKbmDocDetail
  说明:  修改
  参数:  无
  返回值: 无
*/
var updateKbmDocDetail = function(k_doc_id) {
	  var backFn = function(){window.location.reload();};
	  var typeurl = 'opentype='+opentype; 
	  openAlertWindows('updateKbmDocDetailWindow', getCurrentFilePath() +detailjsp+ '?'+typeurl+'&k_doc_id='+k_doc_id+'&windowId=updateKbmDocDetailWindow', '查看' ,1020,520,'5%','3%',backFn);
}
//查看附件
var lookattch = function(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var file_id = model.djsn;//附件主键编号
	var file_extra = trim(model.file_type);//文件类型
	var height = window.screen.availHeight;
	var width = window.screen.availWidth;
	if(IsSpace(file_id)){
		alert("没有附件");
	}else{
		if(file_extra =='.doc' || file_extra =='.docx'){
			window.open("<%=path%>/servlet/pubFileDownload?djsn="+model.djsn+"&openType=online&fileName="+encodeURI(model.fileName),"_blank","width="+width+",height="+height+",left=0px,top=0px");
		}else if(file_extra =='.pdf'){
			var url = "<%=path%>/ccapp/oa/archive/viewpdf.jsp?djsn="+file_id;
			openAlertWindows('windowId',url,'预览文件',1500,710,0,0);
		}else{
			alert("暂不支持在线预览！");
		}
	}
}
/*
函数:  openWord
说明:  新打开一个word的查看
参数:  fileId  文档ID值
返回值: 无
*/
function openWord(fileId){
	openAlertWindows('openwordWindow', getCurrentFilePath() +"openWordKBM.jsp"+ '?'+'fileId='+fileId+'&windowId=openwordWindow', '查看' ,1020,520,'5%','3%');
}

/*
函数:  addFavorites
说明:  添加收藏
参数:  无
返回值: 无
*/
var addFavorites = function (id) {
    var ids = "";
    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
    var ids = new Array();
    $(selectedIds).each(function () {
        var model = jQuery("#gridTable").jqGrid('getRowData', this);
        ids.push(model.k_doc_id);
    });
    if (!ids.length) {
        alert("未选中文档项，请重新选择要收藏的文档项！");
    } else {
        var okF = function () {
            jQuery.ajax({
                type: "post",
                url: "kbmdocdetaildo.jsp",
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data: {
                    action: "addfavorites",
                    k_doc_ids: ids.join(",") //要删除的id列表      
                },
                dataType: "json",
                success: function (result) {
                    if (result) {
                        alert("操作成功！");
                        search();
                    } else {
                        alert("操作失败！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("系统异常，请稍后再试！");
                }
            });
        }
        var p = {
            headerText: '提示',
            okName: '确认',
            okFunction: okF,
            cancelName: '取消'
        };
        alert("确定收藏吗？", p);
    }
}
/*
 * 选部门
 */
var chooseOrg = function (){
	var s = new $.z_tree();
	s.treeID='mian';
	s.treetypestr='radio';
	s.isShowSeacher=true;
	s.treeName="选取部门";
	s.isType='dept';
	s.headerName="选取部门";
	s.item_id = 'org_id';
	s.selectedIds=$('#k_dept').val();
	s.type='ADEPT';
	s.returnFunction=function(orgObj){
		if(!IsSpace(orgObj)){
		    $('#k_dept').val(orgObj.id);
		    $('#k_dept_name').val(orgObj.name);
		}else{
		    $('#k_dept_name').val("");
		    $('#k_dept').val("");
		}
	}
	s.init();
}
var clear111 = function(){
    //清空输入框的值
   jQuery("input[type=text]").val("");
   jQuery("#k_dept").val("");
   //查询
   search();
}

//下载
var downFile = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var file_id = model.djsn;//附件主键编号
	if(IsSpace(file_id)){
		alert("没有附件");
	}else{
		try{ 
	        var elemIF = document.createElement("iframe");   
	        elemIF.src = "<%=path%>/servlet/pubFileDownload?djsn="+model.djsn+"&openType=download&fileName="+encodeURI(model.filename);   
	        elemIF.style.display = "none";
	        document.body.appendChild(elemIF);   
	    }catch(e){ 
	 
	    }
	}
} 

/**
 * [downloadaftercallback 下载点击后的调用的函数。
 * 如有业务需求，在页面自行重载，但重载的函数记得放在该js之后]
 */
function downloadaftercallback(){
}
function getProjectName() {
    return "/" + window.location.pathname.substring(1).split("/")[0];
}
/*
函数:  downloadFile
说明:  批量下载文件
*/
function downloadFile() {
	var ids = "";
    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
    var ids = new Array();
    $(selectedIds).each(function () {
        var model = jQuery("#gridTable").jqGrid('getRowData', this);
        var file_id = model.djsn;//附件主键编号
        if(!IsSpace(file_id)){
        	ids.push("'"+file_id+"'");
		}
    });
    if(!ids.length) {
        alert("未选中文件项或所选文件项无附件，请重新选择要下载的文件项！");
    }else{
    	ids = ids.join(",") //要下载的id列表      
    	var url = "/ccapp/oa/kbm/jsp/downfileload.jsp?table_name=oa_fc_attach&attach_id="+ids;
		var urlpath = getProjectName();
	    location.href = getProjectName() + url;
    } 
}

</script>
</head>
<body>
<div>
	<!-- 固定查询 -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="tabs_search_ctable" >
		<tr >
			<th class="input_cx_title_th">标题：</th>
			<td class="cx_title_td" style="width: 350px" >
				<input type="text" id="k_title" name="k_title" class="input_cx_title_283" style="width: 133px; float: left;" />
				<span style="float:left">所属部门：</span>
				<input type="text" class="input_cx_title_283"  style="width: 133px;"  id="k_dept_name" name="k_dept_name" readonly onclick='chooseOrg()' />
				<input type="hidden" id="k_dept" name="k_dept" >
				<input type="hidden" id="k_type_id" name="k_type_id" >
				<input type="hidden" id="k_type_name" name="k_type_name" >
			</td>
		</tr>
		<tr >
			<th class="input_cx_title_th" >上传时间：</th>
			<td class="cx_title_td"  >
				<input id="begin_time" name="begin_time" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'end_time\')}',dateFmt:'yyyy-MM-dd'})" style="float:left;width: 137px;" class="date_120 Wdate" type="text"/>
				<span style="float:left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至：</span>
				<input class="date_120 Wdate" type="text" id="end_time" name="end_time" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'begin_time\')}',dateFmt:'yyyy-MM-dd'})" style="width: 137px;"/>
			</td>
			<td>
				<input value="搜索" id="sel" type="button"onclick="search();" class="but_y_01" />
				<input value="重置" id="reset" type="button" onclick="clear111();" class="but_y_01" />
			</td>
		</tr>
	</table>
	<!-- 查询列表区 cGridArea(查询区样式)-->
    <div class="cGridArea">
    	<div id="tool_buttons" class="ui-jqgrid .ui-userdata ui_t_bottombar_content" 
         style="width:97%;height:28px;margin-left:10px;margin-bottom:0px;float: none;border: #ebebeb 1px solid;padding-right: 10px;">            
           <input name="exportButton" id="exportButton" onclick="addFavorites();" value="收藏" type="button" class="but_y_01" style="float: left;margin-left: 5px;" />
           <input name="downButton" id="downButton" onclick="downloadFile();" value="批量下载" type="button" class="but_y_01" style="float: left;margin-left: 5px;" />
     	</div>
        <table id="gridTable"></table>
        <div id="gridPager"></div>
    </div>
</div>
</body>
</html>