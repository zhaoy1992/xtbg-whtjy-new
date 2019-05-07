<%--
describe:添加档案的界面
author:dailianchun
date: 2013-7-17
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%
AccessControl accesscontroler = AccessControl.getAccessControl();
accesscontroler.checkAccess(request, response);
String userId = accesscontroler.getUserID();
//获得缓存的机构信息
UserCacheBean userBean = UserCache.getUserCacheBean(userId);
String unitId = userBean.getUnit_id();//单位id
//父窗口id
String windowId = StringUtil.deNull(request.getParameter("windowId"));
//档案id
String id = StringUtil.deNull(request.getParameter("id"));
String f_type_id = StringUtil.deNull(request.getParameter("f_type_id"));
String f_type_name = StringUtil.deNull(request.getParameter("f_type_name"));  
//解码
f_type_name =DataControlUtil.replaceStr(f_type_name);
f_type_name = Escape.unescape(f_type_name);
String f_typeno = StringUtil.deNull(request.getParameter("f_typeno"));
String f_files_state = StringUtil.deNull(request.getParameter("f_files_state"));//案卷状态(0：待归档    1、已归档（正常状态）   8、已移交（移交到档案局）   9. 已销毁)
String busiTypeCode =StringUtil.deNull(request.getParameter("busiTypeCode"));//业务名
if(StringUtil.nullOrBlank(f_files_state)){
	f_files_state = "0";
}
String action= StringUtil.nullOrBlank(id)?"add":"update";
String busi_id = StringUtil.nullOrBlank(id)?StringUtil.getUUID():id;//传入业务id，则取传入的id，没有传入则新建id
//服务对象
FileFilesService service = new FileFilesServiceImpl();  
Map<String,String> programMap = service.queryProgramByTypeId(f_type_id);
String detailPage = "";//添加档案的明细界面
if(null != programMap && programMap.size()>0){
	detailPage = StringUtil.deNull(programMap.get("f_files_detail"));//获得添加档案的明细界面
}
String path = request.getContextPath();
//判断用户是否档案管理员
boolean isFileManager = KbmUtil.isRolesUser(userId,"单位档案管理员");
//是否档案分类管理员
boolean isFileTypeManager = service.isFileTypeAdmin(userId,f_type_id);
//进入页面后，只能查看，不能进行其他任何操作
String isview = StringUtil.deNull(request.getParameter("isview"));
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<%@page import="com.chinacreator.eform.util.Escape"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript"
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>

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
<!-- 日期控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="../resources/js/UUID.js" type="text/javascript"></script>



