/**
 * 弹出意见填写框。
 * @param ideaid
 */
//弹出意见框
function inputidea(table,column,cntab){
	
	var path = getContextPath()+"/ccapp/oa/archive/wordsign.jsp?table="+table+"&column="+column;
	if(cntab){//如果缩进不为空，那么传入改属性
		path = path +"&cntab="+cntab; 
	}
	//var path =  getCurrentFilePath()+"inputideaarea.jsp?table="+table+"&column="+column;
	openAlertWindows('windowId',path,'签阅意见',800,240,'25%','25%');
}

var inputideaareaJS = {};

inputideaareaJS.showAllView = function(insid,table,column){
	var path = [
		getContextPath()+"/ccapp/oa/archive/showallview.jsp",
		"?table="+table,
		"&column="+column,
		"&insid="+insid
	];
	openAlertWindows('windowId',path.join(''),'签阅意见',800,540,'25%','25%');
}