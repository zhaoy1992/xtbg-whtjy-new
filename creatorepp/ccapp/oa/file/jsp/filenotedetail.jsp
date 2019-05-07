<%--
describe:档案备考表
author:dailianchun
date: 2013-7-29
--%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileNoteBean"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesService"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileTypeBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String id = StringUtil.deNull(request.getParameter("id"));//档案id
	String typeId = StringUtil
			.deNull(request.getParameter("f_type_id"));//档案类型id
	String path = request.getContextPath();
	FileFilesService service = new FileFilesServiceImpl();
	FileNoteBean bean = service.queryToFileNote(id);
	if (null == bean) {
		bean = new FileNoteBean();
		bean.setF_files_id(id);	
	} else {
		if (StringUtil.nullOrBlank(bean.getF_files_id())) {
			bean.setF_files_id(id);
		}
	}
	//进入页面后，只能查看，不能进行其他任何操作
	String isview = StringUtil.deNull(request.getParameter("isview"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<!-- 引入jQuery -->
<script type="text/javascript"
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">jQuery.noConflict();</script>
<!-- 引入jQuery UI -->
<script
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
    type="text/javascript"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入formvValidatetion -->
<script
    src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js"
    type="text/javascript"></script>
<script
    src="../../resources/plug/formvalidation/jquery.validationEngine.js"
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

<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"></script>
<!-- 打印需要导入的内容、方法 -->
<script language="javascript" src="../../resources/plug/Lodop/LodopFuncs.js"></script> 
<object  id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>  
<!-- 是专为 FireFox 浏览器设计的代码  -->
<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 pluginspage="<%=path %>/ccapp/oa/resources/plug/Lodop/install_lodop.exe"></embed>
</object>
<script type="text/javascript">
   var path = "<%=path%>";
   jQuery(function(){
	   <%if(!StringUtil.nullOrBlank(isview)){%>
		jQuery(".content_02_top").hide();
		<%}%>
        jQuery("#f_creator_name_button").click(function(){
            chooseUser("f_creator_id","f_creator_name","radio");
        });
    
       jQuery("#f_checker_name_button").click(function(){
           chooseUser("f_checker_id","f_checker_name","radio");
       });
   });

    /**
     *获得所有需要提交的参数
     */
    function getAllValues(pre){
       var thisPre = pre || "";
       var params = new Object();
       params[thisPre+"f_note_id"] = jQuery("#f_note_id").val();
       params[thisPre+"f_note_content"] = jQuery("#f_note_content").val();

       params[thisPre+"f_creator_id"] = jQuery("#f_creator_id").val();
       params[thisPre+"f_creator_name"] = jQuery("#f_creator_name").val();       

       params[thisPre+"f_checker_id"] = jQuery("#f_checker_id").val();
       params[thisPre+"f_checker_name"] = jQuery("#f_checker_name").val();
       params[thisPre+"f_creat_time"] = jQuery("#f_creat_time").val();
       params[thisPre+"f_files_id"] = jQuery("#f_files_id").val();
      return params;
    }
    /*
	    函数:  chooseOrg
	    说明:  选择地址
	    参数：   name 赋值框的id
     treetypestr 单选框或者多选框
    */
    var chooseUser = function (id,name,treetypestr){
        var s = new jQuery.z_tree();
        s.treeID = 'mainUser';
        s.treetypestr = treetypestr;
        s.isShowSeacher = true;
        s.treeName = "选择人员";
        s.headerName = "选择人员";
        s.isType="person"; //要设置默认选中值，则需要此类型
        s.type = "APERSON";
        s.selectedIds = jQuery("#"+id).val(),   
        s.returnFunction = function(userObj,o){    
        try{
        if (!IsSpace(o)) {
             jQuery('#'+id).val(userObj.id);
             jQuery('#'+name).val(userObj.name);
        } else {
            jQuery('#'+name).val("");
            jQuery('#'+id).val("");
        }
        }catch(e){
         /**忽略客户端异常信息**/ 
        }
        }
        s.init();
    }

    /**
     *生成备考表信息
     */
    function createNoteContent(){
        var f_type_id = "<%=typeId%>";
        jQuery("#top input[type=button]").attr("disabled","disabled");
        //ajax方式提交数据
        jQuery.ajax({
            type: "post", 
            url: path+"/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=queryNoteTemplement",  
            contentType: "application/x-www-form-urlencoded; charset=utf-8",
            data : {
                f_type_id : f_type_id,
                f_files_id: "<%=id%>"
            },
            dataType: "json",
            success: function (data) {
            	jQuery("#top input[type=button]").removeAttr("disabled");  
               if(data){
                   if(data.flag){
                      jQuery("#f_note_content").val(data.value);                      
                   } 
                   alert(data.msg);                                     
               }               
            }, 
            error: function (XMLHttpRequest, textStatus, errorThrown) { 
            	jQuery("#top input[type=button]").removeAttr("disabled");
                alert("出现异常，请稍后再试！");
            }
         });
  }

  /**
  *保存
  */
  function save(){
       //是否全部验证通过      
       if(!jQuery('#form1').validationEngine('validate') ){
         return ;
       }
       var param = getAllValues("noteBean.");
       var url = path+"/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=saveFileNote";
       publicAjax(url,param,function(data){
          if(data&&data.msg){
             alert(data.msg);
          } 
       });
   
  }
  function save1(){
       //是否全部验证通过      
       if(!jQuery('#form1').validationEngine('validate') ){
         return ;
       }
       jQuery('#form1').attr("target","filenotedetailJSPhiddenFrame");
       jQuery('#form1').attr("action","filenotedetaildo.jsp");
       jQuery('#form1').submit();
  }
  function afterSubmitFn(a){
  	alert(a);
  }
  /**
   *公用的ajax提交
   */   
  function publicAjax(url,param,backFunction){
      var urlThis = url || "";
      var paramThis = param || {};
      var backFunctionThis = backFunction || function(){};
      
      jQuery.ajax({
          type: "post", 
          url: urlThis,  
          contentType: "application/x-www-form-urlencoded; charset=utf-8",
          data : paramThis,
          dataType: "json",
          success: function (data) {              
            try{   
               if((typeof backFunctionThis ) == 'function'){
                   backFunctionThis(data);
               }
            }catch(e){
               /**忽略异常信息**/
            }              
          }, 
          error: function (XMLHttpRequest, textStatus, errorThrown) { 
              alert("出现异常，请稍后再试！");
          }
       });
  }
    

  var LODOP; //声明为全局变量 


  /* 打备考表 */
  function printNote() {
      createPrintHtml();
      LODOP.PREVIEW();  
  };

  /*创建部分打印内容  */
  function createPrintHtml(){
      /*判断浏览器的类型并决定采用哪个对象实例，并检测控件是否安装、是否最新版本、并引导安装或升级。  */
      LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));
      /*初始化运行环境，清理异常打印遗留的系统资源，设定打印任务名。  */
      LODOP.PRINT_INIT("打印请示信息");
      /*设置打印字体的大小 */
      LODOP.SET_PRINT_STYLEA(0,"FontSize",20);
      LODOP.SET_PRINT_STYLEA(0,"Horient",3);
      LODOP.SET_PRINT_STYLEA(0,"Vorient",3);
      /*增加超文本打印项，设定该打印项在纸张内的位置和区域大小，实现超文本控制打印。  */
      LODOP.ADD_PRINT_HTM('1.25CM','1.5CM','90%','90%',joinHtml()); 

  };  
  function joinHtml(){
        var html = [
		'<div style="width:100%;font: normal 12px \'宋体\' " >',
		'<div style="float:left;width:100%;text-align: center;height:50px;line-height: 50px;font: normal 28px \'黑体\';font-weight: bolder;">'
		+'备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;考&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;表',
		'</div>',
		'<div style="width:620px;float: left;border:1px solid #333;padding:0px;">',
		'<table border="0" cellspacing="0" cellpadding="0"', 
		    'style="width:100%;font: normal 12px \'宋体\';">',		    
		    '<tr>',
		       '<td align="left" valign="middle" style="width:620px;height:260px;">',		        
		        '  <textarea id="f_note_content" name="f_note_content"',
            'class="validate[required,maxSize[500]] textarea_575" ',
            'style="width:620px;border: 0px;overflow:auto;height: 800px;font: normal 18px \'微软雅黑,宋体\';padding-top:10px;" ',
            'rows="3">',
            jQuery("#f_note_content").val(),
            '</textarea></td>',
		    '</tr>',
		'</table>',
		'</div>',
		'</div>'
        ];
        return html.join(" ");
    }
      
