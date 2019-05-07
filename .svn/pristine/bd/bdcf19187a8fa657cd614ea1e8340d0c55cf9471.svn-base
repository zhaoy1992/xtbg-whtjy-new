/**
 *调卷功能代码
 *@author 戴连春
 *@date 2013-08-22
 *
 */

  /**
   *change选择框
   */
  function changeSelect(selectId,divId){
      //没有案卷记录，则不能调卷
      if(!jQuery(selectId).val()){
        jQuery(divId).html("");
        return;
      }     
      jQuery(selectId).attr("title",jQuery(selectId+" option:selected").text());
      var data = { 
              filesId :jQuery(selectId).val(),
              rows : "1000",
              //表示请求行数的参数名称  
              sidx : "f_doc_num",
              //表示用于排序的列名的参数名称  
              sord :"asc",
              page : "1"
      };
      searchDoc(data,divId);
  }
  /*
        函数:  toUserParamJosn
        说明:  构建要查询的参数
        参数:   无
        返回值: 返回要查询的参数
   */
    var toUserParamJosn = function() {
         var param = {
             "bean.f_type_id": f_type_id,//类型信息
             "bean.f_doc_year":jQuery("#f_doc_year").val(),
             "bean.f_doc_deadline":jQuery("#f_doc_deadline").val(),   
             "bean.f_dept_name" : jQuery("#f_dept_name").val(),
             "bean.f_org_id" : unitId,//单位id
             "page.page":"1",//由于沿用的列表查询数据的方法，故需传入分页数据
             "page.rows" : "10",
             "page.sortName":"f_filesno",//按案卷号升序排列
             "page.sortOrder":"asc"
         };  
        //转码
        for(var name in param ){
            param[name] = descape(escape(param[name]));
        }                
        return param;
    }

   /**
    *查询卷内文件
    */ 
   function searchDoc(data,divId){
       var url = path+'/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FileDocListForFiles';
      
       var backFn = function(backData){
           if(backData && backData.rows){
               addTr(backData.rows,divId);
           }     
       };
       publicAjax(url,data,backFn);
   } 
   /**
    *查询数据
    */
   function search(){
       var url = path+'/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=queryFilesList';
       var data = toUserParamJosn();
       var backFn = function(data){   
           var rows = data.rows;
           if(rows){
               addOption("#from",rows);
               addOption("#to",rows);
               //触发onchange事件
               jQuery("#from").trigger("change");
           }
           
       };
       publicAjax(url,data,backFn);
   }

   /**
    *给select添加option
    */
   function addOption(id,rows){
      //首先清空select框
      jQuery(id).html("").attr("title","");
      for(var i=0;i<rows.length;i++){
          if(i==0){
              jQuery(id).attr("title",rows[i].f_files_no);  
          }
         jQuery("<option title='"
                 +rows[i].f_files_no+"' value='"+rows[i].f_files_id +"'"+
                 +" f_doc_year ='"+rows[i].f_doc_year+"'"
                 +" f_dept_id ='"+rows[i].f_dept_id+"'"
                 +" f_doc_deadline ='"+rows[i].f_doc_deadline+"'"
                 +">"+rows[i].f_files_no+"</option> ").appendTo(id);
      }
   }

   /**
    *添加行数据 
    */
   function addTr(rows,divId){
       jQuery(divId).html("");//清空数据
       //添加数据
       var htmlArray = new Array();
       for(var i=0;i<rows.length;i++){
          htmlArray.push("<div id='"+divId.substring(1,divId.length-1)+i+"' class='unselected' onClick ='onDivClick(this)'");
          htmlArray.push(" onMouseOver='onMouseOver(this)'");
          htmlArray.push(" onMouseOut='onMouseOut(this)'");
          htmlArray.push(" ondblclick='moveOne(this.id,\""+divId+"\")'"); 
          htmlArray.push(" f_doc_id='"+rows[i].f_doc_id+"'");
          htmlArray.push(" parent_div='"+divId+"'");
          htmlArray.push("><div style='width:10%;float:left;line-height:23px;'");
          htmlArray.push(" title='"+rows[i].f_doc_num+"'>");
          htmlArray.push(rows[i].f_doc_num);
          htmlArray.push("</div><div style='width:90%;float:left;line-height:23px;'");
          htmlArray.push(" title='"+rows[i].f_doc_name+"'>");
          htmlArray.push(rows[i].f_doc_name);
          htmlArray.push("</div></div>");
       }    
       jQuery(divId).html(htmlArray.join(""));
   }

   /**
    *移动
    */
   function move(fromDiv,toDiv){
	   if(isMoveAble()){
         var moves = jQuery(fromDiv).find(".selected").appendTo(toDiv);
	   }
   }

   /**
    *移动单个的记录
    */
   function moveOne(id){
	   var moveToDiv = "#toDiv";
	   var parentId = jQuery("#"+id).parent().attr("id");
	   if(parentId=="toDiv"){
		   moveToDiv = "#fromDiv";
	   }
	   if(isMoveAble()){
	      jQuery("#"+id).attr("class","selected").appendTo(moveToDiv);
	   }
   }

   /**
    *判断是否能够调卷
    */
   function isMoveAble(){
      var from = jQuery("#from");
      var to = jQuery("#to");
      if(from.val() == to.val()){
         alert("选中的为同一个案卷，不能进行调卷");
         return false;
      }
      if(from.attr("f_doc_year") != to.attr("f_doc_year")){
         alert("【档案年份】不同，不能进行调卷");
         return false;
      }
      if(from.attr("f_dept_id") != to.attr("f_dept_id")){
          alert("【所属部门】不同，不能进行调卷");
          return false;
      }
      if(from.attr("f_doc_deadline") != to.attr("f_doc_deadline")){
          alert("【保管期限】不同，不能进行调卷"); 
          return false;
      }
      return true;
      
   }
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
	   jQuery("#fromDiv>div").each(function(){
		   idsArray.push(jQuery(this).attr("f_doc_id"));
        });

	   var f_files_id_to = jQuery("#to").val();
	   var idsArrayTo = new Array();
       jQuery("#toDiv>div").each(function(){
    	   idsArrayTo.push(jQuery(this).attr("f_doc_id"));
        });
     var data={
          ids : idsArray.join(","),
          f_files_id : f_files_id_from,
          ids_to : idsArrayTo.join(","),
          f_files_id_to : f_files_id_to
     };
     var backFn = function(data){
         if(data&&data.msg){
           alert(data.msg);
          }
         if(data.flag){
        	 jQuery("#from").trigger("change");
         }
     };
     var url = path+"/ajaxServlet?className="
     +"com.chinacreator.xtbg.core.file.action.FileFilesAction&method=fitFiles";
     publicAjax(url,data,backFn);     
   }
   
  /**
   *公用的ajax提交方法
   */
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