<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="../include/global1.jsp"%>
<%@ taglib uri="/WEB-INF/pager-taglib.tld" prefix="pg"%>
<%@ page import="com.frameworkset.dictionary.Data" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityDatabase" %>
<%@ page import="com.chinacreator.sysmgrcore.manager.SecurityConstants" %>
<%@ page import="org.frameworkset.spi.BaseSPIManager" %>
<%@ page import="com.chinacreator.dictionary.DictManager" %>
<%@ page import="com.chinacreator.dictionary.DictManagerImpl" %>
<%@ page import="com.chinacreator.security.AccessControl"%>
<%@ page import="com.frameworkset.common.poolman.DBUtil"%>
<%@ page import="com.frameworkset.common.poolman.sql.*"%>
<%@ page import="com.chinacreator.resource.ResourceManager,
				 com.chinacreator.config.ConfigManager,
				 com.chinacreator.dictionary.DictAttachField"%>
<%@ page import="java.util.*" %>				 
<%	 
	AccessControl accesscontroler = AccessControl.getInstance();
	accesscontroler.checkAccess(request, response);
	boolean isAdminFlag = accesscontroler.isAdmin();
	String currentOrgName = accesscontroler.getChargeOrg() != null ?accesscontroler.getChargeOrg().getRemark5():"";
	String currentOrgIdNO = accesscontroler.getChargeOrgCode()==null?"":accesscontroler.getChargeOrgCode();
	//当前用户所属机构ID
    String currentOrgId = accesscontroler.getChargeOrgId();
	String ids = request.getParameter("did");	
	String selected = request.getParameter("selected");
	//启用停用计数
	int i = 0;
	ids = ids==null?"":ids;
	if("".equals(ids)){
	    ids = request.getParameter("selected");
	}
	String dicttype_name = "";
	String did = "";
	//实际上是datavalue 父数据项的值
	String dictdataValue = "";
	String dictdataName = "";

	Data dtype = null;	
	DictManager dictManager = null;
	if(!"".equals(ids)){
		dictManager = new DictManagerImpl();
		String[] ids_ = ids.split(":");
		if(ids_.length>1){
			did = ids_[0];	
			dictdataValue = ids_[1];
			if(!"root".equals(ids_[2])){
			    dictdataName = ":"+ids_[2];
			}
		}else{
		    did = ids;	
			dictdataValue = "root";
		}
		dtype = dictManager.getDicttypeById(did);
		dicttype_name = dtype.getName();
	}
	if(dtype == null){
		dtype = new Data();
	}	
	String dbname = dtype.getDataDBName();
    String tablename = dtype.getDataTableName();
    String dataNameField = dtype.getDataNameField();
    String dataValueField = dtype.getDataValueField();
    //新维护字段
    String data_name_cn = dtype.getField_name_cn()==""?"名称":dtype.getField_name_cn();
    String data_value_cn = dtype.getField_value_cn()==""?"真实值":dtype.getField_value_cn();
    //字典类型说明
    String description = dtype.getDescription();
    
    //字典数据:名称字段对象
    ColumnMetaData nameObj = DBUtil.getColumnMetaData(dbname,tablename,dataNameField);
    //字典数据:值字段对象
    ColumnMetaData valueObj = DBUtil.getColumnMetaData(dbname,tablename,dataValueField);
    //数据项是否有效,在列表中体现,同时显示"停用/启用功能"
    boolean showDataValidate = false;
    String dataValidate = dtype.getData_validate_field();
    //数据项所属机构,可多个,缺省是登陆用户的机构,在新增的时候体现,在列表体现
    boolean showDataValueOrg = false;
    String dataValueOrg = dtype.getData_create_orgid_field();
    
    //是否有排序字段,决定是否显示排序按钮
    boolean showOrderButton = false;
    String dataOrderField = dtype.getDataOrderField();
    if(dataOrderField != null && dataOrderField.trim().length()>0){
        showOrderButton = true;
    }
	
	if("root".equals(dictdataValue)){
	    dictdataValue="";
	}
	String nameValidType = dictManager.getValidatorTypeByColumnMetaData(nameObj);
    String valueValidType = dictManager.getValidatorTypeByColumnMetaData(valueObj);
    
    String dataValidateType = "";
    String dataValidateTypeName = "";
    String dataOrgType = "";
    String dataOrgTypeName = "";
    if(dataValidate != null && dataValidate.trim().length()>0){
        //字段数据:是否有效
        showDataValidate = true;
    	ColumnMetaData validateObj = DBUtil.getColumnMetaData(dbname,tablename,dataValidate);
        dataValidateType = dictManager.getValidatorTypeByColumnMetaData(validateObj);
        dataValidateTypeName = validateObj.getTypeName();
    }
    if(dataValueOrg != null && dataValueOrg.trim().length()>0){        
    	//字段数据:数据项所属机构
    	showDataValueOrg = true;
    	ColumnMetaData dataOrgObj = DBUtil.getColumnMetaData(dbname,tablename,dataValueOrg);
        dataOrgType = dictManager.getValidatorTypeByColumnMetaData(dataOrgObj);
        dataOrgTypeName = dataOrgObj.getTypeName();
    }
    
    //不能为空的 并且没有被使用的 数据库表字段
    String unableNullColumnNames = "";
    if(dtype!=null){
    	unableNullColumnNames = dictManager.getUnableNullColumnNames(dtype);
    }
    
    //查看采集的数据是否要过滤, 不是自己采集的,不能编辑修改删除....
    boolean needGatherFilter = dictManager.isDicttypeGatherMustFilter(dtype);
    int dicttype_type = dtype.getDicttype_type();
    
    //启用停用灰掉开关
	boolean state = ConfigManager.getInstance().getConfigBooleanValue("enableDictButton", true);
	
	boolean stateDel = ConfigManager.getInstance().getConfigBooleanValue("deleteDictButton", true);
	
	List dictatts = dictManager.getDictdataAttachFieldList(did,-1);
	
	String classType = request.getParameter("classType");
