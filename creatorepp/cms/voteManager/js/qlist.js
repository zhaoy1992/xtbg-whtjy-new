	function checkAll(totalCheck,checkName){	//复选框全部选中
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
	function return2(channel)
	{
	  document.location.href="votelist.jsp?channel="+channel;
	}
	function questionUpdate(id){
		window.open('questionnaire.jsp?qid='+id,'mywindow','toolbar=no,left=100,top=0,width=700,scrollbars=yes,height=600,menubar=no,systemMenu=no');
	}
	
	function seeIP(id)
	{
		//window.open('seeIP.jsp?qid='+id,'mywindow','toolbar=no,left=100,top=100,width=600,scrollbars=yes,height=530,menubar=no,systemMenu=yes');
		window.showModalDialog('seeIP.jsp?qid='+id,window,'dialogWidth:600px;dialogHeight:530px;center:yes;status:no;scroll:yes;help:no');
	}
	
	function  questionDelete(){
			
		document.all("qids").value = "-1";
		
		var obj = document.getElementsByName("checkBoxOne");
		for (var i=0;i<obj.length;i++){
			if (obj[i].checked){
				document.all("qids").value += ","+obj[i].value;
			}
		}
		if (document.all("qids").value=='-1'){
			alert("请作选择!");
			return;
		}
		if (!confirm("是否要删除这些问题?"))
			return;
		document.all("actionType").value ="delete";
		document.questionList.submit();
	}
	
	function questionActivate(){
		document.all("qids").value = "-1";
		
		var obj = document.getElementsByName("checkBoxOne");
		for (var i=0;i<obj.length;i++){
			if (obj[i].checked){
				document.all("qids").value += ","+obj[i].value;
			}
		}
		if (document.all("qids").value=='-1'){
			alert("请作选择!");
			return;
		}
		if (!confirm("是否要审核这些问题?"))
			return;
			
		document.all("actionType").value ="active";
		document.questionList.submit();
	}
	
	function questionUnActivate(){
		document.all("qids").value = "-1";
		
		var obj = document.getElementsByName("checkBoxOne");
		for (var i=0;i<obj.length;i++){
			if (obj[i].checked){
				document.all("qids").value += ","+obj[i].value;
			}
		}
		if (document.all("qids").value=='-1'){
			alert("请作选择!");
			return;
		}
		if (!confirm("是否要取消审核这些问题?"))
			return;
		document.all("actionType").value ="unactive";
		document.questionList.submit();
	}
	
	function setTop(){
		document.all("qids").value = "";
		
		var obj = document.getElementsByName("checkBoxOne");
		for (var i=0;i<obj.length;i++){
			if (obj[i].checked){
				document.all("qids").value = obj[i].value;
				break;
			}
		}
		if (document.all("qids").value==""){
			alert("请作选择!");
			return;
		}
		
		document.all("actionType").value ="settop";
		document.questionList.submit();
	}
	
function query(){
		
		document.questionList.submit();
	}
	
function clean(){
	document.all("surveyName").value = "";
	document.all("active")[2].checked = true;
	document.questionList.submit();
}