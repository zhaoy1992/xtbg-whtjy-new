<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%
	String path = request.getContextPath();
	String template_id = request.getParameter("template_id");
	/*
	WordTemplateServiceIfc wordTemplate = new  WordTemplateServiceImpl();
	request.setAttribute("variableSelect",wordTemplate.getVariableSelect(template_id));
	request.setAttribute("datasetSelect",wordTemplate.getDatasetSelect(template_id));*/
	
	String sql = "select v.var_id,v.var_name from ta_oa_word_var v where v.template_id='"+template_id+"'";
	String vartypeHtml = DictDropDownList.buildSelect(sql,"bl_name","","",true,"");//��Ϣ����������
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.chinacreator.xtbg.pub.util.DictDropDownList"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title></title>
<!-- ����jQuery -->
<script type="text/javascript" src="../jquery1.6/jquery-1.6.min.js"></script>

<!-- ����jQuery UI -->
<link id="uiThemes" rel="stylesheet" type="text/css" media="screen"
	href="../jquery-ui-1.8.17.custom/css/custom-theme/jquery-ui-1.8.17.custom.css" />
<script
	src="../jquery-ui-1.8.17.custom/js/jquery-ui-1.8.17.custom.min.js"
	type="text/javascript"></script>

<!-- ����jGrid -->
<link rel="stylesheet" type="text/css" media="screen"
	href="../jquery.jqGrid-4.3.1/css/ui.jqgrid.css" />
<script src="../jquery.jqGrid-4.3.1/js/i18n/grid.locale-en.js"
	type="text/javascript" charset="UTF-8"></script>
<script src="../jquery.jqGrid-4.3.1/js/jquery.jqGrid.min.js"
	type="text/javascript" charset="UTF-8"></script>
	
	
<!-- �������� -->
<script src="../../js/util/public.js" type="text/javascript"></script>
<script src="../../js/common/commoncss.js" type="text/javascript"></script>
		
<!-- �������� -->
<script src="../../js/util/public.js" type="text/javascript"></script>
<script src="../../js/common/commoncss.js" type="text/javascript"></script>

<script language="javascript"
	src="js/wordtemplateutil.js"> </script>	
	
<script type="text/javascript">



var template_id = "";//creator_getQueryString("template_id")== "null"?"":creator_getQueryString("template_id");//ģ��ID
if(template_id == "") {
    template_id = parent.parent.frames["rightFrame"].$("#template_id").val();
}
var kj_id = "";
//var webOffice = parent.parent.frames["mainFrame"].$("WebOffice").first();
var webOffice = parent.parent.frames["mainFrame"].document.getElementsByName("WebOffice")[0];

