//��ѡ��ȫ��ѡ��
function checkAll(totalCheck,checkName){
   var selectAll = document.getElementsByName(totalCheck);
   var o = document.getElementsByName(checkName);
   if(selectAll[0].checked==true){
	   for (var i=0; i<o.length; i++){
      	  if(!o[i].disabled){
      	  	o[i].checked=true;
      	  }
	   }
   }else{
	   for (var i=0; i<o.length; i++){
   	  	  o[i].checked=false;
   	   }
   }
}
//����ѡ�и�ѡ��
function checkOne(totalCheck,checkName){
   var selectAll = document.getElementsByName(totalCheck);
   var o = document.getElementsByName(checkName);
	var cbs = true;
	for (var i=0;i<o.length;i++){
		if(!o[i].disabled){
			if (o[i].checked==false){
				cbs=false;
			}
		}
	}
	if(cbs){
		selectAll[0].checked=true; 
	}else{
		selectAll[0].checked=false;
	}
}
  function openWin(url,swidth,sheight){
	     var w = showModalDialog(url,window,"dialogWidth:"+swidth+"px;dialogHeight:"+sheight+"px;help:no;scroll:auto;status:no");
		 return w;
	}
//���������ʾ�	
function newq(channel)
{
	openWin('questionnaire.jsp?channel='+channel,800,window.screen.availHeight);
}
//�޸ĵ����ʾ�
function modify(id,channel){
	openWin('questionnaire.jsp?id='+id+'&channel='+channel,800,window.screen.availHeight);
}
//�鿴ͳ�ƽ��	
function getResult(id){
	openWin('seeresult_bz.jsp?titleid='+id+'&opid=1',800,window.screen.availHeight);
}
//
function audit(id){
	openWin('answerlist.jsp?id='+id,800,window.screen.availHeight);
}
//�鿴�����ʾ�
function view(id,channel)
{
	openWin('voteListView.jsp?channel='+channel+'&id='+id,800,window.screen.availHeight);
}
function listquestion(channel)
{
	window.location.href="questionList.jsp?channel="+channel; 
}
//����select�����б��ֵ
function selectValue(selCtrl,v){
	selCtrl = document.all(selCtrl);
	for(var i=0;i<selCtrl.options.length;i++){
		if (selCtrl.options[i].value == v){
			selCtrl.options[i].selected = true;
			return;
		}
	}
}
//����radiobox��ֵ	
function checkRadiobox(radiobox,v){
	radiobox = document.getElementsByName(radiobox);
	for(var i=0;i<radiobox.length;i++){
		if (radiobox[i].value == v){
			radiobox[i].checked = true;
			return;
		}
	}
}
//��������js	
function getQstionTblScript(tblName){
	var questionTable = "<table width='100%'  name='"+tblName+"' id='"+tblName+"' ><tr><td ><strong>��Ŀ��</strong></td><td ><input name='"+tblName+"Qstion' id='"+tblName+"Qstion' type='text' size='60'><input name='"+tblName+"Qstion_id' id='"+tblName+"Qstion_id' type='hidden' value='0' size='5'><input name='"+tblName+"VoteCount' id='"+tblName+"VoteCount' type='hidden' value='0' size='5'><input type='button' name='Submit42' value='ɾ��' onclick=\"return delQstion('"+tblName+"')\"  class='cms_button'></td></tr><tr><td>�ش�ʽ��</td><td><input type='radio' name='"+tblName+"Style' id='"+tblName+"Style' value='0' onClick='return changeStyle(\""+tblName+"\")'>��ѡ<input type='radio' name='"+tblName+"Style' id='"+tblName+"Style' value='1' onClick='return changeStyle(\""+tblName+"\")'>��ѡ <input type='radio' name='"+tblName+"Style' id='"+tblName+"Style' value='2' onClick='return clearOption(\""+tblName+"\")'>���ɻش�</td></tr><tr><td>ѡ�</td><td><input type='button' name='"+tblName+"AddBtn' value='���ѡ��' onclick='return addOption(\""+tblName+"\")'  class='cms_button'><input type='button'name='"+tblName+"DelBtn' value='ɾ��ѡ��' onclick='return delOption(\""+tblName+"\")'  class='cms_button'></td></tr><tr><td>&nbsp;</td><td><table name='"+tblName+"OptinTbl' id='"+tblName+"OptinTbl'><tbody></tbody></table></td></table></td></tr></table>";
	return questionTable;
}
//����ѡ��js	
function getOptionTblScript(tblName){
	var op = "*<input type='checkbox' name='"+tblName+"Chkbx' id='"+tblName+"Chkbx' value='checkbox'><input name='"+tblName+"Option' id='"+tblName+"Option' type='text' size='50'><input name='"+tblName+"Option_id' id='"+tblName+"Option_id' type='hidden' value='0' size='5'><input name='"+tblName+"Count' id='"+tblName+"Count' type='hidden' value='0' size='5'>";
	return op;
}

