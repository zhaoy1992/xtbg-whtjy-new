<%--
描述：档案查询(分部门)(index内右)
作者：邹拓
版本：1.0
日期：2013-7-16
UTF-8
参数列表:
	level:0:机构,1:部门
	nodeId:机构ID or 部门ID
--%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="java.util.*"%>
<%@page import="com.chinacreator.xtbg.core.file.service.*"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.*"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileConstant"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%
    AccessControl controler = AccessControl.getAccessControl();
    controler.checkAccess(request, response);
    String path = request.getContextPath();
    //获得当前登录用户的id
    String userId = controler.getUserID();
    //获得缓存的机构信息
    UserCacheBean userBean = UserCache.getUserCacheBean(userId);
    String unitOrOrgId = StringUtil.deNull(request.getParameter("nodeId"));
	String level = StringUtil.deNull(request.getParameter("level"));
    String unitId = StringUtil.deNull(userBean.getUnit_id());
    String deptId = StringUtil.deNull(userBean.getOrg_id());
    String deptName = StringUtil.deNull(userBean.getOrg_name());
    String unitName = StringUtil.deNull(userBean.getUnit_name());
    //服务接口
    FileFilesService service = new FileFilesServiceImpl();
    //密级的list
    List<Map<String,String>> secretList = service.queryDictByCode(FileConstant.DICT_TYPE_DAMJ);
    //保管期限
    List<Map<String,String>> deadlineList = service.queryDictByCode(FileConstant.DICT_TYPE_BGQX);
  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<!-- 公共部分开始 -->
<script type="text/javascript"
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 日期控件 -->
<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<!-- 引入jQuery UI -->
<script
    src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
    type="text/javascript"></script>

<!-- 引入jGrid -->
<link rel="stylesheet" type="text/css" media="screen"
    href="../../resources/plug/jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script
    src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
    type="text/javascript"></script>
<script
    src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
    type="text/javascript"></script>

<!-- 引入其它 -->
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"
    charset="utf-8"></script>
<script src="../../resources/util/public.js" type="text/javascript"></script>
<script type="text/javascript"
    src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../resources/util/multiSelect.js" type="text/javascript"></script>
<script type="text/javascript">
	var userId = "<%=userId%>";
	var path = "<%=path%>";
	
	var unitOrOrgId = '<%=unitOrOrgId%>';
	var level = '<%=level%>';
	var userUnit = '<%=unitId%>';
	var userDeptId = '<%=deptId%>';
	var userDeptName = '<%=deptName%>';
	//根据传的值修改部门input中的值
	function updateDeptInput(){
		if(parent.treeNodeName){
			jQuery("#f_dept_name").val(parent.treeNodeName);
		}else{
			jQuery("#f_dept_name").val('<%=unitName%>');
		}
	};
	function toUserParamJosn(){
		var f_dept_name = jQuery("#f_dept_name").val();
		var f_doc_year = jQuery("#f_doc_year").val();
		var f_doc_deadline_name = jQuery("#f_doc_deadline_name").val();
		var f_secrecy_name = jQuery("#f_secrecy_name").val();
		var f_org_id = userUnit;
		var f_dept_id = "";
		if(level&&unitOrOrgId){
			if(level=='0'){//查询机构内所有
				f_org_id = unitOrOrgId;
				f_dept_id = '';
			}else if(level=='1'){//查询机构.部门内所有
				f_org_id = userUnit;
				f_dept_id = unitOrOrgId;
			}
		}
		
		var str = "{'f_dept_name':'"+f_dept_name+"'";
		str += ",'f_doc_year':'"+f_doc_year+"'";
		str += ",'f_doc_deadline_name':'"+f_doc_deadline_name+"'";
		str += ",'f_secrecy_name':'"+f_secrecy_name+"'";
		str += ",'f_org_id':'"+f_org_id+"'";
		str += ",'f_dept_id':'"+f_dept_id+"'";
		str += "}";
		return descape(escape(str));
	}
	
