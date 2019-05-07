<%--
　　描述：档案管理--部门档案盒提交--列表
		显示两部分的内容:
			一是从部门档案管理员添加的记录（状态0：未提交），
			一是从单位档案管理员退回的记录（状态1：退回）。状态为（2：已提交  3、已接收）的不显示。
		操作者:部门档案管理员
　　作者：邹拓
　　日期：2014-05-05
	参数 ：null
--%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileConstant"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesService"%>
<%@page import="com.chinacreator.xtbg.core.file.util.ModuleUtil"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<%@taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<%
	AccessControl controler = AccessControl.getAccessControl();
	controler.checkAccess(request, response);
	String userId = controler.getUserID();
	String role = ModuleUtil.checkRoleForGWDGD(userId);
	
	String path = request.getContextPath();
	
	UserCacheBean userBean = UserCache.getUserCacheBean(controler.getUserID());
	if (userBean == null) {
		userBean = new UserCacheBean();
	}
	String f_unit_id = userBean.getUnit_id();
	String f_unit_name = userBean.getUnit_name();
	String f_org_id = userBean.getOrg_id();
	String f_org_name = userBean.getOrg_name();
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<!-- 公共部分开始 -->
		<script type="text/javascript"
			src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
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
			src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js"
			charset="utf-8"></script>
		<script src="../../resources/plug/My97DatePicker/WdatePicker.js"
			type="text/javascript"></script>
<script type="text/javascript">
var cleara = function(){
	$('#f_title').val("");
	$('#f_file_no').val("");
	search();
}

var updateFileDocDetail = function(bean) {
	var width = jQuery(document).width();
    var height = window.top.findPageCacheName("_documentBodyHeight");
    
    openAlertWindows('update_fileFiles'
            ,'<%=path%>/ccapp/oa/file/jsp/filefilesaddmain.jsp?isview=isview&openPage=tijiaoJSP&windowId=update_fileFiles&id='+bean.f_files_id+"&f_files_state="+bean.f_files_state
            +"&busiTypeCode=file_002&f_type_id="+bean.f_type_id+"&f_type_name="+descape(escape(bean.f_type_name))+"&f_flow_state="+descape(escape(bean.f_flow_state)), 
            '查看档案'
            ,width,height,'5%','10%');
}
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
var toUserParamJosn = function() {
	<%if(role.equals(ModuleUtil.ROLE_DWDAGLY)){%>
		var str = "{";
		str += "'f_org_id':'<%=f_unit_id%>',";
		str += "'f_secrecy_name':'"+$('#f_secrecy_name').val()+"',";
		str += "'f_doc_deadline_name':'"+$('#f_doc_deadline_name').val()+"',";
		str += "'f_files_no':'"+$('#f_file_no').val()+"',";
		str += "'f_type':'2'";//未提交
		str += "}";
	<%}else if(role.equals(ModuleUtil.ROLE_BMDAGLY)){%>
		var str = "{";
		str += "'f_org_id':'<%=f_unit_id%>',";
		str += "'f_dept_id':'<%=f_org_id%>',";
		str += "'f_secrecy_name':'"+$('#f_secrecy_name').val()+"',";
		str += "'f_doc_deadline_name':'"+$('#f_doc_deadline_name').val()+"',";
		str += "'f_files_no':'"+$('#f_file_no').val()+"',";
		str += "'f_type':'2'";//未提交
		str += "}";
	<%}else{%>
		var str = "{";
		str += "'f_org_id':'<%=f_unit_id%>',";
		str += "'f_dept_id':'<%=f_org_id%>',";
		str += "'f_create_user_id':'<%=userId%>',";
		str += "'f_secrecy_name':'"+$('#f_secrecy_name').val()+"',";
		str += "'f_doc_deadline_name':'"+$('#f_doc_deadline_name').val()+"',";
		str += "'f_files_no':'"+$('#f_file_no').val()+"',";
		str += "'f_type':'2'";//未提交
		str += "}";
	<%}%>
	return descape(escape(str));
}

