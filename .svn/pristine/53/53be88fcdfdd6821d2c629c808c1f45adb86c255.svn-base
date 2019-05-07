<%--
describe:调卷界面
author:dailianchun
date: 2013-8-20
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileConstant"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    String id = StringUtil.deNull(request.getParameter("id"));//档案id
    String windowId = StringUtil.deNull(request.getParameter("windowId"));//窗口id
    String f_type_id = StringUtil.deNull(request.getParameter("f_type_id"));//类型id
    String columnName = StringUtil.deNull(request.getParameter("columnName"));//图片档案为组号
    if(StringUtil.nullOrBlank(columnName)){
    	columnName = "件号";
    }else{
    	//解码
        columnName =DataControlUtil.replaceStr(columnName);
        columnName = Escape.unescape(columnName);
    }
    //获得当前登录用户的id
    String userId = controler.getUserID();
    //获得缓存的机构信息
    UserCacheBean userBean = UserCache.getUserCacheBean(userId);
    String unitId = userBean.getUnit_id();//所属单位id
    String orgName = userBean.getOrg_name();//所属部门
    //服务对象
    FileFilesService service = new FileFilesServiceImpl();
    //保管期限
    List<Map<String,String>> deadlineList =  service.queryDictByCode(FileConstant.DICT_TYPE_BGQX);
    String year = DateUtil.getCurrentYear();//获得当前年
    
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
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/filefitcss.css" />

<script type="text/javascript">
var path = "<%=path%>";
var windowId = "<%=windowId%>";
var unitId = "<%=unitId%>";
var f_type_id = "<%=f_type_id%>";
//用来判断是否更改的对象
var dataObj = null;
function addTr(rows,divId){
    jQuery(divId).html("");//清空数据
    //添加数据
    var htmlArray = new Array();
    for(var i=0;i<rows.length;i++){
       htmlArray.push("<div id='"+divId.substring(1,divId.length-1)+i+"' class='unselected' onClick ='onDivClick(this)'");
       htmlArray.push(" onMouseOver='onMouseOver(this)'");
       htmlArray.push(" onMouseOut='onMouseOut(this)'");
       htmlArray.push(" f_files_no='"+rows[i].f_files_no+"'");
       htmlArray.push(" parent_div='"+divId+"'");
       htmlArray.push("><div style='width:70%;float:left;line-height:23px;'");
       htmlArray.push(" title='"+rows[i].f_files_no+"'>");
       htmlArray.push(rows[i].f_files_no);
       htmlArray.push("</div><div style='width:30%;float:left;line-height:23px;'");
       htmlArray.push(" title='"+rows[i].f_filesno+"'>");
       htmlArray.push(rows[i].f_filesno);
       htmlArray.push("</div><input type='hidden' name='filesId' value='"+rows[i].f_files_id+"'></div>");
    }
    jQuery(divId).html(htmlArray.join(""));
}
function addTr1(rows,divId){
    jQuery(divId).html("");//清空数据
    //添加数据
    var htmlArray = new Array();
    for(var i=0;i<rows.length;i++){
       htmlArray.push("<div id='"+divId.substring(1,divId.length-1)+i+"' class='unselected' onClick ='onDivClick(this)'");
       htmlArray.push(" onMouseOver='onMouseOver(this)'");
       htmlArray.push(" onMouseOut='onMouseOut(this)'");
       htmlArray.push(" f_files_no='"+rows[i].f_doc_id+"'");
       htmlArray.push(" parent_div='"+divId+"'");
       htmlArray.push("><div style='width:70%;float:left;line-height:23px;'");
       htmlArray.push(" title='"+rows[i].f_doc_name+"'>");
       htmlArray.push(rows[i].f_doc_name);
       htmlArray.push("</div><div style='width:30%;float:left;line-height:23px;'");
       htmlArray.push(" title='"+rows[i].f_doc_num+"'>");
       htmlArray.push(rows[i].f_doc_num);
       htmlArray.push("</div><input type='hidden' name='filesId' value='"+rows[i].f_doc_id+"'></div>");
    }
    jQuery(divId).html(htmlArray.join(""));
}

function publicAjax(url,data,backFn){
      //ajax方式提交数据
      jQuery.ajax({
          type: "post", 
          url: url,
          contentType: "application/x-www-form-urlencoded; charset=utf-8",
          data : data,
          dataType: "json", 
          success: function (data) {
              if(backFn&& (typeof backFn=='function')){
                  backFn(data);
              }
          }, 
          error: function (XMLHttpRequest, textStatus, errorThrown) { 
              jQuery("#cz_fb_button").removeAttr("disabled");
              alert("出现异常，请稍后再试！");
          }
       });
}

