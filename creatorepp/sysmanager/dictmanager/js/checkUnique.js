var sendHttpRequestPath = "checkUnique.jsp";
var http_request;
var fieldObj ;
var fieldObj_name ;
function send_request(obj,dicttypeId) {
    if(obj.value.replace(/(^\s*) |(\s*$)/g, "").length==0){
        return ;
    }
    fieldObj = obj
    http_request = false;
    var url = sendHttpRequestPath + "?dicttypeId="+dicttypeId+"&fieldName="+obj.name+"&fieldValue="+obj.value;
    if(window.XMLHttpRequest) {
        http_request = new XMLHttpRequest();
        if (http_request.overrideMimeType) {
            http_request.overrideMimeType('text/xml');
        }
    }
    else if (window.ActiveXObject) {
        try {
            http_request = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                http_request = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {}
        }
    }
    if (!http_request) {
        window.alert("���ܴ���XMLHttpRequest����ʵ��.");
        return false;
    }
    http_request.onreadystatechange = processRequest;
    http_request.open("POST", url, true);
    http_request.send(null);
}
//�޸��ֵ�����ʱ�����ô˺���..
function send_request_update(obj,dicttypeId,val) {
    if(obj.value.replace(/(^\s*) |(\s*$)/g, "").length==0){
        return ;
    }
    if(obj.value==val){
    	return;
    }
    fieldObj = obj
    http_request = false;
    var url = sendHttpRequestPath + "?dicttypeId="+dicttypeId+"&fieldName="+obj.name+"&fieldValue="+obj.value;
    if(window.XMLHttpRequest) {
        http_request = new XMLHttpRequest();
        if (http_request.overrideMimeType) {
            http_request.overrideMimeType('text/xml');
        }
    }
    else if (window.ActiveXObject) {
        try {
            http_request = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                http_request = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {}
        }
    }
    if (!http_request) {
        window.alert("���ܴ���XMLHttpRequest����ʵ��.");
        return false;
    }
    http_request.onreadystatechange = processRequest;
    http_request.open("POST", url, true);
    http_request.send(null);
}


//ѡ����Ա��ѡ�����ʱ�����������--obj���صĶ���
function send_request_name(obj,obj_name,dicttypeId) {
    if(obj.value.replace(/(^\s*) |(\s*$)/g, "").length==0){
        return ;
    }
    fieldObj_name = obj;
    fieldObj = obj_name;
    http_request = false;
    var url = sendHttpRequestPath + "?dicttypeId="+dicttypeId+"&fieldName="+fieldObj_name.name+"&fieldValue="+fieldObj_name.value;
    if(window.XMLHttpRequest) {
        http_request = new XMLHttpRequest();
        if (http_request.overrideMimeType) {
            http_request.overrideMimeType('text/xml');
        }
    }
    else if (window.ActiveXObject) {
        try {
            http_request = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                http_request = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {}
        }
    }
    if (!http_request) {
        window.alert("���ܴ���XMLHttpRequest����ʵ��.");
        return false;
    }
    http_request.onreadystatechange = processRequest;
    http_request.open("POST", url, true);
    http_request.send(null);
}

//ѡ���ֵ���øú���   isNull�Ƿ�Ϊ�գ�isUnique�Ƿ��ظ�---ѡ���ֵ䲻����Ψһ
function send_requestSelect(obj,isNull,isUnique,dicttypeId) {
    if(obj.value.replace(/(^\s*) |(\s*$)/g, "").length==0){
        return ;
    }
    fieldObj_name = obj;
    http_request = false;
    var url = sendHttpRequestPath + "?dicttypeId="+dicttypeId+"&fieldName="+obj.name+"&fieldValue="+obj.value;
    if(window.XMLHttpRequest) {
        http_request = new XMLHttpRequest();
        if (http_request.overrideMimeType) {
            http_request.overrideMimeType('text/xml');
        }
    }
    else if (window.ActiveXObject) {
        try {
            http_request = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                http_request = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {}
        }
    }
    if (!http_request) {
        window.alert("���ܴ���XMLHttpRequest����ʵ��.");
        return false;
    }
    http_request.onreadystatechange = processRequest;
    http_request.open("POST", url, true);
    http_request.send(null);
}

function processRequest() {
    if (http_request.readyState == 4) {
        if (http_request.status == 200) {
           var restr = http_request.responseText.replace(/(^\s*) |(\s*$)/g, ""); 
           if(restr.length>0){
               alert("ֵ�ظ�!���������");
               fieldObj.value = "";
               fieldObj.focus();
               fieldObj = null;
               if(fieldObj_name){
               	fieldObj_name.value = "";
               	fieldObj_name = null;
               }
               return ;
           }
            
        } else { 
            alert("���������ҳ�����쳣��");
        }
       fieldObj = null;
       fieldObj_name = null;
    }
    
}

function selectOrg(obj){
	var oldValue = '';
	var org_id = obj.org_id;   
	
	var valueWin = window.showModalDialog('orgSelectTree.jsp?orgNames='+obj.value,window,'dialogWidth:'+(400)+'px;dialogHeight:'+(600)+'px;help:no;scroll:auto;status:no');
	if(valueWin!=null){
		var restr = valueWin; 
		obj.value = valueWin.split('\^')[0]; 
		document.all.item(org_id).value=valueWin.split('\^')[1];
	}
}

function selectUser(obj){
	var oldValue = '';
	var org_id = obj.org_id;   
	
	var valueWin = window.showModalDialog('selectexecutor.jsp?userNames='+obj.value,window,'dialogWidth:'+(850)+'px;dialogHeight:'+(600)+'px;help:no;scroll:auto;status:no');
	if(valueWin!=null){
		var restr = valueWin; 
		obj.value = valueWin.split('\^')[0]; 
		document.all.item(org_id).value=valueWin.split('\^')[1];
	}
}