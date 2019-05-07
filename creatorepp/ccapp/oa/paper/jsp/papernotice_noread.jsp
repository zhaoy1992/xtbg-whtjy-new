<%--
　　描述：查阅情况——未阅读 
　　作者：肖杰
　　版本：1.0
　　日期：2013-09-12
--%>
<%@page import="com.chinacreator.xtbg.core.paper.service.impl.PaperMakeNoticeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.paper.service.PaperMakeNoticeService"%>
<%@page import="com.chinacreator.xtbg.core.paper.util.PaperConstants"%>
<%@page import="com.chinacreator.xtbg.core.sysparam.util.SysParamUitl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    String k_create_user = controler.getUserID();
    String p_notice_id=request.getParameter("p_notice_id");
    String p_msg_contents="";
    PaperMakeNoticeService service=new PaperMakeNoticeServiceImpl();
    Map<String,String> makebean= service.getMakeNoticeBean(p_notice_id);
    
    String checkpass = SysParamUitl.getSysParamValueIsVALID(PaperConstants.PAPER_MAKE_NOTICE);
    if(!StringUtil.nullOrBlank(checkpass)){
    	p_msg_contents = SysParamUitl.getSysParamValue(checkpass);
        List<Map<String, String>> listmap = SysParamUitl.getSysParamValueDetail(checkpass);
        if(!StringUtil.nullOrBlank(p_msg_contents) && listmap!=null && listmap.size()>0){
        	for (Map<String, String> map : listmap){
        		//System.out.println("map.get(\"p_value_name\")=="+map.get("p_value_name")+",map.get(\"p_value_code\")==="+map.get("p_value_code")+",kbmDocMap.get(map.get(\"p_value_code\"))=="+kbmDocMap.get(map.get("p_value_code")));
        		if(!StringUtil.nullOrBlank(makebean.get(map.get("p_value_code")))){
        			p_msg_contents = p_msg_contents.replaceAll(map.get("p_value_name"),makebean.get(map.get("p_value_code")));
        		}
        	}
        }	 
    }
%>
<title>查阅情况——未阅读 </title>
<!-- 公共部分开始 -->
<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jQuery UI -->
<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js" charset="utf-8"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="../resources/js/kbmdoc.js" type="text/javascript"></script>
<script type="text/javascript">
var opentype = 'unpublish';
var path = '<%=path %>';
//搜索框的控制对象
$(function() {
    
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.paper.list.PaperReceiveNoticeList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "p_receive_id",
            name : 'p_receive_id',
            index : 'p_receive_id',
            hidden : true
        },{
            label : "user_id",
            name : 'user_id',
            index : 'user_id',
            hidden : true
        },{
            label : "p_notice_id",
            name : 'p_notice_id',
            index : 'p_notice_id',
            hidden : true
        }, {	
            label : "单位名称",
            name : 'p_receive_unit_name',
            index : 'p_receive_unit_name',
            width: '350'
        }, {	
            label : "联系人",
            name : 'user_name',
            index : 'user_name',
            width: '100'
        }, {	
            label : "联系电话",
            name : 'user_phone',
            index : 'user_phone',
            width: '100'
        }, {	
            label : "阅读状态",
            name : 'p_read_status',
            index : 'p_read_status',
            width: '100',
            formatter:'select',
			editoptions:{value:"0:未阅读;1:已阅读"}
        }
        ],
        sortname : 'p_read_time',
        //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
        sortorder : 'desc',
        //设置是否在Pager Bar显示所有记录的总数。
        viewrecords : true,
        
        rowNum : 10,
        //用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
        rowList : [ 10, 20, 30 ],//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
        jsonReader : { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
            repeatitems : false
        },
        //定义页码控制条Page Bar
        pagerintoolbar:true,//上面的分页条
        pagerinBottombar:true,//下面的分页条
    
        //设置Grid表格的标题，如果未设置，则标题区域不显示。
        search : toUserParamJosn(),
        prmNames : { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
            rows : "rows",
            //表示请求行数的参数名称  
            sort : "sidx",
            //表示用于排序的列名的参数名称  
            order : "sord",
            //表示采用的排序方式的参数名称 
            search : "search"
        },
       	toolbar : [ true, "top" ],
       	multiselect : true, 
        onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
			}
		}
    });
    
});
   
    /*
        函数:  toUserParamJosn
        说明:  构建要查询的参数
        参数:   无
        返回值: 返回要查询的参数
     */
    var toUserParamJosn = function() {
        var str = "{'p_notice_id':'<%=p_notice_id%>','p_read_status':'0'}";
        return descape(escape(str));
    }
 
    /*
    函数:  sendnotice
   说明:  催阅
   参数:  无
   返回值: 无
*/
var sendnotice = function(id) {
   var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
   var deleteList = '';
   var url = path+"/ajaxServlet?className=com.chinacreator.xtbg.core.paper.action.PaperNoticeAction&method=sendMSG";
   if(selectedIds.length>0){
		for ( var i = 0; i < selectedIds.length; i++){
			model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
			deleteList+=model.user_id+",";
			jQuery("#p_update_user_id").val(deleteList);
		}
	}
   if(jQuery("#p_msg_type1").attr("checked")=="checked"){
	   jQuery("#p_msg_type1").val("短信");
   }else{
	   jQuery("#p_msg_type1").val("");
   } 
   if(jQuery("#p_msg_type2").attr("checked")=="checked"){
	   jQuery("#p_msg_type2").val("及时信息");
   }else{
	   jQuery("#p_msg_type2").val("");
   }
   if(jQuery("#p_msg_type1").attr("checked")=="checked" || jQuery("#p_msg_type2").attr("checked")=="checked"){
	   
   }else{
	   alert("请选择要提醒的方式！");
	   return;
   }
   if (!deleteList.length) {
       alert("请选择你要催发的项！");
   } else {
    	 //ajax方式提交数据
    	   jQuery.ajax({
    	       type: "post", 
    	       url: url,
    	       contentType: "application/x-www-form-urlencoded; charset=utf-8",
    	       data : getValue(),
    	       dataType: "json", 
    	       success: function (data) {
    	    	   //操作成功，返回上层界面
    	    	  
    	           if(data && data.msg){                
    	             alert(data.msg,{
    	                 headerText:'提示',
    	                 okName:'确认',
    	                 okFunction:function(){
    	                 }
    	                 });
    	           }
    	       },
    	       error: function (XMLHttpRequest, textStatus, errorThrown) {
    	           alert("出现异常，请稍后再试！");
    	       }
            });
       }
   }