$(function() {
	$("#gridTable").jqGrid({
		url: '<%= path %>' + '/commonListServlet?classNameId=ruleItemList',  //commonListServlet�б�����servlet,classNameId��servletBean.xml�ļ�������Ҫ���õ���,isPage:�Ƿ�ҳ(true,false),Ĭ��Ϊtrue
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
		colNames: ['�ؼ�����', 'ȡֵ����', 'ȡֵ����id' , 'ȡֵ����', 'ȡֵ����id', '�ؼ�����', '��������ID', '�ؼ�����value'],
		//�ַ������飬����ָ�����е���ͷ�ı������е�˳���Ƕ�Ӧ�ġ�
		colModel: [ //����Ҫ������֮һ�������趨���еĲ���
        {
			name: 'ruleitem_name',
			index: 'ruleitem_name',
			width: 190
		},
		{
			name: 'ruleitem_value_typename',
			index: 'ruleitem_value_type',
			width: 100,
			editable: true
		},
		{
			name: 'ruleitem_value_type',
			index: 'ruleitem_value_type',
			hidden: true
		},
		{
			name: 'ruleitem_var_name',
			index: 'ruleitem_var_name',
			width: 100,
			editable: true
		},
		{
			name: 'ruleitem_value',
			index: 'ruleitem_value',
			hidden: true
		},
		{
			name: 'control_type',
			index: 'control_type',
			width: 190,
			editable: true
		},
		{
			name: 'ruleitem_id',
			index: 'ruleitem_id',
			hidden: true
		},
		{
			name: 'control_type_value',
			index: 'control_type_value',
			hidden: true
		}
		
		],
		sortname: 'ruleitem_id',
		//ָ��Ĭ�ϵ������У�����������Ҳ���������֡��˲������ڱ����ݵ�Server�ˡ�
		sortorder: 'desc',
		viewrecords: true,
		
		//�����Ƿ���Pager Bar��ʾ���м�¼��������
		rowNum: 10,
		//��������Grid��һ����ʾ��������Ĭ��ֵΪ20���������ѡ�����rows��prmNames�����õģ�ͨ��urlѡ�����õ����Ӵ��ݵ�Server��ע�����Server���ص���������������rowNum���趨����GridҲֻ��ʾrowNum�趨��������
		//rowList: [10, 20, 30],
		//һ�����飬��������Grid���Խ��ܵ�rowNumֵ������[10,20,30]
		gridComplete: function() {

		},
		jsonReader: { //������һ�����飬�����趨��ν�����Server�˷�������json����
			repeatitems: false
		},
		pager: "#gridPager",
		//����ҳ�������Page Bar
		//caption: "�����б�",
		//����Grid���ı��⣬���δ���ã������������ʾ��
		search : toUserParamJosn(),
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
		multiselect: true,
		ondblClickRow: function(id) {
			updateRuleItem(id);
		}
	}).navGrid('#gridPager', {
		edit: false,
		add: false,
		del: false,
		search: false,
		refresh: false
	});
	
	
	$("#t_gridTable").append("<div>")
	.append("")
	.append("</div>");

});

var refreshGrid = function() {

	var sdata = { //������ѯ��Ҫ�Ĳ��� 
			paramJson: toUserParamJosn()
		}; //��õ�ǰpostDataѡ���ֵ  
		var postData = $("#gridTable").jqGrid("getGridParam", "postData"); //����ѯ��������postDataѡ�����  
		$.extend(postData, sdata);
		$("#gridTable").jqGrid("setGridParam", {
			search: true // ��jqGrid��searchѡ����Ϊtrue  
		}).trigger("reloadGrid", [{
			page: 1
		}]); //��������Grid�����ʹ����������Ч
}

/*
����:  toUserParamJosn
˵��:  ����Ҫ��ѯ�Ĳ���
����:   ��
����ֵ: ����Ҫ��ѯ�Ĳ���
*/
var toUserParamJosn = function() {
	var str = "{'template_id':'"+template_id+"'}";
	return descape(escape(str));
}

function kjSave(){
    if(!validateKJ()){
        return;
    }
    var url = "wordtemplatedo.jsp?operationType=dosaveruleitem";
    //$('#rlueitemform').attr("action",url);
    //$('#rlueitemform').attr("target","hiddenFrame");
    document.all.rlueitemform.action = url;
    document.all.rlueitemform.target = "hiddenFrame";
	$('#rlueitemform').submit();
}
function hshs(){
	alert("dfafdda");
}