<!-- 公共部分引用结束 -->       
<script type="text/javascript" charset="utf-8">
    var f_type_id = "<%=f_type_id%>";
    var path = "<%=path%>";
    var isFileManager = <%=isFileManager%>;//是否单位档案管理员
    var isFileTypeManager = <%=isFileTypeManager%>;//是否分类档案管理员（档案分类中配置）
	var windowId = "<%=windowId%>";
	var  f_files_state = "<%=f_files_state%>";//归档状态
	var id = "<%=busi_id %>";	
	var action = "<%=action%>";
	//由于程序界面没有配置项，则在此处写死【文档详细页面-入卷页面】映射关系
    var DETAIL_LIST = [
                         ["filefilesdetail.jsp","filedoclist4files.jsp"],//文书档案
                         ["filefilesdetail4pic.jsp","filedoclist4filespic.jsp"],//照片档案 
                         ["filefilesdetail4disk.jsp","filedoclist4filesdisk.jsp"],//光盘档案
                         ["filefilesdetail4video.jsp","filedoclist4filesvideo.jsp"]//视频档案
                       ];

    var detailPage = "<%=detailPage%>";
        
    //获取列表界面
    var listPage = (function getListPage(detailPage){
        for(var i =0 ;i<DETAIL_LIST.length;i++){
           if(detailPage == DETAIL_LIST[i][0]){
              return DETAIL_LIST[i][1];
           }
        }
        return false;
    }(detailPage));
    
	$(function() {
		//加载对应的添加页面
        if(detailPage){
           jQuery("#frame1").attr("src",getCurrentFilePath()+detailPage
                   +"?action="+action+"&f_type_id=<%=f_type_id %>&f_type_name="+descape(escape("<%=f_type_name %>"))+
                   "&f_typeno=<%=f_typeno %>&busiTypeCode=<%=busiTypeCode %>&busi_id=<%=busi_id %>&isview=<%=isview%>" );
        }
		
	    $("#tabs").tabs({
	    	border:true,  
	        select : function(event, ui) {
	            if("tabTitle2" == jQuery(ui.tab).attr("id")){
		            //如果页面未加载，则加载页面
                   if(listPage){
                      jQuery("#frame2").attr("src",getCurrentFilePath()+listPage+"?id="+id+"&action="+action+"&isview=<%=isview%>");
                   }else{
                	   jQuery("#frame2").attr("src","");
                   }
	            }                
	        }
	    });
        jQuery("#_top_tabs").show();
	    adaptationWH('','frame1',80);
	    adaptationWH('','frame2',80);
	    adaptationWH('','frame3',80);
	    //如果为更新操作，则显示所有tab页
	    if("update" == action){
	    	showTab();
	    }
	    //如果是查看，则只显示返回按钮
        if(!"<%=isview%>"){
            //显示按钮
            showButton();
        }
	    //添加事件
	    addAction();
	});

	/**
	 *当为修改操作或者档案已经保存后，展示tab页
	 */
    function showTab(){
        //如果没有得到卷内文件页面，则不显示(会计档案没有卷内文件和备考表)
        if(listPage){
        	$("#tabTitle2_div").show();
        	 $("#tabs-2").show();
        	 if(!jQuery("#frame2").attr("src") && listPage){
                 jQuery("#frame2").attr("src",getCurrentFilePath()+listPage+"?id="+id+"&action="+action+"&isview=<%=isview%>");
              }
        	 $("#tabTitle3_div").show();       
             $("#tabs-3").show(); 
        }
    }
	
	/**
	 *按钮的显示控制
	 */
    function showButton(){
        //只有分类档案管理员
        
        if(detailPage == "filefilesdetail4pic.jsp"
            ||detailPage == "filefilesdetail4disk.jsp"){
        	jQuery("#printFileDetailButton").show();
        	jQuery("#printFileBackButton").show();
        }
        //光盘档案才答应总说明
        if(detailPage == "filefilesdetail4disk.jsp"){
        	 jQuery("#printFileContentButton").show();        	
        }
        //归档按钮只有在未归档时才有效
        if(f_files_state == "0"||isFileManager||isFileTypeManager){
        	jQuery("#saveButton").show();
        	if(isFileManager||isFileTypeManager){
                jQuery("#archiveButton").show();
            }
        }
        jQuery("#createFilenoButton").show(); 
        if(listPage){       
          jQuery("#printNoteButton").show();
        }

        jQuery("#newButton").show();
        
    }
	
	/**
	 *添加事件
	 */
	function addAction(){
		 //归档按钮点击事件
        jQuery("#archiveButton").click(function(){
            if(!isFileManager&&!isFileTypeManager){
              alert("权限不够，请联系管理员");
              return;
            }
            if(jQuery("#frame1")[0].contentWindow.archive){
                jQuery("#frame1")[0].contentWindow.archive();
             }
        });
		
		 //保存按钮点击事件
	     jQuery("#saveButton").click(function(){
             if(jQuery("#frame1")[0].contentWindow.save){
                 jQuery("#frame1")[0].contentWindow.save();
              }
		 });
		 //自动生成档号
	     jQuery("#createFilenoButton").click(function(){
             if(jQuery("#frame1")[0].contentWindow.createFileno){
                 jQuery("#frame1")[0].contentWindow.createFileno();
              }
         });

         //打印卷内说明         
         jQuery("#printFileDetailButton").click(function(){
             if(jQuery("#frame1")[0].contentWindow.printFileDetail){
                 jQuery("#frame1")[0].contentWindow.printFileDetail();
              }
          });

         //打印卷内说明         
         jQuery("#printNoteButton").click(function(){             
             if(jQuery("#frame3")[0].contentWindow.printNote){
            	 jQuery("#frame3")[0].contentWindow.printNote();
              }
          });
         //打印背脊标签
         jQuery("#printFileBackButton").click(function(){
             if(jQuery("#frame1")[0].contentWindow.printFileBack){
                jQuery("#frame1")[0].contentWindow.printFileBack();
             }
          });
          //打印档案总说明
         jQuery("#printFileContentButton").click(function(){
             if(jQuery("#frame1")[0].contentWindow.printFileContent){
                jQuery("#frame1")[0].contentWindow.printFileContent();
             }
          });
         //新增按钮
         jQuery("#newButton").click(function(){
             addNewFile();
         });
         
		 //返回按钮点击事件
	     jQuery("#closeButton").click(function(){
	    	closed();            
         });

         
	}

   
	/**
	 * 关闭弹出框
	 */
	function closed(){
		var flag = 0;
	    if(flag == 0){
	    //新增或修改数据，提示是否保存
	        var okF = function(){
	        	parentSearch();
	        	removeAlertWindows(windowId,true);
	        }
	        var p={
	            headerText:'提示', 
	            okName:'确认',
	            okFunction:okF,
	            cancelName:'取消'
	        };
	        alert('返回该页,未保存的信息将会丢失 '+'<br>'+'确定返回？',p);
	    }else{
	    	removeAlertWindows(windowId,true);
	    }
	}

	/**
	 *获取入档操作需要的参数
	 */	 
	function getUrl4addDoc(){
		var  urlArray = new Array();
		    urlArray.push("&f_type_name=" + descape(escape(jQuery("input[id$=__F_TYPE_NAME]",jQuery("#frame1")[0].contentWindow.document).val())));
		    urlArray.push("&f_type_id=" + jQuery("input[id$=__F_TYPE_ID]",jQuery("#frame1")[0].contentWindow.document).val());

		    //文件界面需要的档案类型参数,只是大小写不一样 
            urlArray.push("&F_TYPE_ID="+ jQuery("input[id$=__F_TYPE_ID]",jQuery("#frame1")[0].contentWindow.document).val());
            urlArray.push("&F_TYPE_NAME=" + descape(escape(jQuery("input[id$=__F_TYPE_NAME]",jQuery("#frame1")[0].contentWindow.document).val())));

            urlArray.push("&f_dept_name="+descape(escape(jQuery("input[id$=__F_DEPT_NAME]",jQuery("#frame1")[0].contentWindow.document).val())));
            urlArray.push("&f_dept_id="+descape(escape(jQuery("input[id$=__F_DEPT_ID]",jQuery("#frame1")[0].contentWindow.document).val())));
 		    urlArray.push("&f_doc_year="+jQuery("input[id$=__F_DOC_YEAR]",jQuery("#frame1")[0].contentWindow.document).val());
		    urlArray.push("&f_doc_deadline_name="+descape(escape(jQuery("select[id$=F_DOC_DEADLINE] option:selected",jQuery("#frame1")[0].contentWindow.document).text())));
		    urlArray.push("&f_doc_deadline="+jQuery("select[id$=F_DOC_DEADLINE]",jQuery("#frame1")[0].contentWindow.document).val());
		    urlArray.push("&f_files_id="+id);
		return urlArray.join("");
	}

