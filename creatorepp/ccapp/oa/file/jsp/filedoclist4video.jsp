<%--
　　描述：档案管理--文件管理--视频列表页面
　　作者：黄海
　　版本：1.0
　　日期：2013-7-15
--%>
<%@page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<%@taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    String F_TYPE_ID = StringUtil.deNull(request.getParameter("f_type_id"));
    String F_TYPE_NAME = StringUtil.deNull(request.getParameter("f_type_name"));
    String urlTmp = "F_TYPE_ID="+F_TYPE_ID+"&F_TYPE_NAME="+F_TYPE_NAME+"";
    
    String f_file_detail = StringUtil.deNull(request.getParameter("f_file_detail"));//明细通过配置确定
    //初始化"归档状态"下拉框
    StringBuffer sql = new StringBuffer();
    sql.append("SELECT D.DICTDATA_VALUE, D.DICTDATA_NAME");
    sql.append("  FROM OA_DICT_DATA D, OA_DICT_TYPE T");
    sql.append(" WHERE T.DICT_CODE = 'gdzt'");
    sql.append("   AND D.DICT_ID = T.DICT_ID");
    sql.append("   AND T.DICT_IS_VALID = 1");
    sql.append("   AND D.DICTDATA_IS_VALID = 1");
    String selectData = DictDropDownList.buildSelect(sql.toString(),"f_doc_state","","",true,"","width:100%;");
    //
    UserCacheBean userBean= UserCache.getUserCacheBean(controler.getUserID());
	if(userBean==null){
		userBean = new UserCacheBean();
	}
	String F_UNIT_ID=userBean.getUnit_id();
    String F_UNIT_NAME=userBean.getUnit_name();
    String F_ORG_ID = userBean.getOrg_id();
    String F_ORG_NAME = userBean.getOrg_name();
	//角色检查
    String userId = controler.getUserID();
    boolean isManager = KbmUtil.isRolesUser(userId, "单位档案管理员");