function getConfig(){
	return getParentWindow("orderListPage").orderConfig;
}
function addJson(a,b){
	for(var i in b){
		a[i]=b[i];
	}
	return a;
}
function searchFile(){
	var url = getConfig().openWindowActionURL;
    var data = addJson(getConfig().dataArgs,getConfig().pageArgs);
    var backFn = function(backData){
        if(backData && backData.rows){
        	if(getConfig().addTrType=="addTr1"){
        		addTr1(backData.rows,"#fromDiv");
        	}else{
        		addTr(backData.rows,"#fromDiv");
        	}
        }
    };
    publicAjax(url,data,backFn);
}
function search(){
    searchFile();
}

//搜索框的控制对象
$(function() {

    $(document).keydown(function(){
        if(event.keyCode == 13){
            search();
        }
    });
    jQuery("#fromDiv").sortable(
            {
                delay:1,
                distance : 0,
                opacity: 0.6,//拖拽时的透明度
                dropOnEmpty : true,//是否允许拖拽到一个空的sortable
                scroll : false,
                tolerance : "pointer",
                helper : "original",
                receive : function(event,ui){
	                jQuery(ui.item).attr("class","selected");
              }
      }
    );
    //查询数据
    search();
    //设置页面高度
    adaptationWH('','content',65);
    var tableHeadName = getConfig().tableHeadName;
    if(tableHeadName){
    	for(var id in tableHeadName){
    		jQuery("#"+id).html(tableHeadName[id]);
    	}
    }
    });
 

   /**
    *单击后触发的事件
    */
   function onDivClick(obj){
       var objClass = jQuery(obj).attr("class");
       if(objClass == "unselected" || objClass =="onmouseover"){
           jQuery(obj).attr("class","selected");      
       }else{
           jQuery(obj).attr("class","unselected");      
       }        
   }

   /**
    *鼠标移入触发的事件
    */
   function onMouseOver(obj){
       var objClass = jQuery(obj).attr("class");
       if(objClass != "selected"){
           jQuery(obj).attr("class","onmouseover");      
       }       
   }

   /**
    *鼠标移出触发的事件
    */
   function onMouseOut(obj){
       var objClass = jQuery(obj).attr("class");
       if(objClass == "onmouseover"){
           jQuery(obj).attr("class","unselected");      
       }  
   }

   /**
    *保存数据
    */
   function save(){
	   //找到选中的option
	   var f_files_id_from = jQuery("#from").val();
	   var idsArray = new Array();
	   jQuery("#fromDiv input").each(function(){
		   idsArray.push(this.value);
        });
	
     var data={
          "bean.f_files_id" : idsArray.join(",")
     };
     var backFn = function(data){
     	searchFile();
         getConfig().afterOrderSumbitFn();
     }
     if(!getConfig().saveUrl){
     	var url = path+"/ajaxServlet?className="
    	 +"com.chinacreator.xtbg.core.file.action.FileFilesAction&method=updateFilesListOrder";
     }else{
     	var url = getConfig().saveUrl;
     }
     publicAjax(url,data,backFn);
     
   }

/**
 * 关闭弹出框
 */
function closed(){    
   removeAlertWindows(windowId,true);
}
</script>
</head>
<body style="height:200px;">
<div id="content" style="width:100%;height:200px;">
    <div style="width:100%;text-align: center;height:200px;" align="center">
<table cellpadding="0" border="0" cellspacing="0" style="width:100%;height:200px;">
<tr valign="top">
	<td width="45%"
		style="border: 1px solid #f1f1f1; border-top: #fff 0px;"
		valign="top">
		<table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%; border-top: #fff 2px solid;">
			<tr style="height: 25px; margin-top: 0px; background: #f1f1f1; font-weight: bolder;">
				<td style="border-bottom: #C5DBEC 1px solid; width: 70%" id='oneTdCol'>
					档号
				</td>
				<td style="border-bottom: #C5DBEC 1px solid; width: 30%" id='twoTdCol'>
					盒号
				</td>
			</tr>
			<tr>
				<td colspan="2" style="width: 100%">
					<div id="fromDiv" class="vcenter"
						style="width: 100%;height:400px;overflow-y:auto;overflow-x: hidden; text-align: left;">
		
					</div>
				</td>
			</tr>
		</table>
	</td>
</tr>
<tr>
</table>
    </div>
</div>
    
    
   <div class="content_02" style="overflow: hidden;position: absolute;bottom: 0px;" id="_top"><!-- 操作-->
        <div class="content_02_top" style="border-bottom: 0px;border-top:1px solid #9dbfe4;padding-right:5px;">
            <input name="close_button"  value="关闭" onclick="closed()" type="button" class="but_y_01" style="float: right;margin-right: 5px;" />
            <input  name="cz_fb_button" id="cz_fb_button" value="保存" onclick="save();" style="float:right;" type="button" class="but_y_01" /> 
        </div>
    </div>
</body>
</html>