function HTMLEncode(text){
	return text;
}
//�༭�����������ģʽ
function init() {
	eWebEditor1.setMode('EDIT');
	eWebEditor1.eWebEditor.document.body.innerHTML=form1.content.value;
}
var tableNames = "qstionTbl1;";
var tableIndex = 1;
//��������	
function addQuestion(){
	var tbl = document.all("qstTable");
	var row = tbl.insertRow();
	var td = document.createElement("td");
	tableIndex ++;
	td.innerHTML = getQstionTblScript("qstionTbl"+tableIndex);
	tableNames += "qstionTbl"+tableIndex+";";
	row.appendChild(td);
	document.all("qstionTbl"+tableIndex+"AddBtn").disabled = true;
	document.all("qstionTbl"+tableIndex+"DelBtn").disabled = true;
}
//ɾ������	
function delQstion(tblName){
	var re = new RegExp(tblName+";","g");
	tableNames = tableNames.replace(re,"");
	var tbody = document.all(tblName).parentElement.parentElement.parentElement;
	tbody.removeChild(document.all(tblName).parentElement.parentElement)
}
//����ѡ��	
function addOption(tblName){
	var tbl = document.all(tblName+"OptinTbl");
	var row = tbl.insertRow();
	var td = document.createElement("td");
	td.innerHTML = getOptionTblScript(tblName);
	row.appendChild(td);
}
//ɾ��ѡ��	
function delOption(tblName){
	var chckbxs = document.getElementsByName(tblName+"Chkbx");
	for (var i=0;i<chckbxs.length;i++){
		if (chckbxs[i].checked){
			var tbody1= chckbxs[i].parentElement.parentElement.parentElement;
			tbody1.removeChild(chckbxs[i].parentElement.parentElement);
			i--;
		}
	}
}
//���ѡ��	
function clearOption(tblName){
	var chckbxs = document.getElementsByName(tblName+"Chkbx");
	for (var i=0;i<chckbxs.length;i++){
			var tbody1= chckbxs[i].parentElement.parentElement.parentElement;
			tbody1.removeChild(chckbxs[i].parentElement.parentElement);
			i--;
	}
	document.all(tblName+"AddBtn").disabled = "true";
	document.all(tblName+"DelBtn").disabled = "true";
}
//�޸Ļش�ʽ	
function changeStyle(tblName){
	if (document.all(tblName+"AddBtn").disabled){
		document.all(tblName+"AddBtn").disabled = false;
		document.all(tblName+"DelBtn").disabled = false;
		addOption(tblName);
	}
}
//����IPѡ��	
function addIpCtrl(){
	var tbl = document.all("ipTable");
	var row = tbl.insertRow();
	var td = document.createElement("td");
	td.innerHTML = "*<input type='checkbox' name='ipCtrlChlbx' value='checkbox'><input type='text' name='ipCtrlStart'>&nbsp;��&nbsp;<input type='text' name='ipCtrlEnd'>";
	row.appendChild(td);
}
//ɾ��IPѡ��	
function delIpCtrl(){
	var chckbxs = document.getElementsByName("ipCtrlChlbx");
	for (var i=0;i<chckbxs.length;i++){
		if(chckbxs[i].checked){
			var tbody1= chckbxs[i].parentElement.parentElement.parentElement;
			tbody1.removeChild(chckbxs[i].parentElement.parentElement);
			i--;
		}
	}
}
//�����ʾ�	
function save(todayTime){
	if(document.all("titleName").value.replace(/ /gi,'')==""){
		alert("�ʾ����Ʋ���Ϊ�գ�");
		return;
	}
	if(document.all("titleName").value.length>100)
	{
	  alert("�ʾ������������ܳ���100��");
	  return false;
	}
	
	if(document.all("depart_id").value==""){
		alert("�������Ų���Ϊ�գ�");
		return;
	}
	document.all("ipStartString").value = "";
	document.all("ipEndString").value = "";
	
	//ip constrain
	var ipCtrlStartArray = document.getElementsByName("ipCtrlStart");
	var ipCtrlEndArray = document.getElementsByName("ipCtrlEnd");
	for (var i=0;i<ipCtrlStartArray.length;i++){
		if (!checkIP(ipCtrlStartArray[i].value)){
			alert("IP��ַ��ʽ����!!��ֻ���������ֺ͡�.��,��ʽΪXXX.XXX.XXX.XXX ���磺192.168.0.1");
			//ipCtrlStartArray[i].focus();
			return ;
		}
		if (ipCtrlStartArray[i].value > ipCtrlEndArray[i].value){
			alert("��ʼIPӦС����ֹIP��");
		//	ipCtrlStartArray[i].focus();
			return;
		}
		document.all("ipStartString").value += ipCtrlStartArray[i].value+";";
	}
	for (var i=0;i<ipCtrlEndArray.length;i++){
		if (!checkIP(ipCtrlEndArray[i].value)){
			alert("IP��ַ��ʽ����!!��ֻ���������ֺ͡�.��,��ʽΪXXX.XXX.XXX.XXX ���磺192.168.0.1");
		//	ipCtrlEndArray[i].focus();
			return ;
		}
		document.all("ipEndString").value += ipCtrlEndArray[i].value+";";
	}
	
	//time constrain
	//var timeCtrlStartArray = document.getElementsByName("timeCtrlStart");
	//var timeCtrlEndArray = document.getElementsByName("timeCtrlEnd");
	document.all("timeStartString").value = "";
	//for (var i=0;i<timeCtrlStartArray.length;i++){
		if (document.all("timeCtrlStart").value==""){
			alert("ʱ������Ʋ���Ϊ�գ�");
		//	timeCtrlStartArray[i].focus();
			return;
		}
		if (document.all("timeCtrlEnd").value==""){
			alert("ʱ������Ʋ���Ϊ�գ�");
		//	timeCtrlEndArray[i].focus();
			return;
		}
		
		if (document.all("timeCtrlStart").value > document.all("timeCtrlEnd").value){
			alert("��ʼʱ��ӦС����ֹʱ�䣡");
		//	timeCtrlStartArray[i].focus();
			return;
		}
		if(document.all("timeCtrlEnd").value<todayTime.substring(0,10))
		{
		  alert("ʱ��β�ӦС�ڵ�ǰʱ�䣡");
		  return false;
		}
		document.all("timeStartString").value = document.all("timeCtrlStart").value+";";
		
	//}
	//for (var i=0;i<timeCtrlEndArray.length;i++){
		document.all("timeEndString").value = document.all("timeCtrlEnd").value+";";
	//}
	 eWebEditor1.setMode('EDIT');
     form1.content.value=HTMLEncode(eWebEditor1.eWebEditor.document.body.innerHTML);
     if(form1.content.value.lenght<1)
     {
       alert("�ʾ���������Ϊ�գ�");
       return false;
     }
	//construct questioin and options string. 
	//Format is like <questioin?style?option1;option2;><questioin?style?option1;option2;><questioin?style?option1;option2;>
	var questionString = ""
	var tableNameArray = tableNames.split(";");
	for (var i=0;i<tableNameArray.length-1;i++){
		var tblName = tableNameArray[i];
		//get question
		var qstion = document.all(tblName+"Qstion").value.replace(/\?/gi,'');
		var qstion_id = document.all(tblName+"Qstion_id").value;
		var voteCount = document.all(tblName+"VoteCount").value;
		if (qstion.replace(/ /gi,'')==""){
			alert("����д���⣡");
		//	document.all(tblName+"Qstion").focus();
			return;
		}
		if(document.all(tblName+"Qstion").value.length>100)
		{
		  alert("�����������ܳ���100��");
		  return false;
		}
		//get style
		var styleChckbx =  document.all(tblName+"Style");
		for (var j=0;j<styleChckbx.length;j++){
			if(styleChckbx[j].checked == true){				
				styleChckbx = styleChckbx[j].value;
				break;
			}
		}
		if (styleChckbx[1]!=null){
			alert("��ָ���ش�ʽ��");
		//	styleChckbx[0].focus();
			return;
		}
		//get options
		
		var optionString = "";
		var countString = "";
		var option_id = "";
		if(styleChckbx!=2)
		{
		var optionText = document.getElementsByName(tblName+"Option");
		var countText = document.getElementsByName(tblName+"Count");
		var option_idText = document.getElementsByName(tblName+"Option_id");
		if (styleChckbx!=2 && (optionText==null||optionText.length==0)){
			alert("������ѡ����Ϣ��");
			return;
		}
		for (var j=0;j<optionText.length;j++){
			if (optionText[j].value.replace(/ /gi,'')==""){
				alert("������ѡ����Ϣ��");
			//	optionText[j].focus();
				return;
			}
			optionString += optionText[j].value
							.replace(/;/gi,',')
							.replace(/\>/gi,'��')
							.replace(/\</gi,'��')
							.replace(/'/gi,'`')+";";
			option_id += option_idText[j].value + ";";
			countString += countText[j].value + ";";
		}
		}
		qstion = qstion.replace(/\>/gi,'��').replace(/\</gi,'��');
		questionString += "<"+qstion+"'"+qstion_id+"'"+voteCount+"'"+styleChckbx+"'"+optionString+"'"+option_id+"'"+countString+">";
	}
	
	document.all("questionString").value= questionString;
	document.all("actionType").value= "save";
	document.form1.target = "biaoge";
	document.form1.submit();
}
	
function checkIP(ip){
	var format = /(\d+)\.(\d+)\.(\d+)\.(\d+)/;
	if (ip.replace(format,"").length>0){
		return false;
	}
	
	var array = ip.split(".");
	if (array.length != 4)
		return false;
		
	for (var i=0;i<array.length;i++)
		if (array[i]>255 || array[i]<0)
			return false;
			
	return true;
}
	
function chkTimeGap(){
	var repeatChkbx= document.all("can_repeat");
	if (repeatChkbx.checked){
		document.all("selectGap").disabled = false;
	}else{
		document.all("selectGap").options[0].selected = true;
		document.all("selectGap").disabled = true;
	}
}
	
function del(){
	if (confirm("�Ƿ���Ҫɾ�����ʾ�")){
		document.all("actionType").value= "delete";
		document.form1.submit();
	}
}


function myAction(type,channel){
	obj = document.getElementsByName("checkBoxOne");
	var c =0;
	var titleids="-1";
	for (i=0;i<obj.length;i++){
		if (obj[i].checked){
		 
		
			c++;
			break;
		}
		
	}
	
	for (i=0;i<obj.length;i++){
		
		if (obj[i].checked){
		
		titleids+= ","+obj[i].value;		
		}
	}

	if (c == 0){
		alert("����ѡ��");
		return;
	}
	
	if (type=='modify'){
		document.forms[0].actioinType.value = "modify";
		document.voteList.submit();
	}
	if (type=='delete'){
		if(!confirm("�Ƿ�Ҫɾ��ѡ�"))
			return;
		var url = "operationOfVote.jsp?actionType=delete&channel="+channel+"&titleID="+titleids;
		document.voteList.action = url;
		document.voteList.method = "post";
		document.voteList.target = "hidFrm";
	    document.voteList.submit();
		//window.showModalDialog(url,window,'');
	}
	if (type=='settop'){
		titleids = titleids.split(",");
		if(titleids.length>2)
		{
		  alert("ֻ���ö�һ����");
		  return false;
		}
		var url = "operationOfVote.jsp?actionType=settop&channel="+channel+"&titleID="+titleids[1];
		document.voteList.action = url;
		document.voteList.method = "post";
		document.voteList.target = "hidFrm";
	    document.voteList.submit();
		//window.showModalDialog(url,window,'');
	}
	if(type=='canceltop')
	{
		titleids = titleids.split(",");
		var url = "operationOfVote.jsp?actionType=canceltop&channel="+channel+"&titleID="+titleids[1];
		document.voteList.action = url;
		document.voteList.method = "post";
		document.voteList.target = "hidFrm";
	    document.voteList.submit();
		//window.showModalDialog(url,window,'');
		
	}
	if (type=='cancellook'){
		var url = "operationOfVote.jsp?actionType=cancellook&channel="+channel+"&sids="+titleids;
		document.voteList.action = url;
		document.voteList.method = "post";
		document.voteList.target = "hidFrm";
	    document.voteList.submit();
		//window.showModalDialog(url,window,'');
		
	}
	if (type=='look'){
		var url = "operationOfVote.jsp?actionType=look&channel="+channel+"&sids="+titleids;
		document.voteList.action = url;
		document.voteList.method = "post";
		document.voteList.target = "hidFrm";
	    document.voteList.submit();
		//window.showModalDialog(url,window,'');
	}
	if(type=='clearvote')
	{
	  if(confirm("��ȷ��Ҫ�����ѡ�����ͶƱ�����"))
	  {
	    // titleids = titleids.split(",");
	     var url = "operationOfVote.jsp?actionType=clearvote&channel="+channel+"&titleID="+titleids;
	     document.voteList.action = url;
		document.voteList.method = "post";
		document.voteList.target = "hidFrm";
	    document.voteList.submit();
		 //window.showModalDialog(url,window,'');
		 
	  }
	}
	if (type=='copy'){
		var copyTitleIds = titleids.split(',');
		if(copyTitleIds.length>2)
		{
			alert("ֻ��ѡ��һ����¼��");
			return false;
		}
		else
		{
			titleids = copyTitleIds[1];
		}
		openWin('copyOfQuestionnaire.jsp?id='+titleids+'&channel='+channel,window.screen.availWidth,window.screen.availHeight);
		
	}
}

function havealook(id){
	openWin('surveyPreview.jsp?id='+id,800,window.screen.availHeight);
}


function clean(){
    document.all("surveyTitle").value= "";
	document.all("createDateFrom").value = "";
	document.all("createDateTo").value = "";
	document.all("active")[2].checked = true;
	document.voteList.submit();
}

function cleanpart(){
	document.voteList.action="votelist.jsp?actionType=search";
	
	var createDateFrom = document.all.createDateFrom.value;
	var createDateTo = document.all.createDateTo.value;
	if(createDateTo.length>0 && createDateFrom.length>0)
	if(createDateTo<createDateFrom)
	{
		alert("����ʱ�䲻��С�ڿ�ʼʱ��!");
		return false;
	}
	//bug432:����ʱ�䲻��С�ڿ�ʼʱ��,weida
	
	document.voteList.submit();
}
	function surveyActivate(channel){
		var sids = "-1";
		
		var obj = document.getElementsByName("checkBoxOne");
		for (var i=0;i<obj.length;i++){
			if (obj[i].checked){
				sids += ","+obj[i].value;
			}
		}
		if (sids=='-1'){
			alert("����ѡ��!");
			return;
		}
		if (!confirm("�Ƿ�Ҫ�����Щ����?"))
			return;
		var url = "operationOfVote.jsp?actionType=active&channel="+channel+"&sids="+sids;
		document.voteList.action = url;
		document.voteList.method = "post";
		document.voteList.target = "hidFrm";
	    document.voteList.submit();
		//window.showModalDialog(url,window,'');
	}
	
	function surveyUnActivate(channel){
		var sids = "-1";
		
		var obj = document.getElementsByName("checkBoxOne");
		for (var i=0;i<obj.length;i++){
			if (obj[i].checked){
				sids += ","+obj[i].value;
			}
		}
		if (sids=='-1'){
			alert("����ѡ��!");
			return;
		}
		if (!confirm("�Ƿ�Ҫȡ�������Щ����?"))
			return;
		var url = "operationOfVote.jsp?actionType=unactive&channel="+channel+"&sids="+sids;
		document.voteList.action = url;
		document.voteList.method = "post";
		document.voteList.target = "hidFrm";
	    document.voteList.submit();
		//window.showModalDialog(url,window,'');
		
	}


  	var fileFlag;
	function chooseImage(){
		fileFlag = "pic";
		openWin("/cms/channelManage/chooseImageFrameset.jsp?fileFlag=picOrFlash",700,580);
	}
function setImage(uri){
		document.all("picpath").value  = uri;
}
	function addOrg()
{
  var org = openWin('/comm/departManager/departSelect/orgsuborg.jsp','616','500') ;
  if(org != null && org != "" )
  {
  	var arr = org.split("=");	
  	document.getElementById("depart_id").value = arr[0] ;
  	document.getElementById("orgName").value = arr[1] ;
  }
}
function selectDepart(id,name) {
	var url = "/comm/departManager/radioSelect/tree.jsp?displayIdInput="+id+"&displayNameInput="+name;
	openWin(url, "300", "500");
}