%>
<html>
	<head>
		<title>属性容器</title>		
		<link rel="stylesheet" type="text/css" href="../css/windows.css">
		<link rel="stylesheet" type="text/css" href="../css/contentpage.css">
		<link rel="stylesheet" type="text/css" href="../css/tab.winclassic.css">
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
		<script language="JavaScript" src="../user/common.js" type="text/javascript"></script>
		<script language="JavaScript" src="../include/pager.js" type="text/javascript"></script>
        <SCRIPT language="JavaScript" SRC="../user/validateForm.js"></SCRIPT>
        <script language="javascript" src="js/checkUnique.js"></script>
		<script language="JavaScript"
			src="<%=request.getContextPath()%>/public/datetime/calender_date.js"></script>
		<script language="javascript" src="../scripts/selectTime.js"></script>	
  
<SCRIPT language="javascript">
	var jsAccessControl = new JSAccessControl("#DAE0E9","#F6F8FB","#F6F8FB");
	var win;
	var featrue = "dialogWidth=600px;dialogHeight=500px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;help=0;dialogLeft="+(screen.availWidth-600)/2+";dialogTop="+(screen.availHeight-500)/2;
	function unable(){
	    if(document.all.newbt) document.all.newbt.disabled = true;
		if(document.all.up) document.all.up.disabled = true;
        if(document.all.down) document.all.down.disabled = true;        
        if(document.all.top) document.all.top.disabled = true;
        if(document.all.bottom) document.all.bottom.disabled = true;
        if(document.all.save_order) document.all.save_order.disabled = true;
        if(document.all.deletebt) document.all.deletebt.disabled = true;
        if(document.all.changeState) document.all.changeState.disabled = true;
	}
	function closeWin(){
	    win.close();
	}
	function enable(){	  
	    if(document.all.newbt) document.all.newbt.disabled = false;
		if(document.all.up) document.all.up.disabled = false;
        if(document.all.down) document.all.down.disabled = false;        
        if(document.all.top) document.all.top.disabled = false;
        if(document.all.bottom) document.all.bottom.disabled = false;
        if(document.all.save_order) document.all.save_order.disabled = false;
        if(document.all.deletebt) document.all.deletebt.disabled = false;
        if(document.all.changeState) document.all.changeState.disabled = false;
	}
	function afterAddRefresh(){
	    parent.dictdataTree.location.href = parent.dictdataTree.location.href;
	    window.location.href = window.location.href;;
	}
	function afterDeleteRefresh(){
	    parent.dictdataTree.location.href = parent.dictdataTree.location.href;
	    window.location.href = "newDictdata.jsp?did=<%=did%>";
	}
	function dealRecord(dealType) {
	    var isSelect = false;
	    var outMsg;
		var selecet_value = "";   
		var arr = document.frames[0].document.getElementsByName("dictdataValue");
	    for (var i=0;i<arr.length;i++) {
			if (arr[i].checked){
		       	isSelect=true;
		       	if(selecet_value=="") selecet_value = selecet_value + arr[i].value; 
		       	else selecet_value = selecet_value + "," + arr[i].value;
			}
	    }
	    if (isSelect){
	    	if (dealType==1){
	    		outMsg = "你确定要删除吗？(删除后是不可以再恢复的)。";
	        	if (confirm(outMsg)){
					unable();				
					var path = "dictDeletedata.jsp?did=<%=did%>&infos="+selecet_value;
					win = window.showModelessDialog("doing.jsp","",featrue);
					document.dictList.action = path;
					document.dictList.submit();
					
				}
			} 
	    }else{
	    	alert("至少要选择一条记录！");
	    	return false;
	    }
		return false;
	}
	
	//高级添加
	function advance_newDict(){
	    var unableNullColumnNames = "<%=unableNullColumnNames%>";
	    if(unableNullColumnNames.length>0){
	        var msg = "<%=unableNullColumnNames%>字段是不能为空的字段,\n ";
			msg = msg + "必须在【字典高级字段配置】模块中配置为附加字段,才能进行数据采集!"
		    alert(msg);
		    return false;
	    }
	    var path = "newWin_dictdata.jsp?dicttypeId=<%=did%>&dictdataValue=<%=dictdataValue%>";
	    var featrue = "dialogWidth=600px;dialogHeight=500px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;help=0;dialogLeft="+(screen.availWidth-600)/2+";dialogTop="+(screen.availHeight-500)/2;
	    //var win = window.open(path)
	    //alert(path)
	    var win = window.showModalDialog(path,window,featrue);
	    if(win=="ok"){
	        afterAddRefresh();
	    }
	}
	
	//修改
	function advance_EditDict(){
		//var obj=document.getElementsByName("dictdataValue");
		var obj=document.frames[0].document.getElementsByName("dictdataValue");
		var checkValue = "";
		var n = 0;
		var win = "";
		var validateState = "";
		for(var i = 0; i < obj.length; i++){
			var objText = document.getElementById("a"+i);
			if(obj[i].checked){
				checkValue = obj[i].value;
				if(objText){
					validateState = objText.innerText;
				}
				n++;
				if(n > 1){
					alert("请选择一条记录修改！");
					return;
				}
			}
		}
		if(checkValue!=""){
		    var path = "EditWin_dictdata.jsp?dicttypeId=<%=ids%>&checkValue="+checkValue+"&validateState="+validateState;
		    var featrue = "dialogWidth=600px;dialogHeight=500px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;help=0;dialogLeft="+(screen.availWidth-600)/2+";dialogTop="+(screen.availHeight-500)/2;
		    //window.open(path)
		    win = window.showModalDialog(path,window,featrue);
	    }else{
	    	alert("请选择一条记录修改！");
	    	return;
	    }
	    if(win=="ok"){
		   afterAddRefresh();
		}
	}
	
	function topTr()
	{
		var all = document.frames[0].document.getElementsByName("dictdataValue");
		var flag = 0;
		for(var i=0;i<all.length;i++){
			if(all[i].checked == true){
				flag ++;
				if(flag > 1)
				{
					alert("请选择单个字典数据移动！");
					return false;
				}
			}
		}
		if(flag < 1)
		{
			alert("请选择要移动的字典数据！");
			return false;
		}
		for(var i=0;i<all.length;i++){
			upTr();
		}
	}
	function upTr()
	{
		var all = document.frames[0].document.getElementsByName("dictdataValue");
		var row;
		var flag = 0;
		for(var i=0;i<all.length;i++){
			if(all[i].checked == true){
				row = all[i];
				flag ++;
				if(flag > 1)
				{
					alert("请选择单个字典数据移动！");
					return false;
				}
			}
		}
		if(flag < 1)
		{
			alert("请选择要移动的字典数据！");
			return false;
		}
		var tmp = row;
		upRow(row);
		tmp.checked = true;
	}
	function downTr()
	{
		var all = document.frames[0].document.getElementsByName("dictdataValue");
		var row;
		var flag = 0;
		for(var i=0;i<all.length;i++){
			if(all[i].checked == true){
				row = all[i];
				flag ++;
				if(flag > 1)
				{
					alert("请选择单个字典数据移动！");
					return false;
				}
			}
		}
		if(flag < 1)
		{
			alert("请选择要移动的字典数据！");
			return false;
		}
		var tmp = row;
		downRow(row);
		tmp.checked = true;
	}
	function base() 
	{
		var all = document.frames[0].document.getElementsByName("dictdataValue");
		var flag = 0;
		for(var i=0;i<all.length;i++){
			if(all[i].checked == true){
				flag ++;
				if(flag > 1)
				{
					alert("请选择单个字典数据移动！");
					return false;
				}
			}
		}
		if(flag < 1)
		{
			alert("请选择要移动的字典数据！");
			return false;
		}
		for(var i=0;i<all.length;i++){
			downTr();
		}
	}
	//表格row上移
	function upRow(e){
		var _row=e.parentElement.parentElement;
		if(_row.previousSibling.previousSibling)
		{
			//alert(_row.previousSibling.outerHTML);
			swapNode(_row,_row.previousSibling);
		}
	}
	//表格row下移(说明注释性的文字也算 一个nextSibling）
	function downRow(e)
	{
		//通过链接对象获取表格行的引用
		var _row=e.parentElement.parentElement;
		//如果不是最后一行，则与下一行交换顺序
		if(_row.nextSibling.nextSibling)
		{	
			//alert(_row.nextSibling.outerHTML);
			swapNode(_row,_row.nextSibling);
		}

	}
	//
	function swapNode(node1,node2){
		//获取父结点
		var _parent=node1.parentNode;
		//获取两个结点的相对位置
		var _t1=node1.nextSibling;
		var _t2=node2.nextSibling;
		//将node2插入到原来node1的位置
		if(_t1)_parent.insertBefore(node2,_t1);
		else _parent.appendChild(node2);
		//将node1插入到原来node2的位置
		if(_t2)_parent.insertBefore(node1,_t2);
		else _parent.appendChild(node1);
	}
	//保存置顶顺序
	function subform()
	{
		var all = document.frames[0].document.getElementsByName("dictdataValue");
		var docid="";
		var falg = false;
		for(var i=0;i<all.length;i++){
			if(falg){
				docid += "," + all[i].value;
			}else{
				docid = all[i].value;
				falg = true;
			}
		}
		if(docid == "")
		{
			alert("该字典类型暂时没有字典数据！");
			return false;
		}
		document.forms[0].action = "save_treedict_arr.jsp?did=<%=did%>&docid=" + docid + "&dictdata=<%=dictdataValue%>";
		document.forms[0].target = "hiddenFrame";
		document.forms[0].submit();
	}
	
	function changeState_(flag){
		var all = document.frames[0].document.getElementsByName("dictdataValue");
		if(all.length==0){
			alert("该字典类型暂时没有字典数据！");
			return false;
		}
		var docid="";
		falg=false;
		for(var i=0;i<all.length;i++){ 
			if(all[i].checked){
				if(falg){
					docid += "," + all[i].value;
				}else{
					docid = all[i].value;
					falg=true;
				}
			}
		}
		if(docid == "")
		{
			alert("请选择要操作的数据！");
			return false;
		}
	    //add by ge.tao
	    //递归停用子数据
	    //0:不递归; 1:递归
	    var isRescure = "0";
	    var msg = "是否递归停用子数据项?"
	    if(flag==1){//启用
	         msg = "是否递归启用子数据项?"
	    }
	    if(flag==1){//启用 要提示
		    if(confirm(msg)){
		        isRescure = "1";
		    }
	    }else{//停用 不提示
	        isRescure = "1";
	    }
		document.forms[0].action = "changeState.jsp?did=<%=did%>&docid=" + docid + "&dictdata=<%=dictdataValue%>&flag="+flag+"&isRescure="+isRescure;
		document.forms[0].target = "hiddenFrame";
		document.forms[0].submit();
	}
	
	function listQuery(){
		var path = "newDictdataList.jsp?did=<%=ids%>&selected=<%=selected%>&dicttypeId=<%=did%>";
		//window.open(path);
		var winQuery = window.showModalDialog(path,window,"dialogWidth:"+(800)+"px;dialogHeight:"+(600)+"px;scroll=yes;status=no;titlebar=no;toolbar=no;maximize=yes;minimize=0;");
	}
	
	var num = 1;
	function queryDictItem()
	{
		var showdata = document.all.showdata.value;
		var realitydata = document.all.realitydata.value;
		var occurOrg = "";
		if(document.all.occurOrg){
			occurOrg = document.all.occurOrg.value;
		}
		var isaVailability = "-1";
		if(document.all.isaVailability){
			isaVailability = document.all.isaVailability.value;
		}
		document.getElementById("numCount").value = num;
		//var path = "newDictdata.jsp?did=<%=ids%>&showdata="+showdata+"&realitydata="+realitydata+"&occurOrg="+occurOrg+"&isaVailability="+isaVailability;
		//dictList.action=path;
		//document.location.href=path;
		//dictList.submit();	
		dictList.target = "newDictdataIframe";
		var path = "newDictdata_iframe.jsp?did=<%=ids%>&selected=<%=selected%>&dicttypeId=<%=did%>";
		dictList.action=path;
		dictList.submit();	
	}
	
	function resetQuery(){
		document.all.showdata.value="";
		document.all.realitydata.value="";
		if(document.all.occurOrg){
			document.all.occurOrg.value="";
		}
		if(document.all.isaVailability){
			document.all.isaVailability.value="-1";
		}
	}
	
	
	function highLevel(){        
        if(document.all.highLevelButton.value == "高级条件"){
            document.all.highLevel.style.display = "block";
            document.all.highLevelButton.value = "普通条件"
            document.all.isHeighlevel.value = "highlevel";
        }else{
            document.all.highLevel.style.display = "none";
            document.all.highLevelButton.value = "高级条件"
            document.all.isHeighlevel.value = "common";
        }
    }  
    window.onload = function initPage(){
        document.all.highLevelButton.value = "高级条件";
        document.all.isHeighlevel.value = "common";
    }
    
        //改变条件生成相应的html
    function queryConditionChange(obj,index,targetObj){
    	//选中条件的值
    	var selectConditionValue = obj.options[obj.selectedIndex].value;
    	var type = obj.options[obj.selectedIndex].optype;
    	var dictfield = obj.options[obj.selectedIndex].dictfield;
    	
    	var htmlStr = "";
    	if(type=="-1"){
    		htmlStr = "<input name='advancedvalue"+index+"' value='' type='text' />";
    	}else if(type=="选择机构" || type=="当前机构"){
    		htmlStr = "<input type='hidden' name='advancedvalue"+index+"' value=''>" +
    			"<input name='advancedvalue"+index+"_name' readonly='true' org_id='advancedvalue"+index+"' onclick='selectOrg(this)' style='width:200px' />";
    		targetObj.innerHTML = htmlStr;
    	}else if(type=="文本类型" || type=="text"){
    		htmlStr = "<input type='text' name='advancedvalue"+index+"' value='' style='width:200px'>";
    		targetObj.innerHTML = htmlStr;
    	}else if(type=="选择字典"){
    		var fieldNames = dictfield.split(":");
    		var fname = "";
			var dtypeId = "";
			var opcode = "";
			if(fieldNames.length==3){
				fname = fieldNames[0];
				dtypeId = fieldNames[1];
				opcode = fieldNames[2];
			}
    	    htmlStr = "<input type='hidden' name='advancedvalue" + index + "' />" +
    	    	"<iframe scrolling='no' frameborder='0' marginwidth='1' height='25' width='' name='dictSelect"+index+"' src='selectDict.jsp?dtypeId="+dtypeId+"&columnName=advancedvalue"+index +"&index"+index+"'></iframe>";    
    	    targetObj.innerHTML = htmlStr;
    	}else if(type=="选择时间" || type=="当前时间"){ 	
 			var htmlStr = "查询起止时间:" ;
			htmlStr += "<input type='text' name='startDate"+ index +"' size='20' onclick='selectTime(\"document.all.startDate"+ index +"\",0)' readonly='true'>";
			htmlStr +="到<input type='text' name='endDate"+ index +"' size='20' onclick='selectTime(\"document.all.endDate"+ index +"\",0)' readonly='true'>";
 			targetObj.innerHTML = htmlStr;
    	}else if(type=="当前用户" || type=="选择人员"){
    		htmlStr = "<input type='hidden' name='advancedvalue"+index+"' value=''>" +
    			"<input name='advancedvalue"+index+"_name' readonly='true' org_id='advancedvalue"+index+"' onclick='selectUser(this)' style='width:200px' />";
    		targetObj.innerHTML = htmlStr;
    	}else{
    		htmlStr = "<input name='advancedvalue"+index+"' value='' />";
    		targetObj.innerHTML = htmlStr;
    	}
    	
    }
    
    function returnHtmlStr(obj,index,advancedName){
    	//选中条件的值
    	var type = obj.options[obj.selectedIndex].optype;
    	var dictfield = obj.options[obj.selectedIndex].dictfield;

    	var htmlStr = "";
    	var advancedvalueObj = document.all.item(advancedName);
    	var startDD = "startDate" + index;
    	var endDD = "endDate" + index;
    	if(advancedvalueObj!=null || document.all.item(startDD)!=null || document.all.item(endDD)!=null){
	    	if(type=="-1"){
	    		htmlStr = "<input name='advancedvalue"+index+"' value='"+advancedvalueObj.value+"' type='text' />";
	    	}else if(type=="选择机构" || type=="当前机构"){
	    		var selectadvancedName = advancedName + "_name";
	    		htmlStr = "<input type='hidden' name='advancedvalue"+index+"' value='"+advancedvalueObj.value+"'>" +
	    			"<input name='advancedvalue"+index+"_name' readonly='true' org_id='advancedvalue"+index+"' onclick='selectOrg(this)' style='width:200px' value='"+document.all.item(selectadvancedName).value+"' />";
	  
	    	}else if(type=="文本类型" || type=="text"){
	    		htmlStr = "<input type='text' name='advancedvalue"+index+"' value='"+advancedvalueObj.value+"' style='width:200px'>";
	
	    	}else if(type=="选择字典"){
	    		var fieldNames = dictfield.split(":");
	    		var fname = "";
				var dtypeId = "";
				var opcode = "";
				if(fieldNames.length==3){
					fname = fieldNames[0];
					dtypeId = fieldNames[1];
					opcode = fieldNames[2];
				}
	    	    htmlStr = "<input type='hidden' name='advancedvalue" + index + "' value='"+advancedvalueObj.value+"' />" +
	    	    	"<iframe scrolling='no' frameborder='0' marginwidth='1' height='25' width='' name='dictSelect"+index+"' src='selectDict.jsp?dtypeId="+dtypeId+"&columnName=advancedvalue"+index +"&selectedId="+advancedvalueObj.value+"'></iframe>";    
	
	    	}else if(type=="选择时间" || type=="当前时间"){
	    		var startD = "startDate" + index;
	    		var endD = "endDate" + index;	
	 			var htmlStr = "查询起止时间:" ;
				htmlStr += "<input type='text' name='startDate"+ index +"' size='20' onclick='selectTime(\"document.all.startDate"+ index +"\",0)' readonly='true' value='"+document.all.item(startD).value+"'>";
				htmlStr +="到<input type='text' name='endDate"+ index +"' size='20' onclick='selectTime(\"document.all.endDate"+ index +"\",0)' readonly='true' value='"+document.all.item(endD).value+"'>";
	    	}else if(type=="当前用户" || type=="选择人员"){
	    		var selectadvancedName = advancedName + "_name";
	    		htmlStr = "<input type='hidden' name='advancedvalue"+index+"' value='"+advancedvalueObj.value+"'>" +
	    			"<input name='advancedvalue"+index+"_name' readonly='true' org_id='advancedvalue"+index+"' onclick='selectUser(this)' style='width:200px' value='"+document.all.item(selectadvancedName).value+"' />";
	    	}else{
	    		htmlStr = "<input name='advancedvalue"+index+"' value='"+advancedvalueObj.value+"' />";
	    	}
    	}else{
	    	if(type=="-1"){
	    		htmlStr = "<input name='advancedvalue"+index+"' value='' type='text' />";
	    	}else if(type=="选择机构" || type=="当前机构"){
	    		htmlStr = "<input type='hidden' name='advancedvalue"+index+"' value=''>" +
	    			"<input name='advancedvalue"+index+"_name' readonly='true' org_id='advancedvalue"+index+"' onclick='selectOrg(this)' style='width:200px' />";
	  
	    	}else if(type=="文本类型" || type=="text"){
	    		htmlStr = "<input type='text' name='advancedvalue"+index+"' value='' style='width:200px'>";
	
	    	}else if(type=="选择字典"){
	    		var fieldNames = dictfield.split(":");
	    		var fname = "";
				var dtypeId = "";
				var opcode = "";
				if(fieldNames.length==3){
					fname = fieldNames[0];
					dtypeId = fieldNames[1];
					opcode = fieldNames[2];
				}
	    	    htmlStr = "<input type='hidden' name='advancedvalue" + index + "' />" +
	    	    	"<iframe scrolling='no' frameborder='0' marginwidth='1' height='25' width='' name='dictSelect"+index+"' src='selectDict.jsp?dtypeId="+dtypeId+"&columnName=advancedvalue"+index +"'></iframe>";    
	
	    	}else if(type=="选择时间" || type=="当前时间"){ 	
	 			var htmlStr = "查询起止时间:" ;
				htmlStr += "<input type='text' name='startDate"+ index +"' size='20' onclick='selectTime(\"document.all.startDate"+ index +"\",0)' readonly='true'>";
				htmlStr +="到<input type='text' name='endDate"+ index +"' size='20' onclick='selectTime(\"document.all.endDate"+ index +"\",0)' readonly='true'>";
	    	}else if(type=="当前用户" || type=="选择人员"){
	    		htmlStr = "<input type='hidden' name='advancedvalue"+index+"' value=''>" +
	    			"<input name='advancedvalue"+index+"_name' readonly='true' org_id='advancedvalue"+index+"' onclick='selectUser(this)' style='width:200px' />";
	    	}else{
	    		htmlStr = "<input name='advancedvalue"+index+"' value='' />";
	    	}
    	}
    	
    	return htmlStr;
    }
    
    
    function changeFlag(nFlag,condition){
    	//如果num是小于且状态为0返回
		if(num <=1 && nFlag == 0){
			return;
		}
		if(nFlag == 1){
			num ++;
		}else if(nFlag == 0){
			num --;
		}
		if(num <1){
			alert('no');
			return ;
		}
		var str = "<table cellspacing='1' cellpadding='0' border='0' width=100%  class='thin'>";
		//alert(num)
		for(var i = 1; i <= num; i ++ ){
			str += '<tr><td style="text-align:left">高级字段：<select id="selectColumn'+i+'" name="highLevelColumn'+i+'"'
				+ 'onchange="queryConditionChange(this,'+i+',document.getElementById(\'query'+i+'\'))">'
				+ '<option value="">--请选择--</option>';
			<% 
					for(int z = 0; z < dictatts.size(); z++){
						DictAttachField dictatt = (DictAttachField)dictatts.get(z);
						String columnName = dictatt.getTable_column().toLowerCase();
						String dictField = dictatt.getDictField();
						String type = dictatt.getInputTypeName();
				%>
					str += '<option dictfield="<%=dictField %>" optype="<%=type%>" value="<%=columnName %>|<%=type%>"><%=dictatt.getDictFieldName()%></option>';
				<% 
					}
				%>
			
			str += '</select></td>';
			if(condition == 1){
				if(i < num){
					var obj = document.getElementById("selectColumn" + i);
					var targetObj = document.getElementById("query" + i);
					var advanced = "advancedvalue" + i;
					str += "<td style='text-align:left'><div id='query"+i+"'>";
					str += returnHtmlStr(obj,i,advanced);
					str += "</div></td>";
				}else{
					str += "<td style='text-align:left'><div id='query"+i+"'><input name='advancedvalue"+i+"' value='' type='text' /></div></td>";
				}
			}else{
				var obj = document.getElementById("selectColumn" + i);
				var targetObj = document.getElementById("query" + i);
				var advanced = "advancedvalue" + i;
				str += "<td style='text-align:left'><div id='query"+i+"'>";
				str += returnHtmlStr(obj,i,advanced);
				str += "</div></td>";
			}
			str += "</tr>";
			//str +="<td width='16%' height='30' colspan='1' align='center' valign='middle'>";
			//	str += "<select name=logical"+ i+ "><option value='and' selected>并且</option><option value='or'>或者</option><option value='and not'>不包含 </option></select>";
			//str += "</td></tr>";
		}
		str += '<tr><td width="16%" height="30" colspan="2" style="text-align:right" valign="middle">'
			+'<input name="add" type="button" class="input" value="增加" onClick="changeFlag(1,1)">&nbsp;&nbsp;'
			+'<input name="reduce" type="button" class="input" value="减少" onClick="changeFlag(0,0)">'
			+'</td></tr>';
		str += '</table>';
		rememberSelectedField();
		//rememberInputLogic();
		document.all.highLevel.innerHTML = str;
		selectField(condition);
		//selectLogic();
    }
    
    var arrSelectIndex = "";
	function rememberSelectedField()
	{
		arrSelectIndex = "";
		for(var i=1;i<=num;i++)
		{
			var selectID = "selectColumn" + i;
			if (document.all( selectID ) != null)
			{
				arrSelectIndex += document.all( selectID ).selectedIndex + "|";
				
			}
		}
		//去除最后一个|字符
		if (arrSelectIndex.length > 1)
		{
			arrSelectIndex = arrSelectIndex.substring(0,arrSelectIndex.length - 1);
		}	
		
	}

	function selectField(condition)
	{
	    var arrIndex = arrSelectIndex.split('|');
		for(var i=1;i<= num;i++)
		{
			var selectID = "selectColumn" + i;
			//下拉框的长度
			var j = document.all( selectID ).length;

			if( j > i ){
				j = i-1;
			}else{
				j = j -1;
			}

			if(condition == 1)
			{	
				if(i == num)
				{
					document.all( selectID ).options(0).selected = true;
				}
				else
				{
					document.all( selectID ).options(parseInt(arrIndex[i-1])).selected = true;
				}
			}
			else if(condition == 0)
			{
				document.all( selectID ).options(parseInt(arrIndex[i-1])).selected = true;
			}
		}
	}
	
	var arrInputLogic = "";
	function rememberInputLogic()
	{
		arrInputLogic = "";
		for(var i=1;i<= num;i++)
		{
			var selectID = "logical" + i;
			if (document.all( selectID ) != null)
			{
				arrInputLogic += document.all( selectID ).value + "|";
			}
		}
		if (arrInputLogic.length > 1)
		{
			arrInputLogic = arrInputLogic.substring(0,arrInputLogic.length - 1);
		}	
	}

	function selectLogic()
	{
	   if (arrInputLogic=='') return;
		var arrIndex = arrInputLogic.split('|');
		for(var i=1;i<= num;i++)
		{
			if (arrIndex[i-1] != null && arrIndex[i-1] != '')
			{
				var selectID = "logical" + i;
				document.all( selectID ).value=arrIndex[i-1];
			}
		}
	}

