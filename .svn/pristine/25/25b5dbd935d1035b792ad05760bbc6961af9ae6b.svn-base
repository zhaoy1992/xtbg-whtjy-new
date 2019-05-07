<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="com.chinacreator.xtbg.pub.util.DaoImplClassUtil"%>
<%@page import="com.chinacreator.xtbg.pub.util.StringUtil"%>
<%@page import="com.chinacreator.business.common.tools.CacheCommonManage"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String userid = accesscontroler.getUserID();
	String username = accesscontroler.getUserName();
	String waittotal=request.getParameter("waittotal");
	String userArea=CacheCommonManage.getInstance().getSystemParam("CURSYSTEMCODE");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.ldap.AuthRole"%><html>
<!-- 引入jQuery -->
<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
<!-- 引入jGrid -->
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js" type="text/javascript" charset="utf-8" ></script>
<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<!-- 引入其它 -->
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>

<!--公共部分结束  -->

<head>
<script type="text/javascript">
//记录刷新jqgrid刷新次数
var num=1;
$(function() {
	$("#gridTable").jqGrid({
		url: '<%=path%>' + '/commonListServlet?classNameId=commonToDoWorkList', //commonListServlet列表公共的servlet,classNameId在servletBean.xml文件中配置要调用的类,isPage:是否翻页(true,false),默认为true
					//jqGrid控件通过这个参数得到需要显示的数据，具体的返回值可以使XML也可以是Json
					datatype : "json",
					//这个参数用于设定将要得到的数据类型。我最常用的是"json"，其余的类型还包括：xml、xmlstring、local、javascript、function
					mtype : "POST",
					//定义使用哪种方法发起请求，GET或者POST
					height : "100%",//270
					//Grid的高度，可以接受数字、%值、auto，默认值为150
					//width ：800, //Grid的宽度，如果未设置，则宽度应为所有列宽的之和；如果设置了宽度，则每列的宽度将会根据shrinkToFit选项的设置，进行设置。
					//shrinkToFit ：true 此选项用于根据width计算每列宽度的算法。默认值为true。如果shrinkToFit为true且设置了width值，则每列宽度会根据width成比例缩放；如果shrinkToFit为false且设置了width值，则每列的宽度不会成比例缩放，而是保持原有设置，而Grid将会有水平滚动条
					autowidth : true,
					//默认值为false。如果设为true，则Grid的宽度会根据父容器的宽度自动重算。重算仅发生在Grid初始化的阶段；如果当父容器尺寸变化了，同时也需要变化Grid的尺寸的话，则需要在自己的代码中调用setGridWidth方法来完成。
					colNames : [ '机构id','类型', '工作名称','发起人/部门','发起时间','状态','会议接收回复状态','fk_id','m_check_flag_name','m_check_flag','m_reg_user_id','m_check_flag','m_close_time','m_is_need_signup'],
					//字符串数组，用于指定各列的题头文本，与列的顺序是对应的。
					colModel : [ //最重要的数组之一，用于设定各列的参数
					{
						name : 'pri_id',
						index : 'pri_id',
						hidden : true
					}, {
						name : 'info_type',
						index : 'info_type',
						width : '20',
						search : true
					}, {
						name : 'work_name',
						index : 'work_name',
						width : '100',
						search : true
					},{
						name : 'input_user',
						index : 'input_user',
						width : '20',
						search : true
					},{
						name : 'start_time',
						index : 'start_time',
						width : '30',
						search : true
					},
					{
						name : 'info_state',
						index : 'info_state',
						hidden : true
					},{
						name : 'notice_state',
						index : 'notice_state',
						hidden : true
					},
					{
						name : 'fk_id',
						index : 'fk_id',
						hidden : true
					}
					,
					{
						name : 'm_check_flag_name',
						index : 'm_check_flag_name',
						hidden : true
					}
					,
					{
						name : 'm_check_flag',
						index : 'm_check_flag',
						hidden : true
					}
					,
					{
						name : 'm_reg_user_id',
						index : 'm_reg_user_id',
						hidden : true
					}
					,
					{
						name : 'm_reg_user_name',
						index : 'm_reg_user_name',
						hidden : true
					}
					,
					{
						name : 'm_close_time',
						index : 'm_close_time',
						hidden : true
					}
					,
					{
						name : 'm_is_need_signup',
						index : 'm_is_need_signup',
						hidden : true
					}
					],
					sortname : 'start_time',
					//指定默认的排序列，可以是列名也可以是数字。此参数会在被传递到Server端。
					sortorder : 'desc',
					viewrecords : true,

					//设置是否在Pager Bar显示所有记录的总数。
					rowNum : 10,
					//用于设置Grid中一次显示的行数，默认值为20。正是这个选项将参数rows（prmNames中设置的）通过url选项设置的链接传递到Server。注意如果Server返回的数据行数超过了rowNum的设定，则Grid也只显示rowNum设定的行数。
					rowList : [ 10, 20, 30 ],
					//一个数组，用于设置Grid可以接受的rowNum值。例如[10,20,30]
					gridComplete : function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
						// alert(idss);
						var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
						for ( var i = 0; i < ids.length; i++) {
							var cl = ids[i];
						}
						if(1==num){
							parent.window.countTotaltRead($("#gridTable").jqGrid('getGridParam','records'));
						}
						num++;
					},
					jsonReader : { //这又是一个数组，用来设定如何解析从Server端发回来的json数据
						repeatitems : false
					},
					//pager : "#gridPager",
					pagerintoolbar:true,//上面的分页条
					pagerinBottombar:true,//下面的分页条
					//定义页码控制条Page Bar
					//设置Grid表格的标题，如果未设置，则标题区域不显示。
					search : toUserParamJosn(),
					filterNames:["info_type"],
					filterOptions:[[["--请选择--","--请选择--"],["公告查看","公告查看"],["会议通知查看","会议通知查看"],["信息报送","信息报送"],["电子邮件","电子邮件"],["交办的任务","交办的任务"],["我的任务","我的任务"],["传阅文件","传阅文件"]]],//alue text 后的值与显不
					filterOptionsDefValue:[0],
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
					multiselect : false,
					onCellSelect:function(id,iCol){
						if(iCol != 0 )
						{	
							showDetailInfo(id);
						}
					}
				}).navGrid('#gridPager', {
			edit : false,
			add : false,
			del : false,
			search:false,
			refresh: false 
		});
	//操作按钮区  cOprArea(操作区样式)
	/** 
	$("#t_gridTable").append("<div>")
							.append("<input type='button' id='export' class='cButton_statistics'  onclick='exportFile()' />")
				 .append("</div>");
	*/
		
	});
	/*
	 colModel的重要选项

	 和jqGrid一样colModel也有许多非常重要的选项，在使用搜索、排序等方面都会用到。这里先只说说最基本的。

	 name ：为Grid中的每个列设置唯一的名称，这是一个必需选项，其中保留字包括subgrid、cb、rn。
	 index ：设置排序时所使用的索引名称，这个index名称会作为sidx参数（prmNames中设置的）传递到Server。
	 label ：当jqGrid的colNames选项数组为空时，为各列指定题头。如果colNames和此项都为空时，则name选项值会成为题头。
	 width ：设置列的宽度，目前只能接受以px为单位的数值，默认为150。
	 sortable ：设置该列是否可以排序，默认为true。
	 search ：设置该列是否可以被列为搜索条件，默认为true。
	 resizable ：设置列是否可以变更尺寸，默认为true。
	 hidden ：设置此列初始化时是否为隐藏状态，默认为false。
	 formatter ：预设类型或用来格式化该列的自定义函数名。常用预设格式有：integer、date、currency、number等
	
	 资料:http://www.trirand.com/jqgridwiki/doku.php?id=wiki:common_rules
	 */

	/*
	 函数:  toUserParamJosn
	 说明:  构建要查询的参数
	 参数:   无
	 返回值: 返回要查询的参数
	 */

	var toUserParamJosn = function() { 
		var str = "{'listtype':'waitingread','inputuser_id':'<%=userid%>'}";

		return descape(descape(escape(str)));
	}

	/*
	 函数:  userSearch
	 说明:  查询用户信息
	 参数:   无
	 返回值: 用户列表
	 */
	var userSearch = function() {
		var type = "#gridTable";
		var sdata = { //构建查询需要的参数 
			paramJson : toUserParamJosn()
		}; //获得当前postData选项的值  

		var postData = $(type).jqGrid("getGridParam", "postData"); //将查询参数融入postData选项对象  
		$.extend(postData, sdata);
		$(type).jqGrid("setGridParam", {
			search : true
			// 将jqGrid的search选项设为true  
		}).trigger("reloadGrid", [ {
			page : 1
		}]); //重新载入Grid表格，以使上述设置生效 
		
	}
	var showDetailInfo = function(id){
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
		var url = "";
		if("会议通知查看" == model.info_type){
			 openWindows('sub_main_view','查看等待阅读信息','<%=path%>/ccapp/oa/meeting/jsp/meetingnoticeview.jsp?windowId=sub_main_view&issaved=doview&m_notice_id='+model.pri_id+'&m_check_flag='+model.m_check_flag+'&m_check_flag_name='+model.m_check_flag_name+'&m_receiver_id='+model.fk_id+'&m_reg_user_id='+model.m_reg_user_id+'&m_reg_user_name='+model.m_reg_user_name+'&m_close_time='+model.m_close_time+'&m_is_need_signup='+model.m_is_need_signup,'sub_main_todowork',false,window,true,true);	
		}else if("公告查看" == model.info_type){
			 openWindows('sub_main_view','查看等待阅读信息','<%=path%>/ccapp/oa/notice/jsp/noticeview.jsp?isview=view&n_notice_id='+ model.pri_id+'&n_receiverid='+model.fk_id+'&subid=sub_main_view&urls=jsy','sub_main_todowork',false,window,true,true);	
		}else if("信息报送" == model.info_type){
			openWindows('sub_main_viewreadinfos','查看等待阅读信息','<%=path%>/ccapp/xtbg/zhangjiajie/inforeported/jsp/inforeportdetailview.jsp?submittedinfoId='+model.pri_id+'&state=7&operwindowid=sub_main_viewreadinfos','sub_main_todowork',false,window,false,true);	
		}else if("电子邮件" == model.info_type){
			openWindows('sub_main_view','查看等待阅读信息','<%=path%>/ccapp/xtbg/yimingju/mail/jsp/mailInfo.jsp?mid='+model.pri_id+'&isread=yees&back=re&subid=sub_main_view','sub_main_todowork',false,window,true,true);	
		}else if("交办的任务" == model.info_type){
			openWindows('sub_main_view','查看等待阅读信息','<%=path%>/ccapp/oa/task/jsp/addtasks.jsp?id='+model.pri_id+'&status=2&windowId=sub_main_view','sub_main_todowork',false,window,true,true);	
		}else if("我的任务" == model.info_type){
			openWindows('sub_main_view','查看等待阅读信息','<%=path%>/ccapp/oa/task/jsp/taskview.jsp?id='+model.pri_id+'&status='+model.m_check_flag+'&windowId=sub_main_view','sub_main_todowork',false,window,true,true);	
		}else if("传阅文件" == model.info_type){
			//流程类型
			var busitype_code = model.m_check_flag;
			var action_form = model.m_check_flag_name;
			var ins_id = model.m_is_need_signup;
			var busi_id = model.fk_id;
			var circularize_id = model.pri_id;
			if(busitype_code=="uuid-1103"){
				url = '<%=path %>' + action_form + "?ins_id="+ins_id+"&busi_id="+busi_id+"&list_type=worklis&operType=yiban&act_name=&actiontype_code=04&busiTypeCode="+busitype_code
				  +"&template_id="+model.template_id+"&Template=word"+model.template_id+"&circularize_id="+circularize_id;
				title = "签呈";
			} else {
				url = '<%=path %>' + "/ccapp/oa/archive/showWordConext.jsp?ins_id="+ins_id+"&busi_id="+busi_id+"&list_type=worklis&operType=yiban&act_name=&actiontype_code=04&busiTypeCode="+busitype_code
				  +"&template_id=&Template=word&circularize_id="+circularize_id;
				title = model.work_name;
			}
			var width = jQuery(window.top).width();//界面宽度
		    var height = jQuery(window.top).height();//界面高度
			url= url+"&height="+height+"&width="+width;
			url= url+"&windowsId=sub_main_view"
			openAlertWindows('sub_main_view',url,title,width,height-86,86,'0',windowBack,'',true);
		}
	}
	/*
	 函数:  windowBack
	 说明:  等待阅读 传阅类型的界面关闭返回函数 用于刷新等待阅读列表界面
	 参数:   无
	 返回值: 
	 */
function windowBack(){
	var obj = window.top.findPageCacheName("sub_main_view");
	obj.superwindow.location.reload();
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>等待阅读</title>
</head>
<body>
	<!-- 查询列表区 cGridArea(查询区样式)-->
	<div style="height: 50px">
	<div class="cGridArea" id="div_tab1">
		<table id="gridTable"></table>
		<div id="gridPager"></div>
	</div>
	</div>
</body>
</html>