<%--
　　描述：知识库文档列表--已发布 
　　作者：黄海
　　版本：1.0
　　日期：2013-08-06
--%>
<%@page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.upload.util.UploadConstants"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileUtil"%>
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
    String detailjsp = "kbmdocdetail.jsp";
    String tableName = "OA_FILEUPLOAD_KBM";
    String loadpath = path+UploadConstants.WEBPATH;
	String oType="1";
	//是否为体系文件管理员 
	boolean is_role= FileUtil.isRolesUser(k_create_user,"湖北特检院-体系文件管理员");
	if(is_role){
		k_create_user = "";
	}
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
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<script type="text/javascript" src="<%=path%>/ccapp/oa/resources/plug/fancyupload/myfancyupload.js" charset="utf-8"></script>

<!-- 引入提示 与tree -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>
<script src="../resources/js/kbmdoc.js" type="text/javascript"></script>
<script type="text/javascript">
var detailjsp = '<%=detailjsp%>';
var k_create_user = '<%=k_create_user%>';
var opentype = "published";

var k_unit = '<%=k_unit%>';
//搜索框的控制对象
$(function() {
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
    });
    jQuery("#k_type_name_button").click(function(){
        chooseFileType("k_type_id","k_type_name","","radio",false);
    });
    
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.kbm.list.KbmDocList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "k_doc_id",
            name : 'k_doc_id',
            index : 'k_doc_id',
            hidden : true
        }, {	
            label : "标题",
            name : 'k_title',
            index : 'k_title'
        }, {	
            label : "资料分类",
            name : 'k_type_name',
            index : 'k_type_name'
        }, {	
            label : "上传时间",
            name : 'k_create_time',
            index : 'k_create_time'
        }, {	
            label : "发布单位",
            name : 'k_unit_name',
            index : 'k_unit_name'
        }, {	
            label : "阅读情况",
            name : 'v_number',
            index : 'v_number',
            hidden : true
        }, {	
            label : "审核状态",
            name : 'k_flag_name',
            index : 'k_flag_name',
            hidden : true
        },{	
            label : "k_attach_id",
            name : 'k_attach_id',
            index : 'k_attach_id',
            hidden : true
        },{	
            label : "查看附件",
            name : 'act',
            index : 'act',
            width: 50
        },{
        	label : "下载附件",
        	name : 'xiazai',
        	index : 'xiazai',
        	width: 50
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
        gridComplete: function() {
        	var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
			for (var i = 0; i < ids.length; i++) {
				var cl = ids[i];
				var model = jQuery("#gridTable").jqGrid('getRowData', cl);
				v = "<strong><a href='javascript:void(0);' onMouseDown='checkEnrollment("+cl+")'><span style='color:red' id='sp'>"+model.v_number+"</span></a></strong>";
				var chakan = "<input class='but_y_01'  type='button' id='chakan' value='查看附件' onclick='lookfile(\""+cl+"\")'/>";
				var xiazai = "<input class='but_y_01'  type='button' id='chakan' value='下载附件' onclick='downFile(\""+cl+"\")'/>";
				jQuery("#gridTable").jqGrid('setRowData', ids[i], {
					v_number: v,
					act: chakan,
					xiazai : xiazai					
				});
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
       	toolbar : [ true, "top" ,"<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add value='编制' type='button' onclick='addKbmDocDetail()' value=''/><input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add value='导出' type='button' onclick='exportExcel()' /><input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='删除' id=del type='button' onclick='deleteFn()' value=''/>"],
       	multiselect : true, 
        onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
				jQuery("#gridTable").setSelection(id,false);
				var model = jQuery("#gridTable").jqGrid('getRowData', id);
        		updateKbmDocDetail(model.k_doc_id);
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
    var str = "{'opentype':'"+opentype+
    		"','k_create_user':'"+k_create_user+
    		"','k_title':'"+jQuery("#k_title").val()+
    		"','k_type_id':'"+jQuery("#k_type_id").val()+
    		"','k_create_time':'"+getWhere4Date()+"'}";
    return descape(escape(str));
}

/*
函数:  checkEnrollment
说明:  阅读和未阅读
参数:   无
返回值: 
*/
var checkEnrollment = function(id){
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var url = getCurrentFilePath()+'kbmdocuserreadymain.jsp?k_doc_id='+model.k_doc_id;
	var viewrate = jQuery(model.v_number).find("span").html();
	var notread =viewrate.substr(0,viewrate.indexOf("/"));
	var read =viewrate.substr(viewrate.indexOf("/")+1,viewrate.length)-notread;
	openAlertWindows('windowId',url,'阅读情况           已阅读人数：<span style="color:red">'+notread +'</span>' +'     未阅读人数：<span style="color:red">'+read+'</span>','700px','450px','20%','25%');
	
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
函数:  addKbmDocDetail
说明:  添加
参数:   无
返回值: 无
*/
var addKbmDocDetail = function () {
	var typeurl = 'opentype='+opentype;
  openAlertWindows('addKbmDocDetailWindow', getCurrentFilePath() +detailjsp+ '?'+typeurl+'&windowId=addKbmDocDetailWindow', '添加文件' ,1020,530,'10%','10%');
}

var openAttchList = function(k_attach_id){
	var url = "<%=path%>"+"/ccapp/oa/upload/jsp/uploadquerylist.jsp?windowId=openuploadlistWindow&tableName="+"<%=tableName%>&attach_id="+k_attach_id+"&oType=1";
	var windowId = 'openuploadlistWindow';
	openAlertWindows(windowId, url, '查看附件' ,1020,530,'10%','10%');
	/*
	openWin = PubOPT.jqOpen(url,
            {title: "查看附件",//属性
            draggable: true,
            resizable: false,
            height: 500,
            width: 800
        });*/
}

/*
函数:  clear
说明:  重置
参数:   无
返回值: 
*/
var clearParamJosn = function(){
    //清空输入框的值
   jQuery("input[type=text]").val("");
   jQuery("#k_type_id").val("");
   //查询
   search();
}

/*
	函数:  updateKbmDocDetail
	说明:  修改
	参数:  无
	返回值: 无
*/
var updateKbmDocDetail = function(k_doc_id) {
	var typeurl = 'opentype='+opentype; 
	openAlertWindows('updateKbmDocDetailWindow', getCurrentFilePath() +detailjsp+ '?'+typeurl+'&k_doc_id='+k_doc_id+'&windowId=updateKbmDocDetailWindow', '修改文件' ,1020,520,'10%','10%');
}

/**
 * 导出
 */
function exportExcel(){
	var url = getCurrentFilePath()+"/ajaxexcel4kbmdoc.jsp?"
    +"windowId=windowId_paperTJ&sJson="+toUserParamJosn();      
    jQuery('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>'+
           '<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">'+
           '</form>').appendTo("body").submit().remove();
}

//查看附件
function lookfile(id){
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
//下载
var downFile = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var file_id = model.djsn;//附件主键编号
	if(IsSpace(file_id)){
		alert("没有附件");
	}else{
		try{ 
	        var elemIF = document.createElement("iframe");   
	        elemIF.src = "<%=path%>/servlet/pubFileDownload?djsn="+model.djsn+"&openType=download&fileName="+encodeURI(model.fileName);   
	        elemIF.style.display = "none";
	        document.body.appendChild(elemIF);   
	    }catch(e){ 
	 
	    }
	}
} 
</script>
</head>
<body>
<div>
	<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
        <tr>
            <td>
	            <!-- 固定查询 -->
	            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
					<tr>
						<th class="input_cx_title_th">标题：</th>
						<td class="cx_title_td" style="width:150px;"><input type="text"
							id="k_title" name="k_title" class="input_cx_title_283"
							style="width: 133px;" />
						</td>
						<th class="input_cx_title_th">所属分类：</th>
						<td class="cx_title_td" style="width:160px;"><input
							name="k_type_name" id="k_type_name" type="text"
							readonly="readonly"
							class="validate[required,maxSize[100]] input_cx_title_283"
							style="width: 133px; height: 22px;" onclick='chooseFileType("k_type_id","k_type_name","","radio",false);' />  <input name="k_type_id"
							id="k_type_id" type="hidden" />
						</td>
					</tr>
					<tr>
						<th class="input_cx_title_th" style="width:100px;">上传时间：</th>
                    	<td class="cx_title_td"><input class="date_120 Wdate"
							type="text" id="begin_time" name="begin_time"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 137px;"/>
						</td> 
						<th class="input_cx_title_th">至：</th>
                    	<td class="cx_title_td">
                    		<input class="date_120 Wdate"
							type="text" id="end_time" name="end_time"
							onfocus="WdatePicker({minDate:'#F{$dp.$D(\'begin_time\')}',dateFmt:'yyyy-MM-dd'})" style="width: 137px;"/>
						</td>
						<td ><input value="搜索" id="sel" type="button" onclick="search();" class="but_y_01" />
							<input value="重置" id="sel" type="button" onclick="clearParamJosn();" class="but_y_01" />
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