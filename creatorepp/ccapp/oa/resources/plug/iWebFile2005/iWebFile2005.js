var str = '';
var ProjectName = "/" + window.location.pathname.substring(1).split("/")[0];
ProjectName += '/ccapp/oa/resources/plug/iWebFile2005/';
str += '<OBJECT id="iWebFile" width=100% height=100% classid="clsid:074106C0-5E71-4151-9CE8-9B024485B58F" codebase="'
		+ ProjectName + 'iWebFile2005.cab#version=6,0,0,0"';
str += '<param name="ShowBreakpointMsg" value=true>';
str += '</OBJECT>';
document.write(str);