</SCRIPT>		
	<%@ include file="/epp/css/cssControl.jsp"%><body >
		<form name="dictList" method="post" target="hiddenFrame">			
			<table  width="100%" border="0"   cellpadding="0" cellspacing="1" class="thin">
			<input type="hidden" name="isHeighlevel" id="isHeighlevel" />
			<input type="hidden" name="numCount" id="numCount" />
			    <tr>
   					<td height='30'  colspan="4"><img src='../images/edit.gif' height="16" border=0 >
   					    &nbsp;<strong>【<%=dicttype_name%>-<%=description%>】数据列表</strong>
   					</td>
 				</tr>
 				<tr>
 				<td colspan="2" align="right" style="text-align:left">
 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=data_name_cn%>：<input name="showdata" value="" type="text" />
 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 				&nbsp;&nbsp;&nbsp;<%=data_value_cn%>：<input name="realitydata" value="" type="text" />
 				</td>
 				</tr>
 				<tr>
 				<td colspan="2" align="right" style="text-align:left">
 				<%if(showDataValueOrg){%>
 				采集机构：<input name="occurOrg" value="" type="text" />
 				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 				<%}%>
 				<%
 					 if(showDataValidate){
 				%>
 				是否启用：<select name="isaVailability">
			    		<option value="-1">--请选择--</option>
			    		<option value="1">启用</option>
			    		<option value="0">停用</option>
			    	    </select>
			   	<%
			   		}else{
			   	%>
			   	<input type="hidden" name="isaVailability" value="" />
			   	<%		
			   		}
			   	%>
			    </td>
 				</tr>
			    <tr>
			    </table>
				<!--高级查询-->
				<div id="highLevel" style="display:none">
				<table cellspacing="1" cellpadding="0" border="0" width=100%  class="thin">
				<tr>
				<td style="text-align:left">高级字段：<select id="selectColumn1" name="highLevelColumn1" 
				onchange="queryConditionChange(this,1,document.getElementById('query1'))">
				<option value="" optype="-1">--请选择--</option>
				<% 
					for(int z = 0; z < dictatts.size(); z++){
						DictAttachField dictatt = (DictAttachField)dictatts.get(z);
						String columnName = dictatt.getTable_column().toLowerCase();
						String dictField = dictatt.getDictField();
						String type = dictatt.getInputTypeName();
				%>
					<option dictfield="<%=dictField %>" optype="<%=type%>" value="<%=columnName %>|<%=type%>"><%=dictatt.getDictFieldName()%></option>
				<% 
					}
				%>
				</select></td>
				<td style="text-align:left">
					<div id="query1">
						<input name="advancedvalue1" value="" type="text" />
					</div>
				</td>
				<!-- 
				<td width='16%' height='30' colspan='1' align='center' valign='middle'>
					<select name=logical1">
						<option value='and' selected>并且</option>
						<option value='or'>或者</option>
						<option value='not'>不包含 </option>
					</select>
				</td>
				 -->
				</tr>
				<tr>
				<td colspan="2" width="16%" height='30' colspan="1" style="text-align:right" valign='middle'>
					<input name="add" type="button" class="input" value="增加" onClick="changeFlag(1,1)">&nbsp;&nbsp;
					<input name="reduce" type="button" class="input" value="减少" onClick="changeFlag(0,0)">
				</td>
				</tr>
				</table>
				</div>
				<table cellspacing="1" cellpadding="0" border="0" width=100%  class="thin">
			    <td colspan="2" align="right" style="text-align:right">
			    <input type="button" value="" id="highLevelButton" class="input" onclick="highLevel()"/>
			    <input name="queryBut" type="button" value="查询" class="input" onClick="queryDictItem();" />
			    <input name="resetBut" type="button" value="重置" class="input" onclick="resetQuery();" />
			    </td>
			    </tr>	
   				<tr>	
					<td  height='30' colspan="4" >
						<%
	 				        if(showOrderButton){
	 				    %>
						    <input name="top" type="button" class="input" value="移至顶部" onClick="topTr()">	
	 				        <input name="up" type="button" class="input" value="上移" onClick="upTr()">	
	 				        <input name="down" type="button" class="input" value="下移" onClick="downTr()">	
	 				        <input name="bottom" type="button" class="input" value="移至底部" onClick="base()">
	 				        <input name="bottsub" type="button" class="input" value="保存排序" onClick="subform()">
	 				    <%
	 				        }
	 				    %>	 				        
 				        						
 				        <%
						    if(showDataValidate){
						%>
 				        	<input name="changeState1" type="button" <%if(!state){%>disabled="true"<%}%> class="input" onClick="changeState_(1);" value="启用" />	
 				        	<input name="changeState0" type="button" <%if(!state){%>disabled="true"<%}%> class="input" onClick="changeState_(0);" value="停用" />						
 				        <%
 				            }
 				        %>
 				    </td>
 				</tr>
 				

			</table>
			<div style="width:100%;height:440;overflow:auto"> 
			<table cellspacing="1" cellpadding="0" border="0" width=100% height="100%"  class="thin">
   				<tr>
   					<td>
   						<iframe name="newDictdataIframe" src="newDictdata_iframe.jsp?did=<%=ids%>&selected=<%=selected%>&dicttypeId=<%=did%>" style="width:100%" height="100%" scrolling="no" frameborder="0" marginwidth="1" marginheight="1"></iframe>
   					</td>
   				</tr>
		    </table>
		    </div>
		  <div align="right" style="text-align:right">
		  <tr width="98%">
 			 <td align="right" style="text-align:right" colspan="6">    
 			 <%
 			 if(dicttype_type==DictManager.PARTREAD_BUSINESS_DICTTYPE){
 			     ResourceManager resManager = new ResourceManager();
				 String resId = dtype.getDataId();
				 if (resId != null && !resId.equals("") && accesscontroler.checkPermission(resId,
   							"datamanage", AccessControl.DICT_RESOURCE)){ //采集数据
 			 %>    								    
				 <input name="advance_newbt" type="button" class="input" value="添加" onClick="advance_newDict()">
			 <%
			     }
			     if (resId != null && !resId.equals("") && accesscontroler.checkPermission(resId,
   							"edit", AccessControl.DICT_RESOURCE)){ //数据编辑
			 %>	 		 
				 <input name="advance_updatebt" type="button" class="input" value="修改" onClick="advance_EditDict()">
			 <%
			     }
			     if (resId != null && !resId.equals("") && accesscontroler.checkPermission(resId,
   							"delete", AccessControl.DICT_RESOURCE)){ //数据删除
			 %>
				 <input name="deletebt" <%if(!stateDel){%>disabled="true"<%}%> type="button" value="删除" class="input" onclick="javascript:dealRecord(1); return false;">
			 <%
			     }
			 }else{
			 %>	 
			     <input name="advance_newbt" type="button" class="input" value="添加" onClick="advance_newDict()">
			     <input name="advance_updatebt" type="button" class="input" value="修改" onClick="advance_EditDict()">
			     <input name="deletebt" <%if(!stateDel){%>disabled="true"<%}%> type="button" value="删除" class="input" onclick="javascript:dealRecord(1); return false;">
			 <%
			 }
			 %>
				 <input name="queryG" class="input" type="button" value="新窗口打开" onclick="listQuery();" />
			 </td>		
		  </tr>
		  </div>
		</form>
		<iframe height="0" width="0" name="hiddenFrame"></iframe>
	</body>
		
</html>

