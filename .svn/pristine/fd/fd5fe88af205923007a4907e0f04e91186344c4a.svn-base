<%--
describe:档案管理-光盘档案列表
author:dailianchun
date: 2013-7-16
--%>
<%@page import="com.chinacreator.xtbg.core.common.cache.OASystemCache"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
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
    //获得当前登录用户的id
    String userId = controler.getUserID();    
    //获得缓存的机构信息
    UserCacheBean userBean = UserCache.getUserCacheBean(userId);
    String unitId = userBean.getUnit_id();//所属单位id

    String F_ORG_ID = userBean.getOrg_id();
    //服务接口
    FileFilesService service = new FileFilesServiceImpl();
    //密级的list
    List<Map<String,String>> secretList = service.queryDictByCode(FileConstant.DICT_TYPE_DAMJ);
    //保管期限
    List<Map<String,String>> deadlineList = service.queryDictByCode(FileConstant.DICT_TYPE_BGQX);
    boolean isManager = KbmUtil.isRolesUser(userId, "单位档案管理员");
    
    String orderType = "0";
    String configs = OASystemCache.getContextProperty("oa_file_config_codes");
    if(configs!=null&&configs.length()>0){
	    String[] configArr = configs.split(",");
	    for(String cf : configArr){
	    	String[] keyVal = cf.split(":");
	    	if("files_order_type".equals(keyVal[0])){
	    		orderType = keyVal[1];
	    		break;
	    	}
	    }
    }
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
<script src="../resources/js/filefileslist.js" type="text/javascript"></script>
<!-- 打印需要导入的内容、方法 -->
<script language="javascript" src="../../resources/plug/Lodop/LodopFuncs.js"></script> 
<object  id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>  
<!-- 是专为 FireFox 浏览器设计的代码  -->
<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=path %>/ccapp/oa/resources/plug/Lodop/install_lodop.exe"></embed>
</object>
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

    jQuery("#f_files_state").change(function(){
        search();
     });
    //重置按钮添加事件
    jQuery("#reset").click(function(){
        clear();
    });

    showOrHideButton(window.parent.f_type_level);
    //设置多选框
    setSelect("#f_secrecy_name", "classinput1");
    setSelect("#f_doc_deadline_name", "classinput2"); 
    
    $("#gridTable").jqGrid({
        url: '<%=path%>/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=queryFilesList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [

                    {
                        label : "案卷ID",
                        name : 'f_files_id',
                        index : 'f_files_id',
                        hidden : true
                    }, {
                        label : "档号",
                        name : 'f_files_no',
                        index : 'f_files_no',
                        editable : false,
                        width:'200'
                    }, {
                        label : "档案年份",
                        name : 'f_doc_year',
                        index : 'f_doc_year',
                        editable : false,
                        hidden:true
                    },{
                        label : "案卷号",
                        name : 'f_filesno',
                        index : 'f_filesno',
                        editable : false,
                        hidden:true
                    },{
                        label : "目录号",
                        name : 'f_listno',
                        index : 'f_listno',
                        editable : false,
                        width:'60'
                    },{
                        label : "卷内盘数",
                        name : 'f_files_num',
                        index : 'f_files_num',
                        editable : false,
                        width:'60'
                    }, {
                        label : "案卷状态",
                        name : 'f_files_state',
                        index : 'f_files_state',
                        hidden : true
                    }, {
                        label : "案卷状态",
                        name : 'f_files_state_name',
                        index : 'f_files_state_name',
                        editable : false,
                        width:'60'
                    },{
                        label : "保管期限",
                        name : 'f_doc_deadline_name',
                        index : 'f_doc_deadline_name',
                        editable : false,
                        width:'60'       
                    },{
                        label : "密级",
                        name : 'f_secrecy_name',
                        index : 'f_secrecy_name',
                        editable : false,
                        width:'50'    
                    },{
                        label : "密级id",
                        name : 'f_secrecy_id',
                        index : 'f_secrecy_id',
                        hidden : true    
                    },{
                        label : "归档日期",
                        name : 'f_file_time',
                        index : 'f_file_time',
                        editable : false,
                        width:'80'     
                    },{
                        label : "所属部门",
                        name : 'f_dept_name',
                        index : 'f_dept_name',
                        editable : false,
                        width:'80'     
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
                    },{
                        label : "全宗号",
                        name : 'f_fondsno',
                        index : 'f_fondsno',
                        hidden : true    
                    },{
                        label : "是否分类管理员",
                        name : 'istypemanager1',
                        index : 'istypemanager1',
                        hidden : true    
                    },{
                        label : "是否分类管理员",
                        name : 'istypemanager2',
                        index : 'istypemanager2',
                        hidden : true    
                    },{
                    	label : "档案分类号",
                        name : 'f_typeno',
                        index : 'f_typeno',
                        hidden : true    
                    },{
	                  label : "f_order",
	                  name : 'f_order',
	                  index : 'f_order',
	                  hidden : true
	               }
        ],
        sortname : '<%=(orderType.equals("1")?"f_files_no":"f_order")%>',
        sortorder : '<%=(orderType.equals("1")?"desc":"asc")%>',
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
        postData : toUserParamJosn("bean."),
        prmNames : { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
        	 page : "page.page",
             rows : "page.rows",
             //表示请求行数的参数名称  
             sort : "page.sortName",
             //表示用于排序的列名的参数名称  
             order : "page.sortOrder"
        },
        emptyrecords : "暂无数据",
        toolbar : [ false, "top",""],
        multiselect : true,
        onCellSelect:function (id,iCol)
        {
           if(iCol != 0)
            {
                var model = jQuery("#gridTable").jqGrid('getRowData', id);
                update(model.f_files_id,model.f_files_state,model.f_type_id,model.f_type_name);
            }
        }
                    
        });

    //设置工具栏的宽度
    jQuery("#tool_buttons").width(jQuery("#t_bottombar_contentgridTable").width());
        
    });
   
    /*
     函数:  toUserParamJosn
     说明:  构建要查询的参数
     参数:   无
     返回值: 返回要查询的参数
     */
    var toUserParamJosn = function(objName,notEscape){
    	 if(window.parent.role=="org"||window.parent.role=="dept"){
    		 var param = new Object();
    	        
    	        param[objName+"f_dept_name"] = jQuery("#f_dept_name").val();
    	        param[objName+"f_doc_year" ] = jQuery("#f_doc_year").val();
    	        param[objName+"f_doc_deadline_name"] =jQuery("#f_doc_deadline_name").val();
    	        param[objName+"f_secrecy_name"] =jQuery("#f_secrecy_name").val();
    	        param[objName+"f_type_id" ] = window.parent.f_type_id; //获得父页面持有的类型id
    	        param[objName+"f_org_id" ] = "<%=unitId%>";
    	        param[objName+"f_files_state"]=jQuery("#f_files_state").val();

    	        param[objName+"f_files_no"] = jQuery("#f_files_no").val();
    	        param[objName+"f_filesno"] = jQuery("#f_filesno").val();
    	        param[objName+"f_listno"] = jQuery("#f_listno").val();
    	        param[objName+"f_files_num"] = jQuery("#f_files_num").val();
    	        param[objName+"f_file_userid" ] = "<%=userId%>";
    	        //将归档时间的查询项放入起始日期和终止日期        
    	        param[objName+"f_start_time"] = jQuery("#f_start_time").val();
    	        param[objName+"f_end_time"] = jQuery("#f_end_time").val();
    	        if(window.parent.role=="dept"){
       				param[objName+"f_dept_id"] = '<%=F_ORG_ID%>';
       			}
    	        if(!notEscape){
    		        //转码
    		        for(var name in param ){
    		            param[name] = descape(escape(param[name]));
    		        }  
    	        }              
    	        return param;
    	 }else{
    		 var param = new Object();
    	        
    	        param[objName+"f_dept_name"] = jQuery("#f_dept_name").val();
    	        param[objName+"f_doc_year" ] = jQuery("#f_doc_year").val();
    	        param[objName+"f_doc_deadline_name"] =jQuery("#f_doc_deadline_name").val();
    	        param[objName+"f_secrecy_name"] =jQuery("#f_secrecy_name").val();
    	        param[objName+"f_type_id" ] = window.parent.f_type_id; //获得父页面持有的类型id
    	        param[objName+"f_org_id" ] = "<%=unitId%>";
    	        param[objName+"f_files_state"]=jQuery("#f_files_state").val();

    	        param[objName+"f_files_no"] = jQuery("#f_files_no").val();
    	        param[objName+"f_filesno"] = jQuery("#f_filesno").val();
    	        param[objName+"f_listno"] = jQuery("#f_listno").val();
    	        param[objName+"f_files_num"] = jQuery("#f_files_num").val();
    	        param[objName+"f_file_userid" ] = "<%=userId%>";
    	        //将归档时间的查询项放入起始日期和终止日期        
    	        param[objName+"f_start_time"] = jQuery("#f_start_time").val();
    	        param[objName+"f_end_time"] = jQuery("#f_end_time").val();
    	        <%if(!isManager){%>
					param[objName+"f_dept_id"] = '<%=F_ORG_ID%>';
				<%}%>
    	        if(!notEscape){
    		        //转码
    		        for(var name in param ){
    		            param[name] = descape(escape(param[name]));
    		        }  
    	        }              
    	        return param;
    	 }
        
    }

    /*
         函数:  search
         说明:  查询
         参数:   无
         返回值: 
     */
    var search = function() {
       
        //查询参数
        var sdata = toUserParamJosn("bean."); 
        
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
        jQuery("#f_files_state option[value='']").attr("selected","selected");
        //查询
        search();
     }

     /**
      *添加
      */
     var add = function(){
         var width = jQuery(document).width();
         var height = window.top.findPageCacheName("_documentBodyHeight");
         openAlertWindows('add_fileFiles'
                 ,path+"/ccapp/oa/file/jsp/filefilesaddmain.jsp?windowId=add_fileFiles"
                 +"&f_type_id="+window.parent.f_type_id
                 +"&f_type_name="+descape(escape(window.parent.f_type_name))
                 +"&f_typeno="+window.parent.f_typeno
                 +"&f_files_state=0"
                 +"&busiTypeCode=file_002",                            
                 '添加档案',width,height,'5%','10%');
         
     }

     /*
         函数:  update
         说明:  修改 
         参数:  无
         返回值: 无
     */
     var update = function(id,flag,typeId,typeName) {
         var width = jQuery(document).width();
         var height = window.top.findPageCacheName("_documentBodyHeight");
         
         openAlertWindows('update_fileFiles'
                 ,path+'/ccapp/oa/file/jsp/filefilesaddmain.jsp?windowId=update_fileFiles&id='+id+"&f_files_state="+flag
                 +"&busiTypeCode=file_002&f_type_id="+typeId+"&f_type_name="+descape(escape(typeName)), 
                 '更新档案'
                 ,width,height,'5%','10%');
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
	       var total = selectedIds.length;//总共选中的记录数       
	       $(selectedIds).each(function () {
	    	   var model = jQuery("#gridTable").jqGrid('getRowData', this);
               //单位管理员，或者分类管理员能删除所有的档案，包括已归档的
               if(isManager||(model.istypemanager1=="1" && model.istypemanager2=="1" )){                   
                   
                   ids.push(model.f_files_id);  
               }else{
                   //非单位档案管理员 且非分类管理员智能删除自己添加的未归档档案         
                   if(model.f_file_userid == userId && model.f_files_state == "0"){
                       //id不为空
                       ids.push(model.f_files_id); 
                   }
               }
	           
	       });
	           
	       if (!ids.length) {
	           alert("选中<span style='color:red;font-weight:bold'>"
	                   +total+"</span>条,可删除<span style='color:red;font-weight:bold'>"
	                   +ids.length+"</span>条，<br/>成功删除<span style='color:red;font-weight:bold'>"
	                   +ids.length+"</span>条记录");
	       } else {
	           var okF = function(){
	               //ajax方式提交数据
	               jQuery.ajax({ 
	                   type: "post", 
	                   url: path+'/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=deleteFiles',  
	                   contentType: "application/x-www-form-urlencoded; charset=utf-8",
	                   data : {                      
	                       ids : ids.join(",") //要删除的id列表      
	                   },
	                   dataType: "json", 
	                   success: function (data) {
	                       if(data){                          
	                           //如果删除成功，刷新数据
	                           if(data.flag){
	                               alert("选中<span style='color:red;font-weight:bold'>"
	                                       +total+"</span>条,可删除<span style='color:red;font-weight:bold'>"
	                                       +ids.length+"</span>条，<br/>成功删除<span style='color:red;font-weight:bold'>"
	                                       +ids.length+"</span>条记录");
	                               search();
	                           }else{
	                               if(data.msg){
	                                   alert(data.msg);
	                               }
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
		    ids.push(model.f_files_id);  		    
		});
        var urlArray = new Array();		
        urlArray.push(getCurrentFilePath()+'filefilesupdate.jsp?windowId=updateListFileFiles');
        urlArray.push("&ids="+ids.join(","));

        urlArray.push("&f_dept_name=" + jQuery("#f_dept_name").val());
        urlArray.push("&f_doc_year=" + jQuery("#f_doc_year").val());
        urlArray.push("&f_doc_deadline_name="+jQuery("#f_doc_deadline_name").val());
        urlArray.push("&f_files_title="+jQuery("#f_files_title").val());
        urlArray.push("&f_filesno="+jQuery("#f_filesno").val());
        urlArray.push("&f_secrecy_name="+jQuery("#f_secrecy_name").val());
        urlArray.push("&f_type_id="+window.parent.f_type_id);
        urlArray.push("&f_files_state="+jQuery("#f_files_state").val());
        urlArray.push("&f_org_id="+"<%=unitId%>");

        urlArray.push("&f_files_no="+jQuery("#f_files_no").val());
        urlArray.push("&f_listno="+jQuery("#f_listno").val());
        urlArray.push("&f_files_num="+jQuery("#f_files_num").val());
        urlArray.push("&f_start_time="+jQuery("#f_start_time").val());
        urlArray.push("&f_end_time="+jQuery("#f_end_time").val());
        var url = urlArray.join("");
       
		 openAlertWindows('updateListFileFiles'
	                ,url,'批量修改案卷信息'
	                ,600,360,'10%','20%'); 	    
	
	}
  
   /**
    *导出案卷列表
    */
   function exportExcelList(){
       var exportKey = [ "f_filesno", "f_type_name_export","f_listno","f_files_num",
                        "f_doc_deadline_name","备注"];
       var exportHeader = [" 案卷号 ", "  光盘类别  ", "   目录号   ", " 盘数 "," 保管期限 "," 备注 "];
       var data = {
           exportKey : exportKey.join(","),
           exportHeader : descape(escape(exportHeader.join(","))),
           exportTitle : descape(escape("光盘档案案卷目录"))           
       };
       exportExcel("exportFileList",data);
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

	            var param = toUserParamJosn("bean.",true);
	            for(var name in param){
	               html.push("<input type='hidden' name='"+name+"' value='"+param[name]+"' /> ");
	            }
	            var postData = $("#gridTable").jqGrid("getGridParam", "postData");
	            for(var name in postData){
	                html.push("<input type='hidden' name='page."+name+"' value='"+postData[name]+"' /> ");
	            }
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

	/**
	 *显示or影藏按钮
	 */
	function showOrHideButton(level){
		if(3 == level){
			jQuery("#addButton").show();
		}else{
			jQuery("#addButton").hide();
		}
	}
	   /*
    函数:  批量修改
    参数:  无
    返回值: 无
    */
    var fitFiles = function() {
       
        var urlArray = new Array();     
        urlArray.push(getCurrentFilePath()+'filefilesfit.jsp?windowId=fitListFileFiles');
       
        urlArray.push("&f_dept_name=" + jQuery("#f_dept_name").val());
        urlArray.push("&f_doc_year=" + jQuery("#f_doc_year").val());
        urlArray.push("&f_doc_deadline="+jQuery("#f_doc_deadline").val());
        urlArray.push("&f_files_title="+jQuery("#f_files_title").val());
        urlArray.push("&f_filesno="+jQuery("#f_filesno").val());
        urlArray.push("&f_secrecy_name="+jQuery("#f_secrecy_name").val());
        urlArray.push("&f_type_id="+window.parent.f_type_id);
        
        var url = urlArray.join("");
        var width = jQuery(document).width();
        var height = window.top.findPageCacheName("_documentBodyHeight");
         openAlertWindows('fitListFileFiles'
                    ,url,'调卷界面'
                    ,width,height,'5%','10%');      
    
    }


    /* 打印背脊标签 */
    function printFileBack(){
        //选中的列
        var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
        if(selectedIds.length <=0){
           alert("请至少选中一条记录");
           return;
        }
        var htmlArray = new Array();
        htmlArray.push('<div style="width:100%;">');
        var i = 1;
        $(selectedIds).each(function () {
            var model = jQuery("#gridTable").jqGrid('getRowData', this);
            //id不为空
            htmlArray.push(backHtml(model));    
            if(i%5 == 0 && i!=(selectedIds.length)){
                htmlArray.push("<div style='float:left;height:20px;width:100%;'></div>");
            }
            i++;         
        });
        htmlArray.push('</div>    ');
        
         /*判断浏览器的类型并决定采用哪个对象实例，并检测控件是否安装、是否最新版本、并引导安装或升级。  */
         var LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));
         
         
         createPrintHtml(LODOP,htmlArray.join(" "));        
         LODOP.PREVIEW();
    };
    
    /*创建部分打印内容  */
    function createPrintHtml(LODOP,phtml){
       /*初始化运行环境，清理异常打印遗留的系统资源，设定打印任务名。  */
        LODOP.PRINT_INIT("打印");    
        LODOP.SET_PRINT_STYLEA(0,"FontSize",20);
        LODOP.SET_PRINT_STYLEA(0,"Horient",3);
        LODOP.SET_PRINT_STYLEA(0,"Vorient",3);  
        LODOP.ADD_PRINT_HTM('0CM','2.3CM','80%','100%',phtml); 

    };

    /*
     * 打印背脊标签
     */
    function backHtml(model){
    	//var f_type_name = model.f_type_name;
        //if(f_type_name.lastIndexOf("-->") != -1){
        //    f_type_name = f_type_name.substring(f_type_name.lastIndexOf("-->")+3,f_type_name.length);
        //}
       var html = [
       '<table align="center" style="word-wrap:break-word;word-break:nomal;',
       'text-align:center;width:60px;font: normal 18px/29px \'宋体\';background:#E02A14;',
       ' color:#E02A14;font-weight: bold;float:left;margin-left:30px;" cellspacing="5" cellpadding="0" >',
       '<tr>',
       '<td style="color:#fff;height:480px;" valign="middle" align="center">',
       '   <span style="text-align:center;width:20px;display:inline;line-height:80px;',
       'font-size:42px;font-family:"黑体";margin-left:5px;font-weight: bolder;letter-spacing:8px;">',
                   '光盘档案', 
       '</span>',   
       '</td>',
       '</tr>',   
       '<tr><td  align="center"  style="background:#fff;height:35px;text-align:center;">全宗号</td></tr>',
       '<tr><td  align="center"  style="background:#fff;height:65px;text-align:center;color:#000;">',
       model.f_fondsno,
       '</td></tr>',
       '<tr><td align="center" style="background:#fff;height:35px;text-align:center;">目录号</td></tr>',
       '<tr><td  align="center"  style="background:#fff;height:65px;text-align:center;color:#000;">',
       model.f_listno,
       '</td></tr>',

       '<tr><td align="center" style="background:#fff;height:35px;text-align:center;">分类号</td></tr>',
       '<tr><td  align="center"  style="background:#fff;height:65px;text-align:center;color:#000;word-break:break-all; width:60px;">',
       model.f_typeno,
       '</td></tr>',
       

       '<tr><td  align="center"  style="background:#fff;height:35px;text-align:center;">案卷号</td></tr>',
       '<tr><td  align="center"  style="background:#fff;height:65px;text-align:center;color:#000;">',
       model.f_filesno, 
       '</td></tr>',
       
       '<tr><td  align="center"  style="background:#fff;height:65px;text-align:center;line-height: 20px;">',
       '    <span style="width:60px;height:20px;float: left;">保&nbsp;管</span>',
       '    <span style="width:60px;height:20px;float: left;">期&nbsp;限</span>',
       '</td></tr>',
       '<tr><td  align="center"  style="background:#fff;height:65px;text-align:center;color:#000;">',
       model.f_doc_deadline_name,
       '</td></tr>',
       '</table>'
      ];
      return html.join(" ");
    }
<%--排序前查询的配置,防止不同页面不同函数名,统一集合在orderConfig供js和子页面调用--%>
var orderConfig = {
	<%--排序页面的查询数据参数--%>
	dataArgs:toUserParamJosn("bean."),
	<%--排序页面的page参数--%>
	pageArgs:{
		'page.page':'1',
		'page.rows':'5000',
		'page.sortName':'f_order',
		'page.sortOrder':'asc'
	},
	<%--制定的排序页面--%>
	orderPageName:path+"/ccapp/oa/file/jsp/filefilesorder.jsp?windowId=orderListPage",
	orderPageId:"orderListPage",
	<%--打开排序页面之前调用的类--%>
	openWindowActionURL:path+"/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=queryFilesListForOrder",
	<%--提交排序后更新页面--%>
	afterOrderSumbitFn:function(){
		search();
		alert("操作成功");
	}
};
</script>
<!-- 公共部分结束 -->
</head>
<body class="vcenter" style="overflow:auto;overflow-x:hidden;">
<div>
    
<table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
        <tr>
            <td>
            <!-- 固定查询 -->
                <table id="searchTable" style="width:830px;" border="0" cellspacing="3" cellpadding="0" >
                    <tr>
                        <th style="width:90px;"  class="input_cx_title_th">
                                                                             所属部门 ：
                        </th>
                        <td style="width:120px;"  class="cx_title_td">
                             <input type="text"
                                    class="input_cx_title_283"  style="width:118px;" id="f_dept_name" name="f_dept_name"/>
                             
                        </td>
                        <th style="width:90px;" class="input_cx_title_th">档案年份：</th>
                        <td  style="width:100px;" class="cx_title_td">
                           <input style = "width:98px;;background:url(/xtbg/ccapp/oa/resources/style/blue/images/date_img_year.jpg) right 1px no-repeat;" type="text" class="date_120 Wdate" name="f_doc_year" id="f_doc_year"
                             onclick="WdatePicker({dateFmt:'yyyy'})"/>
                        </td>
                        <th  class="input_cx_title_th" style="width:90px;">保管期限：</th>
                        <td valign="top" style="width:140px;"  class="cx_title_td">
                           <div style="float:left;position: absolute;width:100px;z-index: 2;">                         
                             <select style="width:105px;" multiple="multiple" name ="f_doc_deadline_name" id= "f_doc_deadline_name" class ="input_cx_title_283" >
                                 <option  type="checkbox" value='' all='30'>&nbsp;全选</option>
                                <%for(Map dead : deadlineList){ %>
                                <option type="checkbox" value="<%=StringUtil.deNull(dead.get("dictdata_value")) %>">&nbsp;<%=StringUtil.deNull(dead.get("dictdata_name")) %></option>
                                <%} %>
                             </select>
                            </div>
                        </td>
                        <td style="width:200px;">
                            <input value="搜索" id="sel" type="button" onclick="search();" class="but_y_01" />
                        </td>
                    </tr>
                    <tr>
                       <th  class="input_cx_title_th">档号：</th>
                         <td class="cx_title_td">
                             <input type="text"
                                    class="input_cx_title_283"  style="width:118px;" id="f_files_no" name="f_files_no"/>
                        </td>
                        <th  class="input_cx_title_th">案卷状态：</th>
                        <td  class="cx_title_td">
                            <select style="width:100px;" id='f_files_state' name="f_files_state" 
                                style="border:#c6c6c6 1px solid;">
                               <option value="">---请选择---</option>
                               <option value="0">待归档</option>
                               <option value="1">已归档</option>
                            </select>
                        </td>
                       
                        <th  class="input_cx_title_th">密级：</th>
                        <td valign="top"  class="cx_title_td" style="padding-top:0px;">
                             <div style="float:left;position: absolute;width:100px;z-index: 1;">                         
                                 <select style="width:105px;" multiple="multiple" name ="f_secrecy_name" id= "f_secrecy_name" class ="input_cx_title_283" >
                                     <option  type="checkbox" value='' all='30'>&nbsp;全选</option>
                                     <%for(Map type : secretList){ %>
                                     <option type="checkbox" value="<%=StringUtil.deNull(type.get("dictdata_value")) %>">&nbsp;<%=StringUtil.deNull(type.get("dictdata_name")) %></option>
                                     <%} %>
                                 </select>
                             </div>
                        </td>
                        <td >
                            <input value="重置" id="reset" type="button" class="but_y_01" />
                            <span id="selAreaImg" class="all_search_condition">
                            <a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件</a></span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>        
        <tr>
        <td style="padding: 0px;">
        <!-- 隐藏查询 -->
           <table style="width:830px;display:none;margin: 0px;" border="0" cellspacing="3" cellpadding="0" id="hiddenArea" >
                      <tr>
                          <th style="width:90px;" class="input_cx_title_th" >
                                                                                     案卷号：
                          </th>
                          <td style="width:120px;" class="cx_title_td">
                              <input  id="f_filesno" name="f_filesno" type="text" class="input_cx_title_283" style="width:118px;" />
                          </td>
                          <th style="width:90px;" class="input_cx_title_th">目录号：</th>
                          <td class="cx_title_td" style="width:100px;">
                              <input  id="f_listno" name="f_listno" type="text" class="input_cx_title_283" style="width:98px;" />
                          </td>
                           <th class="input_cx_title_th" style="width:90px;">卷内盘数：</th>
                          <td class="cx_title_td" style="width:140px;">
                              <input  id="f_files_num" name="f_files_num" type="text" class="input_cx_title_283" style="width:98px;" />
                          </td>
                          <td style="width:200px;"></td>
                      </tr>
                      <tr>                          
                          <th class="input_cx_title_th" >归档日期：</th>
                          <td class="cx_title_td">
                              <input class="date_120" type="text" style="width:118px;"
                                id="f_start_time" name="f_start_time"
                                onclick="WdatePicker({maxDate:'#F{$dp.$D(\'f_end_time\'||\'2099-01-01\')}',dateFmt:'yyyy-MM-dd'})"  />
                          </td>
                          <td align="center" >
                                                                                     至
                          </td>
                          <td class="cx_title_td" colspan="4">    
                           <input class="date_120" type="text" style="width:98px;"
                            id="f_end_time" name="f_end_time"
                            onclick="WdatePicker({minDate:'#F{$dp.$D(\'f_start_time\'||\'1980-01-01\')}',dateFmt:'yyyy-MM-dd'})" />
                          </td>
                      </tr>
            </table>
        </td> 
        </tr>
    </table> 
    
    
    <!-- 查询列表区 cGridArea(查询区样式)-->
    <div class="cGridArea">
    <div id="tool_buttons" class="ui-jqgrid .ui-userdata ui_t_bottombar_content" 
         style="width:97%;height:28px;margin-left:10px;margin-bottom:0px;float: none;border: #ebebeb 1px solid;">            
           
           <input name="addButton" id="addButton" onclick="add();" value="添加" type="button" class="but_y_01" style="float: left;margin-left: 10px;display: none;"/>
           <input name="deleteButton" id="deleteButton" onclick='del()' value="删除" type="button" class="but_y_01" style="float: left;margin-left: 5px;" />
           <input name="updateButton" id="updateButton" onclick="updateList();"  value="批量修改" type="button" class="but_y_01" style="float: left;margin-left: 5px;" />
           <input name="fitButton" id="fitButton" onclick="fitFiles();"  value="调卷" type="button" class="but_y_01" style="float: left;margin-left: 5px;" />
           <input name="updateState" id="updateState" onclick="updateState();"  value="批量归档" type="button" class="but_y_01" style="float: left;margin-left: 5px;" />
           <input name="copyFile" id="copyFile" onclick="copyFile();"  value="复制案卷" type="button" class="but_y_01" style="float: left;margin-left: 5px;" />
           <input name="exportButton" id="exportButton" onclick="exportExcelList();" value="导出案卷目录" type="button" class="but_y_03" style="float: left;margin-left: 5px;width:105px;" />
           <input name="printFileBack" id="printFileBack" onclick="printFileBack();" value="打印背脊标签" type="button" class="but_y_03" style="float: left;margin-left: 5px;width:105px;" />
     	   <%if(orderType.equals("0")){%>
			<input name="orderButton" id="orderButton" onclick="filefileslistJS.orderList(orderConfig);" value="排序" type="button" class="but_y_03" style="width:105px;float: left;margin-left: 5px;" />   
           <%}%>
     </div>
     <table id="gridTable"></table>
     <div id="gridPager"></div>
    </div>
</div>
</body>
</html>