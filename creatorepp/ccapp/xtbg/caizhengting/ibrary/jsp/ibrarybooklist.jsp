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
	String tree_id = request.getParameter("id"); //ͼ������ID 
	String tree_name = java.net.URLDecoder.decode(StringUtil.deNull(request.getParameter("name")),"UTF-8"); //��������
	String tree_type_code = java.net.URLDecoder.decode(StringUtil.deNull(request.getParameter("tree_type_code")),"UTF-8");//ͼ���ŵķ������
	String tree_type_no = request.getParameter("tree_type_no"); //ͼ���ŵķ������
	
	String unit_id = userBean.getUnit_id();  //��λID
	
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
/**
��������
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

function btnClickFn(){
	var tree_id = "<%=tree_id%>";
	var tree_name = "<%=tree_name%>";
	var tree_type_code = "<%=tree_type_code%>";
	var tree_type_no = "<%=tree_type_no%>";
	//openWindows('treetypeadd','����ͼ��','../../../caizhengting/ibrary/jsp/ibrarybookinfo.jsp?subid=bookadd&tree_id='+tree_id,false,window);
	var url = '../../../caizhengting/ibrary/jsp/ibrarybookinfo.jsp?subid=bookadd&tree_id='+tree_id+'&tree_name='+encodeURI(encodeURI(tree_name))+"&tree_type_code="+encodeURI(encodeURI(tree_type_code))+"&tree_type_no="+tree_type_no;
	openWindows('bookadd','�޸�ͼ����Ϣ',url,'bookadd',false,window);
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
        alert("��ѡ��һ�����ݽ��и���!");
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
			alert("��ѡ��Ҫɾ���ļ�¼��");
		} else {
			if(checkHavaNo(ids)){  //����δ�黹��ͼ��
				alert("����δ�黹��ͼ���޷�ɾ����");
			}else{
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
}

//����Ƿ����δ�黹��ͼ��
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
	//openWindows('addinformation','����ͼ��',url,false,window);
	openWindows('addinformation','�޸�ͼ����Ϣ',url,'addinformation',false,window);
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
	
	title = "ͼ���ѯ��";
	paramHead = "ͼ������,ͼ����,����,����,����������,�����,���,��������,ҳ��,�۸�(Ԫ),���״̬,�Ǽ���,�Ǽ�ʱ��,�Ǽǲ���,����˵��";
	columnWidth = "7000,4000,7000,4000,7000,4000,7000,7000,7000,4000,7000,7000,5000,5000";
	sql +=" select book_name, book_no,"
	sql +=" (SELECT distinct REPLACE(REPLACE(to_char(wm_concat('!@#$%^&*()'||t1.tree_name) over(partition by '' order by level desc rows between unbounded preceding and unbounded  following)),',!@#$%^&*()','/'),'!@#$%^&*()','')  FROM CZT_IBRARYTREE t1  START WITH tree_id = t.tree_id  CONNECT BY PRIOR tree_parent_id = tree_id) tree_name,";
	sql +=" book_author, book_pressname, book_pressno,book_pressbunver, to_char(book_pressdate,'yyyy-MM-dd') book_pressdate,";
	sql +=" book_page, book_price, decode(book_state,'0','�ڿ�','1','�ѽ��') book_state, t1.user_realname, to_char(booker_date,'yyyy-MM-dd hh24:mi:ss') booker_date, t2.org_name, remark from czt_ibrary_bookinfo t ";
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
����
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
	var booker_start_time = jQuery("#booker_start_time").val();//��ʼʱ��
	var booker_end_time = jQuery("#booker_end_time").val();//����ʱ��
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
									<th width="90" class="input_cx_title_th" >ͼ�����ƣ�</th>
									<td width="296"  class="cx_title_td">
									<input name="book_name" id="book_name" type="text" class="input_cx_title_283" /></td>
									<td width="385"  colspan="4"  >
									<input name="search" value="����" type="button" 
									onclick="search()" class="but_y_01"/>
									<input name="reset" value="����" type="button" 
									onclick="reset()" class="but_y_01"/>
									<span id="selAreaImg" class="all_search_condition">
									<a onclick="hiddenOrShowSelArea('hiddenArea','selAreaImg')" >������������
									</a></span></td>
								</tr>
							</table>
							<!-- �̶���ѯ end-->
						</td>
					</tr>
					
					<tr><td>
					<!-- ���ز�ѯ -->
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tabs_search_ctable" id="hiddenArea" style="display:none;margin-left: 3px;">
							<tr>
								<th width="90" class="input_cx_title_th" >ͼ���ţ�</th>
								<td width="296"  class="cx_title_td">
									<input name="book_no" id="book_no" type="text" class="input_cx_title_283" />
								</td>
								<th width="90" class="input_cx_title_th" >���ݣ�</th>
								<td width="296"  class="cx_title_td">
									<input name="remark" id="remark" type="text" class="input_cx_title_283" />
								</td>
							</tr>
							<tr>
								<th  class="input_cx_title_th" >
									�Ǽ�ʱ�䣺
								</th>
								<td class="cx_title_td">
									<input type="text" class="validate[required] date_187" style="width:131px;"
										id="booker_start_time" name="booker_start_time" onchange="checktime()"
										onfocus="WdatePicker({onpicked:function(){booker_end_time.focus();},dateFmt:'yyyy-MM-dd'})" />
										<span class="date_120_span">��</span>
									<input type="text" class="validate[required] date_187" style="width:130px;"
											id="booker_end_time" name="booker_end_time" onchange="checktime()"
											onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
								</td>
								<th width="90" class="input_cx_title_th" >���ߣ�</th>
								<td width="296"  class="cx_title_td">
									<input name="book_author" id="book_author" type="text" class="input_cx_title_283" />
								</td>
							</tr>
						</table>
						<!-- ���ز�ѯ end-->
				</td></tr>
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
			url: '<%= path %>' + '/commonListServlet?classNameId=czt_ibraryBookInfoList',  //commonListServlet�б�����servlet,classNameId��servletBean.xml�ļ�������Ҫ���õ���,isPage:�Ƿ�ҳ(true,false),Ĭ��Ϊtrue
			//jqGrid�ؼ�ͨ����������õ���Ҫ��ʾ�����ݣ�����ķ���ֵ����ʹXMLҲ������Json
			datatype: "json",
			//������������趨��Ҫ�õ����������͡�����õ��ǡ�json������������ͻ�������xml��xmlstring��local��javascript��function
			mtype: "POST",
			pageCached:false,
			//����ʹ�����ַ�����������GET����POST
			height: "100%",//270
			//Grid�ĸ߶ȣ����Խ������֡�%ֵ��auto��Ĭ��ֵΪ150
			//width ��800, //Grid�Ŀ�ȣ����δ���ã�����ӦΪ�����п��֮�ͣ���������˿�ȣ���ÿ�еĿ�Ƚ������shrinkToFitѡ������ã��������á�
			//shrinkToFit ��true ��ѡ�����ڸ���width����ÿ�п�ȵ��㷨��Ĭ��ֵΪtrue�����shrinkToFitΪtrue��������widthֵ����ÿ�п�Ȼ����width�ɱ������ţ����shrinkToFitΪfalse��������widthֵ����ÿ�еĿ�Ȳ���ɱ������ţ����Ǳ���ԭ�����ã���Grid������ˮƽ������
			autowidth: true,
			//Ĭ��ֵΪfalse�������Ϊtrue����Grid�Ŀ�Ȼ���ݸ������Ŀ���Զ����㡣�����������Grid��ʼ���Ľ׶Σ�������������ߴ�仯�ˣ�ͬʱҲ��Ҫ�仯Grid�ĳߴ�Ļ�������Ҫ���Լ��Ĵ����е���setGridWidth��������ɡ�
			colNames: ['book_id','ͼ������','ͼ����','��Ч״̬','װ������','�������id','�������','�Ǽ�ʱ��','����'],
			//�ַ������飬����ָ�����е���ͷ�ı������е�˳���Ƕ�Ӧ�ġ�
			colModel: [ //����Ҫ������֮һ�������趨���еĲ���
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
			
			//�����Ƿ���Pager Bar��ʾ���м�¼��������
			rowNum: 10,
			//��������Grid��һ����ʾ��������Ĭ��ֵΪ20���������ѡ�����rows��prmNames�����õģ�ͨ��urlѡ�����õ����Ӵ��ݵ�Server��ע�����Server���ص���������������rowNum���趨����GridҲֻ��ʾrowNum�趨��������
			rowList: [10, 20, 30],
			//һ�����飬��������Grid���Խ��ܵ�rowNumֵ������[10,20,30]
			gridComplete: function() { // var idss=jQuery("#gridTable").jqGrid('getColNames');
				$(".t_taoobar_content_left").css("width","420px");
				
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
			toolbar: [true,"top","<input type='button' class='but_y_01' value='����' onclick='btnClickFn();'/>"
			+"<input type='button' class='but_y_01' value='ɾ��' onclick='delCarInfo();'/>"
			+"<input type='button' class='but_y_01' value='����' onclick='docopy()'/>"
			+"<input class='but_y_01' id='exprot' value='����' type='button' onclick='exportexcel()'/>"
			+"<input class='but_y_01' id='import' value='����' type='button' onclick='importExcel()'/>"],
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
		����:  importExcel
		˵��:  ����Excel���
		����:   ��
		����ֵ: ��
		*/
		var importExcel = function(){
			var title = descape(escape('ͼ��������Ϣ')); //ת��,�������Ĵ�������
			var remark = descape(escape('ע��:���಻���ڵĽ����ᵼ��!')); //ת��,�������Ĵ�������
			var url = '${pageContext.request.contextPath}/ccapp/oa/resources/util/excel/excelimport.jsp?excelImplClass=ibraryBookInfoDaoExcelImpl&excelTemplateFilePath=ibrary_excelTemplateFilePath&title='+title+'&remark='+remark;
			openAlertWindows('windowId',url,
				    '����excel���', '455px', '70%', '10%', '40%', function() {
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