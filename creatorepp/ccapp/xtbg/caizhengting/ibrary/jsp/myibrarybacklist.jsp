<%--
�������ҵĽ����鼮�ѽ��Ľ���
���ߣ�ͯ��
�汾��1.0
���ڣ�2014-03-22  
--%>

<%@page import="com.chinacreator.xtbg.core.common.util.DateUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.chinacreator.security.AccessControl"%>
<%@page import="com.chinacreator.xtbg.core.common.util.StringUtil"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.entity.UserCacheBean"%>
<%@page import="com.chinacreator.xtbg.core.common.cache.UserCache"%>
<%
	String path = request.getContextPath();
	AccessControl accesscontroler = AccessControl.getAccessControl();
	accesscontroler.checkAccess(request, response);
	String user_id = accesscontroler.getUserID();//�û�id
	
	String org_id = accesscontroler.getChargeOrgId();
	UserCacheBean userBean= UserCache.getUserCacheBean(accesscontroler.getUserID());
	String dept_id = userBean.getUnit_id();
	
	
	String tree_id = request.getParameter("id"); //ͼ������ID 
	
	String nowDateString = DateUtil.getCurrentDate();                    //��ǰ����
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk">
	<title></title>
	<!-- ����jQuery -->
	<script type="text/javascript" src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-1.7.1.min.js"></script>
	<!-- ����jQuery UI -->
	<link id="uiThemes" rel="stylesheet" type="text/css" media="screen" href="../../../resources/plug/jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
	<script src="../../../resources/plug/jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
	<!-- ����formvValidatetion -->
	<script src="../../../resources/plug/formvalidation/jquery.validationEngine-cn.js" type="text/javascript" charset="utf-8"></script>
	<script src="../../../resources/plug/formvalidation/jquery.validationEngine.js" type="text/javascript" charset="utf-8"></script>
	<!-- �������� -->
	<script src="../../../resources/js/util/public.js" type="text/javascript"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-alert.1.1.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-min.1.1.js"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-ui-ztree.1.1.js" charset="utf-8"></script>
	<script type="text/javascript" src="../../../resources/plug/ifrom/js/ifrom-tools.1.1.js" charset="utf-8"></script>
	<!-- ����jGrid -->
	<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"  charset="utf-8" type="text/javascript"></script>
	<script src="../../../resources/plug/jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"  charset="utf-8" type="text/javascript"></script>
		<!--  ����ʱ��ؼ� -->
	<script src="../../../resources/plug/My97DatePicker/WdatePicker.js"	type="text/javascript"></script>
</head>
<body style="overflow-x: auto;">
<script>
$(function(){
	initTable();
});
/*
 ����:  search
 ����:   ��
 */
function search() {
	var sdata = { //������ѯ��Ҫ�Ĳ��� 
		paramJson : toParamJosn()
	}; //��õ�ǰpostDataѡ���ֵ  
	var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //����ѯ��������postDataѡ�����  
	$.extend(postData, sdata);
	$("#gridTable").jqGrid("setGridParam", {
		search : true
	// ��jqGrid��searchѡ����Ϊtrue  
	}).trigger("reloadGrid", [ {
		page : 1
	} ]); //��������Grid�����ʹ����������Ч
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
			alert("��ѡ��Ҫɾ���ļ�¼��");
		} else {
			var okF = function(){
				jQuery("#book_id").val(ids);
				jQuery("#actiontype").val("del");
				var fm = document.getElementById("form1");
				fm.target = "filetypelisthiddenFrame";
				fm.submit();
			}
			var p={
					headerText:'��ʾ',
					okName:'ȷ��',
				    okFunction:okF,
				    cancelName:'ȡ��'
				};
			alert('ȷ��Ҫɾ����',p)
		}
}

var updateactuvuty = function(id) {
	var model = jQuery("#gridTable").jqGrid('getRowData', id);
	var url = "<%=path%>/ccapp/xtbg/caizhengting/ibrary/jsp/ibraryborrowadd.jsp?subid=queryinfo&t_regb_id="+model.t_regb_id+"&sqtype="+model.t_regb_sqtype;
	openWindows('queryinfo','ͼ��������Ϣ',url,'queryinfo',false,window);
	//location.href = url;
}

function reset(){
	$("#jy_start_time").val("");//���Ŀ�ʼʱ��
	$("#jy_end_time").val("");//���Ľ���ʱ��
	search();//��ѯ
}

