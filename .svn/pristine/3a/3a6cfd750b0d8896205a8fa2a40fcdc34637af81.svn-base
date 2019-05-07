//author:zuojian.xiang
var formatXmlStr = function(xmlstr,dataset){
	xmlstr = xmlstr.replace(/\r?\n/g,"");
	var forRegex = RegExp("<(/?)td>");
	var tdregex = RegExp("(<td>)(.*?)(<\/td>)");
	var replaceArr = dataset.Fields.Field;
	var tdlength = replaceArr.length;
	for(var i=0;forRegex.test(xmlstr);i++){
		xmlstr = xmlstr.replace(tdregex,'<'+replaceArr[i%tdlength].FieldName+'>$2</'+replaceArr[i%tdlength].FieldName+'>');
	}
	return xmlstr;
};

var creator_pt_getmapping = function(arg){	
	var temparr;
	try{
		temparr = arg.Fields.Field;
	}catch(e){
		//alert(e.message);
	}var retstr = "[";
	for(var i=0;i<temparr.length;i++){
		retstr += "{name: '"+temparr[i].FieldName.toLowerCase()+"', mapping: '"+temparr[i].FieldName+"'";
		if(temparr[i].DataType=="日期"){
			retstr += ",type:'date'";
			if(IsSpace(temparr[i].DisplayFormat))
				retstr += ",dateFormat: 'Y-m-d'";
			else
				retstr += ",dateFormat: '"+temparr[i].DisplayFormat+"'";
		}
		retstr +="},";
	}
	retstr = retstr.replace(/,$/,"");
	retstr += "]";	
	return eval(retstr);
}
//{header: "姓名", dataIndex: 'name', sortable: true}
var creator_pt_getcm = function(arg,editAble,sm){
	var temparr = arg.Fields.Field;
	var retstr = "[";	
	for1 :
	for(var i=0;i<temparr.length;++i){
		var str ="";
		str += "{header: '"+temparr[i].DisplayLabel+"',menuDisabled:true, dataIndex: '"+temparr[i].FieldName.toLowerCase()+"', sortable: true,tooltip: '"+temparr[i].DisplayLabel+"'";
		str += ",renderer:function(value){return \"<div ext:qtitle='"+temparr[i].DisplayLabel+"' ext:qtip='\"+value+\"'>\"+value+\"</div>\";}";
		//列宽，目前列高没意义
		if(!IsSpace(temparr[i].columnWidth1)){
			str +=",width:"+temparr[i].columnWidth1;
		}
		if(!IsSpace(temparr[i].columnHeight1)){
			str +=",height:"+temparr[i].columnHeight1;
		}
		//自定义显示格式解析
		if(!IsSpace(temparr[i].showType)){
			var tempRules = eval(unescape(temparr[i].showType));
			var s ="";
			for2:
			for(var j=0,tlen = tempRules.length;j<tlen;++j){
				//解析编辑格式
				if(typeof(editAble) != 'undefined'&&editAble=='true'){
					var tmpEdtype = tempRules[j].edittype;
					if(typeof(tmpEdtype) == 'undefined'){
						str += ",editor:new Ext.form.TextField({allowBlank: false})";
					}else if(tmpEdtype=="date"){
						tempRules[j].Rule ="true";
						tempRules[j].showtype="'+(val?(val.dateFormat('Y-m-d')):'')+'";
						str += ",editor: new Ext.form.DateField({format: 'Y-m-d',minValue: '2006-01-01'})";
					}else if(tmpEdtype=="select"){
						str += ",editor: new Ext.form.ComboBox({typeAhead: true,triggerAction: 'all',transform:'"+tempRules[j].selectId+"',lazyRender:true,listClass: 'x-combo-list-small'})";
					}
				}
				if(tempRules[j].showtype=="checkbox"){
					retstr += "sm,";
					sm = new Ext.grid.CheckboxSelectionModel({singleSelect:false});
					continue for1;
				}else if(tempRules[j].Rule){
					s += "if("+tempRules[j].Rule.replace(/\$\{(.*?)\}/g,"rowdata.get('$1')")+") ";
					s += "return '"+tempRules[j].showtype.replace(/\$\{(.*?)\}/g,"'+rowdata.get('$1')+'")+"';";
				}
			}
			str += ",renderer: function(val,p,rowdata,rowIndex,i,ds){"+s+"return val;}";
		}else if(typeof(editAble) != 'undefined'&&editAble=='true'){
			str += ",editor:new Ext.form.TextField({allowBlank: false})";
		}
		str += "},";
		retstr += str;
	}
	retstr = retstr.replace(/,$/,"");
	retstr += "]";	
	return eval("("+retstr+")");
}

Ext.data.CreatorMemoryProxy = function(dataset) {
	Ext.data.MemoryProxy.superclass.constructor.call(this);
	this.data = null;
	this.dataset = dataset;
};

Ext.extend(Ext.data.CreatorMemoryProxy, Ext.data.DataProxy, {
	load : function(params, reader, callback, scope, arg) {
		params = params || {};	
		try{
			var datasetobj = document.getElementById(this.dataset);
			var pageNo = 1;
			if(typeof(params.start) !='undefined' )
				pageNo = Math.ceil(params.start/params.limit)+1;
			datasetobj.JumpTo(pageNo,function(restr){
				this.data = formatXmlStr(restr.value,datasetobj);
				var result;
				try {
					result = reader.readRecords(this.data);					
				} catch (e) {
					this.fireEvent("loadexception", this, arg, null, e);
					callback.call(scope, null, arg, false);
					return;
				}
				callback.call(scope, result, arg, true);
			});
		}catch(e){
			alert(e);
		}
	},
	update : function(params, records) {
	}
});

Ext.grid.CheckColumn = function(config){
    Ext.apply(this, config);
    if(!this.id){
        this.id = Ext.id();
    }
    this.renderer = this.renderer.createDelegate(this);
};

Ext.grid.CheckColumn.prototype ={
    init : function(grid){
        this.grid = grid;
        this.grid.on('render', function(){
            var view = this.grid.getView();
            view.mainBody.on('mousedown', this.onMouseDown, this);
        }, this);
    },

    onMouseDown : function(e, t){
        if(t.className && t.className.indexOf('x-grid3-cc-'+this.id) != -1){
            e.stopEvent();
            var index = this.grid.getView().findRowIndex(t);
            var record = this.grid.store.getAt(index);
            record.set(this.dataIndex, !record.data[this.dataIndex]);
        }
    },

    renderer : function(v, p, record){
        p.css += ' x-grid3-check-col-td'; 
        return '<div class="x-grid3-check-col'+(v?'-on':'')+' x-grid3-cc-'+this.id+'">&#160;</div>';
    }
};