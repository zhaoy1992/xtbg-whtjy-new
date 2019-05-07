<%@page import="com.chinacreator.xtbg.core.common.util.DataControlUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.DictDropDownList"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%@page import="com.chinacreator.xtbg.core.file.util.FileUtil"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID();
	boolean adminOfficeManage= FileUtil.isRolesUser(user_id,"公文编号管理");
	//System.out.println("adminOfficeManage===="+adminOfficeManage);
	String GET_LIST_CLASS="com.chinacreator.xtbg.core.archive.list.WordArchiveList";
	String number_type =DataControlUtil.pageUnEscape(StringUtil.deNull(request.getParameter("name")));
	String number_year = StringUtil.deNull(request.getParameter("id"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- 引入jQuery -->
	<script src="../resources/util/public.js" type="text/javascript"></script>
	<script type="text/javascript" src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- 引入formvValidatetion -->
	<script src="../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script src="../resources/js/util/public.js" type="text/javascript"></script>
	<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<!-- 引入jGrid -->
	<script src="../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	
	<script src="../resources/plug/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<script>
	jQuery(function(){
		initTable();
	});
	</script>
</head>
<body style="overflow-x: auto;" onload="adaptationWH('_top','top',20);">
<div id="tabs1">
<table width="800px;" id="table1">
    <tr>
        <td width="100%" align="left" valign="_top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <th class="input_cx_title_th" style="width:100px;">公文标题：</th>
                    <td class="cx_title_td" >
                    	<input type="text" name="title" id="title" class="input_160" style="width: 138px;">
                    </td>
                    <th class="input_cx_title_th"></th>
					<td  class="cx_title_td">
					</td>
                </tr>
                <tr>
                 <th class="input_cx_title_th">起草日期：</th>
					<td  class="cx_title_td">
						<input class="date_120 Wdate" type="text" id="startSlTime" name="startSlTime" onFocus="var input_endtime=$dp.$('endSlTime');WdatePicker({onpicked:function(){endSlTime.focus();},dateFmt:'yyyy-MM-dd '})" />
							<span class="date_120_span">至</span>
						<input class="date_120 Wdate" type="text" id="endSlTime" name="endSlTime" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'startSlTime\')}',dateFmt:'yyyy-MM-dd '})" />
					</td>
					  
                </tr>
                <tr>
                 <th class="input_cx_title_th">
                 <input value="搜索" type="button" onclick="refreshGrid(true)" class="but_y_01" style="margin-left: 50px"/>
                 </th>
                	 <td>
                    	<input value="重置" type="button" onclick="clearSearch()" class="but_y_01" style="margin-left: 78px"/>
                    	<script>
                    	clearSearch = function(){
                    		jQuery("#title").val("");
                    		jQuery("#startSlTime").val("");
                    		jQuery("#endSlTime").val("");
                    		refreshGrid();
                    	};
                    	</script>
                    </td>
                </tr>
                
            </table>
        </td>
    </tr>
</table>


