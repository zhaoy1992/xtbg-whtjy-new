<%--
describe:督察督办立项列表管理页面
author:dailianchun
date: 2013-10-29
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% String path = request.getContextPath(); %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>督察督办立项列表管理页面</title>
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
var path = "<%=path%>";
    $(function() { 

        adaptationWH('','frame1',40);
        adaptationWH('','frame2',40);
        adaptationWH('','frame3',40);
        adaptationWH('','frame4',40);
        adaptationWH('','frame5',40);
        
        $("#tabs").tabs({
            border:true,  
            select : function(event, ui) {   
        	    if("全部" == jQuery(ui.tab).text()){
        	    	 //如果页面未加载，则加载页面
                   if(jQuery("#frame1").attr("src")){
                	   jQuery("#frame1")[0].contentWindow.search();
                   }  
            	}else if("草稿" == jQuery(ui.tab).text()){
                    //如果页面未加载，则加载页面
                   if(!jQuery("#frame2").attr("src")){
                      jQuery("#frame2").attr("src",path+"/ccapp/oa/inspect/jsp/inspectlist4manage.jsp?state=0");
                   }else{
                	   jQuery("#frame2")[0].contentWindow.search();
                   }
                }else if("办理中" == jQuery(ui.tab).text()){
                	 //如果页面未加载，则加载页面
                    if(!jQuery("#frame3").attr("src")){
                       jQuery("#frame3").attr("src",path+"/ccapp/oa/inspect/jsp/inspectlist4manage.jsp?state=1");
                    }else{
                        jQuery("#frame3")[0].contentWindow.search();
                    }
                }else if("已完成" == jQuery(ui.tab).text()){
                	 //如果页面未加载，则加载页面
                    if(!jQuery("#frame4").attr("src")){
                       jQuery("#frame4").attr("src",path+"/ccapp/oa/inspect/jsp/inspectlist4manage.jsp?state=2");
                    }else{
                        jQuery("#frame4")[0].contentWindow.search();
                    }
                }else if("未完成" == jQuery(ui.tab).text()){
                	 //如果页面未加载，则加载页面
                    if(!jQuery("#frame5").attr("src")){
                       jQuery("#frame5").attr("src",path+"/ccapp/oa/inspect/jsp/inspectlist4manage.jsp?state=3");
                    }else{
                        jQuery("#frame5")[0].contentWindow.search();
                    }
                }
            }
        });
        //tab加载完成，再显示页面
        jQuery("#_top_tabs").show();
        jQuery("#frame1").attr("src",path+"/ccapp/oa/inspect/jsp/inspectlist4manage.jsp");
    });


    function search(){
        var tabs = jQuery("#tabs").tabs("getSelected");
    }
       

</script>
<title></title>
</head>
<body >
   
    <table style="WIDTH: 100%;">
        <tr>
            <td>
                <div>
                    <div id="tabs">
                        <div id="_top_tabs" style="display:none;">
                            <ul>
                                <li id="tabTitle1_div"><a id="tabTitle1" href="#tabs-1">全部</a></li>
                                <li id="tabTitle2_div"><a id="tabTitle2" href="#tabs-2">草稿</a></li>
                                <li id="tabTitle3_div"><a id="tabTitle3" href="#tabs-3">办理中</a></li>
                                <li id="tabTitle4_div"><a id="tabTitle4" href="#tabs-4">已完成</a></li>
                                <li id="tabTitle5_div"><a id="tabTitle5" href="#tabs-5">未完成</a></li>
                            </ul>
                            <div id="tabs-1">
                                 <iframe src="" 
                                         id="frame1" frameborder="0" width="100%"></iframe>
                            </div>
                            <div id="tabs-2">
                                   <iframe src="" id="frame2" frameborder="0"
                                                        width="100%"></iframe>
                            </div>
                            <div id="tabs-3">
                                  <iframe src="" id="frame3" frameborder="0"
                                                        width="100%"></iframe>
                            </div>
                            <div id="tabs-4">
                                  <iframe src="" id="frame4" frameborder="0"
                                                        width="100%"></iframe>
                            </div>
                            <div id="tabs-5">
                                  <iframe src="" id="frame5" frameborder="0"
                                                        width="100%"></iframe>
                            </div>
                        </div>                       
                    </div>
                </div>
            </td>
        </tr>
    </table>   
    </body>
</html>