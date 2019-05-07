$(function(){
	for(var i=0;i<boxlist.length;i++) {
		$("#"+boxlist[i]).attr("checked","checked");
	}
})


function save(){
	var boxvalue="";
	$("#save").attr("disabled")
    //var checkedbox=$(":checked");
    /**拼装结构为      资源id@用户id,用户id-资源id@用户id,用户id    类似于     25@330,374-37@331,369-38@334,344-46@340,343   **/
    for(var i = 0; i < resourceIdList.length ; i ++){
        var checkedbox = $("input[name="+resourceIdList[i]+"]:checked");
        boxvalue += resourceIdList[i]+"@";
        for(var j = 0; j < checkedbox.length; j ++){
        	boxvalue += checkedbox.eq(j).val();
        	if(j!=checkedbox.length-1){
            	boxvalue+=",";
        	}
        }
        if(i!=resourceIdList.length-1){
    		boxvalue+="-";
    	} 
    }
    
  //保存
	var span = {
		data : "{'boxvalue':'" + boxvalue + "','orgId':'" + orgId + "'}",
		classID : 'orgresource',
		method : 'insertResourceConfigBatch'
	}
	$.post(window.top.getContextPath() + "/tree", span, function() {
		// 通一异常处理
		var p = {
			headerText : '提示',
			okName : '确认',
			okFunction : saveOk
		};
		alert("保存成功!", p);
	}, "script");
}
function saveOk(){
	$("#save").removeAttr("disabled");
}
function deleteOk(){
	location.href = location.href;
}

function clearAll(){
	
	//清除
	var span = {
		data : "{'resource_ids':'"+resourceIdList+"','orgId':'"+orgId+"'}",
		classID : 'orgresource',
		method : 'delResourceConfig'
	}
	$.post(window.top.getContextPath() + "/tree", span, function() {
		// 通一异常处理
		var p={
				headerText:'提示',
				okName:'确认',
		        okFunction:deleteOk
		      };
			 alert("清除成功!",p);
	}, "script");
}

var isManager = false;
$successful.initsucessful = function(response){
	isManager = response.result.isManager;
	if("false" == isManager){
		$(".user_oper").hide();
	}
}