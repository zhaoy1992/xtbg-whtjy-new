/**
 * var url='http://localhost:8888/test.jsp?arg='+toUN.on(a);
 */
var toUN = {    
   
    on : function (str) { 
        if(str.replace(/\s+/g,"").length==0){
    	return "";
    	}   
        var a = [], i = 0;    
            
        for (; i < str.length ;) a[i] = ("00" + str.charCodeAt(i ++).toString(16)).slice(-4);    
            
        return "\\u" + a.join("\\u");    
    },    
        
    un : function (str) {    
        return unescape(str.replace(/\\/g, "%"));    
    }    
        
};    