<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.file.entity.FileTypeBean"%>
<%@page import="java.util.Map"%>
<%@page import="com.chinacreator.xtbg.core.file.service.FileTypeServiceIfc"%>
<%@page import="com.chinacreator.xtbg.core.file.service.impl.FileTypeServiceImpl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%   
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	String tree_id = request.getParameter("id"); //图书类型ID 
	String tree_name = java.net.URLDecoder.decode(StringUtil.deNull(request.getParameter("name")),"UTF-8"); //类型名称
	String tree_type_code = java.net.URLDecoder.decode(StringUtil.deNull(request.getParameter("tree_type_code")),"UTF-8");//图书编号的分类代码
	String tree_type_no = request.getParameter("tree_type_no"); //图书编号的分类代码
	
	String unit_id = userBean.getUnit_id();  //单位ID
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- 引入jQuery -->
	<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- 引入jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- 引入formvValidatetion -->
	<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- 引入其它 -->
	<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<!-- 引入jGrid -->
	<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
	
	<!--  引入时间控件 -->
	<script src="../../../resources/plug/My97DatePicker/WdatePicker.js"	type="text/javascript"></script>
</head>
<body style="overflow-x: auto;">
<script>
$(function(){
	initTable();
});
/**
搜索函数
*/
function search() {
	var sdata = { //构建查询需要的参数 
		paramJson : toParamJosn()
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

function btnClickFn(){
	var tree_id = "<%=tree_id%>";
	var tree_name = "<%=tree_name%>";
	var tree_type_code = "<%=tree_type_code%>";
	var tree_type_no = "<%=tree_type_no%>";
	//openWindows('treetypeadd','新增图书','../../../caizhengting/ibrary/jsp/ibrarybookinfo.jsp?subid=bookadd&tree_id='+tree_id,false,window);
	var url = '../../../caizhengting/ibrary/jsp/ibrarybookinfo.jsp?subid=bookadd&tree_id='+tree_id+'&tree_name='+encodeURI(encodeURI(tree_name))+"&tree_type_code="+encodeURI(encodeURI(tree_type_code))+"&tree_type_no="+tree_type_no;
	openWindows('bookadd','修改图书信息',url,'bookadd',false,window);
}
var docopy = function(){
	 var book_id = "";
	 var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	 var count = selectedIds.length;
	 if(count==1){
		jQuery(selectedIds).each(function () {
			model = jQuery("#gridTable").jqGrid('getRowData', this);
			if(!IsSpace(model.book_id)){
				book_id=model.book_id;
			}
		});
		jQuery("#book_id").val(book_id);
		jQuery("#actiontype").val("copy");
		var fm = document.getElementById("form1");
		fm.target = "filetypelisthiddenFrame";
		fm.submit();
     }else{
        alert("请选择一条数据进行复制!");
        return;
     }
}
var delCarInfo = function(){
	 var ids = "";
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		for ( var i = 0; i < selectedIds.length; i++) {
			var model = jQuery("#gridTable").jqGrid('getRowData',selectedIds[i]);
			if ("" != ids) {
				ids += ",";
			}
			ids += "'" + model.book_id + "'";
		}
		if (IsSpace(ids)) {
			alert("请选择要删除的记录！");
		} else {
			if(checkHavaNo(ids)){  //存在未归还的图书
				alert("存在未归还的图书无法删除！");
			}else{
				var okF = function(){
					jQuery("#book_id").val(ids);
					jQuery("#actiontype").val("del");
					var fm = document.getElementById("form1");
					fm.target = "filetypelisthiddenFrame";
					fm.submit();
				}
				var p={
						headerText:'提示',
						okName:'确认',
					    okFunction:okF,
					    cancelName:'取消'
					};
				alert('确定要删除吗？',p)
			}
		}
}

//检查是否存在未归还的图书
function checkHavaNo(book_id){
	var url = "<%=path %>/ccapp/xtbg/caizhengting/ibrary/jsp/getregbookbybookidajax.jsp";
    
	var falg = true;
	
	var number;
	
	var params = {osappitem:book_id};
	jQuery.ajax({
		async:false,
		url: url,
		type: 'POST',
		dataType: 'json',
		data: params,
		success: function(data){
			if(data.length>0){
				number = parseFloat(data);
			}else{
				number = 0;
			}
			if(number <= 0){
				falg = false;
			}
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert(jqXHR);
			alert(textStatus);
			alert(errorThrown);
		}
	});
	return falg;
}

var updateactuvuty = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var url = "<%=path%>/ccapp/xtbg/caizhengting/ibrary/jsp/ibrarybookinfo.jsp?subid=addinformation&action=update&book_id="+model.book_id;
	//openWindows('addinformation','新增图书',url,false,window);
	openWindows('addinformation','修改图书信息',url,'addinformation',false,window);
	//location.href = url;
}

var exportexcel = function(){
	var title = ""
	var paramHead = "";
	var columnWidth = "";
	var sql = "";
	
	var tree_id = descape("<%=tree_id%>");
	var book_name = descape($("#book_name").val());
	var book_no = descape($("#book_no").val());
	var book_pressname = descape($("#book_pressname").val());
	var booker_start_time = descape($("#booker_start_time").val());
	var booker_end_time = descape($("#booker_end_time").val());
	var remark = descape($("#remark").val());
	var book_author = descape($("#book_author").val());
	var unit_id = descape("<%=unit_id%>");
	
	title = "图书查询表";
	paramHead = "图书名称,图书编号,分类,作者,出版社名称,出版号,版次,出版日期,页数,价格(元),库存状态,登记人,登记时间,登记部门,内容说明";
	columnWidth = "7000,4000,7000,4000,7000,4000,7000,7000,7000,4000,7000,7000,5000,5000";
	sql +=" select book_name, book_no,"
	sql +=" (SELECT distinct REPLACE(REPLACE(to_char(wm_concat('!@#$%^&*()'||t1.tree_name) over(partition by '' order by level desc rows between unbounded preceding and unbounded  following)),',!@#$%^&*()','/'),'!@#$%^&*()','')  FROM CZT_IBRARYTREE t1  START WITH tree_id = t.tree_id  CONNECT BY PRIOR tree_parent_id = tree_id) tree_name,";
	sql +=" book_author, book_pressname, book_pressno,book_pressbunver, to_char(book_pressdate,'yyyy-MM-dd') book_pressdate,";
	sql +=" book_page, book_price, decode(book_state,'0','在库','1','已借出') book_state, t1.user_realname, to_char(booker_date,'yyyy-MM-dd hh24:mi:ss') booker_date, t2.org_name, remark from czt_ibrary_bookinfo t ";
	sql +=" left join td_sm_user t1 on t1.user_id = t.booker_id ";
	sql +=" left join td_sm_organization t2 on t2.org_id = t.booker_dept_id ";
	sql +=" where 1=1 ";
	if(!IsSpace(tree_id)){
		sql +=" and t.tree_id in (select tree_id from CZT_IBRARYTREE START WITH tree_id = '"+tree_id+"' CONNECT BY prior tree_id = tree_parent_id)";
	}
	if(!IsSpace(book_name)){
		sql +="   and t.book_name like '%"+book_name+"%'";
	}
	if(!IsSpace(book_no)){
		sql +="   and t.book_no like '%"+book_no+"%'";
	}
	if(!IsSpace(book_pressname)){
		sql +="   and t.book_pressname like '%"+book_pressname+"%'";
	}
	if(!IsSpace(booker_start_time)){
		sql +="   and t.booker_date >=to_date('"+booker_start_time+"','yyyy-MM-dd hh24:mi')";
	}
	if(!IsSpace(booker_end_time)){
		sql +="   and t.booker_date <=to_date('"+booker_end_time+"','yyyy-MM-dd hh24:mi')";
	}
	if(!IsSpace(remark)){
		sql +="   and t.remark like '%"+remark+"%'";
	}
	if(!IsSpace(book_author)){
		sql +="   and t.book_author like '%"+book_author+"%'";
	}
	if(!IsSpace(unit_id)){
		sql +="   and t.booker_dept_id = '"+unit_id+"'";
	}
	sql +=" order  by booker_date desc ";
	$("#sql").val(encodeURI(descape(sql)));
	$("#paramHead").val(encodeURI(descape(paramHead)));
	$("#title").val(encodeURI(descape(title)));
	$("#columnWidth").val(columnWidth);
	var fm = document.getElementById("excelForm");
	fm.target = "hiddenFrame";
	fm.submit();
}

/**
重置
*/
function reset(){
	$("#book_name").val("");
	$("#remark").val("");
	$("#booker_start_time").val("");
	$("#booker_end_time").val("");
	$("#book_no").val("");
	$("#book_pressname").val("");
	$("#book_author").val("");
	search();
}

function checktime(){
	var booker_start_time = jQuery("#booker_start_time").val();//开始时间
	var booker_end_time = jQuery("#booker_end_time").val();//结束时间
	if(booker_start_time != "" && booker_end_time != ""){
		var start_time = booker_start_time;//开始时间
		start_time = start_time.replace(/-/g,"/");
		start_time = new Date(start_time);
		
		var end_time = booker_end_time;//结束时间
		end_time = end_time.replace(/-/g,"/");
		end_time = new Date(end_time);
		if(start_time>end_time){
			 alert('开始时间大于结束时间，请重新选择');
		}
	}
}
</script>
<%--query table end--%>
<table width="100%" style="margin-left: 0" class="tabs_search_ctable_box">
<tr>
				<td>
								<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
					<tr>
						<td>
							<!-- 固定查询 -->
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
								<tr>
									<th width="90" class="input_cx_title_th" >图书名称：</th>
									<td width="296"  class="cx_title_td">
									<input name="book_name" id="book_name" type="text" class="input_cx_title_283" /></td>
									<td width="385"  colspan="4"  >
									<input name="search" value="搜索" type="button" 
									onclick="search()" class="but_y_01"/>
									<input name="reset" value="重置" type="button" 
									onclick="reset()" class="but_y_01"/>
									<span id="selAreaImg" class="all_search_condition">
									<a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >更多搜索条件
									</a></span></td>
								</tr>
							</table>
							<!-- 固定查询 end-->
						</td>
					</tr>
					
					<tr><td>
					<!-- 隐藏查询 -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" id="hiddenArea" style="display:none;margin-left: 3px;">
							<tr>
								<th width="90" class="input_cx_title_th" >图书编号：</th>
								<td width="296"  class="cx_title_td">
									<input name="book_no" id="book_no" type="text" class="input_cx_title_283" />
								</td>
								<th width="90" class="input_cx_title_th" >内容：</th>
								<td width="296"  class="cx_title_td">
									<input name="remark" id="remark" type="text" class="input_cx_title_283" />
								</td>
							</tr>
							<tr>
								<th  class="input_cx_title_th" >
									登记时间：
								</th>
								<td class="cx_title_td">
									<input type="text" class="validate[required] date_187" style="width:131px;"
										id="booker_start_time" name="booker_start_time" onchange="checktime()"
										onfocus="WdatePicker({onpicked:function(){booker_end_time.focus();},dateFmt:'yyyy-MM-dd'})" />
										<span class="date_120_span">至</span>
									<input type="text" class="validate[required] date_187" style="width:130px;"
											id="booker_end_time" name="booker_end_time" onchange="checktime()"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
								</td>
								<th width="90" class="input_cx_title_th" >作者：</th>
								<td width="296"  class="cx_title_td">
									<input name="book_author" id="book_author" type="text" class="input_cx_title_283" />
								</td>
							</tr>
						</table>
						<!-- 隐藏查询 end-->
				</td></tr>
			</table>
		<!-- 查询条件选区    tabs_search_ctable(查询table样式) -->
				</td>
			</tr>
	<tr>
		<td width="100%" align="left" valign="top">
		<div style="float:left;width:100%;margin-left: -10px" class="cGridArea">
			<table id="gridTable"></table>
			<div id="gridPager"></div>
		</div>
		<script>
		function toParamJosn(){
			var book_name = $("#book_name").val();
			var remark = $("#remark").val();
			var booker_start_time = $("#booker_start_time").val();
			var booker_end_time = $("#booker_end_time").val();
			var book_no = $("#book_no").val();
			var book_pressname = $("#book_pressname").val();
			var book_author = $("#book_author").val();
			var str = "{'tree_id':'<%=tree_id%>','book_name':'"+book_name
			+"','remark':'"+remark
			+"','booker_dept_id':'<%=unit_id%>'"
			+",'booker_start_time':'"+booker_start_time
			+"','booker_end_time':'"+booker_end_time
			+"','book_no':'"+book_no
			+"','book_author':'"+book_author+"'}";
			return descape(escape(str));
		}
		$(document).keydown(function(){
			if(event.keyCode == 13){
			   search();
			}
		});
		initTable = function (){
		$("#gridTable").jqGrid({
			url: '<%= path %>' + '/commonListServlet?classNameId=czt_ibraryBookInfoList',  //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
			//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
			datatype: "json",
			//这个参数用于设定将要得到的数据类型。我最常用的是“json”，其余的类型还包括：xml、xmlstring、local、javascript、function
			mtype: "POST",
			pageCached:false,
			//定义使用哪种方法发起请求，GET或者POST
			height: "100%",//270
			//Grid的高度，可以接受数字、%值、auto，默认值为150
			//width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
			//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
			autowidth: true,
			//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
			colNames: ['book_id','图书名称','图书编号','有效状态','装订特征','所属类别id','所属类别','登记时间','数量'],
			//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
			colModel: [ //最重要的数组之一，用于设定各列的参数
		        {
		        	name: 'book_id',index: 'book_id',width: '180',sortable:false,hidden:true
				},
				{
					name: 'book_name',index: 'book_name',width: '60',sortable:true
				},
				{
					name: 'book_no',index: 'book_no',width: '30',sortable:true
				},
				{
					name: 'validstate',index: 'validstate',width: '20',sortable:true
				},
				{
					name: 'zdtz',index: 'zdtz',width: '40',sortable:true
				},
				{
					name: 'tree_id',index: 'tree_id',width: '150',sortable:false,hidden:true
				},
				{
					name: 'tree_name',index: 'tree_name',width: '40',sortable:true
				},
				{
					name: 'booker_date',index: 'booker_date',width: '40',sortable:true
				},
				{
					name: 'book_number',index: 'book_number',width: '25',sortable:true
				}
			],
			viewrecords: true,
			
			//设置是否在Pager Bar显示所有记录的总数。
			rowNum: 10,
			//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
			rowList: [10, 20, 30],
			//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
			gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
				$(".t_taoobar_content_left").css("width","420px");
				
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
			toolbar: [true,"top","<input type='button' class='but_y_01' value='新增' onclick='btnClickFn();'/>"
			+"<input type='button' class='but_y_01' value='删除' onclick='delCarInfo();'/>"
			+"<input type='button' class='but_y_01' value='复制' onclick='docopy()'/>"
			+"<input class='but_y_01' id='exprot' value='导出' type='button' onclick='exportexcel()'/>"
			+"<input class='but_y_01' id='import' value='导入' type='button' onclick='importExcel()'/>"],
			multiselect: true,
			
			onCellSelect:function(rowid,iCol){
				if(iCol != 0)
				{
					updateactuvuty(rowid);
				}
			}
		}).navGrid('#gridPager', {
			edit: false,
			add: false,
			del: false,
			search:false,
			refresh:false
		});};
		
		
		/*
		函数:  importExcel
		说明:  导入Excel表格
		参数:   无
		返回值: 无
		*/
		var importExcel = function(){
			var title = descape(escape('图书资料信息')); //转码,避免中文传输乱码
			var remark = descape(escape('注意:分类不存在的将不会导入!')); //转码,避免中文传输乱码
			var url = '${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/excelimport.jsp?excelImplClass=ibraryBookInfoDaoExcelImpl&excelTemplateFilePath=ibrary_excelTemplateFilePath&title='+title+'&remark='+remark;
			openAlertWindows('windowId',url,
				    '导入excel表格', '455px', '70%', '10%', '40%', function() {
					location.reload();
		    });
		}		
		</script>
		</td>
	</tr>
</table>
<form id="form1" name="form1" method="post" action="ibrarybookinfoDo.jsp" target="filetypelisthiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<input type='hidden' name='book_id' id="book_id"/>
<input type='hidden' name='actiontype' id="actiontype"/>
</form>

<form id="excelForm" name="paramForm" method="post"	action="../../../public/util/jsp/expexcel.jsp">
		<input type="hidden" name="sql" id="sql" /> 
		<input type="hidden" name="paramHead" id="paramHead" /> 
		<input type="hidden" name="title" id="title" /> 
		<input type="hidden" name="columnWidth" id="columnWidth" />
</form>
<iframe name="hiddenFrame" width=0 height=0></iframe>
<iframe name="filetypelisthiddenFrame" width=0 height=0></iframe>
</body>
</html>