$(function() {
	updateDeptInput();
    $(document).keydown(function(){
        if(event.keyCode == 13){
            search();
        }
    });

    //重置按钮添加事件
    jQuery("#reset").click(function(){
        clear();
    });

    showOrHideButton(window.parent.f_type_level);
    //设置多选框
    setSelect("#f_secrecy_name", "classinput1");
    setSelect("#f_doc_deadline_name", "classinput2");
    
    //设置工具栏的宽度
    jQuery("#tool_buttons").width(jQuery("#t_bottombar_contentgridTable").width());
    
    createTable();
});
	
   

    /*
         函数:  search
         说明:  查询
         参数:   无
         返回值: 
     */
    var searchAA = function() {
        
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

    /**
     *重置查询条件
     */
     var clear = function(){
         //清空输入框的值
        jQuery("input[type=text][name!='f_dept_name']").val("");
        jQuery("#searchTable input[type=checkbox]:checked").removeAttr("checked"); 
        //查询
        searchAA();
     }

     

    /**
     *添加
     */
    var add = function(){
        var width = jQuery(document).width();
        var height = window.top.findPageCacheName("_documentBodyHeight");
        openAlertWindows('add_fileFiles'
                ,path+"/ccapp/oa/file/jsp/filefilesaddmain.jsp?windowId=add_fileFiles"
                +"&f_type_id="+window.parent.f_type_id
                +"&f_type_name="+window.parent.f_type_name
                +"&f_typeno="+window.parent.f_typeno
                +"&f_files_state=0"
                +"&busiTypeCode=file_002",                            
                '添加档案',width,height,'5%','10%');
        
    }


/*
       函数:  del
      说明:  删除
      参数:  无
      返回值: 无
*/
var del = function(id) {
       var ids = "";
       var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
       var ids = new Array();
       $(selectedIds).each(function () {
           var model = jQuery("#gridTable").jqGrid('getRowData', this);
           //id不为空
           ids.push(model.f_files_id);  
       });
           
       if (!ids.length) {
           alert("未选中记录，请至少选择一条记录！");
       } else {
           var okF = function(){
               //ajax方式提交数据
               jQuery.ajax({ 
                   type: "post", 
                   url: "filefilesdo.jsp", 
                   contentType: "application/x-www-form-urlencoded; charset=utf-8",
                   data : {
                       action : "delete",
                       ids : ids.join(",") //要删除的id列表      
                   },
                   dataType: "json", 
                   success: function (data) {
                       if(data){
                           if(data.msg){
                               alert(data.msg);
                           }
                           //如果删除成功，刷新数据
                           if(data.flag&&"true" == data.flag){
                               search();
                           }
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


	/*
	函数:  批量修改
	参数:  无
	返回值: 无
	*/
	var updateList = function() {
		var ids = "";
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		var ids = new Array();
		$(selectedIds).each(function () {
		    var model = jQuery("#gridTable").jqGrid('getRowData', this);
		    //id不为空
		    ids.push(model.f_files_id);  		    
		});
        var urlArray = new Array();		
        urlArray.push(getCurrentFilePath()+'filefilesupdate.jsp?windowId=updateListFileFiles');
        urlArray.push("&ids="+ids.join(","));
               
        urlArray.push("&f_dept_name=" + jQuery("#f_dept_name").val());
        urlArray.push("&f_doc_year=" + jQuery("#f_doc_year").val());
        urlArray.push("&f_doc_deadline="+jQuery("#f_doc_deadline").val());
        urlArray.push("&f_files_title="+jQuery("#f_files_title").val());
        urlArray.push("&f_filesno="+jQuery("#f_filesno").val());
        urlArray.push("&f_secrecy_name="+jQuery("#f_secrecy_name").val());
        urlArray.push("&f_type_id="+window.parent.f_type_id);
        
        var url = urlArray.join("");
       
		 openAlertWindows('updateListFileFiles'
	                ,url,'批量修改案卷信息'
	                ,600,360,'10%','20%'); 	    
	
	}

var className="com.chinacreator.xtbg.core.file.entity.FileFilesQueryByDeptExportBean";
function exportExcel(){
	var f_dept_name = jQuery("#f_dept_name").val();
	var f_doc_year = jQuery("#f_doc_year").val();
	var f_doc_deadline_name = jQuery("#f_doc_deadline_name").val();
	var f_secrecy_name = jQuery("#f_secrecy_name").val();
	var f_org_id = userUnit;
	var f_dept_id = "";
	if(level&&unitOrOrgId){
		if(level=='0'){//查询机构内所有
			f_org_id = unitOrOrgId;
			f_dept_id = '';
		}else if(level=='1'){//查询机构.部门内所有
			f_org_id = userUnit;
			f_dept_id = unitOrOrgId;
		}
	}
	var url = getCurrentFilePath()+"/exportexcel.jsp?"+"windowId=windowId_paperTJ"; 
	var html = new Array();
	if(jQuery("#hiddenFrame").size()==0){
		html.push('<iframe id="hiddenFrame"  name="hiddenFrame" width=0 height=0></iframe>');
	}
	if(jQuery("#downFrom").size()>0){
		jQuery("#downFrom").remove();
	}
	
    html.push('<form id="downFrom" name="downFrom" method="post" action="'+url+'" target="hiddenFrame">');
	html.push("<input type='hidden' name='f_dept_name' value='"+f_dept_name+"' /> ");
	html.push("<input type='hidden' name='f_doc_year' value='"+f_doc_year+"' /> ");
	html.push("<input type='hidden' name='f_doc_deadline_name' value='"+f_doc_deadline_name+"' /> ");
	html.push("<input type='hidden' name='f_secrecy_name' value='"+f_secrecy_name+"' /> ");
	html.push("<input type='hidden' name='f_org_id' value='"+f_org_id+"' /> ");
	html.push("<input type='hidden' name='f_dept_id' value='"+f_dept_id+"' /> ");
	html.push("<input type='hidden' name='className' value='"+className+"' /> ");
    html.push("</form>");
	
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body").submit();
}

	/**
	 *显示or影藏按钮
	 */
	function showOrHideButton(level){
		if(3 == level){
			jQuery("#addButton").show();
		}else{
			jQuery("#addButton").hide();
		}
	}
	
	function createTable(){
		$("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FileFilesQueryByDeptList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
                label : "案卷号",
                name : 'f_filesno',
                index : 'f_filesno',
                editable : false
            }, {
                label : "档案年份",
                name : 'f_doc_year', 
                index : 'f_doc_year',
                editable : false
            },{
                label : "档号",
                name : 'f_files_no',
                index : 'f_files_no',
                editable : false
            },{
                label : "保管期限",
                name : 'f_doc_deadline_name',
                index : 'f_doc_deadline_name',
                editable : false
            },{
                label : "密级",
                name : 'f_secrecy_name',
                index : 'f_secrecy_name',
                editable : false
            },{
                label : "密级id",
                name : 'f_secrecy_id',
                index : 'f_secrecy_id',
                hidden : true    
            },{
                label : "归档日期",
                name : 'f_file_time',
                index : 'f_file_time',
                editable : false     
            },{
                label : "id",
                name : 'f_files_id',
                index : 'f_files_id',
                editable : false,
                hidden : true    
            },{
                label : "f_type_id",
                name : 'f_type_id',
                index : 'f_type_id',
                editable : false,
                hidden : true    
            },{
                label : "f_type_id",
                name : 'f_type_id',
                index : 'f_type_id',
                editable : false,
                hidden : true    
            },{
                label : "f_type_name",
                name : 'f_type_name',
                index : 'f_type_name',
                editable : false,
                hidden : true    
            },{
                label : "f_files_state",
                name : 'f_files_state',
                index : 'f_files_state',
                editable : false,
                hidden : true    
            }
        ],
        sortname : 'f_filesno',
        //指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
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
       	toolbar : [ false, "top",
       	"<input name=\"exportButton\" id=\"exportButton\" onclick=\"exportExcel();\" value=\"导出\" type=\"button\" class=\"but_y_01\" style=\"float: left;margin-left: 5px;\" />"],
       	multiselect : false, 
        onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
				//var model = jQuery("#gridTable").jqGrid('getRowData', id);
        		//updateFileDocDetail(model);
				 var model = jQuery("#gridTable").jqGrid('getRowData', id);
	             update(model.f_files_id,model.f_files_state,model.f_type_id,model.f_type_name);
			}
		}
    });
		
	}
	
	
	var update = function(id,flag,typeId,typeName,f_files_state){
		var width = jQuery(document).width();
	    var height = window.top.findPageCacheName("_documentBodyHeight");
	    
		openAlertWindows('update_fileFiles'
                ,path+'/ccapp/oa/file/jsp/filefilesaddmain.jsp?windowId=update_fileFiles&id='+id+"&isview=isview&f_files_state="+flag
                +"&busiTypeCode=file_002&f_type_id="+typeId+"&f_type_name="+descape(escape(typeName)), 
                '更新档案'
                ,width,height,'5%','10%');
        
        $("#update_fileFilesupdate_fileFiles").draggable();
	}
</script>
<!-- 公共部分结束 -->
</head>
<body>
<div>
    <table id="queryTable" width="80%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
        <tr>
            <td>
            <!-- 固定查询 -->
                <table id="searchTable" style="width:100%" border="0" cellspacing="3" cellpadding="0" class="tabs_search_ctable">
                    <tr >
                       
                        <th  class="input_cx_title_th" style="width:80px;">所属单位或部门：</th>
                         <td style="width:120px;" class="cx_title_td">
                             <input value="<%=deptName%>" type="text" disabled="disabled"
                                    class="input_cx_title_283"  style="width:120px;" id="f_dept_name" name="f_dept_name"/>
                             
                        </td>
                         <th style="width:60px;" class="input_cx_title_th">档案年份：</th>
                        <td style="width:120px;" class="cx_title_td">
                        <input style = "width:100px;;background:url(/xtbg/ccapp/oa/resources/style/blue/images/date_img_year.jpg) right 1px no-repeat;" type="text" class="date_120 Wdate" name="f_doc_year" id="f_doc_year"
                             onclick="WdatePicker({dateFmt:'yyyy'})"/>
                        </td>
                      
                        <td style="width:60px;" >
                            <input value="搜索" id="sel" type="button" onclick="searchAA();" class="but_y_01" />
                        </td>
                    </tr>
                    <tr>
                    <th  class="input_cx_title_th" style="width:60px;">密级：</th>
                        <td valign="top" style="width:120px;"  class="cx_title_td" style="padding-top:0px;">
                             <div style="float:left;position: absolute;width:125px;z-index: 1;">                         
                                 <select style="width:125px;" multiple="multiple" name ="f_secrecy_name" id= "f_secrecy_name" class ="input_cx_title_283" >
                                     <option  type="checkbox" value='' all='30'>&nbsp;全选</option>
                                     <%for(Map type : secretList){ %>
                                     <option type="checkbox" value="<%=StringUtil.deNull(type.get("dictdata_value")) %>">&nbsp;<%=StringUtil.deNull(type.get("dictdata_name")) %></option>
                                     <%} %>
                                 </select>
                             </div>
                        </td>
                        <th  class="input_cx_title_th" style="width:60px;">保管期限：</th>
                         <td valign="top" style="width:120px;"  class="cx_title_td">
                           <div style="float:left;position: absolute;width:100px;z-index: 2;">                         
                             <select style="width:105px;" multiple="multiple" name ="f_doc_deadline_name" id= "f_doc_deadline_name" class ="input_cx_title_283" >
                                 <option  type="checkbox" value='' all='30'>&nbsp;全选</option>
                                <%for(Map dead : deadlineList){ %>
                                <option type="checkbox" value="<%=StringUtil.deNull(dead.get("dictdata_value")) %>">&nbsp;<%=StringUtil.deNull(dead.get("dictdata_name")) %></option>
                                <%} %>
                             </select>
                            </div> 
                        </td>
                        
                        <td  style="width:60px;" >
                            <input value="重置" id="reset" type="button" class="but_y_01" />
                        </td>
                    </tr>
                </table>
            <!-- 固定查询 end-->
            </td>
        </tr>
    </table>
    
    
    <!-- 查询列表区 cGridArea(查询区样式)-->
    <div style="float:left;width:100%;" class="cGridArea">
			<div id="tool_buttons" class="ui-jqgrid .ui-userdata ui_t_bottombar_content" 
		         style="height:28px;margin-left:10px;margin-bottom:0px;float: none;border: #ebebeb 1px solid;">            
				           <input name="exportButton" id="exportButton" onclick="exportButton()" value="导出" type="button" class="but_y_01" style="float: left;margin-left: 10px;"/>
	 		</div>
			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
</div>
</body>
</html>