/**
 * 执行父窗口查询参数
 */
	function parentSearch(){
		try{
			var parentWin = getParentWindow(windowId);
			if(parentWin&&parentWin.search){
				parentWin.search();
			}
		}catch(e){
          /**忽略异常信息**/
		}
	}
//是否点击了新增按钮(用于控制会计档案的初始化数据)
var isAddNewFile = false;
var childFormData = null;
/**
 * 新增
 */
 function addNewFile(){	 
	 if(jQuery("#frame1")[0].contentWindow.addNewFile){
		 id = new UUID().toString();//生成新的档案id
		 action = "add";//添加操作
		 f_files_state = "0";//归档状态设置为待归档
		 //重置卷内文件路径，隐藏卷内文件按钮
		 jQuery("#tabs-2").hide();
		 jQuery("#tabTitle2_div").hide();
		 jQuery("#frame2").attr("src","");
		 //重置备考表路径
		 jQuery("#frame3").attr("src","filenotedetail.jsp?id="+id+"&f_type_id=<%=f_type_id %>");

		 //重新设置按钮的显示与隐藏
		 jQuery("#_top button[id!=closeButton]").hide();
		 showButton();
         //案卷号自增1
         jQuery.ajax({
           type: "post", 
           url: path+"/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=queryMaxFileNo",  
           contentType: "application/x-www-form-urlencoded; charset=utf-8",
           data : {
               "bean.f_type_id" : f_type_id,
               "bean.f_org_id" : "<%=unitId%>"
           },
           dataType: "json",
           success: function (data) { 
             try{   
                 if(data && data.flag){
                    jQuery("#frame1")[0].contentWindow.addNewFile(id,data.f_filesno);
                 }else{
                    jQuery("#frame1")[0].contentWindow.addNewFile(id,"");
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
}	

</script>
<title></title>
</head>
<body >
   <div class="content_02" style="overflow: hidden;" id="_top">
        <div class="content_02_top" style="margin-bottom: 10px;">      
            <input name="archiveButton" id="archiveButton" value="归档" style="display: none"
                type="button" class="but_y_01" />       
            <input name="saveButton" id="saveButton" value="保存" style="display: none"
                type="button" class="but_y_01" /> 
            <input name="newButton" id="newButton" value="新增" style="display: none"
                type="button" class="but_y_01" />     
            <input name="createFilenoButton" id="createFilenoButton" value="生成档号" style="display: none"
                type="button" class="but_y_01" />
            <input name="printFileDetailButton" id="printFileDetailButton" value="打印卷内说明" style="width:105px;display: none"
                type="button" class="but_y_03" />
            <input name="printNoteButton" id="printNoteButton" value="打印备考表" style="width:105px;display: none"
                type="button" class="but_y_03" />
            <input name="printFileBackButton" id="printFileBackButton" value="打印背脊标签" style="width:105px;display: none"
                type="button" class="but_y_03" />
            <input name="printFileContentButton" id="printFileContentButton" value="打印档案总说明" style="width:105px;display: none"
                type="button" class="but_y_03" />    
                
            <input name="closeButton" id="closeButton"  value="返回" type="button" class="but_y_01" />
        </div>
	<%if("tijiaoJSP".equals(request.getParameter("openPage"))){%>
		<div style="<%if(!"1".equals(request.getParameter("f_flow_state"))){%>display:none<%}%>;color:red;float:left; margin-left:10px; margin-top:10px;  border-bottom:none; border-right:none;width: 990px;">
			 退回原因：<span id="OA_FILE_FILES__F_ROLLBACK_IDEA"></span>
		</div>
	<%}%>
    <table style="WIDTH: 100%;">
        <tr>
            <td>
                <div>
                    <div id="tabs">
                        <div id="_top_tabs" style="display:none;">
                            <ul>
                                <li id="tabTitle1_div"><a id="tabTitle1" href="#tabs-1">案卷信息</a></li>
                                <li id="tabTitle2_div" style="display:none;"><a id="tabTitle2" href="#tabs-2">&nbsp;</a></li>
                                <li id="tabTitle3_div" style="display:none;"><a id="tabTitle3" href="#tabs-3">备考表</a></li>
                            </ul>
                            <div id="tabs-1">
						         <iframe src="" 
						                 id="frame1" frameborder="0" width="100%"></iframe>
						    </div>
						    <div id="tabs-2" style="display:none;">
						           <iframe src="" id="frame2" frameborder="0"
						                                width="100%"></iframe>
						    </div>
						    <div id="tabs-3" style="display:none;">
						          <iframe src="filenotedetail.jsp?id=<%=busi_id %>&f_type_id=<%=f_type_id %>&isview=<%=isview%>" id="frame3" frameborder="0"
						                                width="100%"></iframe>
						    </div>
                        </div>                       
                    </div>
                </div>
            </td>
        </tr>
    </table>
    </div>
    
    
    </body>
</html>