function kjDelete() {
	var ids = "";
	var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
	var idsArrTemp = new Array();
	$(selectedIds).each(function () {
		var model = jQuery("#gridTable").jqGrid('getRowData', this);
		if(!IsSpace(model.ruleitem_id)){
			idsArrTemp.push("'"+model.ruleitem_id+"'");
		}
	});
	
	
	ids = idsArrTemp.join(",");
	
    if(IsSpace(ids)){
        alert("��ѡ��Ҫɾ���ļ�¼");
        return;
    }
    var url = "wordtemplatedo.jsp?operationType=dodeleteruleitem&ids="+ids;

    $('#rlueitemform').attr("action",url);
    $('#rlueitemform').attr("target","hiddenFrame");
	$('#rlueitemform').submit();

}

	//����
	function kjResert() {
	    $("#kj_type").val("-1");
	    $("#kj_name").val("");
	    $("#kj_id").val("");
	    $("#bl_name").val("");
	    $("#sjj_name").val("-1");
		var tmp = $("kj_lx");
		tmp.first().prop("checked",true);
	}

	function validateKJ() {
	    var kj_name = $("#kj_name").val();
	    var kj_id = $("#kj_id").value;
	    var kj_type = $("#kj_type").val();
	    var kj_lx = $("#kj_lx").val();
	
	    var bl_name = $("#bl_name").val();
	    var sjj_name = $("#sjj_name").val();
		if(template_id == "" || template_id == "null"){
			template_id = parent.parent.frames["rightFrame"].$("#template_id").val();
		}
	    if(template_id == "" || template_id =="null") {
	        alert("ģ�������Ϣδ���棬���ȱ���");
	        return false;
	    }
	    if(kj_type == "") {
	        alert("�ؼ����Ͳ���Ϊ��");
	        return false;
	    }
	    if(kj_name == "") {
	        alert("�ؼ����Ʋ���Ϊ��");
	        return false;
	    }
	    /*
	    if(kj_id == "") {
	        var countNum = WordControl.isUnique(template_id,kj_name);
	        if(parseInt(countNum) != 0) {
	            alert("ͬһģ���еĿؼ�������ͬ������������");
	            return false;
	        }
	    }
	    */
	    if(kj_lx == "") {
	        alert("��ѡ��ؼ�ȡֵ");
	        return false;
	    }    
	    if(kj_lx =="1" && bl_name =="") {
	        alert("��ѡ�����");
	        return false;
	    }
	    if(kj_lx =="2" && sjj_name =="") {
	        alert("��ѡ�����ݼ�");
	        return false;
	    }
	    if(kj_type == "orderlyTable") {
	        var wordSelection = webOffice.WebObject.ActiveWindow.Selection;
	        if (!wordSelection.Information(wdWithInTable)) {
	            alert("������WORDģ���д������");
	            return false;
	        }
	    }
	    return true;
	}

	var listValue  = new Array();//ȫ�ֲ�������wordtemplatedo.jsp�и�ֵ 
	var kj_name = "";
	//wordtemplatedo.jsp�ص�����
	function doReturnOK(operationType){
		if(operationType == "dosaveruleitem"){
			doReturnSaveRuleItem();
		}else if(operationType == "dodeleteruleitem"){
			doReturnDeleteRuleItem();
		}
		parent.parent.frames["mainFrame"].saveTempletFromRight();
		refreshGrid();			
		//document.location.reload();
	}
	
	function doReturnSaveRuleItem(){

		$("#kj_id").val($("#temp_value").val().split("#")[0])
		kjType = $("#kj_type").val(); 

	    if(kjType == "textInput") {
	    	kj_name = "ti_" + $("#kj_name").val();
	    	var tempValue = $("#temp_value").val().split("#")[1];//wordtemplatedo.jsp�и�ֵ
	    	var options = {
					statusText : $("#kj_flag").val(),
					helpText : $("#kj_help").val(),
					defaultValue : tempValue
			};
	    	createTextInput(webOffice.WebObject,kj_name,options);//�����ֹ������ı�����
	    }
	   
		alert("�����ɹ�");
	}
	
	function doReturnDeleteRuleItem(){
		var selectedIds = $("#gridTable").jqGrid("getGridParam", "selarrrow");
		var idsArrTemp = new Array();
		var nameArrTemp = new Array();
		$(selectedIds).each(function () {
			var model = jQuery("#gridTable").jqGrid('getRowData', this);
			idsArrTemp.push(model.ruleitem_id);
			nameArrTemp.push(model.ruleitem_name);
		});

		
		ids = idsArrTemp.join(",");
		kj_name = nameArrTemp.join(",");

	    //if(ids.indexOf("ti_") != -1) {//-----------�����
	       var kjnameobj = kj_name.split(",");
	       for(var i=0; i<kjnameobj.length; i++) {
				rule_Name = "ti_" + kjnameobj[i];
				var isTrue = deleteTextInput(webOffice.WebObject, rule_Name);//WordReportUtil.js
				if(!isTrue) {
					alert("ɾ���ֹ������ı��������,����ϵ����Ա");
					return;
				} 
	       }
	    //}
	    	
		alert("ɾ���ɹ�");
	}

	function updateRuleItem(id){
		var model = jQuery("#gridTable").jqGrid('getRowData', id);
		
		$("#kj_type").val(model.control_type_value);
		$("#kj_name").val(model.ruleitem_name);
		$("#kj_lx").first().prop("checked",true);
		$("#bl_name").val(model.ruleitem_value);
		$("#cur_kj_id").val(model.ruleitem_id.split("_")[1]);
		$("#kj_flag").val(model.ruleitem_flag);
		$("#kj_help").val(model.ruleitem_help);
	}
