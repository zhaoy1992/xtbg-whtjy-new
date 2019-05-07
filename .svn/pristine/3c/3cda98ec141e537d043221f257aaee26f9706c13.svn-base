<%--
describe:案卷信息页面(文书档案添加界面)
author:dailianchun
date: 2013-8-7
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.*"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.file.service.*"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileConstant"%>
<%@ taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>

<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    String action = StringUtil.deNull(request.getParameter("action"));//更新or添加操作
    String f_type_id = StringUtil.deNull(request.getParameter("f_type_id"));
    String f_type_name = StringUtil.deNull(request.getParameter("f_type_name"));
    //解码
    f_type_name =DataControlUtil.replaceStr(f_type_name);
    f_type_name = Escape.unescape(f_type_name);
    String f_typeno = StringUtil.deNull(request.getParameter("f_typeno"));//档案分类号
    String busiTypeCode =StringUtil.deNull(request.getParameter("busiTypeCode"));//业务名
    String busi_id = StringUtil.deNull(request.getParameter("busi_id"));//主键id
    
    String userId = accesscontroler.getUserID();//用户id
    String userName = accesscontroler.getUserName();//用户名
    String time = DateUtil.getCurrentDate();//创建时间
    String year = DateUtil.getCurrentYear();//当前年
    //获得缓存的机构信息
    UserCacheBean userBean = UserCache.getUserCacheBean(userId);
    
     //服务对象
    FileFilesService service = new FileFilesServiceImpl();
    //密级的list
    List<Map<String,String>> secretList =  service.queryDictByCode(FileConstant.DICT_TYPE_DAMJ);
    //保管期限
    List<Map<String,String>> deadlineList =  service.queryDictByCode(FileConstant.DICT_TYPE_BGQX);
    //实物类型
    List<Map<String,String>> swlxList =  service.queryDictByCode(FileConstant.DICT_TYPE_SWLX);

    //全宗号列表
    List<Map<String,String>> fondsnoList =  service.queryListFondsno(userBean.getUnit_id());
 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.eform.util.Escape"%><html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<!-- 打印需要导入的内容、方法 -->
<script language="javascript" src="../../resources/plug/Lodop/LodopFuncs.js"></script> 
<object  id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>  
<!-- 是专为 FireFox 浏览器设计的代码  -->
<embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0 
      pluginspage="<%=path %>/ccapp/oa/resources/plug/Lodop/install_lodop.exe"></embed>
</object>
<oa:filedocinit>

<script type='text/javascript' src='<%=path %>/ccapp/oa/file/resources/js/filefilesdetail.js'></script>

