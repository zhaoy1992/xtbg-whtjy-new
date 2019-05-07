/**
 *卷内文件公用js
 */
function copyDoc(fId){
	 var ids = "";
     var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
     var ids = new Array();
     var total = selectedIds.length;//总共选中的记录数       
     $(selectedIds).each(function () {
         var model = jQuery("#gridTable").jqGrid('getRowData', this);         
         ids.push(model.f_doc_id);               
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
         url: path+'/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=copyDoc',  
         contentType: "application/x-www-form-urlencoded; charset=utf-8",
         data : {                      
             f_doc_id : ids[0], //要更新的id
             f_files_id : fId
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
                    	       updateFileDocDetail(data.bean.f_doc_id);
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

jQuery(function(){
	if(jQuery("#copyDoc").length>0){
		jQuery("#copyDoc").click(function(){
			copyDoc(fileId);			
		});
	}	
});

var filedoclist4fileJS = {};
filedoclist4fileJS.orderList = function(orderConfig){
	if(typeof(orderConfig)!='undefined'){
		var url = orderConfig.orderPageName;
		var windowId = orderConfig.orderPageId;
		openAlertWindows(windowId,url,'排序界面',500,500,'5%','10%');
		
	}
};