var DataStore = function(){
	this.callback = null;
	this.requestsJson = [];
	this.regRequest = function(dataset){
		dataset.DID = dataset.id;
		dataset.datastore = this;
	}
};
DataStore.prototype = (function(){
	var _defaultProcessServlet = "WebBill";
    var SendAllRequest = function(){
    	var xmlstr ="<root>";
    	for(var i=0;i<this.requestsJson.length;i++){
    		xmlstr += "<dataset id='"+this.requestsJson[i].dataset+"'><requeststr>"+this.requestsJson[i].requeststr+"</requeststr><key>"+this.requestsJson[i].key+"</key></dataset>";
    	}
    	xmlstr +="</root>";
        SendHttp(location.protocol+"//"+location.host+ fcpubdata.servletPath +_defaultProcessServlet+ "?key=datastore",xmlstr,this.callback);
    };
    var getDataById = function(datasetId){
        alert(2);
    };
    return {SendAllRequest:SendAllRequest,getDataById:getDataById};
})();