</script>
</head>
<body onload="adaptationWH('top','vcenter',130);">
<form action="" id="form1" name="form1" method="post">

<div class="content_02_top" id="top"
    style="margin-bottom: 10px; float: none; border: #ebebeb 1px solid; padding-right: 10px;">
    <input onclick="createNoteContent();" name="addButton" id="addButton" value="生成" type="button"
    class="but_y_01" style="float: right; margin-right: 10px;" /> 
    <input
    onclick="save1();" name="addButton" id="addButton" value="保存" type="button"
    class="but_y_01" style="float: right;" /></div>
    
<div id="vcenter">

<div class="content_02_box" style="width:620px;border:1px solid #EAEAEA;" >
<div class="content_02_box_title_bg" style="width:620px;text-align: center;font-weight: bolder;">备考表
</div>

<div class="content_02_box_div" style="width:620px;" >
<table border="0" cellspacing="0" cellpadding="0"
    class="content_02_box_div_table" style="width:620px;">   
    <tr>
       <td align="left" valign="middle" style="width:620px;height:260px;">
       	 <input id="method" name="method" type="hidden" value="saveFileNote">
         <input id="f_note_id" name="f_note_id" type="hidden" value="<%=StringUtil.deNull(bean.getF_note_id())%>">
         <input id="f_files_id" name="f_files_id" type="hidden" value="<%=StringUtil.deNull(bean.getF_files_id())%>">
          <textarea id="f_note_content" name="f_note_content"
            class="validate[required,maxSize[500]] textarea_575" 
            style="width:620px;border: 0px;overflow: auto;height: 800px;font: normal 18px '微软雅黑,宋体';" 
            rows="3" ><%=StringUtil.deNull(bean.getF_note_content())%></textarea>
         </td>
    </tr>
 
   
   
</table>
</div>
</div>


</div>
</form>
<iframe id="filenotedetailJSPhiddenFrame" name="filenotedetailJSPhiddenFrame" width=0 height=0></iframe>
</body>
</html>