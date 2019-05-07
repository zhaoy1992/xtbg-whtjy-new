/***
 *档案添加界面，处理的js
 *@author 戴连春
 *@date 2013-08-13
 */


/**
 * 生成档号
 */
function createFileno(){
	debugger;
   // 访问action的方法
  var method = "createFileno";
  var backFunction = updateBack;
  if("add" == action){
      method = "createFileno4Add";
      backFunction = addBack;
  }
 
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
      success: backFunction, 
      error: function (XMLHttpRequest, textStatus, errorThrown) {          
          alert("出现异常，请稍后再试！");
      }
   });
}
function createFilenoAuto(){
   // 访问action的方法
  var method = "createFileno";
  var backFunction = updateBack;
 
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
      success: function(){}, 
      error: function (XMLHttpRequest, textStatus, errorThrown) {          
          alert("出现异常，请稍后再试！");
      }
   });
}
/**
 * 更新操作时，生成档号的回调函数
 * 
 * @param data
 * @return
 */
function updateBack(data){
        if(data&&data.msg){
           alert(data.msg);
        }
        if(data&&data.flag){
          // 档号输入框赋值
            jQuery("input[id$=__F_FILES_NO]").val(data.value);
        }
}
/**
 * 新增操作时生成档号的回调函数
 * 
 * @param data
 * @return
 */
function addBack(data){
    if(!data.flag){
       alert(data.msg);
       return;
    }
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
}

/**
 * 获得档案正文模板
 */
function getContentTemp(){
	 // ajax方式提交数据
	  jQuery.ajax({
	      type: "post", 
	      url: path+"/ajaxServlet?className=com.chinacreator.xtbg.core.file.action.FileFilesAction&method=getContentTemp", 
	      contentType: "application/x-www-form-urlencoded; charset=utf-8",
	      data : {
	           "f_type_id" : f_type_id// 档案类型id
	      },
	      dataType: "json",
	      success: function(data){
	    	  if(data&&data.msg){
	    		 alert(data.msg);  
	    	  }	    	  
	    	  if(data && data.flag){
	    		  jQuery("#OA_FILE_FILES__F_FILES_CONTENT").val(data.value);	    		  
	    	  }
	      }, 
	      error: function (XMLHttpRequest, textStatus, errorThrown) {          
	          alert("出现异常，请稍后再试！");
	      }
	   });
	
}
/*
 * 函数: chooseOrg 说明: 选择部门 参数： name 赋值框的id treetypestr 单选框或者多选框
 */
var chooseOrg = function (id,name,treetypestr){
    var s = new jQuery.z_tree();
    s.treeID = 'mainUser';
    s.treetypestr = treetypestr;
    s.isShowSeacher = true;
    s.treeName = "选择部门";
    s.headerName = "选择部门";
    s.isType="dept"; // 要设置默认选中值，则需要此类型
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
         /** 忽略客户端异常信息* */ 
       }
    }
    s.init();
}
/**
 * 
 * @param cookieName
 *            cookie名
 * @param data
 *            表单数据
 * @param days
 *            cookie有效天数
 * @return
 */
//function setFileCookie(cookieName,data,days){
//	try{
//		var jsonStr = new Array("{");
//	    for(var i=0;i<data.length;i++){	
//	       //如果是表单的内容，则保存
//	       if(data[i].name.indexof("OA_FILE_FILES")!=-1||data[i].name.indexof("OA_FILE_FILES_ACC")!=-1)	
//		   if(i!=data.length-1){
//			   jsonStr.push('"'+data[i].name+'":"' + escape(data[i].value)+'",');
//            }else{
//               jsonStr.push('"'+data[i].name+'":"' + escape(data[i].value)+'"');   	       
//            }
//	    }
//	    jsonStr.push("}");
//	    setCookie(cookieName,jsonStr.join(""),"","",days);
//	}catch(e){
//		/** 忽略异常* */
//	}
//}
// 默认的不需要从缓存读取的字段
//var unreadCookie = ["OA_FILE_FILES__F_FILES_ID",
//                    "OA_FILE_FILES__F_FILES_STATE_NAME",
//                    "OA_FILE_FILES__F_FILES_STATE",
//                    "busiTypeCode",
//                    "busi_id",
//                    "action",
//                    "datelist",                            
//                    "OA_FILE_FILES__F_FILE_USERNAME",
//                    "OA_FILE_FILES__F_FILE_USERID",
//                    "dis_OA_FILE_FILES__F_FILE_TIME",
//                    "OA_FILE_FILES__F_FILE_TIME",
//                    "OA_FILE_FILES__F_TYPE_NAME",
//                    "OA_FILE_FILES__F_TYPE_ID",
//                    "OA_FILE_FILES__F_TYPENO",
//                    "OA_FILE_FILES__F_ORG_NAME",
//                    "OA_FILE_FILES__F_ORG_ID"
//                    ];
//
//
///**
// * 从缓存读取数据，并赋值
// * 
// * @param cookieName
// * @param unreadArray
// * @return
// */
//function readFromCookie(cookieName,unreadCookie){
//	try{
//	   debugger
//       var strCookie = getCookie(cookieName);
//       
//       var jsonCookie = jQuery.parseJSON(strCookie);
//       // 根据cookie赋初值
//       for(var name in jsonCookie){
//    	   var setFlag = true;
//    	   // 判断是否需要从缓存读取初始值
//    	   for(var i=0;i<unreadCookie.length;i++){
//    		   if(unreadCookie[i] == name){
//    			   setFlag = false;
//    			   continue;
//    		   }
//    	   }
//    	   if(setFlag){
//    		   // 选择框则设置选项选中
//    		   jQuery("#"+name+" option[value="+unescape(jsonCookie[name])+"]").attr("selected","selected");
//    		   jQuery("#"+name).val(unescape(jsonCookie[name]));       		      		   
//    	   }
//       }
//	}catch(e){
//	  /** 忽略异常* */	
//	}
//}

/**
 * 新增，在不关闭窗口的情况下，增加一个新的档案
 * @param newId
 * @return
 */
function addNewFile(newId,f_filesno){
       //重置业务id
       id = newId;
       action = "add";
       jQuery("#busi_id").val(newId);
       jQuery("#action").val("add");

       //案卷状态设置为待归档
       jQuery("#OA_FILE_FILES__F_FILES_STATE").val("");
       jQuery("#OA_FILE_FILES__F_FILES_STATE_NAME").val("");
       //重置盒号
       jQuery("#OA_FILE_FILES__F_FILESNO").val(f_filesno);
       //重置归档人
       jQuery("#OA_FILE_FILES__F_FILE_USERNAME").val(userName);
       jQuery("#OA_FILE_FILES__F_FILE_USERID").val(userId);
       //归档状态显示“待归档”
       jQuery("#guidang_state").text("待归档");
}

jQuery(function(){
  if(jQuery('#f_dept_name_button').length>0){
    jQuery('#f_dept_name_button').click(function(){
       chooseOrg('OA_FILE_FILES__F_DEPT_ID','OA_FILE_FILES__F_DEPT_NAME','radio');
    });    
    }
  if(jQuery("#guidang_state").length>0){
    jQuery("#guidang_state").text(IsSpace(jQuery("#OA_FILE_FILES__F_FILES_STATE_NAME").val())? "待归档" : jQuery("#OA_FILE_FILES__F_FILES_STATE_NAME").val() );
  }
});