%>
<title>档案管理--文件管理--列表</title>
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
<script type="text/javascript" src="../resources/js/filedoclist.js"></script>
<script type="text/javascript">
var f_file_detail = '<%=f_file_detail%>';
//搜索框的控制对象
$(function() {
    
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
    });
    
    $("#gridTable").jqGrid({
    	gridComplete: function(){initAddBtn();},
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FileDocListForVideo', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "f_doc_id",
            name : 'f_doc_id',
            index : 'f_doc_id',
            hidden : true
        }, {
        	label : "件号",
        	width:30,
            name : 'f_doc_num',
            index : 'f_doc_num'
        }, {	
            label : "附件",
            name : 'f_attach_id',
            index : 'f_attach_id',
            width:30,
            formatter : function(value){
            	var f_doc_name = "";
            	if (!isSpace(value)&&value!='0'){
            		f_doc_name = "有(<font color=red>"+value+"</font>)";
            	}else{
            		f_doc_name = "无";
            	}
                return f_doc_name;
          	}

        }, {	
            label : "摄影者",
            width:80,
            name : 'f_shooting_user',
            index : 'f_shooting_user'
        }, {	
            label : "标题",
            width:80,
            name : 'f_doc_name',
            index : 'f_doc_name'
        }, {	
            label : "拍摄时间",
            width:80,
            name : 'f_file_formtime',
            index : 'f_file_formtime'
        }, {
            label : "归档状态id",
            name : 'f_doc_state',
            width:50,
            index : 'f_doc_state',
            hidden : true
        }, {
            label : "归档状态",
            name : 'f_doc_state_name',
            width:50,
            index : 'f_doc_state_name'
        }, {	
            label : "所属部门",
            width:80,
            name : 'f_dept_name',
            index : 'f_dept_name'
        }, {	
            label : "地点",
            width:70,
            name : 'f_add',
            index : 'f_add'
        }
        ],
        sortname : 'f_doc_num',
        sortorder : 'asc',
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
       	multiselect : true, 
       	/* onSelectRow:function (id){
        	var model = jQuery("#gridTable").jqGrid('getRowData', id);
        		updateFileDocDetail(model.f_doc_id);
        }   */  
        onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
				var model = jQuery("#gridTable").jqGrid('getRowData', id);
        		updateFileDocDetail(model.f_doc_id,model.f_doc_state);
			}
		}
    });
});
   initAddBtn = function(){
   		if("3" == window.parent.f_type_level){
			jQuery("#add").show();
			jQuery("#del").show();
			jQuery("#exportButton").show();
			jQuery("#copyFileButton").show();
			jQuery("#tool_buttons").show();
		}else{
			jQuery("#add").hide();
			jQuery("#del").hide();
			jQuery("#exportButton").hide();
			jQuery("#copyFileButton").hide();
			jQuery("#tool_buttons").hide();
		}
   };
    /*
        函数:  toUserParamJosn
        说明:  构建要查询的参数
        参数:   无
        返回值: 返回要查询的参数
     */
    var toUserParamJosn = function() {
       	if(window.parent.role=="org"||window.parent.role=="dept"){
       		var f_doc_year_v = $('#f_doc_year').val();<%--档案年份--%>
        	var f_dept_name_v = $('#f_dept_name').val();<%--所属部门--%>
        	var f_doc_state_v = $('#f_doc_state').val();<%--归档状态--%>
        	var f_shooting_user_v = $('#f_shooting_user').val();<%--文号--%>
        	var f_add_v = $('#f_add').val();<%--文档标题--%>
        	var F_TYPE_ID_v = '<%=F_TYPE_ID%>';
            var str = "{";
    		str += "'f_doc_year':'"+f_doc_year_v+"',";
    		str += "'f_dept_name':'"+f_dept_name_v+"',";
    		str += "'f_doc_state':'"+f_doc_state_v+"',";
    		str += "'f_shooting_user':'"+f_shooting_user_v+"',";
    		str += "'f_add':'"+f_add_v+"',";
    		str += "'f_type_id':'"+F_TYPE_ID_v+"',";
    		
    		str += "'f_doc_num':'"+$('#f_doc_num').val()+"',";
    		str += "'f_attach_id_min':'"+$('#f_attach_id_min').val()+"',";
    		str += "'f_attach_id_max':'"+$('#f_attach_id_max').val()+"',";
    		str += "'f_secrecy_name':'"+$('#f_secrecy_name').val()+"',";
    		str += "'start_time':'"+$('#start_time').val()+"',";
    		str += "'end_time':'"+$('#end_time').val()+"',";
    		str += "'f_doc_name':'"+$('#f_doc_name').val()+"',";
    		if(window.parent.role=="dept"){
    			str += "'f_dept_id':'<%=F_ORG_ID%>',";	
    		}
    		str += "'f_org_id':'<%=F_UNIT_ID%>'";
            str += "}";
            return descape(escape(str));
       	}else{
       		var f_doc_year_v = $('#f_doc_year').val();<%--档案年份--%>
        	var f_dept_name_v = $('#f_dept_name').val();<%--所属部门--%>
        	var f_doc_state_v = $('#f_doc_state').val();<%--归档状态--%>
        	var f_shooting_user_v = $('#f_shooting_user').val();<%--文号--%>
        	var f_add_v = $('#f_add').val();<%--文档标题--%>
        	var F_TYPE_ID_v = '<%=F_TYPE_ID%>';
            var str = "{";
    		str += "'f_doc_year':'"+f_doc_year_v+"',";
    		str += "'f_dept_name':'"+f_dept_name_v+"',";
    		str += "'f_doc_state':'"+f_doc_state_v+"',";
    		str += "'f_shooting_user':'"+f_shooting_user_v+"',";
    		str += "'f_add':'"+f_add_v+"',";
    		str += "'f_type_id':'"+F_TYPE_ID_v+"',";
    		
    		str += "'f_doc_num':'"+$('#f_doc_num').val()+"',";
    		str += "'f_attach_id_min':'"+$('#f_attach_id_min').val()+"',";
    		str += "'f_attach_id_max':'"+$('#f_attach_id_max').val()+"',";
    		str += "'f_secrecy_name':'"+$('#f_secrecy_name').val()+"',";
    		str += "'start_time':'"+$('#start_time').val()+"',";
    		str += "'end_time':'"+$('#end_time').val()+"',";
    		str += "'f_doc_name':'"+$('#f_doc_name').val()+"',";
    		
    		<%if(!isManager){%>
    		str += "'f_dept_id':'<%=F_ORG_ID%>',";
    		<%}%>
    		str += "'f_org_id':'<%=F_UNIT_ID%>'";
            str += "}";
            return descape(escape(str));
       	}
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
  函数:  addFileDocDetail
  说明:  添加
  参数:   无
  返回值: 无
*/
var addFileDocDetail = function () {
	var typeurl = '<%=urlTmp%>';
    openAlertWindows('updateFileDocVideoDetailWindow', getCurrentFilePath() +f_file_detail+ '?'+typeurl+'&busi_id=&busiTypeCode=wj-001&windowId=updateFileDocVideoDetailWindow', '添加文件' ,1020,530,'10%','10%');
}

/*
  函数:  updateFileDocDetail
  说明:  修改
  参数:  无
  返回值: 无
*/
var updateFileDocDetail = function(f_doc_id,f_doc_state) {
	if(f_doc_state!='<%--2:已归档--%>'){<%--2:已归档--%>
		openAlertWindows('updateFileDocDetailWindow', getCurrentFilePath() +f_file_detail+ '?busi_id='+f_doc_id+'&busiTypeCode=wj-001&windowId=updateFileDocDetailWindow', '修改文件' ,1020,520,'10%','10%');
	}else{
		openAlertWindows('updateFileDocDetailWindow', getCurrentFilePath() +f_file_detail+ '?busi_id='+f_doc_id+'&busiTypeCode=wj-001&windowId=updateFileDocDetailWindow&isview=isview', '修改文件' ,1020,520,'10%','10%');
	}
}

/*
     函数:  deleteFn
    说明:  删除
    参数:  无
    返回值: 无
*/
var deleteFn = function(id) {
    var ids = "";
    var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
    var ids = new Array();
    var canDelete = true;
    $(selectedIds).each(function () {
        var model = jQuery("#gridTable").jqGrid('getRowData', this);
        
        ids.push(model.f_doc_id);  
    });
    if(!canDelete){
    	alert("已归档文件不能删除");
    	return;
    }
        
    if (!ids.length) {
        alert("未选中文件项，请重新选择要删除的文件项！");
    } else {
        var okF = function(){
            //ajax方式提交数据
            jQuery.ajax({ 
                type: "post", 
                url: "filedocdetaildo.jsp", 
                contentType: "application/x-www-form-urlencoded; charset=utf-8",
                data : {
                	action : "delete",
                	otp_type : "delete",
                	businessType:"wj-001",
                    ids : ids.join(",") //要删除的id列表      
                },
                dataType: "json", 
                success: function(flag){         
                	if (flag) {
    					alert("操作成功！");
    					search();
    				} else {
    					alert("操作失败！");
    				}
                }, 
                error: function (XMLHttpRequest, textStatus, errorThrown) { 
                    alert("系统异常，请稍后再试！");
                }
             });
        }
        var p={
                    headerText:'提示',
                    okName:'确认',
                    okFunction:okF,
                    cancelName:'取消'
            };
        alert("删除后将不能恢复，确定删除吗？",p); 
    }
}


var className="com.chinacreator.xtbg.core.file.entity.FileDocVideoExportBean";
function exportExcel(){
    var url = getCurrentFilePath()+"/exportexcel.jsp?windowId=windowId_paperTJ"; 
	var html = new Array();
	if(jQuery("#hiddenFrame").size()==0){
		html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
	}
	if(jQuery("#downFrom").size()>0){
		jQuery("#downFrom").remove();
	}
	
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');

    var param = toUserParamJosnA("",true);
       for(var name in param){
          html.push("<input type='hidden' name='"+name+"' value='"+param[name]+"' /> ");
       }
       var postData = $("#gridTable").jqGrid("getGridParam", "postData");
       for(var name in postData){
       	html.push("<input type='hidden' name='"+name+"' value='"+postData[name]+"' /> ");
       }
       	html.push("<input type='hidden' name='className' value='"+className+"' /> ");
    html.push('</form>');
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body").submit();
}
var toUserParamJosnA = function(objName,notEscape){ 
    var param = new Object();
    param[objName+"f_doc_year"] = $('#f_doc_year').val();<%--档案年份--%>
	param[objName+"f_dept_name"] = $('#f_dept_name').val();<%--所属部门--%>
	param[objName+"f_doc_state"]= $('#f_doc_state').val();<%--归档状态--%>
	param[objName+"f_shooting_user"]= $('#f_shooting_user').val();<%--文号--%>
	param[objName+"f_add"] = $('#f_add').val();<%--文档标题--%>
	param[objName+"f_type_id"] = '<%=F_TYPE_ID%>';
	
	param[objName+"f_doc_num"] = $('#f_doc_num').val();
   	param[objName+"f_attach_id_min"] = $('#f_attach_id_min').val();
   	param[objName+"f_attach_id_max"] = $('#f_attach_id_max').val();
   	param[objName+"f_file_quantity_min"] = $('#f_file_quantity_min').val();
   	param[objName+"f_file_quantity_max"] = $('#f_file_quantity_max').val();
   	param[objName+"f_secrecy_name"] = $('#f_secrecy_name').val();
   	param[objName+"start_time"] = $('#start_time').val();
   	param[objName+"end_time"] = $('#end_time').val();
   	param[objName+"f_doc_name"] = $('#f_doc_name').val();
	
    <%if(!isManager){%>
		param[objName+"f_dept_id"] = '<%=F_ORG_ID%>';
	<%}%>
		param[objName+"f_org_id"] = '<%=F_UNIT_ID%>';
    if(!notEscape){
     //转码
     for(var name in param ){
         param[name] = descape(escape(param[name]));
     }  
    }      
    return param;
}
</script>
<!-- 公共部分结束 -->
</head>
<body>
<div>
    <table id="queryTable" width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
        <tr>
            <td>
            <!-- 固定查询 -->
                 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
                 	<tr>
                 		<th  class="input_cx_title_th" style="width:80px;">档案年份：</th>
                 		<td width="120" class="cx_title_td">
                 			<input id="f_doc_year" name="f_doc_year" style="width:120px;background:url(/xtbg/ccapp/oa/resources/style/blue/images/date_img_year.jpg) right 1px no-repeat;" class="date_120" type="text" onfocus="WdatePicker({dateFmt:'yyyy'})" />
						</td>
						
						<th style="width:80px;" class="input_cx_title_th">所属部门：</th>
                        <td width="100" class="cx_title_td">
                        	<input type="text" id="f_dept_name" name="f_dept_name" class="input_cx_title_283" style="width:100px;"/>
                        </td>
                      	<th  class="input_cx_title_th" style="width:80px;">归档状态：</th>
						<td valign="top" width="120"  class="cx_title_td">
							<div style="float:left;position: absolute;width:100px;z-index: 2;">                         
								<%=selectData%>
                            </div> 
                        </td>
                        <td width="60" >
                            <input value="搜索" id="sel" type="button" onclick="search();" class="but_y_01" />
                        </td>
                        <td  width="60">&nbsp;</td>
                    </tr>
                    <tr>
                        <th style="width:80px;" class="input_cx_title_th">摄影者：</th>
                        <td width="120" class="cx_title_td">
                        	<input type="text" id="f_shooting_user" name="f_shooting_user" class="input_cx_title_283" style="width:120px;"/>
                        </td>
                        <th  class="input_cx_title_th" style="width:60px;">地点：</th>
                       	<td width="100" class="cx_title_td">
                        	<input type="text" id="f_add" name="f_add" class="input_cx_title_283" style="width:100px;"/>    
                        </td>
                        <th>
						</th>
						<th>
						</th>
                        <td width="60" >
                            <input value="重置" id="reset" type="button" class="but_y_01" onclick='clearaaa()'/>
                            <script>
                            clearaaa= function(){
								$('#f_doc_year').val("");<%--档案年份--%>
								$('#f_dept_name').val("");<%--所属部门--%>
								$('#f_doc_state').val("");<%--归档状态--%>
								$('#f_shooting_user').val("");<%--文号--%>
								$('#f_add').val("");<%--文档标题--%>
								
								$('#f_doc_num').val("");
								$('#f_attach_id_min').val("");
								$('#f_attach_id_max').val("");
								$('#f_file_quantity_min').val("");
								$('#f_file_quantity_max').val("");
								$('#f_secrecy_name').val("");
								$('#start_time').val("");
								$('#end_time').val("");
								$('#f_doc_name').val("");
						        //查询
						        search();
						     }
                            </script>
                        </td>
                       <td width="80">
					                <span id="selAreaImg" class="all_search_condition">
					                  <a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')">更多搜索条件</a>
					                </span>
				                </td>
                    </tr>
                  
                   	<tr>
						        <td id="hiddenArea" style="display: none" colspan="6"><!-- 隐藏查询 -->
						        <table>
						        	<tr>
										<th class="input_cx_title_th" style="width: 80px;">件号：</th>
										<td width="120" class="cx_title_td">
											<input type="text" id="f_doc_num" name="f_doc_num" class="input_cx_title_283" style="width: 120px;" />
										</td>
										<th>
										</th><th>
										</th>
										<th style="width:80px" class="input_cx_title_th">标题：</th>
										<td style="width:100px;" class="cx_title_td">
											<input type="text" id="f_doc_name" name="f_doc_name" class="input_cx_title_283" style="width: 100px;" />
										</td>
									</tr>
						        	<tr>
										<th style="width: 100px" class="input_cx_title_th">附件数量：</th>
										<td style="width:110px;" class="cx_title_td">
											<input type="text"
											onkeypress="return event.keyCode>=48&&event.keyCode<=57||event.keyCode==46" 
											onpaste="return clipboardData.getData('text').match(/\D/)"
											style="ime-mode:disabled;width: 100px;"
											ondragenter="return false"
											id="f_attach_id_min" name="f_attach_id_min" class="input_cx_title_283"  />
										</td>
										<th style="width: 10px" class="input_cx_title_th">至</th>
										<td style="width:110px;" class="cx_title_td">
											<input type="text" id="f_attach_id_max" name="f_attach_id_max" 
											onkeypress="return event.keyCode>=48&&event.keyCode<=57||event.keyCode==46" 
											onpaste="return clipboardData.getData('text').match(/\D/)"
											style="ime-mode:disabled;width: 100px;"
											ondragenter="return false"
											class="input_cx_title_283" />
										</td>
										<th>
										</th><th>
										</th>
									</tr>
									
									<tr>
										<th style="width: 100px" class="input_cx_title_th">摄影时间：</th>
										<td style="width:110px;" class="cx_title_td">
										     <input type="text" class="date_187" id="start_time" name="start_time" value="" style="width:110px;"
										            onfocus ="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'start_time\')||\'2099-12-12\'}'})" />
										</td><th style="width: 10px" class="input_cx_title_th">至</th>
										<td style="width:110px;" class="cx_title_td">
										     <input type="text" class="date_187" id="end_time" name="end_time" value="" style="width:110px;"
										            onfocus ="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'end_time\')||\'1980-01-01\'}'})" />
										</td>
										<th>
										</th><th>
										</th>
									</tr>
						        </table>
						        </td>
						        <td colspan="2">&nbsp;</td>
						    </tr>
                </table>
                <input type="hidden" name="F_TYPE_ID" id="F_TYPE_ID" value="<%=F_TYPE_ID %>" />
            <!-- 固定查询 end-->
            </td>
        </tr>
    </table>
    
    
    <!-- 查询列表区 cGridArea(查询区样式)-->
    <div class="cGridArea">
    	<div id="tool_buttons"  class="ui-jqgrid .ui-userdata ui_t_bottombar_content" 
         style="display:none;height:28px;margin-left:10px;margin-bottom:0px;float: none;border: #ebebeb 1px solid;">            
			           <input name="addBtn" id="addBtn" onclick="addFileDocDetail();" value="添加" type="button" class="but_y_01" style="float: left;margin-left: 10px;"/>
			           <input name="del" id="del" onclick='deleteFn()' value="删除" type="button" class="but_y_01" style="float: left;margin-left: 5px;" />
			           <input name="exportExcel" id="exportExcel" onclick="exportExcel();"  value="导出" type="button" class="but_y_01" style="float: left;margin-left: 5px;" />
			           <input name="copyFileButton" id="copyFileButton" onclick="filedoclist.copyDoc();"  value="复制文件" type="button" class="but_y_01" style="float: left;margin-left: 5px;" />
 		</div>
        <table id="gridTable"></table>
        <div id="gridPager"></div>
    </div>
</div>
</body>
</html>