<%--
　　描述：档案管理--阅读数量统计(按分类)
　　作者：邹拓
　　版本：1.0
　　日期：2013-10-23
--%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.*"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page
	import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.kbm.util.KbmUtil"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileFilesService"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileFilesServiceImpl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileConstant"%>
<%@page import="com.chinacreator.xtbg.core.common.tree.dao.impl.CommonTreeDaoImpl"%>
<%@taglib uri="/WEB-INF/archive-taglib.tld" prefix="oa"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<%
			AccessControl controler = AccessControl.getAccessControl();
			controler.checkAccess(request, response);
			String path = request.getContextPath();
			String F_TYPE_ID = StringUtil.deNull(request
					.getParameter("f_type_id"));
			String F_TYPE_NAME = StringUtil.deNull(request
					.getParameter("f_type_name"));
			String urlTmp = "F_TYPE_ID=" + F_TYPE_ID + "&F_TYPE_NAME="
					+ F_TYPE_NAME + "";

			String f_file_detail = StringUtil.deNull(request
					.getParameter("f_file_detail"));//明细通过配置确定
			//初始化"归档状态"下拉框
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT D.DICTDATA_VALUE, D.DICTDATA_NAME");
			sql.append("  FROM OA_DICT_DATA D, OA_DICT_TYPE T");
			sql.append(" WHERE T.DICT_CODE = 'gdzt'");
			sql.append("   AND D.DICT_ID = T.DICT_ID");
			sql.append("   AND T.DICT_IS_VALID = 1");
			sql.append("   AND D.DICTDATA_IS_VALID = 1");
			String selectData = DictDropDownList.buildSelect(sql.toString(),
					"f_doc_state", "", "", true, "", "width:100%;");
			//
			UserCacheBean userBean = UserCache.getUserCacheBean(controler
					.getUserID());
			if (userBean == null) {
				userBean = new UserCacheBean();
			}
			String F_UNIT_ID = userBean.getUnit_id();
			String F_UNIT_NAME = userBean.getUnit_name();
			String F_ORG_ID = userBean.getOrg_id();
			String F_ORG_NAME = userBean.getOrg_name();
			//档案查询
			String fromDACX = request.getParameter("fromDACX");
			boolean isDACX = false;
			if (fromDACX != null) {
				isDACX = true;
			}
			//角色检查
			String userId = controler.getUserID();
			boolean isManager = KbmUtil.isRolesUser(userId, "单位档案管理员");
			//
			//服务接口 
			FileFilesService service = new FileFilesServiceImpl();
			//密级的list
			List<Map<String,String>> secretList = service.queryDictByCode(FileConstant.DICT_TYPE_DAMJ);
		%>
		<title>档案管理--文件管理--列表</title>
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
		<script type="text/javascript" src="../resources/js/filedoclist.js"></script>
		<script src="../../resources/util/multiSelect.js" type="text/javascript"></script>
		
		<!-- 引入其它 -->
	<script type="text/javascript" src="../../resources/util/public.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
		<script type="text/javascript">
var f_file_detail = '<%=f_file_detail%>';

