<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%
	String mbId = request.getParameter("mb_id");
%>	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title></title>
<script language="javascript"
	src="../../../../kcapp/resources/js/util/public.js "> </script>
<script language="javascript"
	src="../../../../kcapp/resources/js/common/commoncss.js "> </script>
<script type="text/javascript"
	src="../../../resources/js/util/queryfun.js"></script>
<script type="text/javascript">
	var mb_id = creator_getQueryString("mb_id")== "null"?"":creator_getQueryString("mb_id");//模版ID
	if(mb_id == "") {
	    mb_id = parent.parent.frames["rightFrame"].$("mb_id").value;
	}
	
	var sjjId = "";
	
	function init() {
	
	}
	
	function saveSJJ() {
	    if(!validateSJJ()){
	        return;
	    }
	    var url = "wordtemplatedo.jsp?operationType=dosavedataset";;
	    document.all.datasetform.action = url;
	    document.all.datasetform.target = "hiddenFrame";
	    document.all.datasetform.submit();
	}
	
	function validateSJJ() {
	    var sjj_mc = $("sjj_mc").value;
	    var sjj_sql = $("sjj_sql").value;
		if(mb_id == "" || mb_id == "null"){
			mb_id = parent.parent.frames["rightFrame"].$("mb_id").value;
		}
	    if(mb_id == "" || mb_id == "null") {
	        alert("模版基本信息未保存，请先保存");
	        return false;
	    }
	    if(sjj_mc == "") {
	        alert("数据集名称不能为空");
	        return false;
	    }
	    /*
	    if(sjj_id == "") {
	        var countNum = Dataset.isUnique(mb_id,sjj_mc);
	        if(parseInt(countNum) != 0) {
	            alert("同一模版中的数据集名称相同，请重新输入");
	            return false;
	        }
	    }
	    */
	    if(sjj_sql == "") {
	        alert("数据集SQL不能为空");
	        return false;
	    }    
	    var blNames = parseVariant(sjj_sql).toString();
		var bl_name = "";
		var objBlName = blNames.split(",");
		if(objBlName != ""){
			for(var i = 0 ; i < objBlName.length; i++) {
				var result = Variable.isUnique(mb_id,objBlName[i]);
				if(result == "0") {
					if(bl_name == ""){
						bl_name = objBlName[i];
					} else {
						bl_name += "," + objBlName[i];
					}
				}
			}
		}
		if(bl_name != "") {
			alert("SQL的变量 "+bl_name+" 未定义，请先在变量中增加");
			return false;
		}
		try { 
			//var isFlag = DBUtil.getQueryArray(sjj_sql, 0, -1);
		} 
		catch (e) 
		{ 
			alert("SQL语句不能执行，请检查SQL语法");
			return false;
		}
	
	    return true;
	}
	
	/*
	描述：正则表达式将格式为${info}$ 的变量解析
	*/
	function parseVariant(src) {
		var result = src.match(/\${[^}]*}/g);
		if(result == null) {
				result = "";
		} else {
			for (var i = 0, count = result.length; i < count; i++) {
				result[i] = result[i].replace(/\${([^}]*)}/, "$1");
			}
		}
		return result;
	}

	function updateSjj(rowid){
		var sjjMc = document.getElementsByName("sjj_mc_hidden")[rowid].value;
		var sjjSql = document.getElementsByName("sjj_sql_hidden")[rowid].value;
		var sjjMs = document.getElementsByName("sjj_ms_hidden")[rowid].value;
		var sjjId = document.getElementsByName("sjj_id_hidden")[rowid].value;
		$("sjj_mc").value = sjjMc;
		$("sjj_sql").value = sjjSql;
		$("sjj_ms").value = sjjMs;
		$("cur_sjj_id").value = sjjId;
	}
	
	function deleteSJJ() {
		var checkbox = document.getElementsByName("checkbox");
		var id = document.getElementsByName("sjj_id_hidden");
		var ids = "";
		for(var i = 0 ; i < checkbox.length ; i++){
			if(checkbox[i].checked){
				ids = ids + "'" +id[i].value+ "',";
			}
		}
		ids = ids.substring(0,ids.length - 1);
	    if(IsSpace(ids)){
	        alert("请选择要删除的记录");
	        return;
	    }		
	    var url = "wordtemplatedo.jsp?operationType=dodeletedataset&ids="+ids;
	    document.all.datasetform.action = url;
	    document.all.datasetform.target = "hiddenFrame";
	    document.all.datasetform.submit();
	}
	
	function resetSJJ() {
	   $("sjj_mc").value = "";
	   $("sjj_sql").value = "";
	   $("sjj_ms").value = "";
	   sjjId = "";
	   $("cur_sjj_id").value = "";
	}
	
	function doReturnOK(operationType){
		if(operationType.indexOf("errorsql")!=-1){
			alert("sql语句错误，请检查");
		}else if(operationType == "dosavedataset" || operationType == "dodeletedataset" ){
			alert("操作成功");
			parent.frames["ruleItemSubForm"].document.location.reload();//刷新规则项
			document.location.reload();
		}else if(operationType.split("_isUsed").length > 1){
			alert("数据集被控件引用，请先删除控件");
		}	
	}
	
	function init(){
	}