<table width="100%" style="margin-left: 0" >
	<tr>
		<td width="100%" align="left" valign="top">
			<%
					if(adminOfficeManage){%>
						<input id="JYSQ" name="JYSQ" value="新增纸质公文" type="button" onclick="addpaper()" class="but_y_03" /><span style="width:5px;display:block;float:left;">&nbsp;</span>
					<%}
			%>
			<input id="deletebtn" name="deletebtn" value="删除" type="button" onclick="deletePaper()" class="but_y_01" /><span style="width:5px;display:block;float:left;">&nbsp;</span>
		</td>
	</tr>
	<tr>
		<td width="100%" align="left" valign="top">
		<div style="float:left;width:100%;margin-left: -10px" class="cGridArea">
			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
		<script>
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
			var title = jQuery("#title").val();
			var startSlTime =  jQuery("#startSlTime").val();
			var endSlTime =  jQuery("#endSlTime").val();
			var str = "{'archive_title':'"+title+"'";
			str +=",'archive_date':'"+startSlTime+"'";
			str +=",'enddate':'"+endSlTime+"'";
			str +=",'number_type':'<%=number_type%>'";
			str +=",'number_year':'<%=number_year%>'";
			str += "}";
			return escape(str);
		}
		function addpaper(){
			if(''=='<%=number_year%>' || ''=='<%=number_type%>'){
				alert("请先选择具体字号！");
				return;
			}
			var number_type = "<%=number_type%>";
			var number_year="<%=number_year%>";
			openAlertWindows('windowId','<%=path %>/ccapp/oa/archive/papernumberadd.jsp?number_type='+_pub.lang.zwzm(number_type)+'&number_year='+number_year,'新增纸质公文',790,240,'25%','25%');
		}
		//删除文号
		function deletePaper(){
			if(''=='<%=number_year%>' || ''=='<%=number_type%>'){
				alert("请先选择具体字号！");
				return;
			}
			var number_type = "<%=number_type%>";
			var number_year="<%=number_year%>";
			var bus_ids = "";
			var number_codes = "";
			var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
			var idsArrTemp = new Array();
			var codeArrTemp = new Array();
			$(selectedIds).each(function () {
				var model = jQuery("#gridTable").jqGrid('getRowData', this);
				if(!IsSpace(model.busi_id)||!IsSpace(model.number_code)){
					idsArrTemp.push(model.busi_id);
					if(IsSpace(model.number_code)){
						codeArrTemp.push("null");	
					} else {
						codeArrTemp.push(model.number_code);
					}
				}
			});
			
			bus_ids = idsArrTemp.join();
			number_codes = codeArrTemp.join();
			if (IsSpace(bus_ids)&&IsSpace(number_codes)) {
				alert("请选择要删除的记录！");
			} else {
				var okF = function(){
					$("#bus_ids").val(bus_ids);
					$("#number_codes").val(number_codes);
					$("#number_type").val(number_type);
					$("#number_year").val(number_year);
					var fm = document.getElementById("delForm");
					fm.target = "hiddenFrame";
					fm.submit();
				}
				var p={
							headerText:'提示',
							okName:'确认',
					        okFunction:okF,
					        cancelName:'取消'
					};
				alert("确认后删除该条记录吗？",p)
			}
		}
		//删除后,执行完的刷新界面
		var afterSubmitFn= function(result){
			try{
				if(result.indexOf("delete")!=-1){
					alert(result.split(",")[1]);
					refreshGrid();
				}else{
					if(result.split(",").length>1){
							result = result.split(",");
							alert(result[0]);
							refreshGrid();
					} else {
						alert(result);
						refreshGrid();
					}
					
				}
			}catch(e){alert(e.description);}
		}
	initTable=function(){
		jQuery("#gridTable").jqGrid({
			url: '<%= path %>' + '/pubListServlet?classNameId=<%=GET_LIST_CLASS%>',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
			//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
			datatype: "json",
			//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
			mtype: "POST",
			//定义使用哪种方法发起请求，GET或者POST
			height: "100%",//270
			//Grid的高度，可以接受数字、%值、auto，默认值为150
			//width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
			//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
			autowidth: true,
			//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
	     //表头设置       
	        colModel : [ 
	        {
	            label : "busi_id",
	            name : 'busi_id',
	            index : 'busi_id',
	            hidden : true
	        }, {
	        	label : "公文标题",
	        	width:120,
	            name : 'archive_title',
	            index : 'archive_title'
	        }, {	
	            label : "编号",
	            width:50,
	            name : 'number_code',
	            index : 'number_code',
	            hidden: true
	        }, {	
	            label : "编号",
	            width:100,
	            name : 'number_title',
	            index : 'number_title'
	        }, {	
	            label : "申请人",
	            width:80,
	            name : 'archive_user',
	            index : 'archive_user'
	        }, {	
	            label : "起草时间",
	            name : 'archive_date',
	            width:100,
	            index : 'archive_date'
	        }, {	
	            label : "是否纸质",
	            width:50,
	            name : 'is_paper',
	            index : 'is_paper'
	        }
	        ],
	        sortname : 'archive_title',
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
			multiselect: true,
			toolbar: [true,"top"],
			/* "<input id=\"Collect\" name=\"Collect\" value=\"呈批件申请\" type=\"button\" onclick=\"\" class=\"but_y_01\" />" */
			onCellSelect:function(rowid,iCol){
					if(iCol>0){
						
					}
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
</div>
<form id="delForm" name="delForm" method="post" action="papernumberdo.jsp">
	<input type="hidden" name="bus_ids" id="bus_ids"/>
	<input type="hidden" name="number_codes" id="number_codes"/>
	<input type="hidden" name="number_type" id="number_type"/>
	<input type="hidden" name="number_year" id="number_year"/>
	<input type="hidden" name="action" value="deleteInfo"/>
</form>

<iframe name="hiddenFrame" width=0 height=0></iframe>
</body>
</html>