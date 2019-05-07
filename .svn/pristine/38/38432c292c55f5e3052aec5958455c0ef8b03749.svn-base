  //复选框全部选中
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
	//单个选中复选框
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
	function audit(id){
		var url="answer_view.jsp?id="+id;
	 	openWin(url,800,window.screen.availHeight);
	 }
	 
	 function view(id)
	 {
	 	openWin('answerlist.jsp?id='+id,800,window.screen.availHeight);
	 }
	