function checktime(){
	var booker_start_time = jQuery("#jy_start_time").val();//��ʼʱ��
	var booker_end_time = jQuery("#jy_end_time").val();//����ʱ��
	if(booker_start_time != "" && booker_end_time != ""){
		var start_time = booker_start_time;//��ʼʱ��
		start_time = start_time.replace(/-/g,"/");
		start_time = new Date(start_time);
		
		var end_time = booker_end_time;//����ʱ��
		end_time = end_time.replace(/-/g,"/");
		end_time = new Date(end_time);
		if(start_time>end_time){
			 alert('��ʼʱ����ڽ���ʱ�䣬������ѡ��');
		}
	}
}
</script>
<%--query table end--%>
<table width="100%" style="margin-left: 0" class="tabs_search_ctable_box">
	<tr>
		<td>
			<!-- ��ѯ����ѡ��    tabs_search_ctable(��ѯtable��ʽ) -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable_box">
					<tr>
						<td>
							<!-- �̶���ѯ -->
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable">
								<tr>
									<th width="90" class="input_cx_title_th" >����ʱ�䣺</th>
									<td class="cx_title_td" colspan="">
									<input type="text" class="date_187" style="width:130px;"
										id="jy_start_time" name="jy_start_time" onchange="checktime()"
										onfocus="WdatePicker({onpicked:function(){jy_end_time.focus();},dateFmt:'yyyy-MM-dd'})" />
										<span class="date_120_span">��</span>
									<input type="text" class="date_187" style="width:130px;"
											id="jy_end_time" name="jy_end_time" onchange="checktime()"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
								    </td>
									<td width="385"  colspan="4"  >
									<input name="search" value="����" type="button" 
									onclick="search()" class="but_y_01"/>
									<input name="reset" value="����" type="button" 
									onclick="reset()" class="but_y_01"/>
									<span id="selAreaImg" class="all_search_condition">
									</span></td>
								</tr>
							</table>
							<!-- �̶���ѯ end-->
						</td>
					</tr>
					
			</table>
		<!-- ��ѯ����ѡ��    tabs_search_ctable(��ѯtable��ʽ) -->
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
			var jy_start_time = jQuery("#jy_start_time").val();
			var jy_end_time = jQuery("#jy_end_time").val();
			var str = "{'whatTabs':'2','jy_start_time':'"+jy_start_time+"','jy_end_time':'"+jy_end_time+"','t_regb_gh_date':'<%=nowDateString%>','t_regb_user_id':'<%=user_id%>'}";
			return descape(escape(str));
		}
		 /**
		  *�������ʱ��
		  */
		  function mathLeaveDays(startTime,endTime){
			  var start_date= new Date(Date.parse(startTime.replace(/-/g,  "/")));  
			  var end_date= new Date(Date.parse(endTime.replace(/-/g,  "/")));  
			  var days = (end_date - start_date)/1000/60/60/24;
			  return days;
		  }
	
		$(document).keydown(function(){
			if(event.keyCode == 13){
			   search();
			}
		});
		initTable = function (){
		$("#gridTable").jqGrid({
			url: '<%= path %>' + '/commonListServlet?classNameId=czt_ibraryRegBookInfoList',  //commonListServlet�б�����servlet,classNameId��servletBean.xml�ļ�������Ҫ���õ���,isPage:�Ƿ�ҳ(true,false),Ĭ��Ϊtrue
			//jqGrid�ؼ�ͨ����������õ���Ҫ��ʾ�����ݣ�����ķ���ֵ����ʹXMLҲ������Json
			datatype: "json",
			//������������趨��Ҫ�õ����������͡�����õ��ǡ�json������������ͻ�������xml��xmlstring��local��javascript��function
			mtype: "POST",
			//����ʹ�����ַ�����������GET����POST
			height: "100%",//270
			//Grid�ĸ߶ȣ����Խ������֡�%ֵ��auto��Ĭ��ֵΪ150
			//width ��800, //Grid�Ŀ�ȣ����δ���ã�����ӦΪ�����п��֮�ͣ���������˿�ȣ���ÿ�еĿ�Ƚ������shrinkToFitѡ������ã��������á�
			//shrinkToFit ��true ��ѡ�����ڸ���width����ÿ�п�ȵ��㷨��Ĭ��ֵΪtrue�����shrinkToFitΪtrue��������widthֵ����ÿ�п�Ȼ����width�ɱ������ţ����shrinkToFitΪfalse��������widthֵ����ÿ�еĿ�Ȳ���ɱ������ţ����Ǳ���ԭ�����ã���Grid������ˮƽ������
			autowidth: true,
			//Ĭ��ֵΪfalse�������Ϊtrue����Grid�Ŀ�Ȼ���ݸ������Ŀ���Զ����㡣�����������Grid��ʼ���Ľ׶Σ�������������ߴ�仯�ˣ�ͬʱҲ��Ҫ�仯Grid�ĳߴ�Ļ�������Ҫ���Լ��Ĵ����е���setGridWidth��������ɡ�
			colNames: ['t_regb_id','t_regb_user_id','������','��������','ͼ��ids','ͼ������','����ʱ��','Ӧ�黹ʱ��','����״̬'],
			//�ַ������飬����ָ�����е���ͷ�ı������е�˳���Ƕ�Ӧ�ġ�
			colModel: [ //����Ҫ������֮һ�������趨���еĲ���
				{
		        	name: 't_regb_id',index: 't_regb_id',width: '60',sortable:false,hidden:true
				},
		        {
		        	name: 't_regb_user_id',index: 't_regb_user_id',width: '40',sortable:false,hidden:true
				},
				{
					name: 't_regb_user_name',index: 't_regb_user_name',width: '40',sortable:true
				},
				{
					name: 't_regb_sqtype',index: 't_regb_sqtype',width: '40',sortable:true
				},
				{
					name: 't_regb_bookids',index: 't_regb_bookids',width: '40',sortable:false,hidden:true
				},
				{
					name: 't_regb_booknames',index: 't_regb_booknames',width: '200',sortable:true
				},
				{
					name: 't_regb_jy_date',index: 't_regb_jy_date',width: '40',sortable:true
				},
				{
					name: 't_regb_gh_date',index: 't_regb_gh_date',width: '30',sortable:true
				},
				{
					name: 't_regb_state',index: 't_regb_state',width: '30',sortable:true
				}
			],
			viewrecords: true,
			sortname:'t_regb_jy_date',
			sortorder:'desc',
			//�����Ƿ���Pager Bar��ʾ���м�¼��������
			rowNum: 15,
			//��������Grid��һ����ʾ��������Ĭ��ֵΪ20���������ѡ�����rows��prmNames�����õģ�ͨ��urlѡ�����õ����Ӵ��ݵ�Server��ע�����Server���ص���������������rowNum���趨����GridҲֻ��ʾrowNum�趨��������
			rowList: [10, 20, 30],
			//һ�����飬��������Grid���Խ��ܵ�rowNumֵ������[10,20,30]
			gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
				var ids = $("#gridTable").getDataIDs(); //jqGrid('getDataIDs');
				for (var i = 0; i < ids.length; i++) {
					var cl = ids[i];
					var model = jQuery("#gridTable").jqGrid('getRowData', cl);
					
					var days = mathLeaveDays('<%=nowDateString%>',model.t_regb_gh_date);
					if(model.t_regb_state == "6"){
						col = "<strong><span class=rowhighlight>������</span></a></strong>";
					}else{
						if(days <= 7) {
							col = "<strong><span class=rowhighlight>������</span></a></strong>";
						} else {
							col = "<strong><span class=rowhighlight>�ѽ���</span></a></strong>";
						}
					}
					jQuery("#gridTable").jqGrid('setRowData', ids[i], {
						t_regb_state: col
					});
				}
			},
			jsonReader: { //������һ�����飬�����趨��ν�����Server�˷�������json����
				repeatitems: false
			},
			//pager: "#gridPager",
			pagerintoolbar:true,//����ķ�ҳ��
			pagerinBottombar:true,//����ķ�ҳ��
			//����ҳ�������Page Bar
			//caption: "�ݸ���",
			//����Grid���ı��⣬���δ���ã������������ʾ��
			search : toParamJosn(),
			prmNames: { //����һ�����飬��������jqGrid��Ҫ��Server���ݵĲ�������
				rows: "rows",
				//��ʾ���������Ĳ�������  
				sort: "sidx",
				//��ʾ��������������Ĳ�������  
				order: "sord",
				//��ʾ���õ�����ʽ�Ĳ������� 
				search : "search"
			},
			toolbar: [true,"top"],
			
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
		</script>
		</td>
	</tr>
</table>
<form id="form1" name="form1" method="post" action="ibrarybookinfoDo.jsp" target="filetypelisthiddenFrame">
<input type='hidden' name='action' id="hidden_action"/>
<input type='hidden' name='book_id' id="book_id"/>
<input type='hidden' name='actiontype' id="actiontype"/>
</form>
<iframe name="filetypelisthiddenFrame" width=0 height=0></iframe>
</body>
</html>