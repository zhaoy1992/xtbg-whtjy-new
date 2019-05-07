<%--
描述：档案管理-档案借阅申请流程表单页面
作者：邹拓
版本：1.0
日期：2013-7-31
UTF-8
参数列表
busiTypeCode
detailIds 借阅文档集合
dagly_id 被借阅文档管理员ID
busi_id
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.file.dao.imploracle.FileLendingDetailDaoImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String GET_LIST_CLASS="com.chinacreator.xtbg.core.file.list.FileLendingDetailOfUserSelfList";
	String F_USER_ID = accesscontroler.getUserID();
	UserCacheBean usercachebean=UserCache.getUserCacheBean(F_USER_ID);
	if(usercachebean==null){
    	usercachebean=new UserCacheBean();
    }
	String f_org_id=usercachebean.getUnit_id();
	String f_type_id = request.getParameter("f_type_id");
	//以选择项集合
	String detailIds = StringUtil.deNull(request.getParameter("detailIds"));
	String dagly_id = StringUtil.deNull(request.getParameter("dagly_id"));
	boolean canSelectDagly = true;//能否选择档案管理员
	if(!StringUtil.nullOrBlank(detailIds)&&!StringUtil.nullOrBlank(dagly_id)){
		canSelectDagly = false;
	}
	
	
	String userId = accesscontroler.getUserID();
	boolean canEdit = true;
	//档案管理员下拉框
	String sql = FileLendingDetailDaoImpl.getDAGLYWithJYL_sql;
	sql = sql.replaceAll("[{]f_lending_userid[}]", userId);
	String selectData = "";
	if(canSelectDagly){
		selectData = DictDropDownList.buildSelect(sql,"dagly_id","","",true,"","width:100%;");
	}else{
		selectData = DictDropDownList.buildSelect(sql,"dagly_id",dagly_id,"",true,"","width:100%;");
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- 引入jQuery -->
	<script src="../../resources/util/public.js" type="text/javascript"></script>
	<script type="text/javascript" src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- 引入formvValidatetion -->
	<script src="../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<!-- 引入jGrid -->
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	
	<script src="../../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	
	<script type="text/javascript">
	<%if(canSelectDagly){%>
		function initDaglySelect(){
			
		}
		clearSearch = function(){
        	jQuery("#dagly_id").val("");
        };
	<%}else{%>
		function initDaglySelect(){
			jQuery("#dagly_id").attr("disabled","disabled");
		}
		clearSearch = function(){};
	<%}%>
	
	$(function(){
		initDaglySelect();
		initTable();
	});
	</script>
</head>
<body style="overflow-x: auto;">
<div id="tabs1">
<input type="hidden" name="detailIds" id="detailIds" value="<%=detailIds%>"/>
<table width="800px;" id="table1">
    <tr>
        <td width="100%" align="left" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <th class="input_cx_title_th" style="width:100px;">档案管理员：</th>
                    <td class="cx_title_td" style="width:150px;">
                        <%=selectData%>
                    </td>
                    <td>
                    	<input value="搜索" type="button" onclick="refreshGrid(true)" class="but_y_01" />
                    	<input value="重置" type="button" onclick="clearSearch()" class="but_y_01" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>


<table width="100%" style="margin-left: 0;" >
	<tr>
		<td width="100%" align="left" valign="top">
			<div style="float:left;width:100%;margin-left: -10px;" class="cGridArea">
				<table id="gridTable"></table>
				<div id="gridPager"></div>
			</div>
		<script>
		/*
		函数:  addLevel
		说明:  确认按钮
		参数:   无
		返回值: 无
		*/
		var addLevel = function() {
			var selectedIds = jQuery("#gridTable").jqGrid("getGridParam", "selarrrow");
			var idsArrTemp = new Array();
			jQuery(selectedIds).each(function () {
				var model = jQuery("#gridTable").jqGrid('getRowData', this);
				if(!IsSpace(model.f_detail_id)){
					idsArrTemp.push(model.f_detail_id);
				}
			});
			ids = idsArrTemp.join();
			if (IsSpace(ids)) {
				alert("请选择要借阅的档案！");
			} else {
				var detailIds = jQuery("#detailIds").val();
				for (var i = 0; i < selectedIds.length; i++) {
					var model = jQuery("#gridTable").jqGrid('getRowData', selectedIds[i]);
					var detailId = model.f_detail_id;
					var f_doc_num = model.f_doc_num;
					var f_file_no = model.f_file_no;
					var f_doc_name = model.f_doc_name;
					var f_creator_time_str = model.f_creator_time_str;
					if (detailIds.indexOf(detailId) >= 0){
						continue;
					}else{
						getParentWindow("windowId").addOneRow(model);
					}
				}
				if(selectedIds.length!=0&& detailIds.length==0){
					getParentWindow("windowId").jQuery("[id=dayrow]").first().remove();
				}
				getParentWindow("windowId").focus();

				removeAlertWindows('windowId',true);
			}
		}
		/*
		 函数:  refreshGrid
		 说明:  静态加载列表数据，主要供子页面调用和删除字段后调用
		 参数:   无
		 */
		function refreshGrid() {
			var sdata = { //构建查询需要的参数 
				paramJson : toParamJosn()
			}; //获得当前postData选项的值  
			var postData = jQuery("#gridTable").jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
			jQuery.extend(postData, sdata);
			jQuery("#gridTable").jqGrid("setGridParam", {
				search : true
			// 将jqGrid的search选项设为true  
			}).trigger("reloadGrid", [ {
				page : 1
			} ]); //重新载入Grid表格，以使上述设置生效
		}
		function toParamJosn(){
			var f_doc_year = jQuery("#f_doc_year").val();
			var f_dept_name = jQuery("#f_dept_name").val();
			var f_doc_state = jQuery("#f_doc_state").val();
			var f_doc_name = jQuery("#f_doc_name").val();
			var f_doc_fontsize = jQuery("#f_doc_fontsize").val();
			var f_filesno = jQuery("#f_filesno").val();
			var str = "{'f_org_id':'<%=f_org_id%>','f_type_id':'<%=f_type_id%>'";
			str += ",'f_doc_year':'"+f_doc_year+"'";
			str += ",'f_dept_name':'"+f_dept_name+"'";
			str += ",'f_doc_state':'"+f_doc_state+"'";
			str += ",'f_doc_name':'"+f_doc_name+"'";
			str += ",'f_doc_fontsize':'"+f_doc_fontsize+"'";
			str += ",'f_filesno':'"+f_filesno+"'";
			str += ",'f_user_id':'<%=userId%>'";
			str += ",'out_side_detail_ids':'<%=detailIds%>'";
			if(jQuery("#dagly_id").val()){
				str += ",'dagly_id':'"+jQuery("#dagly_id").val()+"'";
			}else{
				str += ",'dagly_id':'dagly_id'";
			}//无档案管理员,不出现结果
			
			str += "}";
			return escape(str);
		}
	initTable=function(){
		jQuery("#gridTable").jqGrid({
			url: '<%= path %>' + '/pubListServlet?classNameId=<%=GET_LIST_CLASS%>',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
			//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
			datatype: "json",
			//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
			mtype: "POST",
			//定义使用哪种方法发起请求，GET或者POST
			height: "300",//270
			shrinkToFit:true,
			//Grid的高度，可以接受数字、%值、auto，默认值为150
			//width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
			//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
			autowidth: true,
			sortname : 'f_doc_num',
        	sortorder : 'asc',
			//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
			colModel : [
		        {
		            label : "件号",
		            name : 'f_doc_num',
		            index : 'f_doc_num',
		            editable : false,
		            width:50
		        }, {
		            label : "附件",
		            name : 'attach_num',
		            index : 'attach_num',
		            editable : false,
		            width:50
		        }, {
		            label : "编号",
		            name : 'f_doc_fontsize',
		            index : 'f_doc_fontsize',
		            editable : false,
		            width:80
		        },{
		            label : "文件标题",
		            name : 'f_doc_name',
		            index : 'f_doc_name',
		            editable : false,
		            width:200
		        }, {
		            label : "归档状态",
		            name : 'f_doc_state',
		            index : 'f_doc_state',
		            editable : false,
		            width:50
		        },{
		            label : "库存数量",
		            name : 'f_file_num',
		            index : 'f_file_num',
		            editable : false,
		            width:50      
		        },{
		            label : "所属部门",
		            name : 'f_dept_name',
		            index : 'f_dept_name',
		            editable : false,
		            width:80     
		        },{
		            label : "文件形成日期",
		            name : 'f_creator_time_str',
		            index : 'f_creator_time_str',
		            editable : false,
		            width:80       
		        },{
		            label : "f_doc_id",
		            name : 'f_doc_id',
		            index : 'f_doc_id',
		            hidden : true    
		        },{
		            label : "query_page",
		            name : 'query_page',
		            index : 'query_page',
		            hidden : true
		        },{
		            label : "f_detail_id",
		            name : 'f_detail_id',
		            index : 'f_detail_id',
		            hidden : true
		        },{
		            label : "f_file_no",
		            name : 'f_file_no',
		            index : 'f_file_no',
		            hidden : true
		        },{
		            label : "f_doc_media",
		            name : 'f_doc_media',
		            index : 'f_doc_media',
		            hidden : true
		        }
		    ],
			viewrecords: true,
			
			//设置是否在Pager Bar显示所有记录的总数。
			//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
			rowList: [10, 20, 30],
			//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
			gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
				
			},
			jsonReader: { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
				repeatitems: false
			},
			//pager: "#gridPager",
			pagerintoolbar:true,//上面的分页条
			pagerinBottombar:true,//下面的分页条
			//定义页码控制条Page Bar
			//caption: "草稿箱",
			//设置Grid表格的标题，如果未设置，则标题区域不显示。
			search : toParamJosn(),
			prmNames: { //这是一个数组，用于设置jqGrid将要向Server传递的参数名称
				rows: "rows",
				//表示请求行数的参数名称  
				sort: "sidx",
				//表示用于排序的列名的参数名称  
				order: "sord",
				//表示采用的排序方式的参数名称 
				search : "search"
			},
			multiselect: <%=canEdit%>,
			toolbar: [true,"top","<input id=\"JYSQ\" name=\"JYSQ\" value=\"选 择\" type=\"button\" onclick=\"addLevel()\" class=\"but_y_01\" />"+
				"<input id=\"Collect\" name=\"Collect\" value=\"关闭\" type=\"button\" onclick=\"removeAlertWindows('',true);\" class=\"but_y_01\" />"],
			onCellSelect:function(rowid,iCol){
				<%if(canEdit){%>
					if(iCol>0){
						var model = jQuery("#gridTable").jqGrid('getRowData', rowid);
						if(model.query_page){
							//openAlertWindows('updateFileDocDetailWindow', '<%=path%>/ccapp/oa/file/jsp/'+model.query_page+'?busi_id='+model.f_doc_id+'&busiTypeCode=wj-001&windowId=updateFileDocDetailWindow', '查看文件' ,1020,520,'10%','10%');
							
						}
					}
				<%}%>
			}
		}).navGrid('#gridPager', {
			edit: false,
			add: false,
			del: false,
			search:false,
			refresh:false
		});
		};
		</script>
		</td>
	</tr>
</table>
<form id="onlyFrom" name="onlyFrom" method="post" action="filefilesquerydo.jsp" target="filefilesquerylisthiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<input type='hidden' name='delete' id="hidden_delete"/>
</form>
<iframe name="filefilesquerylisthiddenFrame" width=0 height=0></iframe>
</div>
</body>
</html>