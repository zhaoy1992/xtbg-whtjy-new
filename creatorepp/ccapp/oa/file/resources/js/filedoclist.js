/**
 * 支持各个档案文件查询页面
 */
var filedoclist={};
/**
 * 支持各个档案文件查询页面
 * 复制文件(案卷之外) like filedoclist4file.js
 * 页面必须存在 updateFileDocDetail
 */
filedoclist.copyDoc=function(){
	 var ids = "";
     var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
     var ids = new Array();
     var total = selectedIds.length;
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
     
     jQuery.ajax({
         type: "post", 
         url: getContextPath()+'/ccapp/oa/file/jsp/filedoclistdo.jsp',  
         contentType: "application/x-www-form-urlencoded; charset=utf-8",
         data : {
         	action:"filedoclist.copyDoc",
            f_doc_id : ids[0],
         },
         dataType: "text", 
         success: function (data) {
             if(data){
                 search();
                 var p={
                         headerText:'提示',
                         okName:'确认',
                         okFunction:function(){
                	     	updateFileDocDetail(data);
          	             },
                         cancelName:'取消'
                 };
                 alert("操作成功,是否马上进行编辑！",p);
             }
         }, 
         error: function (XMLHttpRequest, textStatus, errorThrown) { 
             alert("系统异常，请稍后再试！");
         }
	});
};


filedoclist.copyDocPhotoMess=function(){
	//try{
	 var ids = "";
     var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
     var ids = new Array();
     var total = selectedIds.length;
     jQuery(selectedIds).each(function () {
         var model = jQuery("#gridTable").jqGrid('getRowData', this);         
         ids.push(model.f_id);
     });
     if (ids.length==0) {
         alert("请先选中一条记录！");
         return;
     }
     if(ids.length >1){
    	 alert("每次只能复制一条记录!");
         return;
     }
     
     jQuery.ajax({
         type: "post", 
         url: getContextPath()+'/ccapp/oa/file/jsp/filedoclistdo.jsp',  
         contentType: "application/x-www-form-urlencoded; charset=utf-8",
         data : {
         	action:"filedoclist.copyDocPhotoMess",
            f_id : ids[0],
         },
         dataType: "text", 
         success: function (data) {
             if(data){
                 searchData();
                 var p={
                         headerText:'提示',
                         okName:'确认',
                         okFunction:function(){
                	     	updateDocPhotoMess(data);
          	             },
                         cancelName:'取消'
                 };
                 alert("操作成功,是否马上进行编辑！",p);
             }
         }, 
         error: function (XMLHttpRequest, textStatus, errorThrown) { 
             alert("系统异常，请稍后再试！");
         }
	});
	//}catch(e){alert(e.description)}
};