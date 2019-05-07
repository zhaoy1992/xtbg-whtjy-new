<%--
describe:批量修改档案
author:dailianchun
date: 2013-7-23
--%>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.*"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.*"%>

<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.*"%>
<%@page import="com.chinacreator.xtbg.core.file.service.*"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileConstant"%>
<%
    AccessControl accesscontroler = AccessControl.getAccessControl();
    accesscontroler.checkAccess(request, response);
    String path = request.getContextPath();
    String ids = StringUtil.deNull(request.getParameter("ids"));//主键id
    String windowId = request.getParameter("windowId");//窗口id
    
    FileFilesBean searchBean = new FileFilesBean();
    searchBean = (FileFilesBean) RequestBeanUtils
    .getValuesByRequest(request, searchBean);//获取表单提交过来的数据
    
    String userId = accesscontroler.getUserID();//用户id
    String userName = accesscontroler.getUserName();//用户名
    String deptId = accesscontroler.getChargeOrgId();//用户所属部门id
    String deptorgName = accesscontroler.getChargeOrgName();//所属部门名
    String time = DateUtil.getCurrentDate();//创建时间
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script src="../../resources/util/public.js" type="text/javascript"></script>
<!-- 引入提示 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>

<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.core-3.0.js"></script>
<script type="text/javascript" src="../../resources/plug/JQuery zTree v3.0/js/jquery.ztree.excheck-3.0.js"></script>

<!-- 引入formvValidatetion -->
<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
//要修改的id
var ids = "<%=ids%>";
//父窗口id
var windowId ="<%=windowId%>";
var path = "<%=path%>";