<script type="text/javascript">
var path = "<%=path%>";
var busiTypeCode = "<%=busiTypeCode%>";//业务名 
var id = "<%=busi_id%>";//主键id
var action = "<%=action%>";//当前操作类型
var f_type_id = "<%=f_type_id%>";//档案类型id
var userName = "<%=StringUtil.deNull(userName) %>";//用户名
var userId = "<%=StringUtil.deNull(userId) %>";//用户id

    jQuery(function(){ 
       
        jQuery("#OA_FILE_FILES__F_FILES_NO").focus();
        //实物类型默认选中 纸质
        jQuery("select[id$=__F_ENTITY_TYPE] option[value=1]").attr("selected","selected");
        jQuery("select[id$=__F_ENTITY_TYPE] option[value!=1]").remove();
        jQuery("select[id$=__F_SECRECY_ID] option:first").attr("selected","selected");
        
        //选择位置按钮赋点击事件
        jQuery("#f_storage_fullname_button").click(function(){
           chooseFileAddress("OA_FILE_FILES__F_STORAGE_FULLNAME","radio");
        });        
        //选择分类
        jQuery("#f_type_name_button").click(function(){
            chooseFileType("OA_FILE_FILES__F_TYPE_ID","OA_FILE_FILES__F_TYPE_NAME"
                    ,"OA_FILE_FILES__F_TYPENO","radio");
        });
        //选择责任者
        jQuery("#f_doc_blname_button").click(function(){
            chooseUser("OA_FILE_FILES__F_DOC_BLID","OA_FILE_FILES__F_DOC_BLNAME","radio");
        });

        
        //触发change事件
        jQuery("select").trigger("change");

        //将表单升级为ajax的提交方式
        jQuery("#form1").submit(function(){
            jQuery(this).ajaxSubmit(
                {
                    type: "post", 
                    //url: "filefilesdo.jsp", 
                    url : path+"/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=saveFileFiles",
                    dataType: "json",
                    contentType: "application/x-www-form-urlencoded; charset=utf-8",
                    beforeSubmit : function(data,form,options ){   
                                            
	                   if(data && data.length){	                	 
	                      for(var i=0;i<data.length;i++){		
	                    	  data[i].value = descape(escape(data[i].value));   
	                      }                         
	                   }
                    },
                    success: function (data,status) {
                        if(data&&data.msg){
                           alert(data.msg);
                        }
                        window.parent.parentSearch();
                        if(window.parent && window.parent.showTab){
                            window.parent.showTab(id);                              
                        }
                        jQuery("#form1").resetSubmit(false);   
                        if(data&&data.flag=="true"){
                           action = "update";
                        }
                    }, 
                    clearForm : false,
                    resetForm:false,
                    timeout : 300000                                
                 }
            );
            return false;
         });

     });
  

    /*
    函数:  Ok
    说明:  提交添加与修改(发布操作)
    参数:   无
    返回值: 无
    */
    var save = function() {
        ajaxSubmit("确定要保存吗？",0,"待归档");      
    }

    /**
     *归档
     */
    var archive = function() {
        ajaxSubmit("确定要归档吗？",1,"已归档");      
    }
    

    /**
     函数:  ajaxSubmit
     说明:  ajax访问后台
     参数: action 操作事件（add，update等）
         alertMsg 弹出框的提示信息 
         state 状态 0：暂存，1：发布
          
     返回值: 无
     */
    var ajaxSubmit = function(alertMsg,state,stateName){
       
        //是否全部验证通过      
        if(!jQuery('#form1').validationEngine('validate') ){
          return ;
        }
        
       var p={
             headerText:'提示',
             okName:'确认',
             okFunction:function(){
		    	   //新增或归档时，需要增重新设置状态的值，其他情况，值不变
		           if("add" == action || state == 1){
		              jQuery("#OA_FILE_FILES__F_FILES_STATE").val(state);
		              jQuery("#OA_FILE_FILES__F_FILES_STATE_NAME").val(stateName);
		              jQuery("#guidang_state").text(stateName);
		           }
		    	   //在保存的时候如果档号没有就生成档号后 提交Copy createFileno方法体
		    	   if(jQuery("input[id$=__F_FILES_NO]").val()){
		    		   jQuery("#action").val(action);
	                   jQuery("#form1").submit(); 
		    	   }else{
		    		   var method = "createFileno4Add";
			           // ajax方式提交数据
			           jQuery.ajax({
			               type: "post", 
			               url: path+"/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method="+method, 
			               contentType: "application/x-www-form-urlencoded; charset=utf-8",
			               data : {
			                    "f_type_id" : f_type_id,// 档案类型id
			                    "f_files_id" : id // 档案id
			               },
			               dataType: "json",
			               success: function(data){
			            	   if(data && data.list){
			            	       var array = data.list;// 模板的键值对
			            	       var temp = data.value;// 模板信息
			            	       for(var i = 0;i<array.length;i++){
			            	          var key = array[i].dictdata_value.toUpperCase();
			            	          var name = "【"+array[i].dictdata_name+"】";
			            	          var value = jQuery("input[id$=__"+key+"],select[id$=__"+key+"]").val();
			            	          if(value){
			            	        	  temp = temp.replaceAll(name,value);
			            	          }          
			            	       }
			            	       jQuery("input[id$=__F_FILES_NO]").val(temp);
			            	    }
			            	   jQuery("#action").val(action);
			                   jQuery("#form1").submit();   
			               }, 
			               error: function (XMLHttpRequest, textStatus, errorThrown) {          
			                   alert("出现异常，请稍后再试！");
			               }
			            });
		    	   }
		           
		           
                            
             },
             cancelFunction:function(){
                 jQuery("#form1").resetSubmit(false);   
             },
             cancelName:'取消'
        };
        alert(alertMsg,p);        
    }   

  /*
        函数:  chooseOrg
        说明:  选择地址
        参数：   name 赋值框的id
        treetypestr 单选框或者多选框
    */
    var chooseFileAddress = function (name,treetypestr){
        var s = new jQuery.z_tree();
        s.treeID = 'mianAddress';
        s.treetypestr = treetypestr;
        s.isShowSeacher = true;
        s.treeName = "选择位置";
        s.headerName = "选择位置";
        s.isType="FILE_ADDRESS"; //要设置默认选中值，则需要此类型
        s.type = "FILE_ADDRESS";
        s.selectedIds = jQuery("#"+name).val(),
        s.f_org_id = "<%=userBean.getUnit_ids()%>";//所属单位id
        s.returnFunction = function(userObj,o){    
           try{
            if (!IsSpace(o)) {
                if(o&&o.length>0){
                    jQuery('#'+name).val(o[0].f_storage_urlname);
                    
                }
            } else {
                jQuery('#'+name).val("");
            }
           }catch(e){
             /**忽略客户端异常信息**/ 
           }
        }
        s.init();
        
    }

