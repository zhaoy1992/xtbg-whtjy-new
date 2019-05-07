$(function(){
	for(var i=0;i<boxlist.length;i++) {
		$("#"+boxlist[i]).attr("checked","checked");
	}
})

function save(){
	var boxvalue="";
	$("#save").attr("disabled")
    /**拼装结构为      资源id@用户id,用户id-资源id@用户id,用户id    类似于     25@330,374-37@331,369-38@334,344-46@340,343   **/
    for(var i = 0; i < resourceIdList.length; i ++){
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
	  var params="orgId="+ orgId+"&boxvalue=" + boxvalue+"&oprtype=save";
		jQuery.ajax({
            url: 'orgresonconfigdo.jsp',
			type: 'POST',
			data: params,
            dataType: "json",
            success: function (data) {
              alert(data.msg);
            }, 
            error: function (XMLHttpRequest, textStatus, errorThrown) { 
                alert("出现异常，请稍后再试！"+ XMLHttpRequest + textStatus + errorThrown);
            }
         });

}
function saveOk(){
	$("#save").removeAttr("disabled");
}
function deleteOk(){
	location.href = location.href;
}

function clearAll(){
	
	var params="orgId="+ orgId+"&oprtype=delall";
	jQuery.ajax({
        url: 'orgresonconfigdo.jsp',
		type: 'POST',
		data: params,
        dataType: "json",
        success: function (data) {
          alert(data.msg);
          location.href = location.href;
        }, 
        error: function (XMLHttpRequest, textStatus, errorThrown) { 
            alert("出现异常，请稍后再试！"+ XMLHttpRequest + textStatus + errorThrown);
        }
     });
}