//搜索框的控制对象
$(function() {
	changeFileTypeMess();
	
    
    $(document).keydown(function(){
        if(event.keyCode == 13){ 
            search();
        }
    });
    
    $("#gridTable").jqGrid({
    	gridComplete: function(){initAddBtn();},
        url: '<%=path%>/pubListServlet?classNameId=com.chinacreator.xtbg.core.file.list.FileTJList1', 
        //jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
        datatype : "json",
        mtype : "POST",//定义使用哪种方法发起请求，GET或者POST
        height : "450px",
        autowidth : true,
       //表头设置       
        colModel : [ 
        {
            label : "f_type_name",
            name : 'f_type_name',
            index : 'f_type_name',
            hidden : true
        }, {
        	label : "档案分类",
        	width:200,
            name : 'f_type_name',
            index : 'f_type_name'
        }, {	
            label : "文档数",
            name : 'aa',
            index : 'aa'
        }, {	
            label : "阅读人数",
            name : 'a',
            index : 'a'
        }, {	
            label : "借阅次数",
            name : 'b',
            index : 'b'
        }, {
            label : "其中：外单位借阅次数",
            name : 'c',
            index : 'c'
        }, {
            label : "rm",
            name : 'rm',
            index : 'rm',
            hidden : true
        }
        ],
        sortname : 'rm',
        sortorder : 'asc',
        //设置是否在Pager Bar显示所有记录的总数。
        viewrecords : true,
        rowNum : 100,
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
       	toolbar : [ true, "top" ,
       	"<input name=\"exportButton\" id=\"exportButton\" onclick=\"exportExcel();\" value=\"导出\" type=\"button\" class=\"but_y_01\" style=\"float: left;\" />"
       	],
       	multiselect : false, 
       	
        onCellSelect:function (id,icol)
		{
			if(icol != 0)
			{
			}
		}
    });
    
});
   initAddBtn = function(){
   };
    /*
        函数:  toUserParamJosn
        说明:  构建要查询的参数
        参数:   无
        返回值: 返回要查询的参数
     */
    var toUserParamJosn = function() {
        var str = "{";
		str += "'f_doc_year':'"+$('#f_doc_year').val()+"',";
		str += "'f_dept_name':'"+$('#f_dept_name').val()+"',";
		str += "'f_type_id':'"+$('#f_type_id').val()+"',";
		str += "'f_dept_id':'<%=F_ORG_ID%>',";
		str += "'f_org_id':'<%=F_UNIT_ID%>'";
        str += "}";
        return descape(escape(str));
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
	openAlertWindows('addFileDocDetailWindow', getCurrentFilePath() +f_file_detail+ '?'+typeurl+'&busi_id=&busiTypeCode=wj-001&windowId=addFileDocDetailWindow', '添加文件' ,1020,530,'10%','10%');
  //  openAlertWindows('addFileDocDetailWindow', getCurrentFilePath() +f_file_detail+ '?'+typeurl+'&busi_id=&busiTypeCode=wj-001&windowId=addFileDocDetailWindow', '添加文件' ,1020,530,'10%','10%');
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
var className="com.chinacreator.xtbg.core.file.entity.FileTJList1ExportBean";
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
	html.push("<input type='hidden' name='f_doc_year' value='"+$('#f_doc_year').val()+"' /> ");
	html.push("<input type='hidden' name='f_dept_name' value='"+$('#f_dept_name').val()+"' /> ");
	html.push("<input type='hidden' name='f_type_id' value='"+$('#f_type_id').val()+"' /> ");
	html.push("<input type='hidden' name='f_dept_name' value='"+$('#f_dept_name').val()+"' /> ");
	html.push("<input type='hidden' name='f_org_id' value='<%=F_UNIT_ID%>' /> ");
	html.push("<input type='hidden' name='sidx' value='rm' /> ");
	html.push("<input type='hidden' name='sord' value='asc' /> ");

	html.push("<input type='hidden' name='className' value='"+className+"' /> ");
  	html.push('</form>');
    //加载到body，提交后再删除
    jQuery(html.join("")).appendTo("body").submit();
}
   
   changeFileTypeMess = function(){
  		$("#f_type_name").click(function(){
  			var s = new $.z_tree();
			s.type = "inqueryTreeFileTreeInOneProgramPage";
			s.orgId='<%=F_UNIT_ID%>';
			s.treeID = "TreeFileTreeInOneProgramPage";
			s.treetypestr = 'radio';
			s.isShowSeacher = true;
			s.treeName = "档案分类";
			s.headerName = s.treeName;
			s.selectedIds = jQuery('#f_type_id').val(),
			s.isType = 'dept',<%--关系到selectedIds是否生效--%>
			s.returnFunction = function(node) {
				if(node&&node.id){
					jQuery('#f_type_name').val(node.name);
					jQuery('#f_type_id').val(node.id);
				}else{
					jQuery('#f_type_name').val("");
					jQuery('#f_type_id').val("");
				}
			}
			s.init();
  		});
  	};
</script>
		<!-- 公共部分结束 -->
	</head>
	<body><div style='display:none'>
	String F_UNIT_ID = userBean.getUnit_id();<%=F_UNIT_ID%><br>
	String F_UNIT_NAME = userBean.getUnit_name();<%=F_UNIT_NAME%><br>
	String F_ORG_ID = userBean.getOrg_id();<%=F_ORG_ID%><br>
			String F_ORG_NAME = userBean.getOrg_name();<%=F_ORG_NAME%><br></div>
		<div>
			<table id="queryTable" width="100%" border="0" cellspacing="0"
				cellpadding="0" class="tabs_search_ctable_box">
				<tr>
					<td>
						<!-- 固定查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="tabs_search_ctable">
							<tr>
								<th class="input_cx_title_th" style="width: 80px;">
									档案年份：
								</th>
								<td width="120" class="cx_title_td">
									<input id="f_doc_year" name="f_doc_year" style="width: 120px;background:url(/xtbg/ccapp/oa/resources/style/blue/images/date_img_year.jpg) right 1px no-repeat;"
										class="date_120" type="text"
										onfocus="WdatePicker({dateFmt:'yyyy'})" />
								</td>
								<th style="width: 80px;" class="input_cx_title_th">
									所属部门：
								</th>
								<td width="100" class="cx_title_td">
									<input type="text" id="f_dept_name" name="f_dept_name"
										class="input_cx_title_283" style="width: 100px;" />
								</td>
								<th class="input_cx_title_th" style="width: 80px;">
									档案分类：
								</th>
								<td valign="top" width="120" class="cx_title_td">
									<input type="text" id="f_type_name" name="f_type_name"
										class="input_cx_title_283" style="width: 100px;" />
									<input type="hidden" id="f_type_id" name="f_type_id"
										class="input_cx_title_283" style="width: 100px;" />
								</td>
								<td width="120">
									<input value="统计" id="sel" type="button" onclick="search();"
										class="but_y_01" />
									<input value="重置" id="reset" type="button" class="but_y_01"
										onclick='cleara()' />
									<script>
		                            cleara = function(){
										$('#f_doc_year').val("");<%--档案年份--%>
										$('#f_dept_name').val("");<%--所属部门--%>
										$('#f_type_id').val("");<%--归档状态--%>
										$('#f_type_name').val("");<%--归档状态--%>
								        //查询
								        search();
								     }
		                            </script>
								</td>
							</tr>
						</table>
						<input type="hidden" name="F_TYPE_ID" id="F_TYPE_ID"
							value="<%=F_TYPE_ID%>" />
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