/*
    函数:  chooseFileType
    说明:  选择分类
    参数：   name 赋值框的id
    treetypestr 单选框或者多选框
*/
var chooseFileType = function (typeid,name,typeno,treetypestr){
    var s = new jQuery.z_tree();
    s.treeID = 'mianType';
    s.treetypestr = treetypestr;
    s.isShowSeacher = true;
    s.treeName = "选择分类";
    s.headerName = "选择分类";
    s.isType="FILE_TYPE"; //要设置默认选中值，则需要此类型
    s.type = "FILE_TYPE";
    s.selectedIds = jQuery("#"+typeid).val(),
    s.f_org_id = "<%=userBean.getUnit_ids()%>";//所属单位id
    s.returnFunction = function(userObj,o){    
       try{
        if (!IsSpace(o)) {      
            if(o.length>0 && 3==o[0].f_type_level){        
                jQuery('#'+name).val(o[0].f_type_parentname);
                jQuery('#'+typeno).val(o[0].f_typeno);
                jQuery('#'+typeid).val(o[0].f_type_id);
            }else{
                jQuery('#'+name).val("");
                jQuery('#'+typeno).val("");
                jQuery('#'+typeid).val("");
            }
            
        } else {
            jQuery('#'+name).val("");
            jQuery('#'+typeno).val("");
            jQuery('#'+typeid).val("");
        }
       }catch(e){
         /**忽略客户端异常信息**/ 
       }
    }
    s.init();
    
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

/* 打印卷内总说明 */
function printFileDetail() {
     /*判断浏览器的类型并决定采用哪个对象实例，并检测控件是否安装、是否最新版本、并引导安装或升级。  */
    var LODOP=getLodop(document.getElementById('LODOP'),document.getElementById('LODOP_EM'));
    createPrintHtml(LODOP,joinHtml());
    LODOP.PREVIEW();  
};

/*创建部分打印内容  */
function createPrintHtml(LODOP,phtml){
   /*初始化运行环境，清理异常打印遗留的系统资源，设定打印任务名。  */
    LODOP.PRINT_INIT("打印");    
    LODOP.SET_PRINT_STYLEA(0,"FontSize",20);
    LODOP.SET_PRINT_STYLEA(0,"Horient",3);
    LODOP.SET_PRINT_STYLEA(0,"Vorient",3);  
    LODOP.ADD_PRINT_HTM('1.25CM','2.3CM','80%','80%',phtml); 

};
/**
 * 打印卷内信息
 */
function joinHtml(){
      var html = [
        '<div style="width:100%;">',
        '<table style="width:100%;font: normal 12px/29px \'宋体\';background-color: #333;" border="0" cellspacing="1" cellpadding="0" >',
        '<tr>',
        '<td style="width:25%;text-align: center;letter-spacing:12px;background-color: #fff">案卷号</td>',
        '<td style="width:25%;text-align: center;background-color: #fff">',
        jQuery("#f_filesno").val(),
        '</td>',
        '<td rowspan="2" style="width:50%;text-align: center;letter-spacing:5px;background-color: #fff">',
        '盒内文件共',
        jQuery("#f_files_num").val(), 
        '件',
        '</td>',
        '</tr>',
        '<tr>',
        '<td style="text-align: center;letter-spacing:5px;background-color: #fff">保管期限</td>',
        '<td style="text-align: center;background-color: #fff">',
        jQuery("#f_doc_deadline option:selected").text(),
        '</td>',
        '</tr>',
          '<tr>',
        '<td colspan="3" style="text-align: center;letter-spacing:5px;background-color: #fff;height:30px;line-height: 30px;">',
              '<table style="width:100%;font: normal 12px/29px \'宋体\';" border="0" cellspacing="0" cellpadding="0" >',
              '<tr>',
              '<td style="width:5%;text-align: center;">自</td>',
              '<td style="width:40%;text-align: center;">',
              jQuery("#f_start_time").val(),
              '</td>',
              '<td style="width:10%;text-align: center;">起&nbsp;至</td>',
              '<td style="width:40%;text-align: center;">',
              jQuery("#f_end_time").val(),
              '</td>',
              '<td style="width:5%;text-align: center;">止</td>',
              '</tr>',
              '</table>',        
        '</td>',
        '</tr>',
        '</table>',
        '<table style="width:50%;font: normal 12px/29px \'宋体\';float: right;background-color: #333;',
        'margin-top: 5px;" border="0" cellspacing="1" cellpadding="0" >',
              '<tr>',
              '<td style="width:33.33%;text-align: center;background-color: #fff;">全宗号</td>',
              '<td style="width:33.33%;text-align: center;background-color: #fff;">目录号</td>',
             ' </tr>',
               '<tr>',
              '<td style="width:33.33%;text-align: center;background-color: #fff;">',
              jQuery("#f_fondsno").val(),
              '</td>',
              '<td style="width:33.33%;text-align: center;background-color: #fff;">',
              jQuery("#f_listno").val(),
              '</td>',
          '    </tr>',
         '</table>',
        '</div> '
      ];
      return html.join(" ");
  }

/*
 * 打印卷内目录
 */
function printFileList(){
   var url = path+"/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=printFileDoc";
    
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
</script>
<title></title>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('','vcenter',120)">
<form action="" id="form1" name="form1" method="post" >

<div id="vcenter" style="float:left; width:100%;" >
    <div style="float: left; width: 800px;">
        <div class="content_02_box" style="width:780px;">
            <div class="content_02_box_title_bg" style="width:780px;">
                <span>基本信息</span>
            </div>
            <div id="detailDiv" class="content_02_box_div" style="width:780px;">
                <table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width:780px;">
                    <tr>                        
                        <th class="content_02_box_div_table_th">
                            <span class="color_red">*</span>档号：
                        </th>
                        <td colspan="3"  class="content_02_box_div_table_td" >
                            <oa:input type="text" column="F_FILES_NO" table="OA_FILE_FILES"
                                value="" other='style = "width:545px;" class="validate[maxSize[200]] input_160" ' /> 
                              <oa:input type="hidden" column="F_FILES_ID" table="OA_FILE_FILES"
                               other='' />
                           <oa:input type="hidden" column="F_FILES_STATE_NAME" table="OA_FILE_FILES"
                               other='' />
                           <oa:input type="hidden" column="F_FILES_STATE" table="OA_FILE_FILES"
                               other='' />
                           <input type="hidden" name="busiTypeCode" id="busiTypeCode" value="<%=busiTypeCode%>"/>   
                           <input type="hidden" name="busi_id" id="busi_id" value="<%=busi_id%>"/>  
                           <input type="hidden" name="action" id="action" value="<%=action %>"/>
                           <oa:input type="hidden" column="F_ROLLBACK_IDEA" table="OA_FILE_FILES"/>
                           <oa:input type="hidden" column="F_FLOW_STATE" table="OA_FILE_FILES"/>
                           <oa:input type="hidden" column="F_SUBMIT_USER_ID" table="OA_FILE_FILES" value="<%=userId%>"/>
                           <oa:input type="hidden" column="F_SUBMIT_USER_NAME" table="OA_FILE_FILES" value="<%=userName%>"/>
                           <oa:date dateFmt="yyyy-MM-dd" column="F_SUBMIT_TIME" table="OA_FILE_DOC"  style="display:none" defaultValue="<%=DateUtil.getCurrentDate()%>"/>
                           <script type="text/javascript">
                           jQuery(function(){
                        	  jQuery("#OA_FILE_FILES__F_ROLLBACK_IDEA",parent.document.body).html(jQuery("#OA_FILE_FILES__F_ROLLBACK_IDEA").val()); 
                        	  if(action == "add"){
                        		  try{
                        			  var userRole = window.parent.getParentWindow("add_fileFiles").parent.role;
                            		  if(userRole=='dept'){
                            			  jQuery("#OA_FILE_FILES__F_FLOW_STATE").val("0"); 
                            		  }else if(userRole=='org'){
                            			  jQuery("#OA_FILE_FILES__F_FLOW_STATE").val("3");
                            		  }  
                        		  }catch(e){}
                        	  }
                           });
                           </script>
                        </td>
                    </tr>
                   
                    <tr>
                      <th class="content_02_box_div_table_th">
                            存放位置：
                        </th>
                        <td colspan="3" class="content_02_box_div_table_td" >
                            <oa:input type="text" column="F_STORAGE_FULLNAME" table="OA_FILE_FILES"
                                   other='readonly="readonly" style = "width:522px;" class="validate[maxSize[250]] input_160"'
                                    />
                            <input name="f_storage_fullname_button" id="f_storage_fullname_button"
                                   type="button"  class="but_x" />
                           
                        </td>
                    </tr>    
                    <tr>
                        <th class="content_02_box_div_table_th">
                            <span class="color_red">*</span>所属分类：
                        </th>
                        <td class="content_02_box_div_table_td" >
                            <oa:input type="text" column="F_TYPE_NAME" table="OA_FILE_FILES"
                                   other='style = "width:150px;" class="validate[required,maxSize[100]] input_160" ' 
                                   value="<%=StringUtil.deNull(f_type_name) %>"/>
                            <oa:input type="hidden" column="F_TYPE_ID" table="OA_FILE_FILES"
                                   other='' value="<%=StringUtil.deNull(f_type_id) %>" />                            
                            <input name="f_type_name_button" id="f_type_name_button"
                                   type="hidden"  class="but_x"/>
                        </td>
                         <th class="content_02_box_div_table_th">
                                                                                 档案分类号：
                        </th>
                        <td  class="content_02_box_div_table_td" >
                            <oa:input type="text" column="F_TYPENO" table="OA_FILE_FILES"
                                   other='style = "width:150px;" class="validate[maxSize[20]] input_160" ' 
                                   value="<%=StringUtil.deNull(f_typeno) %>"/>
                        </td>
                     </tr>
                     <tr>
                      <th class="content_02_box_div_table_th">
                            <span class="color_red">*</span>所属单位：
                        </th>
                        <td  class="content_02_box_div_table_td" >
                            <oa:input type="text" column="F_ORG_NAME" table="OA_FILE_FILES"
                                value="<%=StringUtil.deNull(userBean.getUnit_name()) %>" 
                                other='readonly="readonly"  style = "width:150px;" class="validate[required,maxSize[50]] input_160"' /> 
                            <oa:input type="hidden" column="F_ORG_ID" table="OA_FILE_FILES"
                                value="<%=StringUtil.deNull(userBean.getUnit_id()) %>" other='' />
                            
                        </td>
                   
                      <th class="content_02_box_div_table_th">
                            <span class="color_red">*</span>所属部门：
                        </th>
                        <td class="content_02_box_div_table_td" >
                           <oa:input type="text" column="F_DEPT_NAME" table="OA_FILE_FILES"
                                value="<%=StringUtil.deNull(userBean.getOrg_name()) %>" 
                                other='readonly="readonly"  style = "width:150px;" class="validate[required,maxSize[50]] input_160"' /> 
                            <oa:input type="hidden" column="F_DEPT_ID" table="OA_FILE_FILES"
                                value="<%=StringUtil.deNull(userBean.getOrg_id()) %>" other='' />
                            <input  name="f_dept_name_button" id="f_dept_name_button"
                                   type="button"  class="but_x"/>
                        </td>
                    </tr>
                     <tr>
                      <th class="content_02_box_div_table_th">
                            <span class="color_red">*</span>档案年份：
                        </th>
                        <td  class="content_02_box_div_table_td" >
                         <oa:input type="text" column="F_DOC_YEAR" table="OA_FILE_FILES"
                                value="<%=StringUtil.deNull(year) %>" other='style = "width:150px;background:url(/xtbg/ccapp/oa/resources/style/blue/images/date_img_year.jpg) right 1px no-repeat;" class="validate[required,maxSize[4]] date_120 Wdate" onclick="WdatePicker({dateFmt:\'yyyy\',maxDate:\'%y\'})"' /> 
                        </td>
                   
                        <th class="content_02_box_div_table_th">
                            <span class="color_red">*</span>保管期限：
                        </th>
                        <td class="content_02_box_div_table_td" >
                            <oa:select column="F_DOC_DEADLINE" table="OA_FILE_FILES" hiddenName="F_DOC_DEADLINE_NAME"
                               other='style="width:150px;" class ="validate[required] select_100_box_type"'>                                 
                                <%for(Map<String,String> dead : deadlineList){ 
                                  String value = StringUtil.deNull(dead.get("dictdata_value"));
                                  String name = StringUtil.deNull(dead.get("dictdata_name"));
                                %>                               
                                <oa:option  optionValue="<%=value %>" 
                                   optionName="<%=name %>"></oa:option>
                                <%} %>
                           </oa:select>                        
                        </td>
                    </tr>   
                     <tr>
                      <th class="content_02_box_div_table_th">
                            <span class="color_red">*</span>全宗号：
                        </th>
                        <td  class="content_02_box_div_table_td" >                           
                            <oa:select column="F_FONDSNO" table="OA_FILE_FILES"
                               other='style="width:150px;" class ="validate[required] select_100_box_type"'>       
                                 
                                <%
                                if(fondsnoList.isEmpty()){%>
                                <oa:option other='' optionValue=" " 
                                   optionName="请先添加全宗号"></oa:option>
                                <%
                                }
                                
                                for(Map<String,String> dead : fondsnoList){ 
                                    String value = StringUtil.deNull(dead.get("f_fondsno"));
                                    String name = StringUtil.deNull(dead.get("f_fondsno_name"));
                                %>
                                  
                                <oa:option other='' optionValue="<%=value %>" 
                                   optionName="<%=value %>"></oa:option>
                                <%} %>
                            </oa:select>
                        </td>
                   
                      <th class="content_02_box_div_table_th">
                            <span class="color_red">*</span>盒号：
                        </th>
                        <td class="content_02_box_div_table_td" >
                             <oa:input type="text" column="F_FILESNO" table="OA_FILE_FILES"
                                value="" other='style = "width:150px;" class="validate[required,maxSize[20],custom[number]] input_160" ' /> 
                        </td>
                    </tr>
                    <tr>                             
                   <th class="content_02_box_div_table_th">
                           <span class="color_red">*</span>  密级：
                        </th>
                        <td  class="content_02_box_div_table_td" >  
                             <oa:select column="F_SECRECY_ID" table="OA_FILE_FILES" hiddenName="F_SECRECY_NAME"
                               other='style="width:150px;" class ="validate[required] select_100_box_type"'>                    
                                   <%for(Map<String,String> type : secretList){ 
                                       String value = StringUtil.deNull(type.get("dictdata_value"));
                                       String name = StringUtil.deNull(type.get("dictdata_name"));
                                   %>
                                     <oa:option   optionValue="<%=value %>" 
                                        optionName="<%=name %>"></oa:option>
                                   <%} %>
                             </oa:select>    
                        </td>
                        <th class="content_02_box_div_table_th">
                            <span class="color_red">*</span>目录号：
                        </th>
                        <td class="content_02_box_div_table_td" >
                        <oa:input type="text" column="F_LISTNO" table="OA_FILE_FILES"
                                value="" other='style = "width:150px;" class="validate[required,maxSize[50]] input_160" ' /> 
                        </td>
                    </tr>
                    <tr>
                      <th class="content_02_box_div_table_th">
                            <span class="color_red">*</span>实物类型：
                        </th>
                        <td  class="content_02_box_div_table_td" >
                             <oa:select column="F_ENTITY_TYPE" table="OA_FILE_FILES" hiddenName="F_ENTITY_TYPE_NAME"
                               other='style="width:150px;" class ="validate[required] select_100_box_type"'>       
                                <%for(Map<String,String> type : swlxList){ 
                                    String value = StringUtil.deNull(type.get("dictdata_value"));
                                    String name = StringUtil.deNull(type.get("dictdata_name"));
                                %>
                                     <oa:option optionValue="<%=value %>" 
                                        optionName="<%=name %>"></oa:option>
                                <%} %>
                            </oa:select>
                        </td>
                   
                      
                        <th class="content_02_box_div_table_th" id="fileCount_td">
                             卷内件数：
                        </th>
                        <td class="content_02_box_div_table_td" >
                            <oa:input type="text" column="F_FILES_NUM" table="OA_FILE_FILES"
                                value="0" other='readOnly="readOnly" style = "width:150px;" maxlength="8" class="validate[maxSize[8],custom[positiveinteger]] input_160"  ' /> 
                        </td>
                        
                    </tr>  
                    <tr>
                      <th class="content_02_box_div_table_th">
                                                                                 起始日期：
                        </th>
                        <td  class="content_02_box_div_table_td" >
                            <oa:date  column="F_START_TIME" table="OA_FILE_FILES"
                                realDateFmt = "yyyy-MM-dd" dateFmt="yyyy-MM-dd"
                                maxDate="#F{$dp.$D(\\'OA_FILE_FILES__F_END_TIME\\')||\\'2099-12-12\\'}"
                                other='style = "width:150px;" class="validate[maxSize[25]] date_120 Wdate" ' />                         
                        </td>
                        <th class="content_02_box_div_table_th">
                                                                            终止日期：
                        </th>
                        <td class="content_02_box_div_table_td" >
                            <oa:date  column="F_END_TIME" table="OA_FILE_FILES"
                                realDateFmt = "yyyy-MM-dd" dateFmt="yyyy-MM-dd"
                                minDate="#F{$dp.$D(\\'OA_FILE_FILES__F_START_TIME\\')||\\'1980-01-01\\'}"
                                other='style = "width:150px;" class="validate[maxSize[25]] date_120 Wdate" ' />                         
                           </td>
                    </tr>
                    <tr>
                      <th class="content_02_box_div_table_th">
                                                                          归档人：
                        </th>
                        <td  class="content_02_box_div_table_td" >
                            <oa:input type="text" column="F_FILE_USERNAME" table="OA_FILE_FILES"
                                value="<%=StringUtil.deNull(userName) %>" 
                                other=' readonly="readonly" style = "width:150px;" class="validate[maxSize[25]] input_160" ' />                         
                           <oa:input type="hidden" column="F_FILE_USERID" table="OA_FILE_FILES"
                                value="<%=StringUtil.deNull(userId) %>" other='' />
                        </td>
                   
                        <th class="content_02_box_div_table_th">
                                                                                归档日期：
                        </th>
                        <td class="content_02_box_div_table_td" >
                            <oa:date  column="F_FILE_TIME" table="OA_FILE_FILES"
                                realDateFmt = "yyyy-MM-dd" dateFmt="yyyy-MM-dd"     
                                defaultValue="sysDate"                           
                                other='style = "width:150px;" class="validate[maxSize[25]] date_120 Wdate" ' />                         
                        </td>
                    </tr>
                    <tr>                      
                        <th class="content_02_box_div_table_th">
                                                                             责任者：
                        </th>
                        <td  class="content_02_box_div_table_td" >
                            <!-- 责任者默认为当前单位 -->
                            <oa:input type="text" column="F_DOC_BLNAME" table="OA_FILE_FILES"
                                value="<%=StringUtil.deNull(userBean.getUnit_name()) %>" other='style = "width:150px;" class="validate[maxSize[100]] input_160" ' />                         
                        </td>
                        <th class="content_02_box_div_table_th">
                                                                               归档状态：
                        </th>
                        <td  class="content_02_box_div_table_td" >
                            <span id='guidang_state'></span>
                        </td>
                    </tr> 
                    <tr>
						<th class="content_02_box_div_table_th">排序号：</th>
						<td colspan="3" class="content_02_box_div_table_td" >
							<oa:input type="text" column="F_ORDER" table="OA_FILE_FILES"
								other='style="width:522px;" class="validate[maxSize[250],custom[number]] input_160"'/>
                        </td>
                    </tr>
                    <tr>
                        <th rowspan="2" class="content_02_box_div_table_th">
                                                                                 内容：
                        </th>
                        <td class="content_02_box_div_table_td" colspan="3" >
                            <input type="button" value="获取模板" class="but_y_01" onclick="getContentTemp();"/>
                        </td>
                    </tr>
                    <tr> <td class="content_02_box_div_table_td" colspan="3" >
                            <oa:textarea column="F_FILES_CONTENT" table="OA_FILE_FILES"
                               other='class="validate[maxSize[1000]] textarea_575" style="width:545px;"' rows="5"/>
                        </td></tr>
                </table>
            </div>
        </div>      
    </div>   
    
</div>
</form>
</body>
</oa:filedocinit>
</html>