/**
 * 获得要提交的参数
 */ 
function getValue(){
    var params = {};
        params["makebean.p_msg_type1"] = jQuery("#p_msg_type1").val();
        params["makebean.p_msg_type2"] = jQuery("#p_msg_type2").val();
        params["makebean.p_msg_contents"] = jQuery("#p_msg_contents").val();
        params["makebean.p_create_user_id"] = jQuery("#p_create_user_id").val();
        params["makebean.p_create_user_name"] = jQuery("#p_create_user_name").val();
        params["makebean.p_update_user_id"] = jQuery("#p_update_user_id").val();
    //转码
    for(var name in params ){
        params[name] = descape(escape(params[name]));
    }  
    return params;    
}
    /*
     函数:  search
     说明:  查询
     参数:   无
     返回值: 
     */
  var search = function() {
      var sdata = { //构建查询需要的参数 
          paramJson : toUserParamJosn()
      }; //获得当前postData选项的值  
      var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
      $.extend(postData, sdata);
      $("#gridTable").jqGrid("setGridParam", {
          search : true
      // 将jqGrid的search选项设为true  
      }).trigger("reloadGrid", [ {
          page : 1
      } ]); //重新载入Grid表格，以使上述设置生效 
  }
  /* 
  函数:  setValue4m_msg_contents
  说明:  事件响应方法设置短信模板
  */
  function setValue4m_msg_contents(id){
  	if(IsSpace(jQuery("#p_title").val())){
  		/* alert("请先填写标题");
  		return; */
  	}
  	if(jQuery("#p_msg_contents").val()==""){
  		jQuery("#p_msg_contents").val(jQuery("#msg_contents").val());//短信模板
  	}
  }
</script>
</head>
<body style="overflow-y: hidden;" onload="adaptationWH('_top','vcenter',0)">
<div>
<textarea style="display: none" id="msg_contents"><%=p_msg_contents %></textarea>
<input  type="hidden"  name="p_create_user_id" id="p_create_user_id" value="<%=makebean.get("p_create_user_id") %>" />
<input  type="hidden"  name="p_create_user_name" id="p_create_user_name" value="<%=makebean.get("p_create_user_name") %>" />
<input  type="hidden"  name="p_update_user_id" id="p_update_user_id" value="" />



<div class="content_02" style="overflow: hidden;" id="_top">
	<div class="content_02_top" style="margin-left: 10px">
			<input class="but_y_01" type="button" value="催阅"
				onclick="sendnotice()" style="margin-left: 10px"/>
			<input class="but_y_01" type="button" value="关闭"
				onclick="removeAlertWindows('',true)" />
				</div>
	</div>
	
<div id="vcenter" style="float: left; width: 100%;" scrolling="yes">
	<div style="float: left; width: 100%;">
	
		<div class="content_02_box" style="width: 100%">
			<div class="content_02_box_div" style="width: 100%">
				<table border="0" cellspacing="0" cellpadding="0"
					class="content_02_box_div_table" style="width: 97.3%">
					<tr >
						<th class="content_02_box_div_table_th"><font style="COLOR: red">*</font>提醒方式：</th>
						<td class="content_02_box_div_table_td" >
							<div><span style="float:left;display:block;width: 20px">&nbsp;</span>
								<input style="float:left;display:block;margin:7px 2px 0 2px" type="checkbox"  name="p_msg_type1" id="p_msg_type1" onclick="setValue4m_msg_contents(this.id);" />
								<span style="float:left;display:block;width: 50px">短信</span>
								<input style="float:left;display:block;margin:7px 2px 0 2px" type="checkbox"  name="p_msg_type2" id="p_msg_type2" onclick="setValue4m_msg_contents(this.id);" />
								<span style="float:left;display:block;width: 100px">及时信息</span>
								<!-- <input style="float:left;display:block;width: 100px" type="button" class="but_y_05" value="使用默认模版"/> -->
							</div>
						</td>
					</tr>
					<tr >
						<th width="212" valign="top" class="content_02_box_div_table_02_th"><font style="COLOR: red">*</font>提醒内容：</th>
						<td  class="content_02_box_div_table_02_td">
						<textarea class="validate[required,maxSize[250]] textarea_575" style="width:99%;height:50px" name="p_msg_contents" id="p_msg_contents"  ></textarea>
							
						</td>
					</tr>
					
				</table>
			</div>
		</div>
	</div>
    <!-- 查询列表区 cGridArea(查询区样式)-->
    <div class="content_02_box_div_special" style="width:99%" >
        <table id="gridTable"></table>
        <div id="gridPager"></div>
    </div>
</div>
</div>
</body>
</html>