<%--
describe:添加档案时需要的文件列表
author:dailianchun
date: 2013-7-22
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileFilesBean"%>
<html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    String id = StringUtil.deNull(request.getParameter("id"));//档案id
    FileFilesService service =  new FileFilesServiceImpl();
    FileFilesBean bean =  service.queryToFileFilesBean(id);
  //进入页面后，只能查看，不能进行其他任何操作
    String isview = StringUtil.deNull(request.getParameter("isview"));
%>
<title></title>
<!-- 公共部分开始 -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="../resources/js/jquery.contextmenu.js" type="text/javascript"></script>
<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>

<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="../resources/js/filedoclist4file.js" type="text/javascript"></script>
<script type="text/javascript">
var path = "<%=path%>";
var fileId = "<%=id%>"; 
//搜索框的控制对象
$(function() {
	<%if(!StringUtil.nullOrBlank(isview)){%>
		jQuery(".content_02_top").hide();
	<%}%>
	
    $(document).keydown(function(){
        if(event.keyCode == 13){//回车键
           docNumberFn.saveRow('#gridTable','#form1');           
        }
        if(event.keyCode == 27){//ESC键
            docNumberFn.restoreRow('#gridTable');
        }
    });
    adaptationWH('','vcenter',120);
    $("#gridTable").jqGrid({
    	gridComplete: function(){
    		var num = jQuery("#gridTable")[0].p.records;
    		parent.jQuery("#tabTitle2").html("卷内文件("+num+")");
    		var jianhao = jQuery("#OA_FILE_FILES__F_FILES_NUM",parent.jQuery("#frame1")[0].contentWindow.document);
    		jianhao.attr("readOnly","readOnly");
    		jianhao.val(num);
    	},
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FileDocListForFiles', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "f_doc_id",
            name : 'f_doc_id',
            index : 'f_doc_id',
            hidden : true,
            editable :true,
            edittype : 'text'   
        }, {//由于列编辑时，值已经被替换，故重新定义一列用来编辑
            label : "f_doc_id2",
            name : 'f_doc_id2',
            index : 'f_doc_id2',
            formatter: function(value,column,model){
               return model.f_doc_id;
            },
            hidden : true  
        }, {
            label : "件号",
            name : 'f_doc_num',
            index : 'f_doc_num',
            <%if(StringUtil.nullOrBlank(isview)){%>
            editable :true,
            edittype : 'custom',            
            editoptions : {
        	   custom_element: function(value,b){   
                  return jQuery(
                          '<input style = "width:95%;height:23px;line-height:23px;" type="text" '
                          +'onkeyup="this.value=this.value.replace(/\\D/g,\'\')" onkeypress="this.value=this.value.replace(/\\D/g,\'\')"'
                          +'class="validate[required,maxSize[8],custom[positiveinteger]] input_160" '
                          +' name="f_doc_num" id="'+b.id+'_self" value="'+value+'"/>'
                          )[0];
      	       }, 
        	   custom_value:function(el){
                  return jQuery(el).val();
      	       }
            }	
            <%}else{%>
            	editable :false
            <%}%>
        },{    
            label : "字号",
            name : 'f_doc_fontsize',
            index : 'f_doc_fontsize'
        }, {    
            label : "文件标题",
            name : 'f_doc_name',
            index : 'f_doc_name',
            width:200
        }, {    
            label : "归档状态",
            name : 'f_doc_state_name',
            index : 'f_doc_state_name',
            hidden : true
        },{
            label : "责任者",
            name : 'f_doc_blname',
            index : 'f_doc_blname'
        }, {    
            label : "文件形成日期",
            name : 'f_file_formtime',
            index : 'f_file_formtime'
        }, {    
            label : "文档与文件对应关系表id",
            name : 'f_docfiles_id',
            index : 'f_docfiles_id',
            hidden : true
        },{
            label : "备注",
            name : 'f_secrecy_name4export',
            index : 'f_secrecy_name4export',
            width:50
        }
        ],
        editurl : path+"/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=updateDocNum", 
        sortname : 'to_number(f_doc_num)',
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
        postData : toUserParamJosn(),
        prmNames : { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
        	 rows : "rows",
             //表示请求行数的参数名称  
             sort : "sidx",
             //表示用于排序的列名的参数名称  
             order : "sord",
             //表示采用的排序方式的参数名称 
             search : "search"
        },   
        toolbar : [ false, "top" ,"<input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); id=add value='添加' type='button' onclick='addFileDocDetail()' value=''/><input class='but_y_01' onMouseOver=javascript:$(this).attr('class','but_y_02'); onMouseOut=javascript:$(this).attr('class','but_y_01'); value='删除' id=del type='button' onclick='deleteFn()' value=''/>"],
        multiselect : true, 
        onCellSelect:function (id,iCol){           
     	if(iCol != 0)
         {
     		if(iCol == 3){        			
                    //修改行数据
                    docNumberFn.editRow(id,jQuery("#gridTable"));   
                }else{
                    var model = jQuery("#gridTable").jqGrid('getRowData',id);
                    updateFileDocDetail(model.f_doc_id2);
                }
         }
       } 
                              
        });
    jQuery("#gridTable").jqGrid('navGrid',"#p43rowed3",{edit:false,add:false,del:false});
    jQuery("#gridTable").jqGrid('inlineNav',"#p43rowed3");         
       
    });
   
    /*
        函数:  toUserParamJosn
        说明:  构建要查询的参数
        参数:   无
        返回值: 返回要查询的参数
     */
    var toUserParamJosn = function(){
    	 var param = {
    	              filesId : "<%=id%>"
    	 };
    	//转码
        for(var name in param ){
            param[name] = descape(escape(param[name]));
        }
        return param;
    }

    /*
     函数:  search
     说明:  查询
     参数:   无
     返回值: 
     */
  var search = function(){
      var sdata = toUserParamJosn(); //获得当前postData选项的值  
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
  函数:  addFileDocDetail
  说明:  添加
  参数:   无
  返回值: 无
*/
var addFileDocDetail = function (){
    var sF_TYPE_ID = '1';
    var sF_TYPE_NAME = '添加文件';
    //参数
    var typeurl = window.parent.getUrl4addDoc();
    openAlertWindows('addFileDocDetailWindow', getCurrentFilePath() 
    	    + 'filedocdetail.jsp?isgd=yes&busiTypeCode=wj-001&windowId=addFileDocDetailWindow'+typeurl, '添加文件' ,1020,530,'10%','10%');
}

/*
  函数:  updateFileDocDetail
  说明:  修改
  参数:  无
  返回值: 无
*/
var updateFileDocDetail = function(f_doc_id) {
	  <%if(!StringUtil.nullOrBlank(isview)){%>
	  openAlertWindows('updateFileDocDetailWindow',
   	       getCurrentFilePath() + 'filedocdetail.jsp?isgd=yes&busi_id='
   	       +f_doc_id+"&f_doc_id="+f_doc_id+'&isview=<%=isview%>&busiTypeCode=wj-001&windowId=updateFileDocDetailWindow'
   	       +window.parent.getUrl4addDoc(), 
   	       '查看文件' ,1020,520,'10%','10%');
	  <%}else{%>
	  openAlertWindows('updateFileDocDetailWindow',
   	       getCurrentFilePath() + 'filedocdetail.jsp?isgd=yes&busi_id='
   	       +f_doc_id+"&f_doc_id="+f_doc_id+'&busiTypeCode=wj-001&windowId=updateFileDocDetailWindow'
   	       +window.parent.getUrl4addDoc(), 
   	       '修改文件' ,1020,520,'10%','10%');
	  <%}%>
      
}
/**
 * 更新文件
 */
var updateByButton = function(){
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
    if (1!= selectedIds.length) {
           alert("请选中且只选中一条记录");
           return;
       }
   //放弃所有的修改
   //docNumberFn.restoreRow('#gridTable');  
   var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[0]);//文件id
   updateFileDocDetail(model.f_doc_id2);
}
/*
     函数:  deleteFn
    说明:  文件出卷
    参数:  无
    返回值: 无
*/
var deleteFn = function() {
        var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
        var ids = new Array();//文档，文件对应关系表id
        var docIds = new Array();//文件id
        $(selectedIds).each(function () {
            var model = jQuery("#gridTable").jqGrid('getRowData', this);
            //id不为空
            ids.push(model.f_docfiles_id);  
            docIds.push(model.f_doc_id2);
        });
            
        if (!ids.length) {
            alert("未选中记录,请重新选择");
        } else {
            var okF = function(){
                //ajax方式提交数据
                jQuery.ajax({ 
                    type: "post", 
                    url: path+"/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=deleteDocFiles", 
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    data : {
                        ids : ids.join(","), //要删除的id列表      
                        docIds : docIds.join(",")//文档id列表
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
            alert("确定要出卷吗？",p); 
        }
    }


/**
 *文件入卷弹出窗
 */
var addDocToFiles = function(){
	var urlArray = new Array();
    urlArray.push(getCurrentFilePath()+'filedoclist4addtofiles.jsp?windowId=addDocToFiles');
    //调用父页面的函数
    urlArray.push("&busiTypeCode=wj-001");
    urlArray.push(window.parent.getUrl4addDoc());
   
    var url = urlArray.join("");
    openAlertWindows('addDocToFiles'
                ,url,'文件入卷'
                ,700,480,'10%','20%');

}


/*
函数:  批量修改
参数:  无
返回值: 无
*/
var updateList = function() {
    var ids = "";
    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
    var ids = new Array();
    $(selectedIds).each(function () {
        var model = jQuery("#gridTable").jqGrid('getRowData', this);
        //id不为空
        ids.push(model.f_doc_id2);
    });
    var urlArray = new Array();
    urlArray.push(getCurrentFilePath()+'filedocupdate.jsp?windowId=updateListFileDoc');
    urlArray.push("&ids="+ids.join(","));
    urlArray.push("&busiTypeCode=wj-001");
    //档案id
    urlArray.push("&f_files_id=<%=id%>");
    var url = urlArray.join("");
    openAlertWindows('updateListFileDoc'
                ,url,'批量修改文件信息'
                ,600,360,'10%','20%');

}

/**
 * 修改grid的行数据
 */
var docNumberFn = {
    editRowArray : new Array(),//已编辑尚未保存的
    isEditRow : function(id){//判断行是否已经是可编辑的
       for(var i=0;i<this.editRow.length;i++){
          if(id == this.editRow[i]){
            return true;
          }
       }
       return false;
    },
    restoreRow : function(grid){//取消编辑
    	for(var i=0;i<this.editRowArray.length;i++){
    		 jQuery(grid).jqGrid('restoreRow',this.editRowArray[i]);
    	}
    	//防止泄露，先设置为null
    	this.editRowArray = null;
    	this.editRowArray = new Array(); 
    	jQuery("#docNumberButton").attr("disabled","disabled");
    },
    editRow : function(id,grid){//编辑
      if(this.isEditRow(id)){
        return;
      }
      jQuery(grid).jqGrid('editRow',id,true);
      this.editRowArray.push(id);
      jQuery("#docNumberButton").removeAttr("disabled");
    },
    saveRow : function(grid,form){//提交行编辑的数据
       if(form){
          
           //如果传入了表单id，则进行表单验证
         if(!jQuery(form).validationEngine('validate') ){
             return ;
         }
       }
       //保存数据时存在多行数据会分多次提交的问题。由于时间紧迫，暂时不处理此问题。等有时间再行解决
       for(var i=0;i<this.editRowArray.length;i++){
           jQuery(grid).jqGrid('saveRow',this.editRowArray[i]);
       }
       //防止泄露，先设置为null
       this.editRowArray = null;
       this.editRowArray = new Array(); 
       jQuery("#docNumberButton").attr("disabled","disabled");
    }
 };

/**
 *导出案卷列表
 */
function exportExcelList(){
    var exportKey = [ "f_doc_num","f_doc_blname","f_doc_fontsize"
                      ,"f_doc_name","[needALocation]","f_file_formtime4export","f_file_quantity","f_secrecy_name4export"];
    var exportHeader = ["件号","责任者","文号  ","题        名","","日期","页数 ","备注"];
    var data = {
        exportKey : exportKey.join(","),
        exportHeader : descape(escape(exportHeader.join(","))),
        exportTitle : descape(escape("归档文件目录")),
        exportHeaderWidth:"5,10,14,21,20,6,6,7"
    };
    exportExcel("exportDocList4doc",data);
}
 
 /**
  * 导出
  */
 function exportExcel(method,data){
      var url = path+'/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileExportExcelAction&method='+method;      
         var html = new Array();
         
         jQuery("#export_excel").remove();
         html.push("<div id='export_excel'>");
         html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
         html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');

         var param = toUserParamJosn(true);
         for(var name in param){
            html.push("<input type='hidden' name='"+name+"' value='"+param[name]+"' /> ");
         }
         var postData = $("#gridTable").jqGrid("getGridParam", "postData");
         html.push("<input type='hidden' name='page.sortOrder' value='"+postData["sord"]+"' /> ");
         html.push("<input type='hidden' name='page.sortName' value='"+postData["sidx"]+"' /> ");
         
         //特殊处理导出需求
         data["bean.f_dept_name"] = descape(escape("<%=StringUtil.deNull(bean.getF_dept_name())%>")) ;
         data["bean.f_filesno"] = descape(escape("<%=StringUtil.deNull(bean.getF_filesno())%>")) ;
         data["bean.f_type_name"] = descape(escape("<%=StringUtil.deNull(bean.getF_type_name())%>"));
         if(data){
              for(var name in data){
                  html.push("<input type='hidden' name='"+name+"' value='"+data[name]+"' /> ");
              }  
         }
         html.push('</form>');
         html.push("</div>");
         //加载到body，提交后再删除
         jQuery(html.join("")).appendTo("body");
         jQuery("#downFrom").submit();
 }
var orderConfig = {
	<%--排序页面的查询数据参数--%>
	dataArgs:toUserParamJosn("bean."),
	<%--排序页面的page参数--%>
	pageArgs:{
		'page':'1',
		'rows':'5000',
		'sidx':'to_number(f_doc_num)',
		'sord':'asc'
	},
	<%--制定的排序页面--%>
	orderPageName:path+"/ccapp/oa/file/jsp/filefilesorder.jsp?windowId=orderListPage",
	orderPageId:"orderListPage",
	<%--打开排序页面之前调用的类--%>
	openWindowActionURL:path+"/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FileDocListForFiles",
	<%--提交排序后更新页面--%>
	afterOrderSumbitFn:function(){
		search();
		alert("操作成功");
	},
	tableHeadName:{"oneTdCol":"文件标题","twoTdCol":"件号"},
	saveUrl:path+"/ajaxServlet?className="
     +"com.chinacreator.xtbg.core.file.action.FileFilesAction&method=updateFileListInFilesOrder",
    addTrType:"addTr1"
};
</script>
<!-- 公共部分结束 -->
</head>
<body>
<div id="vcenter" style="overflow-x:hidden;">
<form action="" id="form1" name="form1" method="post" >
     <div class="content_02_top" style="width:100%;margin-bottom: 10px;float: none;border: #ebebeb 1px solid;">    
     	   <input name="orderButton" id="orderButton" onclick="filedoclist4fileJS.orderList(orderConfig);" value="排序" type="button" class="but_y_01" style="float: right;margin-right:5px;" />
           <input onclick="exportExcelList();" name="exportButton" id="exportButton"  value="导出卷内文件" type="button" class="but_y_03" style="float: right;width:105px;"/>
           <input onclick="updateList();" name="updateListButton" id="updateListButton"  value="批量修改" type="button" class="but_y_01" style="float: right;" />
           <input onclick="docNumberFn.saveRow('#gridTable','#form1');" name="docNumberButton" id="docNumberButton" disabled="disabled"  value="保存件号" type="button" class="but_y_01" style="float: right;" />
           <input onclick="deleteFn();" name="deleteFromFilesButton" id="deleteFromFilesButton"  value="出卷" type="button" class="but_y_01" style="float: right;" />
           <input onclick="addDocToFiles();" name="addDocToFileButton" id="addDocToFileButton"  value="入卷" type="button" class="but_y_01" style="float: right;" />
           <input onclick="" name="copyDoc" id="copyDoc"  value="复制" type="button" class="but_y_01" style="float: right;" />
           <input onclick="updateByButton();" name="updateByButton1" id="updateByButton1"  value="修改" type="button" class="but_y_01" style="float: right;" />
           <input onclick="addFileDocDetail();" name="addButton" id="addButton"  value="增加" type="button" class="but_y_01" style="float: right;" />
     </div>

    <!-- 查询列表区 cGridArea(查询区样式)-->
    <div class="cGridArea">
        <table id="gridTable" style="position:static"></table>
        <div id="gridPager"></div>
    </div>
</form>
</div>
</body>
</html>