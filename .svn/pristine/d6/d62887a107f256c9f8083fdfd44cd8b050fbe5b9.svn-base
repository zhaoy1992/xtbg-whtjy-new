
/*
       函数:  del
      说明:  删除
      参数:  无
      返回值: 无
*/
var updateState = function() {
       var ids = "";
       var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
       var ids = new Array();
       var total = selectedIds.length;//总共选中的记录数       
       $(selectedIds).each(function () {
           var model = jQuery("#gridTable").jqGrid('getRowData', this);
           //待归档状态的，才进行归档
           if(model.f_files_state == "0"){
               //单位管理员，或分类档案管理员才能归档
              if(isManager||(model.istypemanager1=="1" && model.istypemanager2=="1" )){                   
                   ids.push(model.f_files_id);  
               }
           }
           
       });
           
       if (!ids.length) {
           alert("选中<span style='color:red;font-weight:bold'>"
                   +total+"</span>条,可归档<span style='color:red;font-weight:bold'>"
                   +ids.length+"</span>条，<br/>成功归档<span style='color:red;font-weight:bold'>"
                   +ids.length+"</span>条记录");
       } else {
               //ajax方式提交数据
               jQuery.ajax({ 
                   type: "post", 
                   url: path+'/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=updateFilesState',  
                   contentType: "application/x-www-form-urlencoded; charset=utf-8",
                   data : {                      
                       ids : ids.join(",") //要更新的id列表      
                   },
                   dataType: "json", 
                   success: function (data) {
                       if(data){                          
                           //如果删除成功，刷新数据
                           if(data.flag){
                        	   alert("选中<span style='color:red;font-weight:bold'>"
                                       +total+"</span>条,可归档<span style='color:red;font-weight:bold'>"
                                       +ids.length+"</span>条，<br/>成功归档<span style='color:red;font-weight:bold'>"
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
   }
/**
 * 复制文件
 * @return
 */
var copyFile = function (){
	 var ids = "";
     var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
     var ids = new Array();
     var total = selectedIds.length;//总共选中的记录数       
     $(selectedIds).each(function () {
         var model = jQuery("#gridTable").jqGrid('getRowData', this);
         //待归档状态的，才进行归档
         ids.push(model.f_files_id);               
     });
     if (ids.length==0) {
         alert("请先选中一条记录！");
         return;
     }
     if(ids.length >1){
    	 alert("每次只能复制一条记录!");
         return;
     }
   //ajax方式提交数据
     jQuery.ajax({ 
         type: "post", 
         url: path+'/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=copyFile',  
         contentType: "application/x-www-form-urlencoded; charset=utf-8",
         data : {                      
             f_files_id : ids[0] //要更新的id
         },
         dataType: "json", 
         success: function (data) {
             if(data){                          
                 //如果删除成功，刷新数据
                 if(data.flag){              	     
                     search();
                     var p={
                             headerText:'提示',
                             okName:'确认',
                             okFunction:function(){
              		           update(data.bean.f_files_id,data.bean.f_files_state,
              				     data.bean.f_type_id,data.bean.f_type_name);
              	           },
                             cancelName:'取消'
                     };
                     alert(data.msg,p); 
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

var filefileslistJS = {};
//打开排序界面,依据父页面上的参数做事orderConfig
filefileslistJS.orderList = function(orderConfig){
	if(typeof(orderConfig)!='undefined'){
		var url = orderConfig.orderPageName;
		var windowId = orderConfig.orderPageId;
		openAlertWindows(windowId,url,'排序界面',500,500,'5%','10%');
		
	}
};