</script>
</head>
<body >
<form action="" name="rlueitemform" id="rlueitemform" method="post">
<input type  ="hidden" name = "template_id" value = "<%=template_id %>">
<input type = "hidden" name = "temp_value" id="temp_value" value = ""/>
<input type = "hidden" name = "cur_kj_id" value = ""/>
<input type = "hidden" name = "kj_flag" value = ""/>
<input type = "hidden" name = "kj_help" value = ""/>

<TABLE class="cQueryTableArea" cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
	<TBODY>
		<TR>
			<TD>
			<TABLE  cellSpacing=0 cellPadding=0 width="100%" border=0>
					<TR>
						<TD width="20%" class="poptableLable_new">�ؼ�����<FONT color=red>*</FONT></TD>
						<TD colSpan=3><SELECT id=kj_type name = "kj_type">
							<OPTION value="-1" selected>--��ѡ��--</OPTION>
							<OPTION value=textInput>�����</OPTION>
						</SELECT></TD>
					</TR>
					<TR>
						<TD width="20%" class="poptableLable">�ؼ�����<FONT color=red>*</FONT><INPUT id=kj_id
							name="kj_id" type="hidden"></TD>
						<TD colSpan=3><INPUT id=kj_name name = "kj_name" style="WIDTH: 100%" type="text"></TD>
					</TR>
					<TR>
						<TD width="20%" rowSpan=2 class="poptableLable">�ؼ�ȡֵ<FONT color=red>*</FONT></TD>
						<TD width="20%" class="poptableLable"><INPUT id=kj_bllx type=radio value=1 name=kj_lx checked>����</TD>
						<TD colSpan=2><%=vartypeHtml %></TD>
					</TR>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD align=right>
			<input class="cButton_4text" type="button" name="operation" value="����" onclick="kjSave()" id="btnSave" title = "����word�Ĺ�괦���ӹ�����"/>&nbsp;
			<input class="cButton_4text" type="button" name="operation" value="ɾ��" onclick="kjDelete()" id="btnDelete"/>&nbsp;
			<input class="cButton_4text" type="button" name="operation" value="����" onclick="kjResert()" id="btnReset"/>&nbsp;
			</TD>
		</TR>
		<TR>
			<TD>
				<!-- ��ѯ�б��� cGridArea(��ѯ����ʽ)-->
				<div class="cGridArea">
					<table id="gridTable"></table>
					<div id="gridPager"></div>
				</div>
				<!-- ��ѯ�б��� -->
			</TD>
		</TR>
	</TBODY>
</TABLE>

</form>
<iframe name = "hiddenFrame" width=0 height=0></iframe>
</body>
</html>