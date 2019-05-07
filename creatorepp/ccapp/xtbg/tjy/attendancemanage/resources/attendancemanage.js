/*
函数:  queryHolidayTimes
说明:  查询节假日期
参数:   无
返回值: 无
*/
function queryHolidayTimes(days,start_time,end_time){
	var url= path + "/ccapp/xtbg/tjy/attendancemanage/jsp/ajaxholidaytimes.jsp";
	var params =  {start_time:start_time,end_time:end_time};
	jQuery.ajax({
		url: url,
		type: 'POST',
		dataType:'json',
		data: params,
		async:false,
		success: function(data){
			jQuery("#TA_OA_ATTENDANCELEAVE__T_LEAVETIMES").val(days-data.counts);
		},
		error: function(jqXHR, textStatus, errorThrown){
			
		}
	})
}