jQuery(function(){
     jQuery("#f_storage_fullname ").focus();
     //选择位置按钮赋点击事件
     jQuery("#f_storage_fullname_button").click(function(){
        chooseFileAddress("f_storage_fullname","radio");

     });        
     //选择分类
     jQuery("#f_type_name_button").click(function(){
    	 chooseFileType("f_type_id","f_type_name","f_typeno","radio");
      });
     //选择部门
     jQuery('#f_dept_name_button').click(function(){
         chooseOrg('f_dept_id','f_dept_name','radio');
      });  
     jQuery("#update_column").change(function(){
         //隐藏div
         jQuery("#update_values>div").hide();
         jQuery(jQuery(this).val()).show();
     });
     
     //触发事件
     jQuery("#update_column").trigger("change");
});

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
    s.selectedIds = jQuery("#"+name).val(),
    s.f_org_id = "<%=userBean.getUnit_ids()%>";//所属单位id
    s.returnFunction = function(userObj,o){    
       try{
        //最底层的类型才能被选中
        if (!IsSpace(o) && o[0].f_type_level ==3 ) {
            if(o&&o.length>0){
                jQuery('#'+name).val(o[0].f_type_parentname);
                jQuery('#'+typeno).val(o[0].f_typeno);
                jQuery('#'+typeid).val(o[0].f_type_id)
            }
        }else {
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

	/*
	函数:  chooseOrg
	说明:  选择部门
	参数：   name 赋值框的id
	treetypestr 单选框或者多选框
	*/
	var chooseOrg = function (id,name,treetypestr){
	    var s = new jQuery.z_tree();
	    s.treeID = 'mainUser';
	    s.treetypestr = treetypestr;
	    s.isShowSeacher = true;
	    s.treeName = "选择部门";
	    s.headerName = "选择部门";
	    s.isType="dept"; //要设置默认选中值，则需要此类型
	    s.type = "ADEPT";
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

/*
函数:  Ok
说明:  提交添加与修改(发布操作)
参数:   无
返回值: 无
*/
var Ok = function() {
	var updateLimit = jQuery("input[name=update_limit]:checked").val();
    //更新选中的记录
    if("selected" == updateLimit && IsSpace(ids)){
       alert("没有选中任何记录，不能修改");
       return;
    }
    //是否全部验证通过      
    if(!jQuery('#form1').validationEngine('validate') ){
      return ;
    }
    var url = path+"/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=updateListFiles";
    alert('是否需要同步生成档号',{
           headerText:'提示', 
           okName:'是',
           okFunction:function(){
    	     ajaxSubmit(url,"1");
           },
           cancelName:'否',
           cancelFunction: function(){
        	 ajaxSubmit(url,"0");
           }
    });
}


/**
 函数:  ajaxSubmit
 说明:  ajax访问后台
 参数:  state 状态 0：暂存，1：发布
 返回值: 无
 */
var ajaxSubmit = function(url,filenoFlag){
      
    jQuery("#cz_fb_button").attr("disabled","disabled");
    var param = getValue();
    param["filenoFlag"] = filenoFlag;//filenoFlag 1:重新生成档号，0：不重新生成档号
    //ajax方式提交数据
    jQuery.ajax({
        type: "post", 
        url: url,
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        data : param,
        dataType: "json", 
        success: function (data) {
            jQuery("#cz_fb_button").removeAttr("disabled");
            
            //操作成功，返回上层界面
            if(data && data.flag && "true" == data.flag){
                //调用父窗口的方法重新加载数据
                var pwindow = window.top.findPageCacheName(windowId).superwindow;
                if(pwindow && pwindow.search){
                    pwindow.search();
                }                   
            }
            if(data &&data.msg){                
              alert(data.msg,{
                  headerText:'提示',
                  okName:'确认',
                  okFunction:function(){
                     if(data.flag == "true"){
                        removeAlertWindows(windowId,true);
                     }
                  }
                  });
            }
        }, 
        error: function (XMLHttpRequest, textStatus, errorThrown) { 
            jQuery("#cz_fb_button").removeAttr("disabled");
            alert("出现异常，请稍后再试！");
        } 
     });          
}

/**
 * 获得要提交的参数
 */ 
function getValue(){
    var params = {};
    var updateLimit = jQuery("input[name=update_limit]:checked").val();
    if("selected" == updateLimit){ //修改选中的记录
    	 params["ids"] = ids; //传入的id 
    }
    if("all" == updateLimit){//修改全部满足条件的记录
         params["search.f_dept_name"] = "<%=searchBean.getF_dept_name()%>";
         params["search.f_doc_year"] = "<%=searchBean.getF_doc_year()%>";
         params["search.f_doc_deadline_name"] = "<%=searchBean.getF_doc_deadline_name()%>";
         params["search.f_files_title"] = "<%=searchBean.getF_files_title()%>";
         params["search.f_filesno"] = "<%=searchBean.getF_filesno()%>";
         params["search.f_secrecy_name"] = "<%=searchBean.getF_secrecy_name()%>";
         params["search.f_type_id"] = "<%=searchBean.getF_type_id()%>";
         params["search.f_files_state"]="<%=searchBean.getF_files_state()%>";
         
         params["search.f_org_id"]="<%=searchBean.getF_org_id()%>";
         params["search.f_files_no"]="<%=searchBean.getF_files_no()%>";
         params["search.f_listno"]="<%=searchBean.getF_listno()%>";
         params["search.f_files_num"]="<%=searchBean.getF_files_num()%>";
         params["search.f_start_time"]="<%=searchBean.getF_start_time()%>";
         params["search.f_end_time"]="<%=searchBean.getF_end_time()%>";  
    }   
    
    var updateColumn = jQuery("#update_column").val();
    if("#f_storage_fullname_div" == updateColumn){
    	//档案存放位置
        params["bean.f_storage_fullname"] = jQuery("#f_storage_fullname").val();
    }
    if("#f_doc_deadline_div" == updateColumn){
    	//保管期限
        params["bean.f_doc_deadline"] = jQuery("#f_doc_deadline").val();
        params["bean.f_doc_deadline_name"] = jQuery("#f_doc_deadline option:selected").text();
    }
    if("#f_type_name_div" == updateColumn){
    	 //档案分类
        params["bean.f_type_name"] = jQuery("#f_type_name").val();
        params["bean.f_type_id"] = jQuery("#f_type_id").val();    
        params["bean.f_typeno"] = jQuery("#f_typeno").val();
    }
    if("#f_fondsno_div" == updateColumn){
    	//全宗号
        params["bean.f_fondsno"] = jQuery("#f_fondsno").val();
    }
    if("#f_secrecy_id_div" == updateColumn){
    	//密级
        params["bean.f_secrecy_id"] = jQuery("#f_secrecy_id").val();
        params["bean.f_secrecy_name"] = jQuery("#f_secrecy_id option:selected").text();
    }
    if("#f_doc_blname_div" == updateColumn){
    	 //责任者
        params["bean.f_doc_blname"] = jQuery("#f_doc_blname").val();
        params["bean.f_doc_blid"] = jQuery("#f_doc_blid").val();
    }  
    if("#f_dept_name_div" == updateColumn){
        //所属部门
       params["bean.f_dept_name"] = jQuery("#f_dept_name").val();
       params["bean.f_dept_id"] = jQuery("#f_dept_id").val();
   }
    if("#f_file_time_div" == updateColumn){
        //归档日期
       params["bean.f_file_time"] = jQuery("#f_file_time").val();
   }  
    //转码
    for(var name in params ){
    	params[name] = descape(escape(params[name]));
    }  
    return params;    
}


/**
 * 关闭弹出框
 */
function closed(){
    //新增或修改数据，提示是否保存
    removeAlertWindows(windowId,true);
        
}
</script>
</head>
<body>
<form id="form1" action="" method="post">  
<!-- 表格-->
    <div id="vcenter" style="float: left; width: 100%;height:293px;overflow: scroll；padding:0px;text-align: center;">
        <div style="float: left; width: 100%;margin:0px;padding:0px;">
            <table border="0" cellspacing="0" cellpadding="0" class="content_02_box_div_table" style="width:100%;">
                    <tr>
                    <td colspan="2" class="content_02_box_div_table_td" valign="middle"> 
                      <input name="update_limit" type="radio" checked="checked" value="selected" />&nbsp;
                     <span style="cursor:hand;" onclick="jQuery('input[name=update_limit][value=selected]').attr('checked','checked');">
                                                                选中的案卷</span>
                     <input  name="update_limit" type="radio" value="all" />&nbsp;
                     <span style="cursor:hand;" onclick="jQuery('input[name=update_limit][value=all]').attr('checked','checked');">
                                                                满足条件的所有案卷</span>
                    </td>
                    </tr>
                    <tr>
                    <td style="border-bottom: #ebebeb 1px solid;height:28px;font-weight:bolder;width:200px;background-color: #f1f1f1;text-align: center;">
                                                                 修改项
                    </td>
                    <td style="border-bottom: #ebebeb 1px solid;height:28px;font-weight:bolder;width:400px;background-color: #f1f1f1;text-align: center;">
                                                                修改的值
                    </td>
                    </tr>
                     <tr>
                    <td class="content_02_box_div_table_td" style="text-align: center;">
                        <select style="width:150px;" name ="update_column" id= "update_column" class ="select_100_box_type" >
                           <option value="#f_storage_fullname_div" selected="selected">存放位置</option>
                           <option value="#f_doc_deadline_div">保管期限</option>
                           <option value="#f_type_name_div">所属分类</option>
                           <option value="#f_fondsno_div">全宗号</option>
                           <option value="#f_secrecy_id_div">密级</option>
                           <option value="#f_doc_blname_div">责任者</option> 
                           <option value="#f_dept_name_div">所属部门</option>
                           <option value="#f_file_time_div">归档日期</option>                       
                        </select>
                    </td>
                    <td id="update_values" class="content_02_box_div_table_td" style="width:400px;">
                        <div id="f_storage_fullname_div" style="display:none;width:100%;margin:0px;border:0px;">
                           <input style = "width:300px;" type="text" class="validate[required,maxSize[100]] input_160" name="f_storage_fullname" id="f_storage_fullname"/>
                           <input name="f_storage_fullname_button" id="f_storage_fullname_button"
                                   type="button"  class="but_x"/>
                        </div>
                        <div id="f_doc_deadline_div" style="display:none;width:100%;margin:0px;border:0px;">
                           <select style="width:300px;" name ="f_doc_deadline" id= "f_doc_deadline" class ="input_cx_title_283" >
                                <%for(Map dead : deadlineList){ %>
                                <option value="<%=StringUtil.deNull(dead.get("dictdata_value")) %>">&nbsp;<%=StringUtil.deNull(dead.get("dictdata_name")) %></option>
                                <%} %>
                             </select>
                        </div>   
                        <div id="f_type_name_div" style="display:none;width:100%;margin:0px;border:0px;">
                           <input name="f_type_name" id="f_type_name" style = "width:300px;" type="text" class="validate[required,maxSize[100]] input_160" />
                           <input name="f_type_name_button" id="f_type_name_button"
                                   type="button"  class="but_x"/>
                           <input style = "width:150px;" type="hidden" name="f_typeno" id="f_typeno" />
                           <input name="f_type_id" id="f_type_id"  type="hidden"/>
                        
                        </div>
                        <div id="f_fondsno_div" style="display:none;width:100%;margin:0px;border:0px;">
                            <select style="width:300px;" name ="f_fondsno" id= "f_fondsno" class ="select_100_box_type" >
                              <%
                                if(fondsnoList.isEmpty()){%>
                                <option value=" " >请先添加全宗号</option>
                                <%
                                }                      
                                for(Map<String,String> dead : fondsnoList){ %>
                                <option title="<%=StringUtil.deNull(dead.get("f_fondsno_name")) %>"  value="<%=StringUtil.deNull(dead.get("f_fondsno")) %>"><%=StringUtil.deNull(dead.get("f_fondsno")) %></option>
                                <%} %>
                            </select>
                        </div>
                        <div id="f_secrecy_id_div" style="display:none;width:100%;margin:0px;border:0px;">
                           <select style="width:300px;"  name ="f_secrecy_id" id= "f_secrecy_id" class ="select_100_box_type" >
                                   <%for(Map<String,String> type : secretList){ %>
                                    <option title="<%=StringUtil.deNull(type.get("dictdata_name")) %>" value="<%=StringUtil.deNull(type.get("dictdata_value")) %>"><%=StringUtil.deNull(type.get("dictdata_name")) %></option>
                                   <%} %>
                           </select>
                        </div>
                        <div id="f_doc_blname_div" style="display:none;width:100%;margin:0px;border:0px;">
                           <input style = "width:300px;" type="text" class="validate[maxSize[100]] input_160" name="f_doc_blname" id="f_doc_blname"/>                           
                           <input id="f_doc_blid" name="f_doc_blid" type="hidden"/>                      
                        </div>   
                        <div id="f_dept_name_div" style="display:none;width:100%;margin:0px;border:0px;">
                           <input style = "width:300px;" type="text" class="validate[required,maxSize[200]] input_160" name="f_dept_name" id="f_dept_name" readonly="readonly"/>                           
                           <input id="f_dept_id" name="f_dept_id" type="hidden"/>
                           <input  name="f_dept_name_button" id="f_dept_name_button"
                                   type="button"  class="but_x"/>                      
                        </div>   
                        <div id="f_file_time_div" style="display:none;width:100%;margin:0px;border:0px;">
                           <input style = "width:300px;" type="text" class="validate[required,maxSize[100]] date_120 Wdate" name="f_file_time" id="f_file_time" 
                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'})"/>                           
                                                                     
                        </div>
                              
                    </td>
                    </tr>
            </table>
        </div>
    </div>
    <div class="content_02" style="overflow: hidden;" id="_top"><!-- 操作-->
        <div class="content_02_top" style="border-bottom: 0px;border-top:1px solid #9dbfe4;padding-right:5px;">
            <input name="close_button"  value="关闭" onclick="closed()" type="button" class="but_y_01" style="float: right;margin-right: 5px;" />
            <input  name="cz_fb_button" id="cz_fb_button" value="保存" onclick="Ok(this.value);" style="float:right;" type="button" class="but_y_01" /> 
        </div>
    </div>
 </form>   
</body>
</html>