//搜索框的控制对象
$(function() {
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
    });
    
    $("#gridTable").jqGrid({
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FilesSubmitList', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "100%",
        autowidth : true,
       //表头设置       
        colModel : [
        {
                  label : "案卷ID",
                  name : 'f_files_id',
                  index : 'f_files_id',
                  hidden : true
              },{
                  label : "档号",
                  name : 'f_files_no',
                  index : 'f_files_no',
                  editable : false,
                  width:'200'
              }, {
                  label : "档案年份",
                  name : 'f_doc_year',
                  index : 'f_doc_year',
                  editable : false,
                  hidden:true
              },{
                  label : "盒号",
                  name : 'f_filesno',
                  index : 'f_filesno',
                  editable : false,
                  hidden:true
              },{
                  label : "目录号",
                  name : 'f_listno',
                  index : 'f_listno',
                  editable : false,
                  width:'60'
              },{
                  label : "盒内件数",
                  name : 'f_files_num',
                  index : 'f_files_num',
                  editable : false,
                  width:'60'
              }, {
                  label : "案卷状态",
                  name : 'f_files_state',
                  index : 'f_files_state',
                  hidden : true
              }, {
                  label : "案卷状态",
                  name : 'f_files_state_name',
                  index : 'f_files_state_name',
                  editable : false,
                  width:'60'       
              },{
                  label : "保管期限",
                  name : 'f_doc_deadline_name',
                  index : 'f_doc_deadline_name',
                  editable : false,
                  width:'60'           
              },{
                  label : "密级",
                  name : 'f_secrecy_name',
                  index : 'f_secrecy_name',
                  editable : false,
                  width:'50'    
              },{
                  label : "密级id",
                  name : 'f_secrecy_id',
                  index : 'f_secrecy_id',
                  hidden : true
              },{
                  label : "归档日期",
                  name : 'f_file_time',
                  index : 'f_file_time',
                  editable : false,
                  width:'80'
              },{
                  label : "所属部门",
                  name : 'f_dept_name',
                  index : 'f_dept_name',
                  editable : false,
                  width:'80'
              }, {
                  label : "提交状态",
                  name : 'f_flow_state',
                  width:40,
                  index : 'f_flow_state',
                  formatter:function(v){
                  	var val_map={"0":"未提交","1":"已退回","2":"已提交","3":"已接收"};
                  	var val1 = val_map[v];
                  	if(val1){
                  		return val1;
                  	}else{
                  		return "未提交";
                  	}
                  }
              }, {
                  label : "归档人ID",
                  name : 'f_file_userid',
                  index : 'f_file_userid',
                  hidden : true    
              },{
                  label : "所属部门ID",
                  name : 'f_dept_id',
                  index : 'f_dept_id',
                  hidden : true    
              },{
                  label : "案卷状态",
                  name : 'f_files_state',
                  index : 'f_files_state',
                  hidden : true    
              },{
                  label : "所属分类id",
                  name : 'f_type_id',
                  index : 'f_type_id',
                  hidden : true    
              },{
                  label : "所属分类名",
                  name : 'f_type_name',
                  index : 'f_type_name',
                  hidden : true    
              },{
                  label : "f_order",
                  name : 'f_order',
                  index : 'f_order',
                  hidden : true    
              },{
                  label : "f_flow_state",
                  name : 'f_flow_state',
                  index : 'f_flow_state',
                  hidden : true    
              }
        ],
        sortname : 'f_order',
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
       	toolbar : [ true, "top" ,""],
       	multiselect : false, 
        onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
				var model = jQuery("#gridTable").jqGrid('getRowData', id);
        		updateFileDocDetail(model);
			}
		}
    });
    
});

</script>
	</head>
	<body>
		<div>
			<table id="queryTable" width="100%" border="0" cellspacing="0"
				cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="tabs_search_ctable">
							<tr>
								<th class="input_cx_title_th" style="width: 50px;">
									档号：
								</th>
								<td width="100" class="cx_title_td">
									<input type="text" id="f_file_no" name="f_file_no" class="input_cx_title_283" style="width: 100px;" />
								</td>
								<th style="width: 50px;" class="input_cx_title_th">
									保管期限：
								</th>
								<td width="100" class="cx_title_td">
									<div style="float:left;position: absolute;width:100px;z-index: 2;margin-top: -10px;">
			                             <select style="width:100px;" multiple="multiple" name ="f_doc_deadline_name" id= "f_doc_deadline_name" class ="input_cx_title_283" >
			                                <option  type="checkbox" value='' all='30'>&nbsp;全选</option>
			                                <%
			                                List<Map<String,String>> deadlineList = new FileFilesServiceImpl().queryDictByCode(FileConstant.DICT_TYPE_BGQX);
			                                for(Map dead : deadlineList){ %>
			                                <option type="checkbox" value="<%=StringUtil.deNull(dead.get("dictdata_value")) %>">&nbsp;<%=StringUtil.deNull(dead.get("dictdata_name")) %></option>
			                                <%} %>
			                             </select>
			                        </div>
			                           <script src="../../resources/util/multiSelect.js" type="text/javascript"></script>
			                           <script>
									    setSelect("#f_doc_deadline_name", "classinput12");
									    </script>
								</td>
								<th style="width: 50px;" class="input_cx_title_th">
									密级：
								</th>
								<td width="100" class="cx_title_td">
									<div style="float:left;position: absolute;width:100px;z-index: 1;margin-top: -10px;">                         
									         <select style="width:125px;" multiple="multiple" name ="f_secrecy_name" id= "f_secrecy_name" class ="input_cx_title_283" >
									             <option  type="checkbox" value='' all='30'>&nbsp;全选</option>
									             <%
									           //服务接口 
									 			FileFilesService service = new FileFilesServiceImpl();
									 			//密级的list
									 			List<Map<String,String>> secretList = service.queryDictByCode(FileConstant.DICT_TYPE_DAMJ);
									             for(Map type : secretList){ %>
									             <option type="checkbox" value="<%=StringUtil.deNull(type.get("dictdata_value")) %>">&nbsp;<%=StringUtil.deNull(type.get("dictdata_name")) %></option>
									             <%} %>
									         </select>
									     </div>
									     
									    <script>
									    setSelect("#f_secrecy_name", "classinput1");
									    </script>
								</td>
								<td width="60">
									<input value="搜索" id="sel" type="button" onclick="search();"
										class="but_y_01" />
									<input value="重置" id="reset" type="button" class="but_y_01"
										onclick='cleara()' />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>

			<!-- 查询列表区 cGridArea(查询区样式)-->
			<div class="cGridArea">
				<table id="gridTable"></table>
				<div id="gridPager"></div>
			</div>
		</div>
	</body>
</html>