</script>	

</head>
<body onload = init()>
<form action="" name="datasetform" method="post">
<input type = "hidden" name = "cur_sjj_id" value = "">
<input type = "hidden" name = "mb_id" value = "<%=mbId %>">
<TABLE cellSpacing=0 cellPadding=0 width="100%" align=center border=0>
	<TBODY>
		<TR>
			<TD>
			<TABLE class=Ctable cellSpacing=0 cellPadding=0 width="100%" border=0>
				<TBODY>
					<TR>
						<TD class=c2 width="25%">数据集名称<FONT color=red>*</FONT></TD>
						<TD width="75%"><INPUT id=sjj_mc name = "sjj_mc" type="text" style = "width:100%"></TD>
					</TR>
					<TR title = "参数方式：\${参数}">
						<TD class=c2 width="25%" >sql语句<FONT color=red>*</FONT></TD>
						<TD ><INPUT id=sjj_sql name = "sjj_sql" type="text" style = "width:100%" value = ""></TD>
					</TR>
					<TR>
						<TD class=c2 width="25%">描述</TD>
						<TD><TEXTAREA id=sjj_ms name = "sjj_ms"></TEXTAREA></TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD align=right>
			<BUTTON class=cButton id=btnSave onclick="saveSJJ()">保存</BUTTON>
			<BUTTON class=cButton id=btnDelete onclick="deleteSJJ()">删除</BUTTON>
			<BUTTON class=cButton id=btnReset onclick="resetSJJ()">重置</BUTTON>
			</TD>
		</TR>
		<TR>
			<TD>
			<TABLE cellSpacing=0 cellPadding=0 width="95%" align=center border=0
				class="cTable">
				<pg:listdata
					dataInfo=""
					keyName="WordDatasetList" />
				<pg:pager data="WordDatasetList" scope="request" isList="false"
					maxPageItems="4">
					<pg:param name="mb_id" />
					<pg:header>
						<pg:title title="" className="report_header" width="10%"></pg:title>
						<pg:title title="名称" className="report_header" width="25%"></pg:title>
						<pg:title title="sql语句" className="report_header" width="20%"></pg:title>
						<pg:title title="描述" className="report_header" width="25%"></pg:title>
					</pg:header>
					<pg:notify>
						<tr>
							<td colspan="10" align="center">暂时没有数据</td>
						</tr>
					</pg:notify>
					<pg:list>
					<input type = "hidden" name = "sjj_id_hidden" value = "<pg:cell colName = "sjj_id" defaultValue = ""/>"/>
					<input type = "hidden" name = "sjj_mc_hidden" value = "<pg:cell colName = "sjj_mc" defaultValue = ""/>"/>
					<input type = "hidden" name = "sjj_sql_hidden" value = "<pg:cell colName = "sjj_sql" defaultValue = ""/>"/>
					<input type = "hidden" name = "sjj_ms_hidden" value = "<pg:cell colName = "sjj_ms" defaultValue = ""/>"/>
						<tr>
							<td align="center"><input type="checkbox" name="checkbox" />
							</td>
							<td title="<pg:cell colName = "sjj_mc" defaultValue = ""/>"
								ondblclick="updateSjj(<%=rowid %>)">
							<pg:cell colName="sjj_mc" defaultValue="" maxlength="5"
								replace="..." /></td>
							<td title="<pg:cell colName = "sjj_sql" defaultValue = ""/>"
								ondblclick="updateSjj(<%=rowid %>)">
							<pg:cell colName="sjj_sql" defaultValue="" maxlength="8"
								replace="..." /></td>
							<td title="<pg:cell colName = "sjj_ms" defaultValue = ""/>"
								ondblclick="updateSjj(<%=rowid %>)">
							<pg:cell colName="sjj_ms" defaultValue="" maxlength="5"
								replace="..." /></td>
						</tr>
					</pg:list>
					<tr>
						<td align="center" colspan="12" class="pagefoot"><!-- 分页提示 -->
						<div>共<pg:rowcount />条记录&nbsp;&nbsp;<pg:index
							export="00000001" /></div>
						<!-- 分页提示 --></td>
					</tr>
				</pg:pager>
			</TABLE>
			</TD>
		</TR>
	</TBODY>
</TABLE>
<iframe name = "hiddenFrame" width = "0" height = "0"></iframe>
</form>
</body>
</html>